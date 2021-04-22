Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67773688BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 23:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbhDVVvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 17:51:13 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:45152 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236763AbhDVVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:51:12 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MLmEfK004055;
        Thu, 22 Apr 2021 21:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pps0720;
 bh=iNdC/uGhdlQFKij68vl/US1UmD9Kxg0qHkSQJC+u0O8=;
 b=dGxqzGaul4kf/ZlF+iKMxvC3Urj7S6nG3DizjZBL2kma3TaWoIIFJ3Fl3r+UbbaFvX/1
 AoTNQ59cf1YYDF8he5ZKkfJn+WDqBSudxBVXgQlPTUGJkOq5Y4ndP1QRKvzLS7fqiKOQ
 A7eqD0FeXOOvgLo7ysvFU34p+ZX1aFZUZOh8feZMtVFZ1pf68nF9/Sp7CWSrRqmocW3Z
 S3zc9RZRWzGjls8OfbIpu9HW1aPxwl4WlROJOu6yMGdr3Re7aNj7DpM5VZvP1VxHVo/M
 OJkiqo7URY0WeStsRWrWlSU/ltwrTFFOz+urycxdUanAdRZTD+p+Xi8yVkxfDE6doJTv DQ== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 3830xc8jhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 21:50:30 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 1930D4E;
        Thu, 22 Apr 2021 21:50:29 +0000 (UTC)
Received: from [16.99.148.179] (unknown [16.99.148.179])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 3FE5348;
        Thu, 22 Apr 2021 21:50:28 +0000 (UTC)
Subject: Re: arch/x86/kernel/apic/x2apic_uv_x.c:106 early_get_pnodeid() warn:
 inconsistent indenting
To:     Borislav Petkov <bp@suse.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Yang Li <yang.lee@linux.alibaba.com>
References: <202104211946.vkuV39N1-lkp@intel.com>
 <84b4fbc3-0310-b7d7-f613-0eb4ae090e1e@hpe.com>
 <20210422090652.GB6361@zn.tnic>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <e2e957f1-06f4-29b5-b268-7fd77db25529@hpe.com>
Date:   Thu, 22 Apr 2021 14:50:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422090652.GB6361@zn.tnic>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TJqp4bz8Adqie1NvLIlAtPQZLWdzNj9l
X-Proofpoint-ORIG-GUID: TJqp4bz8Adqie1NvLIlAtPQZLWdzNj9l
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_14:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Boris, I do have a clean up patch to remove more dead code 
coming, I'll put this patch in that if that's okay?

On 4/22/2021 2:06 AM, Borislav Petkov wrote:
> On Wed, Apr 21, 2021 at 06:38:37PM -0700, Mike Travis wrote:
>> I'm a bit confused.  I have this in my inbox that someone else has this fix.
>> So will that fix be applied or should I send a separate one that is
>> essentially a duplicate?
> 
> I'm not even considering that fix because I'm tired of getting some
> half-baked robot mails which only resemble patches. The obnoxiousness to
> not have the decency to sit down and write a proper commit message is
> getting totally out of control.
> 
> Apparently some people(?) think that sending robot output to real humans
> *without* even vetting that output is a good idea so off to /dev/null it
> goes.
> 
> If you want this fixed, you could do a proper patch with a sensible
> commit message and I'll take it.
> 
> I'm tired of dumb robots.
> 
> Thx.
> 
> 
