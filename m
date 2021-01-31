Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B143D309D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhAaPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhAaPGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 10:06:52 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8149C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:06:05 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o7so10278096pgl.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EOdQu8R2fot/gp5Ae6HSeBVIkzrM0gQFsbLsSFMQobU=;
        b=lf1ichlOzDlmK5NBztXD3cxB3cmRPaMi21O/wA/ZnS49a0HR0kXmuTzan1KAKyP1V1
         NcwYBAFkWQym4kJFWS0EDfJfHYck9MxLnvvZ1FI86oGoi3QXbWp6qXIeBd4OC4BuAohP
         lWLyITWVErKWExTEIrfeuosVXqs3/rCjXU79IYbiOrG0bY4LUd8dK/tyBhV8N6PJOmFT
         xOIAj+QlRPFWf+Qx1tvIZ1h+ufGfZ+2Es/PThsxTrROoJDMhHYDKKBhpZOc3HbF82iZT
         VpnaBKowxfVK5CLVBSPnomJk1zRnlDRiCB/pwrSYvtcWXt8pOve4GcjBsZIxpUdJvUTD
         vhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EOdQu8R2fot/gp5Ae6HSeBVIkzrM0gQFsbLsSFMQobU=;
        b=njwtj1K5YTxSXBh+V9mpbiLIHSeTzCVxAqyVlwLaRsLLB7wB0gQ2PTYMPTfwiVbf5+
         LxxHQArAwL31crO+JM5b/Gi+382Qj0BwgJXDvDi9qJ+SER6QlYm4pBIwagiZhlVQ/hi5
         JfzHQPtwllRdq4VsreSuB7W4nwd0Zjy8tdQnIMkUaipx4gIPNtSc1Mai5NB1/Lin9LvV
         Dmw9cOq+gB/MA199KjC05VNYI5SYlmO0a2wb0QOX6mnXmagnZTbbhD2gFYPjWBW8+xhA
         ciXFI3sOUSbni+21eZWasR1Whlmp06OloWP71rzoBlOaC5hm343GZfmBYgQ7h4wdih8q
         gV4g==
X-Gm-Message-State: AOAM5313fsRfZxV8IiIC8dwbaU9pwse58ZIh0njYNaSh94/2Bb7HgN8d
        jnIMGpUChtJqp+EOU1SGS+4hyc0MdpawAg==
X-Google-Smtp-Source: ABdhPJwKrPeAj1uarbZ2u2NbLVs/aKaffadRPNV8uqGTBXDsrJCFeUsqtkDVw36S8rdnVhc6Itn+5w==
X-Received: by 2002:a62:2ac3:0:b029:1bc:4287:c0b3 with SMTP id q186-20020a622ac30000b02901bc4287c0b3mr12021723pfq.26.1612105564903;
        Sun, 31 Jan 2021 07:06:04 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c4sm13466537pfd.160.2021.01.31.07.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 07:06:04 -0800 (PST)
Subject: Re: [PATCH 05/29] ata: Avoid comma separated statements
To:     Joe Perches <joe@perches.com>, Jiri Kosina <trivial@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1598331148.git.joe@perches.com>
 <2a3979b0eab31224e53553ca01759eb072790a65.1598331148.git.joe@perches.com>
 <e65adfa0d8a74e06edda822ac42f7c62c8e0af90.camel@perches.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33b209ae-14d6-477f-19a4-2a94b5adc6f3@kernel.dk>
Date:   Sun, 31 Jan 2021 08:06:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e65adfa0d8a74e06edda822ac42f7c62c8e0af90.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 11:56 AM, Joe Perches wrote:
> On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
>> Use semicolons and braces.
> 
> ping?

Queued for 5.12.

-- 
Jens Axboe

