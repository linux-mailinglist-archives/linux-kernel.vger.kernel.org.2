Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8845AA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhKWR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234416AbhKWR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637688340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygX9stNObBwTwa4yUUs6NE8vyjejsSHuXhBtzRR0RVw=;
        b=IFoM3vTOdVYGSVH5bwQWT4b+JFQhBfZlAbEgUtBK2R4DTz9A8ASzIoPCf8EDoCtSvkoScw
        mvAqelllmx3dMWGiwCOY+sdrhpouFUn5BPA1Hu/ORUNe1I8Qi3cZuNRGy4Mn/VIDEp3vcH
        mhRuNXU4Fj7mHzVdnZKmjJ3B3ZngEPk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-OZHL6TVyM2mo0EgTzaP-YQ-1; Tue, 23 Nov 2021 12:25:39 -0500
X-MC-Unique: OZHL6TVyM2mo0EgTzaP-YQ-1
Received: by mail-wm1-f72.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so1873403wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygX9stNObBwTwa4yUUs6NE8vyjejsSHuXhBtzRR0RVw=;
        b=gQYDZZ28SIxHks8h+jqLH4bDI8k1fNptDCkk9ydDnW/HrXl3AvMqqV0JR6jnMdnf1U
         XmFrhVoN/dBqg3To/g7c/tWTsc8bklG8S76bMG944KPL8ZH+73SnYSOiEfy4SfayUl6d
         sRS30pZq0u/niH2aWNoj5EfH0amm4Mi9GPQYXIweZR1MWBgYMQaMzJtG+XOO9IUv5FkY
         ecU4WsyMQYUD0CopvGNxQH3eanphdpG6wZMk6eYfV3MyC+RO0NWTZu4d69q8QPZfCOFs
         dBjPW/iFytLnylezxLdqxH5exnLasISM1rLjRm+QQv0Zh3V649IhlyFM6gBV1sEtGyjd
         iSjw==
X-Gm-Message-State: AOAM531vFm9I/rKKnzzJOxZt32HUGItcE4XaLuQIvTPrX0EHpSd7wU4Z
        nPhmLZgAoAkGhnEcUveNUMhJTvte0V+y3c5Ro3gZCNXd78vXsid2SqV+vp5KYtamslQCCdvoZGf
        sgtz/eQ7ibb7ZuGNmqOlHAiJU
X-Received: by 2002:adf:f708:: with SMTP id r8mr9172767wrp.198.1637688337088;
        Tue, 23 Nov 2021 09:25:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysPEMbhEoCEjBU+0lOVwkGDJAd1JCc2Oie62LzmXyvWxSm0wdinZHG7f/zAbM739fUr3LvyA==
X-Received: by 2002:adf:f708:: with SMTP id r8mr9172716wrp.198.1637688336836;
        Tue, 23 Nov 2021 09:25:36 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a17:4f01:3a16:ae0:112c:ba92])
        by smtp.gmail.com with ESMTPSA id h3sm11524486wrv.69.2021.11.23.09.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:25:36 -0800 (PST)
Date:   Tue, 23 Nov 2021 17:25:34 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 0/6] rcu/nocb: Last prep work before cpuset interface v2
Message-ID: <20211123172534.iaaagfa4eygfsjew@localhost.localdomain>
References: <20211123003708.468409-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123003708.468409-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/11/21 01:37, Frederic Weisbecker wrote:
> Changes since v1 after Paul's reviews:
> 
> * Clarify why the DEL vs ADD possible race on rdp group list is ok [1/6]
> * Update kernel parameters documentation [5/6]
> * Only create rcuo[sp] kthreads for CPUs that have ever come online [4/6]
> * Consider nohz_full= on changelogs
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/nocb
> 
> HEAD: da51363e5ddf54d6ce9c2cfbab946f8914519290

I run this on RT. It survived rcutorture on different kernel cmdline
configurations and creation of rcuox/N kthreads seemed sane. :)

FWIW, feel free to add

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks for working on this!

Best,
Juri

