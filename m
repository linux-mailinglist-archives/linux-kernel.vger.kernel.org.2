Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D23F04D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhHRNbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbhHRNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:31:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB912C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:30:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f3so1825800plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JiAEKqw1TmaXG5ey30yvp0VAO5EclWS4YuSYejPpRTY=;
        b=AycjMMqhwlYIW1ijZTPQVS12fZKgquQqE2Oxp2pINc2+CTNVUc+QB3yZ1hd5XlBw7L
         5+RdyMHrVKOSEg8unXD0TLGGNNYz35UpeV9jJP8/kggqrLjTCKj1cU0Mk49n6ebGnuWx
         W84WbWt6oxOXq4Y+PkZrXjcJuM79mKExEwoeNLSshwb2fccfAAdRGdCsLn5n4NntKfvi
         +s0QImtyrSUTFKzwDGzZJkpLwOGYE88agrbfRBbGJ6XRGbwnqXZO+Cm1KH+lx1IMYjJV
         dUJieUwOP9nXifVPguZHGVLHlYwViTAZaD5W7Iomtv1/JT06EjvStbEh2SDwrWFZdkKZ
         Npcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JiAEKqw1TmaXG5ey30yvp0VAO5EclWS4YuSYejPpRTY=;
        b=V2X2KOuEcFf2HF8YSTmpYyyfql55klw7Y2pjtM+WqcrCbKu6hKXXvIk+A4E96uT6NO
         3yoDmoRqibhP7cpM6NkyzvcJ7pQGF9Ppvzl1W0nl5VyeO2y+AunTU4vCnGzR8WM7UrjQ
         lEMyJLch6rexqiNroQ+uUU/BkyHoAnT0R/zLuexBLLsXCdnMz/yu1U0YuB6ZftzgLm0Q
         XL0R5TtMwjLn7Vby3XKmF2BnzKCHXF2HTyyFbbAaY2AomwX75HX4ktC1KtiXfaSho13J
         nTAFGYo8tfxfloSUIAzHHM68MG7vYmrhfyxpH2UxdTTOrlLgDC+00dJpiAAvsA8sYVU4
         O56w==
X-Gm-Message-State: AOAM531Ywxm4vtPqAtrc83OWly9lWE/jOkfJSXZFXMpivheXiqJum6qI
        nn2VkHK0KfWD+AXlntGddoIpL53YRnm8qcc3
X-Google-Smtp-Source: ABdhPJyU6qLIy37UH3XENdWCN2YDjkxYHtMEqpB/Si5Lyh4NdoxMlmpFg2JztRpczf5spGft/M7xNw==
X-Received: by 2002:a17:903:310e:b0:12d:c3e7:a8d9 with SMTP id w14-20020a170903310e00b0012dc3e7a8d9mr7295026plc.35.1629293444180;
        Wed, 18 Aug 2021 06:30:44 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q21sm5231817pjg.55.2021.08.18.06.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 06:30:43 -0700 (PDT)
Subject: Re: [PATCH 01/01] io_uring: Add register support to other PAGE_SIZE
To:     wangyangbo <wangyangbo@uniontech.com>
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210818055613.1655-1-wangyangbo@uniontech.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <24d10cda-445e-10f3-d249-dac254e199e0@kernel.dk>
Date:   Wed, 18 Aug 2021 07:30:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210818055613.1655-1-wangyangbo@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 11:56 PM, wangyangbo wrote:
> Define rsrc table shift from PAGE_SHIFT

This really needs a lot better explanation. A good commit message
explains "why" a change is done, this one doesn't have anything really.
It briefly tells you "what" is being done, but no reasoning for why.

-- 
Jens Axboe

