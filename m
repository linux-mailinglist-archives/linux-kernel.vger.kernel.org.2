Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A932656A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBZQTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:19:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2609 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhBZQTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:19:09 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DnF764xS7z67sCn;
        Sat, 27 Feb 2021 00:12:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 17:18:22 +0100
Received: from [10.47.0.216] (10.47.0.216) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Feb
 2021 16:18:21 +0000
Subject: Re: [PATCH] perf vendor events: Remove 'type' field from mapfiles
To:     Andi Kleen <ak@linux.intel.com>
CC:     <peterz@infradead.org>, <acme@kernel.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <irogers@google.com>, <kjain@linux.ibm.com>,
        <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <linuxarm@huawei.com>
References: <1614344897-229717-1-git-send-email-john.garry@huawei.com>
 <20210226154737.GY472138@tassilo.jf.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d2b754c2-0994-34a2-c42e-d8323beaf8c5@huawei.com>
Date:   Fri, 26 Feb 2021 16:16:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210226154737.GY472138@tassilo.jf.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.216]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2021 15:47, Andi Kleen wrote:
> On Fri, Feb 26, 2021 at 09:08:17PM +0800, John Garry wrote:
>> Included for each CPU entry in the per-arch mapfile.csv file is a 'type'
>> field.
> I don't like it because this will make the mapfile incompatible with
> what download.01.org uses. We originally derived it from that.

I assumed that it was this file:
https://download.01.org/perfmon/mapfile.csv

which already has a different format - extra columns - so figured that 
some handcrafting was already going on. Indeed 'type' is not always 
'core' there.

 >
 > It would be ok if it fixed something serious, but as it seems to be
 > more cosmetic I don't think there's a good reason to devivate.
 >

If you're against that, then ok; I suppose jevents handling could still 
be removed, but I'm not enthused.

Thanks,
John


