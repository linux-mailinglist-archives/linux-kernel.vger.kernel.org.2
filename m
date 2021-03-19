Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FFC342651
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCSTes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCSTeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:34:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1966C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=terqXH9wF8X6uGRtSftYzgYt96v/nFnRfp1SIBYf1Sc=; b=CXw/JHiLsltMu+RII+0p48FIlL
        EJeDK580kai4cfd3OxGdluUaLodBKlk+DDa2G2vTe85pyWinOLagOnf7sVEtLYKxLmGe9M44Lg0U9
        qDdKGBMkZqZO3WIcdKG6WkITh61E1HGOb0MRaFtRWqd+3StotrII3sQY17ywpYL5VT+uC/k309jEO
        RxI37h1NRNZy95U6NZXc0JQgBaZqak+ZIYRBF1yOBDHjtog27FdTh0Sa57jr24CyQ8qQ5ACr6qKJU
        g+MMmWzTEl0YSuWQcnbSA8pG58g3Agcx9bv+72Ri8arTGC1P3bqj6t/oG4t27lJbV4Y22MnAAU0JX
        9dtf/iBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNKt7-0083o6-2a; Fri, 19 Mar 2021 19:34:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25EBF3012DF;
        Fri, 19 Mar 2021 20:34:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D996200FFB59; Fri, 19 Mar 2021 20:34:24 +0100 (CET)
Date:   Fri, 19 Mar 2021 20:34:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org,
        jeyu@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFT8wDrWvfpQoIWw@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
 <20210318161308.vu3dhezp2lczch6f@treble>
 <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
 <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
 <20210319140005.7ececb11@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319140005.7ececb11@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 02:00:05PM -0400, Steven Rostedt wrote:
> Would making __exit code the same as init code work? That is, load it just
> like module init code is loaded, and free it when the init code is freed

As stated, yes. But it must then also identify as init through
within_module_init().
