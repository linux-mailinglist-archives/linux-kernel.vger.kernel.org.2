Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3B339002
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCLO2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhCLO1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:27:52 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCEAC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:27:52 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w11so142734iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hbhr+73hQOL9pcBSx9+oejZ49xpIefhn0N9RrQNm01Q=;
        b=tVOq0uFO0TEqN8EWOLnkTn/qG6oqWtvTF0lTdN/DRM0j1q8IPvKP0jwvAC9OQuj8C6
         S/5KpKFkjT2Y7c+dpfIUaBcqAxegIUpdUuZjrViFDUSrQVUBh1gcQ54WLl0ymJXX1BmB
         bIs7i7FV7Jz9d5GTXt0cLg9dqWU2EPKxzIhXvEMo1Dq5jRqEJTKxN3KHJMKpM3tQyix/
         ZsLE3g/pDIS+/bnA91RuUiqV3Soa+mLiPo09ge8Wj1wjH3e2WJYPl4pQTLyXz0nvz37y
         K6mARBQRSRuJwVijM8Pbmoirql4EejIYH+XDdXe5VFiUcc/oVMD3lOYw6kFhk/GLWdkI
         tCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hbhr+73hQOL9pcBSx9+oejZ49xpIefhn0N9RrQNm01Q=;
        b=Ekksuw4nu6i//YgyZW9qZm9V71y1kXvKkBw9KUAs+TrIemQ3d8Ian2kRZY3STdq6Ge
         bQBdMzq39XcSZjy9rSKF4DykO4v2eQG190fpS9B/ci7ux5sMmm93b7fbJTIibYxzNnrH
         ATWo/99M85EpWbUSMwFWmRTMFG0g3TYT+/xSBlnS1uikTqdEzlyNSZfl527jJBSKg0iR
         2kC37ok3apQ7VK56OceEpiZPsYWWK6KZF4dpbkabmAaBYn3mE0FHq3Ptcc3w7nA6rKQB
         b7WeDhX5O0BW995BANIZ/aIBw8o77A1E5gy8bGIIUzTTekKkqM93rujmXmORMVoSDTai
         DlhA==
X-Gm-Message-State: AOAM5322cgiJlp8NQs1ATyJsAnw7ofat1qoWjvG7gBrXZVSQFbo+Fhw3
        tJr6XdwTm2a28x8zaeqx5kFubg==
X-Google-Smtp-Source: ABdhPJzm3OT4c8cY5tRHNfEBctrS7/hcD6VAfRxSrQ+NU4In0TgrszhbJi473fTZvstUBkwp3bGmBA==
X-Received: by 2002:a02:817:: with SMTP id 23mr8478793jac.23.1615559272119;
        Fri, 12 Mar 2021 06:27:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a5sm2997400ilk.14.2021.03.12.06.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 06:27:51 -0800 (PST)
Subject: Re: [PATCH v1] ata: ahci: Disable SXS for Hisilicon Kunpeng920
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org, john.garry@huawei.com,
        yangxingui@huawei.com
References: <1615544676-61926-1-git-send-email-luojiaxing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1ef5207-96a4-e7f1-68ac-f95ab0b0f5d2@kernel.dk>
Date:   Fri, 12 Mar 2021 07:27:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1615544676-61926-1-git-send-email-luojiaxing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 3:24 AM, Luo Jiaxing wrote:
> From: Xingui Yang <yangxingui@huawei.com>
> 
> On Hisilicon Kunpeng920, ESP is set to 1 by default for all ports of
> SATA controller. In some scenarios, some ports are not external SATA ports,
> and it cause disks connected to these ports to be identified as removable
> disks. So disable the SXS capability on the software side to prevent users
> from mistakenly considering non-removable disks as removable disks and
> performing related operations.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/ahci.c    | 5 +++++
>  drivers/ata/ahci.h    | 1 +
>  drivers/ata/libahci.c | 5 +++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 00ba8e5..33192a8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1772,6 +1772,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
>  
>  #ifdef CONFIG_ARM64
> +	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
> +	    pdev->device == 0xa235 &&
> +	    pdev->revision < 0x30)
> +		hpriv->flags |= AHCI_HFLAG_NO_SXS;

Is this controller arm exclusive?

-- 
Jens Axboe

