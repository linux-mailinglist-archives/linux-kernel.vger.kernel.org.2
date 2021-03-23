Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9034664E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhCWR2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCWR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:27:51 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF8C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:27:50 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id j26so18504147iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HeqUxpw67GUtG8xohzxQIj1PzhT3kGyB+k7vjdvIyxQ=;
        b=tO0RdXD3HzTKx65xOHct/Oaac5lN+TwBFu1cZU6ZbMJEjDAA0QpZ6BLpePaXMoHBeG
         AoPjKkVtXPYmqjQcZzL95IrcJG7je6M5XalF3b3uFh2CpQbMjJ4U2Oe4iZtq8Ea+fgIp
         NTtvSCyk+26XObFWg8v3Y48d7/4kL6mOe0mVR4kKZTR2tkUygAPD185BiTmdKPmE+gyJ
         PF94Tnn283npgzss6yD97+zsav7PG2KsvgdOw9UwB1h+p9kCbECu3Qxh9hHL3WMLv9/c
         Y0nqzJ01nVMtNoHnduk9RzPcfBxYpSWs9jf5VR8+kArqvEjI9BBF73qGHmL4X8HmoZJg
         fFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HeqUxpw67GUtG8xohzxQIj1PzhT3kGyB+k7vjdvIyxQ=;
        b=LtWDZp5XOh4MNwn90swonvjRhUYWoGEXoDiqbW7hLzkhkvcsv+FhxhJP6lYElkHU4W
         LvAkpQhYjTe6IW2AoZ/5/Cwv30L0ChtZPNPCR5yy9JmUQEnw44ImJg9DrFcaQJNeQXzP
         m0O4cCGDZzbetKlcpjldjj8PtHmpqfJBpDgE61ZXKf//CcW+jrZPT9ZAjSsjbxg8/eec
         bUSM7pXbIwiWjyj+LvGU36ERxnVGZV3UH/6uijgXs8VLuquDXhN8CMoujbgToorhA2ZI
         hcJPw3VTXoppR5aB8uLvfr2B/7hCQOWyD5VKcqeFWYxgUkmuRsdQAt1TtmzOymxiCCN9
         uABA==
X-Gm-Message-State: AOAM53218vs6Ch4IIXUN2ONXOVs5/5BEMmbbwAmI0mCwb8OiJJUZw51F
        rvM9/e9fho3pQNXe2SttuTmzfw==
X-Google-Smtp-Source: ABdhPJwLwiXGn9Vq7IXdEmorOoB/+QyO1pIg+nEB4rjswWkjpATzbY3SbS0r99PDOoF6QMcuPo7x8g==
X-Received: by 2002:a5d:8b09:: with SMTP id k9mr5098007ion.185.1616520470339;
        Tue, 23 Mar 2021 10:27:50 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e12sm9566148ilm.85.2021.03.23.10.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 10:27:50 -0700 (PDT)
Subject: Re: [PATCH] block/umem: convert tasklet to threaded irq
To:     Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20210323004856.10206-1-dave@stgolabs.net>
 <20210323172437.GA2463754@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d26434e-36e2-58f2-16b4-ef0fa4292c6e@kernel.dk>
Date:   Tue, 23 Mar 2021 11:27:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323172437.GA2463754@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 11:24 AM, Christoph Hellwig wrote:
> On Mon, Mar 22, 2021 at 05:48:56PM -0700, Davidlohr Bueso wrote:
>> Tasklets have long been deprecated as being too heavy on the system
>> by running in irq context - and this is not a performance critical
>> path. If a higher priority process wants to run, it must wait for
>> the tasklet to finish before doing so. A more suitable equivalent
>> is to converted to threaded irq instead and deal with the async
>> processing in task context.
> 
> I'm really curious if this driver is still in use at all, or if we
> can drop it.

Me too, I'd be surprised if anyone has used it in... forever. We can
probably drop it - I really dislike making core changes to something
that can't even be tested. Davidlohr, assuming you had no way of
testing this change?

-- 
Jens Axboe

