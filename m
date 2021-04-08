Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A839035871E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhDHO04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:26:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:28661 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhDHO0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:26:55 -0400
IronPort-SDR: ScZeezddBWTjHkHFyIYZRFj7ojEG4Ykd6Hbms/ron+uO5ILDWZ5toJpM0IQfRno9ZMKUxVXQO5
 Xe9n9Km5JNFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="278826257"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="278826257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:26:44 -0700
IronPort-SDR: hevKwC9BMjhBVfoGukP8OpM+jWUFxZ8PfoSx5pcxwAHIn0/fm/5akD0TtCCSKhTW2ySZU8zvJf
 dDEGFeHorwYg==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="530617040"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:26:44 -0700
Date:   Thu, 8 Apr 2021 07:26:43 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v4 12/12] perf session: use reader functions to load perf
 data file
Message-ID: <20210408142643.GG3762101@tassilo.jf.intel.com>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <990c4b5f-6a30-2c71-2794-d900da71dba5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <990c4b5f-6a30-2c71-2794-d900da71dba5@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Except where I commented, for the series

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
