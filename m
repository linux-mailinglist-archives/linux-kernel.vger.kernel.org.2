Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C833DEDE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhHCMdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:33:17 -0400
Received: from foss.arm.com ([217.140.110.172]:48782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234524AbhHCMdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:33:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5475411FB;
        Tue,  3 Aug 2021 05:33:05 -0700 (PDT)
Received: from [10.57.36.239] (unknown [10.57.36.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1499C3F40C;
        Tue,  3 Aug 2021 05:33:02 -0700 (PDT)
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
Message-ID: <6d1954d2-28bc-4b70-25fc-e74d63cc86cd@arm.com>
Date:   Tue, 3 Aug 2021 13:33:01 +0100
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
> I checked ETMv4.3 and ETMv4.4 spec (ARM IHI0064E for ETMv4.3 and ARM
> IHI0064F for ETMv4.4), both clarify ETMv4 has the register TRCDEVARCH;
> thus TRCDEVARCH is not a new register introduced by ETE.
> 
> For this case, it's good to directly add a new field in the metadata
> array for recording register TRCDEVARCH.

This might be true, but the OpenCSD library doesn't take TRCDEVARCH as a config
parameter for ETMv4 so it couldn't be used. This is the struct:

        typedef struct _ocsd_etmv4_cfg 
        {
        uint32_t                reg_idr0;    /**< ID0 register */
        uint32_t                reg_idr1;    /**< ID1 register */
        uint32_t                reg_idr2;    /**< ID2 register */
        uint32_t                reg_idr8;
        uint32_t                reg_idr9;   
        uint32_t                reg_idr10;
        uint32_t                reg_idr11;
        uint32_t                reg_idr12;
        uint32_t                reg_idr13;
        uint32_t                reg_configr;  /**< Config Register */
        uint32_t                reg_traceidr;  /**< Trace Stream ID register */
        ocsd_arch_version_t    arch_ver;   /**< Architecture version */
        ocsd_core_profile_t    core_prof;  /**< Core Profile */
        } ocsd_etmv4_cfg;

And this is ETE where TRCDEVARCH is used:

        typedef struct _ocsd_ete_cfg
        {
        uint32_t                reg_idr0;       /**< ID0 register */
        uint32_t                reg_idr1;       /**< ID1 register */
        uint32_t                reg_idr2;       /**< ID2 register */
        uint32_t                reg_idr8;       /**< ID8 - maxspec */
        uint32_t                reg_devarch;    /**< DevArch register */
        uint32_t                reg_configr;    /**< Config Register */
        uint32_t                reg_traceidr;   /**< Trace Stream ID register */
        ocsd_arch_version_t    arch_ver;        /**< Architecture version */
        ocsd_core_profile_t    core_prof;       /**< Core Profile */
        } ocsd_ete_cfg;

Thanks
James
