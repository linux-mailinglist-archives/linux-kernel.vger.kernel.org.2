Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E220396E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhFAIBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:01:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233069AbhFAIBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:01:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622534361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ETA/uZ3RYpkBUVga1GOnLXdkl/xa1dO7W1HIUnISUfo=;
        b=qxjixrjODsCX8O311V2pZ4XZDFroeVhUc0n5yOMyNYPrPiS+hTiuZdT172p2qKvPFnby2q
        J7PWibYVNItSjk7JFRNi+Nnn6QHfMSiUvVowo0UrLojZpcpczmzvHFxC122Y345WfeXU6q
        k8fw73HXt03kPkdUM/TDEdLuvzAShZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622534361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ETA/uZ3RYpkBUVga1GOnLXdkl/xa1dO7W1HIUnISUfo=;
        b=wHR0OVOHiig4z3YxtYJ7jszKfMePoHoZDi8xUstskenJ7l0QPdZ5wvDBMWIGv1UrjF+hAZ
        pJo3cv94Cc7vRVBw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35272AD54;
        Tue,  1 Jun 2021 07:59:21 +0000 (UTC)
Date:   Tue, 1 Jun 2021 08:59:18 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        tangchengchang <tangchengchang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] sched: fair: don't depend on wake_wide if waker and
 wakee are already in same LLC
Message-ID: <20210601075918.GP3672@suse.de>
References: <20210526091057.1800-1-song.bao.hua@hisilicon.com>
 <YK474+4xpYlAha+2@hirez.programming.kicks-ass.net>
 <7dd00a98d6454d5e92a7d9b936d1aa1c@hisilicon.com>
 <20210527121409.GK3672@suse.de>
 <07e4ba63a19c451ab47e6a636c400f4a@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <07e4ba63a19c451ab47e6a636c400f4a@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:21:55PM +0000, Song Bao Hua (Barry Song) wrote:
> The benchmark of tbenchs is still positive:
> 
> tbench4
> 
>                            5.13-rc4               5.13-rc4
>                                      disable-llc-wakewide/
> 
> Hmean     1       514.87 (   0.00%)      505.17 *  -1.88%*
> Hmean     2       914.45 (   0.00%)      918.45 *   0.44%*
> Hmean     4      1483.81 (   0.00%)     1485.38 *   0.11%*
> Hmean     8      2211.62 (   0.00%)     2236.02 *   1.10%*
> Hmean     16     2129.80 (   0.00%)     2450.81 *  15.07%*
> Hmean     32     5098.35 (   0.00%)     5085.20 *  -0.26%*
> Hmean     64     4797.62 (   0.00%)     4801.34 *   0.08%*
> Hmean     80     4802.89 (   0.00%)     4780.40 *  -0.47%*
> 
> I guess something which work across several LLC domains
> cause performance regression.
> 
> I wonder how your test will be like if you pin the testing
> to CPUs within one LLC?
> 

While I could do this, what would be the benefit? Running within one LLC
would be running the test in one small fraction of the entire machine as
the machine has multiple LLCs per NUMA node. A patch dealing with how the
scheduler works with respect to LLC should take different configurations
into consideration as best as possible.

-- 
Mel Gorman
SUSE Labs
