Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34EF3B0B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhFVRfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231572AbhFVRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624383205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fprW9and+W4ZesgQO5v/nl41G796IELnfkI2rFtS/Gw=;
        b=CE4y9crAyzrdrLW9yhwhONvwNwRbvoqfuHy6sU392JzjfFaEJQ1cDdTSbTvrphYiJlh7Sg
        kbFw98WSLAAOzmXkUW/OGSVOZqbiARuFrEZ4zdgNYk4ivT4FjDP8LPRuFxAVmmqPHm01nK
        O1l8xDkDvmIfgQM1ekzzgl77XqUkHyc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-RBUTUrtYNc2iZKPafJtGDQ-1; Tue, 22 Jun 2021 13:33:24 -0400
X-MC-Unique: RBUTUrtYNc2iZKPafJtGDQ-1
Received: by mail-wr1-f72.google.com with SMTP id e9-20020a5d6d090000b0290119e91be97dso10039222wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fprW9and+W4ZesgQO5v/nl41G796IELnfkI2rFtS/Gw=;
        b=Wn3TfcqHNMRvVevLmAxoJukdc6c+UCNQdxmhYC73/G6cbFPHnXV/qR+hu7/agH6blF
         XRfQZT1Z2qIvil/f3BGwBJQhksV/dXkTvl1/e1Zazmbi5pzqYOUFA6XUm1erJUKsQ2cd
         zfO6WTFk9Ik4Fb7bRLjp6YsuYYv+m8GxfInH6i9kbZycr7u9nGzWB2FiEY2sOg7L5+4x
         iZB9mCTttkXzJfZO7hyC5GUoMruIaHPY2ihco8sDD+l0we/Y3/FbC8krsarrX72YWc+a
         vaI+inz3qmivYRsUkQbkziYw5cEi79mssfcfHD5HDl9KjSQIPTWWTdVGAZBchdD/4DyR
         Ulnw==
X-Gm-Message-State: AOAM531tAE23nFC/+BPr2+je3qGJti3Bh2i8eMNBwd6V5LKWodneF0gm
        tJHhKkem+Jf4qYTlvLR6NzxovpTaQgjFAvp78SU2WtVDGlpIr/mdRbZI38p08986IBxo2lscspE
        HRF9CX0gn3b8Cr6Ii8nSH1yjS
X-Received: by 2002:a5d:6485:: with SMTP id o5mr6180818wri.91.1624383203297;
        Tue, 22 Jun 2021 10:33:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRtw4dO+cTagjehQZeZVMFQsiqbYo/AqhuED3rToW/g+49XMW3/di5iqjgVHrjFvLRVb8IMw==
X-Received: by 2002:a5d:6485:: with SMTP id o5mr6180808wri.91.1624383203169;
        Tue, 22 Jun 2021 10:33:23 -0700 (PDT)
Received: from krava ([5.171.242.79])
        by smtp.gmail.com with ESMTPSA id v22sm2915055wmh.40.2021.06.22.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 10:33:22 -0700 (PDT)
Date:   Tue, 22 Jun 2021 19:33:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, frederic@kernel.org,
        mtosatti@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC 2/2] timers: Make sure irq_work is handled when no pending
 timers
Message-ID: <YNIe38WaY0lOTEAZ@krava>
References: <20210610125945.558872-1-nsaenzju@redhat.com>
 <20210610125945.558872-2-nsaenzju@redhat.com>
 <87mtrmeqon.ffs@nanos.tec.linutronix.de>
 <YNHpN1h5hEZdt+Au@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNHpN1h5hEZdt+Au@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 03:44:23PM +0200, Peter Zijlstra wrote:
> On Sat, Jun 19, 2021 at 12:47:04AM +0200, Thomas Gleixner wrote:
> > There are two solutions:
> > 
> >   1) Create a IRQ_WORK softirq and raise that
> > 
> >   2) Simply delegate it to a workqueue
> 
> IIRC someone was looking to stick the whole thing in a kthread_worker.
> Jiri, was that you?
> 

yep, I still plan on doing that

jirka

