Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE1431EFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhBRTXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:23:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:59144 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhBRS0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:26:41 -0500
IronPort-SDR: lbhgb+sAxKDkbaTyp2OB9YOWvdA2gC2QVczIkuPSU5ZkUCP02klkbv9u4iyKqTHkQyv2ZVaHJ3
 ARtM9WzFNwWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="162748524"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="162748524"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 10:24:53 -0800
IronPort-SDR: BxHHUZL5051synqASMo9cCp1FoA2TKmlwiIAGeLEQ0sk86OGBuFOlIrFagJ1ia8W7o5TiK9Aj7
 /xQ/Y70B6kIw==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="378511037"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 10:24:53 -0800
Date:   Thu, 18 Feb 2021 10:24:51 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] perf intel-pt: Add limited support for tracing
 guest kernels
Message-ID: <20210218182451.GH472138@tassilo.jf.intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:57:50AM +0200, Adrian Hunter wrote:
> Hi
> 
> Currently, only kernel tracing is supported and only with "timeless" decoding
> i.e. no TSC timestamps

Patches look good to me. That will be quite useful.

Acked-by: Andi Kleen <ak@linux.intel.com>

Thanks,
-Andi
