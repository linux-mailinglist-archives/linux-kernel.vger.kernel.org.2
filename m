Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A083DF129
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhHCPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236560AbhHCPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628003588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8o/rTzc0DME9LTFVeKGiKPTiuRdLkYaFEUGmBMvMmU=;
        b=Op3I2jBedg2mPflOu93mS9NdQHvnNMk/mRv7zLavzkyj1IfrKLxm7Cqe0UOWMwKqpfd2kR
        nOPK9RPFQbvlVHkz5aT5tqV6X+MOpjmOBAAnj5pr/3Dwe8shyxjXgvwdlQOYiGhVoZX5Lh
        xGVx1JQVlGVH9O63lF0HJr11qccUomc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-TtDpyaDwMRuh-8r_--8V8w-1; Tue, 03 Aug 2021 11:13:05 -0400
X-MC-Unique: TtDpyaDwMRuh-8r_--8V8w-1
Received: by mail-wm1-f72.google.com with SMTP id l19-20020a05600c4f13b029025b036c91c6so1787092wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=i8o/rTzc0DME9LTFVeKGiKPTiuRdLkYaFEUGmBMvMmU=;
        b=BRaLlFKdlRx7dkutUeMlwRjvePXwXba3aziluudoPBFH4nrHZr8wNXERhZyk21nNeG
         9U8V7BW/Mh8n8opBu6j5AZXcUoNablAZTN37sEPDDjksunT/LZAydAvpszWeNJGiJyWd
         Z2U/HgLmg+QKxnI3dFLxPGYe5bP/4mNR5WZfqf6hRuE9RTKmyM7Cvmr0pkg2RnedFyBh
         //wKmFg1cebojWOza48IOu9uB2HwltFplPOulV2DragjFAp/igLy2XykHRFVYssCgM2A
         wfWj1WXE4bh7JFQVujZL3h+/IKRKiWJQUKcaODKMptGdv1xOqIfhQW/U+IKLd8gDbSHA
         uOag==
X-Gm-Message-State: AOAM531GsYDR9bg7o4/6q5t1qDLcpHARLgdbIa8c/9k3mY0zOicK3vTZ
        saCOB/vHp1pJit+W3XM5t3f1W6pi6FPE8z3utUEPx1vhOuJsDjSd9zXEjmiU3jFNsQYkNVkZFao
        M/jiRTZSwDESNXlJsw+FQnyiC
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr23930710wrw.161.1628003584408;
        Tue, 03 Aug 2021 08:13:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS2rNMZWSu7ANts7U1FGd3xS+gZGU6tQGrym4HqL9NbEFgx7R7vWP/3NoyfiaoV7MDsN94NQ==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr23930691wrw.161.1628003584250;
        Tue, 03 Aug 2021 08:13:04 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id j1sm15387645wrm.86.2021.08.03.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:13:03 -0700 (PDT)
Message-ID: <62a66a5744b28dfea6ff2aec4e02ca0978914819.camel@redhat.com>
Subject: Re: [patch 2/4] task isolation: sync vmstats on return to userspace
From:   nsaenzju@redhat.com
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Date:   Tue, 03 Aug 2021 17:13:03 +0200
In-Reply-To: <20210730202010.270885685@fuller.cnet>
References: <20210730201827.269106165@fuller.cnet>
         <20210730202010.270885685@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-30 at 17:18 -0300, Marcelo Tosatti wrote:
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
> 
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
> 
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.
> 
> To fix this, use the task isolation prctl interface to quiesce 
> deferred actions when returning to userspace.

Even though this is mostly targeted at nohz_full users, I believe I haven't
seen anything in this series that forces the feature to be run on nohz_full
CPUs (this is a good thing IMO). So, I'd suggest to reword the patch
description so it doesn't imply nohz_full is necessary to use this.

-- 
Nicolás Sáenz

