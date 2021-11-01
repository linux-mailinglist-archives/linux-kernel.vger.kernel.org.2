Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9AE44191C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhKAJzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:55:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233594AbhKAJvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:51:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8EB3106F;
        Mon,  1 Nov 2021 02:49:09 -0700 (PDT)
Received: from [10.57.47.15] (unknown [10.57.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90E083F719;
        Mon,  1 Nov 2021 02:49:08 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] coresight: etm4x: Add lock for reading virtual
 context ID comparator
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211031144214.237879-1-leo.yan@linaro.org>
 <20211031144214.237879-2-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <df07c7b0-0145-8290-b4cd-a1831f19330d@arm.com>
Date:   Mon, 1 Nov 2021 09:49:06 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211031144214.237879-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo

On 31/10/2021 14:42, Leo Yan wrote:
> When read the virtual context ID comparator value via sysfs node, the
> driver firstly reads out the index, then reads the comparator value
> based on index. >
> This patch adds the spinlock to protect the atomicity for up two steps.

minor nit: This could be :

"Updates to the values and the index are protected via the
spinlock. Ensure we use the same lock to read the value
safely"

With that:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
