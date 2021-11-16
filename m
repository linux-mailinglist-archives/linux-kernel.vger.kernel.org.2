Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B73453340
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhKPNzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:55:53 -0500
Received: from foss.arm.com ([217.140.110.172]:45518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbhKPNzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:55:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71BB26D;
        Tue, 16 Nov 2021 05:52:55 -0800 (PST)
Received: from [10.57.76.160] (unknown [10.57.76.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FD7F3F766;
        Tue, 16 Nov 2021 05:52:54 -0800 (PST)
Message-ID: <c716be29-4f0c-b516-c0bf-dc89ba466885@arm.com>
Date:   Tue, 16 Nov 2021 13:52:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v1 0/4] coresight: etm: Correct (virtual) contextID
 tracing for namespace
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211031144214.237879-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20211031144214.237879-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo


On 31/10/2021 14:42, Leo Yan wrote:
> If a profiling program runs in a non-root PID namespace, if CoreSight
> driver enables contextID tracing, it can lead to mismatching issue
> between the context ID in hardware trace data and the allocated PID in
> the non-root namespace.
> 
> CoreSight driver has tried to address this issue for the contextID
> related interfaces under sysfs, but it misses other parts: it doesn't
> prevent user to set VMID (virtual contextID) for kernel runs in EL2 with
> VHE, and furthermore, it misses to handle the perf mode when the
> profiling tool (e.g. perf) doesn't run in root PID namespace.
> 
> For this reason, this patch series is to correct contextID tracing for
> non-root namespace.
> 
> Patch 01 is to use spinlock to protect reading virtual context ID
> comparator.
> 
> Patch 02 corrects the virtual contextID tracing for non-root PID
> namespace.
> 
> Patch 03/04 are used to fix the contextID tracing for perf mode.
> 
> I only verified this patch series on Juno board in the root PID
> namespace and confirmed the patches don't introduce any regression for
> root PID namespace.
> 

I have finished reviewing the set.

Suzuki
