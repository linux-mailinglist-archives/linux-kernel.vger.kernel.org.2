Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873413670B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhDUQ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244469AbhDUQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:57:00 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDFC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:56:20 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r5so27299940ilb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZFSOtZMmhPTU9JBlcmY+DOQRzSewGE0IcmlQTJi7S0=;
        b=bNTNqa0HnJa/B96/tgwhvBuQpuVTe1iPwITyvrdSrRHPB5DoRxLBUdBPLtLHjvIomh
         Ldqygq6t4Kkok2mJznizH5aq0ldY4422+lg1pAEcKFumDSlgL/0cAfmic/MOR4xeFRtM
         w6wmmTrJwmyZyeM2q0eiZUxxzm3f3r+0r41D2QZs0ngWt8J9xnYiCjZREmVVFuGlADNZ
         SzCHkhwXHuminZIE748/nkNkad8VDEspwN0xIcJ8fFbsmTNvUmED3o20aU7KzmrJo5vM
         Kl3Y2pOEN/X0qSYNgPu37WaqSA/DUC/s8XpqF99sag11yzyHd7t4Y+YUKyD35tN75Sue
         hkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZFSOtZMmhPTU9JBlcmY+DOQRzSewGE0IcmlQTJi7S0=;
        b=ADsTkajT3+tatzWwG+k+Kjjn45KwOcLHIr78BEKH77O+y+xM/pQ52MjA4+G5It5WEF
         /W1MO8rK7O91mYAIEw178ubYoRwH6Cf3pIf+8Lo0Am3kSROPPk0J1FTp6EwRy3ku1B5l
         to4i1J4wRN+c2LTJ76TRS8Q2kH1E8d4tjIi6BLFOSufFyyy/zQ+xc3g2V7vAd9+rV9o6
         ZTk623Awfx7U46luQB3ebh6YSdZ3oRQMWYAX9wxyztSSZsAIXhVLbI+A6qWayrVuA6FV
         oqJUxZAznu3Rg/x0vdDpfIiRUuV8RvpyR42Oi9QZ9Z2nwIgh8XG7w+qYPIiCpCodv2L/
         VZew==
X-Gm-Message-State: AOAM532Skze6PpdYlmdhVPRVbq4Gm+DVKH4OoE4VY51bEW8k52WySS+X
        H95A0EWs88K5bVaOigCVQTqn+g==
X-Google-Smtp-Source: ABdhPJz59S8ZopGsXeRykQwRa/BtMRNsMKDwQ8qauGoKqx1v9yg1pXNk1bR0YA5rQYC2szzx/kW01Q==
X-Received: by 2002:a92:2c02:: with SMTP id t2mr26500868ile.233.1619024178693;
        Wed, 21 Apr 2021 09:56:18 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a17sm1248701ili.6.2021.04.21.09.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 09:56:18 -0700 (PDT)
Subject: Re: [PATCH] brd: expose number of allocated pages in debugfs
To:     Saravanan D <saravanand@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkkm@fb.com, tj@kernel.org, kernel-team@fb.com,
        Calvin Owens <calvinowens@fb.com>
References: <20210416211829.4002947-1-saravanand@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd3added-1674-165a-0cfd-5e5841b738c7@kernel.dk>
Date:   Wed, 21 Apr 2021 10:56:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416211829.4002947-1-saravanand@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/21 3:18 PM, Saravanan D wrote:
> From: Calvin Owens <calvinowens@fb.com>
> 
> While the maximum size of each ramdisk is defined either
> as a module parameter, or compile time default, it's impossible
> to know how many pages have currently been allocated by each
> ram%d device, since they're allocated when used and never freed.
> 
> This patch creates a new directory at this location:
> 
> »       /sys/kernel/debug/ramdisk_pages/
> 
> ...which will contain a file named "ram%d" for each instantiated
> ramdisk on the system. The file is read-only, and read() will
> output the number of pages currently held by that ramdisk.

I folded in the justification and applied it for 5.13, thanks.

-- 
Jens Axboe

