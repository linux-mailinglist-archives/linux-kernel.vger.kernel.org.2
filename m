Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB931345BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCWKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:12:20 -0400
Received: from foss.arm.com ([217.140.110.172]:43406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCWKLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF18F1042;
        Tue, 23 Mar 2021 03:11:53 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE6B63F719;
        Tue, 23 Mar 2021 03:11:52 -0700 (PDT)
Subject: Re: [PATCH v2] coresight: core: Fix typo in coresight-core.c
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@openeuler.org
References: <1616487086-50418-1-git-send-email-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <63e996a1-e97b-111d-90af-bd3c5a47fde4@arm.com>
Date:   Tue, 23 Mar 2021 10:11:51 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616487086-50418-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 08:11, Qi Liu wrote:
> Fix the following checkpatch warning:
> WARNING: 'compoment' may be misspelled - perhaps 'component'?
> 
> Fixes: 8e264c52e1da  ("coresight: core: Allow the coresight core driver to be built as a module")

I will queue this one, dropping the above Fixes tag. In general, you 
don't need Fixes tag for anything that doesn't really fix functional
bug.

Suzuki
