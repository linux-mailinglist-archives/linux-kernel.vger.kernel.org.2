Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FED366C80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbhDUNSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbhDUNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:40 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4FDC06138F;
        Wed, 21 Apr 2021 06:09:06 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FQLV65HT1z9vF3; Wed, 21 Apr 2021 23:09:02 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org
Cc:     ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com, kan.liang@linux.intel.com
In-Reply-To: <1616425047-1666-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1616425047-1666-1-git-send-email-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 0/5] powerpc/perf: Export processor pipeline stage cycles information
Message-Id: <161901050007.1961279.2172742114670881645.b4-ty@ellerman.id.au>
Date:   Wed, 21 Apr 2021 23:08:20 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 10:57:22 -0400, Athira Rajeev wrote:
> Performance Monitoring Unit (PMU) registers in powerpc exports
> number of cycles elapsed between different stages in the pipeline.
> Example, sampling registers in ISA v3.1.
> 
> This patchset implements kernel and perf tools support to expose
> these pipeline stage cycles using the sample type PERF_SAMPLE_WEIGHT_TYPE.
> 
> [...]

Patch 1 applied to powerpc/next.

[1/5] powerpc/perf: Expose processor pipeline stage cycles using PERF_SAMPLE_WEIGHT_STRUCT
      https://git.kernel.org/powerpc/c/af31fd0c9107e400a8eb89d0eafb40bb78802f79

cheers
