Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4263DEDE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhHCMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:34:52 -0400
Received: from foss.arm.com ([217.140.110.172]:48818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234524AbhHCMeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:34:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C6D11FB;
        Tue,  3 Aug 2021 05:34:39 -0700 (PDT)
Received: from [10.57.36.239] (unknown [10.57.36.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878B43F40C;
        Tue,  3 Aug 2021 05:34:37 -0700 (PDT)
Subject: Re: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
To:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-4-james.clark@arm.com>
 <CAJ9a7Vjz_CMugYrLcAqr_aFsK6jYcqR3xLwJUi9KTXB3aPjnEQ@mail.gmail.com>
 <20210731063731.GC7437@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <9156d7a1-3676-ab98-2c38-26f9765b845c@arm.com>
Date:   Tue, 3 Aug 2021 13:34:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210731063731.GC7437@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/2021 07:37, Leo Yan wrote:
>>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>>> index 85168d87b2d7..65a863bdf5cc 100644
>>> --- a/tools/perf/arch/arm/util/cs-etm.c
>>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>>> @@ -53,6 +53,7 @@ static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
>>>         [CS_ETMV4_TRCIDR2]              = "trcidr/trcidr2",
>>>         [CS_ETMV4_TRCIDR8]              = "trcidr/trcidr8",
>>>         [CS_ETMV4_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
>>> +       [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch"
> ETMv4 supports TRCDEVARCH, so I think it's good to use the naming
> "CS_ETMV4_TRCDEVARCH"?
> 

Based on the other discussions do you still think I should do this?

As part of the new magic number I moved it into a new enum so it
might be clearer now?

James
