Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD43F823B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhHZGIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbhHZGIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:08:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB90C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:08:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso5824529pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=NNtuO05+8Dc6BRsSuMp/HZ2ZgToThCggAJvItaSKgr4=;
        b=UfcKjyWt1UqNEnNoP5+DZEnZy48CAGB30gxlXK76kRWAGeQlgwXqYCj+UZkoChsnQS
         8PZnkIkfMU/5vI7oBHWqwt3xLwzZ1lqOdfrhCUx4vULc0rqUtyWZUoJReiXkHRAj/rFB
         pbrObz6/1zif5tvGh/T4Q81xkOHXwjAiCy0UbjdWF394gHVO0VPKFyHZ7Y4faDFdj6cO
         0ryo8i0Dyb7ON+RVPOHlxAvkkdAuKIPU8JGXm1lODq27JjpcXA5m5RGlxtC1ny5qdhP1
         RYAHgPpTQfE3THkwM5UgRK3xigtNRMPjJlTs4TFYxHk6cMYNMVJyyRcy+v6kki84aEOB
         kuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=NNtuO05+8Dc6BRsSuMp/HZ2ZgToThCggAJvItaSKgr4=;
        b=VxuELthm0sQfFwVjugBgg93mBDJiAj6YS7IW7+3zBEyX6Ly/HvK9Py4jYPl6nG4IVW
         YaU4Zx7mMehK6uc5WnImwaV354j6UJr80VT3BZk1Px2NT1bc6WxxTowWzb+f2EasXD/x
         mUVNo4HbQqiQthh+ZsIVBkWLqBHXbGXkM1pGvwyi5tWmmj89p7aika3GKp9ZjKskdzss
         2UQnLJL62+9begw7K3nvWorIhlfmmA93dTHIH9BuzVV+sKxpdScgsVxLDpA79OPFKWzE
         1IDNTpKRRNKPm0bRKIfgjoCIkh/Id9hzivKqfaVLmtLmvKhAxC+kP8CiqhsHOSU0Z7+k
         aFJw==
X-Gm-Message-State: AOAM532DwhL3aUyEDBqBS1+5Z2UJBJNGNiqjzPKNbqvMSFMDnpykJP1a
        iSUpCzLL6/WOYAcREuuJumhQjg==
X-Google-Smtp-Source: ABdhPJx9ctMBPCljF2Xlz8amzdSmJcEDJ+3zpshuIOv0EA3RuS6bF9bVNd10PkvIt+pqrnzJRB0vCg==
X-Received: by 2002:a17:90a:7e8b:: with SMTP id j11mr2478556pjl.210.1629958081797;
        Wed, 25 Aug 2021 23:08:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j4sm2025639pgi.6.2021.08.25.23.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 23:08:01 -0700 (PDT)
Date:   Wed, 25 Aug 2021 23:08:01 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Aug 2021 23:07:59 PDT (-0700)
Subject:     Re: [PATCH] riscv: use strscpy to replace strlcpy
In-Reply-To: <20210807071427.59613-1-wangborong@cdjrlc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, wangkefeng.wang@huawei.com,
        mick@ics.forth.gr, alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangborong@cdjrlc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangborong@cdjrlc.com
Message-ID: <mhng-ec52f7a2-7fe9-4109-b326-a92af8b8205b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Aug 2021 00:14:27 PDT (-0700), wangborong@cdjrlc.com wrote:
> The strlcpy should not be used because it doesn't limit the source
> length. As linus says, it's a completely useless function if you
> can't implicitly trust the source string - but that is almost always
> why people think they should use it! All in all the BSD function
> will lead some potential bugs.
>
> But the strscpy doesn't require reading memory from the src string
> beyond the specified "count" bytes, and since the return value is
> easier to error-check than strlcpy()'s. In addition, the implementation
> is robust to the string changing out from underneath it, unlike the
> current strlcpy() implementation.
>
> Thus, We prefer using strscpy instead of strlcpy.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 18bd0e4bc36c..2dc62ebc0001 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -255,7 +255,7 @@ static void __init parse_dtb(void)
>
>  	pr_err("No DTB passed to the kernel\n");
>  #ifdef CONFIG_CMDLINE_FORCE
> -	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +	strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>  	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
>  #endif
>  }

Thanks, this is on for-next.
