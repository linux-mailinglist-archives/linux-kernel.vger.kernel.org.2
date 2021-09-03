Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354A93FFCE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348741AbhICJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:18:29 -0400
Received: from foss.arm.com ([217.140.110.172]:39362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhICJS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:18:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A52D1FB;
        Fri,  3 Sep 2021 02:17:28 -0700 (PDT)
Received: from [10.57.92.220] (unknown [10.57.92.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66A523F7D7;
        Fri,  3 Sep 2021 02:17:26 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] perf cs-etm: Print the decoder name
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
 <20210806134109.1182235-9-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <de23e803-3840-501e-87a8-39eed7ba434b@arm.com>
Date:   Fri, 3 Sep 2021 10:17:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210806134109.1182235-9-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2021 14:41, James Clark wrote:
> Use the real name of the decoder instead of hard-coding "ETM" to avoid
> confusion when the trace is ETE. This also now distinguishes between
> ETMv3 and ETMv4.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

