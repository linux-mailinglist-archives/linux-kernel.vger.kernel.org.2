Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D713DEDDC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhHCMaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:30:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235709AbhHCMaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:30:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2831B11FB;
        Tue,  3 Aug 2021 05:29:49 -0700 (PDT)
Received: from [10.57.36.239] (unknown [10.57.36.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6EEC3F40C;
        Tue,  3 Aug 2021 05:29:46 -0700 (PDT)
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
 <20210731074343.GG7437@leoy-ThinkPad-X240s>
 <CAJ9a7Vj_KhV+v6VU+EQN5t818VS9jvf3v3-2JbwVMOHZbi3gcg@mail.gmail.com>
 <20210802120545.GJ7437@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <ef068f6a-0a31-bd34-7140-5d7cca331369@arm.com>
Date:   Tue, 3 Aug 2021 13:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210802120545.GJ7437@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2021 13:05, Leo Yan wrote:
> If so, I understand your suggestion in another email to add a new magic
> number and a new protocol (this patch set has added the new protocol
> CS_ETM_PROTO_ETE) for creating ETE decoder.

Yes this is what I'm working on now. I think that it's actually
cleaner than the previous change where there was some half way
solution that old versions of perf wouldn't properly decode ETE
but would try to anyway.

James
