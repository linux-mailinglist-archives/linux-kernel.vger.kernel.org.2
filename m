Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3638F371342
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhECJze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 05:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhECJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 05:55:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32265C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tTd9eo00Ue3wFKj+8UCV8oHUSbnAPYsBUziBG+5QfHY=; b=p6/fXoHfBsno7l+5+4dQMtHRF4
        cCTUOAqI7cf7sCGY1DkqE4KsC58d1OWn9e3g2J9SmWiAGfVkCv188brbWho5lWuygWY7zSnf/Inhe
        MbZDuxLRQEUCPLtxGEKKh55z6eG1A1ZN9WyL2PwovEd0/ENqbpMHFtHtctSG17J/tJmlZZCFMgr/y
        lkfeVMBgaQNYJ+NfUV8hsxvtQ5CbVAHZwbssRTpeMz6i5fH4Ch2/FidTXkiQThKv0zIglkto7DuhC
        bRt5VFpi5mGIp4jLWKw/T+zsnNO4MmsTdQKWepUdXMvn+NREMCOx0uKCV1sLA+38JYsuotqdMLXtI
        OcY0lDeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldVHH-00Daqu-MN; Mon, 03 May 2021 09:54:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CE71300036;
        Mon,  3 May 2021 11:54:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 270C42BC22563; Mon,  3 May 2021 11:54:11 +0200 (CEST)
Date:   Mon, 3 May 2021 11:54:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 3/4] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <YI/IQ+LRD/YhgZoN@hirez.programming.kicks-ass.net>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:04:35PM -0700, Ricardo Neri wrote:
> +/**
> + * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> + * @dst_cpu:	CPU doing the load balancing

FWIW, that description isn't correct. dst_cpu does not need to be the
CPU doing the actual balancing. It mostly is, but no guarantees.

