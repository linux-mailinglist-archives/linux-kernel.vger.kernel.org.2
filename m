Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112FE32D66F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhCDPUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:20:53 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:54655 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbhCDPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:20:45 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFbeC-1lYpAJ2IT0-00HAg1 for <linux-kernel@vger.kernel.org>; Thu, 04 Mar
 2021 16:18:13 +0100
Received: by mail-ot1-f47.google.com with SMTP id w3so7824484oti.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:18:13 -0800 (PST)
X-Gm-Message-State: AOAM533rfpIyE07HhDJmHL81PsgxLrFHTUwmvf6AuaBBjUj+32SsBJO1
        Y0srr0D+GAFsbbwC5nu5vl31hFG2d2Qlxsg0bck=
X-Google-Smtp-Source: ABdhPJxsAeVZP55vxQObqQCcGRYx5uyd3bK326QT6JPGejb1DQh9/gqdNMtw502+OlNnt24OanUNCRyoHMe0+ilQ4Ko=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr3828655otq.210.1614871092267;
 Thu, 04 Mar 2021 07:18:12 -0800 (PST)
MIME-Version: 1.0
References: <2daa39fa210d971863a6f9ac7c81849764e7a261.1614862233.git.christophe.leroy@csgroup.eu>
In-Reply-To: <2daa39fa210d971863a6f9ac7c81849764e7a261.1614862233.git.christophe.leroy@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Mar 2021 16:17:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2=qOG1iLhw2fi=r128bRMdfNx4BseXONiS7vrnbVvr6w@mail.gmail.com>
Message-ID: <CAK8P3a2=qOG1iLhw2fi=r128bRMdfNx4BseXONiS7vrnbVvr6w@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/32: remove bogus ppc_select syscall
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        halesh.sadashiv@ap.sony.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Tyyi4PowvsCs+gfapCEelGFxZFWx13/BlVy+pd5z1+eq59gNHDp
 AqhYdcEtILIbhdiQprawl0/Dj1ShDrFP1BRZbzLepPZasCJSEkNB6fl93jXkVn3wMlWKjIn
 FFpRFLBpqjcxQ2/SEfCSkpxPE/W42fMf/cs4/emE/nAo72JDAP6NGvlYrq2lq/ZD4848S+5
 5JUJ/rCIBpBhWlYdpvjEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dogmHKBl3ow=:sEifCO0QUz+R3+D7N9UugJ
 Dz/OxkuBtbcha4v0yTAB+31L+yaIefodzQPANwEXhqTo7QGtyayWMHrB8mJjZAHwkWyOVgyty
 wA1DvNlxf8zaBdvO186ZhInNqexkimDTyyHZoIoecuy8+tyzCZpAHzLcbx1z/MTCmSycI3I08
 18T6VM+ZaCnuly0QKFUQGShNEzUAzV556o6+y5syPVyypKe0q0OjWN1Fm+s/pd9Oi7MarfvEH
 gFI8otYqr1N/JLxFDAGLIuzlG+Tg9q4d208sfybtDLo8crOJcijtrZ2G3zbC3tpznLZ96Q+i1
 oG4FpL7+L1CmUyA5J3WX7RBnWU+JqqdpIiJkgxMhQCj+zMxan3v+8eQ+TgG3bx3Vx+mZ1aA2a
 SkKBao0l+VQxFVUW9ZGaB6fpMWcxwxkSxpW3RiNtFS4IWIKYJ95KKfUgtixZqvQ+FImcrm674
 TnBpFbaJvBevoqUFs8mNIN2PpAAo9fdFcLHjIy9THna1oHFuVRCsT3/MgozCFtms/dLSEJEcj
 hTJtZ6wgxPse+8+Ax+QblvgBjSF5l+vkOTvx4ujyXi1xXG26NsVzEOibnRS23evZw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 1:51 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The ppc_select function was introduced in linux-2.3.48 in order to support
> code confusing the legacy select() calling convention with the standard one.
> Even 24 years ago, all correctly built code should not have done this and
> could have easily been phased out. Nothing that was compiled later should
> actually try to use the old_select interface, and it would have been broken
> already on all ppc64 kernels with the syscall emulation layer.
>
> This patch brings the 32 bit compat ABI and the native 32 bit ABI for
> powerpc into a consistent state, by removing support for both the
> old_select system call number and the handler for it.
>
> The bug report triggering this came from
> Halesh Sadashiiv <halesh.sadashiv@ap.sony.com>, who discovered that the
> 32 bit implementation of ppc_select would in case of a negative number
> of file descriptors incorrectly return -EFAULT instead of -EINVAL.
> There seems to be no way to fix this problem in a way that would
> keep broken pre-1997 binaries running.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Halesh Sadashiiv <halesh.sadashiv@ap.sony.com>
> [chleroy: Rebased and updated the number of years elapsed in the commit message]
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> First version was in 2008, at that time it was rejected, see
> http://patchwork.ozlabs.org/project/linuxppc-dev/patch/200809240839.14902.arnd@arndb.de/

The patch from 2008 did two things:

- it removed the ppc32 specific 'select' syscall at #82
- it fixed the generic '_newselect' syscall at #142

Back then, the decision was to only address the second issue, which
got merged in commit dad2f2fb0fc7 ("powerpc: Fix wrong error code from
ppc32 select syscall").

It is probably ok to remove the old select system call now, but
my changelog text no longer makes sense, as the patch has nothing
to do with the bug that was reported back then.

       Arnd
