Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF25430B156
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhBAUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:06:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232301AbhBAUGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:06:35 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111K5Ovk041924;
        Mon, 1 Feb 2021 15:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5iosLxrCvAZBRRZ41e5Btkx4diiJqruG2aej/1qf8wQ=;
 b=K0q7ElVWojYXF9sq37Rv0p4AoFkT5bP37PkgZUwAjqqwa/8DxCSJ/VUBIAjb83xwowzp
 FHKaDEhQD9/VXQ1XYukXabJABwEGKuI4nBjqtdZoTcsFjwLmNCN9Ozaxgw1zG9Jnknf9
 T4FsdCBdsbl7A5hQF6ZHhx9cRg8PiSkrrKS1qI7qPh3namV6bOR+EKN1OpEVJajubgth
 Kl7OEURsul4NePVMfS8rgjpGPMq/en7GacjASdFBDxOwVONxVR1g56Kspgh6GebJi5LC
 DTFyn9e0qDpR7S0aEFXXGKpFrzJq3jXgboop+DllugfmYF5Ir0z+30dPuMnsd7hZiC2P jA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36er9fg1v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 15:05:31 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111K1u6J007112;
        Mon, 1 Feb 2021 20:02:19 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 36ehekbm41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 20:02:19 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111K2JeU23658828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 20:02:19 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16DA3AE067;
        Mon,  1 Feb 2021 20:02:19 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8DFCAE05F;
        Mon,  1 Feb 2021 20:02:17 +0000 (GMT)
Received: from [9.163.45.205] (unknown [9.163.45.205])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 20:02:17 +0000 (GMT)
Subject: Re: [PATCH] pmbus:max31785: Support revision "B"
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com
Cc:     joel@jms.id.au, andrew@aj.id.au
References: <20210201165043.36751-1-msbarth@linux.ibm.com>
 <96fd0466-13be-dea1-985c-19cccbd3d321@roeck-us.net>
From:   Matthew Barth <msbarth@linux.ibm.com>
Message-ID: <04d06367-2e70-53a3-d0af-8d67d51fcd22@linux.ibm.com>
Date:   Mon, 1 Feb 2021 14:02:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <96fd0466-13be-dea1-985c-19cccbd3d321@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_08:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/21 1:43 PM, Guenter Roeck wrote:
> On 2/1/21 8:50 AM, Matthew Barth wrote:
>> There was an issue in how the tach feedbacks of dual rotor fans were
>> reported during any change in fan speeds with revision "A" of the
>> MAX31785. When the fan speeds would transition to a new target speed,
>> the rotor not wired to the TACH input when TACHSEL = 0 would report a
>> speed of 0 until the new target was reached. This has been fixed,
>> resulting in a revision "B" update where the MFR_REVISION of "B" is
>> 0x3061.
>>
> Is that published somewhere ?
If you're referring to the issue noted, it is not explicitly published 
anywhere that I'm aware of other than being functionally described on 
pg22 within the MAX31785 datasheet under the 'Dual Fan Applicaitons' 
paragraph(https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf). We 
have worked with Maxim to get this addressed as the method of latching 
the TACHSEL during speed transitions gives windows of being unable to 
detect fan failures of the rotor that is not being read during the 
transition.

In reference to revision "B" being published, Maxim provided a couple 
samples with the issue noted fixed where it was noticed the MFR_REVISION 
bumped to 0x3061. After I had verified the functionality of this 
revision, they have started production of 31785's with this revision "B" 
firmware. I can not speak to if/when they will update their datasheet.
>
>> Signed-off-by: Matthew Barth <msbarth@linux.ibm.com>
>> ---
>>   drivers/hwmon/pmbus/max31785.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
>> index e5a9f4019cd5..e636a65061df 100644
>> --- a/drivers/hwmon/pmbus/max31785.c
>> +++ b/drivers/hwmon/pmbus/max31785.c
>> @@ -17,6 +17,7 @@ enum max31785_regs {
>>   
>>   #define MAX31785			0x3030
>>   #define MAX31785A			0x3040
>> +#define MAX31785B			0x3061
>>   
>>   #define MFR_FAN_CONFIG_DUAL_TACH	BIT(12)
>>   
>> @@ -350,12 +351,13 @@ static int max31785_probe(struct i2c_client *client)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	if (ret == MAX31785A) {
>> +	if (ret == MAX31785A || ret == MAX31785B) {
>>   		dual_tach = true;
>>   	} else if (ret == MAX31785) {
>>   		if (!strcmp("max31785a", client->name))
> Probably also wants to check for max31785b,
Good call, will do!
>
>>   			dev_warn(dev, "Expected max3175a, found max31785: cannot provide secondary tachometer readings\n");
> and say something like "Expected max3175a/b, ..."

Thanks,

Matt

>
> Thanks,
> Guenter
>
>>   	} else {
>> +		dev_err(dev, "Unrecognized MAX31785 revision: %x\n", ret);
>>   		return -ENODEV;
>>   	}
>>   
>> @@ -371,6 +373,7 @@ static int max31785_probe(struct i2c_client *client)
>>   static const struct i2c_device_id max31785_id[] = {
>>   	{ "max31785", 0 },
>>   	{ "max31785a", 0 },
>> +	{ "max31785b", 0 },
>>   	{ },
>>   };
>>   
>> @@ -379,6 +382,7 @@ MODULE_DEVICE_TABLE(i2c, max31785_id);
>>   static const struct of_device_id max31785_of_match[] = {
>>   	{ .compatible = "maxim,max31785" },
>>   	{ .compatible = "maxim,max31785a" },
>> +	{ .compatible = "maxim,max31785b" },
>>   	{ },
>>   };
>>   
>>
