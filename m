Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8778242F0FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhJOMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:35:52 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:36132 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230512AbhJOMfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:35:48 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FCAPkL017617;
        Fri, 15 Oct 2021 12:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=xERYmZwmfvVKuI837IZXwoFEqmhDBrhVKo2xJFeeL80=;
 b=Y0fw02OX/r71NXgdxKwWa1POOBzodTtwB0K/hePUjwAGrCyQEZpYLbZx8MJxl/Qt4hAt
 S2r7PXZmyyZC53KrY2spPhiaoj6S1XCM5jkavsjOlcLQCIek/1+mmZkm7MMDpBdmqpmz
 JpCAIhVPD2PV+IO86++w/mzWRYqRZCO0Wjp3fAzKGZFkp87e+Jr1P43ySXT+UZnANINB
 BjuqtiW+4j0nGh7hY3rkJn26Ll+y3TypuG6mDHaXUsOSS+u3AP8mULUW3nX3VeQowVud
 aFVnM/aIZ+v0p0IFDZ/Pc0a3dVt1L7wY4PLOltZ2oGHBvceOXb5Uo1HZpzLeJlIrFLuD Bw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bq57b86yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 12:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BedlUSGmWSQ0CP99F5E97K5RSCG9QpOQBAhejadoo7c3JxPx87HstU4t4DNNEdrnkgh+lmnIshTVdHp1HLkocssTa3F/vRDd/Z5MX3xlVWh81oCdhrh9igDDsDLZflCH0NnnSburGOEFKOjM3H7M/3lpHpZH0RbeOpCZPeNIF3AipuBTvXzWa3DB/pG8HfCqfyb/5zYPlQFXJcNcBV5NkDItbTj4fYZD9/IKjG8saOR+1vM+/JTqDg9EVJa2I+ZQ8HxLFyEkfASPpdh/HNHDo+4/MtuM5O5Idt90v/dcOMJZoydRrsxn2OIhbUkwuShojqHTk3kH3RDmrNQMRVjXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xERYmZwmfvVKuI837IZXwoFEqmhDBrhVKo2xJFeeL80=;
 b=aGYkS2xgmLJDvf7puHFPF+XcJx8jofP6MfNNRT0GfJaNSlY9KuRhusrRPRKhvBkgBEkHYdxc0S7XSd3noICblLbFewDI1pJn99kzUnzst4mOz8BpNEphuBzJzmEAt0mCIih9/cQepu5UExSB+/SrTkRB+fjx7Y37+2dKBsfBZntKV7MPWcWaqybqr8/xe+kJYTdBooaodfKzaIiadeqCZlbwMoRl3o0JPLx3S2CSCuP5PqejNaV7hdgvaBTHSGhsy8ywt9Nk7KVvSPPilmUgLy4oj0owFZ1fFcTSazuU10jXZGGwp0fxKuot+NBBu6MGNuvvpv+5Y2RHJTKnCopynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3290.namprd11.prod.outlook.com (2603:10b6:5:59::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 12:33:28 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%3]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 12:33:28 +0000
Subject: Re: [PATCH v2 2/3] locking/rwsem: disable preemption for spinning
 region
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
References: <20211013134154.1085649-1-yanfei.xu@windriver.com>
 <20211013134154.1085649-3-yanfei.xu@windriver.com>
 <YWlUZ5BlUZRA7LGR@hirez.programming.kicks-ass.net>
 <YWlV7gVnPColm61C@hirez.programming.kicks-ass.net>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <41448d61-8711-15b7-c120-7ce27e47134a@windriver.com>
Date:   Fri, 15 Oct 2021 20:33:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YWlV7gVnPColm61C@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from [128.224.163.131] (60.247.85.82) by HK2PR04CA0060.apcprd04.prod.outlook.com (2603:1096:202:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 12:33:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85250ad1-41ae-4676-821e-08d98fd7fd54
X-MS-TrafficTypeDiagnostic: DM6PR11MB3290:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3290C03C0CAA5804AAA7C92BE4B99@DM6PR11MB3290.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfWcryEg89ii5qV0HAgYs2hEEH6RwFLdhCl+ZWLWwcfj1xPm3R+bIgjW4JZoaMa3Gwx7C70zRU7kpU9V8+ZEHJK9W49TiFM5z2eRBITEXuhA3HGipIB1o/1r9xqPNawW9togt85VESMRbgZVreKlkQE4AlysxGC2U91tQ5SrR9bwa5cuuO3ZT0WpcnVLNod/VBeZoVhhjX9bDJeQ/jDTCXIblfJZ9X25eYN6r+i98BAuAn64avdqIREtVUjnNrnfQ71fpErQ/anRpAgJpRhcurvDds3Gjnk+pCBBXBIKGQEiiVEoson3RPVtJsPCg9LhIqUoumi1eCv9sk/HJlHlFuRNlxp6b6RYPCSdOgEdhyvfz04/hqW6rB6LpkNi826RfI4RsRSRoUtJcAXRzQkIP/kOJt1kp0K0TuegPxZiNo/9Eo/ZmiuYPQ9zNZeCd00fw+rOUYA68boMtx2i09dWpRxUPnDkBBv93GoitdF8A/wq7iUTUnrrVWUJB/YQnr0v+hImWQteg70+XBfcH19QsnIcIqUrjOFGcBM8mY4rTSIQcjRQ/jBsV2AUqpIW6a8irISKiFsKc6JX8WVayEyPn3FIG/0aeB59/lcrA4bbaRv+hkCPhOgCahT0zV7aPuI0NmBU5vlUwV8zoitk8c+fjgvs8p3bg98BJovjNn4SsSiswdhDXUtMrzDuFTqiXuICKvj/Bt3vhu854sVuv2Vy948YCzTRbdkL9xSN0eo5irQ17ToqqGzEGxQSyQ+Xg/NUGUI7pUwOc0T1O48i2g3hetOykzbmR/n8S5X9SJp0PTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(6666004)(26005)(186003)(38100700002)(66556008)(2616005)(4744005)(66476007)(36756003)(66946007)(5660300002)(956004)(8936002)(8676002)(6916009)(6486002)(6706004)(2906002)(508600001)(316002)(83380400001)(38350700002)(86362001)(31696002)(4326008)(52116002)(16576012)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWYvWk03K2ZKVG5WdDFZNFNLa3hKelMrZE9XWTJYaTlERGdzMlBlc2xPZ1JM?=
 =?utf-8?B?RWI2RnEyVDg5ZXNNME9kcTZIeW84YWxPd29EVUZrWFpiMUhoSkZUU01iTURs?=
 =?utf-8?B?Z3EyY3JzT0RJQlZRRzdxbGhKajFxKzhKV2czZnhCclc2M0hMdm1ZQ2pkYmhX?=
 =?utf-8?B?RVhwaW4veGM1YkN2Q24rYTFPaHJRcUlaMVNMd1RJSE1oM0N5SEIxM3h4UStV?=
 =?utf-8?B?bTRneThtcDZyLzA1SExSYWdxVGc3RVpIZ0Z6N3QwUDFDYllHZVBPK3Z5S1Z5?=
 =?utf-8?B?NWEvUFNIRVpCNnMxSThkZDNNT3ZnSWd1eWNibVRrbXFvR25sUFVycmlzYzZj?=
 =?utf-8?B?Y2JFTWswTXI3T1o0NFNFTHpqd0hxZE50K0t1d0FSUlU2aUw5VFYwem9nTlpa?=
 =?utf-8?B?RHUvZGdjRmNFQjZoRHVJRzVGYlBOVzdRaVdENW1CNk9uaGwyQ0VjOWRVYmZI?=
 =?utf-8?B?U1ZtMFZBS3llUEhNb1ZkbG45RklmUGJsV01aMnJzUW9yTjNSSVVEYUU2cHRE?=
 =?utf-8?B?bCtXTkNWb21Gd0pKL2dEeFhaU1dFcVJ3ZTcyQURnckE4T2FPbmhUdHdiSDlG?=
 =?utf-8?B?aGMzZHBJR2taKzBwVXVXWml4YWtyZzVEa3p3d1hEWEZ4Wko0NzlTSzhwM0s1?=
 =?utf-8?B?VDBWdVZibVZicGdLbGFKUGNCK2J3dWtWYTV5ZXo1MlVQelVUOVNTYU4xdWhH?=
 =?utf-8?B?WXEvdjNjR0x6UnhPUnMzeXZqcUI2VUJmWWpPM094N1gvcTg5Y3ptVkZuZjhj?=
 =?utf-8?B?Z25ra21Cc3hqN1ExNFdHeE5YWnV3dlBORnlHYWduRnpFVW5DaVlvNWNmOXhR?=
 =?utf-8?B?aUhUYmdYOTdqaXIzWTMzcStOTEUzNkpkY2FzRDMwVjl3MXI5cHhDMVZ6RlRn?=
 =?utf-8?B?MmM3ZE9KVVd6ZnorOE5jZU9xeXR4YnBpWDFlSkxpUThsaC9COUErMDFFNW1a?=
 =?utf-8?B?UE9QZll4YXhXSFh3aThuclZ2YW8rcFF6TkduL2syRmJoanJCYkRFZVpwNWl2?=
 =?utf-8?B?NWtTSjBwQXdmZDA3Z3RPM0pub01HbG1QQ0V0NHFDQzRnYUlsOVFaRFBCd2Q4?=
 =?utf-8?B?M3V2RW9wVXhlMGhveHByS1dSMDNmTENWRWRoRitWRWo3L01ITW5vcWdMQlFC?=
 =?utf-8?B?bTZqUHB3bmE4TGlMS3BHMmltdkpaaUhUWVkyb1YrRk0xZDFVdHFERHV4UFJF?=
 =?utf-8?B?RFNER3BycGVqUWNGaFZwbU9qMkVrL3BvSnBLVmg5Vlk1RlE3SCtzU3ZUNGNX?=
 =?utf-8?B?c2FiZHliNlc2aHhvUnVDVmpLT0J5N1lsUlZTUUFoSG9Nb3VtZDlNYlpJMGhU?=
 =?utf-8?B?N0QvYTdQbzNnTTlrT3A1RUVJMFRWZ1JvQjBXT25tUGhZNmhBYVErYUtNUmF5?=
 =?utf-8?B?bjBIL3kzRExVbGNrTmNTWWMyczMvK3ZUVWFKbVozeDNuSElWRXR0N3k0T1F4?=
 =?utf-8?B?OWNwR3JjNGF4MFNjQys5MTVtK0FkNnJJVkNkTGlpYjErQlF6OVJrbXI3cnNE?=
 =?utf-8?B?TU1seE5MSFZoSnJ2bmR6QXllN29aTnRLVGtlangwUlptb1NMdHNBeDhHcmph?=
 =?utf-8?B?L2Y2VE1XNjlUVEJmYlhFdlBraHlpcU1UMnRaR0ljbHFocEd3VWVLdDE2aDlS?=
 =?utf-8?B?YmtiWmJSMGFNNFBpdllVMy9uQm9nNEtwRjE2aG1NMDRxYlVSUkw1cGF2b2E4?=
 =?utf-8?B?eHB3SVllZk8ycDJvK0NjTlRxNElHSUZBV2ZnUlJhK2dTZ2xaRkt6Mmp5M1ox?=
 =?utf-8?Q?NL7QRtoUT027CEROju9Md8G3+4/B92bxxPjpW4S?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85250ad1-41ae-4676-821e-08d98fd7fd54
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 12:33:28.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZUwp6DeGi/oyu0jwdPm23MJZaLwWBHdKJ8NZ+x28k10g4VzwR3cq8gK+GKrFM0R6Raa6UDVgKxO86OZD6Z2XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3290
X-Proofpoint-ORIG-GUID: 35Wlg56BmvxWNuR47-gdfRhfAuHt2LpC
X-Proofpoint-GUID: 35Wlg56BmvxWNuR47-gdfRhfAuHt2LpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_03,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=512
 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/21 6:20 PM, Peter Zijlstra wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, Oct 15, 2021 at 12:13:59PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 13, 2021 at 09:41:53PM +0800, Yanfei Xu wrote:
>>> The spinning region rwsem_spin_on_owner() should not be preempted,
>>> however the rwsem_down_write_slowpath() invokes it and don't disable
>>> preemption. Fix it by adding a pair of preempt_disable/enable().
>>
>> I'm thinking we should do this patch before #1, otherwise we have a
>> single patch window where we'll trigger the assertion, no?
> 
> Anyway, I've stuck the lot (reordered) into my locking/core branch, lets
> see what the robots make of it ;-)
> 
Well, thanks for reordering them :)

Cheers,
Yanfei
