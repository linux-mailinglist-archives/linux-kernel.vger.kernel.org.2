Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC1339D9C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFGKgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:36:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230475AbhFGKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:36:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157AYBKH072859;
        Mon, 7 Jun 2021 06:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T++hfNLe/ur3y9fA7SllqMXKwq+JzB2NPZ6pChQMyM0=;
 b=aITs/QVZS+YDO80WzRkqsofwRd8m2LVC1wXbM1NNanvatBjoMRnA9DMKVMh7qSw3yJUg
 6F3UUyk6Wm5I27N2zWiwB7E+mbhs8BCyVqdMmBx3zhBpFoT2tK5NJ72XnJW9xGVbQcOy
 XZaxF2286OuZyJ+uZspR4BkqST/vAqL6j87hJY1eBc6a3jB/1NuaL4liFGCDqq72K2wJ
 M34prnYFWMoLlfv0nM9o8EreEBMNjrVAyACVTUrUqN070FdsZGlqrMeU2tn+rRdJOUTG
 v+QnDZaGzRFhbIHZe/VBa/iMgn+W4lVxmhJOYS4a1yAUAHGWcKh4ZMNT78SG7XIy/ZMq 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391gd4je65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 06:34:56 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 157AYFOm073218;
        Mon, 7 Jun 2021 06:34:56 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391gd4je44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 06:34:56 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 157AWeZN011779;
        Mon, 7 Jun 2021 10:34:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3900w8gf63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 10:34:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 157AYoAs25166228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jun 2021 10:34:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 627BFA404D;
        Mon,  7 Jun 2021 10:34:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3D11A4040;
        Mon,  7 Jun 2021 10:34:49 +0000 (GMT)
Received: from [9.145.179.244] (unknown [9.145.179.244])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jun 2021 10:34:49 +0000 (GMT)
Subject: Re: [PATCH wq/for-next 2/2] workqueue: let device core create the
 WQ_UNBOUND attributes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20210607094420.2054403-1-jwi@linux.ibm.com>
 <20210607094420.2054403-2-jwi@linux.ibm.com> <YL30jJsS+xWMjGVa@kroah.com>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <7b9366c0-13d9-a5ef-1a29-dd3510a831c0@linux.ibm.com>
Date:   Mon, 7 Jun 2021 13:34:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YL30jJsS+xWMjGVa@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3sx9yYtK4GFzy31CST8zu2JztmUH9c9l
X-Proofpoint-ORIG-GUID: 1B1x6L8XnmGOpqQnqs_wFphVGU7XorQe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_07:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.21 13:27, Greg Kroah-Hartman wrote:
> On Mon, Jun 07, 2021 at 11:44:20AM +0200, Julian Wiedmann wrote:
>> Wrap the attributes for a WQ_UNBOUND workqueue in ATTRIBUTE_GROUPS(),
>> and wire them up in dev->groups so that the device core can manage them
>> for us.
>>
>> As device_add() will add such attributes _prior_ to raising the KOBJ_ADD
>> uevent, this also makes the initial uevent suppression unnecessary.
>>
>> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
>> ---
>>  kernel/workqueue.c | 51 ++++++++++++++++++++--------------------------
>>  1 file changed, 22 insertions(+), 29 deletions(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 817dc2d7438a..629859ac5262 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -5449,6 +5449,9 @@ static ssize_t wq_pool_ids_show(struct device *dev,
>>  	return written;
>>  }
>>  
>> +static struct device_attribute wq_sysfs_unbound_attr_pool_ids =
>> +	__ATTR(pool_ids, 0444, wq_pool_ids_show, NULL);
> 
> __ATTR_RO() please.
> 

I did consider using DEVICE_ATTR_*(), yes. But renaming all the _show and _store
functions added too much unrelated churn for my taste. So let's maybe do this
as a follow-on?

>> +
>>  static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
>>  			    char *buf)
>>  {
>> @@ -5502,6 +5505,9 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
>>  	return ret ?: count;
>>  }
>>  
>> +static struct device_attribute wq_sysfs_unbound_attr_nice =
>> +	__ATTR(nice, 0644, wq_nice_show, wq_nice_store);
> 
> __ATTR_RW()
> 
>> +
>>  static ssize_t wq_cpumask_show(struct device *dev,
>>  			       struct device_attribute *attr, char *buf)
>>  {
>> @@ -5539,6 +5545,9 @@ static ssize_t wq_cpumask_store(struct device *dev,
>>  	return ret ?: count;
>>  }
>>  
>> +static struct device_attribute wq_sysfs_unbound_attr_cpumask =
>> +	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store);
> 
> __ATTR_RW()
> 
> thanks,
> 
> greg k-h
> 

