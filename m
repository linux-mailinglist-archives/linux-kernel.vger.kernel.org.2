Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1797E334A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhCJWBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhCJWAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:00:36 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:00:36 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d20so18635624qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kcd0bDy31qh5vk/DuAdS7h0Lw7mk2GydD6Jd8CupBM4=;
        b=JRF2ee6Bn2RL6aDDY7qJ2K7WrfGIKxyLLQ0UFAiuUxoDr9gRFzMwdNeODtbgGB+HKM
         mP/GqMxJxv8VSXpapfg0AyR2ueyi5gazb64FJqy/8th/WOSgTRRCjX5f45Jfuf2M0M6Y
         tuQ2g3lZFr/UzvVKosmUVf0LyTrGUaqXZbGk5nflVfVqVx1I+Fbv88L3YkRynehJbHy5
         4+AInRzpgR9j9E9lhJnfoogv/9xBYJ1OcvwwFpKzsemJdXvPBwWgGJpZbdMG+7G+srN9
         kBVgS8wRRkI5EvTR4eW0JMBitpMsR8u1s7xE2+xpQAtPituoUqmvm1xd9hYYwcurBF+M
         75WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kcd0bDy31qh5vk/DuAdS7h0Lw7mk2GydD6Jd8CupBM4=;
        b=C9vqhZcOd85INiKTV9zinmkIyqhBciMfR2FX6ca92lomXbriWf1S5UrGCuTm/kbCBB
         VGimdlW7Pwp8IuQNplPxkdrrEtAdE0PEhmsNxNbpjOggC6zuXCq+l3fIKfrdLY0ffKjm
         ucD0r8aZdrnN7S/SQVP6bbSgzsORdFvhzmiGShBviyIvxLnD4kkSyrDrSLgS1Kbu8KST
         9CrsejJNHIkYDRt6BbkYQsWV6G59rUfye9otylEno/W8/+4LFrAkbtFj+6RuZ00S9EM0
         tFJr6CknkjfDdyQBwAV25a+KC/m8JAB/ocJxwYAnLl70CsnR1Dgw06tOAiZ9ki+zOxMm
         hIyg==
X-Gm-Message-State: AOAM5325cAnkMgZN3nUKAdxc8dbFeu01lCyaOwC0n3yHH7Bbl1p+Yq19
        RIyMGoVmD5S4lWrUeedy7IZKU1M6c01AhA==
X-Google-Smtp-Source: ABdhPJzIByDXRkidIC5qrPWkndEwJvvOuJetFWZF6/CJmahU22NM0Qrh1n/cX/xGHeYOLHzyeHOaKw==
X-Received: by 2002:a05:620a:1017:: with SMTP id z23mr5006243qkj.23.1615413635223;
        Wed, 10 Mar 2021 14:00:35 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r7sm423915qtw.17.2021.03.10.14.00.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 10 Mar 2021 14:00:34 -0800 (PST)
Date:   Wed, 10 Mar 2021 14:00:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Singh, Balbir" <bsingharora@gmail.com>
cc:     Michal Hocko <mhocko@suse.com>,
        Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to
 split_page_memcg
In-Reply-To: <d20d5dbe-74cd-fe90-8e43-ebbc5a3b4403@gmail.com>
Message-ID: <alpine.LSU.2.11.2103101353240.1783@eggly.anvils>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com> <20210304074053.65527-2-zhouguanghui1@huawei.com> <3ad50842-881f-eb88-a14d-0b6c70ce33d2@gmail.com> <YEcxqTUp88sl/cq3@dhcp22.suse.cz> <d20d5dbe-74cd-fe90-8e43-ebbc5a3b4403@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021, Singh, Balbir wrote:
> On 9/3/21 7:28 pm, Michal Hocko wrote:
> > On Tue 09-03-21 09:37:29, Balbir Singh wrote:
> >> On 4/3/21 6:40 pm, Zhou Guanghui wrote:
> > [...]
> >>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>  /*
> >>> - * Because page_memcg(head) is not set on compound tails, set it now.
> >>> + * Because page_memcg(head) is not set on tails, set it now.
> >>>   */
> >>> -void mem_cgroup_split_huge_fixup(struct page *head)
> >>> +void split_page_memcg(struct page *head, unsigned int nr)
> >>>  {
> >>
> >> Do we need input validation on nr? Can nr be aribtrary or can we enforce
> >>
> >> VM_BUG_ON(!is_power_of_2(nr));
> > 
> > In practice this will be power of 2 but why should we bother to sanitze
> > that? 
> > 
> 
> Just when DEBUG_VM is enabled to ensure the contract is valid, given that
> nr is now variable, we could end up with subtle bugs unless we can audit
> all callers. Even the power of 2 check does not catch the fact that nr
> is indeed what we expect, but it still checks a large range of invalid
> inputs.

I think you imagine this is something it's not.

"all callers" are __split_huge_page() and split_page() (maybe Matthew
will have a third caller, maybe not).  It is not something drivers will
be calling directly themselves, and it won't ever get EXPORTed to them.

Hugh
