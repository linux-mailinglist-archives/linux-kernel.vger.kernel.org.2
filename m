Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586483FB137
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 08:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhH3G3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 02:29:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47248 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233104AbhH3G3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 02:29:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17U5EVce031585;
        Mon, 30 Aug 2021 06:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=13uD0V9sR+ZylFpFC4mXtgLMn8e72tDo5xl0gd1syLQ=;
 b=B0zMiOTLDZ0ljYgkire/X8v8Fwkf0GtIAJlZeikcWBU3KlpCdZJLQNtVweyAGpFw/4Kd
 w67AbYByMrcnXW7Dgt2q5yeqMDWDNWCNBRZNa/PQWXdk1DUOWnD2RPhfkXYhTd4tO503
 /GcUnZR9trxKEggDXe5pj7nj6x6lrGK0KXyNFPkBapDsPvduoR99+iGhnLsesc4N+MDP
 y+X6USvTsex3qks/5Azee69DZ/eOyq/UvAZg+x1ScUlhidSYXI666bdxlJ44PQkcTgE/
 2ddoSb76Pi+4f0XakdH5Mt1C6BqCNgUHgUgWbJ5R5IOO3VnuPFgjsuz62YM6tlR9sx7y xg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=13uD0V9sR+ZylFpFC4mXtgLMn8e72tDo5xl0gd1syLQ=;
 b=CXsGfhxV5Gw7OQi+vi7D9CnJ51pucg3/SA/Ys+V8fpCtKbkdM5uMY+1LcbtUjOkVePyr
 l+SADeBJAesRSdTwr9Tjc5Ag9SRywB+sh4aJSQaCd8pqhH1dWrf64IBzAX1KzlKQc6m2
 M+1bijHJz73JnwzBO+uyfb9AjI3miSmqx9lPXt4ZhiBLk1U5YlPVtvYvtH6N3UXu/j26
 ZPz8LvkAbU4GNqwGXntYQ4jridbaAA5mSgXLj+BNn5aeZ0oWndOcPxE+tznCid1a3ijR
 oMcxU2JZC/Atf7YbfuekrHf9w1vxb1NtKm0Uokwma22H69PJ5cDxgP5NqNUDcpspkSNs zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxsgpk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 06:28:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17U6PYiX033336;
        Mon, 30 Aug 2021 06:28:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 3aqcy2a1nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 06:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqLObR1KHKM/9EyIW9fkYi7lTHpA/F7WfN0SZy14SdupzQyCplOZ5kqjft7vrePsT30TAP+uwhGmSnvI/6wgIrWNMyj5N7KL2x2yfFS/xbNEBwMbpVhDsZINk2009MoyP9XX5BijxItlBZIMNElX+9MfHT2PWzLADNuoFhgqwanKzVFpOA1YMX9IC+YdcMjVPtK1BgZ07RcPUlYSD++4cHjWiKqd35//SLRRUKGx8ViqDmin6MQTZYpjeJNj+zPBpNDRqygJ82plD2hpo+4AjgjZN85GU8uNMl74uo7ni6rZfVWx+g1AQWFO53Tjy4UP1ObT7x5Gx+hqdYhi8CH4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13uD0V9sR+ZylFpFC4mXtgLMn8e72tDo5xl0gd1syLQ=;
 b=h4Ahi8TKrHK0mYMEGl+o9QeYCgeViIHNlDKZgJCHF8udy4RnuonjlmyxRy/iATV8tg0ZZYeDkPX2LpGp5xHQGfUGaaTg5RuDVxdDU2vscG+VxR53Zv7Czk66gpj7Z8LTGcKiM4Ns2Jse+IR2BrML6uhcXk8HHeoCvoBaLavefSQO61HOjxfgB8ZySQGZZ4LihfQalWIUDEqpdBsWCVmCaUEKKziTD9R84x7ixd4ABr0H8nqUHfvYkd8rD8xWVjny2lSMO1V9DuFj0s6SQ9qMmj3p0E+ZeFooGdjLPz1lttuiCfQ8ob6pP7u1tzjFkAycsYhFbIrem+mUhQchrc229A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13uD0V9sR+ZylFpFC4mXtgLMn8e72tDo5xl0gd1syLQ=;
 b=HtoqVkXleoNnh3jGoxwmaSDrMliOzey4JkXWJZ7gTo42IV62rVlilvMY7e7B5sHtqTeuh8mBId2BxAvavtkJH8ht25SeBP+VAnv8ACu4hxdioQwz33+pXjpNQ1qEQuNuGz/JeBJpMk60eCQTHKTcmf3hBLQi/fM+eqCaAsiVBEI=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB1504.namprd10.prod.outlook.com
 (2603:10b6:300:25::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 06:28:50 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::fc82:b1fa:4991:f67e%6]) with mapi id 15.20.4436.024; Mon, 30 Aug 2021
 06:28:49 +0000
Subject: Re: [PATCH v1 1/3] pvpanic: Keep single style across modules
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <93c42686-8283-615f-e24f-b94bea24ee88@oracle.com>
Date:   Mon, 30 Aug 2021 09:28:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ro
X-ClientProxiedBy: LO2P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::20) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.0.254] (141.85.241.41) by LO2P265CA0032.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Mon, 30 Aug 2021 06:28:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3f6c39-cff3-43bd-5e23-08d96b7f6db5
X-MS-TrafficTypeDiagnostic: MWHPR10MB1504:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1504F2369EB73B7CD020708D88CB9@MWHPR10MB1504.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrNRuUdYWJbUk3JQQdotZ6BYTtzcvvMFIYkxj9aGWiWt6xBYbqM3REZPtXy/mRNY3zjEXwhdzll1z7rNBry4NGBfZdpTL3RizHyH6ggRdeseJEf9MgpiCA2epk5odJZacU/Dd2yeogiE52Yir6H2IKolZkb4WDCeJi1YZ6Ydz31Bbw7a2VMOMMoyOS/Q4zI+LAV3xJRns59GzLAJ9TT0dz8VDhvqYZlQjaUpNevA3CSmKOXC86j6yg18GGoAHlvBP0/CDgN66SWCXwXNrbHb0CkSesG3NO8d7l1kfX1mennzy6BhptPdYF4DtOCUwbVBMmUXY4QA9VdS8mS81otYkfNo8crQ0nDOgq5QMgU/uG/AB385YldZxsZoE0MBLHvPZW0w2OBuRuG5TSy0Hvj3V0yyqe8WGLpIeryIOV1V40YEHpdhX4yVJLQ7FMWvfHLBMlqHNCMfbDkXrJj7LE37zL9RW+VYPI/sWNDTQt2QEQ+8tJK/7Z9As7xUMrCgL1s9KAi/+QTsotQpqoAKYGIA1XsLNF1zQNe6Se/r9N7tVN9ElA4Jnem5vLq7b1eQqmJ9vxA2n/XPAvpEgJg01/O19/xCuc0bdj5Aqk+A0+bQlK4/dsZv2hCVpu4JeJgcSw+88lN36FJVBMhQ6rhe//2Ntb+uLv6DJQoyH/vASnUwX34s+/1GHNBqtvk/+6ViD7o87XW++XgTW+eDxywHWHGWW2XR5FMItuWrr0//UcyaHv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(2906002)(31696002)(4326008)(8936002)(66476007)(31686004)(36756003)(16576012)(316002)(38100700002)(6486002)(110136005)(86362001)(66946007)(956004)(8676002)(2616005)(44832011)(186003)(83380400001)(6666004)(26005)(478600001)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MktsMkRnUzUvV1ZTNU5remtYR2J2RE5MRElwT05lcWtiWUZCVWtvczNYYTN3?=
 =?utf-8?B?eUFoMVBDbU1aZmovVXU0c2c5Nm9DaWRISHdKN3ZHM0hvZ3FXaVVXZ3NnSGpu?=
 =?utf-8?B?cGVxb2ZMTU5WcUNLbzIyV1VkMVBTMGkvak5YcVAxZVVyQlo2VFlYeHZkam8w?=
 =?utf-8?B?WU5xalRHNGt6OFFRNVhrVVpCZGZoUy9ZdENVTlJqVEN2Tmkzcml5NlB4b0RZ?=
 =?utf-8?B?d0ZvYVh2a21mQlZFK1lKN2ZDOFYvbnRSeDBNdW93aFdHQTJ6N0xBU2VwU0dN?=
 =?utf-8?B?d3FvNlE2OVpEYkdpaHNPQzgxSC8vRVF5blJFSXJNWHhXUWhodVJSRDFteHJk?=
 =?utf-8?B?M2tYZFBMTElJcEhtNEZHenFQWTlMRGZGclVxalc0b0FEMzBFdVV0T2FOejBC?=
 =?utf-8?B?M3JjOXlMM0pjMjA4YjhqblVIeDN4RGU2ZVhXOHVWM2Q1cmJsd3JoUlNkZVA5?=
 =?utf-8?B?MGh2WDBacVJVOWRRTmpGWjBPbjdDbE4yMlBaWXB6QWgxM3JlVWFYYXVtRGhj?=
 =?utf-8?B?L3d5NnZCVGVvRnhFb2lWbU9rdUFMUmdWU3M1ZEJJdXJxNU5GcmRyVTFmdyt4?=
 =?utf-8?B?eVZzdzBrWW0vS2lQMi90b09KK1FqdGQxVlRQTE1pekpxbndNNUE4aUQwdmJ0?=
 =?utf-8?B?MnhLd2RpdXFxNnV0ZERndWRPdmU5MUdlVCtpQmY0bTBzemJsU0RQSTZYNFJz?=
 =?utf-8?B?RTNxMmdyQms5NTFZMThsK1pSMlZ2cWU2cTdBQmxqaExIR0V0czJGa3NDTDl2?=
 =?utf-8?B?S1NuRHhURXZRWVYyZW53ZjhtMWI4WFhyNWo3Zmg0KytCblRXWFVRSUlGQXJH?=
 =?utf-8?B?QkZGQ1U5SldvZUNwL2EvMEZDdEFkZVY4cWM4c0ZBNGhJbGx0SzZ5eit2c1Jw?=
 =?utf-8?B?dUlBVHdXdDdCdGRUNXJHRjZxaWt6NENqMWdYTWxMYnVONUxmUG81RVJkaFBp?=
 =?utf-8?B?dmVaR1hPMC9IYkliMW9VVUM3NUw4cUJCWnJpVXJkakZGZmZwSXI4b1I0eCta?=
 =?utf-8?B?Z2RSY3h0QVFDWEVEVTlBak5ZSkFtYyt6WHVES3RaZlZLSENpcjdzR3BpdkpG?=
 =?utf-8?B?N05LVlJ0WnRNU2h5NXpZTDZ3UkUyUFpzRmNvT0NwZ3VpbThkQTRjNFFCazRC?=
 =?utf-8?B?aDBvcHJtYlBTNjNmcjNSL2ViUExIQUJ3WXVsVWd2d1I5N0xHSGViQ2xsREc0?=
 =?utf-8?B?UkUzcExCRVlFNTFrMVBEVFBUQi9EZVVkQytxelRKdExZdzh5SjRldDN3NUdh?=
 =?utf-8?B?d0ppTG4vYUx4YXZNQVp6bFFJSHM4MDBPM1MyZlBsdjJxblFBMy9QQ3lRY21I?=
 =?utf-8?B?UDF5OWNlRjNXdWdmYlVBUlA3aW8yRCswOUVHNlNGYXJFU0VvcW0vV3R0M04z?=
 =?utf-8?B?L1Q3UE91V2IzTnFvbSt2UW1wRVBURDI2V0Y0ZlRNSkQzUmU5OUNPTkpkVDEr?=
 =?utf-8?B?R25iTWpyV3M3Qm1NZ3BZb1FuMjhqWXAwWGVPQlhJRENOdHhFbUlzWTRXSlM3?=
 =?utf-8?B?NWxuUFpCNnJrY2JrVU85UnNVMmsrSWJPRGpwVUFmMytTZEFXWk5tUGd0clpY?=
 =?utf-8?B?WjRUY0V4RWlHa3doaU5qY2FGMDZrUG42MGxiVDI4SHIyTlNhcmI3R3dNc1Y2?=
 =?utf-8?B?TjJ6UzFUUW5hOEZKUWxQZDY3T0VpR2wwVXVQVHJqOXdOVzFuQ1RCL04rSGhK?=
 =?utf-8?B?MHpiVzArQ3YwM1FYTU9OZlVxR3FiQy9ISnJtRWg0ZU1FWTV3NmdFVWhrRnBU?=
 =?utf-8?Q?74s2DjyuwF8QPjhvsNtaMQkl+k4aAjqJuTh/CnA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3f6c39-cff3-43bd-5e23-08d96b7f6db5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 06:28:49.8895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrD6iARD1WUiZSpD26fTDrBIc+2oc0ScsQRJehD8B17Cg3y7xhKmQVCp7AQzULCMOp7YvQDu+NLKvMd25pfpE1CiY//zybeD57e5+vbAiyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1504
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300045
X-Proofpoint-GUID: OcaIA7KW51e0SbkVH1HCCp45_3qGBaIS
X-Proofpoint-ORIG-GUID: OcaIA7KW51e0SbkVH1HCCp45_3qGBaIS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

La 29.08.2021 15:43, Andy Shevchenko a scris:
> We have different style on where we place module_*() and MODULE_*() macros.
> Inherit the style from the original module (now pvpanic-mmio.c).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mihai Carabas <mihai.carabas@oracle.com
> ---
>   drivers/misc/pvpanic/pvpanic-pci.c | 14 ++++++--------
>   drivers/misc/pvpanic/pvpanic.c     |  3 +--
>   2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> index 741116b3d995..7d1220f4c95b 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -22,11 +22,6 @@ MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
>   MODULE_DESCRIPTION("pvpanic device driver ");
>   MODULE_LICENSE("GPL");
>   
> -static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC)},
> -	{}
> -};
> -
>   static ssize_t capability_show(struct device *dev,
>   			       struct device_attribute *attr, char *buf)
>   {
> @@ -99,6 +94,12 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
>   	return devm_pvpanic_probe(&pdev->dev, pi);
>   }
>   
> +static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC)},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
> +
>   static struct pci_driver pvpanic_pci_driver = {
>   	.name =         "pvpanic-pci",
>   	.id_table =     pvpanic_pci_id_tbl,
> @@ -107,7 +108,4 @@ static struct pci_driver pvpanic_pci_driver = {
>   		.dev_groups = pvpanic_pci_dev_groups,
>   	},
>   };
> -
> -MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
> -
>   module_pci_driver(pvpanic_pci_driver);
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 02b807c788c9..fb5411dfd614 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -99,6 +99,7 @@ static int pvpanic_init(void)
>   
>   	return 0;
>   }
> +module_init(pvpanic_init);
>   
>   static void pvpanic_exit(void)
>   {
> @@ -106,6 +107,4 @@ static void pvpanic_exit(void)
>   					 &pvpanic_panic_nb);
>   
>   }
> -
> -module_init(pvpanic_init);
>   module_exit(pvpanic_exit);


