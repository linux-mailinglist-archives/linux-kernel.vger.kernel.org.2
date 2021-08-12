Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126863E9DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhHLFXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhHLFXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:23:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F08C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:23:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so8948717pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qatbrqDegqmZ0+XHzQ+4gx0yhVxDkAp+fv5tGls4q3I=;
        b=aimghCwh9vSL4Px6zMdUVf3mo1lXg/6Gd8Vw/3AKWsade5m36h3rThJDbDzsTIQbrV
         NXjzGIJB/YohR2b4TjkNOlnPcvm+wPdfaV5G09FPfhDJ/Os7Tc9co90VBQRNulvXA/va
         DmqKWzOPNY5uhMd/+8EuhISnJKpdPv433h8wzN95n06mxtO+R9QNPJeqMUe+e0aJpTnf
         sK+FSkBwpB5aLmot0IA8RbDWBdEAau2/S0PPUneUn2O2HO2hvAPamZlGWvy6JLy4eS5K
         iq4ARlrI7+5rfK3UJFIv5F3rFiPsoc4o4qUYO3/Y79opEdtoan+6yCb+WHURdelH0hp/
         G15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qatbrqDegqmZ0+XHzQ+4gx0yhVxDkAp+fv5tGls4q3I=;
        b=JDJ5Y1g+Z/bz+yOQnOBpTN0peUI9OAftyef0XEqbAGY6kG6/vbXNzJNNGiI98b8d0o
         ZKS3RdS/Du1Z0CEgYvBec8i7glHg037SPBNgeFRDoiAsX9SSiXJ/3ySzh4iq0fVlBkcC
         hoThO3DQPq3eRtGDQ77hmJO03uHvviKk1QI3eh3BEq6lSzOpJTiCmCX8n7QF4rbFLahK
         qi/owbPRiCKgN9iKIo3ekUIdWsBjiZRHku0mUSLPSfiFFbtRZ1PmGWuP1rMfBAM5ilIX
         KQ6ChNDj7kPjB2nFRuDINj6ZBOdyxxLyDChKhERpP/ff/9pXQwNukCVW5uHLv6Nw0n3Y
         OeSg==
X-Gm-Message-State: AOAM532SaSTqd+20LhFqMKp1gE+yj0GJFU3B7bB8FKm98cDAp1f7Vldt
        kExJ7Bsssxyz2fjya1fcY6lwbA==
X-Google-Smtp-Source: ABdhPJzzE9kdJxFxrdvD8weA+y1+kdPfk94xSZIF/eB3RohGlvu/88yy+uZu2owJ2D9IOE8Rx1ByeA==
X-Received: by 2002:aa7:800e:0:b029:3a9:e527:c13 with SMTP id j14-20020aa7800e0000b02903a9e5270c13mr2417512pfi.42.1628745803836;
        Wed, 11 Aug 2021 22:23:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y9sm1631753pgr.10.2021.08.11.22.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 22:23:23 -0700 (PDT)
Date:   Wed, 11 Aug 2021 22:23:23 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Aug 2021 18:42:22 PDT (-0700)
Subject:     Re: [PATCH] riscv: kexec: do not add '-mno-relax' flag if compiler doesn't support it
In-Reply-To: <20210722021715.127066-1-changbin.du@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        changbin.du@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     changbin.du@gmail.com
Message-ID: <mhng-d9c7d4ea-1842-41c9-90f0-a7324b883689@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 19:17:15 PDT (-0700), changbin.du@gmail.com wrote:
> The RISC-V special option '-mno-relax' which to disable linker relaxations
> is supported by GCC8+. For GCC7 and lower versions do not support this
> option.

I would not trust GCC 7 on RISC-V, that was a long time ago and there's 
been a lot fixed since then.

>
> Fixes: fba8a8674f ("RISC-V: Add kexec support")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  arch/riscv/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index d3081e4d9600..3397ddac1a30 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -11,7 +11,7 @@ endif
>  CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
>
>  ifdef CONFIG_KEXEC
> -AFLAGS_kexec_relocate.o := -mcmodel=medany -mno-relax
> +AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
>  endif
>
>  extra-y += head.o

This is on fixes.

Thanks!
