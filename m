Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59EE394627
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbhE1REp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:04:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbhE1RE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:04:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SGtaKs025253;
        Fri, 28 May 2021 17:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HO1t0Nf139hv8nlBpSlZZIXge9CTcP3YIhjPB/CVLLs=;
 b=a/yfYxqgw8zSsgvv0iFEkQZumwAGyt3eBQJuJZj40VHe0UV47YUWsQHBzJ6rRT3WZtav
 L+PVTgXzDSXgmaxVDqqxRoaSFx7YrbuPkTBUWLbMZLDJiN3rO20fpdpZE/TYYrybewYG
 ZSLudRB7vcYpbwxWIA35EKLnhLiZR21BQGlJSnV9RlqonYwKx1y6sqcaMZdSLF92R4TC
 Y3dPg1tJDdBctwIFvHGcq0eA711sDVmUtLXX0Iyp9niSLD/6n8zfNSjWry/sH/A92f38
 qcmxrL8o1b/GkcXPKi6VdvxgBF27NOWqu9A+vlz6P+++H05yW2XjVsV9XUnvmRP3qpW5 jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38q3q9767m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 17:00:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SGoN1s150505;
        Fri, 28 May 2021 17:00:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 38qbqvmxs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 17:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpBidGDqiGaz7j+ZPQYjGZKBRKroG9SlwPjb9Yi9uHst0CdAv3s2+NGXNDpJDGddHzxgMKw0FpM+dmAcST8z6kUYRhtJckmD1MK2kZMzvpuelJKG69RuTAd92duA1EP9pdE+vpjdiFkdrem1B2n2Nut+VAWx0vz5zmEtv9ZhxtRdLYlTvBtQ+lhqF1axho8tpyYofu+S+8r45f1fjHaGF28KkNwRaEyQGx9YjnxWUzhhs4g4KoEpuD11iTMnnmDLNTDrPL0vNf8G5PS5IvAVYT67weIb4MctPMGig7TdW4+yPM+xEN6JglYbBpSLP2kmEkOltA8k3/+VMMMC73Bqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO1t0Nf139hv8nlBpSlZZIXge9CTcP3YIhjPB/CVLLs=;
 b=XQIfa0zSr4OB1sqBtF5PabD1rCu8M+ayVe+Y0XnTa4Mn7y8iedUc9hqLP5q5WeGmsmzHMkt7l5p37/3XJheeQsjaHXGhzwRSwQdYrlOiLapYFY0vXIa3I0DLaGAMewNRe6NE4F9sJf8VMEKeVeTWBJKn4z3FwcgCBoXpvmzv3ykOsmrE3UVn3pxYcPLP8mppvK8H7jekzlWnN/LHm+LcRgDLa3Tn6gDqdnn5iR4b70zOTVDib9t97Zz26ItyVlRM00CMvvjKVGPBcT09w+RquMRex/9NNdwcQDuc+G1BsaVCA0PM8JGYlwioaG33uKhARq2nkapMzoUBzvVt2cw36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO1t0Nf139hv8nlBpSlZZIXge9CTcP3YIhjPB/CVLLs=;
 b=jYE2+297L7ir1cKHcpu/47kbC0HSNxjkL82ukRVGoKpZypQvN4/A7Wj4YiZuQgl0pYr4tndi/xDb8iwbx5Pmd1cB/LiqLLJTVEhzpvhDp5haOtutDrH0gVgPnOySnxh/8Q91iDlNTW4zKU7vA94n9T/hKGuyU+tDbAke7mWDLzI=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH2PR10MB4198.namprd10.prod.outlook.com (2603:10b6:610:ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 17:00:40 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517%5]) with mapi id 15.20.4173.025; Fri, 28 May 2021
 17:00:40 +0000
Subject: Re: [PATCH 4/5] x86/pkeys: replace PKRU modification infrastructure
To:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, luto@kernel.org, shuah@kernel.org,
        babu.moger@amd.com, linuxram@us.ibm.com, bauerman@linux.ibm.com,
        bigeasy@linutronix.de
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
 <20210527235118.88C9831B@viggo.jf.intel.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <4849ead4-e2e9-2fa9-ec96-142a0f38ca16@oracle.com>
Date:   Fri, 28 May 2021 12:00:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210527235118.88C9831B@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.201.65.98]
X-ClientProxiedBy: SN4PR0401CA0043.namprd04.prod.outlook.com
 (2603:10b6:803:2a::29) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.190] (68.201.65.98) by SN4PR0401CA0043.namprd04.prod.outlook.com (2603:10b6:803:2a::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 17:00:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dc6c9ee-8c63-4cb6-803a-08d921fa1f8b
X-MS-TrafficTypeDiagnostic: CH2PR10MB4198:
X-Microsoft-Antispam-PRVS: <CH2PR10MB41986674C5A2EE4C9B94326587229@CH2PR10MB4198.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bU2GLc66ur0qm6N3YYcaLHFzG/KdSBsoZKrD0Wu4mpqkP10RZvLbCqYmpqa5II3qV2pnTf9g4Tuf7h1T6MGkFxlfoY7nrmFRo6QH8jurm/vS98BDQRTg7W+5NQ/XjmTxZuSRr/22dwzkEOZLikbskHLgq1KjKrcOgfkPNbXTnwmJWVLXWVfh+E0UBA0xlM0Ij753Twb/38QIUaa65u1wMUrlpvB2Kzj0gKw2uErA3C/HlD07i4TDQ6QQiwNOJVDmXoCxlD8T57sO7Qf9mNMrGhRIn3h+KEBAEdZGUENUZ9YPmrZHd91W9Jh5frcQ7fyc9LwpPjrlscAQkUm2HqIeDinopPnycRpSaXC3o3DFDAkiYHA25cM1gBCE/wH7hv4xC2LP6N++ALAbXRJSDyH5xbf8/c3SKuKOCPY9TCCkPS/6GCSvGnygba4yMnjnP5+zI2Y+lTI70Qy32KgQaMEhkU1l8LxNEb2amMPlrOImdfOl3m2IkXZiGkBphB6G5D4WNQFMA2IgmmcHJfq0SuMPKbwOkjxAiPT492cEgo4Uf9gb8HozkinT2Q02iD88eHxD6s/u0nW2PlJW8wF53aJBq5lJt8JJ1AzBI5pR0ru7aW0QEzvyojrhv7yeINI55OXdKq5YybZ/c0wPvWEEQlvuW2zCqMJw6eSM3V3ynvWKy6gSDyJZ19DmxMBmzweL22OspcRSR+XOg1UTztLDoJxAImTr0yEMb7fMbUYdjKBULSuUnpj5tqJzFth6sc/ndkW1gzA2T/7eYP/3FtoTin+wuxLjfBUgTcbezhTD/OAhOPVJQukXCdmr3G3M7GBA91W7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(39860400002)(346002)(2616005)(30864003)(66556008)(66476007)(4326008)(8936002)(5660300002)(2906002)(31696002)(956004)(16526019)(86362001)(186003)(38100700002)(6486002)(26005)(53546011)(16576012)(7416002)(44832011)(31686004)(36756003)(966005)(66946007)(6666004)(478600001)(83380400001)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VUJuYTRPYzFVVDN5Yzl2YVNYRlRjdTM5NE9YOWltdzBHSnBmSHFWbXBEL0Jo?=
 =?utf-8?B?WTQwMk9Fb2FjbUtIMzRKSlVIL0FVSzJYWVgzMmgyaDJ4WHE3TUhYSnhWZjBD?=
 =?utf-8?B?NE9QUERsU1F3Qk5NY1BwZEZMNERYMEJRdnJlR05UckxNSmlmcUFHb2FYVExu?=
 =?utf-8?B?eHdSNy8wQUxRQzBuNFduNnNZVnlWdGloaEF2d2xUTnYvSk9kYy9DWkMrbkdj?=
 =?utf-8?B?bklzUlJCaEhrTjFtMHFxT3hQZitlb25SWE1PUnhOVjVueGtESE9WNDI1VlI3?=
 =?utf-8?B?TGFqYzBzMzRIck9tdmxIcEh1MjZoSjZLVWFDNmVBSElWSnJ0UEtiQy9xZFEv?=
 =?utf-8?B?Ui9lMTNJUFJwaXZENWJsZnZPWDQ2VXcrREQrdEYwclhPWmhhR0FtUkQ2RnBx?=
 =?utf-8?B?NFd6bUdYU1hBTnpTU01WMXV3N0dEVFkyZzFhMUhvYmNvVGFneUZTUkkwUGFZ?=
 =?utf-8?B?Zkd5aVN4cVpqZW1qbnRBQUdsUHBVZXBCVzNacU43d0poRUZhdDUyRnpkL0di?=
 =?utf-8?B?K3l5QmErOUpuOFhLSHdHVTg1bnNBNnRQemlWc3pTUWpNWkJlNHVDZnM5Um1C?=
 =?utf-8?B?YlFpblg0U3YzMDM2R3AvUGFEZDVnU0FCQWxYL1NpL2VKaFQxWDIxVWtkUmtT?=
 =?utf-8?B?WmZFcnJFOENGOXlqTjVjVXJiNVJmcFA1cWJxbk9BVWd2dkNYVEN6bHkwMGhi?=
 =?utf-8?B?UXBCRHk5aWRIQWh4Qm5zT2RJUVlYd2Z1MHEvMnVScHdoK01nL1pEQVk1QTBt?=
 =?utf-8?B?WkNWMk5LR2VFeFgxWURNdmRlaHZ0TmVWRHhlNDVRdWVEZ3JnUkRLVllENUp2?=
 =?utf-8?B?M1o2am1WQnZtK2NNSGQ0VFFBQXh1NWdNV2YwSjBxNkY4a25JSnAvVVJrUW9K?=
 =?utf-8?B?UWw4WWxqak5LR0ZZSFc5dFlHMTlFRmwwMU50UUYybnRFREN1VWM5eVRFL0Ev?=
 =?utf-8?B?WktxV2tSWU9uVlZMWWFVQ3k3WWVYSHQreFZqUTRJTDV1NmdzZ0ppdjc3TXpL?=
 =?utf-8?B?TW1wM2xHVlNNSysySkJwL3hPTTNwNmtiOUxsWVdKUyt4QXE0a1RPRnZXaTI2?=
 =?utf-8?B?Z3dYNkE1eTBCbS9kaEg1QzVFQ28xa2VyYU9zTUllWkhjOThBejkycVVrYlE1?=
 =?utf-8?B?cFppOTNKVktFQVRxTEhSR1JNR2lHTzZkOFZKclpBUDA3N0x1djhYOTJjU1h4?=
 =?utf-8?B?SldPUnV6eW85WkxvVG41ZlliN05oTHBxTXFRdXQvYVdYQ0w5NEZTQ0JJVEJG?=
 =?utf-8?B?TmN2VDlWRmxFc29vNnliaG5pYjd4N21Ed2oxYTdmTmU2M2EvVDF4Znd3Y0F1?=
 =?utf-8?B?ZjU1R3M5U2pnT3FMOFduT2ZXZnNtZEFOamVtaGREdmxJVURGZGR0ZE9iaWpV?=
 =?utf-8?B?VFkyaFhUZnpackdoKy9XTmxOaVlqdVEyMDdhYlNJQVlhUXdNeFpUT3F3bGZF?=
 =?utf-8?B?MmV1N0wrZWVnWDFrd1lBN29kWFY0aFdKYUcwTXRvYzB1Z05henJGZzNwUGFp?=
 =?utf-8?B?em1HaFZ2Tk9kLzZEdVN2Snk1ZE5xQzNSQzArZlgyZFFIZ3YxT01QZHRoRWVY?=
 =?utf-8?B?UDJZemlaOHRXUDhzZnZ1ajhscXNhQjF6T0w4S05rcDFZWXBSYjZna0pIaCsv?=
 =?utf-8?B?ZVN0L1Y3eFc5TlBIUVJ2REVrcHpzeVovRTNSMXdVVGRpSTA2YmFBWXpaWFlX?=
 =?utf-8?B?L3VPaVRlT1RLZlV3L096WUhza3FBdXI4Z0h6R2dXMTA3cCtUMm03NWJQUFFa?=
 =?utf-8?Q?LXKm5F4FLQbbp9g7Q8Gz4shl4Tt+MY7mhjvWGG0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc6c9ee-8c63-4cb6-803a-08d921fa1f8b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 17:00:40.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7xiZqqvShbiDIahMs8fWGs7kykcRju6gsUDzPclPwwoTLkLWQ/TWLsTgj1/pa92nOazcGkaRpWIrrtD++V8oWc5Zh+4THqHMS+dCyRm4jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4198
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280113
X-Proofpoint-GUID: ps-oAWxXTqsQaN8k6RYG-V6TLqDWPo1x
X-Proofpoint-ORIG-GUID: ps-oAWxXTqsQaN8k6RYG-V6TLqDWPo1x
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed a typo in a comment, but I haven't reviewed these thoroughly.

Shaggy

On 5/27/21 6:51 PM, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There are two points in the kernel which write to PKRU in a buggy way:
> 
>   * In switch_fpu_finish(), where having xfeatures[PKRU]=0 will result
>     in PKRU being assigned 'init_pkru_value' instead of 0x0.
>   * In write_pkru(), xfeatures[PKRU]=0 will result in PKRU having the
>     correct value, but the XSAVE buffer will remain stale because
>     xfeatures is not updated.
> 
> Both of them screw up the fact that get_xsave_addr() will return NULL
> for PKRU when it is in the XSAVE "init state".  This went unnoticed
> until now because on Intel hardware XINUSE[PKRU] is never 0 because
> of the kernel policy around 'init_pkru_value'.  AMD hardware, on the
> other hand, can set XINUSE[PKRU]=0 via a normal WRPKRU(0).  The
> handy selftests somewhat accidentally produced a case[2] where
> WRPKRU(0) occurs.
> 
> get_xsave_addr() is a horrible interface[1], especially when used for
> writing state.  It is too easy for callers to be tricked into thinking:
>   1. On a NULL return that they have no work to do
>   2. On a valid pointer return that they *can* safely write state
>      without doing more work like setting an xfeatures bit.
> 
> Wrap get_xsave_addr() with some additional infrastructure.  Ensure
> that callers must declare their intent to read or write to the state.
> Inject the init state into both reads *and* writes.  This ensures
> that writers never have to deal with detritus from previous state.
> 
> The new common xstate infrastructure:
> 
> 	xstatebuf_get_write_ptr()
> and
> 	xfeature_init_space()
> 
> should be quite usable for other xfeatures with trivial updates to
> xfeature_init_space().  My hope is that we can move away from
> all use of get_xsave_addr(), replacing it with things like
> xstate_read_pkru().
> 
> The new BUG_ON()s are not great.  But, they do represent a severe
> violation of expectations and XSAVE state can be security-sensitive
> and these represent a truly dazed-and-confused situation.
> 
> 1. I know, I wrote it.  I'm really sorry.
> 2. https://lore.kernel.org/linux-kselftest/b2e0324a-9125-bb34-9e76-81817df27c48@amd.com/
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: 0d714dba1626 ("x86/fpu: Update xstate's PKRU value on write_pkru()")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Babu Moger <babu.moger@amd.com>
> Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: Ram Pai <linuxram@us.ibm.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
>   b/arch/x86/include/asm/fpu/internal.h |    8 --
>   b/arch/x86/include/asm/fpu/xstate.h   |  111 +++++++++++++++++++++++++++++++---
>   b/arch/x86/include/asm/processor.h    |    7 ++
>   b/arch/x86/kernel/cpu/common.c        |    6 -
>   b/arch/x86/mm/pkeys.c                 |    6 -
>   5 files changed, 115 insertions(+), 23 deletions(-)
> 
> diff -puN arch/x86/include/asm/fpu/internal.h~write_pkru arch/x86/include/asm/fpu/internal.h
> --- a/arch/x86/include/asm/fpu/internal.h~write_pkru	2021-05-27 16:40:26.903705463 -0700
> +++ b/arch/x86/include/asm/fpu/internal.h	2021-05-27 16:40:26.919705463 -0700
> @@ -564,7 +564,6 @@ static inline void switch_fpu_prepare(st
>   static inline void switch_fpu_finish(struct fpu *new_fpu)
>   {
>   	u32 pkru_val = init_pkru_value;
> -	struct pkru_state *pk;
>   
>   	if (!static_cpu_has(X86_FEATURE_FPU))
>   		return;
> @@ -578,11 +577,8 @@ static inline void switch_fpu_finish(str
>   	 * PKRU state is switched eagerly because it needs to be valid before we
>   	 * return to userland e.g. for a copy_to_user() operation.
>   	 */
> -	if (current->mm) {
> -		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> -		if (pk)
> -			pkru_val = pk->pkru;
> -	}
> +	if (current->mm)
> +		pkru_val = xstate_read_pkru(&new_fpu->state.xsave);
>   	__write_pkru(pkru_val);
>   
>   	/*
> diff -puN arch/x86/include/asm/fpu/xstate.h~write_pkru arch/x86/include/asm/fpu/xstate.h
> --- a/arch/x86/include/asm/fpu/xstate.h~write_pkru	2021-05-27 16:40:26.906705463 -0700
> +++ b/arch/x86/include/asm/fpu/xstate.h	2021-05-27 16:40:26.919705463 -0700
> @@ -124,27 +124,124 @@ static inline u32 read_pkru(void)
>   	return 0;
>   }
>   
> +static inline void xfeature_mark_non_init(struct xregs_state *xstate,
> +					  int xfeature_nr)
> +{
> +	/*
> +	 * Caller will place data in the @xstate buffer.
> +	 * Mark the xfeature as non-init:
> +	 */
> +	xstate->header.xfeatures |= BIT_ULL(xfeature_nr);
> +}
> +
> +
> +/* Set the contents of @xfeature_nr to the hardware init state */
> +static inline void xfeature_init_space(struct xregs_state *xstate,
> +					     int xfeature_nr)
> +{
> +	void *state = get_xsave_addr(xstate, xfeature_nr);
> +
> +	switch (xfeature_nr) {
> +	case XFEATURE_PKRU:
> +		/* zero the whole state, including reserved bits */
> +		memset(state, 0, sizeof(struct pkru_state));
> +		break;
> +	default:
> +		BUG();
> +	}
> +}
> +
> +/*
> + * Called when it is necessary to write to an XSAVE
> + * component feature.  Guarantees that a future
> + * XRSTOR of the 'xstate' buffer will not consider
> + * @xfeature_nr to be in its init state.
> + *
> + * The returned buffer may contain old state.  The
> + * caller must be prepared to fill the entire buffer.
> + *
> + * Caller must first ensure that @xfeature_nr is
> + * enabled and present in the @xstate buffer.
> + */
> +static inline void *xstatebuf_get_write_ptr(struct xregs_state *xstate,
> +					    int xfeature_nr)
> +{
> +	bool feature_was_init = xstate->header.xfeatures & BIT_ULL(xfeature_nr);
> +
> +	/*
> +	 * xcomp_bv represents whether 'xstate' has space for
> +	 * features.  If not, something is horribly wrong and
> +	 * a write would corrupt memory.  Perhaps xfeature_nr
> +	 * was not enabled.
> +	 */
> +	BUG_ON(!(xstate->header.xcomp_bv & BIT_ULL(xfeature_nr)));
> +
> +	/*
> +	 * Ensure a sane xfeature_nr, including avoiding
> +	 * confusion with XCOMP_BV_COMPACTED_FORMAT.
> +	 */
> +	BUG_ON(xfeature_nr >= XFEATURE_MAX);
> +
> +	/* Prepare xstate for a write to the xfeature: */
> +	xfeature_mark_non_init(xstate, xfeature_nr);
> +
> +	/*
> +	 * If xfeature_nr was in the init state, update the buffer
> +	 * to match the state. Ensures that callers can safely
> +	 * write only a part of the state, they are not forced to
> +	 * write it in its entirety.
> +	 */
> +	if (feature_was_init)
> +		xfeature_init_space(xstate, xfeature_nr);
> +
> +	return get_xsave_addr(xstate, xfeature_nr);
> +}
> +
> +/* Caller must ensure X86_FEATURE_OSPKE is enabled. */
> +static inline void xstate_write_pkru(struct xregs_state *xstate, u32 pkru)
> +{
> +	struct pkru_state *pk;
> +
> +	pk = xstatebuf_get_write_ptr(xstate, XFEATURE_PKRU);
> +	pk->pkru = pkru;
> +}
> +
> +/*
> + * What PKRU value is represented in the 'xstate'?  Note,
> + * this returns the *architecturally* represented value,
> + * not the literal in-memory value.  They may be different.
> + */
> +static inline u32 xstate_read_pkru(struct xregs_state *xstate)
> +{
> +	struct pkru_state *pk;
> +
> +	pk = get_xsave_addr(xstate, XFEATURE_PKRU);
> +	/*
> +	 * If present, pull PKRU out of the XSAVE buffer.
> +	 * Otherwise, use the hardware init value.
> +	 */
> +	if (pk)
> +		return pk->pkru;
> +	else
> +		return PKRU_HW_INIT_VALUE;
> +}
> +
>   /*
>    * Update all of the PKRU state for the current task:
>    * PKRU register and PKRU xstate.
>    */
>   static inline void current_write_pkru(u32 pkru)
>   {
> -	struct pkru_state *pk;
> -
>   	if (!boot_cpu_has(X86_FEATURE_OSPKE))
>   		return;
>   
> -	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
> -
> +	fpregs_lock();
>   	/*
>   	 * The PKRU value in xstate needs to be in sync with the value that is
>   	 * written to the CPU. The FPU restore on return to userland would
>   	 * otherwise load the previous value again.
>   	 */
> -	fpregs_lock();
> -	if (pk)
> -		pk->pkru = pkru;
> +	xstate_write_pkru(&current->thread.fpu.state.xsave, pkru);
>   	__write_pkru(pkru);
>   	fpregs_unlock();
>   }
> diff -puN arch/x86/include/asm/processor.h~write_pkru arch/x86/include/asm/processor.h
> --- a/arch/x86/include/asm/processor.h~write_pkru	2021-05-27 16:40:26.908705463 -0700
> +++ b/arch/x86/include/asm/processor.h	2021-05-27 16:40:26.921705463 -0700
> @@ -854,4 +854,11 @@ enum mds_mitigations {
>   	MDS_MITIGATION_VMWERV,
>   };
>   
> +/*
> + * The XSAVE architecture defines an "init state" for
> + * PKRU.  PKRU is set to this value by XRSTOR when it
> + * tries to restore PKRU but has on value in the buffer.

... but has *no* value ...

> + */
> +#define PKRU_HW_INIT_VALUE	0x0
> +
>   #endif /* _ASM_X86_PROCESSOR_H */
> diff -puN arch/x86/kernel/cpu/common.c~write_pkru arch/x86/kernel/cpu/common.c
> --- a/arch/x86/kernel/cpu/common.c~write_pkru	2021-05-27 16:40:26.912705463 -0700
> +++ b/arch/x86/kernel/cpu/common.c	2021-05-27 16:40:26.924705463 -0700
> @@ -466,8 +466,6 @@ static bool pku_disabled;
>   
>   static __always_inline void setup_pku(struct cpuinfo_x86 *c)
>   {
> -	struct pkru_state *pk;
> -
>   	/* check the boot processor, plus compile options for PKU: */
>   	if (!cpu_feature_enabled(X86_FEATURE_PKU))
>   		return;
> @@ -478,9 +476,7 @@ static __always_inline void setup_pku(st
>   		return;
>   
>   	cr4_set_bits(X86_CR4_PKE);
> -	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
> -	if (pk)
> -		pk->pkru = init_pkru_value;
> +	xstate_write_pkru(&current->thread.fpu.state.xsave, init_pkru_value);
>   	/*
>   	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
>   	 * cpuid bit to be set.  We need to ensure that we
> diff -puN arch/x86/mm/pkeys.c~write_pkru arch/x86/mm/pkeys.c
> --- a/arch/x86/mm/pkeys.c~write_pkru	2021-05-27 16:40:26.914705463 -0700
> +++ b/arch/x86/mm/pkeys.c	2021-05-27 16:40:26.926705463 -0700
> @@ -155,7 +155,6 @@ static ssize_t init_pkru_read_file(struc
>   static ssize_t init_pkru_write_file(struct file *file,
>   		 const char __user *user_buf, size_t count, loff_t *ppos)
>   {
> -	struct pkru_state *pk;
>   	char buf[32];
>   	ssize_t len;
>   	u32 new_init_pkru;
> @@ -178,10 +177,7 @@ static ssize_t init_pkru_write_file(stru
>   		return -EINVAL;
>   
>   	WRITE_ONCE(init_pkru_value, new_init_pkru);
> -	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
> -	if (!pk)
> -		return -EINVAL;
> -	pk->pkru = new_init_pkru;
> +	xstate_write_pkru(&init_fpstate.xsave, new_init_pkru);
>   	return count;
>   }
>   
> _
> 
