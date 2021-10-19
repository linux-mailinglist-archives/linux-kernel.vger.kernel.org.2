Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954C3433FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhJSUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:25:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5330 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230147AbhJSUZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:25:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JIktE8006814;
        Tue, 19 Oct 2021 16:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8NLFH5fbVdP9Er8HhEGWHKSRTlljO8FNwgquJOLESNs=;
 b=MvVAOcCLONqVzxaOuUXiPNFbhm7dByqDIcRdokRs9izAx2Ml7ClXzLb2i5QBW9W98yAh
 15aBd0BfV90kWWvmA/pJvL0//+h22TtV8vUQ6fLsO2RQzr2ChjsQeaH+XR1FCRfJ03oD
 jUW6pbe8uZp84zIdx25UzVO3DqTiUcrJCWyii14m6Q5mEK+7MVVu7fM+7uiPPRxO1PS9
 0zZameGIMLqPkr+jUzbhsUyMGSS90EPnb1W3oFl+R8sMi/euw/I8yHdbX8QNusy8487m
 4GAV2mbaVlIBbo1mm1TSLs9ubp3nIdp4KGDqTjohLB82LO4LEwcsgPpcn/7U+/UYL4n/ 1A== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bt2stka8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 16:22:28 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JKE4ES024493;
        Tue, 19 Oct 2021 20:22:28 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 3bqpcbpw5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 20:22:28 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JKMRYZ35258724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:22:27 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B6FE6E064;
        Tue, 19 Oct 2021 20:22:27 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B045F6E05B;
        Tue, 19 Oct 2021 20:22:26 +0000 (GMT)
Received: from [9.211.36.93] (unknown [9.211.36.93])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 20:22:26 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] fsi: occ: Use a large buffer for responses
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
References: <20210927155925.15485-1-eajames@linux.ibm.com>
 <20210927155925.15485-2-eajames@linux.ibm.com>
 <CACPK8XdQ9wdg=VxRb0atd8P7PpFZTsWZwsYEkWsbmbR20DKKBQ@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <eed5470f-f186-4ff0-607b-e90fceb52d15@linux.ibm.com>
Date:   Tue, 19 Oct 2021 15:22:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XdQ9wdg=VxRb0atd8P7PpFZTsWZwsYEkWsbmbR20DKKBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nUK75m6ubKQ1XWdEagbvSWf_tAUJaITU
X-Proofpoint-ORIG-GUID: nUK75m6ubKQ1XWdEagbvSWf_tAUJaITU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/15/21 12:05 AM, Joel Stanley wrote:
> On Mon, 27 Sept 2021 at 15:59, Eddie James <eajames@linux.ibm.com> wrote:
>> Allocate a large buffer for each OCC to handle response data. This
>> removes memory allocation during an operation, and also allows for
>> the maximum amount of SBE FFDC.
> Why do we need this change? (is it fixing a bug, did the host change,
> is it an unimplemented feature, etc)


It allows for the maximum amount of SBE FFDC, so an unimplemented 
feature. Previously for the putsram and attn commands, only 32 words 
would have been available, and for getsram, only up to the size of the 
transfer. SBE FFDC might be up to 8Kb.


>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-occ.c   | 109 ++++++++++++++++------------------------
>>   include/linux/fsi-occ.h |   2 +
>>   2 files changed, 45 insertions(+), 66 deletions(-)
>>
>> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
>> index b0c9322078a1..ace3ec7767e5 100644
>> --- a/drivers/fsi/fsi-occ.c
>> +++ b/drivers/fsi/fsi-occ.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/list.h>
>>   #include <linux/miscdevice.h>
>> +#include <linux/mm.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>>   #include <linux/fsi-occ.h>
>> @@ -42,13 +43,6 @@
>>
>>   #define OCC_P10_SRAM_MODE      0x58    /* Normal mode, OCB channel 2 */
>>
>> -/*
>> - * Assume we don't have much FFDC, if we do we'll overflow and
>> - * fail the command. This needs to be big enough for simple
>> - * commands as well.
>> - */
>> -#define OCC_SBE_STATUS_WORDS   32
>> -
>>   #define OCC_TIMEOUT_MS         1000
>>   #define OCC_CMD_IN_PRG_WAIT_MS 50
>>
>> @@ -60,6 +54,7 @@ struct occ {
>>          char name[32];
>>          int idx;
>>          u8 sequence_number;
>> +       void *buffer;
>>          enum versions version;
>>          struct miscdevice mdev;
>>          struct mutex occ_lock;
>> @@ -250,8 +245,10 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
>>   static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
>>   {
>>          u32 data_len = ((len + 7) / 8) * 8;     /* must be multiples of 8 B */
>> -       size_t cmd_len, resp_len, resp_data_len;
>> -       __be32 *resp, cmd[6];
>> +       size_t cmd_len, resp_data_len;
>> +       size_t resp_len = OCC_MAX_RESP_WORDS;
>> +       __be32 *resp = occ->buffer;
>> +       __be32 cmd[6];
>>          int idx = 0, rc;
>>
>>          /*
>> @@ -278,19 +275,19 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
>>          cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_OCC_SRAM);
>>          cmd[4 + idx] = cpu_to_be32(data_len);
>>
>> -       resp_len = (data_len >> 2) + OCC_SBE_STATUS_WORDS;
>> -       resp = kzalloc(resp_len << 2, GFP_KERNEL);
> Previously the driver would zero the buffer before using it. Should
> you add a memset here?


Based on the rest of the code, I don't see that it's necessary for it be 
initialized to 0.


>
>> @@ -635,6 +605,10 @@ static int occ_probe(struct platform_device *pdev)
>>          if (!occ)
>>                  return -ENOMEM;
>>
>> +       occ->buffer = kvmalloc(OCC_MAX_RESP_WORDS * 4, GFP_KERNEL);
> Why do you allocate WORDS * 4?


I suppose it's an assumption that words are 4 bytes, but the SBE 
operates that way. I will add a #define for it at least. I didn't want 
to define 8192 because the SBE expects the length in words, so I'd 
rather multiply in one place than divide in several places.


>
>> diff --git a/include/linux/fsi-occ.h b/include/linux/fsi-occ.h
>> index d4cdc2aa6e33..7ee3dbd7f4b3 100644
>> --- a/include/linux/fsi-occ.h
>> +++ b/include/linux/fsi-occ.h
>> @@ -19,6 +19,8 @@ struct device;
>>   #define OCC_RESP_CRIT_OCB              0xE3
>>   #define OCC_RESP_CRIT_HW               0xE4
>>
>> +#define OCC_MAX_RESP_WORDS             2048
> Does this need to go in the header?


Yes, the hwmon driver needs it.


