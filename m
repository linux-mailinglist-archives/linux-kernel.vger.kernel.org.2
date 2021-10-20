Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE35435393
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJTTQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhJTTQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:16:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E70C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:14:02 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id g125so10842272oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aAzwAmQeKzF0WVBVW16AY3oaoGu6FV5pZ/uvPBUYZKQ=;
        b=hXvFYkrjyUwbl1APnm9h6moADVcfjzSEmIMX/DlBOPqKrTfDlkOgZtalqb6g7GMx12
         prWKn65e/yS0LTPXz5wKJfZiMaX1NNXV0b+oubQMPISR8zwH+R/XuN2J3sd73twnlAeq
         +YXpAT4sar3VvcREPvE/EyydYm0ntgoHFkJoDUynq7BDQBWZM2OseNMpKRfB5EEK/rS+
         RgbGycv43i0dr2mjHS40V+EHb2As/DFjQuE1wJI+zZi7aRszpuiDyBgCj5IL/YNpvAsT
         SHlg8NSFSmsuH67awKhxUblGJX1L9fr2p0HdLKeRlK88M68gj9b7s9cGyooYVpirUcfy
         3+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aAzwAmQeKzF0WVBVW16AY3oaoGu6FV5pZ/uvPBUYZKQ=;
        b=B7uu0r2hSVE+JgK+2E3jiOGpYbtttnY1P42rdaL3Hp3rBjgBTsSlMJ7DWTtAIk69Eo
         bKvXzJpxJBe7JnbN9hDNFx9MjEp58ntTAld2RvQ+m99fsRr85NuicJYQq+SC71mFUUQK
         WN3/hRBBnvqrJRMc5t5wIiTjtoXVY8yvx8gKVIueBEqcsRU4lnHUoqvg0hExj54wORaX
         Odvti1HVCU3/Ulb3Nvacg7N4tTf/j+8IHxADTVFJ2yc7XFpmzf9zpxG6bXa33eeDwoxR
         EJQeC7uXEr3abIapel5eFblmOalDHaTIIHM0dAVtrhdJxQp/33xwdXuzs0mLaE42ddxU
         D/EA==
X-Gm-Message-State: AOAM531Ny10CPVavDRIKsgkFgaQM6EbEhEFCO5kOHsbLxEzcnWxLeSql
        WlxUjIke3Xwk8E7xCLQIaJKemozf4iY=
X-Google-Smtp-Source: ABdhPJxiD6AH9NssPmRs6ApEEP4rQoaRRAValP45Mwx0MbquvJRLGHoqEDiIK6gMXxBQcTTBTlRCKA==
X-Received: by 2002:aca:3606:: with SMTP id d6mr1030278oia.35.1634757242152;
        Wed, 20 Oct 2021 12:14:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17sm673768ots.35.2021.10.20.12.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 12:14:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20211020190952.2473153-1-linux@roeck-us.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1f8d0120-d016-0f83-fb93-abe49e40e9b3@roeck-us.net>
Date:   Wed, 20 Oct 2021 12:14:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020190952.2473153-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 12:09 PM, Guenter Roeck wrote:
> nios2:allmodconfig builds fail with
> 

... actual error message goes here. Sorry for the noise.
v2 sent immediately.

Guenter

> This is seen with compile tests since those enable NIOS2_DTB_SOURCE_BOOL,
> which in turn enables NIOS2_DTB_SOURCE. This causes the build error
> because the default value for NIOS2_DTB_SOURCE is an empty string.
> Disable NIOS2_DTB_SOURCE_BOOL for compile tests to avoid the error.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   arch/nios2/platform/Kconfig.platform | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform/Kconfig.platform
> index 9e32fb7f3d4c..e849daff6fd1 100644
> --- a/arch/nios2/platform/Kconfig.platform
> +++ b/arch/nios2/platform/Kconfig.platform
> @@ -37,6 +37,7 @@ config NIOS2_DTB_PHYS_ADDR
>   
>   config NIOS2_DTB_SOURCE_BOOL
>   	bool "Compile and link device tree into kernel image"
> +	depends on !COMPILE_TEST
>   	help
>   	  This allows you to specify a dts (device tree source) file
>   	  which will be compiled and linked into the kernel image.
> 

