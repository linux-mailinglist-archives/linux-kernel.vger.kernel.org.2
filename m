Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24254458C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhKDRkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhKDRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:40:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8917C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:37:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so4806841wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vEtpeBqc1SfByNyATN14KlpMwjPUoxDoHwS2Nhgjwmg=;
        b=oBe6LORhNOLtguyNABY0deApumjlUDu+3vO5atRBfxYFT5zkNLNTf5urR7WNBB34//
         2IiLPe3iL+7Kw9vvnz7Em3mbFVIt272h0HpABWJyW+eBQ1xzOJ95C+9jSMRpcDezi2Pj
         0PgWmQ+79l8FOnVJ+/CYdNK3mayGJt0wUSWv8rzeKR0qbMmaUEu7WRdJCawAASIyIFDA
         H+AdUiKfWoA+zrDhB5oTbX0MgJ+itaAWhSVZk2nSk6UgBmsKhx2vy6FqQVEvw0Y1M/we
         7IAOn6ZPYc8BO7M+FVECJdDg9cwFry46keuvhdz307N/PHq8qJSaboum4sUgXr2gBPZR
         mA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vEtpeBqc1SfByNyATN14KlpMwjPUoxDoHwS2Nhgjwmg=;
        b=zM+QOuyw1tLucyxiDFSj4S0ZNlIHqyYyULB2weGCYYw0Tm+v6C7k9hWJlcmjUY4EQm
         d+avZQ3xOCmA10cmE8ZGr3aMSyejBY2UnY95O5h8Jz3tGPzGChyF6J8LUvZ+ahreHeeY
         fkWOYRcUaU/f4j3A+c8yPuSfguF03JFbfVgEqdvaLkcKSNh3DfN1x04zOI10QTCgVuiK
         y4E+PecfJu8ebPO+vK3BCo+82yf+s0VEGQHxdZEGouNxYR0euzAs/Q8xd8r74qTmGt8A
         RX6YQ83bTfpxcipDxpB4VhTUVs0tlZPTHjYmSA0o9qAVPZS3mW7qSwOdUq77i3f6pvmQ
         Fs0Q==
X-Gm-Message-State: AOAM530eiQ5fWD5Zj0VB55jOMVG+xrxGGmFxD8cClrN5M4pqzOkFr2JS
        +Rvl3J+Vf7/mB/xGewJCaWv1lQ==
X-Google-Smtp-Source: ABdhPJwqJkaDEw/jgLmcN0KjydEMpm2lKoDDhhb/jCggN3sfOY4KzC9k+H+XdU7/XbMat2jOKhqUOw==
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr25798449wme.127.1636047472459;
        Thu, 04 Nov 2021 10:37:52 -0700 (PDT)
Received: from ?IPv6:2003:f6:af07:3b00:c7c0:ba0:afa0:f76a? (p200300f6af073b00c7c00ba0afa0f76a.dip0.t-ipconnect.de. [2003:f6:af07:3b00:c7c0:ba0:afa0:f76a])
        by smtp.gmail.com with ESMTPSA id p12sm5718243wro.33.2021.11.04.10.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 10:37:52 -0700 (PDT)
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
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
From:   Mathias Krause <minipli@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
Date:   Thu, 4 Nov 2021 18:37:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.11.21 um 17:49 schrieb Vincent Guittot:
> [snip]
> 
> Ok so we must have 2 GPs:
> 
> list_del_rcu(&tg->siblings);
> GP to wait for the end of ongoing walk_tg_tree_from : synchronize_rcu
> in your patch
> list_del_leaf_cfs_rq(tg->cfs_rq[cpu]); if on_list
> remove_entity_load_avg(tg->se[cpu]);
> GP to wait for the end of ongoing for_each_leaf_cfs_rq_safe (print_cfs_stats)
> kfree everything

Basically yes, but with my patch we already have these two, as there's
at least one RCU GP between after sched_offline_group() finishes and
sched_free_group() / cpu_cgroup_css_free() starts.

So we either use my patch as-is or move unregister_fair_sched_group() to
free_fair_sched_group() and use kfree_rcu() instead of kfree(). Both
approaches have pros and cons.

Pro for my version is the early unlinking of cfs_rq's for dead task
groups, so no surprises later on. Con is the explicit synchronize_rcu().

Pro for the kfree_rcu() approach is the lack of the explicit
synchronize_rcu() call, so no explicit blocking operation. Con is that
we have cfs_rq's re-added to dead task groups which feels wrong and need
to find a suitable member to overlap with the rcu_head in each involved
data type.

Which one do you prefer?

Thanks,
Mathias
