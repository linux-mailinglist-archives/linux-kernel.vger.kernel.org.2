Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61B34931F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhCYNda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhCYNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:32:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261ABC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:32:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r20so3147556ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Z5JwBQoNQ9COKdCYdIrHU5ofCQMRHplX6mx8Ono98I=;
        b=C/u5y8awfYzoAsrVl41s87k6kAiweq1En94knsvf1rQRl9ajR3klx9XdOZsvo5kjFo
         YsypYsytnWxZxqlxxYWTwNc0+nn4WkjXHADVpQfZ9WT2yIrnjQ5932PohjZd59X70xep
         qauC0XqD2hzyvlOZVbc7vMRONoDf8p/rE/hDig/10iHQ+Zp5fNfg+d1QLXfRIhYClay6
         Ep8uyeEZTQYrDLukIfu5vDVpNKj/yNKBDaB+TGtsVt3Kvi+h3vBjvVP0PRO6iUM4o1BY
         jhk9/alQjMtoeb0FRhtsTTbxmh4CcyTQiJi5d537T60PiiS5pNh5ssvuBa7oA1wEfbrs
         79EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Z5JwBQoNQ9COKdCYdIrHU5ofCQMRHplX6mx8Ono98I=;
        b=T56GA897akyX5EH+uAERXkgvj8yZz5Qd5IY1qLpCQQaSbjo6Nfk9gkpfK7yRGljB4E
         maFDFhf3kmHmiC/vab+YooUsivKanPwLmBG+X6Ebd0vqNisBZ1hVCrLGKvRtjdyjI5KC
         +Vj2C7rdOjN4wltOidCt4FU+y7RoSLtsYBQI1iN91XxWwUJWK8dKse100EHviiaxlQan
         ntMmSgdg2hJ4ptEZ70QFHADgvuFI18/Mxj+sSrKG1s8ya81wI2CCi1s5j/wfbFJQpsfv
         o5Bj5S8I/XUvwwbYPiGsw5hDMD+5MFIz+SD9jtmQjC5tnXmvpeP5x+USGKeJozWOKquC
         plqQ==
X-Gm-Message-State: AOAM531C6BVZn1Q4OLQtfzW/Q0OfTwypWuPOYXzRMKpaU+q87ApTsbPU
        OAEKLBHCfPFycvfQ7WyKV1L5do0P11kKYND3VJQ=
X-Google-Smtp-Source: ABdhPJwbRrfXUA8B3XGfDDz92+WFZmSVWbz1lsNfXNlH8gWorIxRbo+8UueednWj0pUUASgmmnLwTGE8PYivMCCRPLQ=
X-Received: by 2002:a2e:1612:: with SMTP id w18mr5890405ljd.6.1616679177648;
 Thu, 25 Mar 2021 06:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210325095049.6948-1-liu.xiang@zlingsmart.com> <20210325100605.GL1463@shell.armlinux.org.uk>
In-Reply-To: <20210325100605.GL1463@shell.armlinux.org.uk>
From:   Liu Xiang <liuxiang1999@gmail.com>
Date:   Thu, 25 Mar 2021 21:32:35 +0800
Message-ID: <CAPPcxxSzNvGu3y+3Fpc5FtV-6mOBPWMihmGhHnbq_qAHe3oYTA@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix smp_processor_id() in preemptible warning in harden_branch_predictor()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Liu Xiang <liu.xiang@zlingsmart.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> =E4=BA=8E2021=E5=B9=
=B43=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:06=E5=86=99=
=E9=81=93=EF=BC=9A
>
> On Thu, Mar 25, 2021 at 05:50:49PM +0800, Liu Xiang wrote:
> > When CONFIG_HARDEN_BRANCH_PREDICTOR is selected and user aborts occur,
> > there is a warning:
> >
> > BUG: using smp_processor_id() in preemptible [00000000] code: errnotest=
/577
> > caller is __do_user_fault.constprop.4+0x24/0x88
> > CPU: 1 PID: 577 Comm: errnotest Not tainted 4.14.188-rt87-fmsh-00004-g5=
8055877a #1
> > Hardware name: FMSH PSOC Platform
> > [<8010d6d4>] (unwind_backtrace) from [<8010a228>] (show_stack+0x10/0x14=
)
> > [<8010a228>] (show_stack) from [<80698f44>] (dump_stack+0x7c/0x98)
> > [<80698f44>] (dump_stack) from [<803d17d0>] (check_preemption_disabled+=
0xc4/0xfc)
> > [<803d17d0>] (check_preemption_disabled) from [<80110eb8>] (__do_user_f=
ault.constprop.4+0x24/0x88)
> > [<80110eb8>] (__do_user_fault.constprop.4) from [<801112e4>] (do_page_f=
ault+0x2dc/0x310)
> > [<801112e4>] (do_page_fault) from [<801012a8>] (do_DataAbort+0x38/0xb8)
> > [<801012a8>] (do_DataAbort) from [<8010b03c>] (__dabt_usr+0x3c/0x40)
> > Exception stack(0xb21d1fb0 to 0xb21d1ff8)
> > 1fa0:                                     fffffff4 00000000 00000054 ff=
fffff4
> > 1fc0: 00000000 00000000 7ed81cc8 7ed81ca0 0007a440 00000000 00000000 00=
000000
> > 1fe0: 00000000 7ed81ca0 00010493 0001f330 20030010 ffffffff
>
> This is not the right fix - preemption is supposed to be disabled before
> this function is called. I'm not sure at the present time what the right
> fix is supposed to be because I've forgotten most of the background
> behind why this was placed where it is.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

I have tested with the current mainline kernel, the warning still exists.
[   14.404322] BUG: using smp_processor_id() in preemptible [00000000]
code: errnotest/81
[   14.404795] caller is __do_user_fault.constprop.5+0x54/0x7c
[   14.405163] CPU: 1 PID: 81 Comm: errnotest Not tainted
5.12.0-rc4-ge97a94a30e55-dirty #6
[   14.405616] Hardware name: ARM-Versatile Express
[   14.406475] [<c010af58>] (unwind_backtrace) from [<c01064c4>]
(show_stack+0x10/0x14)
[   14.407018] [<c01064c4>] (show_stack) from [<c0a6a0cc>]
(dump_stack+0x8c/0xa0)
[   14.407398] [<c0a6a0cc>] (dump_stack) from [<c0a6d0a4>]
(check_preemption_disabled+0x114/0x118)
[   14.407906] [<c0a6d0a4>] (check_preemption_disabled) from
[<c010ef68>] (__do_user_fault.constprop.5+0x54/0x7c)
[   14.408367] [<c010ef68>] (__do_user_fault.constprop.5) from
[<c010f274>] (do_page_fault+0x208/0x3bc)
[   14.408907] [<c010f274>] (do_page_fault) from [<c010f588>]
(do_DataAbort+0x3c/0xbc)
[   14.409266] [<c010f588>] (do_DataAbort) from [<c0100e7c>]
(__dabt_usr+0x3c/0x40)
[   14.409721] Exception stack(0xc285ffb0 to 0xc285fff8)
[   14.410099] ffa0:                                     fffffff4
00000000 00000054 fffffff4
[   14.411000] ffc0: 00000000 00000000 bed90d28 bed90d00 0007a440
00000000 00000000 00000000
[   14.411386] ffe0: 00000000 bed90d00 00010493 0001f330 20030010 ffffffff
Segmentation fault
