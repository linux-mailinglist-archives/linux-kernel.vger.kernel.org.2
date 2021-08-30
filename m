Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A966A3FB138
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 08:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhH3GbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 02:31:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7882 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232412AbhH3Ga5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 02:30:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17U5SvII008570;
        Mon, 30 Aug 2021 06:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JWk4EF4y6ikuSGroUMBzJpbIhf0EhmkinNKuqW9TqOc=;
 b=DrqaP/ng//24g6l5H+DCHgc8Xo+L2L5xftmbCQ1W8n9Co51Za7DgwqAAcOD3lGAXeHBe
 t5iN3P9hOiGznhW/1u4RoBPXTES0NVE7s3aQZUVNP/rTdJ+epEK4raf9mjQtLW7S7snl
 zIWQrHz/dnjDBMfrX5KXPGk7zuXTGCZTR8yAdIWv5L1uIcPXpdqzqypQjJvIecCBnHgR
 k2OduhgDsDeBVXL1i2SVmKlW3ZhuulPwZeurpsyqNo5PzqmolCT+DHc9W68hfLK+LRqf
 4IKJHAx277NfiQRkHaOf2ja7i+nNPW3hgMQaT9vq9gDkQWO1vS6bdRl+ICOlGWsD/iCS wQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JWk4EF4y6ikuSGroUMBzJpbIhf0EhmkinNKuqW9TqOc=;
 b=HaJih4Y92xlnTrBaOKXofAcqZ3Tk5TNd2NYsQbU+aufcfG9kgEETe9pvN/xFcJ9gCCwR
 T268dvx3XPYRB9j9/aAgsbqy8uRkdJqrJMk/N0Q7ViGzScHAc2Wn4TEx0N2lgL80S1Fg
 cFGa673K6472MFsF9gLhTfnGb03iDSrVuG2IVjDsU78jKWoSLZ/VWGvR6RH6FrwDdAkR
 k+nwZeB2UckHdhPQnKnW1BuRWVsP0luQKAVCQqxOSmd8m5lA722Zq+sowRJcX7Da1mLN
 HlicgWTbjjQOoTY423tN8k0kWGNjAdOw6qLxY56Nh+fdx1owLmCJZoHpY5trit7/932L FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxwgqe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 06:30:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17U6TYVE043453;
        Mon, 30 Aug 2021 06:29:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3020.oracle.com with ESMTP id 3aqcy2a2ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 06:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1S/QWzsph7i/guwXQq4Uxd28SFEYwldDFRukanXKaJYChitEKPyjxPPmZe0+wPXydeDuJQqYwP3yC9BWiaQJ2exGolpMltDP3jGX1rwBvjLVzeYciS15fKBfrdRkMQFB9iHBqRXdIPNA6cz7uWgki3PoxGdQaTHQ/4orU9L8Kg481ZiAPxzH3yXCHxI87D1JZSvRp4abyWtDE6wLNp/C39iZf52np2THiIXIT2ObHZAAqk0lkPBr561TuCQA2THJt4kaS3R2e4F3EVzniQ7PlFs/2FhyqaLzEkOCrdhXbbA+UPmm9RwCU85GYgnogpzwkw1u8g4gB1kUl2xfpZjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWk4EF4y6ikuSGroUMBzJpbIhf0EhmkinNKuqW9TqOc=;
 b=NAfpHiVg37YKGpnh08Hd8PMVL8oHlPR3P+wy6xmDeOC7AOcMXAEW4eWYGDh0H4yxjlkxRJZAJ4BcshSykSZlLF4NTDOoVrOQLLzKtQHINMXiPrT0gkCFTlftleatRsCYbqRiyMqBI67OUTYOkioqyTvgQQuzZayUnNWik5KRhMlP+LJBI6xsJl4NEEIChDk0b4/7A+5yaaTn/95L9WZzLLITkpkdY7+o7fhUvhDEYLLEzFxNfRVoadJr3slw9sBE4xXWJYwfZhLBZDIz+e/A5zwmV6e/mrFGh7yRiN1sUswJxwE5TfdBoV0UBEOmM4inuDedTlID776tRTAzyi9vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWk4EF4y6ikuSGroUMBzJpbIhf0EhmkinNKuqW9TqOc=;
 b=c4f0vePAvy5sMphIrx0g+NUKVQKDx1T+DCeTZ0nOpUPCEjhN9f7bPpXVLszECX10sCd29NQn0msap8C7e6a07kfnXwWksyLQZA8c6MPndAhrwVVOHcZ57eUIl3GZAupIgaKCsZOYwrtEZ1LpQAQCuL6t9EDwd+zl0Y1C9+5+O28=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB1519.namprd10.prod.outlook.com
 (2603:10b6:300:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 06:29:55 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4436.024; Mon, 30 Aug 2021
 06:29:55 +0000
Subject: Re: [PATCH v1 3/3] pvpanic: Indentation fixes here and there
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
 <20210829124354.81653-3-andriy.shevchenko@linux.intel.com>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <6edf9acc-1385-f6b0-cf36-8d52e2bcf7b8@oracle.com>
Date:   Mon, 30 Aug 2021 09:29:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210829124354.81653-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ro
X-ClientProxiedBy: LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::11) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.0.254] (141.85.241.41) by LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Mon, 30 Aug 2021 06:29:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b369aa5-fddc-40ae-3b63-08d96b7f94d5
X-MS-TrafficTypeDiagnostic: MWHPR10MB1519:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1519E567ECA164389001AC3388CB9@MWHPR10MB1519.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJFqZ16kvuG26J/XaMDaet5Un3RRNqxtYgwdciyK2I3l8u93PrfXbA7vF5/lkYiZW0XzoWiyKqzcSasMOYP9XsXqaQ/QihC+ATYGros+X0TTAYAwPGLqCLRxG24cOptjK2sqDtNapOrbp7qCsnumKQOh15lVwj84rlN60yCoeJ5LMPMtj0Qvn/9u01KR5JF8D118PopwBSfyaDVJ0ynKvgTvNsOJ8RKws8krq/sQxH45s1WrIHCThrmFO+I15N0tCPVS5V3MrgqN0IVd26yIYJMl2+D9BLTuJSn1WliSrOEziGcGhWJpuNAfYlpXv8TcUV+hr8mb2BIBka7gsotIEzCpWo3M+Uwf6A8l1IJLpATJvv16lKTEuVBANtCTyX4cS9iGJE7JDy+jLigA2XvagjBTQ00mlGYk3fIqIjRRwcFuh3Qb/dVfqgPnkQEu1ibVKxXG1NjVlyZGbiaN6XrMvTeIWQE2lreN/c/LbKBNSsGLvywjeSJqyxMWNOMwaQKiMyFtvw4lZrZ/mogFswQRjSesiPXc9wmgxn4FBICa2YS//TRINiIvEfJ1Wl4bLrIZM0MuiLusd5hGYgejdEGugXmOpHcr5fi2VloacVg00HfvtYS1Pn0FYPmZQifK37bL5mzY0rybgtrqNUHNtQ+9DflaoX3Wx+pS7bFl/7lHtBu5/CQsBD78luN0Eky+WNgTMJMPQfcXrRSdyRrznUfWbzZ9cSNzCRoH9eUp6wovUYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(346002)(39860400002)(110136005)(5660300002)(8936002)(44832011)(6666004)(38100700002)(86362001)(31696002)(36756003)(478600001)(2616005)(186003)(956004)(4326008)(316002)(2906002)(83380400001)(6486002)(66556008)(66476007)(31686004)(66946007)(26005)(8676002)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVdLY3F3WW9HN3ljMGhJNWU0Z25IQ1MrcVhoRlFBekUvdEphVkRKNllWTkhR?=
 =?utf-8?B?Y3kvelR3cGhROFRER0sydXlodDhHeER4LzZxTHNEQ2dSSW1FVVBDdENCdGdI?=
 =?utf-8?B?Q3VkSXhQcGRTVlUzUTFHaElCWThuaU5vWjI1TVVtRmJrRnpLWUtGR01LU1Nj?=
 =?utf-8?B?NEhjVW5nZ1lSMU5YZ3pSTjlzUG5aVTd2cFcreVpZckcrMzhacmJiUnpRVHN2?=
 =?utf-8?B?Y1FLbVVSUFdtejRlcEM1bUMxOGdId0NKRUppL1drSTJodTIyeWNNblhnZ2g0?=
 =?utf-8?B?VTRVenMxYXpRdEp6SDJya2xtWFdhTHIySFVKRUs0K0psbEwyaitEeTR5b2hs?=
 =?utf-8?B?aG5TNnpwcHdseTNzSGM3TzhYS0d6bW1USi9xMmh4SlFVRG9zRmRvRE51UFgr?=
 =?utf-8?B?K3RCN2llcGhaVjVmN244UzhoM0gwNTFLY2owc1B4L3ppT2Z5N2N6SGVjOVJ5?=
 =?utf-8?B?emE0NGgxcHZrM3VaZUhudFdJcHFJMXd1R0g3dTJQbi9EQ2E2RXRiWnlDYnlW?=
 =?utf-8?B?OVRSRDJiUDNERzFHYzJZd2twY0REQWlucXpWMlJJN0dWOUM1Q014TG83UHN3?=
 =?utf-8?B?TVJlRzNEK0d4b2RDZi9SUFo2R2s3Zm8ycWQrWW1LYWN6b3Rmek9GWjRRRjdZ?=
 =?utf-8?B?T2p3Ny9SeEZjVmF3OUdJNlRpbnBSN0JtZlM2NGdTV2FBeFA4VTRHc3pYcStj?=
 =?utf-8?B?bHYvNTU5MW1TMWhza2Q2Ti9sbEZHK05XdTQveXdYdngyRTRTQ3NBTlJmVENp?=
 =?utf-8?B?VE5aRmVvSGc5aXhGSFNjaFFPM0tFa2FGY1EvYTNBWGtvcEdIdzAvaWJ1OGlu?=
 =?utf-8?B?VkRQV29kcjFFNldZVElrMFY3ckhQSDlzNE8xNTJyb0xYd0RTdjlPcDVtWitL?=
 =?utf-8?B?RDh3YWdxTXprVWJVZURCMGhETnVqOVlTT0tqWGRKTnYwOE9NTm9RcWJBZFNH?=
 =?utf-8?B?MG85OG1TMzFPYlVSTitwMndJOU5RelJiVmlycEJFUkdoSnRvU0tRYzNxOWdG?=
 =?utf-8?B?TTArMHRReXBLSnIyUXRoTFZCRjdHdWtta3dFUmFCMi9qZXN5VEpFN28rZklK?=
 =?utf-8?B?SGRmcnZyTFhES3pNenU2a3NINElUNzNCR2R2aHB6Y3A2c1BaN0d2Z0QwTVp1?=
 =?utf-8?B?QVRHVnFpWHAwU3pqaitzbXovckEvVlJvWms0a2tONzllN2ZDUkI5RXlnVXha?=
 =?utf-8?B?U1FZMG51K3QwQ1dMcG43YUJIR25xMWdqeE10WTBvZVR4SXcyajcrWWNUYU5Q?=
 =?utf-8?B?ZkJMRHNvc1ZXTldKSmhBTVBPQUF2aXN2UzdBajZUN0RhSU14Y2hQOXBkZDdm?=
 =?utf-8?B?VnFtSkRnMlNRWHEvRkN2eElKdXAxd0JjbTdRZUlaZkZhNWZYTkNjMkpjaWV5?=
 =?utf-8?B?ZjRZRTVTRFRKU3NtcVhJU2l3ellEeHdibGxpUHhJNGVJM05rTkpOUVJOZDZI?=
 =?utf-8?B?SWVyTlZ2eThUNjRkWnJ4S2xtTDFLekNDK1pQc2FJUWtibmNFSSt1K1J0MXdo?=
 =?utf-8?B?bVhrUlJpY0NxcHJYSjJRS29MN2JFNndWcDFmK3NLdHIwUnBhR2oyVEFIMFdl?=
 =?utf-8?B?cThpZTZFSWZYQTg1WTFyK2JrWk9vNjVkY2pKSEtvYnRxY3AvNWE3SUhKRGh1?=
 =?utf-8?B?MXFFOG9ISldoWHdXc3VDbDJoVE1KeU4yREh6dERTSm1Rd2dZcldBUm0yMlli?=
 =?utf-8?B?TnAvQjY3anByL0NEY1NSZG9kemdKZkZnbWZQWUJrMFozSzI5dzdWNFpSbkU5?=
 =?utf-8?Q?rL7YKBV52xgZu5b/UYv2VXOxWRM7bhYtvvlYeoZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b369aa5-fddc-40ae-3b63-08d96b7f94d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 06:29:55.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjdHx5lgBOz6LwLMmKFClbZp/TtAjwgE0aBsP1mRpHS0XSe9ZYQ0Fjw7Vtq2zVD1ciU57CTF9y8bb0bKFXt5PT4F/5oalumBelkF7VootUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1519
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300046
X-Proofpoint-ORIG-GUID: 5psmkhg-sA2Mtyw9kLaNtaVirrT7z9pZ
X-Proofpoint-GUID: 5psmkhg-sA2Mtyw9kLaNtaVirrT7z9pZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

La 29.08.2021 15:43, Andy Shevchenko a scris:
> 1) replace double spaces with single;
> 2) relax line width limitation a bit.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>   drivers/misc/pvpanic/pvpanic-mmio.c |  7 +++----
>   drivers/misc/pvpanic/pvpanic-pci.c  | 12 +++++-------
>   drivers/misc/pvpanic/pvpanic.c      | 11 ++++-------
>   3 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
> index 61dbff5f0065..eb97167c03fb 100644
> --- a/drivers/misc/pvpanic/pvpanic-mmio.c
> +++ b/drivers/misc/pvpanic/pvpanic-mmio.c
> @@ -24,8 +24,7 @@ MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
>   MODULE_DESCRIPTION("pvpanic-mmio device driver");
>   MODULE_LICENSE("GPL");
>   
> -static ssize_t capability_show(struct device *dev,
> -			       struct device_attribute *attr, char *buf)
> +static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
>   	struct pvpanic_instance *pi = dev_get_drvdata(dev);
>   
> @@ -33,14 +32,14 @@ static ssize_t capability_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(capability);
>   
> -static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
> +static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
>   	struct pvpanic_instance *pi = dev_get_drvdata(dev);
>   
>   	return sysfs_emit(buf, "%x\n", pi->events);
>   }
>   
> -static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
> +static ssize_t events_store(struct device *dev, struct device_attribute *attr,
>   			    const char *buf, size_t count)
>   {
>   	struct pvpanic_instance *pi = dev_get_drvdata(dev);
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> index 7d1220f4c95b..07eddb5ea30f 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -19,11 +19,10 @@
>   #define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
>   
>   MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
> -MODULE_DESCRIPTION("pvpanic device driver ");
> +MODULE_DESCRIPTION("pvpanic device driver");
>   MODULE_LICENSE("GPL");
>   
> -static ssize_t capability_show(struct device *dev,
> -			       struct device_attribute *attr, char *buf)
> +static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
>   	struct pvpanic_instance *pi = dev_get_drvdata(dev);
>   
> @@ -31,14 +30,14 @@ static ssize_t capability_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(capability);
>   
> -static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
> +static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
>   {
>   	struct pvpanic_instance *pi = dev_get_drvdata(dev);
>   
>   	return sysfs_emit(buf, "%x\n", pi->events);
>   }
>   
> -static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
> +static ssize_t events_store(struct device *dev, struct device_attribute *attr,
>   			    const char *buf, size_t count)
>   {
>   	struct pvpanic_instance *pi = dev_get_drvdata(dev);
> @@ -65,8 +64,7 @@ static struct attribute *pvpanic_pci_dev_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(pvpanic_pci_dev);
>   
> -static int pvpanic_pci_probe(struct pci_dev *pdev,
> -			     const struct pci_device_id *ent)
> +static int pvpanic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   {
>   	struct pvpanic_instance *pi;
>   	void __iomem *base;
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 254d35efb0b7..c9b5a66697ea 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -23,7 +23,7 @@
>   #include "pvpanic.h"
>   
>   MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
> -MODULE_DESCRIPTION("pvpanic device driver ");
> +MODULE_DESCRIPTION("pvpanic device driver");
>   MODULE_LICENSE("GPL");
>   
>   static struct list_head pvpanic_list;
> @@ -43,8 +43,7 @@ pvpanic_send_event(unsigned int event)
>   }
>   
>   static int
> -pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
> -		     void *unused)
> +pvpanic_panic_notify(struct notifier_block *nb, unsigned long code, void *unused)
>   {
>   	unsigned int event = PVPANIC_PANICKED;
>   
> @@ -94,8 +93,7 @@ static int pvpanic_init(void)
>   	INIT_LIST_HEAD(&pvpanic_list);
>   	spin_lock_init(&pvpanic_lock);
>   
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -				       &pvpanic_panic_nb);
> +	atomic_notifier_chain_register(&panic_notifier_list, &pvpanic_panic_nb);
>   
>   	return 0;
>   }
> @@ -103,8 +101,7 @@ module_init(pvpanic_init);
>   
>   static void pvpanic_exit(void)
>   {
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -					 &pvpanic_panic_nb);
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &pvpanic_panic_nb);
>   
>   }
>   module_exit(pvpanic_exit);


