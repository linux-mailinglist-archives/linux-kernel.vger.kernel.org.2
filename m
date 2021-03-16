Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D947433D982
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhCPQei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:34:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:14149 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237939AbhCPQeX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:34:23 -0400
IronPort-SDR: wn+th1d1e77PnxPav/WXUcCzCc6ZoI80w7sBJQuy1JF/su/BJIeAeueIY55KFE8wyQgID3NGma
 XZBHVI6BlzLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="250656168"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="250656168"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 09:34:22 -0700
IronPort-SDR: CcE1Dq9lmlGr5vWgT2drgg3+ofMgMdLwkkf9voLoN/mttaGMSfwERyXlaCGSJjrzYie/mdXExt
 aPqqy8HyDrPg==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="449774301"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 09:34:22 -0700
Date:   Tue, 16 Mar 2021 09:34:21 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
Message-ID: <20210316163421.GQ203350@tassilo.jf.intel.com>
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
 <YFCtfXlaKbIeEMwk@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCtfXlaKbIeEMwk@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> looks ok, but maybe make the option more related to CVS, like:
> 
>   --x-summary, --cvs-summary  ...? 

Actually I don't think it should be a new option. I doubt
anyone could parse the previous mess. So just make it default
with -x

-Andi
