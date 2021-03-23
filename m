Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA7345B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCWJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:48:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhCWJrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:47:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FCB61042;
        Tue, 23 Mar 2021 02:47:53 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23A0B3F719;
        Tue, 23 Mar 2021 02:47:51 -0700 (PDT)
Subject: Re: [PATCH -next] coresight: etm-perf: Mark format_attr_contextid
 with static keyword
To:     Zou Wei <zou_wei@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210323075452.38920-1-zou_wei@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d455cc43-5ac1-4542-60e1-40fe8b85445b@arm.com>
Date:   Tue, 23 Mar 2021 09:47:50 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323075452.38920-1-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 07:54, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/hwtracing/coresight/coresight-etm-perf.c:61:25: warning: symbol
> 'format_attr_contextid' was not declared. Should it be static?
> 

A fix is already queued in coresight/next.

Thanks

Suzuki
