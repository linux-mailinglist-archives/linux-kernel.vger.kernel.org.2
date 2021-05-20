Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF838AE80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbhETMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240307AbhETMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621514293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H2EoGPNNHek5LA/HaoBsDmWfJRldrDqmUuCzE8A0ctw=;
        b=H3YA8T0VUyESiBigdLS4ghZdyCIJ9Tp9AiS27WgsBLzDeN97aD31yriaL6ttPa9DOIOHeF
        OwO9o1CpimNiLOSp9zuW3fFV48Sv3iI5+xSWuwziu4WNkxBw8D4fQHWyYk55Olmb3elHB3
        G4lbDp/BbkHetCeNTbD3n7WE4NymJFk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-bSZ8vDK5MSWD2RfiHo3vyQ-1; Thu, 20 May 2021 08:38:12 -0400
X-MC-Unique: bSZ8vDK5MSWD2RfiHo3vyQ-1
Received: by mail-ej1-f71.google.com with SMTP id dr20-20020a1709077214b02903db77503922so1313261ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H2EoGPNNHek5LA/HaoBsDmWfJRldrDqmUuCzE8A0ctw=;
        b=Yn4RjP8dK/vWnA91OxyCeE4RA3hogQMTs+chEALbpFWcJdYjqqvtDJyoAS7S/XUq4d
         WC7S5Kx00tEv/Ab2vfnaMnXHsrfZzIY9wfPi5ooXre8RczW+TRLTWsR/umEKzxWtjAfb
         XBdGlXjn0pTgOg2rRrCQdpFNECFlFBPe7RTmwj9x6bYDdMi5gpfYx9a4ZsxYr1+aqPxO
         sc1csI5nm6rbAW6Ot4yttaRkATs2w2R+VcC6A0naEi12qbG9W8A6uwoX8XvPHS6LDr6p
         M+O5FtUPorccqAwMKcuoYu92xOFr4qGcy5QtEzHGF7DVpG/FgBcjlREDcq0yLcMpYuW8
         pebg==
X-Gm-Message-State: AOAM533Fs8htjwKOy2InCRyF2r+NhgPbhe4NZNST5MINPJrr7Kros6vr
        fRrTMWYkWuQPJdcnYkYLnDhV/Z7hHws4jLkgJ3NiojzCkr99ye9yutpd1ykepN/gJAsyl2uczGR
        ewVCCK6fGCKKhpSDaIe9mxb6A
X-Received: by 2002:a50:bae6:: with SMTP id x93mr4839701ede.48.1621514290946;
        Thu, 20 May 2021 05:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAZeB/EOTP1dDTwMk1xnI0rDau9TReXYikgiANp8pL0KOwU4KheOhp2p+q8xNWGxoGgMckLg==
X-Received: by 2002:a50:bae6:: with SMTP id x93mr4839685ede.48.1621514290778;
        Thu, 20 May 2021 05:38:10 -0700 (PDT)
Received: from localhost.localdomain ([151.29.18.58])
        by smtp.gmail.com with ESMTPSA id bw26sm1321519ejb.119.2021.05.20.05.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:38:10 -0700 (PDT)
Date:   Thu, 20 May 2021 14:38:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKZYMKg8PPkwzJXm@localhost.localdomain>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org>
 <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKY7FvFeRlXVjcaA@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/21 10:33, Quentin Perret wrote:
> On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> > Ok, thanks for the insight. In which case, I'll go with what we discussed:
> > require admission control to be disabled for sched_setattr() but allow
> > execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> > is probably similar to CPU hotplug?).
> 
> Still not sure that we can let execve go through ... It will break AC
> all the same, so it should probably fail as well if AC is on IMO
> 

Yeah, this was my thinking as well.

