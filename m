Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76439A9DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFCSQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:16:39 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:38701 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:16:38 -0400
Received: by mail-io1-f42.google.com with SMTP id b25so7308622iot.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LrMYcjq05VyJxkL18sDV7DXDJoHHmPTPpPGO0QVG5ws=;
        b=sleU7SFV30zMQkS002evJmEErV/7Q8rP5+rKIXSi5P5X1GVAv9dkWqnFKKC7c38xTs
         fU+msYzfQ4THH5kjw70SVcaiqj0GykE9UDNFUxsR+Oc2yA2zjpjV8HCeQ/oBTKg41n0t
         pCr8PwDjnAZZ3eHScEhe2KKCK6Ujmbx+1RcPzN2N8UzF7/uqbaXMzpDyiuH7X8ueg6dl
         1iNSh1vGLo8pk68HX3Nu4xmJAhWlfLoChXUW46C/ld/0RBSCEx3sB6cNUX4wyFEOE27V
         xx/HFophmhK4/LPmdcV/WZfErMG+LtGGi2PbZGTC0AXWLQc5FsypAilyTGQSWEoykFSH
         Vr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LrMYcjq05VyJxkL18sDV7DXDJoHHmPTPpPGO0QVG5ws=;
        b=shI2RmvRA8l2VqN8tTF3U9WieIr0K/YF1LwyMy5mllWKq8cKdQ3kdJ+AZ4bESPbn+e
         ChWxjpPQ+K2A0RVEb8zedH0TAPDCl55zYLD5lBsGgTU3MifCnlTNNY7Dvt03iyXLkiZ0
         1YQK+bsoV3ReNtBk9EMoxgegUdqnXkP8VLTcn4WiqyRP/Xnlu1kOENMG8tSgVuHimI5c
         QU4wr2eFJgYXZbdBN4EM/0z6w/Y2Qn+gGZWssxBBRWJV43pEWWqPQp3L48HsxD6bVIJ1
         44P3H8J1A+770pQXb6we2IRFoL9eW9XPMm+reu04QeD100Gmqvb/Y2WT3bMPzaChOgWC
         w7lA==
X-Gm-Message-State: AOAM530x5+2ycpDd+r/woFJlc2uh68HaWoVNNlqqbNr4fYxrNbfOnhSs
        QauJIwlEoxci0QA0hIdqdbWgHTyjvSlKyBvy
X-Google-Smtp-Source: ABdhPJwMkO/dtY0/zseCyhwuB5uDMbGLutwMXu9Ca6DDUw+Rk/lHEdxnbjdJcFoLwQfJ+wckLJfkLg==
X-Received: by 2002:a05:6638:1482:: with SMTP id j2mr260876jak.63.1622744033395;
        Thu, 03 Jun 2021 11:13:53 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z2sm1901101ioe.26.2021.06.03.11.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 11:13:52 -0700 (PDT)
Subject: Re: Memory uninitialized after "io_uring: keep table of pointers to
 ubufs"
To:     Andres Freund <andres@anarazel.de>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210529003350.m3bqhb3rnug7yby7@alap3.anarazel.de>
 <d2c5b250-5a0f-5de5-061f-38257216389d@gmail.com>
 <20210603180612.uchkn5qqa3j7rpgd@alap3.anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89f8e80f-839b-34bc-612b-d0176050bc7d@kernel.dk>
Date:   Thu, 3 Jun 2021 12:13:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210603180612.uchkn5qqa3j7rpgd@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 12:06 PM, Andres Freund wrote:
> Hi,
> 
> On 2021-05-29 12:03:12 +0100, Pavel Begunkov wrote:
>> On 5/29/21 1:33 AM, Andres Freund wrote:
>>> Hi,
>>>
>>> I started to see buffer registration randomly failing with ENOMEM on
>>> 5.13. Registering buffer or two often succeeds, but more than that
>>> rarely. Running the same program as root succeeds - but the user has a high
>>> rlimit.
>>>
>>> The issue is that io_sqe_buffer_register() doesn't initialize
>>> imu. io_buffer_account_pin() does imu->acct_pages++, before calling
>>> io_account_mem(ctx, imu->acct_pages);
>>>
>>> Which means that a random amount of memory is being accounted for. On the first
>>> few allocations this sometimes fails to fail because the memory is zero, but
>>> after a bit of reuse...
>>
>> Makes sense, thanks for digging in. I've just sent a patch, would
>> be great if you can test it or send your own.
> 
> Sorry for the slow response, I'm off this week. I did just get around to
> test and unsurprisingly: The patch does fix the issue.

OK good, thanks for confirming, I did ship it out earlier today so
should be in the next -rc.

-- 
Jens Axboe

