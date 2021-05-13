Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D837F937
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhEMN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:57:57 -0400
Received: from foss.arm.com ([217.140.110.172]:36084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234287AbhEMN5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:57:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FD81169E;
        Thu, 13 May 2021 06:56:26 -0700 (PDT)
Received: from [10.57.62.72] (unknown [10.57.62.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D850C3F73B;
        Thu, 13 May 2021 06:56:24 -0700 (PDT)
Subject: Re: [PATCH 0/3] coresight: Few cleanups
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
References: <1620912469-52222-1-git-send-email-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c8d08614-f60c-2f6e-4b9d-1266e6bea49d@arm.com>
Date:   Thu, 13 May 2021 14:56:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1620912469-52222-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2021 14:27, Qi Liu wrote:
> This patchset is just a clean up and should not cause a functional change.
> 
> Junhao He (3):
>    coresight: core: Fix use of uninitialized pointer
>    coresight: core: Remove unnecessary assignment
>    coresight: etm4x: core: Remove redundant check of attr
> 
>   drivers/hwtracing/coresight/coresight-core.c       | 3 +--
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 5 -----
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 

Thanks for the cleanups. I will queue them

Suzuki
