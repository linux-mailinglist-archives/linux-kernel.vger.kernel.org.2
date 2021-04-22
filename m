Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB6E3684BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhDVQZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhDVQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:25:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IK2DRL9QTskPdmvchMK2QQZwls+b8mo8keCxH1wBohQ=; b=mJGAf+N7muFsXFIRyvjbKiERu5
        b6L1zKXmvmeJsmZyBZEJBMZi0Euz7eFDl7KEHHnpSu71+u/6/d1dLBOXZ+brOgN+QlJiVfZwcTedI
        rc3IyAmT4NLjaMn+xsdZa69smJ1SLjcdYQI6BAPkRBtQrqhqezzQwLHCHCE2rQRO+UeDGXtumFBop
        Idt7PMJvu2skdNlIG0j88ngqk6YEdu1VmcXlxsBBG54HEfvmtLEmf49nMkZrTng+o4Qc1YKOeTRk+
        pHe/txF437gin6ojUYKeDUEMGFsZ3j4oKlmqtyfbhS+AJWOmvj2my2RJNWtwKtUY2zEjBcDcoHLYx
        Nli0QjtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZc7j-00H3aM-1M; Thu, 22 Apr 2021 16:24:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 061A53001E2;
        Thu, 22 Apr 2021 18:24:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B22252CBE5ED9; Thu, 22 Apr 2021 18:24:13 +0200 (CEST)
Date:   Thu, 22 Apr 2021 18:24:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [sched,debug]  3b87f136f8:  stress-ng.procfs.ops_per_sec -31.7%
 regression
Message-ID: <YIGjLQq6w2wERotq@hirez.programming.kicks-ass.net>
References: <20210422144258.GD6394@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210422144258.GD6394@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:42:58PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -31.7% regression of stress-ng.procfs.ops_per_sec due to commit:

> commit: 3b87f136f8fccddf7da016ab7d04bb3cf9b180f0 ("sched,debug: Convert sysctl sched_domains to debugfs")

> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory

>      16865 ±  4%     -31.7%      11516 ±  6%  stress-ng.procfs.ops

The patch in question removes a ton of procfs files, so this is just
about expected. If this also lowers the procfs ops/s measure, this could
be because all these procfs files were trivial.

Some procfs files are expensive to read and collect lots of data, these
files were trivial and fast, by removing them, the average time to read
a procfs file might very well have increased.

Over-all: -EDONTCARE.
