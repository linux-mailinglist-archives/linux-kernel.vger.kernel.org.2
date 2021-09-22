Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB3414409
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhIVIsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233792AbhIVIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632300431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzE7ct7TcGCXm8mUaKMPJj+IqZtEjSH8Rgo1FH7r3qU=;
        b=GUIv44KFY15m3ro+OgNSbeL+dJiO2sUGUSy2+OAJ7LfwrsgZYHpKcE2sKtVOD9Q3eqZtwF
        jeKAz5AkPj924kbNHEhjdSJeIjxw86xKjK5zfpOdu7/9OKa2uZavoLkLbVCsbaNL/eBuZn
        zvV1GglgG5YlB6T+J+eav9y2bolKGR4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-HFxEIHToPZyX5J659XmYWA-1; Wed, 22 Sep 2021 04:47:10 -0400
X-MC-Unique: HFxEIHToPZyX5J659XmYWA-1
Received: by mail-wr1-f69.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso1436713wra.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RzE7ct7TcGCXm8mUaKMPJj+IqZtEjSH8Rgo1FH7r3qU=;
        b=ZD6GSYTTTqyHwnCh5kDCA/n3/V1did+oTcgAWushK2n9irn9q6QMd9gMsP0tkX9fhh
         oHynV39yDJkT91vAippvBgD+UuCddojM3ECWcsWryiml9QO9NrfJ884eFb246jpUJKq6
         jLQLnj7qK9FXa/tlhxGBBMqKXSOL7KWeXLB8sdSbMtcC51CzNJ6OkMCzMe1P/+Sfg1dA
         5mK/XI1P9Lc2iqR6xGMUw5M040VlMg352srDbsD3/x0cFLRAPlXT4l+oEFtaHKJLemoa
         ArfEGIjnEBaOqsXI+h5GGzik6hY2y8fatSXY61+p6r0qBDhdKgR1i9avGwmETRhCjCJG
         by6Q==
X-Gm-Message-State: AOAM533UTVFX7qvO6SABNUHHy9LJxf2vt6BZ+ieHBFpxMu8Vg2UfXQic
        qoI5EPwiFCFPIDpxiwQeicIaGfpv4QIsQKdSTc9eskz26TtPox4pA9ULvd8rsIgy+t6r+kdgDen
        yTQdkIdNTVuWZJoqwC+LSJ6oD
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr3180747wmi.114.1632300428758;
        Wed, 22 Sep 2021 01:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWyFTZqMVTFCG4e3JArxU0wOw41T1HqTgwLv6yHZRJpHA8FeYLz93DWE/1ppRavCbpJORW0g==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr3180710wmi.114.1632300428502;
        Wed, 22 Sep 2021 01:47:08 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123? ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id r27sm1464087wrr.70.2021.09.22.01.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 01:47:08 -0700 (PDT)
Message-ID: <0ec733daf2daaf8a6f5b1fbf56676b9892d5bf73.camel@redhat.com>
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
Date:   Wed, 22 Sep 2021 10:47:07 +0200
In-Reply-To: <20210921220358.GN4323@worktop.programming.kicks-ass.net>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
         <20210921161323.607817-3-nsaenzju@redhat.com>
         <20210921220358.GN4323@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 00:03 +0200, Peter Zijlstra wrote:
> On Tue, Sep 21, 2021 at 06:13:20PM +0200, Nicolas Saenz Julienne wrote:
> > +static inline void lru_cache_lock(struct lru_cache_locks *locks)
> > +{
> > +	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
> > +		/* Avoid migration between this_cpu_ptr() and spin_lock() */
> > +		migrate_disable();
> > +		spin_lock(this_cpu_ptr(&locks->spin));
> > +	} else {
> > +		local_lock(&locks->local);
> > +	}
> > +}
> 
> > +static inline void lru_cache_unlock(struct lru_cache_locks *locks)
> > +{
> > +	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
> > +		spin_unlock(this_cpu_ptr(&locks->spin));
> > +		migrate_enable();
> > +	} else {
> > +		local_unlock(&locks->local);
> > +	}
> > +}
> 
> *why* use migrate_disable(), that's horrible!

I was trying to be mindful of RT. They don't appreciate people taking spinlocks
just after having disabled preemption.

I think getting local_lock(&locks->local) is my only option then. But it adds
an extra redundant spinlock in the RT+NOHZ_FULL case.

-- 
Nicolás Sáenz

