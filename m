Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DBA433CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhJSRHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:07:42 -0400
Received: from foss.arm.com ([217.140.110.172]:52118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhJSRHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:07:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A380BD6E;
        Tue, 19 Oct 2021 10:05:27 -0700 (PDT)
Received: from [10.57.21.130] (unknown [10.57.21.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A8363F694;
        Tue, 19 Oct 2021 10:05:26 -0700 (PDT)
Subject: Re: [PATCH] PM: EM: do not allow pd creation prior to debugfs
 initialization
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>
Cc:     rafael.j.wysocki@intel.com, qperret@google.com,
        daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20211019152819.6141-1-clingutla@codeaurora.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e01188a0-1dc7-db57-309f-f49390216875@arm.com>
Date:   Tue, 19 Oct 2021 18:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20211019152819.6141-1-clingutla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/21 4:28 PM, Lingutla Chandrasekhar wrote:
> em_dev_register_perf_domain() can be called from any initcall level before

The EM is registered by cpufreq drivers (or devfreq), which is later
than fs_initcall, so the debugfs is setup. We even have added recently
a dedicated callback into the cpufreq (register_em()) for that.

Do you have such code which registers EM for CPUs (or some devfreq)
earlier than this fs_initcall?

I cannot find such code in mainline.

Regards,
Lukasz
