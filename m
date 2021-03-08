Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB38330DB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhCHMbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:31:47 -0500
Received: from foss.arm.com ([217.140.110.172]:37162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhCHMb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:31:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62486D6E;
        Mon,  8 Mar 2021 04:31:25 -0800 (PST)
Received: from [10.57.54.134] (unknown [10.57.54.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E887D3F70D;
        Mon,  8 Mar 2021 04:31:23 -0800 (PST)
Subject: Re: [PATCH -next] coresight: etm: perf: Make symbol
 'format_attr_contextid' static
To:     'Wei Yongjun <weiyongjun1@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210308123250.2417947-1-weiyongjun1@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <af3639c0-3671-46d4-5093-4c7a71b3f6b5@arm.com>
Date:   Mon, 8 Mar 2021 12:31:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308123250.2417947-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 12:32 PM, 'Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The sparse tool complains as follows:
> 
> drivers/hwtracing/coresight/coresight-etm-perf.c:61:25: warning:
>   symbol 'format_attr_contextid' was not declared. Should it be static?
> 
> This symbol is not used outside of coresight-etm-perf.c, so this
> commit marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
