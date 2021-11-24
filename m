Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194E645B1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 03:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhKXCJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 21:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhKXCJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:09:39 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3BDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 18:06:30 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 14so1210259ioe.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 18:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6JqwUkT5b5T7yfFvPXHrMYJB5jvxB6kIH/FjieZ2ioU=;
        b=LgT+EnxlUsqCl6vjE8BXM9rnL1rlkUNBl2HyIbvhxBRq0bKcD6xqahoNl/iHaN9bL6
         rD5C5RCdKTe8hciJ7PCGmxlxQwnKAIp+n0JgFudGEfuteaAQsW97VM9dn/jt5KN586k8
         MeyitQZ8grHhwktvV8RDcWQ72o63XlVOgbyOSxQgmTRqTBuN3aeUpZN5xMH/tEkuR4RF
         UYXwb05NYjCIbQeiT/aFUtzIcORyTYf4OJvzTMs1WNYCHZBqDEW5P03w22NC3CneeEzJ
         AMaqcGYU7tLHuvDOqlW4e16Uh5mNPB9XGYWrf53KaFmwfttoYTfq0iqiqyhJX6J1DinM
         xDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6JqwUkT5b5T7yfFvPXHrMYJB5jvxB6kIH/FjieZ2ioU=;
        b=mHmCN1hbnjLeLlhDGbOuzVJi1sfEpYQDAGdIRbWXse3Bj22kx+DI1fEnrxAHuBCWV1
         O8HL1i5Tnt1j4WKMVVmwi6DjJiKq0YsqUC2Jxn31SAuLYVc6K15c1mXXnoMi8InbYpDr
         rHdWHsj28aNFNC7leQ7GYhLrCyPnm1xUh7EkBafFCveuuq8ZwKpiaMK+ersViRqQJMaN
         RD3MjwVN3wEuevj8O2B4/7rrDxS4zYIxcfuT6B84wc0jESNyo3lFhftpQb9FjejwB6Z1
         YS2zDPdwXqKfU+uKSALnXppL4SQh5X6by3bcX31AyZ2CMMFYthD02yrroBX9/Rk1s/uC
         VfRw==
X-Gm-Message-State: AOAM5320U+5SFuwtEEzTWbXFdlNtbmq0CLJDBI9rTBLt5XlICH2j932q
        HvxxKkPqh2Hi5eZrEbIfGeiADw==
X-Google-Smtp-Source: ABdhPJx4MZlam5+iHKslwY0j62QrIcewX49zDPgL9KlKi2J8fMMwxut5JvNPkr3TxJDyb6Yo6LPO+A==
X-Received: by 2002:a05:6638:2054:: with SMTP id t20mr12215861jaj.42.1637719589837;
        Tue, 23 Nov 2021 18:06:29 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k13sm10235749ilo.40.2021.11.23.18.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 18:06:29 -0800 (PST)
Subject: Re: linux-next: manual merge of the tomoyo tree with the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211124113825.2d9de813@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cbeb57ae-5a87-9959-689f-d9d73baf6ee4@kernel.dk>
Date:   Tue, 23 Nov 2021 19:06:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211124113825.2d9de813@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 5:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tomoyo tree got a conflict in:
> 
>   drivers/block/loop.c
> 
> between commit:
> 
>   3793b8e18186 ("block: rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART")
> 
> from the block tree and commits:
> 
>   dfb2cc3b7f7e ("loop: don't hold lo_mutex during __loop_clr_fd()")
>   51d5ae114da8 ("loop: replace loop_validate_mutex with loop_validate_spinlock")
> 
> from the tomoyo tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Why does the tomoyo tree have loop commits is the question?

-- 
Jens Axboe

