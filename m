Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4533DA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbhCPRJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:09:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbhCPRJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:09:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GH5Uu5184868;
        Tue, 16 Mar 2021 17:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JUh921jZlfNEbfOLZxTzQYPgFa8BFecpbxHfLkW+pbI=;
 b=upNnysVf+U6TdlagP10hvpqYEO8w1+8e7CsgbGkPf4eBZHSxsVHN3ZbraQ95fk62vBlB
 psd3BfWDHRoXZY5byBWr1t4avQp1d/GjxrJYNMpHJIRIjRABRCtdWpSt0FXa/cI5oI7p
 vrj/p85xag9vmlYbx9dDXc5vKQBsI41ou+K0iVDktOu24o8d3eYDJ054noObZHsLaD0B
 k/oo0qL1wCIR8PEsn+tbxhv6Gidlx8KltVtXyD0a0FPWGNbfUhvszGIzYMlLHtO+bN4O
 A4YiybyfzAJ1gNZP+dGydyHqvjq/pfPw6p1Tg5Yina604az/A7SmT1tI1MiucEHDg65V 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 378nbm91db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 17:08:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GH0jrI195006;
        Tue, 16 Mar 2021 17:08:51 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by aserp3030.oracle.com with ESMTP id 3796ytqtqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 17:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTFhfNKpOkxudEgCkRH22YmTwU4Q3+k97b1SIAr0OH68ZROwgPKur65ndRPvEbyvgEefWQxn3R0sGprmsEFniweH3l3cXFiu2G7zDhkRTTNJFKnR5QB4R25Xaulm/h50jLcT6isiGlq5y45U4Wcm/R+PtPHTJmqhZNpLnThWBKP9rBYTSDA8QO/ji0sar6rJc/OBtg+rhyrKAvVz+DLBLTufvVf09pQ6OJS8wxHRJrBvw3nmjc0AUWK7KtdfbaQpmR1kshs8aNMfvH+bmvdlLd8ZJcE3vGYxbQlQnE8Qx4gqjB2xY/Aipk449Z43Vdxk1MLaLZ8B69qgigQIwhSO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUh921jZlfNEbfOLZxTzQYPgFa8BFecpbxHfLkW+pbI=;
 b=a/2x0ZKl6hKYjwsRTq8Y2j0BzaWqen+8HP485V+hlaJW+ObY3H5eVOWmwPm6jv8CzpD/mp5K9AksH14YQPSAf/AhhGjXx7daqHEekf1Icnbbfd//pdnEw9Ct3e8xnJWUYYfb7Jz7xSfxVSTpMEQ8Jr5zOjKLT/qf1Ems8963aW648Ji9tluNfHv0KjQJrOrSpwIAj8PsFm5QJUtAHsfwIIydFqW7MHSk/L2f+dHuX8btxODxtzyf365e1IzK8gC/50CU4jlENq6MO7hPnkerO126iq5fX2srOloayDsFZZsl93EvKegkcXsgxWyWNbAmnGMjEgDcePEEMKfCo/1oUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUh921jZlfNEbfOLZxTzQYPgFa8BFecpbxHfLkW+pbI=;
 b=R4Jg4kyq2ESpx5EP1k57DVWhspEkR/0JH94wCiMZ6L7h7bnVcH+hSZFWxg0lIs0MKx0Ib539vYnEjYYtXawpOIMIew+p7FAidAN6C84xBvL0HMRwD2B64tECEiq2qk8rMH9UiQ/StNRoSj9/SHAOnBejTaoBWzksNdfkb1A1H/0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR1001MB2288.namprd10.prod.outlook.com
 (2603:10b6:301:2c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 17:08:49 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 17:08:49 +0000
Subject: Re: [PATCH v5 3/3] misc/pvpanic: add PCI driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
References: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
 <1615897229-4055-4-git-send-email-mihai.carabas@oracle.com>
 <YFDhZbRYE5szZ4l/@kroah.com>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <b3d33f82-21ab-2244-13b0-700fc54b2093@oracle.com>
Date:   Tue, 16 Mar 2021 19:08:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YFDhZbRYE5szZ4l/@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ro
X-Originating-IP: [141.85.241.41]
X-ClientProxiedBy: AM0PR04CA0017.eurprd04.prod.outlook.com
 (2603:10a6:208:122::30) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.0.254] (141.85.241.41) by AM0PR04CA0017.eurprd04.prod.outlook.com (2603:10a6:208:122::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 17:08:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ef5824-0a57-4ee5-a5c0-08d8e89e2a71
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2288:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22885ACC1DA0E494741B06DE886B9@MWHPR1001MB2288.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIZU7NojGwuhL2VTgaAZsG4fkFOIzfKHuJB1VOvDeF0kzSs44oxC2rWVkMntGVO72od4zJsttSxcMWAOWV8mum9eReOLe/yKb26IPkGchKETYstioYkSDeYWoJGogFZ95pEfSVp6qPioKZANbUlVY7atC9NHz61ovfK7TqZIe+M1BAGR0jt68uPjBPHYueNlhKDIi1+cHE6PAydqNyL6sp/hYbSkGdUkC5YR1i9+HC3tLWODyCohufWUfTs8olmI1YXdVbjLVG9ogOF9fDjqRP3w86rKxLvLlgXA9sGPQngdwBqTU7gEC007S8LQrDdTBvDqdKkAH1Ei/l7SdsfhUAKwY3acU9jJV/ypHD1GJ3fPn54cBKE5s2rQFyT2IHe4raekrbk9zyEFF4DItAlg2kCAn33tBa12qFPU7+t/WYaIh+5Le2eb8HKct6oHehvOJkpIF0XgVzczTpu+MvBTIv2cIxwofGHuUvyHt8EAxbLnkSMWPgsR/CIlZmPdWMmbBdAZw3OKA+k/F0jgPu0ZoZIqInqVYYHKk43rUpreQdLpbZv3jn5YDtEiEu7/aaNf51iS0JSKFrH9TgGG4XtXz7Ffrda1S/BE8abm1/8TXQm74u+82r2sxVfdxd71o2uv7GL9PmrtShCJPZwt8cWp4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(16526019)(956004)(186003)(6666004)(2616005)(5660300002)(66556008)(44832011)(8676002)(26005)(86362001)(6916009)(66476007)(31696002)(2906002)(31686004)(16576012)(8936002)(36756003)(316002)(478600001)(4326008)(6486002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L05rUzhnRDcxVVd5akhHRnNTbUxqVDlQbFphNHh5Y1Y5NmRRNTZiWlp2K1Jx?=
 =?utf-8?B?aTF2MHBScDl4ZElwelNubHFlSlEyekNLWDF2QndxbzRYS01ldDB2NEhMendM?=
 =?utf-8?B?VkZ1Y0hNRjRrMU85SW84MnIvQXZSYm5YMGxnNDYxSHl3YVZMUC9UU2FQZVpt?=
 =?utf-8?B?eG9JNGc1S1NiWXQ0Mkd6d1ZabitMU2RWcHVNMnFlamlIbGFyd2pPbW1IREtT?=
 =?utf-8?B?cjUzMFpnaFhiR0FRMWt6Z1Rsem1uQXBEdC85U3FsWEFiM1RoTGJxUTF0NWhI?=
 =?utf-8?B?WER6ektMNi9leEczMDJiZWRIMFZWTUszUm5yRHAyV0tJSW5Yb09XdnpFOUVu?=
 =?utf-8?B?dmlqRWc2Z1Mya3pReEN0MCtWWnhqNm05NTRxeE80UWxzdGlPMnJESWFxbER5?=
 =?utf-8?B?YVByYXVqakh5KzcrNFpwK2hPQ2NxQUUwLzFDMGpwUy9SNnpoSll3WWRsU1VP?=
 =?utf-8?B?THl1UFlXYnNQZHRCR0s4ZlBIQXpmd05jbGtBL05ZMEExMVlPOEhOTzRscUV4?=
 =?utf-8?B?U1p6RjJLUWtBTXFpOE9QTktLZmJrODJqV3RxUnRCdnZJVldpckJFa2FCeVQy?=
 =?utf-8?B?RTRTWW9CNi9qNzZOcUNBdzltZENVcnNNV0pXb0NZSGRNbzdkUVNCNDl1OXdM?=
 =?utf-8?B?YUtQeTdVeG1ncERPV0E2ckFXOFFzNkx5ajZ3dFRMY3VlVERFcHZmaDVRaUg3?=
 =?utf-8?B?dDZWVUZZaktjclJORFV5OVY1cURGbjYrM3A0VUw5L0szK0pjcDlBaG1FY3Np?=
 =?utf-8?B?LzNyam1uVEFMdXF4NWNtL2F3Zks1NmdwN2swWG5kNzZObFh6dWRyamFiR3pR?=
 =?utf-8?B?emxPbS9FWEl4R1M0YzlFRWxZNVFZR3h1M0ZVdzVaM1ZaQmpnaTU4Vm1JMEdF?=
 =?utf-8?B?S3ZUTnNQK2dUeVR1NThyU0dGQTY3c0V4ZzAzV20yWEZkTjdWM3g2TTJKMWsx?=
 =?utf-8?B?TVFVQ2U3M01YVitMYWNQNGE2My9GbEtmVmwvem9Cb0RnWjFRYmdmS0toOGxG?=
 =?utf-8?B?bzFXUlNJb1lnOStmYVBMVHFpMlY1cEtUN0paRURGYngxOW5OeXlyUzNqMEtY?=
 =?utf-8?B?MHkyalNHcTIreDlmRmo0T3diRStMeEgxU1hGVXhFdjZaYXdNaU91WElEUTVj?=
 =?utf-8?B?UmpWelBHUDhCWitES2YzSFkzd05vWGltQXRkR1lBMGp4eWVucUQzNGFOUitv?=
 =?utf-8?B?S3FaUmM1SE1aMDgxem9sVTAyTUZyM2lxbDd5Zm01NlJmZmVLMzRsS09oSXBK?=
 =?utf-8?B?TnRMNWRNY0JObVowbTdsRXVUcFFMeHNNb0UyT0RNRWZOL2p5emRTblkxVUEv?=
 =?utf-8?B?ZFZDbUZzclAwc1hQVlVEWDQvVXFsSndGQTEzK3NVUmJ6d2l4VGFYTldNTk9o?=
 =?utf-8?B?SFJCM25kd1k0OUJSYjE5NmowRUJFS0JVOTA4SkQ4elNPWElKQm5VTkQ3RC9X?=
 =?utf-8?B?dGo2TTdvL0h2TTVDbDA2MG5TbTNrbi90NitwRWlPUFNqNWViWTV1MnR2c2RH?=
 =?utf-8?B?empPUld1RnlZaElyeDl5TTRYdm9JMDNWaDNCV3d0amxjWkQxUlJxbzh2dys0?=
 =?utf-8?B?OHJxSU1WdzB2d1Rkd1lxTDViQ1hnMUxWeHFXTnpoQmpHdis3bVZkNkpaQ2Vr?=
 =?utf-8?B?Rm1KY2Z2TUI3RVFXSGNDdG5Hdjd3YlRBOE1QeXl1WFhQWExmQjd4Wm82QlJL?=
 =?utf-8?B?aG9TaUNUYnZIWVVBRVIvYjlzb0ZMZlpsTmRYVTMxNTF0RXN4empvQjl0YitS?=
 =?utf-8?Q?0mE5yvEAl6fCJkJVBks8ivu/L+r4MoYpeoEDNSm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ef5824-0a57-4ee5-a5c0-08d8e89e2a71
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 17:08:49.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc+6wYtmVMzGsr1ra59RjMeZ/czDqJkHL622WEXLuPm+dAWxYnWHAt77KBrTEs+BGvVARNxj0rnZAsExBCw7mU5rCsETK8SxDnisxmS4y4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2288
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

..snip..
>> +};
>> +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>> +static unsigned int events;
>> +
>> +static ssize_t capability_show(struct device *dev,
>> +			       struct device_attribute *attr, char *buf)
>> +{
>> +	return sysfs_emit(buf, "%x\n", capability);
> A global capability for all devices?  No, this needs to be a per-device
> attttribute as you are showing it to userspace as such.

We can only have a pvpanic-pci device. This is necessary in that case?

...snip..
>> +static struct attribute *pvpanic_pci_dev_attrs[] = {
>> +	&dev_attr_capability.attr,
>> +	&dev_attr_events.attr,
>> +	NULL
>> +};
>> +ATTRIBUTE_GROUPS(pvpanici_pci_dev);
> You did not document these new sysfs files in Documentation/ABI/ so it's
> hard to judge what they do.  Please do so next version.

This appeared after 5.12 rebase on pvpanic-mmio. I did this changes to 
pvpanic-pci to be on the same page as pvpanic-mmio which is described 
here: Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic.

Thank you,
Mihai
