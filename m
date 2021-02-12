Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07494319FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBLNed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:34:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39544 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhBLNcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:32:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CDTO6w169070;
        Fri, 12 Feb 2021 13:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VAiL+WbAaswHZESk33R9Yy1FkBuLaLCxpl7+HeAkh6A=;
 b=GpoCiNZNKmDQ1obU0+K0cJsyPQ+6dcZY7n/uEecdD2/sLQptSlFSrpjlD9wlE+oSAi3t
 B/hZ0+VLsM8IY8p2iCmgHlcX9yQ3SNmDk1CIQu1Xi3CxVK8x3lq7h1Fqd7XpUPy2H+qK
 FABl+D2ZxCLSQaFsjzPCaGWh+mbTc7IZwjCV3wLNmZGB5GJl62qWhQFD4EdTkgTNXK6g
 ik+iry3q9gw4b5oFO2MG2kCCJe+QCC07ngW17TcYhO0DlKjVTZk4JSEylVlbYFaSsGqJ
 ILAGS7RepzhOLt8ADWKOhpaOHJbpqX9UhRAqP7tI7YKMzlMmtCIr7K1Q5rxAKLRn+3o9 TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36m4uq1qv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:31:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CDVFBG086888;
        Fri, 12 Feb 2021 13:31:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by userp3030.oracle.com with ESMTP id 36j521gasu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkX6jJEwVckMFBYEbHcqyQiUHTB6SgyKZ+X7/ThpwQD1cB7ARqcbapPuBzHF5Rq+CSCRJCkLTiv6Dg/bTeFzOgrxanTdZoiASLh0xZ01DJ7oSUIekLEgu6tCKZ9D+DzONBZDr25IHoCTwNIqby6blaYZJQs0SXGT7cqRfS49BYLfGVP1ac3S40vH+NRuq5Syi+h5uy0kA5x8/LW1yLx9aT8yc4LuFFzVzN0TnBRYz8B8Xdo1p/sfFXiUTM8GdjRIhSPs9Sm2LKEW56QNP4ns0pO4D6im9OK1Moodkspdn8Mwb3L6vOFCbjeREMY2bCcIuPHA65GE28sTgBMmwzaBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAiL+WbAaswHZESk33R9Yy1FkBuLaLCxpl7+HeAkh6A=;
 b=e2gulh0MAnaEPHi3uIkJ8Ez8qKMhbVG/L8kxbq4eG0I5inD7nFBtbzxuE5c/oQEcG5JLNQC3B3cY6vrwp48seJ0bnHvMzhXkfzqJXrzYcAUxYCPfk1qno83u7GyQuP7NfViiuxmhUm2PZ8gGTpv8Dt4TWuGmnVkag1VX4o2Nzes2nbaVy6Fwz3Zm6BUfF+NCmn6CqDJd6OtHmAd8U0h04cc+NL08YXUASW0K08rVDlSrQu238aYYU51zewbiSYj3pkd3/5nAIu+5dUXh8bzTh30XhEEU2Og0N6SpWMmsWq02MlkJMd7T3Q/nPW81/o/J7tpB6d9BS44/QhrMhCmI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAiL+WbAaswHZESk33R9Yy1FkBuLaLCxpl7+HeAkh6A=;
 b=hfoY1s4SqViV5DBTmEF556r5QWnQY6IzPUzhkueo/dUEStG1VWFVkSo/N9S+21ndR8j8UbbQF1BhXG35yV9wCJYk9zJop+31Z3vbffo0pQj0Yqg57CjBUgEUCPtwNymST/a5yhK86aQuu04GY6p+QFV2lqWVg6Q7CKRFiNzSdb8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Feb
 2021 13:31:00 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3846.027; Fri, 12 Feb 2021
 13:31:00 +0000
Subject: Re: [PATCH 1/1] iscsi_ibft: KASAN false positive failure occurs in
 ibft_init()
From:   George Kennedy <george.kennedy@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, pjones@redhat.com,
        konrad@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>, david@redhat.com
References: <1611684201-16262-1-git-send-email-george.kennedy@oracle.com>
 <YBG0glwiK1wyJTeN@Konrads-MacBook-Pro.local>
 <CACT4Y+a48smtXc6qJy9Wthwuqjk2gh6o7BK1tfWW46g7D_r-Lg@mail.gmail.com>
 <cc712c9c-7786-bb26-7082-04e564df98aa@oracle.com>
 <CACT4Y+bPDvmwk38DrKfGV8cbtS_abAMDCqr9OigcPfep0uk5AQ@mail.gmail.com>
 <20210203192856.GA324708@fedora>
 <CACT4Y+bscZGpMK-UXXzeFDeJtGYt-royR_=iTzTmBrwe3wOmTw@mail.gmail.com>
 <14124734-326e-87b3-a04a-b7190f1e1282@oracle.com>
Organization: Oracle Corporation
Message-ID: <bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com>
Date:   Fri, 12 Feb 2021 08:30:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <14124734-326e-87b3-a04a-b7190f1e1282@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by BYAPR05CA0061.namprd05.prod.outlook.com (2603:10b6:a03:74::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Fri, 12 Feb 2021 13:30:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04c4e0b3-e9bc-4a1d-bb7f-08d8cf5a6fb1
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3113D5344F7B1F870383977EE68B9@DM6PR10MB3113.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIB4lY2wo2c1bNfDzRELtG7TNYFpkLYnEgiW6B/blt8ZFAnBcUY8+gppcO7KOAiPDzFulnaLajLkEtdTEqIQUS6wSKoE2pRozB6WfD7SCLnAwulTlIYTGlppjbeZpiBuP1yiwUIGuU8V/OTXV0Smn5xxi4sBtXh+aEM6HYs5Fmo34hLUZbk4WLFq/xHYqk21bR+qAd/NGB8EOOaSfU9Ihd4RSrVWSzmRCWko1DxEZg1JhMXBbyMjDChdqRVoQGA0Ya6OViAYnvuVVOw2qxShcEDL1iZOWTUrW4LpfLa4W9RV6RwwKrCRY/fiOrd8C6o9t7c0ASlvs+wzV/JI0NYXMVjWPuWnILM8lcNuWMDuhBYRQK4rnAhQjSoCurGfcN2UEVGhZX1sVlMIe6pbDpotU+2NG7yPZfS835mpKf2h3y/rVOEVpZUhP9KorYUqbuKyK9tK5KT0mCSMomLS2MCNEFwE2KJzjwgjBDvT3VLNSkS8DGGe4ilm1kfdi4iX0/hOpjgJ/Z204Qii52hThYo1TS/ymAWBQhsros6WDWRtrhhvqUCJwfVQHEgttWN1ec1RkfERRX0YiYtGOBINdojfRxTtWiFPKu4WT/y57g0EpeS+mM6p9JRHd7t82pRihlEjg4fKxXr+UPindRNifazCJ8HPDfLAR1sRZhCRXqGC72faQHptmF84+iq9ZarFb5Mq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(44832011)(26005)(316002)(66556008)(66476007)(66946007)(83380400001)(30864003)(2616005)(5660300002)(16526019)(186003)(956004)(31696002)(53546011)(54906003)(45080400002)(110136005)(478600001)(2906002)(6666004)(36916002)(4001150100001)(36756003)(966005)(16576012)(8936002)(8676002)(7416002)(86362001)(6486002)(31686004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWprbzd0NGZsaUx2WnNzdzZWM083aGVMck50NmwwZEF3ajcrb1AwMHZLeDlL?=
 =?utf-8?B?UXVseXljVlJQWUxWdC9lYXFjWmFPbkR6RVAranpvR2c2bVR6RGo5bE9vejEx?=
 =?utf-8?B?Z3NSZFhpNmtiNXhjN0tWNllPYkR3SlVjK3NZeEpjb2ZRbm1qdHA1OVZpUk1H?=
 =?utf-8?B?TzFndW1WcENUMmQrTmtPOWlGeGM4YWRsZ2M3NUw4eWZ2M3dpTUFsUjlnY3cw?=
 =?utf-8?B?Umx5cHd5bFlUZTVYa09MUDcrRGlBa1hJb0daUWZyamUrWi9RSStpTUUyTWVR?=
 =?utf-8?B?MXB3UlNycnRzOVBSOHhHZUcxOU0rUFhtZllGVUswRTVtRUJnRjBkRjE0dTVj?=
 =?utf-8?B?N0pDTnFiRS92ZFlvUnpCS3Q2OWhTdk40YklHOUQ5YVJtdndxOWtIL0tSUWV6?=
 =?utf-8?B?OTc3UnZzVm1uWnFzYU1vdSswQ2k1aGZRdWxHZ2dtVk5tcVhEU3BEcTV2L2h0?=
 =?utf-8?B?NnRaWnBSN1ZPbysyRzU0MURDUVR4SGJ0aWNXS1hjWWxZUVFtZUlIcGN1c2hT?=
 =?utf-8?B?dndXTVVIQWc0N2phMXJBaFZvY0dlMW1iR3hEUGdOWjBzUUc5aW42ZkRJSDJF?=
 =?utf-8?B?RXJ2VVAxSEJnbEF6OWtha29zQ2RnR2tDc2MwS1B3VjB3cVB1bVJXbitDTmRP?=
 =?utf-8?B?dzhudUhTRlEzbndnS1d4KytZS2UrcWJyN2ViL3FadGVBUlhTSUtwQjZFMjVi?=
 =?utf-8?B?eWMrS2tNZ1FROGo2V3VzdkowL2Q5WHIrWS9IYXRlN0U5dXZKTmdBZ1ZreTRZ?=
 =?utf-8?B?b2EyOTBJeFM5SnpoN0szSERlVE9yRkxqS1NYRWp6dXpwUFB2SVRVVk0vaGpO?=
 =?utf-8?B?eGxobmlqSm5heFZNdjVqRVV0Zkl1OXpGK2Y3N0NwRGt0UkRFdHpRNWVEbDIz?=
 =?utf-8?B?eENPYWFXZGZxcnZYKytDVzhiT0JweGFtaG9IRnE1MituYkM0UElFWHZlb29B?=
 =?utf-8?B?RXBIQ3Z5c1R0UllWRU9YOC8vWWJGZ2RodThvdUkxSCtEWlVBeHVmL1NvRGlD?=
 =?utf-8?B?L3hWTkxQUnlBTVhZcE5IQys0Yyt0NDV4RWZUalAzTk1YM2RsNm1DTlFkUitR?=
 =?utf-8?B?c0lpYjBFaUd6c3dsNDJmdzgxcUUzeEJZUlhrdDFRZERYRWN6bHR2N2w1Uy9Y?=
 =?utf-8?B?b3FKSSs2TU4yK2FUa1ZUZUZrWEtLYVhzeWxEYlpBVWxUakdQSk1yWTRaOWhX?=
 =?utf-8?B?b2F5WUQvbThMaEN1U0tZeEl0UFgwZUllYVc0K01nQU1KVFJBY2JDdnFxMy9K?=
 =?utf-8?B?MVRIbHNDWWx1WEp0Rm5Wb2owNTNvcmNITHJrZSsvRlF6QzQxRGIzdldzb09X?=
 =?utf-8?B?WmhZNFdjN2VnbGt3SFVVWVZ0Qlloc1FFNTRHVUxBMzhKcndZdVdrd2xCdVoy?=
 =?utf-8?B?ZDlmV3hJbzY0NTMwMmtULzd5V0dHM2M4RHBOZmk0VGJESnZsbytIYmdMWVVh?=
 =?utf-8?B?VWhwR1RHQk5TYmpKSGJoS2JhVWNEWjZqZWtqdWxRdEYxZWpUbWRmemtUa1pC?=
 =?utf-8?B?a1JyZzR6TUtjTExJMzRTcEhQN0VzL1VUQlJmY2NKMWhZOXFkMGMwS2FGa3Qx?=
 =?utf-8?B?VWc2dkRsdVcyZFlwWHBJSzUzQ1FZeUdFOHg3UXRYRFp4U3ZUU2JRN3ZRVkR5?=
 =?utf-8?B?T1hZVGljYm93T2RuRlEyUWdRSzNPWGxJekVUeVY5TUFMaDJaUFRwS3NyNEdQ?=
 =?utf-8?B?MFMyMU5MaVNrVjRGNmR2QXYwa1lDVm15dklnYjhvems0VUxDUVFWQy9Bc1p3?=
 =?utf-8?Q?E2MmIHwCY+n3F/l28LqK5knPBCpjDq6gCj6BL5D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c4e0b3-e9bc-4a1d-bb7f-08d8cf5a6fb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 13:31:00.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DH9SkalP/4Osz2OPD1T8OsPm9qHbWVDH44Ro1l9/8TBgVc7DNc0XwLLC2YB/RfPwPFn79YDsYzon13E6+9V+rcZ3rTFcfwp8DhUz5Y+KBIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3113
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/2021 4:51 PM, George Kennedy wrote:
>
>
> On 2/3/2021 2:35 PM, Dmitry Vyukov wrote:
>> On Wed, Feb 3, 2021 at 8:29 PM Konrad Rzeszutek Wilk 
>> <konrad@darnok.org> wrote:
>>> Hey Dmitry, Rafael, George, please see below..
>>>
>>> On Wed, Jan 27, 2021 at 10:10:07PM +0100, Dmitry Vyukov wrote:
>>>> On Wed, Jan 27, 2021 at 9:01 PM George Kennedy
>>>> <george.kennedy@oracle.com> wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>> On 1/27/2021 1:48 PM, Dmitry Vyukov wrote:
>>>>>
>>>>> On Wed, Jan 27, 2021 at 7:44 PM Konrad Rzeszutek Wilk
>>>>> <konrad.wilk@oracle.com> wrote:
>>>>>
>>>>> On Tue, Jan 26, 2021 at 01:03:21PM -0500, George Kennedy wrote:
>>>>>
>>>>> During boot of kernel with CONFIG_KASAN the following KASAN false
>>>>> positive failure will occur when ibft_init() reads the
>>>>> ACPI iBFT table: BUG: KASAN: use-after-free in ibft_init
>>>>>
>>>>> The ACPI iBFT table is not allocated, and the iscsi driver uses
>>>>> a pointer to it to calculate checksum, etc. KASAN complains
>>>>> about this pointer with use-after-free, which this is not.
>>>>>
>>>>> Andrey, Alexander, Dmitry,
>>>>>
>>>>> I think this is the right way for this, but was wondering if you have
>>>>> other suggestions?
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Hi George, Konrad,
>>>>>
>>>>> Please provide a sample KASAN report and kernel version to match 
>>>>> line numbers.
>>>>>
>>>>> 5.4.17-2102.200.0.0.20210106_0000
>>>>>
>>>>> [   24.413536] iBFT detected.
>>>>> [   24.414074]
>>>>> ==================================================================
>>>>> [   24.407342] BUG: KASAN: use-after-free in ibft_init+0x134/0xb8b
>>>>> [   24.407342] Read of size 4 at addr ffff8880be452004 by task 
>>>>> swapper/0/1
>>>>> [   24.407342]
>>>>> [   24.407342] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
>>>>> 5.4.17-2102.200.0.0.20210106_0000.syzk #1
>>>>> [   24.407342] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>>>>> 1996), BIOS 0.0.0 02/06/2015
>>>>> [   24.407342] Call Trace:
>>>>> [   24.407342]  dump_stack+0xd4/0x119
>>>>> [   24.407342]  ? ibft_init+0x134/0xb8b
>>>>> [   24.407342] print_address_description.constprop.6+0x20/0x220
>>>>> [   24.407342]  ? ibft_init+0x134/0xb8b
>>>>> [   24.407342]  ? ibft_init+0x134/0xb8b
>>>>> [   24.407342]  __kasan_report.cold.9+0x37/0x77
>>>>> [   24.407342]  ? ibft_init+0x134/0xb8b
>>>>> [   24.407342]  kasan_report+0x14/0x1b
>>>>> [   24.407342]  __asan_report_load_n_noabort+0xf/0x11
>>>>> [   24.407342]  ibft_init+0x134/0xb8b
>>>>> [   24.407342]  ? dmi_sysfs_init+0x1a5/0x1a5
>>>>> [   24.407342]  ? dmi_walk+0x72/0x89
>>>>> [   24.407342]  ? ibft_check_initiator_for+0x159/0x159
>>>>> [   24.407342]  ? rvt_init_port+0x110/0x101
>>>>> [   24.407342]  ? ibft_check_initiator_for+0x159/0x159
>>>>> [   24.407342]  do_one_initcall+0xc3/0x44d
>>>>> [   24.407342]  ? perf_trace_initcall_level+0x410/0x405
>>>>> [   24.407342]  kernel_init_freeable+0x551/0x673
>>>>> [   24.407342]  ? start_kernel+0x94b/0x94b
>>>>> [   24.407342]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
>>>>> [   24.407342]  ? __kasan_check_write+0x14/0x16
>>>>> [   24.407342]  ? rest_init+0xe6/0xe6
>>>>> [   24.407342]  kernel_init+0x16/0x1bd
>>>>> [   24.407342]  ? rest_init+0xe6/0xe6
>>>>> [   24.407342]  ret_from_fork+0x2b/0x36
>>>>> [   24.407342]
>>>>> [   24.407342] The buggy address belongs to the page:
>>>>> [   24.407342] page:ffffea0002f91480 refcount:0 mapcount:0 
>>>>> mapping:0000000000000000 index:0x1
>>>>> [   24.407342] flags: 0xfffffc0000000()
>>>>> [   24.407342] raw: 000fffffc0000000 ffffea0002fca588 
>>>>> ffffea0002fb1a88 0000000000000000
>>>>> [   24.407342] raw: 0000000000000001 0000000000000000 
>>>>> 00000000ffffffff 0000000000000000
>>>>> [   24.407342] page dumped because: kasan: bad access detected
>>>>> [   24.407342]
>>>>> [   24.407342] Memory state around the buggy address:
>>>>> [   24.407342]  ffff8880be451f00: ff ff ff ff ff ff ff ff ff ff ff 
>>>>> ff ff ff ff ff
>>>>> [   24.407342]  ffff8880be451f80: ff ff ff ff ff ff ff ff ff ff ff 
>>>>> ff ff ff ff ff
>>>>> [   24.407342] >ffff8880be452000: ff ff ff ff ff ff ff ff ff ff ff 
>>>>> ff ff ff ff ff
>>>>> [   24.407342]                    ^
>>>>> [   24.407342]  ffff8880be452080: ff ff ff ff ff ff ff ff ff ff ff 
>>>>> ff ff ff ff ff
>>>>> [   24.407342]  ffff8880be452100: ff ff ff ff ff ff ff ff ff ff ff 
>>>>> ff ff ff ff ff
>>>>> [   24.407342]
>>>>> ==================================================================
>>>>> [   24.407342] Disabling lock debugging due to kernel taint
>>>>> [   24.451021] Kernel panic - not syncing: panic_on_warn set ...
>>>>> [   24.452002] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G B 
>>>>> 5.4.17-2102.200.0.0.20210106_0000.syzk #1
>>>>> [   24.452002] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>>>>> 1996), BIOS 0.0.0 02/06/2015
>>>>> [   24.452002] Call Trace:
>>>>> [   24.452002]  dump_stack+0xd4/0x119
>>>>> [   24.452002]  ? ibft_init+0x102/0xb8b
>>>>> [   24.452002]  panic+0x28f/0x6e0
>>>>> [   24.452002]  ? __warn_printk+0xe0/0xe0
>>>>> [   24.452002]  ? ibft_init+0x134/0xb8b
>>>>> [   24.452002]  ? add_taint+0x68/0xb3
>>>>> [   24.452002]  ? add_taint+0x68/0xb3
>>>>> [   24.452002]  ? ibft_init+0x134/0xb8b
>>>>> [   24.452002]  ? ibft_init+0x134/0xb8b
>>>>> [   24.452002]  end_report+0x4c/0x54
>>>>> [   24.452002]  __kasan_report.cold.9+0x55/0x77
>>>>> [   24.452002]  ? ibft_init+0x134/0xb8b
>>>>> [   24.452002]  kasan_report+0x14/0x1b
>>>>> [   24.452002]  __asan_report_load_n_noabort+0xf/0x11
>>>>> [   24.452002]  ibft_init+0x134/0xb8b
>>>>> [   24.452002]  ? dmi_sysfs_init+0x1a5/0x1a5
>>>>> [   24.452002]  ? dmi_walk+0x72/0x89
>>>>> [   24.452002]  ? ibft_check_initiator_for+0x159/0x159
>>>>> [   24.452002]  ? rvt_init_port+0x110/0x101
>>>>> [   24.452002]  ? ibft_check_initiator_for+0x159/0x159
>>>>> [   24.452002]  do_one_initcall+0xc3/0x44d
>>>>> [   24.452002]  ? perf_trace_initcall_level+0x410/0x405
>>>>> [   24.452002]  kernel_init_freeable+0x551/0x673
>>>>> [   24.452002]  ? start_kernel+0x94b/0x94b
>>>>> [   24.452002]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
>>>>> [   24.452002]  ? __kasan_check_write+0x14/0x16
>>>>> [   24.452002]  ? rest_init+0xe6/0xe6
>>>>> [   24.452002]  kernel_init+0x16/0x1bd
>>>>> [   24.452002]  ? rest_init+0xe6/0xe6
>>>>> [   24.452002]  ret_from_fork+0x2b/0x36
>>>>> [   24.452002] Dumping ftrace buffer:
>>>>> [   24.452002] ---------------------------------
>>>>> [   24.452002] swapper/-1         1.... 24564337us : rdmaip_init: 
>>>>> 2924: rdmaip_init: Active Bonding is DISABLED
>>>>> [   24.452002] ---------------------------------
>>>>> [   24.452002] Kernel Offset: disabled
>>>>> [   24.452002] Rebooting in 1 seconds..
>>>>>
>>>>> Why does KASAN think the address is freed? For that to happen that
>>>>> memory should have been freed. I don't remember any similar false
>>>>> positives from KASAN, so this looks a bit suspicious.
>>>>>
>>>>> I'm not sure why KASAN thinks the address is freed. There are 
>>>>> other modules where KASAN/KCOV is disabled on boot.
>>>>> Could this be for a similar reason?
>>>> Most of these files are disabled because they cause recursion in
>>>> instrumentation, or execute too early in bootstrap process (before
>>>> kasan_init).
>>>>
>>>> Somehow the table pointer in ibft_init points to a freed page. I
>>>> tracked it down to here:
>>>> https://elixir.bootlin.com/linux/v5.4.17/source/drivers/acpi/acpica/tbutils.c#L399 
>>>>
>>>> but I can't find where this table_desc->pointer comes from. Perhaps it
>>> It is what the BIOS generated. It usually points to some memory
>>> location in right under 4GB and the BIOS stashes the DSDT, iBFT, and
>>> other tables in there.
>>>
>>>> uses some allocation method that's not supported by KASAN? However,
>>>> it's the only such case that I've seen, so it's a bit weird. Could it
>>>> use something like memblock_alloc? Or maybe that page was in fact
>>>> freed?... Too bad KASAN does not print free stack for pages, maybe
>>>> it's not too hard to do if CONFIG_PAGE_OWNER is enabled...
>>> Hm, there is a comment in the acpi_get_table speaking about the
>>> requirement of having a acpi_put_table and:
>>>
>>>
>>>   * DESCRIPTION: Finds and verifies an ACPI table. Table must be in the
>>>   *              RSDT/XSDT.
>>>   *              Note that an early stage acpi_get_table() call must 
>>> be paired
>>>   *              with an early stage acpi_put_table() call. 
>>> otherwise the table
>>>   *              pointer mapped by the early stage mapping 
>>> implementation may be
>>>   *              erroneously unmapped by the late stage unmapping 
>>> implementation
>>>   *              in an acpi_put_table() invoked during the late stage.
>>>   *
>>>
>>> Which would imply that I should use acpi_put_table in the error path
>>> (see below a patch), but also copy the structure instead of depending
>>> on ACPI keeping it mapped for me. I think.
>> Hi Konrad,
>>
>> Thanks for looking into this.
>> If ACPI unmaps this page, that would perfectly explain the KASAN report.
>>
>> George, does this patch eliminate the KASAN report for you?
>
> Hi Dmitry,
>
> No luck with the patch. Tried high level bisect instead. Here are the 
> results:
>
> BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
>
> Bisect status:
> v5.11-rc6 Sun Jan 31 13:50:09 2021 -0800     Failed
> v5.11-rc1 Sun Dec 27 15:30:22 2020 -0800    Failed
> v5.10 Sun Dec 13 14:41:30 2020 -0800           Failed
> v5.10-rc6 Sun Nov 29 15:50:50 2020 -0800    Failed
> v5.10-rc5 Sun Nov 22 15:36:08 2020 -0800    Failed
> v5.10-rc4 Sun Nov 15 16:44:31 2020 -0800    Failed
> v5.10-rc3 Sun Nov 8 16:10:16 2020 -0800      Failed
> v5.10-rc2 Sun Nov 1 14:43:52 2020 -0800      Failed
> v5.10-rc1 Sun Oct 25 15:14:11 2020 -0700     Failed
> v5.9 Sun Oct 11 14:15:50 2020 -0700              OK - 10 reboots so 
> far w/o kasan failure
>
> So, will look at what changed between v5.9 and v5.10-rc1

git bisect has identified the following as the offending commit:

2020-10-16 torvalds@linux-foundation.org - 7fef431 2020-10-15 David 
Hildenbrand mm/page_alloc: place pages to tail in __free_pages_core()

Here's the commit that follows the above:

2020-10-16 torvalds@linux-foundation.org - 293ffa5 2020-10-15 David 
Hildenbrand mm/page_alloc: move pages to tail in move_to_free_list()

With HEAD=7fef431 the KASAN crash occurs.
With HEAD=293ffa5 no crash.

With latest upstream (HEAD=dcc0b49) now getting this:

[    1.759763] BUG: unable to handle page fault for address: 
ffff8880be453000
[    1.761100] #PF: supervisor read access in kernel mode
[    1.762106] #PF: error_code(0x0000) - not-present page
[    1.763114] PGD 28c01067 P4D 28c01067 PUD 13fb01067 PMD 13f90e067 PTE 
800fffff41bac060
[    1.764672] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[    1.765731] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
5.11.0-rc7-dcc0b49 #39
[    1.767103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 0.0.0 02/06/2015
[    1.768665] RIP: 0010:acpi_tb_verify_checksum 
(drivers/acpi/acpica/tbprint.c:161)
[    1.773301] RSP: 0000:ffffffff8fe07c78 EFLAGS: 00010246
[    1.774330] RAX: 0000000000000003 RBX: ffff8880be453000 RCX: 
ffffffff839ab92c
[    1.775718] RDX: 1ffff11017c8a600 RSI: ffffffff8fe3dec0 RDI: 
0000000000000002
[    1.777099] RBP: ffffffff8fe07c90 R08: 0000000000000000 R09: 
fffffbfff212ebfd
[    1.778479] R10: ffffffff90975fe7 R11: fffffbfff212ebfc R12: 
0000000000000800
[    1.779864] R13: 0000000000000800 R14: dffffc0000000000 R15: 
0000000000000000
[    1.781245] FS:  0000000000000000(0000) GS:ffff88810a400000(0000) 
knlGS:0000000000000000
[    1.782819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.783941] CR2: ffff8880be453000 CR3: 0000000024e30000 CR4: 
00000000000006b0
[    1.785325] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    1.786709] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    1.788094] Call Trace:
[    1.788595] acpi_tb_verify_temp_table (drivers/acpi/acpica/tbdata.c:499)
[    1.789546] ? acpi_tb_validate_temp_table 
(drivers/acpi/acpica/tbdata.c:469)
[    1.790536] ? __sanitizer_cov_trace_pc (kernel/kcov.c:197)
[    1.791474] ? write_comp_data (kernel/kcov.c:218)
[    1.792263] ? write_comp_data (kernel/kcov.c:218)
[    1.793049] ? __sanitizer_cov_trace_pc (kernel/kcov.c:197)
[    1.793983] ? write_comp_data (kernel/kcov.c:218)
[    1.794766] acpi_reallocate_root_table 
(drivers/acpi/acpica/tbxface.c:182)
[    1.795736] ? acpi_tb_parse_root_table 
(drivers/acpi/acpica/tbxface.c:134)
[    1.796706] ? write_comp_data (kernel/kcov.c:218)
[    1.797488] ? __sanitizer_cov_trace_pc (kernel/kcov.c:197)
[    1.798422] acpi_early_init (drivers/acpi/bus.c:1050)
[    1.799211] start_kernel (init/main.c:1023)
[    1.799955] x86_64_start_reservations (arch/x86/kernel/head64.c:526)
[    1.800875] x86_64_start_kernel (arch/x86/kernel/head64.c:507)
[    1.801699] secondary_startup_64_no_verify 
(arch/x86/kernel/head_64.S:283)
[    1.802709] Modules linked in:
[    1.803324] Dumping ftrace buffer:
[    1.804003]    (ftrace buffer empty)
[    1.804707] CR2: ffff8880be453000
[    1.805369] ---[ end trace fab88542288c30b6 ]---
[    1.806272] RIP: 0010:acpi_tb_verify_checksum 
(drivers/acpi/acpica/tbprint.c:161)
[ 1.807325] Code: da b8 ff ff 37 00 48 c1 e0 2a 48 c1 ea 03 8a 14 02 48 
89 d8 83 e0 07 83 c0 03 38 d0 7c 0c 84 d2 74 08 48 89 df e8 c6 f8 1e fe 
<44> 8b 23 bf 53 33 50 54 44 89 e6 e8 f6 84 db fd 41 81 fc 53 33 50
[    1.810904] RSP: 0000:ffffffff8fe07c78 EFLAGS: 00010246
[    1.811930] RAX: 0000000000000003 RBX: ffff8880be453000 RCX: 
ffffffff839ab92c
[    1.813312] RDX: 1ffff11017c8a600 RSI: ffffffff8fe3dec0 RDI: 
0000000000000002
[    1.814701] RBP: ffffffff8fe07c90 R08: 0000000000000000 R09: 
fffffbfff212ebfd
[    1.816078] R10: ffffffff90975fe7 R11: fffffbfff212ebfc R12: 
0000000000000800
[    1.817458] R13: 0000000000000800 R14: dffffc0000000000 R15: 
0000000000000000
[    1.818841] FS:  0000000000000000(0000) GS:ffff88810a400000(0000) 
knlGS:0000000000000000
[    1.820406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.821529] CR2: ffff8880be453000 CR3: 0000000024e30000 CR4: 
00000000000006b0
[    1.822918] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    1.824299] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    1.825680] Kernel panic - not syncing: Fatal exception
[    1.827454] Dumping ftrace buffer:
[    1.828122]    (ftrace buffer empty)
[    1.828821] Rebooting in 1 seconds..

Thank you,
George

>
> Failure is intermittent, so takes a lot of retries.
>
> Thank you,
> George
>
>>
>>
>>> CC-ing Rafeal.
>>>
>>>
>>>  From c37da50fdfc62cd4f7b23562b55661478c90a17d Mon Sep 17 00:00:00 2001
>>> From: Konrad Rzeszutek Wilk <konrad@darnok.org>
>>> Date: Tue, 2 Feb 2021 17:28:28 +0000
>>> Subject: [PATCH] ibft: Put ibft_addr back
>>>
>>> Signed-off-by: Konrad Rzeszutek Wilk <konrad@darnok.org>
>>> ---
>>>   drivers/firmware/iscsi_ibft.c | 19 +++++++++++++------
>>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/firmware/iscsi_ibft.c 
>>> b/drivers/firmware/iscsi_ibft.c
>>> index 7127a04..2a1a033 100644
>>> --- a/drivers/firmware/iscsi_ibft.c
>>> +++ b/drivers/firmware/iscsi_ibft.c
>>> @@ -811,6 +811,10 @@ static void ibft_cleanup(void)
>>>                  ibft_unregister();
>>>                  iscsi_boot_destroy_kset(boot_kset);
>>>          }
>>> +       if (ibft_addr) {
>>> +               acpi_put_table((struct acpi_table_header *)ibft_addr);
>>> +               ibft_addr = NULL;
>>> +       }
>>>   }
>>>
>>>   static void __exit ibft_exit(void)
>>> @@ -835,13 +839,15 @@ static void __init acpi_find_ibft_region(void)
>>>   {
>>>          int i;
>>>          struct acpi_table_header *table = NULL;
>>> +       acpi_status status;
>>>
>>>          if (acpi_disabled)
>>>                  return;
>>>
>>>          for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
>>> -               acpi_get_table(ibft_signs[i].sign, 0, &table);
>>> -               ibft_addr = (struct acpi_table_ibft *)table;
>>> +               status = acpi_get_table(ibft_signs[i].sign, 0, &table);
>>> +               if (ACPI_SUCCESS(status))
>>> +                       ibft_addr = (struct acpi_table_ibft *)table;
>>>          }
>>>   }
>>>   #else
>>> @@ -870,12 +876,13 @@ static int __init ibft_init(void)
>>>
>>>                  rc = ibft_check_device();
>>>                  if (rc)
>>> -                       return rc;
>>> +                       goto out_free;
>>>
>>>                  boot_kset = iscsi_boot_create_kset("ibft");
>>> -               if (!boot_kset)
>>> -                       return -ENOMEM;
>>> -
>>> +               if (!boot_kset) {
>>> +                       rc = -ENOMEM;
>>> +                       goto out_free;
>>> +               }
>>>                  /* Scan the IBFT for data and register the 
>>> kobjects. */
>>>                  rc = ibft_register_kobjects(ibft_addr);
>>>                  if (rc)
>>> -- 
>>> 1.8.3.1
>>>
>

