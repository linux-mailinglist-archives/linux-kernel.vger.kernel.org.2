Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685B244BCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhKJIjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJIjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:39:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D86C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QTjq4+NF5gS81UUXJMbCMX9lOOw+gbyrkDDIl5OUPWY=; b=jaXYQgzmD506gRK4y9KTKker1O
        4R4JxVIlz8saIi+ToShOmq8db/j62hdPz9YhwFHZuhH7ARyPaDPT8uV4LGkpgmme7/E9YwjBHSheH
        rj1DaPmJ4+Nm0O5cXqbEwKy6sHOKQQU2adS3ye4G//L5ERim1ymenV/weWsfuuxO++EpFF/xpl9UN
        kCpnGp/fSv3y5p9pWUWJTs9uCA7GUN1J6arccu/q4+rXUoeTCCXWisICElNzpqa53FDn7ktEF+xj5
        9A4ycCWvPIT5XLKcd4lFhOuVOrCwk/8EKfypQaLAibhuDRNskoOc0dqstLdF42XsuQIEkJsN3qI1b
        2OFJOGLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkj6A-00FF0C-Ku; Wed, 10 Nov 2021 08:36:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 863E430003C;
        Wed, 10 Nov 2021 09:36:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A365212EE584; Wed, 10 Nov 2021 09:36:49 +0100 (CET)
Date:   Wed, 10 Nov 2021 09:36:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ke Wang <ke.wang@unisoc.com>, xuewen.yan@unisoc.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
Message-ID: <YYuEoftqXxOhStJ7@hirez.programming.kicks-ass.net>
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
 <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
 <CAGWkznHGZeAeQzpuwi-ZH50R_fm4Nw5r8TSonk8AQatZaB_xSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHGZeAeQzpuwi-ZH50R_fm4Nw5r8TSonk8AQatZaB_xSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:37:00AM +0800, Zhaoyang Huang wrote:
> On Tue, Nov 9, 2021 at 10:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 02, 2021 at 03:47:33PM -0400, Johannes Weiner wrote:
> > > CC peterz as well for rt and timekeeping magic
> > >
> > > On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > In an EAS enabled system, there are two scenarios discordant to current design,
> > > >
> > > > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > > > RT task usually preempts CFS task in little core.
> > > > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > > > ignore the preempted time by RT, DL and Irqs.
> >
> > It ignores preemption full-stop. I don't see why RT/IRQ should be
> > special cased here.
> As Johannes comments, what we are trying to solve is mainly the
> preempted time of the CFS task by RT/IRQ, NOT the RT/IRQ themselves.
> Could you please catch up the recent reply of Dietmar, which maybe
> provide more information.

In that case NAK.
