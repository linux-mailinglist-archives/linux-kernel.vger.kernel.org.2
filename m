Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE13B1A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhFWMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFWMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:40:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB979C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:37:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g14so1911172qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYY3t3SZgKirD6WxlYWUH57bb/cmzEpXCDfMeGqIxB0=;
        b=jRPAywv++23eP8EZrfe64KwnWB0RZH6bmg/TiQrpelroLBrMV2AUKaOgRhX38drGH4
         eIo8hnx5oAzmdNlOTHGIenSigaQTr51XyV0HOtc9Rb3Hr2oUzl0dZTUm40pGDkJ+f4hq
         osfpXkQ14Nv5GPBvKlp6SRMpKb8BeRHNgoOUhBj6jEYtfO9RdP1xXTweQAVtaCOdEvZz
         knFxk0nDKOdKbXSpfbejNi/LJC7NWs4OQXX2nMrFfvnNexVyfgiNJvJDdhA/IOxoebCA
         jBiWMB2N+CYhXqGcoRB1h7rMPpMCXf5UN8BDlcTSbU4CPIz6AqCTyci8dzA8uEwVUBtb
         ZULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYY3t3SZgKirD6WxlYWUH57bb/cmzEpXCDfMeGqIxB0=;
        b=cQrWjgB0dLlbip0PJzTKpYNkRPB6HywiZemp25eBmqYE3XmLV1szkbCIdpr+P+vE0A
         jlhMPSsLC47mZjI++Y4rUslGuiu3yMIrhV1C8gyP8vZvO1oo5vWIEC2Htf1G1X1I2tOG
         mY2ui+9nHTaTBa3+ZMxAb9fAKK0A+h9bQNpw0hEBA+F6rJeHt71trHpykJlrtSBnjT0o
         Iw1HEOOQa/EswnJGCKvhoPHLxLSwMYovQhxubWnWG3YSPHWlzSP3S4sC3mLhWlkbK5nE
         Euy4RcVfyE+hn379cVEscsjIXVFlT8EIMyvWDQVFbKbEa3PN6xMPW6dpQ7K1hsbPXObB
         IW2w==
X-Gm-Message-State: AOAM530tv6D6k7XfgWoe/1K68nljU7vFMrW30cdBEnN0DuvVS/fIjzYz
        XXk0LsMHt9QDxXQfazOtUin+NhAy8QDOmxSkKpdgGA==
X-Google-Smtp-Source: ABdhPJzHiVxHtJBXIV2e3WuOFpZtkhGeX9maJOCWyu6LgNeVZDMhh8BAS/Kk7GKlMKaMboAmWuLe99C+qzcmVc3muyk=
X-Received: by 2002:a05:622a:15c1:: with SMTP id d1mr3823991qty.138.1624451870847;
 Wed, 23 Jun 2021 05:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.vnet.ibm.com>
 <CAKfTPtDrHv4OOfPvwOE2DMNoucXQJ=yvvEpTVKrXghSdKEnZcA@mail.gmail.com>
 <20210622143154.GA804@vingu-book> <53968DDE-9E93-4CB4-B5E4-526230B6E154@linux.vnet.ibm.com>
 <20210623071935.GA29143@vingu-book> <CCB4222F-000A-44E8-8D61-F69893704688@linux.vnet.ibm.com>
 <6C676AB3-5D06-471A-8715-60AABEBBE392@linux.vnet.ibm.com> <20210623120835.GB29143@vingu-book>
 <CAFpoUr01xb9ZJF9mb2nmZDpUHXFH3VSbY3AU8-1owV-_7wVTPg@mail.gmail.com> <CAKfTPtB++3y4VnbKE_n=bgsqCfqXuF0KUsdB_cFhi9xAnMRubw@mail.gmail.com>
In-Reply-To: <CAKfTPtB++3y4VnbKE_n=bgsqCfqXuF0KUsdB_cFhi9xAnMRubw@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Wed, 23 Jun 2021 14:37:14 +0200
Message-ID: <CAFpoUr3bHzrwvumw6R=2JVbKa_wmtT9cMf-mdDHxY0Png-N9Jw@mail.gmail.com>
Subject: Re: [powerpc][next-20210621] WARNING at kernel/sched/fair.c:3277
 during boot
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ons. 23. jun. 2021 kl. 14:22 skrev Vincent Guittot <vincent.guittot@linaro.org>:
>
> In theory it should not because _sum should be always larger or equal
> to _avg * divider. Otherwise, it means that we have something wrong
> somewhere else

Yeah, that might be the case. Still trying to wrap my head around
this. I might be wrong, but isn't there a possibility
that avg->period_contrib is increasing in PELTs accumulate_sum,
without _sum is increasing. This makes the pelt divider increase,
making the statement "_sum should be always larger or equal to _avg *"
false? Or am I missing something obvious here?

Still unable to reproduce what Sachin is reporting tho.

Odin
