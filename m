Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4343B044
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbhJZKlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:41:20 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:42934 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234571AbhJZKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:41:14 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QAX2sO012000;
        Tue, 26 Oct 2021 10:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=ST6QhdbzQeAN2mOYOTCRKTSH7hOMDPwOjWjZ3IKe4wM=;
 b=if4L+edB4J/t09rcfyZ/W8wkz2yh95j2g1X5gG3YXY/k38RovEO/mDrbGCI7vQOwPPnR
 nfd8UI/OCinPAoKUFj8l2sfXMDI8A/cQvsiJMJsNFlV/qPqAmZPgpKvLdCY0zPklG/xP
 WYXVYgtZiJdJUcQ1Cn48QxsjBF2L1XqX3IT+v6HyH/joYFqBWOgC/8wYJgjTwHkWpyu3
 /5toZeeOvaq1XFcHHd5aznmcZyJSFwkmxgQzxjaZRdZB81wz8bg7xWoH9vfnFD2U8pV8
 IG5JzFXUmiyRenfa6uK7qFa2U2SWYhAS0Yy31uVhOdN+mmQI499a0xi4PP+n5xpXdmNa tA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bx4rcgdas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 10:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUgqXJPxpQ/Wx3IZW6CCuwMvNEGSGWU4E+5eFLbZsMsU5+7r2q0PBu8+P3hmn4T0rAA7xq9RWvtD/J6Y7QrvxVn4EkXDk7iMJXpP4WBf8TRACG8zr3bSep2Y8+30/b1tsRFPfrvCXaw2y29QjYFFkjW+6lRVwy72PNljA0+wUJTWMDkpPG7+a6QMeHJO+x90ZSsFEJxCFVlWPdJhhUu4PlCkzrH1qUWlrXpQFrLkBjStyzuU2ZM95EhBqTNNcqnddsBV8uj67L2rhCr33IsheVN61MImediEWo1kOqZiVO3j9EDXH0NNj7z+26r5jvp0KBgRy8X5UwuaIKCeoFY0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST6QhdbzQeAN2mOYOTCRKTSH7hOMDPwOjWjZ3IKe4wM=;
 b=iwALj0ugQVFUPDyOaEj95ocBoH7o/s32+bNCSaqs7HCExGRLbL1djO/eBbqKaARdDmv2ucTPDZE67OASAxD8ZKuwhonhZJ0VYn7ipC6DI/0nPRxt7kwtM8dRKV/uR+kamzDIEJaIOxr6mwyWQ/iH1Fm7jM7CvzeR+f7WBbSGe2zBzpcpc+NefATON6o1yB9cJ4y77a6ptJOCbC/W2jF4XnAE+0jIE6tLzOarvpN0sCv2LgKMvIezhZixOBPpESOnDUnLBVnyko6mL3ee0AkppQaXpU+1W8CScxTqTYyu2lmWed0CrlLLlnhbYlKJ5MaN4Z8tcBltXLlvDuyDbjovcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 10:38:25 +0000
Received: from PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::3508:ff4c:362d:579c]) by PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::3508:ff4c:362d:579c%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 10:38:25 +0000
Subject: Re: [PATCH] ARM: add BUILD_BUG_ON to check if fixmap range spans
 multiple pmds
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211020054942.1608637-1-quanyang.wang@windriver.com>
 <CACRpkdYxMDp4FRGP=EOt8oTMxs_YuskbvMx5wXBDjUWz6hD=gQ@mail.gmail.com>
 <YXfDdmrCynZk/QW8@shell.armlinux.org.uk>
 <cddc3cd6-a36d-e02f-4cd8-26ff15e72d13@windriver.com>
 <CAMj1kXEyc0S6A_OQRQOTtTFxev=Kj55Zhn2dRDaZ6FP+Ek=17w@mail.gmail.com>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <8905597e-49a9-c898-c78d-3d2f51180133@windriver.com>
Date:   Tue, 26 Oct 2021 18:38:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAMj1kXEyc0S6A_OQRQOTtTFxev=Kj55Zhn2dRDaZ6FP+Ek=17w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:202:17::19) To PH7PR11MB5819.namprd11.prod.outlook.com
 (2603:10b6:510:13b::9)
MIME-Version: 1.0
Received: from [128.224.162.199] (60.247.85.82) by HK2PR03CA0049.apcprd03.prod.outlook.com (2603:1096:202:17::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend Transport; Tue, 26 Oct 2021 10:38:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d39855-25d3-4d03-b95b-08d9986cbd40
X-MS-TrafficTypeDiagnostic: PH0PR11MB5015:
X-Microsoft-Antispam-PRVS: <PH0PR11MB5015D0AFD3E6AAA7E3294F12F0849@PH0PR11MB5015.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYl5JfCKfbqMi8s+tBpQeI+DOJAL1Hv4va/Bu4GkpZHa+5ety7764CByQ34Y/Or6xANBuqGnUlov0tDWtnTVaGwWSuZfnb12KjEkNXLnkZw7ttf630KDMLel+tx15/DaS9JoVfkXUsK9qpprXRdG/6cMgNXnwdyyrsTeLDuWJrOPwTTQ7HIq6UCOqLTnDrLj7+mcR4nk8WSWTdb9UHLCadJq6jKr9pk2OZvtsXEhetxTs9/J/Ab45c7QE3b8G6OFrqueu2OEIg54/CbF75G/O1HuCOCJH8PjjD85DATvd+/DgImZ/3ctIS+0bg9kesB2rLSIWiLHcwp0l575L+FGatU3Ij5u7O3VpjYRJ5RuhyGdrWYgrTGqvWR4vArUGlcySRaU2V6jgS+be7KJjUYVtZQ8TdGg3YBwUc8LkKRWYqaocNIaO5PL0PjLf2Rfam7HYHhFlZo67jYCzz9+VRVdETy58e4J9LBJ4eTgLLLaQAXe07rzUM4p0dFljZBcIURzAFhY1+kj0Uz5qeCFfkOWz2JudgEs/bPoAul3CNCeaDo5+/MRWEGAUNczkf3z5Cwu4GdOaO8MbfmEZ/bOKxtH7runVUEQCJxtTlZhCdtJf10rUgT9361tdldQIvnh2grB5ZVXynZ8Joq0uL3o9eQIOWDRDFwtQBVqnv+C4gokUci/X2/nrHd2LjF38V1D7CH5sJ35Ls9QRkwiqgMfTGJQ57oo+O5TJVR6eHX17rDxJ80qnJH2yYDCez7MKUasdpfPWkpradSm0Rk1TCFe5ZP1CjnJvFyStN6PK1Q9xWr8njI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(16576012)(38100700002)(5660300002)(54906003)(316002)(31686004)(83380400001)(52116002)(6706004)(6916009)(2906002)(508600001)(26005)(66476007)(956004)(8676002)(36756003)(2616005)(31696002)(86362001)(8936002)(186003)(66556008)(4326008)(6666004)(38350700002)(66946007)(6486002)(53546011)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZGWVY5OVMzMXBSWldua25jb1VWNE9lWGc5bUJaTGZSY08xM05ndzBHNDdh?=
 =?utf-8?B?bU12SXlhelBuVmZXQlFqK1grQkRSWFBXendYem9MQ2ttTUs1VzRZU2NOL3RC?=
 =?utf-8?B?bkN6bVo1MWREclgyUG5JTHVSVlVRZTZYSkRyOVVZTng0UDJMRFVSYXVCNlI0?=
 =?utf-8?B?VnlTbExkNHd4Q09vVnA4cXh1VitFSFoyWlVmK3NIRThMMUxVZ1Joc1hQNmRz?=
 =?utf-8?B?cXl5QjltdUVSMGJVSUhyZ2Z2T2t2S1EwVHo2MWU2NE5Fb3R2eVJuQXdMSExF?=
 =?utf-8?B?T2srOWtUcTgxSWdpcU9BbUgvaDZJeUpmMSs4c29YSXA5RmYxeUNhMklBcU15?=
 =?utf-8?B?R0d6SkRvSnhISGJqM1lZTmRZcVJ4VVE4VWxYMGxJb3JWZTRqSzVYT0FhWmNQ?=
 =?utf-8?B?SmNnNUhpRElaVmJhTWZDdkQySDRNbkdPMHRmZkVjMVpSRDd4NkJUa1h1UktQ?=
 =?utf-8?B?YVhHWWd4L0ZHVEVUN0l0aDYzcW1NUlVsVCtUcnFMSUR3cTk5L1hHWk5aM25y?=
 =?utf-8?B?K3hhME91WDd5aDdtMkdJYXFyRkFkU3JmdXVSUnExbC9QQzkzNHVoR1V2eXBs?=
 =?utf-8?B?RUR1S014RHpmcGpzaDBEMGhhdlZmenh3OVJod2gvZjdwdS90aXl5d1ZOSUp3?=
 =?utf-8?B?YkJBZldPWTZaZkFWbUMwME9PRzZKYU8xMlZ0emhYekFNY2drTXhESnJJa0s4?=
 =?utf-8?B?UnpTVjZpOUx6dUNIVlQ0eTJxZUsxK0hFWUdDRUFQaHI5UzBFUE5oa2VGSFYy?=
 =?utf-8?B?dVdDZUlQamxuVzY0dDhHMmhSQjg2TnZORG5kN09LYm0wZ1RHeUxHeE9LU0lP?=
 =?utf-8?B?UGJDVzhCNjFjQUlaTjJBbkVMNWdUcWhzWGY5R25Xb2JMMlRyN3ZJNjU4ZUlZ?=
 =?utf-8?B?eERVb245NXJQbHQ5U3F1KzZEenRRVzdFQ00xK3kyd2xvU3Jjb1hyTm1rM3lX?=
 =?utf-8?B?V0p3NnZGMmV0TzZhOG0wUCtUOTdFZWE4TlFuaTY5c2Y2dTM1VWl2MFNnVnp0?=
 =?utf-8?B?RFZMQkdJajlZWnUzTHMrMUtONG01bGFpZDZhZzJOWmxtcVJ0UTFXcXhCYXA1?=
 =?utf-8?B?T3oxbXlXUU11K1gwczBQSFI1cHpnNkpSSW00NlpGeU1uSHFNRkw3TDhJbkpX?=
 =?utf-8?B?UmlrRnpoa0JqdVhJbi9SMFBVeVVJRFB2TUU4YmJlOHNIWTdUNEFZTEhmL2kr?=
 =?utf-8?B?SzdEbVcyMythMllNamx4S244T2l4dG9hckFaU2d2ZkdiRU5rQlZVeHhhZWgw?=
 =?utf-8?B?U2p4WHpaNXBnNzVtdFNpR1FPNHd6MkR0cDQxUWRob0RDNHorN2hoV2EwRzFX?=
 =?utf-8?B?Y1dTeHhvc2V3Uzd0alFzWkozNXA5QTJ6SXBueTdIeVhjWkJPb3V6RlRsQTc0?=
 =?utf-8?B?WjFGMzByQlp3Zlk2azZxbkcvRnZ3VzBLQk9CZHJ2bnVaTlhtT3k0dHV3VHUy?=
 =?utf-8?B?c1V1T0IxOWRQaVdwTnNiaFVpWHRrMzA2Q2I2UUFMbkhsaTIxS1ZEeUx1cUI5?=
 =?utf-8?B?YWd6bVlpb0pGYWlhMWlkUnd2L1VFRlM4QmU5bkJWV3BqL2N3UzQ1UG1aNm0x?=
 =?utf-8?B?dVlPS3RxWlBwRU5NcHFMVnpzb0VoZExybDhseHNxWTNGb2xFejhRNEdSbWVN?=
 =?utf-8?B?aGpSVmVsQ3hjUlZKNnY1QWd2N0kyTkFnREZLdzRtRzgyV3Vmckk3THd0ekda?=
 =?utf-8?B?U3RUN2MyVWlRbFovdDdoNzJGV25tVkJiRmpSR1NMSHlPdHgvWVhQVUlHUGYr?=
 =?utf-8?B?bEZwNm12bk80SGNHUEZqTTk2V05KMmFkcTI4MlBNZXpqK1E0eEhmdmxwWGgv?=
 =?utf-8?B?dkhzcmllakJrOGVtVVJnemNURWM3Rm5SeER3STVmVnlVLzFCSGRlbThxeXRB?=
 =?utf-8?B?S3Rrd3lsQ0piaUoxTkJCdnNZdUhlL2dkWnlCRnlTdlJaQ2hrVmV3Rzl4WjN4?=
 =?utf-8?B?UzFMeTFrNDRFTFpPYzZKOGNYNXNqS2FtMjBRRnM4NzFma1lOVThjeTB1c2xD?=
 =?utf-8?B?SllQb0Fkdlo5ZE5MQlh3YVlORVViK2UxTmREOHlVUnhzTm9hV05URmRQMzlu?=
 =?utf-8?B?amNaeWUySnBRZjdnNUQ0UFY4cDNvcmNtOXVzZCtqTVE3RkRTOC9RYXF6Q204?=
 =?utf-8?B?aU1wakVDNWt2N00xdzZZbCt6dUo4RGZlNGY3MmFhbnFveG8yeElFeGZScE0v?=
 =?utf-8?B?OXZUM0YyVStZT0VzWnNtVU81cTRYMjViUWpodk41WXVBUTlsa0JvMmV3VEVM?=
 =?utf-8?B?TDVwUHRoWTFWUG9SaVUzNGdGckV3PT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d39855-25d3-4d03-b95b-08d9986cbd40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 10:38:25.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XYMK8qrVIIJeqN6FrCupKyJ8dg533Qs7Ce4dgrH2YPJt33y/DvxRbHAUYovR7j3RV1htsK1sxzlVy9bJqEmbkHAucpr4hvkQgPte4NAz+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-Proofpoint-GUID: jvATNMsemRBiwfej0akCKkJhywNC3xvf
X-Proofpoint-ORIG-GUID: jvATNMsemRBiwfej0akCKkJhywNC3xvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=840 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 10/26/21 6:12 PM, Ard Biesheuvel wrote:
> On Tue, 26 Oct 2021 at 11:53, Quanyang Wang <quanyang.wang@windriver.com> wrote:
>>
>> Hi,
>> Sorry for the inconvenience.
>>
>> On 10/26/21 4:59 PM, Russell King (Oracle) wrote:
>>> On Sun, Oct 24, 2021 at 11:44:31PM +0200, Linus Walleij wrote:
>>>> On Wed, Oct 20, 2021 at 7:50 AM <quanyang.wang@windriver.com> wrote:
>>>>
>>>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>>>>
>>>>> Not only the early fixmap range, but also the fixmap range should be
>>>>> checked if it spans multiple pmds. When enabling CONFIG_DEBUG_HIGHMEM,
>>>>> some systems which contain up to 16 CPUs will crash.
>>>>>
>>>>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>>>>
>>>> Looks reasonable to me.
>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>
>>>> Please submit this patch into Russell's patch tracker.
>>>
>>> ... and has totally broken what looks like _all_ ARM kernel builds.
>> This patch is intended to trigger build error when it check the value of
>> __end_of_fixmap_region is equal or larger than 256.
> 
> Why? The fixmap region is larger than one PMD, so why do we need to cap it?
In __kmap_local_pfn_prot, arch_kmap_local_set_pte(&init_mm, vaddr, 
kmap_pte - idx, pteval) is used to set pteval.
But the ptep is calculated by "kmap_pte - idx", which means all ptes 
must be placed next to each other and no gaps. But for ARM, the ptes for 
the range "0xffe00000~0xfff00000" is not next to the ptes for the range
"0xffc80000~0xffdfffff".

When the idx is larger than 256, virtual address is in 0xffdxxxxx, 
access this address will crash since its pteval isn't set correctly.

> 
>> In fact, it breaks the ARM kernel builds which NR_CPUS is equal or more
>> than 16. If CONFIG_DEBUG_HIGHMEM is enabled, all ARM builds which
>> NR_CPUS is more than 8 will fail.
> 
> You really need to be more specific about the failure mode here.
OK, I will be more careful about this.

Thanks,
Quanyang
> 
