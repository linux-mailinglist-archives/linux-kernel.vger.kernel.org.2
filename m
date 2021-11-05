Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383604467A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhKERRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhKERRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:17:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06676C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:14:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o29so3821515wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zv3ABwnUWd2T/SHLWRu++05oJKCkYNE3n6fh4ULeSmw=;
        b=idSHuTwy4Uk7mPYTHSQxC+MiMEzIGIndfKskDrMAbruy3ClegQCNDa6l+DvIzbSICq
         p9a6kWPhVxaq4SvJK/8s0qDRe50CuuvcxxC5JABmP6FugBm3KdVbvLsTpJhC0guxJ1LX
         ZcHXL5f09/B31OEbqyALl7J5723cuzTbyHDlV+tMJMdse6anL/RNzlVgoQ12ASpIcxGW
         fDLcj10IviIxiUUvovQEpYLfWY2CPRNJ9EMt+46+ZsszChUn9hWEQ894uHm28O6uSw2O
         ezez9Srcepu+I0F7QolDv9QH26K7HH607YLlki2Vgz/ziiDPLHp/ReGk23DF8jCp0S3I
         yeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zv3ABwnUWd2T/SHLWRu++05oJKCkYNE3n6fh4ULeSmw=;
        b=QMY/oPj0hrvI+caPMsEsVAHjl0JkbIujSJOsEF0iVJXstQh9M05u9fj2+fe3JCJQ11
         4m0kf7qonyQncjuEFEqvTbtR5ihzFOuC8cVFPQSyrC6jROreqEFgr3wsCqj9Ix6Pz+9W
         SM+nrLV6kThvDjgTmLBXNcUlEis2B3+CFnkAuIQXcQqkzSsDo6vUJpj2t/P77BREMgZT
         3PeDAHrAJzgnXyB9YTeVeA7u60zfje/Qzl+qAhtBDyCO0dOrmHDD4p3FgXudsarT4wUz
         va1jojI+hu9bo35ofu8i/ggO16x1rf/sAXslGOKyb/h0dJNeW7RnJlgkh+qc6RbbumA1
         +lBA==
X-Gm-Message-State: AOAM531WbIQFTVyR95LVG6TwcyjV8QjobPBHB+N7UiC84JKKIyYoflQR
        4cq9JHmdS2ihvru1fyAFFRzvqA==
X-Google-Smtp-Source: ABdhPJwl9lJ17OoBtFWDvNaVdLhq+ue5nx2Z0aiGSyfReQQwWbzK0CKtIrinFtL6ZTYo04tLhs4Ryg==
X-Received: by 2002:a05:600c:1d28:: with SMTP id l40mr4257963wms.192.1636132474580;
        Fri, 05 Nov 2021 10:14:34 -0700 (PDT)
Received: from ?IPv6:2003:f6:af04:5300:7c00:c62b:b3aa:158b? (p200300f6af0453007c00c62bb3aa158b.dip0.t-ipconnect.de. [2003:f6:af04:5300:7c00:c62b:b3aa:158b])
        by smtp.gmail.com with ESMTPSA id m36sm8529706wms.25.2021.11.05.10.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 10:14:34 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net>
 <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
 <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
 <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
 <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
 <20211105162914.215420-1-minipli@grsecurity.net>
 <YYVim5qpteqfwYjx@hirez.programming.kicks-ass.net>
From:   Mathias Krause <minipli@grsecurity.net>
Message-ID: <a113044b-b5b6-8bc1-864b-c817535889ff@grsecurity.net>
Date:   Fri, 5 Nov 2021 18:14:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYVim5qpteqfwYjx@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.11.21 um 17:58 schrieb Peter Zijlstra:
> On Fri, Nov 05, 2021 at 05:29:14PM +0100, Mathias Krause wrote:
>>> Looks like it needs to be the kfree_rcu() one in this case. I'll prepare
>>> a patch.
>>
>> Testing the below patch right now. Looking good so far. Will prepare a
>> proper patch later, if we all can agree that this covers all cases.
>>
>> But the basic idea is to defer the kfree()'s to after the next RCU GP,
>> which also means we need to free the tg object itself later. Slightly
>> ugly. :/
> 
> Can't we add an rcu_head to struct task_group and simply call_rcu() the
> thing with a free function?

There is already one and this patch makes use of it for the second RCU
GP requirement. Basically, the patch is doing what you request, no? See
the new free_fair_sched_group().

Thanks,
Mathias
