Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57DC3C25F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhGIO37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGIO35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:29:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D888C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 07:27:14 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k6so10471473ilo.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95dkVPm8mKfD+WhqlIEKmIqJnoyW6EzD5pKbI1YQ1aw=;
        b=kVg4PY8RXgvhd3Sd3kOhaIkN2d1ko23xe8BkDehunth690JjMfHF3Uw5kigoViaQAd
         XU5SoeLzp9siKxy8A0aR/ti6mesUX77cvCXt/w6QMFcJyhZdvx3swCPjnJzAFdLa9NT0
         RyUDvr+1uJxYWr6riQTSZnI3OAGzhpFFfiLsVGGJSU11Nldg/D88ys7W0vle902NNVLw
         hdcXc5j6MepYXGNsMtJgSnWhQvB7oBETnOEsctJ1Dc6/m5JgeuLdxyt+3mO3dpSoWpql
         FgH55bOFLAn4LJoZFe8KLGLbKFSA5roSCxYfSjJIU8CRPlsYgB85AXp2b0ymdI7+1dh2
         2nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95dkVPm8mKfD+WhqlIEKmIqJnoyW6EzD5pKbI1YQ1aw=;
        b=m0MD1c7KQw/Ko+eUxhvveY1LeKFoSObZ7psxegH1YzqFN9Mh6QKbeiSL7ldI8uIVxH
         EV0JUWsdXKqDn0Y3iCnG2ePIcB0lt3++xlFnN30g5CkksT61zY2PI7JIKd9nCqWCm++v
         6PMnP+NL39jYLGvtscagsYOix1WpxL/dU5G2UCLIY4dJMx219PDPq3OG+b7D/KjJGmC0
         yi7r5YjfHAcbfjiuN3UrRzMPoqdyRW+QLq+umtTxuQdeoktK6zy+qrdwIRwx4fxSFwy1
         AD4p7hbzE8pVeSEK4acx4feH35SKwPh19Zjna7M6SZrvFj8HQbzpuTWokq0iUz/WOKII
         uFog==
X-Gm-Message-State: AOAM5325R7n77SYMvIMEZ/tiMu9YZwOT4eGtqHlBykJGO0PST1wHfiQy
        8aEkur2QlzXC1kA6TDHrnpp35g==
X-Google-Smtp-Source: ABdhPJzC5DNGi6NgV9XHXpVkOO3/L8OD1SjkyK5Lwv4L+LABCTnOtlvRi1kZ873eia9i7G8qo59ftA==
X-Received: by 2002:a92:c7c4:: with SMTP id g4mr5026281ilk.252.1625840833951;
        Fri, 09 Jul 2021 07:27:13 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id j4sm2866189iom.28.2021.07.09.07.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:27:13 -0700 (PDT)
Subject: Re: linux-next: manual merge of the block tree with the mmc-fixes
 tree
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20210709103244.64b2f1de@canb.auug.org.au>
 <CAPDyKFrO-KcrPWBLGvS9hO+rLJjr=yx1766Np2M8HHApgkwNKg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <12c52b0f-275c-4663-d1bd-3f06fece4299@kernel.dk>
Date:   Fri, 9 Jul 2021 08:27:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrO-KcrPWBLGvS9hO+rLJjr=yx1766Np2M8HHApgkwNKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/21 2:34 AM, Ulf Hansson wrote:
> On Fri, 9 Jul 2021 at 02:32, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the block tree got a conflict in:
>>
>>   drivers/mmc/core/block.c
>>
>> between commit:
>>
>>   5c0777665b3e ("mmc: core: Use kref in place of struct mmc_blk_data::usage")
>>
>> from the mmc-fixes tree and commits:
>>
>>   249cda3325e0 ("mmc: remove an extra blk_{get,put}_queue pair")
>>   607d968a5769 ("mmc: switch to blk_mq_alloc_disk")
>>
>> from the block tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> --
>> Cheers,
>> Stephen Rothwell
> 
> Stephen, thanks for the heads up!
> 
> Jens, I noticed that you sent the PR with the mmc commits as of
> yesterday. Assuming Linus will pull it before rc1, I will rebase and
> fix up the conflict from my fixes branch on top. No action needed from
> your side.

I don't have any 5.15 code in for-next until after the merge window, so
it's all fixes that are going into this release until then. These commits
have been queued up for a few weeks, they are just part of a later push
to Linus (that was sent out yesterday).

-- 
Jens Axboe

