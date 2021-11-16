Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89C94535CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhKPPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238273AbhKPPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637076518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYQN9I70gjsFE5Naqa2HU/h8w6OlAwkKbYGsjtVq6nA=;
        b=R8p1twqzTE5iLARiqESHX3fIUTIP8adtUDlWe9ztw5DCV1jHty/jmDdNtpIGK6l/lF5nl5
        0yNEphXttKWBU2OgmB33y8TPrhgALM5wOW+rWrmtSYUTlfLOXHprkEfiD4rd/X6yypQV5I
        ZPiiP5GX7o7AgQEPmw4l0Tj/htOuUYE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-_X-VpFSGMd-VWNBt4GeM8w-1; Tue, 16 Nov 2021 10:28:37 -0500
X-MC-Unique: _X-VpFSGMd-VWNBt4GeM8w-1
Received: by mail-wm1-f72.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso1377287wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UYQN9I70gjsFE5Naqa2HU/h8w6OlAwkKbYGsjtVq6nA=;
        b=WdX2JLHpKylsbpTa5FVjrQywsR2Awq9LyI4EDEM92dXkn15EmHIU0Iy/baz0JbPjuz
         pylLRwhSMw3Qu1zuuWLX2fzV84A1tXWT7G3QNs+0Nunb5nR1QVMtIEhUGR/k1eNWVmNb
         Mw/Q5A7pTykb0eZeUOe7Rk23VHLVwNDN7t70EI2xpv6ZNorZth220JpozdXZ8GBtHTTC
         BqR06VJmCC9OgXbm5IsriOOKIHREERBQP3oQTkvXHD4X5Dy6zEqoKDSnsr9BwYlUJ6aH
         itBXE2jKnnko76V+wgDAUp5ao+KZOE15enLVxOSxIV2gLGRZ0i/8FQm3vDsXa/oUyCqX
         UWhA==
X-Gm-Message-State: AOAM531Iap9bdWyQ1pZojbURotxBuBHfL2Avp8rQDRVZNenMSJ6WPuBC
        PzzXX6LYHCoydChz5Jlz1BXVDKXNoh3wriPITu6BJsd3iiDv5U93YstBYknY8ubE09u/ni+wItp
        Ct2oYUEjfJzYFP5WHoufZLozU
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr10551311wrj.338.1637076516087;
        Tue, 16 Nov 2021 07:28:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyF815fmFuY8bG7dsEGyu346D4qU2PxLAXuM2xLKBP7NcVm/OObn1MwERjTAqvhG73N6sbKbg==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr10551281wrj.338.1637076515927;
        Tue, 16 Nov 2021 07:28:35 -0800 (PST)
Received: from [192.168.1.36] (62.red-83-57-168.dynamicip.rima-tde.net. [83.57.168.62])
        by smtp.gmail.com with ESMTPSA id f12sm3586100wmq.0.2021.11.16.07.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 07:28:35 -0800 (PST)
Message-ID: <2ced2fae-2ffd-3a70-f02c-175662baf7bc@redhat.com>
Date:   Tue, 16 Nov 2021 16:28:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fw_cfg: Fix memory leak in fw_cfg_register_file
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, Qiushi Wu <wu000273@umn.edu>
Cc:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20211116114233.29462-1-linmq006@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
In-Reply-To: <20211116114233.29462-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 12:42, Miaoqian Lin wrote:
> When kobject_init_and_add() fails, entry should be freed just like
> when sysfs_create_bin_file() fails.
> 

Fixes: fe3c60684377 ("firmware: Fix a reference count leak.")
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 172c751a4f6c..0f404777f016 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -608,6 +608,7 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
>  				   fw_cfg_sel_ko, "%d", entry->select);
>  	if (err) {
>  		kobject_put(&entry->kobj);
> +		kfree(entry);
>  		return err;
>  	}
>  
> 

