Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B1C3264E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 16:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBZPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:49:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:33595 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZPt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:49:26 -0500
IronPort-SDR: QZF09YzAFh+JBm0yBW+2n0aQyRPwgx5PEC6WQWyO8qnkKx0Vo1NvGQpRlj9QckQlAekbLaMksi
 u5f112gOZdDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="182487383"
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="182487383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 07:47:39 -0800
IronPort-SDR: 9Xdd/lfQYg/zd3Y5RS/WTOp46Jmh+fWIfc1h0R0wWiIS+66yDH45mw0pG127GRDmAbnlMeKZwZ
 O17yNaVBO5Jw==
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="393651248"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 07:47:38 -0800
Date:   Fri, 26 Feb 2021 07:47:37 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        irogers@google.com, kjain@linux.ibm.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        will@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] perf vendor events: Remove 'type' field from mapfiles
Message-ID: <20210226154737.GY472138@tassilo.jf.intel.com>
References: <1614344897-229717-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614344897-229717-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 09:08:17PM +0800, John Garry wrote:
> Included for each CPU entry in the per-arch mapfile.csv file is a 'type'
> field.

I don't like it because this will make the mapfile incompatible with
what download.01.org uses. We originally derived it from that.

It would be ok if it fixed something serious, but as it seems to be
more cosmetic I don't think there's a good reason to devivate.

-Andi
