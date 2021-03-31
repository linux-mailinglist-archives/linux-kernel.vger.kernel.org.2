Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF32C350404
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhCaQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhCaQAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:00:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94A1F61005;
        Wed, 31 Mar 2021 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617206422;
        bh=QKNMkZrb8k+0UWfb+fxD1Gh5YsJ3i4rjyy6mJ8/QnfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5qRXHmv6XEUqL9lP46k7b2FOfn04KBTSbfH5hbpUYO5oATX6Mzd35XpusreLi+Wi
         A8Xy+HD7V4PU2dLEDsTqACHo0g0Bht3DgkEXjikRG9w8dsEBuuWCCpY8bfdjnvkTAB
         TkxXyQkunLZykI7fyMe9Oi1krNaAAMfS373s3/hqDCeI41sOvD5PuyXiabjNc4iRui
         zHM+kvLL9ArfrnqZNhTOLxrCbZgv4BkYG/d0HPIWYQrXOsX4E09rLskZ81IS6qUpz9
         ZmKGNYewwsj5hTOIQREePckFNAOM+zNGu0oRarZt3EDpnNJ8lDIAxOdNs9dcpQzS69
         Mjultf1zmS8pQ==
Date:   Wed, 31 Mar 2021 17:00:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/10] Documentation: arm64: Document PMU counters
 access from userspace
Message-ID: <20210331160016.GC7815@willie-the-truck>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311000837.3630499-11-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:08:37PM -0700, Rob Herring wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> Add a documentation file to describe the access to the pmu hardware
> counters from userspace
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v6:
>   - Update the chained event section with attr.config1 details
> v2:
>   - Update links to test examples
> 
> Changes from Raphael's v4:
>   - Convert to rSt
>   - Update chained event status
>   - Add section for heterogeneous systems
> ---
>  Documentation/arm64/index.rst                 |  1 +
>  .../arm64/perf_counter_user_access.rst        | 60 +++++++++++++++++++

We already have Documentation/arm64/perf.rst so I think you can add this
in there as a new section.

Will
