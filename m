Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789B53FFCD9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbhICJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:16:12 -0400
Received: from foss.arm.com ([217.140.110.172]:39276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348700AbhICJQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:16:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5990D1FB;
        Fri,  3 Sep 2021 02:15:11 -0700 (PDT)
Received: from [10.57.92.220] (unknown [10.57.92.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226B23F694;
        Fri,  3 Sep 2021 02:15:09 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] perf cs-etm: Create ETE decoder
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org
Cc:     acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-8-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4da533c0-8da6-00d4-1849-e210e163d326@arm.com>
Date:   Fri, 3 Sep 2021 10:15:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210806134109.1182235-8-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2021 14:41, James Clark wrote:
> If the magic number indicates ETE instantiate a OCSD_BUILTIN_DCD_ETE
> decoder instead of OCSD_BUILTIN_DCD_ETMV4I. ETE is the new trace feature
> for Armv9.
> 
> Testing performed
> =================
> 
> * Old files with v0 and v1 headers for ETMv4 still open correctly
> * New files with new magic number open on new versions of perf
> * New files with new magic number fail to open on old versions of perf
> * Decoding with the ETE decoder results in the same output as the ETMv4
>    decoder as long as there are no new ETE packet types
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Changes look good to me with my limited knowledge about the decoder
facing code.

FWIW,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

