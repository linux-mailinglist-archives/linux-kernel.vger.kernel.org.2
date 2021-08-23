Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC873F440D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 06:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhHWECA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 00:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhHWEB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 00:01:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB5C061575;
        Sun, 22 Aug 2021 21:01:17 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d9so12752948qty.12;
        Sun, 22 Aug 2021 21:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aRgamPKGb4YrEkVwlKVeiTkelYnJ/WUCUxASVTfMczY=;
        b=WAEAJArmhfElY+V1GA3EbQLLmeW3xGij0Gr7OkgaVxIvoIeenqT4qy2ql7qzg91GDA
         UQYmpYYvWku2Wde9wHp2iWMUFHKgfVW0iDI2P6siCxxhvQ/k+PKjrp5RU4FOol2rq7Yg
         ed55tzV+cojz++ugPijAM/qJgYlK24fLI77OQpdLqxwgpLoQD9v0MCr2lsvmbZy9IlCs
         qR+VHXGZQeLVmiKmnZzgUyvyIrjONqDBwEx0dYdMxFLSJMAVdLrF6XD6SpHGYfACYq81
         yMb5Zl6bsMPC+dbOvunV2xzj7SU2Ermv4dxmN8OtXZT1o3CBoifn9dPwPFYwuY48SFZi
         s71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aRgamPKGb4YrEkVwlKVeiTkelYnJ/WUCUxASVTfMczY=;
        b=FHa9wqv8fPKbtdFOh4DuVQTrHJ5sw9bogNN9TTotVJuPN9I/Ng2YFgMh6Ha0RagtNu
         SBrVWTCLcdsp6koSjpfYrpjgfE7OxAFiQkyXCFIzRl+bgU6Yc9NklL8fn3JO7xOJf3iV
         0p3mzKqOgneZfR+H2HZUB7A5Kk3VvJFvntFnF/vgD8DAVjzvjTlsIjZQ1z3bRdcv0fZr
         AytzNKqxYesDa9fLf8WBiSsy53QrtVlX0wKryh3kV2YZ7FPr4H0UhDYldhZpghOnphm0
         P/gEAYD1OtMLCFohIH6s7KW6s+YB2nUt9nipNZrA0iWUYZYh44md7TQxCknzeR/lMNLi
         vI+w==
X-Gm-Message-State: AOAM532EuVhFMUvfqTnvW2SgkWUp2tAEvA0PAKD+iewzOziFxwbEP2fG
        fxcdpZdVYWEAUXFJ5wLdiFU=
X-Google-Smtp-Source: ABdhPJxfVF9gp7FgIBNpZRCNtTxge23zeA634PIZbfrSAQu15T/A8m+VJbARSW1rEpMXWxu+q71fow==
X-Received: by 2002:ac8:534c:: with SMTP id d12mr16340333qto.221.1629691276705;
        Sun, 22 Aug 2021 21:01:16 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id t26sm6842572qkm.0.2021.08.22.21.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 21:01:16 -0700 (PDT)
Subject: Re: [PATCH] of: Don't allow __of_attached_node_sysfs() without
 CONFIG_SYSFS
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, kernel-team@android.com
References: <20210820144722.169226-1-maz@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a67743f9-869b-28df-d714-db15da4ebe06@gmail.com>
Date:   Sun, 22 Aug 2021 23:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820144722.169226-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 8/20/21 9:47 AM, Marc Zyngier wrote:
> Trying to boot without SYSFS, but with OF_DYNAMIC quickly
> results in a crash:
> 
> [    0.088460] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> [...]
> [    0.103927] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3 #4179
> [    0.105810] Hardware name: linux,dummy-virt (DT)
> [    0.107147] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> [    0.108876] pc : kernfs_find_and_get_ns+0x3c/0x7c
> [    0.110244] lr : kernfs_find_and_get_ns+0x3c/0x7c
> [...]
> [    0.134087] Call trace:
> [    0.134800]  kernfs_find_and_get_ns+0x3c/0x7c
> [    0.136054]  safe_name+0x4c/0xd0
> [    0.136994]  __of_attach_node_sysfs+0xf8/0x124
> [    0.138287]  of_core_init+0x90/0xfc
> [    0.139296]  driver_init+0x30/0x4c
> [    0.140283]  kernel_init_freeable+0x160/0x1b8
> [    0.141543]  kernel_init+0x30/0x140
> [    0.142561]  ret_from_fork+0x10/0x18
> 
> While not having sysfs isn't a very common option these days,
> it is still expected that such configuration would work.
> 
> Paper over it by bailing out from __of_attach_node_sysfs() if
> CONFIG_SYSFS isn't enabled.

CONFIG_SYSFS should be automatically selected when CONFIG_OF_DYNAMIC
is enabled, and it should not be possible to disable CONFIG_SYSFS
in this case.

Can you send your .config?
What ARCH did you build the kernel with?

Thanks,

Frank


> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/kobj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
> index a32e60b024b8..6675b5e56960 100644
> --- a/drivers/of/kobj.c
> +++ b/drivers/of/kobj.c
> @@ -119,7 +119,7 @@ int __of_attach_node_sysfs(struct device_node *np)
>  	struct property *pp;
>  	int rc;
>  
> -	if (!of_kset)
> +	if (!IS_ENABLED(CONFIG_SYSFS) || !of_kset)
>  		return 0;
>  
>  	np->kobj.kset = of_kset;
> 

