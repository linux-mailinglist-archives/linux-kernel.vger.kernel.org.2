Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C393F8E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhHZSqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhHZSqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:46:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ABEC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:45:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f6so5099363iox.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7HodnaKpdk5YItu/syJf9VsSTM/fNqElFhGR0XHjm+E=;
        b=mW+UR4nfztugFUDZ1TDSsHiQzKxoWiz3D2q43UtkfHlAarwJ8XGYRQjmlMJTzi+OdL
         fKA8Rq+BUNsxJGbXuczGXStXXZF2wlkhFqALwEDzwjUGeDFaNstffhOfUYbwi7SNMmxS
         PTa2ZEm29VoCfJRiQ9IEE6Q6NB/N7b4TAnodskA4GNeKqOuE883QZ37nX93CXDoTi7Iq
         pujCccDCbuABZnvIN2sCWVusyTMaksHTmLQtXQL7gHo/BS44XeWbljRzScJ+dOT8iA6B
         LXTtdsgw9Vjl1FiiuwjUk2OrFw5nJHGTD+n8dxDkXXJSUsSefuIheShgaerAbpeySHRT
         rhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HodnaKpdk5YItu/syJf9VsSTM/fNqElFhGR0XHjm+E=;
        b=g7kPCU5bqjCLI5XuHpAIKBOpCC8L2tEW47u2rUcQB36mECPhDLQPBbfbuDMB41EHbK
         d8aHWsoTFhDhxq3ebrKkGw6Jmep3ln5BQlneZq7xdrVjZ3Pv8Mm9oEn0irBAFs2SVSd9
         Rni/NlyIQC5HhfHGn4LRS1Mikh6uY25C8GQStwiH3Zctufkhl6pYeGu2ECx2kyswXk1R
         kCOJDGFLMB5TG4pKH/Af/Na5m0Ais7fmO/Oq4/6oo9H/RODSQ50yc6vGRATrWXc1yE7P
         TpQIPD0XyFtkBG7Hd4BhodT7o02eaev1DrOofFCvG+BzIKjigYJf5KEsGk6/lfHkhZxz
         JFjA==
X-Gm-Message-State: AOAM532Syx471oagjuGLAzP8KEresbUGds4wZ34wyqyw+uAksce7ME2L
        pfv1HlUFRMJZkSuIkEaby/27/w==
X-Google-Smtp-Source: ABdhPJytciWSIwxDuSzZOwdFxgQ26VZPz9L9xnas77WKoWWgMsyXN1m4GDBGrkOuDfRB+RY8aN+9WA==
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr627068jao.22.1630003557853;
        Thu, 26 Aug 2021 11:45:57 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k21sm1977805ioh.38.2021.08.26.11.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:45:57 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
Message-ID: <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
Date:   Thu, 26 Aug 2021 12:45:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 12:13 PM, Jens Axboe wrote:
> On 8/26/21 12:09 PM, Bart Van Assche wrote:
>> On 8/26/21 7:40 AM, Zhen Lei wrote:
>>> lock protection needs to be added only in dd_finish_request(), which
>>> is unlikely to cause significant performance side effects.
>>
>> Not sure the above is correct. Every new atomic instruction has a
>> measurable performance overhead. But I guess in this case that
>> overhead is smaller than the time needed to sum 128 per-CPU variables.
> 
> perpcu counters only really work, if the summing is not in a hot path,
> or if the summing is just some "not zero" thing instead of a full sum.
> They just don't scale at all for even moderately sized systems.

Ugh it's actually even worse in this case, since you do:

static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)               
{                                                                               
	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);        
}

which ends up iterating possible CPUs _twice_!

Just ran a quick test here, and I go from 3.55M IOPS to 1.23M switching
to deadline, of which 37% of the overhead is from dd_dispatch().

With the posted patch applied, it runs at 2.3M IOPS with mq-deadline,
which is a lot better. This is on my 3970X test box, so 32 cores, 64
threads.

Bart, either we fix this up ASAP and get rid of the percpu counters in
the hot path, or we revert this patch.

-- 
Jens Axboe

