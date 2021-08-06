Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A723E2796
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbhHFJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:43:46 -0400
Received: from foss.arm.com ([217.140.110.172]:56838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242680AbhHFJnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:43:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D52F31B;
        Fri,  6 Aug 2021 02:43:29 -0700 (PDT)
Received: from [10.57.40.41] (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38AA43F719;
        Fri,  6 Aug 2021 02:43:27 -0700 (PDT)
Subject: Re: [PATCH 6/6] perf cs-etm: Print the decoder name
To:     Leo Yan <leo.yan@linaro.org>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-7-james.clark@arm.com>
 <20210731073037.GF7437@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <077ebe58-f692-9adb-9cb5-ed35a9b508c1@arm.com>
Date:   Fri, 6 Aug 2021 10:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731073037.GF7437@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/2021 08:30, Leo Yan wrote:
>> @@ -658,7 +658,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>>  
>>  		return 0;
>>  	} else if (d_params->operation == CS_ETM_OPERATION_PRINT) {
>> -		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
>> +		if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder->decoder_name,
>>  					   OCSD_CREATE_FLG_PACKET_PROC,
>>  					   trace_config, &csid))
>>  			return -1;
>> @@ -790,3 +790,8 @@ void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
>>  	decoder->dcd_tree = NULL;
>>  	free(decoder);
>>  }
>> +
>> +const char *cs_etm_decoder__get_name(struct cs_etm_decoder *decoder)
>> +{
>> +	return decoder->decoder_name;
>> +}
> Maybe can consider to place this function into the header file with
> "static inline" specifier.

I tried this, but because the struct is defined in the .c file it can't
be done without moving the struct to the header. It's also only used
for the --dump-raw-trace path so performance isn't critical anyway.

James

> 
> Either way, this patch looks good to me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
