Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42E366A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhDUMEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbhDUMEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:04:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE369C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+NSk+az2QosENoII1h0fqE2YODWrKCILNwyXS4ZFhb4=; b=jzAMmu4OHt/dmR5Ru5u7WE3vd0
        f8fhGkRvxhl7a3ZHNw8LuwACsVQ7sop0zjD9jdeH1k/2fC0xZqDkZNEinc7Zb4aOlaV7s/GF1gpQZ
        YCFfWFXd174kt8d17d0U57ddGI7v/mLJ6hiadhowHziMW+TltM6BYQcr78PatCop3/wdEy2SGhkGq
        VrR6dqPelQFHkLt6XOYC+ch0BXErHOB+4Hq7QN5N6SNNB3MhJGT43BRfsq58LDj1KItwCkNd5dcLV
        NsIZX5JwgrblpvIq95reCDSbJ8YZexpz+olQ4zg/moS0DAPR9NKW4itlm60Ryzwgj0iPUGkuf2pGc
        LINWNLnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZBZX-00ELjm-4G; Wed, 21 Apr 2021 12:03:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 077EF300130;
        Wed, 21 Apr 2021 14:03:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E243628582672; Wed, 21 Apr 2021 14:03:08 +0200 (CEST)
Date:   Wed, 21 Apr 2021 14:03:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Oliver Sang <oliver.sang@intel.com>, 0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [sched/fair]  38ac256d1c:  stress-ng.vm-segv.ops_per_sec -13.8%
 regression
Message-ID: <YIAUfFXFFY9Jggra@hirez.programming.kicks-ass.net>
References: <20210414052151.GB21236@xsang-OptiPlex-9020>
 <87im4on5u5.mognet@arm.com>
 <20210421032022.GA13430@xsang-OptiPlex-9020>
 <87bla8ue3e.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bla8ue3e.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:27:49AM +0100, Valentin Schneider wrote:
> o 2-socket Xeon E5-2690 (x86, 40 cores)
> 
> and found at worse a -0.3% regression and at best a 2% improvement. I know
> that x86 box is somewhat ancient, but it's been my go-to "have I broken
> x86?" test victim for a while :-)

It happens that my main test-box is an E5-2680. I've got a slightly more
modern one too, but that boots like treacle so I end up using the IVB-EP
most :-)
