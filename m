Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6942CF97
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 02:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhJNAj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 20:39:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:53568 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhJNAj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 20:39:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227529552"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="227529552"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 17:37:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="481030386"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.163.40]) ([10.212.163.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 17:37:53 -0700
Message-ID: <5e2262a3-ec27-fa3e-c5d1-3a5e25a42042@linux.intel.com>
Date:   Wed, 13 Oct 2021 17:37:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] perf/x86/intel: fix ICL/SPR INST_RETIRED.PREC_DIST
 encodings
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kan.liang@intel.com
References: <20211014001214.2680534-1-eranian@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20211014001214.2680534-1-eranian@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/2021 5:12 PM, Stephane Eranian wrote:
> This patch fixes the encoding for INST_RETIRED.PREC_DIST as published by Intel
> (download.01.org/perfmon/) for Icelake. The official encoding
> is event code 0x00 umask 0x1, a change from Skylake where it was code 0xc0
> umask 0x1.
>
> With this patch applied it is possible to run:
> $ perf record -a -e cpu/event=0x00,umask=0x1/pp .....
>
> Whereas before this would fail.
>
> To avoid problems with tools which may use the old code, we maintain the old
> encoding for Icelake.
>
> Signed-off-by: Stephane Eranian <eranian@google.com>


Make sense.

Reviewed-by: Andi Kleen <ak@linux.intel.com>


-Andi

