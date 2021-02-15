Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1949531C386
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 22:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBOVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 16:24:43 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35183 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBOVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 16:24:42 -0500
Received: by mail-wr1-f46.google.com with SMTP id l12so10755372wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 13:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9WE7sfWuADZEgBkO6VBLoyU3Kt+14QI5HCaf9dRKQr0=;
        b=QHld4gcAirLT9KYKVdp2J9gadjhIMcCWtXam524bH4RRL8nYR1kbztFgFVcbnyBu6N
         sTNpEeT/Qp2/CoIS4LvASklE5qu1VGbuOqQZXUeYE7RfxzQJ00WpUNyMw4bGXnkLwAMe
         iQmkO65iDLxtkne/Rsy4buPGPpsRwm3rYgFSMAlxK4cvmKQNeLSUauQqh7SKQnopYV/T
         cYSXnD1RP10ZgTPAg6T3PpQesIDHKB+A1J/4inkPhoipdEzJC50p9syjvULvIuO6yMuP
         obv1jrYx3r3azUtdqFfpDjs3mi1SlEGIvnkI3MefgMGPjwRuzgRMi/tY3PKlsF4rQgRe
         pDvA==
X-Gm-Message-State: AOAM530KZBqmpDbwcCrZfZaQt31s0lBvsHB4LIjGAw3kcs0Z5VEEklD4
        /dtGdaHzqJyCMqButzP83tm8vElO/Cw=
X-Google-Smtp-Source: ABdhPJyOdMuEiNm8u20zTsF8TOp7tAyT4IUWQCToD1uMnEiSwNxtuc3/Htz4clHlcbiBTWYOQf6beA==
X-Received: by 2002:a05:6000:242:: with SMTP id m2mr20027397wrz.422.1613424240136;
        Mon, 15 Feb 2021 13:24:00 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e348:9c6c:4cb7:8321? ([2601:647:4802:9070:e348:9c6c:4cb7:8321])
        by smtp.gmail.com with ESMTPSA id t6sm16067655wrn.96.2021.02.15.13.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 13:23:59 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
        linux-kernel@vger.kernel.org
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5b45835b-eb81-29e8-e319-a8509474e27f@grimberg.me>
Date:   Mon, 15 Feb 2021 13:23:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> blk_mq_tag_to_rq() will always return a request if the command_id is
>>>>> in the valid range. Check if the request has been started. If we
>>>>> blindly process the request we might double complete a request which
>>>>> can be fatal.
>>>>
>>>> How did you get to this one? did the controller send a completion for
>>>> a completed/bogus request?
>>>
>>> If that is the case, then that must mean it's possible the driver could
>>> have started the command id just before the bogus completion check. Data
>>> iorruption, right?
>>
>> Yes, which is why I don't think this check is very useful..
> 
> I actually view that as a valid protection against spoofed frames.
> Without it it's easy to crash the machine by injecting fake completions 
> with random command ids.

And this doesn't help because the command can have been easily reused
and started... What is this protecting against? Note that none of the
other transports checks that, why should tcp?
