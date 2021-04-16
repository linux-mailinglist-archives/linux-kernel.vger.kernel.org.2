Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FEB361F44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbhDPMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:02:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:36583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhDPMCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618574528;
        bh=QP6zpvpiOBFTWjRWyUOTqKOfudm/QdBgNsC0x5d1gCc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ahAoaxj1aNdqkQWn1fbThMmBcTvNABN9BHeOXWOg20KpceytAZxs4EcPGhAgZoclo
         RhbUc7+q2laWUPS+zzN8aFKoZCGEF35LyaFh12lDweb5lhQxKZrVfZ0/imeFfat5Ld
         0b6S2HQDGBJGG56hHd+lKkqP36tup/c9WUwhnPKI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1ljVgC1nH2-00yeSM; Fri, 16
 Apr 2021 14:02:08 +0200
Message-ID: <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
Subject: [patch] x86/crash: fix crash_setup_memmap_entries() out-of-bounds
 access
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DaveYoung <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 16 Apr 2021 14:02:07 +0200
In-Reply-To: <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
         <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
         <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
         <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iwXci5EKGJCJtgOxAHTN+ZCcPnvvbKkNgfxSiWpZObzDaRzWl6B
 k+B4aPtuXJOOTEkyC18B4DtnGdP34+RcvoOvUWPNsRIwoSsfeu2enruZtSIW8OIxyRKcW+r
 TN3Wrv1FeN+8/zdA5jTxTTfmL+5RZtl2MY0FKSNE3OaSA3SPVQ3Wkq1we/u0K9m+DMYsJD5
 FwUqUydgGkWVl+x3mbPrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7D78gtA7+Ak=:Go2v7MRNt8f3Ktc8CDYIfd
 cZsZOvyzRYU/urIt1TX+jEOHj+GJtQvjmvM7ojBqMRpZJlcqeJpwab6YOgcAIKVf6k324HgnN
 yBegOePDoA+UJfsH7m9LtWI5cFv9ML/8q83XnQURT7iUw3ePR6R845bLW3csXaOWaZBjOWvsR
 ehkCX5RXPq72r1hMFRmAzKZE6x4joURRF43IONICCVKoc7VyjFf3zDjOFmpsN9mP9o11bCTCz
 beAuozDUt++as+afu3GhiLk6ZSe5zivOSISmO909PqOBUXQxmGEJObg9t2zvh9a6P+BIA8i1w
 hZPIZ5LQMWWxQ43V2lFqxvnXRKZ7Pk5MXY3EoUOrrcYJXLA3t6bUE/6FbDtYajTtSh5J4saf1
 09vPzrvaRniY9+GK8owS3MnQQ5CYs1CTanh5m/M1VLNkbA6eKI1WrKCuC7Gf+pns1hqVWE/NE
 etYCiXxB4GNJSR1LpPoqF8M9NFe+WlG6EBNBNA4a022lONxpp7NkThj2fK1M6vYtQsrFRufqk
 rqELAdQzrjJOmbjDVFV61XXR1SxsShadqEYQaF9tvzZrvYhrbmvstnvKvt/HfkKB4I3w4nKLC
 TDBgxlC0h0NxukzkY5YDypqDwUzS/hYs79ygSz21p7sX3nb8vggeLOmzM9xYq14eyb2M4Tybl
 z+7ij1qkHZ+9J/HBCGYofqA2z9kFBr4n8Og+cKR8WnlKzvtDhJC9mTa0aekmx70SnXPfPMO6c
 a6DXbkICRgfJfXsoROuxBmM7GoSTgffbqUqHs+rhrwmFqJB887HRtcsquzWtMp6sFf1Ee8cz7
 HrrXGLdvhZpNrrqUP7vXmAJHsIWMfKHmLoXpMp0XjFRuOeJRNsKwsmHQI1PEVjpCxxSIqs5Ma
 Odu/PYjJLZnet4He13A/zMmCY5Qa2+P5bzdSemKm+1ryjBndKcFSIA8YUHEamCFSeNxVjWQgt
 +mMkWQKgMEQQxMTFasnmUh6xKlwO7QgKhoPHppr2p/KgOY0RdTHZ50MVHGItx40uqwpbr9nL5
 RgHu0pf+k4WqMRYh8fZAGITL9ChR72Ca7uG8FS4SiUL6NSIu7qbKjJgcN9MD93wyCY7/gLvU6
 FH790iUbDHgNx2QKkdD9QZCP2QddJPMXHA4fr1nfNql9Cc9zQBGVSxyfZ6B/5PXMb3R2m9hJE
 2DOJ87Ca3U7AZ2c7jZ5l8QK8+RzU2kpiJAbIyRUM9DwN2rqZ87wAJXBXoLsU6adie3SjE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[   15.428011] BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap_ent=
ries+0x17e/0x3a0
[   15.428018] Write of size 8 at addr ffffc90000426008 by task kexec/1187

(gdb) list *crash_setup_memmap_entries+0x17e
0xffffffff8107cafe is in crash_setup_memmap_entries (arch/x86/kernel/crash=
.c:322).
317                                      unsigned long long mend)
318     {
319             unsigned long start, end;
320
321             cmem->ranges[0].start =3D mstart;
322             cmem->ranges[0].end =3D mend;
323             cmem->nr_ranges =3D 1;
324
325             /* Exclude elf header region */
326             start =3D image->arch.elf_load_addr;
(gdb)

Append missing struct crash_mem_range to cmem.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 arch/x86/kernel/crash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

=2D-- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -337,7 +337,7 @@ int crash_setup_memmap_entries(struct ki
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;

-	cmem =3D vzalloc(sizeof(struct crash_mem));
+	cmem =3D vzalloc(struct_size(cmem, ranges, 1));
 	if (!cmem)
 		return -ENOMEM;


