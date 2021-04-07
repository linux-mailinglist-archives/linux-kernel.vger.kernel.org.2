Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCE356DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347660AbhDGNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:33257 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347595AbhDGNuI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:08 -0400
IronPort-SDR: dFQ7hPWgwcaBzb895WplB6IiNxvsnT7qzHKgOTN/WgZBCtVfPQXGZcSlVY6aw1LZVIs8CWWqAT
 yTC7aSi8JtOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="192849141"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="192849141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:49:58 -0700
IronPort-SDR: IqWjyWZBkEBzXYUqTzIAKiym3dSoKWlI/Mkp4dZX6NdwGxr7Wawd5Bra3UbuZuQPLT+/L7hLgY
 uVMQxku+kswg==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="458375612"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:49:58 -0700
Date:   Wed, 7 Apr 2021 06:49:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf report: Fix wrong LBR block sorting
Message-ID: <20210407134957.GL1285835@tassilo.jf.intel.com>
References: <20210407024452.29988-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407024452.29988-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Now the hottest block is reported at the top of output.
> 
> Fixes: b65a7d372b1a ("perf hist: Support block formats with compare/sort/display")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>


Reviewed-by: Andi Kleen <ak@linux.intel.com>
-Andi
