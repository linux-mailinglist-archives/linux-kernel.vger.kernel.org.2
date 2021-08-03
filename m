Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E42A3DEDF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhHCMg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:36:26 -0400
Received: from foss.arm.com ([217.140.110.172]:48870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235877AbhHCMgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:36:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32DBC11FB;
        Tue,  3 Aug 2021 05:36:14 -0700 (PDT)
Received: from [10.57.36.239] (unknown [10.57.36.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49413F40C;
        Tue,  3 Aug 2021 05:36:11 -0700 (PDT)
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
Message-ID: <ed38005f-7723-6b62-ebcb-3db750604b6a@arm.com>
Date:   Tue, 3 Aug 2021 13:36:10 +0100
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
>>> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
>>> index d65c7b19407d..52d82dce9d59 100644
>>> --- a/tools/perf/util/cs-etm.h
>>> +++ b/tools/perf/util/cs-etm.h
>>> @@ -59,7 +59,7 @@ enum {
>>>  /* define fixed version 0 length - allow new format reader to read old files. */
>>>  #define CS_ETM_NR_TRC_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
>>>
>>> -/* ETMv4 metadata */
>>> +/* ETMv4 + ETE metadata */
>>>  enum {
>>>         /* Dynamic, configurable parameters */
>>>         CS_ETMV4_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
>>> @@ -70,7 +70,8 @@ enum {
>>>         CS_ETMV4_TRCIDR2,
>>>         CS_ETMV4_TRCIDR8,
>>>         CS_ETMV4_TRCAUTHSTATUS,
>>> -       CS_ETMV4_PRIV_MAX,
>>> +       CS_ETE_TRCDEVARCH,
>>> +       CS_ETMV4_PRIV_MAX
> Spurious change for "CS_ETMV4_PRIV_MAX"?

This change will be removed in the next version due to moving it into
a new enum. But it wasn't a mistake, CS_ETMV4_PRIV_MAX is used to define the length
of the header so it always needs to be at the end if another item is saved.

James
