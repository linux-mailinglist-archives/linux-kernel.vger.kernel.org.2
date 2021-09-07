Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0290402AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbhIGOiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhIGOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:38:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF2C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:37:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z1so13138222ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/S6NVKS+rAl9aR4n3SE5uAuU4aZe4mciq8781mBYsjY=;
        b=VOSgUj1wc8knZeRVbNf3FAbpUzXJwSywrL5pYnfp/MjmVmoTrq28kVxU5DqwyIILlZ
         DT2SMXaXjzmzG4AZ7rXZwgKHeXg8KqB4S3W/w36ws2XAxAswl50Xo3REg9dt+BN3TdLW
         lmBD1A+fLx4oLlSeJVpuaGEhe/i+1snel97IOVR21KRTIlS3aFXdtIaNnIxXygIZbgXV
         cmC9VAeQ7K4sFJwKTadlgI46iF7/Uk2OrUEcLBQDiUGlQJbAu2htDS0OpSjh9tCcX0Y/
         YnCYlMXiUrsklhsGY+zQCX5/Z4Odevd6KG+8Eq5B0+D8gagDAARC/GOuTv9KYRdH0Hjx
         kzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/S6NVKS+rAl9aR4n3SE5uAuU4aZe4mciq8781mBYsjY=;
        b=KmdKPILbJ0zPmzqC8PejveuZbXDXLiT+42Cl+UDZartd056E4uAM2t4ysqNB2wUDbl
         iLpw9aUy2dggBZaNtMEoXgNds18KyCbOzT1N98Ag2r2FZiN52gci3W2eWB9QWpoK1xRd
         zQe8oBgzS2auiZ3pkkTo49l3NFk7HMPA6a7v2UZWaxcsB4TSQEam59uXO9hW8mSvjDwX
         UlVVRS/s+jKudl0YxVAjVho3OMzSPT9Vbson1YL9UeCKv73wKWFluZdsRPcvKI4FAiJ+
         VUqG/Tnufq+qMlnRFIjZTNBCHfbX3Aan655n0MXz7rbR9inBXUmXDBatBlqgjscJy/wx
         d8gw==
X-Gm-Message-State: AOAM532JtT0e2bU8NLLIUEXRxAa0pUgWhgXsg67cQWwCUo3VRcqiGj5e
        tsFRw/7s+nBm8JUwUvWv7x68Uw==
X-Google-Smtp-Source: ABdhPJxCFz1RVkSXmkxnoFMSLRVGtw+KyJ9h6cFRIdCUSz6PRJxUpW/2mXD2QFUHzuf5zVNN1O6PoQ==
X-Received: by 2002:a5e:da44:: with SMTP id o4mr13768582iop.147.1631025428502;
        Tue, 07 Sep 2021 07:37:08 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u17sm6343646iln.81.2021.09.07.07.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 07:37:07 -0700 (PDT)
Subject: Re: [PATCH] blk-throttle: fix UAF by deleteing timer in
 blk_throtl_exit()
To:     Li Jinlin <lijinlin3@huawei.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        louhongxiang@huawei.com
References: <20210907121242.2885564-1-lijinlin3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f962850-06d6-f50b-2c2f-e6d5bfd3823a@kernel.dk>
Date:   Tue, 7 Sep 2021 08:37:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210907121242.2885564-1-lijinlin3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 6:12 AM, Li Jinlin wrote:
> From: Li Jinlin <lijinlin3@huawei.com>
> 
> The pending timer has been set up in blk_throtl_init(). However, the
> timer is not deleted in blk_throtl_exit(). This means that the timer
> handler may still be running after freeing the timer, which would
> result in a use-after-free.
> 
> Fix by calling del_timer_sync() to delete the timer in blk_throtl_exit().

Applied, thanks.

-- 
Jens Axboe

