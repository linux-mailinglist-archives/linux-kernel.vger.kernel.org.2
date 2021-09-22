Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31450414587
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhIVJvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234381AbhIVJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632304211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWU7csjt4Np/ai++4aBlLIWralnkqY/1oQmbIHwv+NI=;
        b=d5dMTWoT1IsIoBa24qiJLrxRzYkmxqb7a64hxf2Orokpg0+hoOeDF7bDTVUoZC1S15ta36
        +HbKalklo/7rrMD4gmyyo0ri8PQJlAgwaNOevmN/RHRueJ1RK58m3M8dk+fwtsChnVJW+r
        L5WTax272SeW6QvavDFDErpm+83AX8k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-fYT69TeDNiy5TWbbBeyZxA-1; Wed, 22 Sep 2021 05:50:10 -0400
X-MC-Unique: fYT69TeDNiy5TWbbBeyZxA-1
Received: by mail-wr1-f71.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so1600644wrq.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HWU7csjt4Np/ai++4aBlLIWralnkqY/1oQmbIHwv+NI=;
        b=4vfZi5WmzqqJNH7sEPTtrpJodb0HCVQZc6xOU1rjFgOHIz78hfibfZXYrqcIe/CaRR
         qqvxgAsQt5zwWTPAsbg8G8B+iCd2JoREGY5YlIhGTUZGxjkdNV7OPjRGKjXbcbOND8ZM
         fMEcs1jtcj0QrCW1E0t7ghrBbjVtTmn0F4tLEYjh4WhUaQMX4M0JKcMnIEukXGIdjjX0
         w9+pa8sgXpERfmC4kxy5yxruvZ2pSHgtk9n15tuAmuE9f/goOZ946RHrXGALcNC9sPIR
         IU45Xl+wFx/+s8vAIbqocPvVdwelTYaFfkvXpnG5hSK7Kys1Ivqs4Q3TFtREspWwXig8
         QkiQ==
X-Gm-Message-State: AOAM533UvbDQKHO7cVlYXaYYQ3BFqAAn0PSeChcMIM7OUH+K9QNG+9Kn
        80XXaIzWw8abEQTxvXL1b1Mkq4bHcjUpcWI6q8XYqAmeN4v9BQS2BEklTOUBu4T/CXkMOi98oxh
        5feiRWAE6tmtd8rO1OCc57UVb
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr38586415wrb.334.1632304208910;
        Wed, 22 Sep 2021 02:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSdlRuz+OyjwzCgzVR2s/BhfvS6G/FdxXQ7YW/wSm+ya8/shGeXeBe0T4XHcZG3G0y6rx1lQ==
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr38586391wrb.334.1632304208701;
        Wed, 22 Sep 2021 02:50:08 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123? ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id f8sm1651573wrx.15.2021.09.22.02.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 02:50:08 -0700 (PDT)
Message-ID: <7c8594d5943f99bc647951269606ae24dd1b37de.camel@redhat.com>
Subject: Re: [PATCH 2/6] mm/swap: Introduce alternative per-cpu LRU cache
 locking
From:   nsaenzju@redhat.com
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, akpm@linux-foundation.org,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, cl@linux.com,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, anna-maria@linutronix.de,
        linux-rt-users@vger.kernel.org
Date:   Wed, 22 Sep 2021 11:50:07 +0200
In-Reply-To: <20210922092039.2j6efnkhmfxuzjnx@linutronix.de>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
         <20210921161323.607817-3-nsaenzju@redhat.com>
         <20210921220358.GN4323@worktop.programming.kicks-ass.net>
         <0ec733daf2daaf8a6f5b1fbf56676b9892d5bf73.camel@redhat.com>
         <20210922092039.2j6efnkhmfxuzjnx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 11:20 +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-22 10:47:07 [+0200], nsaenzju@redhat.com wrote:
> > > *why* use migrate_disable(), that's horrible!
> > 
> > I was trying to be mindful of RT. They don't appreciate people taking spinlocks
> > just after having disabled preemption.
> > 
> > I think getting local_lock(&locks->local) is my only option then. But it adds
> > an extra redundant spinlock in the RT+NOHZ_FULL case.
> 
> spin_lock() does not disable preemption on PREEMPT_RT. You don't
> disables preemption on purpose or did I miss that?

Sorry my message wasn't clear. Adding code for context:

+ static inline void lru_cache_lock(struct lru_cache_locks *locks)
+ {
+ 	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+ 		/* Avoid migration between this_cpu_ptr() and spin_lock() */
+ 		migrate_disable();

IIUC PeterZ would've preferred that I disable preemption here. And what I meant
to explain is that, given the spinlock below, I choose migrate_disable() over
preempt_disable() to cater for RT.

+ 		spin_lock(this_cpu_ptr(&locks->spin));
+ 	} else {


So, to make both worlds happy, I think the only option left is using the
local_lock (at the expense of extra overhead in the RT+NOHZ_FULL case):

+ 	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+ 		/* Local lock avoids migration between this_cpu_ptr() and spin_lock() */
+		local_lock(&locks->local);
+ 		spin_lock(this_cpu_ptr(&locks->spin));
+	} else {

-- 
Nicolás Sáenz

