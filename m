Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91573268D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBZUrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:47:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:5184 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhBZUrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:47:05 -0500
IronPort-SDR: ChS2MaPqE5E4jdV9azmJs0PPzAIUuppmJ68j8Gfu9XXIaOAbPaS+fpWjpUxdhV+h+l2QtP943b
 /IxzSuQWR+xQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="247413703"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="247413703"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 12:45:19 -0800
IronPort-SDR: wfg+jxblTZXT4+JbJv/A2Jl2+qMGRcveHkGww4qXLMfdRMbJeaOfPH0smSYdAIOuHZYvl7fXPk
 Oig4jP/rtj9A==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="382144478"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 12:45:19 -0800
Date:   Fri, 26 Feb 2021 12:45:18 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        irogers@google.com, kjain@linux.ibm.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        will@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] perf vendor events: Remove 'type' field from mapfiles
Message-ID: <20210226204518.GB472138@tassilo.jf.intel.com>
References: <1614344897-229717-1-git-send-email-john.garry@huawei.com>
 <20210226154737.GY472138@tassilo.jf.intel.com>
 <d2b754c2-0994-34a2-c42e-d8323beaf8c5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b754c2-0994-34a2-c42e-d8323beaf8c5@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I assumed that it was this file:
> https://download.01.org/perfmon/mapfile.csv

Yep.

> 
> which already has a different format - extra columns - so figured that some
> handcrafting was already going on. Indeed 'type' is not always 'core' there.

Yes. Could possibly add the extra columns from there just to stay compatible,
but being a subset is ok too.

-Andi
