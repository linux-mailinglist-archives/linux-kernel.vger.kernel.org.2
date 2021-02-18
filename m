Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE331F2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBRXYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhBRXY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:24:29 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7B0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:23:49 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z6so2524923pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F6K9/2GMwbJ3bhU6hJWUI6YWV5BFx6Om9siFDF7askc=;
        b=HSl3eso9PIuLUNphuUt3EKoYgHCiUTO8UCtDeaXMcRlKyAc1AT0f+PMYqYrd61at1u
         0PUV2ymit6GGip2c0azR54NyzA7BC+KPwDL9FIkJnXRRGvzy9/ndZOSl7wH5FK/7xvZV
         ndJH5ElugOBCK2v8Pg3HG2hzYE94mz1hmjz2F6SZHA4IdEke7NqCgeiwTAb6zP+3nGIW
         HAONoSpY7DB4ZHY1rzosUsVO/JAdoT3ztdlAD77bR/TGIhrkmIq5eEcrCRHuLmanNyt6
         Bk5+SvwR3u72R5YdP5HlD4E21mNhM3c3ktwTCmaRjvcB7Q1Fnpj1ock+e0CIC8Zi2mng
         kZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F6K9/2GMwbJ3bhU6hJWUI6YWV5BFx6Om9siFDF7askc=;
        b=UngM4hHa10B/kPOI9XSUZo4EpfG/gqPXipiyqO2HB+ZZVoeBXZ6NxBqo/UEQx4m4wu
         cjAomCQoCZSyktB1BEH68mTj2sMNK+I48oF6Gu9mqEfvcLwyxLKWQZ+rbHaZOS7VoDRJ
         FlBDdCWWHOMwnZZHTSsjv2PBFYsn5RCWDiIPV1tsVw0f2phBee6gb+Fxe9vx45YQkoYB
         Y3aX8ORoHqGfztANUs1HYV1KP2jClv2wCh0ekySp8B9PHENSHPsZRDw4MpwlOPBU6I5Z
         LeEbTG8qJ0kHn9SejftzgjRYt/7BlvhKLXvSYxTg3idJhRbms0IrJrxYoQ3iLXnNME6z
         /Bbw==
X-Gm-Message-State: AOAM532xGWf5qTnaLAa6ifVe8BJuPv5rJ+qg6A0Ab7eWIEagy1Xi1Nvi
        jP4f4naUrRLDYdN/tHQSpEqpwC1znX61ag==
X-Google-Smtp-Source: ABdhPJylGMAP70aJR5daWrxMcwZMFVOJaKQct5XmvTN1YMRWOCAHKSq05FBDMhz6Lwj9gcfY+Dc4HA==
X-Received: by 2002:a63:fc06:: with SMTP id j6mr3416630pgi.275.1613690628489;
        Thu, 18 Feb 2021 15:23:48 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b34sm3560931pgl.63.2021.02.18.15.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 15:23:48 -0800 (PST)
Subject: Re: [PATCH] percpu_counter: increase batch count
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0bf90e07-8758-b238-b3f3-a330725a1134@kernel.dk>
 <20210218151644.df430e4f77f763b7db2a004f@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <919b3aa5-7332-0817-3b70-4f20ae6410a8@kernel.dk>
Date:   Thu, 18 Feb 2021 16:23:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210218151644.df430e4f77f763b7db2a004f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 4:16 PM, Andrew Morton wrote:
> On Thu, 18 Feb 2021 14:36:31 -0700 Jens Axboe <axboe@kernel.dk> wrote:
> 
>> Currently we cap the batch count at max(32, 2*nr_online_cpus), which these
>> days is kind of silly as systems have gotten much bigger than in 2009 when
>> this heuristic was introduced.
>>
>> Bump it to capping it at 256 instead. This has a noticeable improvement
>> for certain io_uring workloads, as io_uring tracks per-task inflight count
>> using percpu counters.
>>
> 
> It will also make percpu_counter_read() and
> percpu_counter_read_positive() more inaccurate than at present.  Any
> effects from this will take a while to discover.

It will, but the value of 32 is very low, especially when you are potentially
doing millions of these per second. So I do think it should track the times
a bit.

> But yes, worth trying - I'll add it to the post-rc1 pile.

Thanks!

-- 
Jens Axboe

