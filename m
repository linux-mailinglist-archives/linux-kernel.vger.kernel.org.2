Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6839332B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhE0QJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:09:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45338 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhE0QJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:09:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RG5Do3144302;
        Thu, 27 May 2021 16:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Qyn3LXFLagI58CaqE9kkNHCMRUxKkwZF3ShWeeoDCuw=;
 b=zKQuUd6rZXS+j6lsP/YTZnT3AWNnpmTWBQSwqZllBbopIGFf4+fBu/ffFcroJ/46sMiy
 IckARazyrufYM5/ruFN08mDEQI1tk2Q6FRNS8MIHjJ6RUz01Gokp+Oqfh+14bYbMzsfK
 RUkNZ12yYbnBEyWRWs1lG8Fc/CfY9rtbBLFi20Xlx4ya9dRpwDmmgi0qRtsV/D2itIMr
 CEZO5lrPclll27hwo4H08fnG7xDzbCz/icyFdojQiPctpADMphpE2iCk17Ux6aPFkxhA
 Utdvr/wOZbZow+k/LmztTGmCF0r1B+idqjb5WAlxPKw+vAoGRExz6F+tC5f+yBLTvvR1 iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38rne487h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 16:08:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RG7Xvd125001;
        Thu, 27 May 2021 16:08:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 38pq2whm1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 16:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOXaldDxW59Z52rpcVLGc/QnHeO7uVeLXTLkoLPx3hUPZQ5BL6vLM+yHbQqImNQDxip/Kkv2AoIUU8bYAZuAT5YDoM/AzGjgrUjp1B7HgGh18GtRWe+lhbvDgTEi/cFCrBTaDS88zKoVZ7BHiTCW+EAOZF5ewSXgTo7WOcMdqcsXz4G/coeWYX/X4MkRHx/8E0vuBOvDbHotmPgivIzp5n9j4J5izAsfBtXwN1E3fYoYfSuP3154fQV4Nd33zmvpdz/gohh8By+HdL3LtUyLg+yPzH9qK/CyVBEv+QRQo0+GRgN4b/jVJqzJ80Dq6A4Fs/SJAh3PBAxSyqmtip6+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyn3LXFLagI58CaqE9kkNHCMRUxKkwZF3ShWeeoDCuw=;
 b=VvNKHyQGebd81PKFWrKg/JgG0DOdWl2wRP2dqyHCeg55a01uXZofwKV5IORU0qKlDwdNu5qaa+Ksw0ESD7WeoT0a3vv/iFq5EioyIjMkf4vArLVqZttGpVFEXwCArFVJ3Ovouhwt7yeudDsQE0cf+ANfr943L3rZ2vA4UVF01SFoBOILZBQn/adT8h21OZPuhtB1MJL5b25kdxKxmGTR2zRy3oC5Pw9Q94wa6XbqHOmSa9PJDPFEk5Wmilt0GAlXEA5f52JcGZjEnJOPv9J3nokD5vPXmpfq76cvVLjDLKmfPzlH72os11vC0wPZr2X9lMADZhs8VrBdFm0UcMAIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyn3LXFLagI58CaqE9kkNHCMRUxKkwZF3ShWeeoDCuw=;
 b=ZaeKM5KUPsVLkSq1RRXiyQK01g8MmD9QLGGswhvo2oI/yd1g0CqUAfddLCBAGOzHhsscMULyzkwGJORaPD0dHjuEvnouA3MtrTCC86NohlGP6a4TDbc/3ehK5JluDeLaZe301+F+fOPE7fEy+F5fEMA6rQNUrPa0P52AbjdngP8=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2824.namprd10.prod.outlook.com (2603:10b6:a03:8c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 27 May
 2021 16:08:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 16:08:04 +0000
Subject: Re: [External] [PATCH 0/2] Track reserve map changes to restore on
 error
To:     Mina Almasry <almasrymina@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
 <20210525233134.246444-1-mike.kravetz@oracle.com>
 <CAMZfGtVUvtCCEHN_V8iE4m9FAmiz9e5Z1CNNvnetXsrEwAVzgQ@mail.gmail.com>
 <1485e64d-e794-c24e-9688-51b0c1bc1340@oracle.com>
 <CAHS8izN+-GVOp5cowjkT9WBXYf9Xg6BThWin8tWoKg2ZGFia0Q@mail.gmail.com>
 <CAHS8izNDTv37XvowTD2SfFSe3kmVDGGbRBRVAQaJ2UMy42ho_g@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8d7d9b2e-10de-9b6a-2551-24d4b65d22f4@oracle.com>
Date:   Thu, 27 May 2021 09:08:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izNDTv37XvowTD2SfFSe3kmVDGGbRBRVAQaJ2UMy42ho_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR22CA0064.namprd22.prod.outlook.com
 (2603:10b6:300:12a::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR22CA0064.namprd22.prod.outlook.com (2603:10b6:300:12a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 16:08:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69105f7e-c287-4c00-df40-08d921299c00
X-MS-TrafficTypeDiagnostic: BYAPR10MB2824:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2824E94BF2A4413BDD09064AE2239@BYAPR10MB2824.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRm3uhHyi52fhm/pG2oBhbFk3H6pKW8SjasABmI/1LE6fNwkd3UqymAbLy4ONHZPMAZgKTWYkYTOMp6OjX632QLfyPjJCg5POKKu1NJInlEFtgNFqULtWYTZoTn8xG4rQjxcsULuOog9GMnMvjz8gSlx1KkWcvbf9zqd2YIYc9wqmsP18IdjRqORZtjZS6PJDSCoa1RB8jvYYQMAth9KN6+AM+0e6H6m2NRPsD89skgMDvBV3R6mk3/Ym92QAkfEfDQnH/SI40y5RLpGAx8FWk9MsuklmCv40l1oVlKhAc+XTd3HnFVuL/sN+K7do0WcPGrPAlw3IeEEK8Zj8A/SwGlJ5ki8NnsiKPF/+nInZaDuf/7ubTw3fRZktJHed3DwPFMWZMPN3k4diR6sp1U1RFclH5vbM+oJbvRfRRC/Kq4yY/x7qZJNBWMu+A/huuuGrfQw11Wa8OL1IYeiHY8CsnHKZwJf+S+gngwB9kdhuqie6ZGvcgVNSFBPiqYOakCPeHhg4AtYm+T2nqdQvXKHj5xmJRsw6NEgFpd7q/walOIQk71fh+YlgOi4C+EpXwYjzEEqOLiV3aMBd8QIO20hT/ZEBynE3W88UcuhTJtWdU6/+6veSRKaxj7WWFLgEktBNBiJamhcKcUMDYVDNS1NBr30UoZ0PoVsSI8rW0gRP0P1rlM10C6Et5PO9GfVGsqIzuLQfk+k7SZoSxBH1ITokA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39860400002)(346002)(136003)(36756003)(956004)(5660300002)(316002)(186003)(31686004)(16576012)(83380400001)(8936002)(478600001)(2616005)(16526019)(8676002)(66946007)(54906003)(66476007)(6486002)(66556008)(26005)(31696002)(4326008)(44832011)(38100700002)(2906002)(38350700002)(52116002)(6916009)(86362001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M2k3ODlnMWFRbTZRREpLemNhdVlUTUlkVUtvN2gxN0ZuTmVsUW9NTUhkWlRG?=
 =?utf-8?B?TFFhc0czdVEwT1hqaXk5RFhaSWk4RWxGblVPeWZZVTdUdU9yZW5pbitKUFRM?=
 =?utf-8?B?L1R0bzNHYXNqM20wM1pWS2g0TjlPcnltU3dCYTJhcE00dHEwN1dMUVBsajR1?=
 =?utf-8?B?R0NEUG5BUjBrazBIZTdmMTk2S0NhcEV3eExPUmJzd3pOeHJ6NktDWm1hQmQv?=
 =?utf-8?B?N2pBM0V5M0x5VTJKeitYTTQ0aGdWc05WekpnSk0yd2VuLzR1M1A0SnQ3TmQ3?=
 =?utf-8?B?Wml3Y2xSTDNZL3pLYWFld2Y5TldKQmVKcGNkK2djbGo5Y2VkQ0VkaHJlM3pX?=
 =?utf-8?B?T3NxNWdvTms2VDZXaENNYlJ4TmtrN0doRGNyRm0zRllDK09KVk54OGhIWEtV?=
 =?utf-8?B?cjNyZG5iV2p0WmthRFNOcWVVZmVPNFBYY00wOVhTSkMxL2trQzdWRFpseWp1?=
 =?utf-8?B?WjkyQWp0RkRsSVQyajlJQit6MURablQxaGtRT1NscVZ0U042MFhEU1ljajhP?=
 =?utf-8?B?RTY5OE96K0xudVZVN0xqbGYxZWY2b290MWVmS2pXRGp5SU9QS0c3NUd3b2V1?=
 =?utf-8?B?R05PREhSeVNCcC9IVzU2N3V1aE55QkZPaTBiVStOWHAvekF5K2VGekJkQXhh?=
 =?utf-8?B?TWI3ekZ3d1QrY2VPQjJ5ZHJRcHNJUzNuMEhocExDZW5MK3RwR00wdWI5Q2k0?=
 =?utf-8?B?K2x2N3Nyb1B0eDgxVkQ5eVFwbzVQZTNYYTl5emZGL0t2dEZ6Z2xBMXkvbC9O?=
 =?utf-8?B?R3Jsd3VFWE9KNkVXOEJDMUFUVWdXMGV5TCtEYXd1ajBnMDlLanNvTDdGUnhk?=
 =?utf-8?B?VUp1ZTZlVFJUb3VZVVlpcDlzNlRtNzBZTDNseGNqOExzcnZ6SjF6TWVhMGpD?=
 =?utf-8?B?QUZaUmRiREY5S2pzR2dUanAwNmI2ZlNzUGxEaHhMNkU4UlpaSTVkcE13RUxG?=
 =?utf-8?B?WGlNWFlSODJTR3NqTkxXZnpBRHUxSjUyNmp3SkhONHdSY3g3WmtDREcyK3Ur?=
 =?utf-8?B?Wkk4S3VPNnU0MEd1U0oxV3l1SHlUWU5xRnMwa2t2a24vNzkrQS8wd3FBcXln?=
 =?utf-8?B?K2M3TWg0L1pTcGcyckxpTDFveGV4U3hCSzdNamI3amV1cyszTUdvNkN2UENM?=
 =?utf-8?B?Rm1pVGNlWDVjYXpEdzZmSE93NFNwcHRBTitFMTZtMFA3ZHBQQitsaFYwNGIx?=
 =?utf-8?B?UzZwRGIyN2x0L1BkeXkrREF6N2dpZVhvaWdjbWJoYVdUSHFRSFkzZXBPSzV3?=
 =?utf-8?B?amN3ZHppSXZtOE1rR1g4MDI4b05OOXFMTGVWaDNweThLclRyenFLWFRPdWF2?=
 =?utf-8?B?TENTQVhCRnlHMWV3WUU0MFZzUzNOaU5IRGxqUjV4dWdHekZ2elI5NjZMVVJP?=
 =?utf-8?B?Zm4wQUdKUzNSMXZuV2gxQlJ4U3lKNndpbUJ4NTVQKzVuMmhVMmZ3V2s1Z3Zi?=
 =?utf-8?B?cFhJT3dsRVlrQTgwOEFENFM4TkJ1QkI2WXZ0em5NMUF2QXdRTFIwRkVtMUY1?=
 =?utf-8?B?QTlNeWNyZkIyUTJHRWJiWjdUNU1LazZTRk9LNmRVRGVRNnpUU2xmQi9Hb2k4?=
 =?utf-8?B?QXBtU0tXOE9UV0hLR3FHTHRqelQrbXpKRzAvaVdOd2w3eFlTOGxaODBJdTB1?=
 =?utf-8?B?V0RLaHFodVZZakNpeEd0Rm9DNUl0aUttSG5KL3p4MmtJRDU4b2RZMkcxYUdw?=
 =?utf-8?B?bFMwalVSNGRFcEN4U1pwek90TWU4WTd5Z0wwSHlwcGl5WmxaSnhKeHZ4bzhO?=
 =?utf-8?Q?SZNoXa3rYCFg8UXYliteANUDco/GymeVg8lnu0S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69105f7e-c287-4c00-df40-08d921299c00
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 16:08:04.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBF/D7Q07K+ytWnpKXwvqX6/aNLRoVsB2jbuaPlTzxfyYC2iDQWJcPvdLDJNhm6DyFXzortelCMgShWbBGZzkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2824
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270104
X-Proofpoint-ORIG-GUID: VXsGjsbdgAImEv3yqi_i8mcR0pQhhsr0
X-Proofpoint-GUID: VXsGjsbdgAImEv3yqi_i8mcR0pQhhsr0
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 7:48 PM, Mina Almasry wrote:
> On Wed, May 26, 2021 at 4:19 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Wed, May 26, 2021 at 10:17 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 5/25/21 8:19 PM, Muchun Song wrote:
>>>> On Wed, May 26, 2021 at 7:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>>
>>>>> Here is a modification to the reservation tracking for fixup on errors.
>>>>> It is a more general change, but should work for the hugetlb_mcopy_pte_atomic
>>>>> case as well.
>>>>>
>>>>> Perhaps use this as a prerequisite for your fix(es)?  Pretty sure this
>>>>> will eliminate the need for the call to hugetlb_unreserve_pages.
>>>>
>>>> Hi Mike,
>>>>
>>>> It seems like someone is fixing a bug, right? Maybe a link should be
>>>> placed in the cover letter so that someone can know what issue
>>>> we are facing.
>>>>
>>>
>>> Thanks Muchun,
>>>
>>> I wanted to first see if these patches would work in the code Mina is
>>> modifying.  If this works for Mina, then a more formal patch and request
>>> for inclusion will be sent.
>>>
>>
>> So a quick test: I apply my patche and yours on top of linus/master,
>> and I remove the hugetlb_unreserve_pages() call that triggered this
>> conversation, and run the userfaultfd test, resv_huge_pages underflows
>> again, so it seems on the surface this doesn't quite work as is.
>>
>> Not quite sure what to do off the top of my head. I think I will try
>> to debug why the 3 patches don't work together and I will fix either
>> your patch or mine. I haven't taken a deep look yet; I just ran a
>> quick test.
>>
> 
> Ok found the issue. With the setup I described above, the
> hugetlb_shared test case passes:
> 
> ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10 2
> /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> 
> The non-shared test case is the one that underflows:
> 
> ./tools/testing/selftests/vm/userfaultfd hugetlb 10 2
> /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> 
> I've debugged a bit, and this messy hunk 'fixes' the underflow with
> the non-shared case. (Sorry for the messiness).
> 
> @@ -2329,17 +2340,14 @@ void restore_reserve_on_error(struct hstate
> *h, struct vm_area_struct *vma,
>                                  */
>                                 SetHPageRestoreRsvCnt(page);
>                 } else {
> -                       rc = vma_needs_reservation(h, vma, address);
> -                       if (rc < 0)
> -                               /*
> -                                * See above comment about rare out of
> -                                * memory condition.
> -                                */
> -                               SetHPageRestoreRsvCnt(page);
> -                       else if (rc)
> -                               vma_add_reservation(h, vma, address);
> -                       else
> -                               vma_end_reservation(h, vma, address);
> +                       resv = inode_resv_map(vma->vm_file->f_mapping->host);
> +                       if (resv) {
> +                               int chg = region_del(resv, idx, idx+1);
> +                               VM_BUG_ON(chg);
> +                       }
> 
> The reason being is that on page allocation we region_add() an entry
> into the resv_map regardless of whether this is a shared mapping or
> not (vma_needs_reservation() + vma_commit_reservation(), which amounts
> to region_add() at the end of the day).
> 
> To unroll back this change on error, we need to region_del() the region_add().
> 
> The code removed above doesn't end up calling region_del(), because
> vma_needs_reservation() returns 0, because region_chg() sees there is
> an entry in the resv_map, and returns 0.
> 
> The VM_BUG_ON() is just because I'm not sure how to handle that error.
> 

Thanks Mina!

Yes, that new block of code in restore_reserve_on_error is incorrect for
the private mapping case.  Since alloc_huge_page does the region_add for
both shared and private mappings, it seems we should just do the
region_del for both.  I'll update this patch to fix this and take your
other comments into account.

-- 
Mike Kravetz
