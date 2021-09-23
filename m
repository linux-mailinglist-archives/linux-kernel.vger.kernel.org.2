Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F491415AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbhIWJdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:33:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240033AbhIWJdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:33:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55EFD106F;
        Thu, 23 Sep 2021 02:31:34 -0700 (PDT)
Received: from [10.57.95.68] (unknown [10.57.95.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67D453F59C;
        Thu, 23 Sep 2021 02:31:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add Coresight support for RB5 board
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
References: <1631515214-13653-1-git-send-email-quic_taozha@quicinc.com>
 <07bba970-2315-4284-cd3e-d69a3028a406@arm.com>
 <20210923091627.GA7576@taozha-gv.ap.qualcomm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c73f4216-862a-25c9-bff0-c038b521ce2d@arm.com>
Date:   Thu, 23 Sep 2021 10:31:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923091627.GA7576@taozha-gv.ap.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 10:16, Tao Zhang wrote:
> On Tue, Sep 21, 2021 at 05:31:34PM +0100, Suzuki K Poulose wrote:
>> Hi Tao
>>
>> On 13/09/2021 07:40, Tao Zhang wrote:
>>> This series adds Coresight support for SM8250 Soc on RB5 board.
>>> It is composed of two elements.
>>> a) Add ETM PID for Kryo-5XX.
>>> b) Add coresight support to DTS for RB5.
>>>
>>> This series applies to coresight/next
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>
>>
>> Please could you mention what has changed since the previous version
>> in the cover letter ?
>>
>> Kind regards
>> Suzuki
>>
> The version 2 of the series add more comments "Cortex-A77" for ETM pid.
> Do I need to rewrite the cover letter and then resubmit it for review?

No need to resubmit the series for reveiwing the patch. Ultimately
patches are what matters. But it is a good practise to keep the
changelog in the cover letter for a revision of a series. That helps
the reviewers to understand what has changed and we all are able to
spend our time efficiently. So, please follow that if possible.

Thanks
Suzuki
