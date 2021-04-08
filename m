Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4749E358711
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhDHOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:21:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:21652 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhDHOVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:21:51 -0400
IronPort-SDR: F/zCS/PYFiPqBewprAPKHdDlhLr4eFJ3YwOljlzSgkYyxb4wrCvEi+j2sY2du/IQA1gOL3DtIn
 OglBt3YOuslg==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="190348333"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="190348333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:21:40 -0700
IronPort-SDR: PN568oKrfQ7hkG6wer9c5pBIDEvPW/meQgHrFz9VTph76i/i77DXF7BW9QpnMfrjZQVcvPG3IY
 gU/PiJHhtqfQ==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="422268065"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:21:40 -0700
Date:   Thu, 8 Apr 2021 07:21:39 -0700
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
Subject: Re: [PATCH v4 05/12] perf record: start threads in the beginning of
 trace streaming
Message-ID: <20210408142139.GE3762101@tassilo.jf.intel.com>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <d11bab8e-74e8-ed4d-c3a3-af4d42244806@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11bab8e-74e8-ed4d-c3a3-af4d42244806@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
> +	if (err == -1)
> +		pr_err("threads[%d]: failed to notify on start. Error %m", thread->tid);

It might be safer to not use %m. I'm not sure if all the non glibc
libcs that people use support it.

