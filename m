Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965F33EC699
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 03:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhHOBPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 21:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHOBPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 21:15:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C4C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 18:14:41 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e186so18322842iof.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x2b3137Hg3O35wl4KvAg3fkN/4EPjZhVIIFocKDpOzw=;
        b=JNP1gkSDmAye92b824CW/SUEX+EdwwaqZtDqtnkJAUmkDBHjTHWSIsBYNlIXQxvqR1
         XYt2ztX4SxZcsvu1LwvlEZKlL0f84LHRTyNUYRg5hfqTLTt8MDuCIoRdZ/diOGS2zvrV
         vcX4KXpOItr26LiTEAMxsjoDzStZ1sE+BvhUhEblVe92CKn7WnJFf1VDJc8QaH9DMnkc
         wMNYXBeQeE020Q2qe+xZXJYzhou1sIJ2mrWoXjqNSXTDoxtKOhDtH4UmPW98ZFjTbvOS
         L/KLNSVZ72TBI3xSYdZnf3/IcyWwpZeIxzRFXyPSXOHUbEDE5mLyKwm3Gixuy2HUgfVb
         k14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x2b3137Hg3O35wl4KvAg3fkN/4EPjZhVIIFocKDpOzw=;
        b=sgUXW7NinsDTsrLbxFXWTTDgj0VaDaBrXWX3NFCly4zS3QcFraCPxINUCazOaE2XxK
         mXwS3BIiBYBUVh+Kte1H7F3fRapDNNJUr3yJQyuJqIws5H8w8JpJp41iqYvC22++JOSr
         VX+NPTqvxs2AjHGpZNWvXrUo3ZbzXGBvqiz766JGHL9YT++EmckK08pwbE7j2h/B71Ku
         RGxBDkUS3M8y14ywIBmO2x27OZJ8fMBAVJI5UQOpZmBXqOBjt/N4kZv+P8oqzM7k4pHC
         XO18D1WWLUqOALaZyMRKZJ9Uge8bCrRXb6bIQGtkHiEYyHBYQe7I77JFzi0WazXfI+ro
         a4Tg==
X-Gm-Message-State: AOAM531DQy13sXF6v8BBfcBzJmATo6ErVwIPHulQ6eVhD39d3NrRzUAA
        ECYeaw3tGZtLRRH7VtCdIRi7iw==
X-Google-Smtp-Source: ABdhPJxw9puQIiXvkgw1FjEIRiEMA52YP5gYHEPETTSDjcPlzFAj2ZwJrD/Smwt/BykmuqTeN/vHcw==
X-Received: by 2002:a02:cc22:: with SMTP id o2mr8769511jap.26.1628990080703;
        Sat, 14 Aug 2021 18:14:40 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u14sm2730446iol.24.2021.08.14.18.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 18:14:39 -0700 (PDT)
Subject: Re: [PATCH v3] blk-throtl: optimize IOPS throttle for large IO
 scenarios
To:     brookxu <brookxu.cn@gmail.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <65869aaad05475797d63b4c3fed4f529febe3c26.1627876014.git.brookxu@tencent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53196a1f-9fdc-269d-801b-ce1ff2963cb0@kernel.dk>
Date:   Sat, 14 Aug 2021 19:14:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <65869aaad05475797d63b4c3fed4f529febe3c26.1627876014.git.brookxu@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/21 9:51 PM, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> After patch 54efd50 (block: make generic_make_request handle
> arbitrarily sized bios), the IO through io-throttle may be larger,
> and these IOs may be further split into more small IOs. However,
> IOPS throttle does not seem to be aware of this change, which
> makes the calculation of IOPS of large IOs incomplete, resulting
> in disk-side IOPS that does not meet expectations. Maybe we should
> fix this problem.
> 
> We can reproduce it by set max_sectors_kb of disk to 128, set
> blkio.write_iops_throttle to 100, run a dd instance inside blkio
> and use iostat to watch IOPS:
> 
> dd if=/dev/zero of=/dev/sdb bs=1M count=1000 oflag=direct
> 
> As a result, without this change the average IOPS is 1995, with
> this change the IOPS is 98.

Applied for 5.15, thanks.

> v3: Optimize the use of atomic variables.
> v2: Use atomic variables to solve synchronization problems.

Just a note for the future, changelog stuff goes below the ---
line.

-- 
Jens Axboe

