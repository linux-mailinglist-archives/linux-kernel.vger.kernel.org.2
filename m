Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF3306BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 04:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhA1DdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 22:33:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:64683 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhA1DdV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:33:21 -0500
IronPort-SDR: 4GAoTuFXJmimnhVoeJMHbsuMuW6d78TNmCrjuwRnvnOmEg3LADJ8t8JYPJ400v1wAVVGLsKDw/
 CgaqsMUhCbQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="241701780"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="241701780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 19:31:33 -0800
IronPort-SDR: /Jc3c5jYCj7kC1arPXYY9H/0QUKyDtq7ivr/H3f0v0YmkuXskfIvnjXSTUxpWD03sHZaOGpmQX
 QKdh4vvviHnQ==
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="388577104"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 19:31:28 -0800
Subject: Re: [PATCH 1/2] perf script: Support filtering by hex address
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210124232750.19170-1-yao.jin@linux.intel.com>
 <20210127222905.GD284633@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <60d102fa-d98a-6182-0a1d-b78122fed574@linux.intel.com>
Date:   Thu, 28 Jan 2021 11:31:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210127222905.GD284633@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 1/28/2021 7:13 AM, Jiri Olsa wrote:
>> @@ -709,6 +725,26 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>>   			ret = strlist__has_entry(symbol_conf.sym_list,
>>   						al_addr_str);
>>   		}
>> +		if (!ret && al->map) {
>> +			snprintf(al_addr_str, sz, "0x%"PRIx64,
>> +				al->map->unmap_ip(al->map, al->addr));
>> +			ret = strlist__has_entry(symbol_conf.sym_list,
>> +						 al_addr_str);
>> +			if (!ret) {
>> +				/* Check for hex without "0x" prefix */
>> +				snprintf(al_addr_str, sz, "%"PRIx64,
>> +					al->map->unmap_ip(al->map, al->addr));
>> +				ret = strlist__has_entry(symbol_conf.sym_list,
>> +							 al_addr_str);
>> +			}
> that seems tricky.. what if user specify more leading zeros,
> I think it'd be better to search intlist instead
> 
> we could move all 'address' entries from sym_list to
> new intlist (in symbol__init) and use it for this search
> 
> jirka
> 

intlist now only supports 'int' type.

I'm considering to use 'long' to replace original 'int' in struct int_node.

struct int_node {
	struct rb_node rb_node;
-	int i;
+	long i;
	void *priv;
};

On 32 bits platform, sizeof(long) is 4, and on 64 bits platform, sizeof(long) is 8. So that should 
be OK for storing the values such as pid/tid and address.

I'm not very clear why currently it uses 'int' for i in struct int_node, maybe something I don't 
understand correctly. Please correct me if my understanding is wrong.

Thanks
Jin Yao





