Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DA538FE11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhEYJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:46:36 -0400
Received: from foss.arm.com ([217.140.110.172]:53938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhEYJq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:46:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F96C6D;
        Tue, 25 May 2021 02:45:00 -0700 (PDT)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16C673F73D;
        Tue, 25 May 2021 02:44:57 -0700 (PDT)
Date:   Tue, 25 May 2021 10:46:01 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <20210525094601.GB369979@e124901.cambridge.arm.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKzETaPD/Flnz+dz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKzETaPD/Flnz+dz@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 09:33:01AM +0000, Quentin Perret wrote:
> On Friday 21 May 2021 at 17:54:24 (+0100), Vincent Donnefort wrote:
> > @@ -161,6 +162,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
> >  		table[i].cost = div64_u64(fmax * table[i].power,
> >  					  table[i].frequency);
> >  		if (table[i].cost >= prev_cost) {
> > +			table[i].flags = EM_PERF_STATE_INEFFICIENT;
> > +			pd->flags |= EM_PERF_DOMAIN_INEFFICIENCIES;
> 
> If we're looking for micro-optimizations, then perhaps you could store
> the index of the next efficient OPP (which would be 'i' if the current
> OPP is already efficient), so you can jump to it directly when doing the
> search.

Wouldn't add any new field compared to this version so yeah might be an
interesting improvement.

> 
> >  			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> >  				table[i].frequency);
> >  		} else {
