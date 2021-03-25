Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070DB349393
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhCYODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhCYOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:02:47 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D270C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:02:47 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l5so2189511ilv.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uui5a2oxxV+bwHUJbRgbxWLfj5T7kr4j6jjOle6T7XI=;
        b=0TgDRLwmC8HDiV152IBCAqqdrtE24Y390ZTej2c2FnMRvBN7kPv3vMiIiSrNk8raxR
         Mna00pxYW2dtR/m18RR+u5h53l0uVLQlCZ3s2/Gj42lmOuQvwC4ujSwk6/xRWeQRKJ54
         bWbQBwt5HP/iR/VHNRQ8zcKsVDrvc1EVHgJzO053zodZtJ0B6/JH/9wXQZCIqawTHAhv
         f3kuyjKXWCqx7ol4c9w5/QTp4fQ3U2Fkc+G5/9IZguQZdv2aPFlUXKUozX9Wyp+AJLM+
         JfHn4XK5+d7awchuNTF/RL66kajhe15tIBtZCCvfOHvHzxHFVRqthl4LOMAKEMTrSmXl
         nySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uui5a2oxxV+bwHUJbRgbxWLfj5T7kr4j6jjOle6T7XI=;
        b=I6PHe2N+mjdSA4xyd6nG2XuNfqd+sECJ25iqbgYQA3eAUbyV42oFd0VmJ/1f99ysIH
         w6COG4hUBdw1Ym5XEjEcCZtI9y8m9AXo78aY+J5r2pxyVd5JwKKHrUQXdREPGYfz0woe
         dIdKalIB5vlJqYRu1TmL2yjwyNnPprjOzmP7VRNsPi3Rhqk743s/F7XrPTfmNw+Czt5f
         LYZ2wPtkq3TuLhO2BnjLKCcAby5JCQZn2KFQDYuEdmqvBlseTKvhyDSIL5/rDcsDXJY0
         CWAVNPOV7grJ/YZRenpd669GTIxAYgw119YgYrSJfxbnBShyyaotD3pqA6IJjUko0nyU
         oDFQ==
X-Gm-Message-State: AOAM531M+hp8q5RsUP68QjQcQLH3lrPQLI4kK3KPHDCbsewPFG/Mabdt
        lMjOog4anYYRl/kDta0B6dgfr2tJh3PZig==
X-Google-Smtp-Source: ABdhPJxCmDscdqVLvLkVFtL37YbSiDv5nqipeM0bcr1okBhaoiMKNf3oPkrX4smPjOLRnP/ZORZJZA==
X-Received: by 2002:a05:6e02:d53:: with SMTP id h19mr6871217ilj.157.1616680966589;
        Thu, 25 Mar 2021 07:02:46 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o15sm2799441ils.87.2021.03.25.07.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 07:02:46 -0700 (PDT)
Subject: Re: Are CAP_SYS_ADMIN and CAP_SYS_NICE still needed for SQPOLL?
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210325113322.ecnji3xejozqdpwt@steredhat>
 <842e6993-8cde-bc00-4de1-7b8689a397a8@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <46016d10-7b87-c0f6-ed0f-18f89a2572d0@kernel.dk>
Date:   Thu, 25 Mar 2021 08:02:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <842e6993-8cde-bc00-4de1-7b8689a397a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 7:44 AM, Pavel Begunkov wrote:
> On 25/03/2021 11:33, Stefano Garzarella wrote:
>> Hi Jens, Hi Pavel,
>> I was taking a look at the new SQPOLL handling with io_thread instead of kthread. Great job! Really nice feature that maybe can be reused also in other scenarios (e.g. vhost).
>>
>> Regarding SQPOLL, IIUC these new threads are much closer to user threads, so is there still a need to require CAP_SYS_ADMIN and CAP_SYS_NICE to enable SQPOLL?
> 
> Hmm, good question. If there are under same cgroup (should be in
> theory), and if we add more scheduling points (i.e. need_resched()), and
> don't see a reason why not. Jens?
> 
> Better not right away though. IMHO it's safer to let the change settle
> down for some time.

Yes, agree on both counts - we are not going to need elevated privileges
going forward, but I'd also rather defer making that change until 5.13
so we have a bit more time on the current (new) base first.

-- 
Jens Axboe

