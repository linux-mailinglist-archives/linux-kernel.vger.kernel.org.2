Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E133903C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhEYOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbhEYOTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:19:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E47C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R3CM2Lsu3VJH05B4Xvgeahvan2waaA6zGmOBWkB7ucM=; b=QhHEV9SMIPb9e2vcx+sRttOMHg
        1ad1UfpqbfBTF6PegXck6vLnK73iJuqtO6GfRcvGORNSBb4MCtN0si8dz88f5aiVt+4+EyiCYfry1
        ALK/NQ2paQxgVX9Mk5PBOWdqrynvSShRsuri2mDaFWs1V7n0RMedD8gwrSoxbZrqI2HHsZatAq00Y
        uhn2zFGoshrfJ4xM5HHL3nI0ij3ZhHpBXMIYqZUeNfjD3Kb1CeZVBPJJi4lHiMSrUI9Ww/AJY7leR
        oaCluGDG5hsTV5huoSAGd9RVDfVxnb9dUfN98NPPXq5aLiDMm0SoWiJRMoJM+RnZ7tKGPp7aP4Sy1
        r/u1nKpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llXrX-0008HI-Je; Tue, 25 May 2021 14:16:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1782A30022C;
        Tue, 25 May 2021 16:16:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31889202A6057; Tue, 25 May 2021 16:16:54 +0200 (CEST)
Date:   Tue, 25 May 2021 16:16:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        maddy@linux.vnet.ibm.com, santosh@fossix.org,
        aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        atrajeev@linux.vnet.ibm.com, tglx@linutronix.de,
        rnsastry@linux.ibm.com
Subject: Re: [RFC v2 4/4] powerpc/papr_scm: Add cpu hotplug support for
 nvdimm pmu device
Message-ID: <YK0G1nmvhOPimRay@hirez.programming.kicks-ass.net>
References: <20210525132216.1239259-1-kjain@linux.ibm.com>
 <20210525132216.1239259-5-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525132216.1239259-5-kjain@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 06:52:16PM +0530, Kajol Jain wrote:
> Patch here adds cpu hotplug functions to nvdimm pmu.

I'm thinking "Patch here" qualifies for "This patch", see
Documentation/process/submitting-patches.rst .

> It adds cpumask to designate a cpu to make HCALL to
> collect the counter data for the nvdimm device and
> update ABI documentation accordingly.
> 
> Result in power9 lpar system:
> command:# cat /sys/devices/nmem0/cpumask
> 0

Is this specific to the papr thing, or should this be in generic nvdimm
code?
