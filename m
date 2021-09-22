Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF13414816
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhIVLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235730AbhIVLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632310995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5n+PJJpfTukBRlRBxGVs9WKo8MC+YhuW/pImDRLgI4I=;
        b=T5DdL6Y/oLq5TJMROmQn8cGBaq3UgV0yV/ihdYXBfaOq8L+Nol3qC2VayO6Vtl38FXRywr
        MRFMJxB3/SwOFx+ptfzi6y1wgheyYUwyurHh+ZPsqgmTY0IrizAzv7Ag5aNO/9gs9JVZT2
        WEQBzHFqkwU/OQXp9j+Li6zYxJkye2E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371--dxr9HukNnWChM0c6VLbgw-1; Wed, 22 Sep 2021 07:43:14 -0400
X-MC-Unique: -dxr9HukNnWChM0c6VLbgw-1
Received: by mail-wr1-f70.google.com with SMTP id j16-20020adfa550000000b0016012acc443so1873058wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5n+PJJpfTukBRlRBxGVs9WKo8MC+YhuW/pImDRLgI4I=;
        b=cPBmGtxVtz+FMNNTEqslybGV7wowPS5f9N8HhC4Qtcy0m80IeCvnhq9CYZDJGZy5dT
         ZiW7eQvMxKv8syX7lzWh9muwt2yEN6Le5Z1a/0ZeolwOGqlm2UkFJ0fevNcDhwHxQsFS
         ChLPjn9fXRopqxrxOM9k8j2E0Znu4hBUowvo0+w3uDgEFAw80nzXQiXlQdH+HOuc6HpP
         EqIh09EZ0h6YN/7NxRg8gSB7UmbLhM9BTRJ210vmUIGFW3E9pP/hc1mQKjzy92dAdHZS
         U3jMwspBHp6yvqOfyd+7siXyxdMOGrQtZ8Rt2pvIkTpbN4ZtoLhmBJmHRQo62jEk7WpI
         9PrQ==
X-Gm-Message-State: AOAM531zC4MQpNGulp2SumHDmM16GVNR0sJ+kFzt7IG70bb6DfXKxkVM
        hxh6Zs2lBjnh2e69+qLDK8OqmPTbQXr4Uym1skRn5tucGUnE4d/AId6sFwRc8ZInT4ZMt/MySfr
        ZKHlZC5nnxwQEwxxmUG1efnE7
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr40582780wrx.134.1632310992857;
        Wed, 22 Sep 2021 04:43:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaLJd1RGo11rnmuA15w9wZ7IbiFzTULiRw8v3kf/DAmp1sfLo/eRLf2Yp2zODBAbsQBhltvw==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr40582760wrx.134.1632310992664;
        Wed, 22 Sep 2021 04:43:12 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123? ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id 135sm5969068wma.32.2021.09.22.04.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:43:12 -0700 (PDT)
Message-ID: <db7192d474c09c17843c9fed41baeee67bc7a420.camel@redhat.com>
Subject: Re: [PATCH 2/6] mm/swap: Introduce alternative per-cpu LRU cache
 locking
From:   nsaenzju@redhat.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, juri.lelli@redhat.com,
        mingo@redhat.com, mtosatti@redhat.com, nilal@redhat.com,
        mgorman@suse.de, ppandit@redhat.com, williams@redhat.com,
        bigeasy@linutronix.de, anna-maria@linutronix.de,
        linux-rt-users@vger.kernel.org
Date:   Wed, 22 Sep 2021 13:43:11 +0200
In-Reply-To: <20210922113736.GP4323@worktop.programming.kicks-ass.net>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
         <20210921161323.607817-3-nsaenzju@redhat.com>
         <20210921220358.GN4323@worktop.programming.kicks-ass.net>
         <0ec733daf2daaf8a6f5b1fbf56676b9892d5bf73.camel@redhat.com>
         <20210922113736.GP4323@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 13:37 +0200, Peter Zijlstra wrote:
> On Wed, Sep 22, 2021 at 10:47:07AM +0200, nsaenzju@redhat.com wrote:
> > On Wed, 2021-09-22 at 00:03 +0200, Peter Zijlstra wrote:
> > > On Tue, Sep 21, 2021 at 06:13:20PM +0200, Nicolas Saenz Julienne wrote:
> > > > +static inline void lru_cache_lock(struct lru_cache_locks *locks)
> > > > +{
> > > > +	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
> > > > +		/* Avoid migration between this_cpu_ptr() and spin_lock() */
> > > > +		migrate_disable();
> > > > +		spin_lock(this_cpu_ptr(&locks->spin));
> > > > +	} else {
> > > > +		local_lock(&locks->local);
> > > > +	}
> > > > +}
> > > 
> > > > +static inline void lru_cache_unlock(struct lru_cache_locks *locks)
> > > > +{
> > > > +	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
> > > > +		spin_unlock(this_cpu_ptr(&locks->spin));
> > > > +		migrate_enable();
> > > > +	} else {
> > > > +		local_unlock(&locks->local);
> > > > +	}
> > > > +}
> > > 
> > > *why* use migrate_disable(), that's horrible!
> > 
> > I was trying to be mindful of RT. They don't appreciate people taking spinlocks
> > just after having disabled preemption.
> > 
> > I think getting local_lock(&locks->local) is my only option then. But it adds
> > an extra redundant spinlock in the RT+NOHZ_FULL case.
> 
> That doesn't make it less horrible. The fundamental problem you seem to
> have is that you have to do the this_cpu thing multiple times.
> 
> If instead you make sure to only ever do the per-cpu deref *once* and
> then make sure you use the same lru_rotate.pvec as you used
> lru_rotate.locks, it all works out much nicer.
> 
> Then you can write things like:
> 
> 	struct lru_rotate *lr = raw_cpu_ptr(&lru_rotate);
> 
> 	frob_lock(&lr->locks);
> 	frob_pvec(&lr->pvec);
> 	frob_unlock(&lr->locks);
> 
> and it all no longer matters if you got this or that CPU's instance.
> 
> After all, you no longer rely on per-cpu ness for serialization but the
> lock.

Thanks, understood. I'll look into it.

-- 
Nicolás Sáenz

