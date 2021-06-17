Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9727A3AA8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhFQBjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhFQBjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:39:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1EFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 18:37:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g22so3608098pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Nbl87QZp4G8A2CDe/cUWud1I+sN33vpXEyaZOU+NVnU=;
        b=rOSk7N6LOygZBNwvYUgPnrbQZvNmdImxd6J+evzqzPUPfw9tk+U3VqpfIViOP9GhhV
         4wJ4ufIclF2zMB3wvtpuzNnq4HrrOjZqvrecMj9kfkWeq7tOCsuCX6SURe5qAU75dDXF
         2p/ZXy+AZ+pkTFc8/cxZw9mTEnFPQuYWzFv9WJLq3EutJKMoi0qvT1oY/sW1Dt2hEtXJ
         Yz/ZJPFBHtWBIUNMbW3a/OTFsOWa+9u+s9e+3NX9WwC7Q0MAuf6yTRtZCxhusnVbei5g
         2hga2+XqdWeNemECkshqVW+TgP+vOGEIUap/zwGeWHutl1vzZPcDOA2Xk+UtOFfRLTf7
         q6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Nbl87QZp4G8A2CDe/cUWud1I+sN33vpXEyaZOU+NVnU=;
        b=DXv6EHQzwrFZVP6BxUIpsCDpbbtKgJWF2mPxZgPFd1UUpX6TMZ+9OrEPsAcd1VU186
         b4QHmUsVHS9QHdgwO4YXz92ygqEXe+XaUH4El0DdcRdfWO1GTm6r7+hJ6I39AbRy75i4
         hd56qqM95YBQ/X+zBPvaxb7ck7hY4KcKqCbWXyUL1eBNHzxJFV+mueY0uAs3DlTHzmpi
         LhHWX/r5T2e+l/zXjjmrhufD8gRMmyNpwmjcY8ehkkGtNvuu12DOryb4pCVPO1zCgqwN
         o5s2HHiXFTjuydzFcz5C6dkN/taBcMNydp8j1HaKmWWtNTT8Fi+oPaU1GIgCSgHWQ27X
         AN6A==
X-Gm-Message-State: AOAM532FodQIR+82Tvu2Xtg0lyCyfyDsWtHftzS3A8rc9EPjrODGNcGK
        ClPh6Q/1exLuZQM5I+ReZWI=
X-Google-Smtp-Source: ABdhPJwWixdjAyQzzO+A6MibZh7XlTuuirIW5NpTWbf8VvQYk/vcWCN6PVqngVXurXBetngNVHpigA==
X-Received: by 2002:a63:4653:: with SMTP id v19mr2557630pgk.240.1623893853436;
        Wed, 16 Jun 2021 18:37:33 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id r135sm3310612pfc.184.2021.06.16.18.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 18:37:33 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:37:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
To:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org
References: <cover.1623813516.git.luto@kernel.org>
        <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
        <1623816595.myt8wbkcar.astroid@bobo.none>
        <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
        <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
In-Reply-To: <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
MIME-Version: 1.0
Message-Id: <1623893358.bbty474jyy.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 17, 2021 4:41 am:
> On 6/16/21 12:35 AM, Peter Zijlstra wrote:
>> On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
>>> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
>>>> membarrier() needs a barrier after any CPU changes mm.  There is curre=
ntly
>>>> a comment explaining why this barrier probably exists in all cases.  T=
his
>>>> is very fragile -- any change to the relevant parts of the scheduler
>>>> might get rid of these barriers, and it's not really clear to me that
>>>> the barrier actually exists in all necessary cases.
>>>
>>> The comments and barriers in the mmdrop() hunks? I don't see what is=20
>>> fragile or maybe-buggy about this. The barrier definitely exists.
>>>
>>> And any change can change anything, that doesn't make it fragile. My
>>> lazy tlb refcounting change avoids the mmdrop in some cases, but it
>>> replaces it with smp_mb for example.
>>=20
>> I'm with Nick again, on this. You're adding extra barriers for no
>> discernible reason, that's not generally encouraged, seeing how extra
>> barriers is extra slow.
>>=20
>> Both mmdrop() itself, as well as the callsite have comments saying how
>> membarrier relies on the implied barrier, what's fragile about that?
>>=20
>=20
> My real motivation is that mmgrab() and mmdrop() don't actually need to
> be full barriers.  The current implementation has them being full
> barriers, and the current implementation is quite slow.  So let's try
> that commit message again:
>=20
> membarrier() needs a barrier after any CPU changes mm.  There is currentl=
y
> a comment explaining why this barrier probably exists in all cases. The
> logic is based on ensuring that the barrier exists on every control flow
> path through the scheduler.  It also relies on mmgrab() and mmdrop() bein=
g
> full barriers.
>=20
> mmgrab() and mmdrop() would be better if they were not full barriers.  As=
 a
> trivial optimization, mmgrab() could use a relaxed atomic and mmdrop()
> could use a release on architectures that have these operations.

I'm not against the idea, I've looked at something similar before (not
for mmdrop but a different primitive). Also my lazy tlb shootdown series=20
could possibly take advantage of this, I might cherry pick it and test=20
performance :)

I don't think it belongs in this series though. Should go together with
something that takes advantage of it.

Thanks,
Nick
