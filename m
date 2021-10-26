Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353C243BC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbhJZVWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:22:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58526 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhJZVWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:22:12 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QL6CwR029795;
        Tue, 26 Oct 2021 21:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GJRS9CJByppCQqXbgPmQafKy3ykt2+Ff2zIY9bzzOsY=;
 b=P+c1so6ajnnXQameR+eom9GZCFRKqTgHeoQBlZLsiKuc3L95X+7gveisVuDXzizQYHHk
 SbkvdVH+ql0Smy6oxCIN8JDNhin4CIo13RvTLI4D3jUjizvOKMjoAvv9RyJMZ35TqKZO
 sG3b1C3JmpkfaRIrHQC9KocjiYdj0le2QpyXhJgywBDl7KSq3QfO+lt3NnrdahLEOdqP
 tRpV0DokuZBVtQogMHUgpoRXql3ji6a5DsTVLBe3ttxA3uywIpgA24Xi3Rzdf9kYJx23
 8H/2dzp/FnemgAviR3UX68+o0VLEUcjiIJWJvMqnUscNT4EeSUlxXUyqDuGtibP/Z7li rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fjfcum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 21:19:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19QLFE0r055976;
        Tue, 26 Oct 2021 21:19:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 3bx4g8wwcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 21:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaSVkEOD7P6o06bHDRiiZw1NpKu3UEANqXArn2tLU8XFzQLe+aVCKv5AUNp0lwv831U0pQ2wAr9U9RW5xshA33nifIqw4Mjg+oQu2LidfaKXkQV9U0o6Atn17KJuvDk+R75CcOSqkcyGtuxWbqnghZdgVXxJzBMljMqbX4Dvm2Q8VnjZdKNtRvYn4VcoanUmn2wrCoztAU+ibn5r/UKPHL2b9skzA32Q5ZgBLO9khAum9Tu3hc+InqTokLNJi6HM/sjubhma3l/wb0GOHXnNABazx4T5lGwE7GlDUH+dcifSRlIqdUuilUrkzx70BecbRjFKFQLKSsaE94xVDuwl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJRS9CJByppCQqXbgPmQafKy3ykt2+Ff2zIY9bzzOsY=;
 b=QW9hMkzufpqhbeMAImL1S9Un/MJP7xiATW9JEdGplPwbPCUB+9XBSGZOpj2LlXt1ogD2KChtWLVuxLJNC9yd0df3Pp2MdBTgMQzGxpWlpQApxkd+gJv9hCVyACYl10R2aqfPwPXdnOrM4LqBXrSG3uFInAysj+hK4Owvs2q/lMEhImtSexxVNPJrLXjVdeYiCLFh1nsqUF0ZYwuvB7jxLRCFSQA2lwr91/r3qkklmvcgCqfQw/zQDnTOwExQQEW5QYmauDR/Wt0ceI0GFt621OGEX68kzwHRD9KYb2nf7kbh1yMoQQLQQA/ZixEkkQqxI91z+XdK83A9oi/4BImwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJRS9CJByppCQqXbgPmQafKy3ykt2+Ff2zIY9bzzOsY=;
 b=S5FCEKAC0QRLnIr7/8CdxGegeWV1DwBP1yO2rQfvhv9JkGkYGwkLx56yan+ZCLbOkr1NdHVAL/nMehjz9+XOnXRBC5VSF8hnibCdtRTCvViRiiZese4gxmKNkNeza8caYekyQpk3QXG8iDHXtcKUiIUXV2Ahxla17n7v/ItEJYM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3589.namprd10.prod.outlook.com (2603:10b6:a03:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 21:19:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%8]) with mapi id 15.20.4608.025; Tue, 26 Oct 2021
 21:19:12 +0000
Subject: Re: [RFC 2/8] mm/hugetlb: remove useless set_page_count()
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com, Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        weixugc@google.com, Greg Thelen <gthelen@google.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-3-pasha.tatashin@soleen.com>
 <57fbf167-b2e8-69f6-7f79-8e989162c889@oracle.com>
 <CA+CK2bBuU5_8PrT8zd-bAJ-zJW29+9MncnBMAyoJ+JwDHp=WyQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <11486412-5c9c-9a20-3288-3998d6d91ff7@oracle.com>
Date:   Tue, 26 Oct 2021 14:19:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CA+CK2bBuU5_8PrT8zd-bAJ-zJW29+9MncnBMAyoJ+JwDHp=WyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 21:19:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dff2d72-36fe-4737-d404-08d998c6415f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3589:
X-Microsoft-Antispam-PRVS: <BYAPR10MB358924DC3414575A503B2B14E2849@BYAPR10MB3589.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3BnT1W3ymTQFyt8dNdzAP8Vhv1lqL9QtOLbXw1g2KD45uax/kJHD1UHDfvVh2kvL5y6VEVhz6NIajVo4IU/4ZDvhQp2znk5cJ7AqIBWBcoJiT1Oe4iMq5F3fUjBZr6VN+I5L7p7LWcilR0clBi4rh8X0LWtUoTfdznTu3lZbKtYBJwTWSuuAbb0t9p1NyIVdsCEOoGaJE53/3M6gzBlPLj6dssGKATpXiAOtUbLEmCeLHQ03kP2GzLNksdBpOno76JxT6Q5L1CPkrgqHQatpfwSCGb47QG0foRAj/PZJxn0XS/w0ZPCHRxOzAyWJOKQjlPVesKG29dt86CVOSdyPxh6NIVJRCYbnQCeAPpx4QE/5OS5rpEKQMq158rsjcNEw19Tr7vBeSpO8/6fyDwaE+pk/2I2Emf/mW6wg99P7Jc3oNTWvY6NX+ihvUTVfavSDafevU6bRIJrsYV5pOEphYPNu+XB5EUJDV1HXpLNKncNDH9x6IoJXfdteWi9nztIEyixx5sz/eT5uUPAPmrqgw7L19fzBt95Co0+1zJcpH/7dClH4yVBfl3ohS1ZK3EQD7OD3+hoeBKHMR1A6DRYJG5uYPQIAbMMGOEnz3Wfz2bZ2k9C7V/OBEPGThFDJBM0BFAYO1BBDmCn7Exw7JinQZh5J4xSHF2Ld7TlWjGdGWazScDI7zg0lR7vox8vBoFhdFvGBFOE3vMrF7X5qJucyPG0BDI2S2XUOF91JLrG2LGu1VttsFXLU60bUxPbN0n9REOtpz3Ow67Y50Sns67N1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(6486002)(956004)(316002)(2906002)(66476007)(66556008)(8936002)(8676002)(86362001)(44832011)(4326008)(7416002)(2616005)(6916009)(16576012)(54906003)(53546011)(186003)(52116002)(26005)(5660300002)(31696002)(508600001)(38350700002)(31686004)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My95VGN2b3Y1UHRQWGNmUjMvUGtqTktzSWxYc0ZidHYrSEN2VjluOEtHQXF1?=
 =?utf-8?B?djJwRmVXNXpFVlpMWTRtdnN1cVR6YllvM3FFaE5GSzY5Nzc0RkkwdUVJdE1y?=
 =?utf-8?B?SDVHOGd1Wm02WlZYQWZBZ3p0MDdYazY2cC9pM3B1UUoyM0llajREeDVieUZs?=
 =?utf-8?B?dUJjaldSR3NOcG1Ea2xLeW4yUDJlYkd5eHRRVnZpeVVTQ3BqMmQ4VzFmQTVn?=
 =?utf-8?B?VGxJMWozZktRbnZ0Qkw1TVZ0N1NTUzZJT1pzbUI1TzJGaEZwTUlsNmZFSUJ3?=
 =?utf-8?B?VnNnM2ZkdndzQVRKSUpTSFk0ZGVJTkhkMktLOVplWjd5ZDFwTFFXaFBYdUZp?=
 =?utf-8?B?MU1Na0VWOU82RlczSm1NcGNzNXprUjRQaDlhamRVUmIxMnV4bHRWZnlyWWwx?=
 =?utf-8?B?K2lnUE1YNFlCK3F0MVVrRlFWK0Ztc0x1SGdBNnNXUEY1VUNwS2dVWEFxTkh5?=
 =?utf-8?B?VDNsQzhyZmVNR2Y4S0RLaTFLdVRJU3RYbnBLU2lFRWw4NCtNVnlWNHptbTEv?=
 =?utf-8?B?dTlFd1V2dm03VDNKWVRabTAvejc0cDdCRHNHbUdSZVlWZER3MlY0bVZyQ2Vn?=
 =?utf-8?B?MERteXdpNkc3N3dYMHhhYWJCV0NxaEwreW56MjJoc2VuN3A5Q0ljdkVVaGJs?=
 =?utf-8?B?S1ZjaFlQTkZqYkpuNWFTRWtDMEhKOTcxWUVuVnowUUdrMHJoNzB5R09sZ29t?=
 =?utf-8?B?YXZxY1l5VDdmWjV6VDNLNjRPNmpuUUpaaHZwMVdIOGFvNGovZjlTdTB6MkQr?=
 =?utf-8?B?V0R5V0NKZEhxNDFpV1p6T1B2TldHM3pLRFd5a2ZwTEV2RDBGM2JwQjQyUFM3?=
 =?utf-8?B?OXVOb3NJZ1BuV1NGa2ZEaGxKTE5BK1htMTQwQUFOK1lYUGEwaVZSY29ZSFJH?=
 =?utf-8?B?cUR3ZGdNK3QvUXhScUJ1RXZ2ZkRqZG5lUFNvQXhEK3FwZ0lES21EZVpLVGJ1?=
 =?utf-8?B?TUt1RDRveTU0NXlUMUtQUjZKWGo3NUlPV00ram5yVTRybmNjek1sOXBxVmor?=
 =?utf-8?B?Nk5aR0l6aS9QbTVXUVdxdE5OUGRFSENFbXRQSitHT2twN2hlaktxVmV0Nlkw?=
 =?utf-8?B?ZFN3dUZZYUlSaWNRM2lDZUs5dUFUdTFnVmRUR1YxMDFkZUNzaHkyaGZMdGpU?=
 =?utf-8?B?YTYwb1FaV1ZKcUpGZ2Y2OS9uOTlTa0g4ZmhhZGY0L2pJNGtzaHBUUStvU3FD?=
 =?utf-8?B?QnVRTzh1bUZxbk90QytEMktWM01ycGp1Z1VWbUpMUVhFbEZ3OTdabG1xWFlR?=
 =?utf-8?B?c0t6bzM5TUVBNmV0S1o1bFhZNEJNUEpxUXY0ZTJyempiZEZndk51UW45dFJP?=
 =?utf-8?B?YURGTTNLNHk3cGhIZGIwVkRlQkRiVWc5c0huNEpMZlFRZGExMDArZFNVV1BZ?=
 =?utf-8?B?dmpiaVZ5ZmM2R0tuTzZNM0huNlFSSzNvSkF0RER4UzM5VnZXMlFqNTVKQU9Q?=
 =?utf-8?B?Y05QY2NWZU0wUy9YQnVNdTdKeUF4Q1cxbzhhQWNEakwyWHNpbWpSaS9Td0p3?=
 =?utf-8?B?TWNyQ0F6Kyt5dzNoL2dxRTRRcVV3MDBaTnNHS2xqV2lSSkRJbFZ1UVB1M3V1?=
 =?utf-8?B?VkovRzliUThrMlk2dEtOdC9IM1J2UnpQSC9ZWWUvd0lLMWFNZVBaSk1nYVF6?=
 =?utf-8?B?MFdqWGFDOFZvV3dZR3RKSnVFQmFFZGxzQ2lpQXZoV0VhcmZxempDdWx4RzQx?=
 =?utf-8?B?MjNiK1NuNTF2M1B1VWJXWEZ4bE8xcUxyRmVNWHNlY0ZISTJUTlJmNFk1TXAv?=
 =?utf-8?B?NVB2TUFNMnpCc2VsNXlDc2dhdWtFbjJmMWpEZlhucm9BSS8rWHd5MDI1VWRi?=
 =?utf-8?B?Y2hHZ0ZLejRmT2dKWkoxSkxYNkNuTDhIdndLbzk0WjhjdkVzdnowNnBTZStj?=
 =?utf-8?B?R3dQSzhmMjFGdkx4eGxkTDYxQkNiaU02ZHlxRDdNYkhGcC9EMzZUdFFLVDIz?=
 =?utf-8?B?WDN6a3hPSWN5d1lJcGpySWtSb0lHbkFnUWgvNzJRaHd5Mnd3N3UvdGpvZmg1?=
 =?utf-8?B?Z01EVDVISWJGV040YjA1dDE1NXVaWFlaR3pYQUJhRFpQakZ1TDhJKzZYMkRX?=
 =?utf-8?B?WFBuaFczelM4ZTRPeXp6TFVTOTBxWHNYNGNBTzdvV2xpN2tLVXBDaG5JM2wr?=
 =?utf-8?B?TzhtVUVrbWc5UHdTTkk2eUpjVU9tb0Z6SGRTL2xaSzVCK3BkZDB4dmRjVTlt?=
 =?utf-8?Q?UxNIJGQRe/SZ/S02rjp6cCg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dff2d72-36fe-4737-d404-08d998c6415f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 21:19:12.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEYKL2QDLqHNXacm5b1XMmZCvZ5jo4vzFze2r4Ehr7QOuYGt17jbLcBtrxCeb74YZcxayRjJLda8hrgwkvi/oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3589
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10149 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=959 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110260116
X-Proofpoint-GUID: GtMeCyyLofVL31zfakXzPC3T_yfYAAPI
X-Proofpoint-ORIG-GUID: GtMeCyyLofVL31zfakXzPC3T_yfYAAPI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 11:50 AM, Pasha Tatashin wrote:
> On Tue, Oct 26, 2021 at 2:45 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 10/26/21 10:38 AM, Pasha Tatashin wrote:
>>> prep_compound_gigantic_page() calls set_page_count(0, p), but it is not
>>> needed because page_ref_freeze(p, 1) already sets refcount to 0.
>>>
>>> Using, set_page_count() is dangerous, because it unconditionally resets
>>> refcount from the current value to unrestrained value, and therefore
>>> should be minimized.
>>>
>>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>
>> Thanks!
>>
>> My bad for not removing the set_page_count when adding the page_ref_freeze.
>>
>> FYI, there have been additional changes to this routine in Andrew's
>> tree.  Not really sure if we want/need the VM_BUG_ON_PAGE as that would
>> only check if there was a 'bug' in page_ref_freeze.
> 
> I would like to keep it. Part of the idea of this series is to reduce
> reliance on comments such as:
> 
> /* No worries, refcount is A therefore we can do B */
> 
> And instead enforce that via VM_BUG_ON().  It should be able to
> prevent existing and future _refcount related bugs from manifesting as
> memory corruptions.

Ok, but that seems a bit redundant to me. 

There is actually a VM_BUG_ON_PAGE(page_count(p), p) in the 'non-demote'
case in Andrew's tree.  This is in the path where we do not call
page_ref_freeze to zero page ref.  That seems sufficient to me.

Since you did point out the unnecessary set_page_count, I will submit a
code cleanup patch to remove it.  I think that is independent of your
efforts here, and adding VM_BUG_ON can be discussed in the context of
this series.
-- 
Mike Kravetz
