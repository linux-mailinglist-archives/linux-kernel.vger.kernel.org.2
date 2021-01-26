Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82186305477
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314962AbhA0Akn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392290AbhAZR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:58:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585BAC061793
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:57:29 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z21so11934457pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RZ+amtv2rM4ZG3JeujxWIMMt0IB2MFDfx6TgXbk6O20=;
        b=m6KAaxaAQJn9v59ckWKN4kc7c1IstQnReQmmSZyl8+uIbQpTS3C+bGz5XxDdTSXwif
         fF37YnfLoyhWFPwee5Ejtuc6nI8Uq1qHcLJZRvYG8NwvFDSAPKdF+x6iZ2inawsVxV/j
         5rGlsFSVUcrrmSOoWFqJMxVMa9XzVE7E1RbqVC9Ch/3TXlXJQCTPO+EKOXzEjeMlqpLO
         exKqeoPhfT9FaolUHTlIQUIFsxSahJ8vS3ViBpx75HxbzBEOWiG7S9xHmU1fFmK0nA0c
         EoeU3iyom4zlpPK+9ehiCbI+Ld7ISgv4BznWVknUNsFDojGwrMfTxq84Onct/pNLOf4L
         AYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RZ+amtv2rM4ZG3JeujxWIMMt0IB2MFDfx6TgXbk6O20=;
        b=QO1rXUX6t5TdRHgbLqA8D8LzpGbVOuYwQ17BdpKZSSR8tLyTUST+rQ4n3Wzm8aXKPN
         LZ09kbGn8impHuXrapS0JnPkWELv6rZhXAhM4oM54965rHJoxjpL/G79ewZJFPVbVV4l
         Sw1gmaDV9naR4taFBkwjgv04w5JYL4dznszqlNKQGL8wdbrtmoXOCKIaF95T3NTJxCvm
         jlc8P8T7cCWUqzLRTRed1n7hmX446AlwcagoN/ToLWz3MKZ4kBSC6AyjuWLUgxxUMU7E
         HuYyFw7GymyLPpQTdjV8pStrh37FAIpV8WUHQ//jCZ7oyPC1t9TCk6/OE2D/I5N3VHiD
         8YWg==
X-Gm-Message-State: AOAM531b2BidQnSlp/5KNhq+iMwPk/UnGBW0DB/odyFOrRkSNcIEBhBf
        tXeIwDNWZXSWaRHUQRPx4cg=
X-Google-Smtp-Source: ABdhPJxxCnK3D5Nk4R4l1fh29klj8JoV0vsOFA/nPmJscmhWtRzmqYNidYzD/qY5cMvglAzMfrL48A==
X-Received: by 2002:a65:5882:: with SMTP id d2mr6723960pgu.323.1611683848774;
        Tue, 26 Jan 2021 09:57:28 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o14sm20729761pgr.44.2021.01.26.09.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:57:27 -0800 (PST)
Subject: Re: [GIT PULL 1/4] bcm2835-dt-next-2021-01-25
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210125210131.14969-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fecf94a8-11c9-17a3-c2d4-26336f25eed8@gmail.com>
Date:   Tue, 26 Jan 2021 09:57:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125210131.14969-1-nsaenzjulienne@suse.de>
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
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-01-25
> 
> for you to fetch changes up to 5878b8087904a5827c3551698be83da1ccf84e11:
> 
>   ARM: dts: bcm2711: Add the BSC interrupt controller (2021-01-25 21:49:41 +0100)
> 
> ----------------------------------------------------------------
> Add DSI compatible string for Raspberry Pi 4
> 
> Enable BSC controller used for HDMI DCC
> 
> Add reserved memory node to expose Raspberry Pi 4's bootloader configuration
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Nicolas!
-- 
Florian
