Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B836433FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhJSUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:19:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230147AbhJSUTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:19:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JK9rhu005044;
        Tue, 19 Oct 2021 16:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rVj213Pa+swcNgnKPkD9V8W6vlMuPjhztU8MOKsDiIg=;
 b=tpVDnqBp0ZVgcIZv4vqiVyx1WRzAKdGjHt6RasXVr7uQefA/fFjpAL0W5WK7foEouBN+
 7U2tjXYwqgA4LGB1vWxA3Zi1WmS5vjZu5zOSvSezTPR3w4DgtmPm7bsP+kRMfC2a1c8V
 MPmAXKWDrbtGH7td1Res3r3o8bua4oT5wWvEWsCKPBU+d70B9MtMwHhehvZ1f2scRlsJ
 X6ocB87to64fBZlUtSKywbu37v8SBj8hyoyqLTQp4GrwpbOjV2iIej+7clY1zNGjF9bB
 uhhPi7jGvtxfnWA6gMmKChvroygRcBf2hlXvljkwraEbJk/9RViu3LEsu5Uz9DZzEnei bw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt362am8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 16:16:25 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JKDG2q015488;
        Tue, 19 Oct 2021 20:16:24 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3bqpcbnrpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 20:16:24 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JKGNeA30081498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:16:23 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F96D6E054;
        Tue, 19 Oct 2021 20:16:23 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 135486E050;
        Tue, 19 Oct 2021 20:16:22 +0000 (GMT)
Received: from [9.211.36.93] (unknown [9.211.36.93])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 20:16:22 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] fsi: occ: Store the SBEFIFO FFDC in the user
 response buffer
To:     Joel Stanley <joel@jms.id.au>, Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
References: <20210927155925.15485-1-eajames@linux.ibm.com>
 <20210927155925.15485-3-eajames@linux.ibm.com>
 <CACPK8XfAL2-07M+ZWZ74X42Mvo8UvAdKPJ-51YWgKb_nzS-ffQ@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <48d997c0-5b2e-40d2-ef66-594b4275fd1a@linux.ibm.com>
Date:   Tue, 19 Oct 2021 15:16:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XfAL2-07M+ZWZ74X42Mvo8UvAdKPJ-51YWgKb_nzS-ffQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Js8iOWMfW4xoVB4sbLjUn3yig-qmHN70
X-Proofpoint-ORIG-GUID: Js8iOWMfW4xoVB4sbLjUn3yig-qmHN70
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/15/21 12:05 AM, Joel Stanley wrote:
> On Mon, 27 Sept 2021 at 15:59, Eddie James <eajames@linux.ibm.com> wrote:
>> If the SBEFIFO response indicates an error, store the response in the
>> user buffer and return an error. Previously, the user had no way of
>> obtaining the SBEFIFO FFDC.
> How does this look for userspace?


The user's buffer now contains data in the event of a failure. No change 
in the event of a successful transfer.


>
> Will existing userspace handle this?


Yes, unless a poorly-designed application is relying on the data being 
the same after a failed transfer... In that case I would argue that the 
application should be fixed.


>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v1:
>>   - Don't store any magic value; only return non-zero resp_len in the error
>>     case if there is FFDC
>>
>>   drivers/fsi/fsi-occ.c | 66 ++++++++++++++++++++++++++++++-------------
>>   1 file changed, 47 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
>> index ace3ec7767e5..1d5f6fdc2a34 100644
>> --- a/drivers/fsi/fsi-occ.c
>> +++ b/drivers/fsi/fsi-occ.c
>> @@ -55,6 +55,9 @@ struct occ {
>>          int idx;
>>          u8 sequence_number;
>>          void *buffer;
>> +       void *client_buffer;
>> +       size_t client_buffer_size;
>> +       size_t client_response_size;
>>          enum versions version;
>>          struct miscdevice mdev;
>>          struct mutex occ_lock;
>> @@ -217,6 +220,20 @@ static const struct file_operations occ_fops = {
>>          .release = occ_release,
>>   };
>>
>> +static void occ_save_ffdc(struct occ *occ, __be32 *resp, size_t parsed_len,
>> +                         size_t resp_len)
>> +{
>> +       size_t dh = resp_len - parsed_len;
> Is there any chance that parsed_len is larger than resp_len?


No, based on the sbefifo_parse_status function.


>
>> +       size_t ffdc_len = (dh - 1) * 4;
>> +       __be32 *ffdc = &resp[resp_len - dh];
> Should you be checking that this number is sensible?


Do you mean ffdc_len or (resp_len - dh)? I was basing all this on the 
sbefifo_parse_status code, but I see that obviously:

resp_len - dh = resp_len - (resp_len - parsed_len) = parsed_len

So I will simplify.

As for ffdc_len, it is conceivable that dh is 0, so I will add a check 
for that.



Thanks Joel!

Eddie


>
>> +
>> +       if (ffdc_len > occ->client_buffer_size)
>> +               ffdc_len = occ->client_buffer_size;
>> +
>> +       memcpy(occ->client_buffer, ffdc, ffdc_len);
>> +       occ->client_response_size = ffdc_len;
>> +}
