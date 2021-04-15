Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F61B361186
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhDOR4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:56:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:32865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233052AbhDOR4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618509381;
        bh=BnrD0Vrfm6zB/PRxfxOhmiyYOtXxuJR51E35ZRv9rlk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=AE7iUyET3gUERNALYHSxuoWpdAWgYyc+wz2ru2dvlURPm9y5cH3a+JiVfXKxhuVg7
         UDOWAlJ3hBy9hM4uF83kCtUkBLdPszt88pMzGThQnkNcCFTR8X1XYThgX22236cJMN
         b8MTrbp1RtVrzlu8v8pnI1uiq3jULfvy16W4jtX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.95]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1m6z0Z2aKg-00Zwm8; Thu, 15
 Apr 2021 19:56:21 +0200
Message-ID: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
Subject: x86/crash: fix crash_setup_memmap_entries() out-of-bounds access
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>
Date:   Thu, 15 Apr 2021 19:56:21 +0200
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fgSPECuIbyNBuGkYP4usFyde34TFMQpX+fIxwq0dFjzyvJZjASr
 pDeofe7eYRted9Puw0WllS//MXYddwQ4U6WAJTLKkO+Exvi8S923aJprI+c8c92RswUNH8V
 lU+deVHg8w2n5nWtzT20p5L1mcTvdyHStYsY9aExnfV+DrHFCdpxDzAPiGvZDeCycUUEgHz
 fxMYo41Nl8//K6xSxyS6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H3xOIUiYE/Y=:BIaS7JdP/X5uVA7rHC6XFI
 vMgZ9y2lhi2KDiUnU+L8dFnJhOymvcLq6BhoIm/gpt9Ei9vuISLNHzhZHUpIKcMV/o29C6Wpf
 LluD25Hct+11q3Z/5gekeIz/13mUefui1eHm7zVIn4jBpP0p1V0WOqtalWdQQe4LqCm5n2ZiZ
 Pd5BdDbSNO88551FZa3HaingwYEIrqgW6iENRxwRpBnIOzQpHOu8076XTOrdSgXk5yA/+awhc
 HTVflstvaxs9t/AxyIZoVtW6BbpGWlJrAbX4ElDwM8DE0A5GnviFvSj5/fFbXdowIJ2njsS3x
 dYZDcEPnTf8UfDE2KBAlTkTGgoNQzzdl31gau0TARWPLttNa7BdL8xQg6Nh1tdHFPawpj5sV2
 btGMwZPlj7m7HbQIgwZisqsCDT4t8oQo4Fgnjv0/SqDreN/sQStyOHiFXN5diP4PPXpSGEeTo
 trQGjWEGMqzihZZKR4kqOYrpL+IdjojaS9DFsco1BXTknzS2GxGyrlIFzN01I7MEKXlZx2AE/
 JwKE7mW69ntGIyUy+/0bVPIxSV7w/Kcq+w5nnV0S7GvCti1pzF/D3f1pkwux8G941YiHyDpmE
 N3qvTRQnkpOcMLygRCK4pN6Zjvj6SZE5j6i1QIuBt2R3VQYT6pLDkD/jiHvEMV6Ym2MB49m+v
 U3f30qlniXQL61zlYIiPfVgdXq1SGvSfWb3iFrYc+TW7oUYzBVGWmLOWO5daoq4kkHWIpwTm1
 z3DpNB6N958j4r9Piv9+uZOEW8PDOpWjtlzTfTz1hvRh3oigSoY9GiLYJe5WXuJdHFsjx9IHe
 T0O2RJpxvsaIAaw9dVEs+pPOHnLcQCsXqF0uvNTLfXOA8wLibotymTVt92eSDPnlTds+qOD5E
 Yss1YnV9qSPP9QZvQ98PfHBgbeqs+4bAT2tiVxmitjMwqmPzf1HLR8dY1NazUQGInOCnU6JxG
 0tW5mcwTZ3RsZ+pNwVuoFKXOiq0fUGSkqP53cXlupoN2FJzcu1ConTRF2+AjWu2hE62yOGhYu
 kn2VDZIEln0LNzAk5Cj6pVq5eEjlx8gSjRnD7kMy+P50BCqgmN9KnRZni2lY08JZIuXjjWpLA
 +f4NiV3VgqmTqBQkseXTSy7AIgFf4DWvwXCStJuqvd5VwUxH9iSvQwp6+ipjGS4QmB2kmuxX/
 McTsTEi0LdEFxWwpHgEUgq6JOkmjd7DOAuedf6FZBI3ATOBQVwvPinJc/Kgdpa0DboyCk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/crash: fix crash_setup_memmap_entries() KASAN vmalloc-out-of-bounds gr=
ipe

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

We're excluding two ranges, allocate the scratch space we need to do that.

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
+	cmem =3D vzalloc(sizeof(struct crash_mem)+(2*sizeof(struct crash_mem_ran=
ge)));
 	if (!cmem)
 		return -ENOMEM;


