Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7FF30540F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317722AbhA0Ark (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392251AbhAZR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:58:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A86BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:57:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cq1so2441014pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AbOOlV0NPlzblrKhqFQe+Dypka8cKysT0ejfM88w3ao=;
        b=jQIveH7L0IO57xm5gRgHbD0nKsNClyLuVaUi8mTRETtOLw/AeSFkPPO99E3e7cgmCh
         cpyOs2zHAD165WDuyG1s4SkkdtLEdlYMsWgnqxdWiIY495qf/rHnxUojpU3rvEqnF9PQ
         /eIC8ue8VaEb2+3mi+JE1qkk+3b6vtiL/dwITrJR92lgAs+gQ7vyfd2xOOxbSo8vg3+N
         z0KnVbR/Y1hdcv5XsH9nYIuidBQXku4S/ZGV1mWIUgyv/dcrFPjC1Ukq13uIlWLLJY+L
         gyB92fY3H+j6qipaXMlsEqLM6OwSdLPNH3wQP16ynibogpysZK1PfOOHyNbyfwHtUKAG
         RImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AbOOlV0NPlzblrKhqFQe+Dypka8cKysT0ejfM88w3ao=;
        b=d8cFU5suXzj3kd5X51JvVEXpfWQ/mqtUDVswe4Ep9j+3G91F9SaoerHLXf61AsHWm0
         ualQ57yEyB05vvpNefOIfqeZQIuHR4Q/6H7rGygpl0o/h4Vwdik8ViwTOEIILujTV9nM
         zQ3ocjKeO02rbguTPtHNedNYSELCuox0+QWG8cr3vxerH5mJLeRnyT3ijjVsrQtjfRja
         wgBJ8s6UyxqTe/pUUlC3VjUWslMqwjLObwhjW8N1a0ugLqMIZ+XTT+0LUSj/kyHweD0k
         sbDflT7jEpbjIDeZsFNE8GYg1E8tlffRd0rRwr8p5iY7gFYhWQsQAxgoi+EZ7MSuv+BR
         rDrA==
X-Gm-Message-State: AOAM533wY9B1tIWKOrZTs03y4aDo1sFA1xygHpCo7iI/BCJZ15q3ggDa
        +fIhK58+Jy8VWTjl3vptwzU=
X-Google-Smtp-Source: ABdhPJzPrFFGAjqSb+QodVgDfyxUjeKXARZkLWU12DDA5xfyGSa/nzGwmo1FzQkyq9YXFcsY3nbzwg==
X-Received: by 2002:a17:90a:7143:: with SMTP id g3mr1029687pjs.196.1611683863619;
        Tue, 26 Jan 2021 09:57:43 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v21sm2077269pfn.80.2021.01.26.09.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:57:42 -0800 (PST)
Subject: Re: [GIT PULL 2/4] bcm2835-defconfig-next-2021-01-25
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210125210131.14969-1-nsaenzjulienne@suse.de>
 <20210125210131.14969-2-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <91cf95ee-def7-a58a-56ed-591545068ff6@gmail.com>
Date:   Tue, 26 Jan 2021 09:57:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125210131.14969-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2021 1:01 PM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-defconfig-next-2021-01-25
> 
> for you to fetch changes up to 5462a35ce3e4748e079ee325a1e9bb436f4950b3:
> 
>   ARM: multi_v7_defconfig: Enable nvmem's rmem driver (2021-01-25 21:57:33 +0100)
> 
> ----------------------------------------------------------------
> Enable NVMEM_RMEM as module to expose RPi4's bootloader configuration to
> userspace
> 
> ----------------------------------------------------------------

Merged into defconfig/next, thanks Nicolas!
-- 
Florian
