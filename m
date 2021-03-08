Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1EA3313E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCHQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:54:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:34620 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhCHQyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:54:43 -0500
IronPort-SDR: 898Xm2NgKOIHwiVJ3iaYeL2/igbzwnruKElMWUXt4FANA0LKougCVeyQ6CSnoE8NJwvVMtTyOH
 aT8nSNwoYtJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="207831945"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="207831945"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:54:43 -0800
IronPort-SDR: pbFnx7iBOrbMc2QALC+mxcPEvXgco+DtPPXnpBxnGJEXO8ORlqKUl8v7VeObfdKSR1zv+kH540
 W9wM4FhOcuSA==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="447192324"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:54:42 -0800
Date:   Mon, 8 Mar 2021 08:54:37 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Fix auxtrace queue conflict
Message-ID: <20210308165437.GA203350@tassilo.jf.intel.com>
References: <20210308151143.18338-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308151143.18338-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 05:11:43PM +0200, Adrian Hunter wrote:
> The only requirement of an auxtrace queue is that the buffers are in
> time order.  That is achieved by making separate queues for separate
> perf buffer or AUX area buffer mmaps.
> 
> That generally means a separate queue per cpu for per-cpu contexts,
> and a separate queue per thread for per-task contexts.
> 
> When buffers are added to a queue, perf checks that the buffer cpu
> and thread id (tid) match the queue cpu and thread id.
> 
> However, generally, that need not be true, and perf will queue
> buffers correctly anyway, so the check is not needed.
> 
> In addition, the check gets erroneously hit when using sample mode
> to trace multiple threads.
> 
> Consequently, fix that case by removing the check.

Thanks!

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
