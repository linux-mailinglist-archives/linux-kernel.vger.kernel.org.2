Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375EC3A3902
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFKAxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhFKAxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:53:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4912C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:51:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso4838774pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=aZNT3kL4iWZvfY4I/7vWnUNWgnDCeU2L8iX660hLjpI=;
        b=txhSEsqEx0yBEULxHzcBLHV8fMe/03mn5SuB58L2XBXArQlbBBfMHP62mLkvCWeVxb
         pLqoMAgr7jrDgF4kmVC0sIPik4BJXO99+fGWNjMnk7R6LIxSSG8oDloUeW2PfTk7O7L8
         6v4nG8+Q84p2vVQYvXe+vFbFlJz9wlZppcFU+mZS0XRvafuKtSkqvexjIpNk/r0mfMIy
         EdKQ6rwQzxLeh/ovnQC/3pmOLognUXL93AktlD9wInPcU3T+4g3rE5GUqOgQPHpXnAYW
         VGubjevJ0MZBD9K6RrnLVyGkU6Y15j9rnChf39Ka/KD8EvgQEecF2rEoBqZrKzNuaoRC
         i4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=aZNT3kL4iWZvfY4I/7vWnUNWgnDCeU2L8iX660hLjpI=;
        b=L59bJvHunHYI6qDp+xr7a8vtq06RoSpBBUwyVw/egvrEHo5Jfh00QSc2FWrZSbUMV5
         h27unrwiYl1fk+AVLq3Kn4J5uwupbf4A/N93UVoNhCP48sgteWJiU9YWmQpSewuDMzom
         +zS5HLILBLzp5/W9DmN0HrPGLQO6XPwowVi4jeju/7EyYa9970F3NeFGgZlRpHC4yaJk
         cUTpaCPy1e5wMgAH57XI+zljnM7d3yD++CgamiEZBXczDxN3moOFvqrStmI6WItnWvFp
         Xc4hnzKYLjQT2W5Ak1MhOhLGO5EOcascghmQq7kaMUOrh5b34MND9n+D1Xs6rUZ2gAfh
         n1Ig==
X-Gm-Message-State: AOAM532P2SoFqRb1KBTvIJBLSXqJiNLyjyxakfXdPd6Mt4ZrtxCm+K/D
        UKZyjhBHT11B2GE8oPR5BeCBI49z3g9vxOx8
X-Google-Smtp-Source: ABdhPJyq9FrCShS23Llbd5PD5b1xuqmIo2d7fvh50y+aXFphhMIQ1G24RqPCN8fivd7Wyc++cTajHg==
X-Received: by 2002:a17:90a:650b:: with SMTP id i11mr1580828pjj.39.1623372697167;
        Thu, 10 Jun 2021 17:51:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t1sm3512162pjs.20.2021.06.10.17.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:51:36 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:51:36 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Jun 2021 16:30:08 PDT (-0700)
Subject:     Re: [PATCH] riscv: xip: support runtime trap patching
In-Reply-To: <CAM4kBBKL0D0cvHaNTt2DobbUROp1eGAfmNkakOqzgakEZDLYbA@mail.gmail.com>
CC:     alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vitaly.wool@konsulko.com
Message-ID: <mhng-3991ff14-95d8-4d36-b2f5-bed51f109380@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021 02:52:40 PDT (-0700), vitaly.wool@konsulko.com wrote:
> Hi Alex,
>
> On Fri, Jun 4, 2021 at 11:35 AM Alex Ghiti <alex@ghiti.fr> wrote:
>>
>> Le 31/05/2021 à 17:17, Alex Ghiti a écrit :
>> > Hi Vitaly,
>> >
>> > Le 31/05/2021 à 10:53, Vitaly Wool a écrit :
>> >> RISCV_ERRATA_ALTERNATIVE patches text at runtime which is currently
>> >> not possible when the kernel is executed from the flash in XIP mode.
>> >> Since runtime patching concerns only traps at the moment, let's just
>> >> have all the traps reside in RAM anyway if RISCV_ERRATA_ALTERNATIVE
>> >> is set. Thus, these functions will be patch-able even when the .text
>> >> section is in flash.
>> >>
>> >
>> > This sounds like a good fix for sifive platforms to work with XIP kernel
>> > in 5.13: did you test that it actually works on HW?
>> >
>> >> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
>> >> ---
>> >>   arch/riscv/kernel/traps.c           | 13 +++++++++----
>> >>   arch/riscv/kernel/vmlinux-xip.lds.S | 15 ++++++++++++++-
>> >>   2 files changed, 23 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> >> index 0721b9798595..7bc88d8aab97 100644
>> >> --- a/arch/riscv/kernel/traps.c
>> >> +++ b/arch/riscv/kernel/traps.c
>> >> @@ -86,8 +86,13 @@ static void do_trap_error(struct pt_regs *regs, int
>> >> signo, int code,
>> >>       }
>> >>   }
>> >> +#if defined (CONFIG_XIP_KERNEL) && defined
>> >> (CONFIG_RISCV_ERRATA_ALTERNATIVE)
>> >> +#define __trap_section        __section(".xip.traps")
>> >> +#else
>> >> +#define __trap_section
>> >> +#endif
>> >
>> > Maybe we could do something more generic. At the moment, only traps are
>> > subject to alternatives but that will likely expand: what about rather
>> > defining a section called __alternative_section?
>>
>> Any thoughts about that?
>
> Oh sorry, I have overlooked this. I do agree this is the way to go
> long term, I just wanted to do a reasonably good quick fix since the
> default SiFive configuration won't even build with CONFIG_XIP enabled.
> So I would probably just suggest to take the existing solution and
> then think over the details (e. g. should we just use one "alternative
> section" for both the functions and the table or have separate ones?)
> for the generic solution.

I've taken this on fixes.  It's fixing a bug and should be pretty safe, 
since it only has any effect on XIP kernels.
