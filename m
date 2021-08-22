Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3453F4056
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhHVQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhHVQHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 12:07:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A3C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:06:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u1so8993393wmm.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tQHe9Q7vl5WTwA6JvsLeJPa2NzlgzjWaSheEAIc4ByY=;
        b=nSPtHF0yQLcBa281rX8Vb62/q1KXYbuy65LJijoKcj4QTsSh7wRSliTnS52Wqwu26Y
         h7hwYt70v5FSvypPAlblS/8wTcR1xvH6RkNDQC+PPSI1WeNDcerNoOI/Mp26iXfz4xfo
         keSrXGM+UyYtDYPyo0pMZTEdex83kNcsv9P2B4MnG5sothArKUKQbCckogJo9lpgeExH
         tt+2ApSJPmCHDBAvla8/W/JiRFMYPSqM0ZPGeFAb9YlBy7DiKQkZkyi9mLMgwnzb6dr2
         n7qqpjifUL47ygDiePiculGwCA7JXYqcvaH+YpOBqzlm69+KJURqDQOagR9d6spxiGWo
         Gjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQHe9Q7vl5WTwA6JvsLeJPa2NzlgzjWaSheEAIc4ByY=;
        b=bIe2qTTzEuCNIu4CyTHW31qN7PZax3lE7sQwFAMgTC5xQtgigUhanRmDajUAwzoqJi
         IFLDLd03s1YRY553i6KDC+8HoSmakJv3fb4irgODkO2cYDwpycNE/0NBMlYbIdEJoQly
         zOC6VRv8wxjsVlorEbjyis5uqpI4inraeSPCBfbIyvGPut3pPO+umGPdCEEhn0/BIqWw
         WQ1/eQx10Ks7XSEpcSgsvh+ADvE8s3zlFlO7QA+FeM4pf3tbUZPMDFcR+TuQNyAR/SPb
         YxL6FdsSR6WI6+bp8vBh/zhORfEa4feTWP/RVS+GuMTu8XI03g55LM9MUHh5S29YgkFf
         P2ZQ==
X-Gm-Message-State: AOAM530dZ9QaERz2GrBOn1LyQm6aqUcVXXZSXzuKJv7t7Jnun/JI1e7/
        1ec6DPKtxkPC1c9LWVowLhiYCe18efM=
X-Google-Smtp-Source: ABdhPJymJNttuHfuLjOB3RWi9DEswOIahfKaers0FIY9CAncJsbfx8vBZQMU2R5r5AdrA3btdub+qg==
X-Received: by 2002:a05:600c:3b06:: with SMTP id m6mr12525317wms.35.1629648383975;
        Sun, 22 Aug 2021 09:06:23 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id y14sm12497035wrs.29.2021.08.22.09.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:06:23 -0700 (PDT)
Subject: Re: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
To:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
 <cover.1629642658.git.paskripkin@gmail.com>
 <44fc34ec-6bbe-9cd0-0c51-78836bad7e0c@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <d479bf75-f031-136c-3967-16127ed26868@gmail.com>
Date:   Sun, 22 Aug 2021 18:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <44fc34ec-6bbe-9cd0-0c51-78836bad7e0c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 5:30 PM, Pavel Skripkin wrote:
> BTW, can you recommend any devices with this chip except for ASUS 
> USB-N10 Nano? I didn't find any of them with delivery/reasonable 
> delivery price to Russia.
> 
> I want to help with testing and moving this driver out of staging 
> directory :)

Hi Pavel,

My one is a TP-LINK WN725N (not sure, but I guess v2).
You could also have a look at the device table in os_dep/usb_intf.c

Regards,
Michael
