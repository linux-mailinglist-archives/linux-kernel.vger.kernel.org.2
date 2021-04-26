Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A836B871
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbhDZR5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:57:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:16836 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237671AbhDZR5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:57:10 -0400
IronPort-SDR: dhu1B24S19qQ5d6mCgFeGk1L4m5/UKf7nsg3IB8xZoc0EcLCt8FVHTTJS0urip8Tcw8wIbubJn
 +F6gHl9JK6Kw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175862275"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="175862275"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 10:56:28 -0700
IronPort-SDR: 8XosBHsyApUuRW3qf0+gK2Gg4NHMmiBgwAm+bicw1aMZNg4xyHG0eVo0/GpJV3gpXia7n69gqC
 tZcTwLJWYUXA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="429484304"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 10:56:28 -0700
Date:   Mon, 26 Apr 2021 10:56:27 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, feng.tang@intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
Message-ID: <20210426175627.GZ1401198@tassilo.jf.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org>
 <20210426040736.GS1401198@tassilo.jf.intel.com>
 <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426160008.GY1401198@tassilo.jf.intel.com>
 <20210426161425.GC975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426161425.GC975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ------------------------------------------------------------------------
> 
> - module parameters
> 
>   If the scope of the fault injection capability is limited to a
>   single kernel module, it is better to provide module parameters to
>   configure the fault attributes.
> 
> ------------------------------------------------------------------------
> 
> And in this case, the fault injection capability is in fact limited to
> kernel/clocksource.c.


I disagree with this recommendation because it prevents fuzzer coverage.

Much better to have an uniform interface that can be automatically
explored.

-Andi
