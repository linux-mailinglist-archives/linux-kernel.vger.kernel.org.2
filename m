Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D0414C19
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhIVOfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhIVOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:35:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD576C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ob4/gKtPQhJS8Qy8WeXzgM72xF40FfzYjJVqa9qGLCE=; b=oM85U9nNhdOrk7qZICyp0UankB
        rQ486190awpYI4Vctn1ZUGRjgr4faGjBPuJhbalqzmVkMhK3RcX52DjQ2dc3ZdjdhHxwFTjU3+2mF
        8nMdobCu7BAKWvVR/8KnZy6mwxKWwiLDheLFzm9kl51ln1nnj01smYYiTQIDmuIqtdsf/+l686JtH
        dvbZL9ICBsI0K8vjfYz+VhwMz+XC2w4GGYTsv90Q9aTlD9KuuJYEfWbK4uDuW85S7/Gd62coOrdbZ
        q7nMFMJpfBvWhgpfR6ifFHg4zhK0ZskFghX/ooAjxT4Rozl8bbIjJG96486CYnc+I8GdMPQ3wXBvz
        dh5MhFjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT3Hf-004rsC-NJ; Wed, 22 Sep 2021 14:31:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B18679816EA; Wed, 22 Sep 2021 16:31:37 +0200 (CEST)
Date:   Wed, 22 Sep 2021 16:31:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [sched/fair]  56498cfb04:  netperf.Throughput_tps -5.4%
 regression
Message-ID: <20210922143137.GT4323@worktop.programming.kicks-ass.net>
References: <20210912153447.GG25450@xsang-OptiPlex-9020>
 <20210922124400.GQ4323@worktop.programming.kicks-ass.net>
 <20210922134247.GY3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922134247.GY3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 02:42:47PM +0100, Mel Gorman wrote:
> For the LKP test, the nr_threads are 50% so I expect with two sockets,
> the machine is fully loaded and would be vulnerable to load-balancing
> artifacts as client and server threads move around. Hence, I ended up
> thinking that this result was likely a false positive.

Fair enough, lets ignore it for now then :-)
