Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1BC33DC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhCPSEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:04:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55408 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbhCPSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:02:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GHsLO9123782;
        Tue, 16 Mar 2021 18:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5t3FSz1X5lHUsdsFvUNhQKcYiZfx2aJS/Veue6Sr+Ps=;
 b=cneIl7LyfDbwkuDq5/irKv4J7fu4es/r580a7iDK5ejaSe9BgWpGpflhvGelasSveHSY
 6LoQfDlDfLG6qrEb3U+yP6PxzwcjqJEJV3uF+OrRFq64xHfWb4+iWysdDhGkuEPUYwU8
 pQJcwimc7GP4VvdIFGqf+ia02aYOu/H88nOayk7L/6vIFiW/MTGX+K6l7F36dwy/B/iA
 HaCQHfzgMtB7MkOjaJaeZn6wwzKPgxpL9/Wi75ZgEOzMEYitInMMFd8ZszkskCPmJqpj
 u+ChMXkbQTgOQxi88xs2jozxe8pcKvbFbWs6hZ9ifAKJYQKe/sSXbax7rtUDCiQDvPPt uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37a4ekp5kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 18:02:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12GHtswt164162;
        Tue, 16 Mar 2021 18:02:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3030.oracle.com with ESMTP id 3797b0dxkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 18:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsgNNQZLrz2q1r48awvJJRmVZqw3rgWl10SHf33am/TIBkAm2VyEwRTYMyMr9bJgXkmOeFwICUxmjC/IEfFD9NVuEarjgFGRtlR6vzmbdlnxSJGM+HHClXSXtuc/dtz52tljjP/Hou6a8ahk2pIvTzR80Dwa6vfinakwdcsGgTjHR0CyStXy5W7eLlFABdvOt5qRKjf7WLou36Xz2Y05AE2kBkVG1vCmwKNnuYzdLsyH2lmBbo9Lwh9sAursPtHzRT4FvjV93GeypXvFuKpNwDxH0bbHVupR3adVYTISecVN+rLySObKIJ5WufJiLqEl9dWAwGPwPzLVGZLNm5UAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t3FSz1X5lHUsdsFvUNhQKcYiZfx2aJS/Veue6Sr+Ps=;
 b=Qp9OsJuDP87wPu/IKe/RPfaLuxf7d36OMwsfzuXKso/eNs5L8/fV9WKHH1Ym3ADOulFGgurNsr0cTnRoqG+tR01mcUEQs6prhjOQR6iTPhY35Cq4plDEFyKEyO3XvSOs1UNmepYhmWxoZreuUCUOlVg6GnZZgOp8n00LUvx+/MxCA7g1wShvCuS7rsvXfOMfFqzTxpzPJgiZ7AdhpfSoUmtapvYtbQ1h2h21Ph3ITMJgOCd+yzOtAKErdSX2VXfNVbHSESf4+4mD79USDeuXxnmeTtIP7XvFIT2+9ASR3AWAz1i5Kiu3JlQ7vx5YC3eSyF/a9DsJr9zfyofWzTZT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t3FSz1X5lHUsdsFvUNhQKcYiZfx2aJS/Veue6Sr+Ps=;
 b=UcAyS8tKTaulX/gV/Ua5TK479MWfTnhLQZSllX9YQASIfRTyH2SFohNcubKdOuDELs7tEWlGtkqm9HuCI0Av3urVHUcU7kgN5l+hwY0tHEY9/eRns5kEMnNs/Ofq6MNc01sbPqnqEcKiVH4akhzvrXSzIVDlSMRyFe+w5iNTSuM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by CO1PR10MB4579.namprd10.prod.outlook.com
 (2603:10b6:303:96::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 18:02:23 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 18:02:23 +0000
Subject: Re: [PATCH v5 3/3] misc/pvpanic: add PCI driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
References: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
 <1615897229-4055-4-git-send-email-mihai.carabas@oracle.com>
 <YFDhZbRYE5szZ4l/@kroah.com>
 <b3d33f82-21ab-2244-13b0-700fc54b2093@oracle.com>
 <YFDq5Wj4AQOm/Bm4@kroah.com>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <91231b60-d559-5d1e-aff8-303fefc1f25e@oracle.com>
Date:   Tue, 16 Mar 2021 20:02:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YFDq5Wj4AQOm/Bm4@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ro
X-Originating-IP: [141.85.241.41]
X-ClientProxiedBy: AM4PR0701CA0002.eurprd07.prod.outlook.com
 (2603:10a6:200:42::12) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.0.254] (141.85.241.41) by AM4PR0701CA0002.eurprd07.prod.outlook.com (2603:10a6:200:42::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Tue, 16 Mar 2021 18:02:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a560cd91-995a-4c25-ebad-08d8e8a5a670
X-MS-TrafficTypeDiagnostic: CO1PR10MB4579:
X-Microsoft-Antispam-PRVS: <CO1PR10MB457956EA8073F6CA44FE5E21886B9@CO1PR10MB4579.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKmOjKn2tV+eFrNnmzCyoUeeiu0a5iX0Wv6cwKZwFggPmdHBZ2NvL6wbEn9syOAbmTCbZ1Tq+WWAZvtotnNqyo9OpvRDyLsVPE1NjEa6HVhU/UNxli2oeo/c/q3pNRfbwuR3MQc7BmLdrWmmyz14NzvMUZY4byNE8ESQb0ktI0Ot5xJ2ioxKZWk6EfKRR+yxmpdNQGZ9KfBphBRIz9pke2wIuK2sEdAFzINannCk2PAdanI69GMdLIDQ6ZVAnkcY54Sg1VTBtaO9YqjbqV+izCBL1UN9J82fEMqFdz/jzRZil36H4AFKrtB+TkL5apJYI77f4/6AdoYT+E8xCmeL7zfT9P0OXxWTSm4tafK5nNUvUEOFB7zxJZVrMD1KzGVG4W89sjl4AvvUG4UeNLx6SV/jpajldo6u3DIHH8kTl3ED8pZf5XWuJA0JF4mh4seIRCQABSZHKARBOLAwrYod6cPP2nwobo6K+BR4Q9RwSd8z9YQVso/7Kmkg281Z7IFzXjUUa7DrwmDbymWnEjjJYq3nmRfpwT95kl916Sgxi5XTWL4d6kPJ9szsjNnfoNZ24RTpW/62VawZzPLLtRMDbFUawTwBNWqw1HTUohcGi8Z32Q/p3BePfDikpNC+YwlBoNKfFusqaa9H0jyzfpxlqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(44832011)(26005)(2616005)(4744005)(186003)(36756003)(31696002)(316002)(4326008)(8936002)(478600001)(16576012)(956004)(6916009)(16526019)(66946007)(8676002)(86362001)(2906002)(6666004)(31686004)(66556008)(5660300002)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RG1yQ1dHMTg1VmVxK2J3emh5U285MUUvclU2TmZadFFHU1dMSVc5VWpWUlRU?=
 =?utf-8?B?SWRONTBlT1pDZVJ3SkNtZzlDbDBFWFRqazFHTkd0MkpqZkZiUkhqZy9wZytC?=
 =?utf-8?B?TVhHMEZFQ1pSSDV1eEI2NlJlRW45Z3Azd3p2UWFydHVlbGpzYUVnT1JlMU9E?=
 =?utf-8?B?OFplR0d4TStzWVA2K3ZuNkZtajRMSlNOMXU2SHZpekEraTVIMnluZVdOUU5I?=
 =?utf-8?B?RW1nVGJLMTkzUTk1NUZVWkxiemxsYVdjakF5b1VoeHMzVERQT1FCUHJJUkdo?=
 =?utf-8?B?NTZyQ0owb0NCSjRNUHFLZmVLQ2JYRUk0dnlZZWszYktpcjJEQ0dyR3hxR2Fl?=
 =?utf-8?B?TlYvRDd4ZysrRHdncnJuaEhQeDZ1VWJ0bGZQVkpocUtRVWFYZ2hvV0NNNnB0?=
 =?utf-8?B?MW1PVFlobUE1Z2IwaFh0TzdoSXlULzdEcEFkQyszWHdqLzlyM2k5NWxhZ1lG?=
 =?utf-8?B?WktGdTlhL1ordnlEOGFadndoSGNBYXRJK0hSMkxqWjVhM3hMbUlWOTEwSFlp?=
 =?utf-8?B?eExOMDA5OGZwcnZjT0Z0MGVINENyM1l0eG5UM3NUMUZFN3BEUnN4enl4eSsv?=
 =?utf-8?B?V0FkQ3BZYVpNdjdvMEZlWlI4VnJCNWFJeGFOZDdvd1lLYkFoZHp2eW9vdVNG?=
 =?utf-8?B?VTk4MTZzS3paT29GUVlHMGkyM0lqS0xSMmVLZ0UxdERqSWt4UXFJNGJMc0lz?=
 =?utf-8?B?M3FzYmtqZHdCUHdObFlxb1VvK0dCaVJ3THQzakdiYjZiMU5wK1l1d3k4Ui84?=
 =?utf-8?B?aExyNXR3Q09YcTdHM3dRS0xWcUtjc3cwbVdFbklwbWNJbUh5bnFpaDE2c0Vq?=
 =?utf-8?B?bG5KYkRzb1hvZ01VNUdOOEtoYUI0dUI4NW11SjB0VExBc3pKZ05pbXJNUnhu?=
 =?utf-8?B?bEJzeW1saUxINlAxV1F2K3BqZXJ3eFVaRGJNeVFiM0NoeDhLeWlZU2NrU1hw?=
 =?utf-8?B?MVhPQUw3bUlnSGhVWlJSWTVIblIrVGxUN0M2b2JOV3hQSlpqUDBad2RvZzNN?=
 =?utf-8?B?cy82QTdaR1RvK1dyVnBjc3U2Tmh0bVVVbk5BeVh4SjlUMHVaU0xPUEF6cXQz?=
 =?utf-8?B?a2NDQTJlcXNlNWJDcDM4RFNiZzRtNmM0TFZyem9zWGZhVzhyUktlNWFwWjFF?=
 =?utf-8?B?Qkh0VlN4ZzRyQnlYMytJTjZlTlVqUStKb056bHZCTnRvNk5IaThHWFhkTlNm?=
 =?utf-8?B?SWpVbkV6RnNEK2dwWnU5RHlTbUFWMjFYSXQyb29iV1IwSjg0dCtYdjhvbmkw?=
 =?utf-8?B?Qk5lUWNXSHRoQ3RXK2cxVmpqR1g5dXhRQnpJTEhKZFhqUjAxUUUvQWwvVXd2?=
 =?utf-8?B?aEJtNmNkdlVsWEpMYTAvdUZOOE5zNFFnNXByYkVoVTlkdFQvWWE4YXB2NXR5?=
 =?utf-8?B?YWhncFZUWWoxRi94c0pvS2ZvQlRZQ29vL2pkdXl6TnBTazZnbDB1eEQ1OXZi?=
 =?utf-8?B?NExXb29OQzRtanBSSG1UKyt3U1V6ZFdIeTBRT3RHOXQvMlduK3IxWkg5b0JR?=
 =?utf-8?B?UENORjQvR2FUeXc1UlBZVDBGQ2J2VUhVUHZYU285dHl5VXJNR2xsKytoSzUv?=
 =?utf-8?B?QU1hb3lOaHlTcUsvT1lhb0RZQWg0azBNY0NEQlpTbGRHclpSQ3IrVG91cFU2?=
 =?utf-8?B?ZmRzMkNpeHlaQUNIMVRRRWM0N2N6cys3YVF1dFg3eDJpUXVQT2o3VE80aG1B?=
 =?utf-8?B?K3JMUkt1WGFUMGtnSUN5WWIvUUJMdkhDZzBMRmhjd2xkZjJ3Ulc1ODN4RlJt?=
 =?utf-8?Q?C9LnIMtP0MEUmqRje7X63zEn4arkAlp4Dsa0W7A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a560cd91-995a-4c25-ebad-08d8e8a5a670
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 18:02:23.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGvJrfGmSDMtZOqkYpfwWR1ojUZELOZclss39E4qylYW94EbU7Txz0HHRC6uidFuArm0fx87gJWAW3OYBpvJeSCK/wpxuI8Udr07kE/tKL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

La 16.03.2021 19:29, Greg KH a scris:
> On Tue, Mar 16, 2021 at 07:08:38PM +0200, Mihai Carabas wrote:
>> ..snip..
>>>> +};
>>>> +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>>>> +static unsigned int events;
>>>> +
>>>> +static ssize_t capability_show(struct device *dev,
>>>> +			       struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	return sysfs_emit(buf, "%x\n", capability);
>>> A global capability for all devices?  No, this needs to be a per-device
>>> attttribute as you are showing it to userspace as such.
>> We can only have a pvpanic-pci device. This is necessary in that case?
> Why would it not be?  Why constrain yourself to something that someone
> will only have to fix sometime in the future?

Agree. But why this got in in Jan2021 for pvpanic-mmio.c (ex. pvpanic.c) 
like this :)?

