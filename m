Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53AB32D814
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhCDQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:51:34 -0500
Received: from foss.arm.com ([217.140.110.172]:41442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238407AbhCDQvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:51:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 192D8D6E;
        Thu,  4 Mar 2021 08:50:23 -0800 (PST)
Received: from [10.57.63.81] (unknown [10.57.63.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84EED3F7D7;
        Thu,  4 Mar 2021 08:50:20 -0800 (PST)
Subject: Re: [PATCH v4 06/10] coresight: etm-perf: Update to activate selected
 configuration
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-7-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6e48bd1d-edab-f605-24ca-93da0f0e2d4c@arm.com>
Date:   Thu, 4 Mar 2021 16:50:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210128170936.9222-7-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 5:09 PM, Mike Leach wrote:
> Add calls to activate the selected configuration as perf starts
> and stops the tracing session.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
