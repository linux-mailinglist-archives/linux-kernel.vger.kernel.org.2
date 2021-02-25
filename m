Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619003249E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhBYE6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 23:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhBYE6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:58:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:57:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ba1so2554168plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 20:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+8kI8nz4N5Z48gbO4eFrSdCp9JwpH67g3WghBeNMpbU=;
        b=UCbZ5Mhzz4O5aTkkjWgGwk3FLzXuPh8ycqu8b3WpnxL1gqVcU4sJ9w42+cOkvjAmcf
         REpFYMUV4APQsRd2sy7qqMuumqz8lByV6QhjIcU2drZjBTaISO2YvK3zk0zZq2Vn6MMG
         vRdIDJNTLaO0ZVwLpY4Y5oYQiZaoaoQJTRRFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8kI8nz4N5Z48gbO4eFrSdCp9JwpH67g3WghBeNMpbU=;
        b=VQHXPVCwXsGAGZQr0BpewR5Hoe8sWROMiwK+nI5mhnDFX26n8HgPONIVOnBf5S9w0g
         4rJgF7wZCebgkdEoJda7vQIj6dTniR0hzH4sfeu1wFPBBpcIeNwDc/L9gA/ZGI+/JDaP
         Kv8KSGUpdlu9MmIamOvqy2Et37nR2o9A0i3/R+JaI8VRLJ3aVvqv+M2iuT44s5brfzVG
         ptsvL1CbbhvBuAsiyblCYrUxxHxUFpBlsmKBzwfBcpl0xxTD7WKRqchdR+kkmGm7xIXC
         WTVXs7+KYxKYkfL8gv4uk+8z7qc03nsaSyJofJXHhtCASUS8hdFT7nn9zv9Hq05qe1IV
         Zx4w==
X-Gm-Message-State: AOAM530G3mNL1ROcEqL6BNQmK1os9V1Kxe5b0rIgeS3eNElG7pPer2gB
        UVNj0Fm/4MuMR8I9kod4X8vVyw==
X-Google-Smtp-Source: ABdhPJxN42CgYcoLGskaFUCoPXLZ2lXQ2UUsOjk+rumrN7ykCwdYDaAVvwhw0mcwsn86KftcE8gtww==
X-Received: by 2002:a17:902:edc2:b029:e4:3738:9b23 with SMTP id q2-20020a170902edc2b02900e437389b23mr1512855plk.37.1614229056386;
        Wed, 24 Feb 2021 20:57:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z8sm1756620pjd.0.2021.02.24.20.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 20:57:35 -0800 (PST)
Date:   Wed, 24 Feb 2021 20:57:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Gabriel Somlo <somlo@cmu.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
Message-ID: <202102242050.128D0CD@keescook>
References: <20210211194258.4137998-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211194258.4137998-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:42:58PM -0700, Nathan Chancellor wrote:
> fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> which violates clang's CFI checking because fw_cfg_showrev()'s second
> parameter is 'struct attribute', whereas the ->show() member of 'struct
> kobj_structure' expects the second parameter to be of type 'struct
> kobj_attribute'.
> 
> $ cat /sys/firmware/qemu_fw_cfg/rev
> 3
> 
> $ dmesg | grep "CFI failure"
> [   26.016832] CFI failure (target: fw_cfg_showrev+0x0/0x8):
> 
> Fix this by converting fw_cfg_rev_attr to 'struct kobj_attribute' where
> this would have been caught automatically by the incompatible pointer
> types compiler warning. Update fw_cfg_showrev() accordingly.
> 
> Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1299
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Ah, nice, yes.

Reviewed-by: Kees Cook <keescook@chromium.org>

Michael, are you able to take this? I can snag it if needed.

-Kees

> ---
>  drivers/firmware/qemu_fw_cfg.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 0078260fbabe..172c751a4f6c 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -299,15 +299,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
> +static ssize_t fw_cfg_showrev(struct kobject *k, struct kobj_attribute *a,
> +			      char *buf)
>  {
>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>  }
>  
> -static const struct {
> -	struct attribute attr;
> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
> -} fw_cfg_rev_attr = {
> +static const struct kobj_attribute fw_cfg_rev_attr = {
>  	.attr = { .name = "rev", .mode = S_IRUSR },
>  	.show = fw_cfg_showrev,
>  };
> 
> base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
> -- 
> 2.30.1
> 

-- 
Kees Cook
