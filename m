Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A436C7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhD0OkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbhD0OkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:40:00 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:39:17 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id t21so8990187iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VzCXi3U4cA43+FJ7G1wS5WnWPcFxc4C59R2q89RLAEE=;
        b=rbl6dGamxZbGTGVWIeflu0JeKPdpyqXU5lERJm2YuRbuWQ4IBGQgyC5N5Jk+OK8Pd3
         lJ8s5kmJRPzbsiUvF/PGui3B5GwuMd0T8U0IpGpJ9zRHHJgF0cxBf3KW784WXOg/SSuD
         NOigYuR0uJHKHGebfcn4KK+dMIQyU9shTVQRPA7jhEc9nGwDFYshsTrHamB4s3cHA6Wh
         QcLJAvvMZcOsPK31OZctElfPa5maEqxkRz8gioNYGzlySu05XLNnmDsSvK3nOhjCGgwE
         wKzWjNC0SkNAKFzUSvXcELzt9zCb0a2i7FAXVcpSA3Tdb+TjM/PdMa0F/3lm4xAQ5Wy2
         0ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VzCXi3U4cA43+FJ7G1wS5WnWPcFxc4C59R2q89RLAEE=;
        b=QnViGnjJm76Vt4I+qwnG+044+0q7xzdR0zg6ZFLfwBq5/Os7Z9J/2P7RvNE3CbdMth
         4D7hja8a8aB1xZmq6PpUNk0uDJicglIxhzx/YsjgTxo7QYs215javxFjT3mcZAzRohu9
         VO52B9jOl63eo8JAg8Y0Ek8+poZ53r3URmDYWsPDwmNn4Mn9Fc3TAXQchZHmi9Hrkk+t
         7a5L790bS5qDUe/qo/WdgDDwugGFPAgbmPrWIMI703wJIOyLB+8v2DGCgbPxZJPzzebm
         yAEmUiJA0m32++xzBxPy/9r1IiMGCdBnvMzGMIwwTG4D7J0RZUGr6sS98jIh0wcAI+TR
         gBYQ==
X-Gm-Message-State: AOAM531cR7ojd+O7WcADa1o9apHdds8Ltf/83VWNMm8AFyW6s6N6Z2QK
        0NUVVbWqXqgQWriVdj6VVm5ArVHQ2tZ49w==
X-Google-Smtp-Source: ABdhPJypkkuMfeIIfnwojWMH/w7kva/yQUVsfqM5rhBnFR4H91CxAwXUaJfUjT9wW2z4tolwobejxQ==
X-Received: by 2002:a5e:9801:: with SMTP id s1mr18976896ioj.194.1619534356857;
        Tue, 27 Apr 2021 07:39:16 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l2sm1441489ilq.70.2021.04.27.07.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 07:39:16 -0700 (PDT)
Subject: Re: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
To:     Peter Rosin <peda@axentia.se>, Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
 <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
 <14bdfbee-b8b9-d8ac-de34-b6d852d1485b@kernel.dk> <YIgLIscB1I8MxkWP@kroah.com>
 <5a55e8d4-e9b6-1854-51bc-afacd3ca097c@axentia.se>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e2ee4904-b13b-fd75-7066-d28e5a7ca711@kernel.dk>
Date:   Tue, 27 Apr 2021 08:39:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a55e8d4-e9b6-1854-51bc-afacd3ca097c@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 8:03 AM, Peter Rosin wrote:
> On 2021-04-27 15:01, Greg KH wrote:
>> On Fri, Apr 23, 2021 at 08:20:30AM -0600, Jens Axboe wrote:
>>> On 4/22/21 3:29 PM, Peter Rosin wrote:
>>>>> This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.
>>>>
>>>> The reverted patch looks fishy.
>>>>
>>>> gc.cd_info is kzalloc:ed on probe. In case probe fails after this allocation, the
>>>> memory is kfree:d but the variable is NOT zeroed out.
>>>>
>>>> AFAICT, the above leads to a double-free on exit by the added line.
>>>>
>>>> I believe gd.cd_info should be kfree:d on remove instead.
>>>>
>>>> However, might not gc.toc also be kfree:d twice for similar reasons?
>>>>
>>>> I could easily be mistaken.
>>>
>>> >From taking a quick look the other day, that's my conclusion too. I
>>> don't think the patch is correct, but I don't think the surrounding code
>>> is correct right now either.
>>
>> Thanks for the review from both of you, I'll keep this commit in the
>> tree.
> Err, which commit is "this" and what tree are you keeping it in? I
> think you mean that you are keeping the revert in your tree with
> reverts, and not that you mean that we should keep the original
> commit in Linus' tree.
> 
> In any case, I'd think that the original memory leak is somewhat
> better than the introduced double-free and therefore the revert
> should be done.

It should probably look like the below, though I doubt it matters
since only one device is supported anyway. As long as the free
happens post unregister, it likely won't make a difference. But
it is cleaner and easier to verify, and should double device support
ever be introduced, the existing code is buggy.

But given that, I don't think we should keep the revert patch.

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 9874fc1c815b..02d369881165 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -831,6 +831,8 @@ static int remove_gdrom(struct platform_device *devptr)
 	if (gdrom_major)
 		unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
 	unregister_cdrom(gd.cd_info);
+	kfree(gd.toc);
+	kfree(gd.cd_info);
 
 	return 0;
 }
@@ -862,8 +864,6 @@ static void __exit exit_gdrom(void)
 {
 	platform_device_unregister(pd);
 	platform_driver_unregister(&gdrom_driver);
-	kfree(gd.toc);
-	kfree(gd.cd_info);
 }
 
 module_init(init_gdrom);

-- 
Jens Axboe

