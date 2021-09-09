Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3392C405EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348160AbhIIVdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:33:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58154 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349331AbhIIVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:33:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189LTQvX030143;
        Thu, 9 Sep 2021 21:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EYGL/jJDsVO+mdtAqPhh/6yLjXTbKgrkQV54SM2vTXE=;
 b=urraDXl/VPaYa2ktMC5VL0OZgSI7gQuOqzZwwCWR7e4XaUXCZ6b4fV5iTnLFS19w9qXI
 PwE6hWnIyAAl8LRmZWYnpNsmZ2uNgF1MBQ/39A+lKoFUl8QE9uwpqBbGWp/7ik1I2QLp
 QOXROOpnAGvBA0aZ00QYZGF4EJmIBN4VVxmxyRPr6xDzEit/eKaui0VtuD8eETpbIQxr
 4RjsH4ivoHCLgmOo3iUFcTSH7jnWeNSXqdBKsUPo0CfmEi17KOzz4ejwTUxT/s4QHjPN
 FWLENdIb1r8lfzvYfPKGo9FD/v+yNEvrNCM2OOLF7iY08WbQ+p865fvNNi+Elh/Lw4An Yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EYGL/jJDsVO+mdtAqPhh/6yLjXTbKgrkQV54SM2vTXE=;
 b=f8tbQRug/6ohD6CfPlWIVS+a68tFnyoT/4Ta3erWNkVwYh/BTjaa5l4a/Tj9fJCz+iyh
 sUudcbTJFsV7u6lxDhclxZZLDw8CIORRXalhlb8CA19QRcAC8RihXSSPZRdWhjOob+6j
 THmdZCrMebvXq+RUPezznTAiacjsQOWbPx8o5l4EW2SoufZR976XcRCX3jemaZ4IWYDb
 yyVACoDCqc37OMbRQC0HTp0/tfGN5qmYWNZv6QBv3JLGEKxX83IYRqgnmPeomtcLrx97
 EWRLW4CzYRrBv8UG0zbW0Xj0DPtJUOr4HYsYWi/YwkGc3Uj6XMw7sB/8EuBZMbAUX8WR kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayf8aa5a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 21:31:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189LGG8j012009;
        Thu, 9 Sep 2021 21:31:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3030.oracle.com with ESMTP id 3axcpqth4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 21:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS1qnZN9L8GgRKc0psKeky6F8nd8Hh+PcDrcghy7ol8wgxoQ1rVCAMwRGAwBxeTSxp0KWypv5on9Ph9vQO6phFwhMv+G8tJAc1Lrfa3l+SKyGX/7em7cOvU/49AFH9hjZ3iHY3j9P4xgO6FJTm408XlTC4moonSUqYrGCrlEdR2HxR/k5uVhqOa8qU2Vax35QhwZaGHO0zlbfFHQBTBGVR0C3JLAKo/PbrU+SHXwLy0lG050tqfoLthGWVECqIMR2JEgg9xnOpVLao9izeLVDoULvnjrd/b/8iK3VCy07YpcsZOK5cSVyaXA90yz4+7Y+V/Zctlfx96AlxgHpTZEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EYGL/jJDsVO+mdtAqPhh/6yLjXTbKgrkQV54SM2vTXE=;
 b=F0GoD6miaoYhU6fbpAHa7qZRIxo6bOfwYrj/Sv3MjXo1TwLePhWcR/PCkXPjs3dk+B69xpxEaAB/tQvAWVh+V8vsNBrzClZhkJnBUki3MBINmqX04kqkexuZOq4Hmoz5mGzIxvnSzcjELHxtKXA+Y41gBBhQ4S+yF2WEm1JAE1owDBQ9m86BArLYd8P77mA/S4CDUH7zwdtI2846Kero8vnkXqTgmu0f0tFTYINVdI6EgKeofOgiz3aAuNN4EXsu7YrxC3PHomffg/Gk7EVhihNqEZzfSMJiVkv80LXXVc0x8wcpw/f8QPCK2iv+Bw0ow8qOfcF1CEhE498P4OUMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYGL/jJDsVO+mdtAqPhh/6yLjXTbKgrkQV54SM2vTXE=;
 b=z/gZZacaa9qKBRIywy4DV1QNSMAouYAtF67GZrktSWdA22bUe8RDbKaQSYamKkpd/jTz/FVSmAS8XctbGWjGM7ZlxvhAkPs558mKN/R/UUoKjzrEN6ouU2ULuR3OBW/RBrt2kpRz6fmA8l2S1/+MXV6xwmiNOYH023GsXOHZcVY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 21:31:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 21:31:45 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
 <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
 <YTn196em42sDsXs+@dhcp22.suse.cz>
 <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4607345b-27c2-0c0b-4a04-8a3b054cb5a1@oracle.com>
Date:   Thu, 9 Sep 2021 14:31:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:300:13d::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR20CA0021.namprd20.prod.outlook.com (2603:10b6:300:13d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 21:31:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b408936-6c26-4e65-a04b-08d973d938c7
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47049379100F0A1ACA6DFF89E2D59@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8rAILLL0sdhNuAZzNRxDSdkIT/JTeKRK9pve/YYdTKXR/uQC6jfoE0Irmnbbz/ETljfjl7F6Y+ZyQpzph0srhPAwRTboCs6PthcI06Y7s4H61PmqbMNP3wpl5wyZtvZmzjTJhI1B42IrBCkF9dGRCZcT/TEid9ryLYO7vdfjIsmjhqbhEBuUu0hUNYrBFQ514l2bT704GdtOQvuBD7iYc7W0H2OG082ACrfjPqAcJIB75Zzj/khnqZPQHSVAlXqZrN22h6I7o7lr+Tvf2pKig2kT5wyUZii3KEAfSNMnKR6DcDWA4fKk1kUWmWyXgU8u8rVlwWtR010Za6xlgk8fVjQpSpzwDPaVu9YdcDjXvgJJdyTxErzoJDLNGwm9k9h+wFjy6DqJWhnNn92dVhvLNGfd+S27PAES2Y31qbv6o95PDdO53Pt2QYjHG+sIyKyQZ7yIFpRiW04POmV+XcQ/40wPzwJvARI9IYLcyYX5JztY1nCOjFM9nTi/byCKS8o/zmCqYayUB5b2nzyX3RcoH0sKEjVTZdKz7MFblQTtYUzbqC2lv1WiMUkdZkkzvZYL/lJpgDirSRUyOLMp2M5ofJPytwECfegIhUmiUmNE8OnZxkj27hdnPE98jtud/27pZWTiTs8jXHoHCCHL4rQ0kQYnu6oX2W01TAOgaBrCMva190NcZce8EtL3mzyfqXKZKff3y0Tk9+XQtESKtbrhzHKXiGF+Y+IUDlFLTe5clQRRN8smpZUn0YkyRN/iIhKM3rGSAOJczCMY/9p0vgFDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(39860400002)(366004)(186003)(26005)(86362001)(31686004)(52116002)(44832011)(66946007)(66556008)(83380400001)(316002)(4326008)(31696002)(66476007)(8676002)(956004)(6486002)(53546011)(110136005)(16576012)(2616005)(36756003)(8936002)(2906002)(478600001)(5660300002)(38100700002)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJHQzY1SjRHNm03VjNlbURGNUg4WG44WnFtY1VLVjgvSmNCMEowOGdONy82?=
 =?utf-8?B?TDVTRTJHelF4QWlFUzBKRVU4WFBEUTM5VmJ6czFaT0p2MlpEaEYvQk1acGJQ?=
 =?utf-8?B?NkRCY2pWajZHWDlna3h5cmJTNTBTS1ZDUUlJekxnZlRKVHpRN0V5T0ZQWWFJ?=
 =?utf-8?B?b1BobThQT0RGcVBFNHpMWkJIWFdnUjBueVNzNTJpTDFhMExWcVVGOGRDbm8w?=
 =?utf-8?B?YWFweTNnVHpzaFRVTWZ5MWR1aU42NmtNVmVJeFI3bGhPclFUQ0s1Q1ozWjhp?=
 =?utf-8?B?ZzN3R3Nud2E3Q1NJbEZLS1VIT051UC9WckF3Y2FVV3hpcEo5aWpBSGtzRVA4?=
 =?utf-8?B?dWJ2THROb0kybklaM1FoS2hoZnRQSmR6ZFExYm5HSnBvYnc3U1pzVVpjdjFw?=
 =?utf-8?B?SmNGL3UxZnkwVGdxaUs3QURqam45VE96Yzh1NjV2WVkrOWhmZjE2OUFRbXdG?=
 =?utf-8?B?Umcya003OUdML1FJR0g2TVJUWlNjcEtYZERjVjJ3WEhhaVlTLzhYUFhjWUY2?=
 =?utf-8?B?WG9vci9lVTZkU1k4ekx5eUpiaE9uOEU0QXIzRElTMzVKVmUrVW1uQXVYeGVS?=
 =?utf-8?B?c3YzL2RJODdwSzZ6dUJtdkRIWGMvdk9ZMzU2Vk43NDJuYnZ3VnN3L2RIRFBS?=
 =?utf-8?B?M3BCY3drdVZReE9xbkx0N3hXK2R2SVcrcnBRK3V4aGFiWExrVld3MmZseUZv?=
 =?utf-8?B?Wld1aW1FNHZqS1QrOTBCMWpEUXdpTTlzTmI2aG9xdzFpR204ekJaZUF4eVpE?=
 =?utf-8?B?d3I0YnVnRlRidVlWMDdMWHlEbGZZS29pcFJ2bjg2NXNpMTMrZmFpME8ybG1T?=
 =?utf-8?B?a1MvSDhEakh6a3VPL0RCNXdSK1VnSWZmYjJSaXI3aHlzMzJtOERQTEU4TjBG?=
 =?utf-8?B?T3pTYzBMbGx1VEw0N1BFNWFMSUk1c3lZQVFnVjRpUzlFbkdJb293UUdNVGpo?=
 =?utf-8?B?RDlvd2RPcWlYNEpVWTMvaUZ1OUVRamd1S1dKcHFDSldYVEdlQmZIUXROek5a?=
 =?utf-8?B?SGFMekt2ei9OVmNZM2QwaHV3SjlHcEIwNTlkWk96b3VwZEQ2ejFiTkFydHlQ?=
 =?utf-8?B?dHJVazhWTmN6NnM3SUZmby8xRE5QcUExdG5DdE90VGFXRWVNVFRKRXI3bE5p?=
 =?utf-8?B?OStGVWVuLzhnaUs2UDFRM2tEQjdLY3UvY0lLNitPTEFka0JKNXFaUVBQZ1Jl?=
 =?utf-8?B?Rk4vcWszMTlrNGIzRTBBVER2WnM3QWdXbzZHVTFjZUFMckNDOWxucUJwQ2M5?=
 =?utf-8?B?YmtlRVVGSGk1c3NNRUpkZ29QaWV4WWJxRVRVUnJ6dldUTWxNejZTK0RqN0ha?=
 =?utf-8?B?QWxVaFpYK0llSEhYcGRVMFV4bGkxT3pqSnpmallwc1cvWEI3dFoveDVIcGFa?=
 =?utf-8?B?cmgvMm90Um9CeGVYS3RWNE5jOVBNV0ZETi9rT2NFRTRXYUw5VEpDRWgyMnlB?=
 =?utf-8?B?U09rMWFhWHYvVHFORFA0YVpXb1Y4SUxuK2VzZW5ZbTY4TzlJZmpsenR3Qk5S?=
 =?utf-8?B?U0hrTGtsVGVMZURkdmgxNWNPR0xXSmtrS0JGQ1Q2SWRKdHpsQUlCM3ZMZmpM?=
 =?utf-8?B?ck5oS08xVDVISERCelFtK21lTHRrQTJKOVVqRi9CTzBCeUxudlhBU1RQSmMz?=
 =?utf-8?B?ZGt5VDZucTlFMnByKzRIM084NVlxZTM2Q1Q3YVZ0VFJRZ0FPS3o0UVBPbE1k?=
 =?utf-8?B?RCtYTG1YUGFyTVpyMXFMWWh1d1BRUXhzMWtxdWs2L0xVZmVLM2N1RjNHSHls?=
 =?utf-8?Q?FpNqv/OyimVrS+wbzzu5Tyw5euu7r9H4LBqBNoC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b408936-6c26-4e65-a04b-08d973d938c7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 21:31:44.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuGPiVhQZ7eyaFv2uxCzOiCiC+8Tig8HoEPRlqFHMNHycKE3e+zo88ad5/MVk+tjrJUj5V3zHDm8pidBQyNNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090131
X-Proofpoint-ORIG-GUID: BRokSJJsBmpHMBkzNmSuo9cAgiRiHH3K
X-Proofpoint-GUID: BRokSJJsBmpHMBkzNmSuo9cAgiRiHH3K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 6:45 AM, Vlastimil Babka wrote:
> On 9/9/21 13:54, Michal Hocko wrote:
>> On Wed 08-09-21 14:00:19, Mike Kravetz wrote:
>>> On 9/7/21 1:50 AM, Hillf Danton wrote:
>>>> On Mon, 6 Sep 2021 16:40:28 +0200 Vlastimil Babka wrote:
>>>>
>>>> And/or clamp reclaim retries for costly orders
>>>>
>>>> 	reclaim retries = MAX_RECLAIM_RETRIES - order;
>>>>
>>>> to pull down the chance for stall as low as possible.
>>>
>>> Thanks, and sorry for not replying quickly.  I only get back to this as
>>> time allows.
>>>
>>> We could clamp the number of compaction and reclaim retries in
>>> __alloc_pages_slowpath as suggested.  However, I noticed that a single
>>> reclaim call could take a bunch of time.  As a result, I instrumented
>>> shrink_node to see what might be happening.  Here is some information
>>> from a long stall.  Note that I only dump stats when jiffies > 100000.
>>>
>>> [ 8136.874706] shrink_node: 507654 total jiffies,  3557110 tries
>>> [ 8136.881130]              130596341 reclaimed, 32 nr_to_reclaim
>>> [ 8136.887643]              compaction_suitable results:
>>> [ 8136.893276]     idx COMPACT_SKIPPED, 3557109
>>
>> Can you get a more detailed break down of where the time is spent. Also
>> How come the number of reclaimed pages is so excessive comparing to the
>> reclaim target? There is something fishy going on here.
> 
> I would say it's simply should_continue_reclaim() behaving similarly to
> should_compact_retry(). We'll get compaction_suitable() returning
> COMPACT_SKIPPED because the reclaimed pages have been immediately stolen,
> and compaction indicates there's not enough base pages to begin with to form
> a high-order pages. Since the stolen pages will appear on inactive lru, it
> seems to be worth continuing reclaim to make enough free base pages for
> compaction to no longer be skipped, because "inactive_lru_pages >
> pages_for_compaction" is true.
> 
> So, both should_continue_reclaim() and should_compact_retry() are unable to
> recognize that reclaimed pages are being stolen and limit the retries in
> that case. The scenario seems to be uncommon, otherwise we'd be getting more
> reports of that.

Yes, I believe this is what is happening.

I honestly do not know if my test/recreation scenario is realistic.

I do know that our DB team has had issues with allocating a number of
hugetlb pages (after much uptime) taking forever or a REALLY long time.
These are all 2MB huge page allocations, so going through the normal
page allocation code path.  No idea what else is running on the system
at the time of the allocation stalls.  Unfortunately, this can not be
reproduced at will in their environment.  As a result, I have no data
and just this brief description of the issue.  When I stumbled on an
easy way to recreate, I thought it would be worth investigating/fixing.

It certainly does not seem to be a common scenario.
-- 
Mike Kravetz
