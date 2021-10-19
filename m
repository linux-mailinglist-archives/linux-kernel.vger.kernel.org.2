Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756C0433832
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhJSOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:18:39 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:33190 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhJSOSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:18:38 -0400
Date:   Tue, 19 Oct 2021 10:16:24 -0400
From:   Rich Felker <dalias@libc.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     musl@lists.openwall.com, Takashi Iwai <tiwai@suse.de>,
        Michael Forney <mforney@mforney.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
Message-ID: <20211019141622.GN7074@brightrain.aerifal.cx>
References: <s5h5yu79aab.wl-tiwai@suse.de>
 <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <s5hv9277oux.wl-tiwai@suse.de>
 <20211008120736.GF7074@brightrain.aerifal.cx>
 <s5hsfx95n99.wl-tiwai@suse.de>
 <20211018144259.GK7074@brightrain.aerifal.cx>
 <s5hlf2q4byc.wl-tiwai@suse.de>
 <20211018150824.GL7074@brightrain.aerifal.cx>
 <CAK8P3a1RAk5WRtMjqV6QZ1eHtFu_sxhSBJn0Uv-MhRA5WGiJqQ@mail.gmail.com>
 <20211018204203.GM7074@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20211018204203.GM7074@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 18, 2021 at 04:42:04PM -0400, Rich Felker wrote:
> On Mon, Oct 18, 2021 at 05:26:35PM +0200, Arnd Bergmann wrote:
> > On Mon, Oct 18, 2021 at 5:08 PM Rich Felker <dalias@libc.org> wrote:
> > > On Mon, Oct 18, 2021 at 04:58:03PM +0200, Takashi Iwai wrote:
> > > > On Mon, 18 Oct 2021 16:43:00 +0200, Rich Felker wrote:
> > >
> > > No, I don't think so. The musl translator is to translate between the
> > > time64 ioctl structures and the old time32 ones for the sake of
> > > executing on an old kernel. Up til now, it has been broken comparably
> > > to how 32-bit binaries running in compat mode on a 64-bit kernel were
> > > broken: the code in musl translated the time64 structure to (and back
> > > from) the time32 one assuming the intended padding. But the
> > > application was using the actual kernel uapi struct where the padding
> > > was (and still is) illogical. Thus, nothing was built with the wrong
> > > ABI; it's only the musl-internal translation logic that was wrong (and
> > > only pre-time64 kernels are affected).
> > >
> > > The attached patch should fix it, I think.
> > >
> > > + int adj = BYTE_ORDER==BIG_ENDIAN ? 4 : 0;
> > > + if (dir==W) {
> > > +     memcpy(old+68, new+72+adj, 4);
> > > +     memcpy(old+72, new+72+4+2*adj, 4);
> > 
> > I think that should be "new+72+4+3*adj": the "2*adj" would
> > be what the code does already for the originally intended
> > format.
> 
> Well for little endian either would work (because adj is 0 :) but yes
> there are 3 such paddings before the second member on big endian, so
> it should be 3.

How about this? It avoids open coding the logic and handles it as 2
4-byte substructures with endian-specific offsets.

Rich

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="snd_pcm_mmap_control_v2.diff"

diff --git a/src/misc/ioctl.c b/src/misc/ioctl.c
index 49282811..35804f02 100644
--- a/src/misc/ioctl.c
+++ b/src/misc/ioctl.c
@@ -6,6 +6,7 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <string.h>
+#include <endian.h>
 #include "syscall.h"
 
 #define alignof(t) offsetof(struct { char c; t x; }, x)
@@ -53,7 +54,7 @@ static const struct ioctl_compat_map compat_map[] = {
 	{ _IOWR('A', 0x23, char[136]), _IOWR('A', 0x23, char[132]), 0, WR, 1, 0 },
 	{ 0, 0, 4, WR, 1, 0 }, /* snd_pcm_sync_ptr (flags only) */
 	{ 0, 0, 32, WR, 1, OFFS(8,12,16,24,28) }, /* snd_pcm_mmap_status */
-	{ 0, 0, 8, WR, 1, OFFS(0,4) }, /* snd_pcm_mmap_control */
+	{ 0, 0, 4, WR, 1, 0 }, /* snd_pcm_mmap_control (each member) */
 
 	/* VIDIOC_QUERYBUF, VIDIOC_QBUF, VIDIOC_DQBUF, VIDIOC_PREPARE_BUF */
 	{ _IOWR('V',  9, new_misaligned(68)), _IOWR('V',  9, char[68]), 68, WR, 1, OFFS(20, 24) },
@@ -90,7 +91,11 @@ static void convert_ioctl_struct(const struct ioctl_compat_map *map, char *old,
 		 * if another exception appears this needs changing. */
 		convert_ioctl_struct(map+1, old, new, dir);
 		convert_ioctl_struct(map+2, old+4, new+8, dir);
-		convert_ioctl_struct(map+3, old+68, new+72, dir);
+		/* snd_pcm_mmap_control, special-cased due to kernel
+		 * type definition having been botched. */
+		int adj = BYTE_ORDER==BIG_ENDIAN ? 4 : 0;
+		convert_ioctl_struct(map+3, old+68, new+72+adj, dir);
+		convert_ioctl_struct(map+3, old+72, new+76+3*adj, dir);
 		return;
 	}
 	for (int i=0; i < map->noffs; i++) {

--0ntfKIWw70PvrIHh--
