Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB68740CF32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhIOWFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:05:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34068 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhIOWFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:05:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FLvuDD014852;
        Wed, 15 Sep 2021 22:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+vN6RXUAXkbgWoouHMa+XSaf9TqsU92GNtE8vHh9C/Q=;
 b=pPgyoMXk88NEH7xvm9sEYBvIfZ/s7Wj3qsudFS9SzqKKQIfZxSnGMoqlyxLjJVCGBlhA
 Q/v7Rmii1rB9k8aBtrYmACUXCqz6fECWts6lNIbH+qVyf7qXJGef49rlnlT/kfj2Jnx6
 ZIO9vz6hTqg8Wm1ZFHotnP5JdgBCUR95o+WVIcmOdwCG8yTOoSdSESPrHl09SVsxYEwS
 6u8IWLrEpwDU2R+nEVahp1p2eqk/EXoUOhBwcPWm6TgNLgboXXtu0EFZHmr3vZiNeLvG
 Vff0xBaka49JJBA5psKDsLhQh0HKIZci9wIzGWNA7JFqIvyKMAnE+zbli912cqIiBD6s Cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+vN6RXUAXkbgWoouHMa+XSaf9TqsU92GNtE8vHh9C/Q=;
 b=O2HU9K3CR0VJMjXI/Y2GudQNjHmakKw5bVoJ5qg9d4Tp50UZCOXTv7Dablx5hHOljIRr
 sUL8hJSwrmx8Geu4ljA4xq4Jv4C13kyISSilJrN+wiGEy/7VJvxqY4M+2kfpmZj1usI4
 6ivrbq/zrq887AuyyYoEtHz2K0ixZotIxx9M6cQTz4sFRDEtGCCPvgfSyFvRU2sgMTQO
 jXTut/KsTQwimeyFB8IsUXL13glyAS6C0WbfLKXuz6ESob8QSlviU/Zb8K56aq7INNHS
 JctU2YrLswLTacDIs5w+LxTylVBV4XWZgfGONIEJjnT8eWjD6DSZJ0b7flconLcrSB1O dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3s74g0et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 22:03:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FM0T1H036353;
        Wed, 15 Sep 2021 22:03:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3b0m98eab1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 22:03:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akpGGO+OHBJ2Cin22rjMnwfzTtj1IrQ+ZtmV18lFE9zeAzPDe0Cy6JNV6cIdIOjB8opXKNIVoPFXfB37ULj2L1rTuXHjax4vvbr1U4AcKUjHf7yYp7mJTaSTcvGa3HNEZM9d6G0tBQXeY8cjijpPasof0xq3JBGavY6NeMX/ID4fZJ3WmhvZxdmUsHmQktRLC5iMD31r8PML5bruzgAwaP+4sU7RMJt/2/fQidcT5/zamS823CHZqUqVYhUzBM0pxGOtuGSZLWBAe5g+qVF8CoqX1rvW5PrIdJwuar/eH8ioW2uQ1XQnLxHj8t9nWpVIj2XvL8wu5NzLoRZQnx1Q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+vN6RXUAXkbgWoouHMa+XSaf9TqsU92GNtE8vHh9C/Q=;
 b=QhnuElinYZi2RvEzDZh6pTGLFQETNU1XysivkbXOwyJXOE02i5r8+iJYivBx1vJ6u7H3exlwyf/cXNU0kRTEYaI3Zj3I1x+za09hznDfP9yyn6cj3mhGIfnICVPPptIku8TCfRiLIW94r1T2Jq/euYFWNF77cbz8LyuHRwJ1x/BiT56chf8+vmgxcHXjYYlST2EwuK9lu5tqvKpx+OPuGn/684Vo/hCsmWIh/1FFr3D4N0s+FkYbcK9OEa2biA8rf2hLfPGt9vyWmjyFq9axzaavZJG8ZCw8Dz+wsZf1PUwK/tyWzbA0IVEzf4SCnSM/fc/sMoniJElo7O+bTvdpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vN6RXUAXkbgWoouHMa+XSaf9TqsU92GNtE8vHh9C/Q=;
 b=TO+SWoA3k+/q5BTuwj2jRpnr+Oo92uuAa4mKRbMLHZdaYPQRwVrKmHUno3eEPM7pHermGLCyyoMvR8jF9O0IfYbbwFTX9iYgLh/RemZln88f30me8HytqQv4PYo2zxciBxywucLCOEJEAWf9MeFd82qaD4lQhvdTtG30yjOEuas=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3095.namprd10.prod.outlook.com (2603:10b6:a03:157::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Wed, 15 Sep
 2021 22:03:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 22:03:33 +0000
Subject: Re: [PATCH v4] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
To:     zhenguo yao <yaozhenguo1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     corbet@lwn.net, yaozhenguo@jd.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210909141655.87821-1-yaozhenguo1@gmail.com>
 <20210914205001.7ccc7ef3dd76a9ec551b370e@linux-foundation.org>
 <CA+WzARmsPT46ck17-96cJVWE-=QEK8QobRFnCnEcNxsd42zNTw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c55f0be5-f68d-1a33-a9e4-5890a2887a15@oracle.com>
Date:   Wed, 15 Sep 2021 15:03:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CA+WzARmsPT46ck17-96cJVWE-=QEK8QobRFnCnEcNxsd42zNTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO1PR15CA0077.namprd15.prod.outlook.com
 (2603:10b6:101:20::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by CO1PR15CA0077.namprd15.prod.outlook.com (2603:10b6:101:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 22:03:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24e3da02-35b6-4c45-d9c8-08d97894a87a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3095:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3095DB6D963462F1441AEAFFE2DB9@BYAPR10MB3095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFxF1CSvGru5JS0cbhV4FVoNC92VYeC+eIZw6w83q3gdvvCFucwOPLjFxGc5fFPYFpuKHYdHnRFoeP3WtQLn2iUyl4JmVKctew9D29QjTNDF09i1yCdfPHPScLiZiinOxPOoFiXp8Ext9EckLNAEWjIzQtJ6BtL/lWgc3eGaD/l5/AEomRtYNs6rjca6kur9CJwXoMReMAeAUiQKHn5kA1tXUk0eHpLvltQsrcw+vdSyPnWybNBx7zPGcjF2VcMIKwV115WDTr/FHUITRuLlKrpsN+ATa8NWtkra8FRtl+yuD9TXSz2m/UG5wfaXoRqmDaqxlI29INFIX6Soajq7+OSHJhkQsClOcgjx9uAGsLbDDbgkY17n7dNRLgEx5UoeJZ/lKn7ehCvk9FpMpwuuSxLMhHkW0Oy6IMG3fSyxAI520DBnVblwMbxxJTGFDZVVq+gBKfpkGPf+R/Xfi7xfN8iL14EwFOI7nH0SIglPOJohufMvp3cGT1fuzUnNvBSEW6pvh5BaX66XjLd7mr6slkwJYxBfnhZoGQAHG8PJVn4/6qMukaMzaL8b0EjruQnwaHy/dV7LjSdz0mjS8sP6SJsZhHJnKtEpKf8I33k7tpAZi2dNj6k9g47U6C3iU7WtNXvx1aK7/sGPcAflHpLHU+ny8r3edmLq9wMWyAhVZ3a5SKKYuvC0L87bpbVEBraW7l6hb0TDhhZbkSys2Kh+j3h5eS+1rOi3fkfJ5TxMXUdMWUcWFD4noWdesgPjawyPYP4fsC44EpF2BSWuJLgSpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(66946007)(66556008)(66476007)(44832011)(316002)(478600001)(16576012)(5660300002)(83380400001)(36756003)(2616005)(956004)(6486002)(4326008)(86362001)(53546011)(26005)(31686004)(2906002)(38100700002)(52116002)(186003)(8936002)(31696002)(54906003)(38350700002)(8676002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTJXWllLbitVZHVFUGNNSXNQalZBUGhhZGZWNzV6dVhEcW5LTDRyWFY2eXV3?=
 =?utf-8?B?eGY5RHVpT1RFdEN5RTQ0aFF0aFNCRXZ5dFRuMDRhdDI2MWQ2aXByeitsZnhX?=
 =?utf-8?B?ZmozczA4MkcrREZJTEdaZGxnNmp2TjE3Y3Vod1V1cmlxNXdnTUgxcWFZNVBU?=
 =?utf-8?B?ZGZubUsvMGxSYjFzOXVTZzBybG05SzZpdWx1K1dYWktyOHZwWEdSTWtMdnRT?=
 =?utf-8?B?WHFKd1J0NDN4Q3Fad3B0QUd2c3pFN09KZzhPZGlHbG9GOE1EMmhHdFltaDlH?=
 =?utf-8?B?SFlGekZHYUJkTHlQbmlMbmhVTWNlc1gzWHpEZVlab1d1azNIcG5qZjRyWXlj?=
 =?utf-8?B?MDZ1enVubnRENWY0S2pLUHdyWnRTaEUwTDlhT0g0ejFCcEtZVUFFcmx0MjJm?=
 =?utf-8?B?VkZzUkw0Y1hoMkk5U256ZVAyYWpxSzFZMzFpRVlmUmFtdHNId1hjMHp6REpO?=
 =?utf-8?B?ZW54VzdBTHIxNGxGeWFVWmpUYnRUeU1lN3BuOFhQK1RteGRseUVlU3ZEQ3lF?=
 =?utf-8?B?QkpmUGdQSzlOZXdOUlNwTU00RXo5elhrdkFiWDVZTVNaSDYxRG1oZFo5dkg3?=
 =?utf-8?B?Z240amd3UHJGS2pCZmE5WVJoOWpzNUVSM21KY0dvbmdPY2M1N2xaZlZPcW4w?=
 =?utf-8?B?eUdMUjFWOXV0VEQ4Q21yUWZpWndZVlFMS0VaN1UwbnljK2JnSGpqL2lVc3Rp?=
 =?utf-8?B?dW8rZUFqZk95R2ZMZjRxZXlha3ozdXFqSWNrVC90Uys4aGR2cENjWlhNZzlZ?=
 =?utf-8?B?QWgvVFJlamhaTWZuS290ZmMyYVpmRWsyc3ZtY3ZPR1YwbHBjcVBWSkpRckRK?=
 =?utf-8?B?bkVvNU1LVUN3Nkl4OXNTbHQ1ellwTlNIQTRuRzJEYlh3WHdEclZ0bzZJL05F?=
 =?utf-8?B?dkxtY1FldWYvbkJQS3pqYU5jTTJsZXJkZFJWZjh4RDFJdFREbzdaeEQrMS9H?=
 =?utf-8?B?bGhZRXZvNHhPSm5XWWZzUWNjTDBWTWErUGg2WXBTVUlsRVE5QXgyZ1F5T05I?=
 =?utf-8?B?THFKS3U1THVodUo2MVE2cURTN1Fjak9vSE9aclJDWkRMOWdEVFkzZlBSQjUw?=
 =?utf-8?B?bVJpZmttMzhLV2hyQVZQV3g1a1prbGxsWGdLcE5jTGhiVTVSOFpFdHB6aCtS?=
 =?utf-8?B?NGhYUmsvZmhVUUpTQnhvdVlNbktvMlpTZ01qMzE5V1RrY3B2R25sMVpwUTAy?=
 =?utf-8?B?WElTeVZreG5jQWd5MGRWeXRJQ0g4bm1zczFJeFZIN01mWlc2NmhkNGMxR25F?=
 =?utf-8?B?c2ZDWk5MVnRHZzNONElJMnFiWFlYcmJJS3FQTm8xWndkRjNDT2x5Vk5MeXhx?=
 =?utf-8?B?QmIzYklCbHZDMzEwK09CbnNRdyszNVhZVmErZVhVaFN3VndCNlA2NlRyeERR?=
 =?utf-8?B?VTBBZ256STF3RXQ2b1lVSTJRQzIrTmxtUmhCUUlaaGJsa0tIZ2xCd0loZ1hG?=
 =?utf-8?B?NE4xQ0FKbTVEby9rRlQzZE5POEhjM1NvN2pTeEh0UnZtWVpYSmtrZXVlVHJs?=
 =?utf-8?B?eGVpcEp3QSszWXNTUWlJcGNoNkphaWVkNXdYSUVHNUxoazhWdFZldFB3Z1BJ?=
 =?utf-8?B?MEQ2THgwN1R5MElFYk92ZGJkb0Nib3RzaGNTcHFJbWRZRDlsN2dRZEV2WFZ2?=
 =?utf-8?B?MVMyYUdSUFZRdDRLOTBiUGUxUjNvem5FRG9JQXUrbXF4YmZBWWcwRityNVVO?=
 =?utf-8?B?MmtXU1IrbzZISC8zbmpXNTJ6dFdadEFXcXNoenZISitPQW5Sd0JtZk5zQkhi?=
 =?utf-8?Q?vkW2VT0A2YfjiU7UJo+kMUfFFX1jt4sy6qJn/iX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e3da02-35b6-4c45-d9c8-08d97894a87a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 22:03:32.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy03FNN+TRAUfktsueWr9L0BzeQ9ZiKybiz/sBv/xOMntSaMT9zZHJORjQOPDZ17NUQObxqPu51XxBrmetQDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3095
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150125
X-Proofpoint-ORIG-GUID: gEfiyO4BfsIr7Pl01Who_WNasHh_4Hhe
X-Proofpoint-GUID: gEfiyO4BfsIr7Pl01Who_WNasHh_4Hhe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 6:11 AM, zhenguo yao wrote:
> Andrew Morton <akpm@linux-foundation.org> 于2021年9月15日周三 上午11:50写道：
>>
>> On Thu,  9 Sep 2021 22:16:55 +0800 yaozhenguo <yaozhenguo1@gmail.com> wrote:
>>
>>> We can specify the number of hugepages to allocate at boot. But the
>>> hugepages is balanced in all nodes at present. In some scenarios,
>>> we only need hugepages in one node. For example: DPDK needs hugepages
>>> which are in the same node as NIC. if DPDK needs four hugepages of 1G
>>> size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
>>> in kernel cmdline. But, only four hugepages are used. The others should
>>> be free after boot. If the system memory is low(for example: 64G), it will
>>> be an impossible task. So, Extending hugepages parameter to support
>>> specifying hugepages at a specific node.
>>> For example add following parameter:
>>>
>>> hugepagesz=1G hugepages=0:1,1:3
>>>
>>> It will allocate 1 hugepage in node0 and 3 hugepages in node1.
>>>
>>> ...
>>>
>>> @@ -2842,10 +2843,75 @@ static void __init gather_bootmem_prealloc(void)
>>>       }
>>>  }
>>>
>>> +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>>> +{
>>> +     unsigned long i;
>>> +     char buf[32];
>>> +
>>> +     for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
>>> +             if (hstate_is_gigantic(h)) {
>>> +                     struct huge_bootmem_page *m;
>>> +                     void *addr;
>>> +
>>> +                     addr = memblock_alloc_try_nid_raw(
>>> +                                     huge_page_size(h), huge_page_size(h),
>>> +                                     0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>>> +                     if (!addr)
>>> +                             break;
>>> +                     m = addr;
>>> +                     BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
>>
>> We try very hard to avoid adding BUG calls.  Is there any way in which
>> this code can emit a WARNing then permit the kernel to keep operating?
>>
> Maybe we can rewrite it as below:
>                         if (WARN(!IS_ALIGNED(virt_to_phys(m),
> huge_page_size(h)),
>                                 "HugeTLB: page addr:%p is not aligned\n", m))
>                                 break;
> @Mike,  Do you think it's OK?

Sorry, I have not yet reviewed the latest version of this patch.
Quick thought on this question.

The required alignment passed to memblock_alloc_try_nid_raw() is
huge_page_size(h).  Therefore, we know the virtual address m is
huge_page_size(h) aligned.  The BUG is just checking to make sure
the physical address associated with the virtual address is aligned
the same.  I really do not see how this could not be the case.
In fact, the memblock allocator finds a physical address with the
required alignment and then returns phys_to_virt(alloc).
Someone please correct me if I am wrong.  Otherwise, we can drop
the BUG.
Adding Mike Rapport on Cc:

This allocation code and the associated BUG was copied from
__alloc_bootmem_huge_page().  The BUG was added 12 years ago before
the memblock allocator existed and we were using the bootmem allocator.
If there is no need for a BUG in hugetlb_hstate_alloc_pages_onenode,
there is no need for one in __alloc_bootmem_huge_page.
-- 
Mike Kravetz
