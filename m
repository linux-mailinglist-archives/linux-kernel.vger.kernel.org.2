Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1564117AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbhITO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:58:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29806 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234006AbhITO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:58:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KEp2nx026683;
        Mon, 20 Sep 2021 14:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FB0zUdTDy8bY4ken7WmUSaeDTEe8RZd6i0oZqMHuFLY=;
 b=jMAQfANUpF8gi2GAROoxd8nMjZXPyrF82lRKGWbQH6kebStczXm403geTgeGGFoSUJ8p
 D7yYAxipuUSFeVaxY6xDR9iadX8GKXLjJWdXQIYkCyg6Qv4OR71MX6n8e1eLI655i+BE
 686BRR+G+WC+GdNNogZudRcCWmTAJDRmTca7HAG7JE9UgRd5nddx6U1miYjgH8ORRgqD
 qEbt0UNS+Cy/ZQq6iUILeagxJwt7ME2koJ8pxHHDzjiubs2kQv3fnNv3vh89kGtYElls
 IwVnJHe6SfeHVprkWTvRKDurTlxlb/tH4d+nKovYr41X5kYoTwSYJh80FVPCv2QLYOy9 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b6426b7y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 14:56:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18KEur42086088;
        Mon, 20 Sep 2021 14:56:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3030.oracle.com with ESMTP id 3b565cq85h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 14:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsLEiEhdKu6ea0InZ2u95CDlpTlknotDAqj47gOsKSHmPtPZajysJyRZnKcu5C8uOgBbyJbnv3/i+i/a7lv+RZgm+YaR4Utz6eRnVzTV9fAgeoBMI2zpeIJ9Dl0AYDu0vymez3rZUWe1GyRNb/byvzSiJzsXj4GhG+KJ+1o752/iGUudM7jSB9CPdhH7ZD1jIcMEc8U18gwN78CZwCx/+8P1qlnGpz4E+4+yr4P1Yui0zAE3QObPigSvuALDOXw4VTbJ1HMtMGFx9Um0OdwWXuhEBD/Zlt9rkcEgkokx5uM9bbIsQENKc8kTAhokrhDab/mxHEZouf1otRlvjuvR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FB0zUdTDy8bY4ken7WmUSaeDTEe8RZd6i0oZqMHuFLY=;
 b=DtWyLOrbN8XOxrd9vOyrRGu495v2pRSBJKGeOVlJbPX5PHOFOT6PCss013n95AuSeLtJtpAUExaeU9tN20QxeKjjMHTFBnWFAjZJPg+FS26avWRtUdoy7Y3+YW2s/TNdIhlxvjuQs007qFNBZJEXZyVo8URHzgrg7d7Ca2U6znVVY89r+/rqsKQ15Lrsq7nlycUZkd6wUrF99PHbvKtoDR2u1K8Ue6YI2+RLw9t87GNgAkGpmq6rECfNWnAuoz1AwBDOClM5FA1iinkDhz9IPeb3+4uA7FEPqNujjOQppv/rJlaFM0+duYOOz7Ja5U18G52BaDJbqEWqmcO87a6QCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB0zUdTDy8bY4ken7WmUSaeDTEe8RZd6i0oZqMHuFLY=;
 b=mG2FL4TyTqLpsOuiuaqS94DLht9adjaIG+aC2auAQKf1OrUS4xxQlOsGUBdlYBsDi8pQIRxMq9wEZPzDRJpr21xer6izNGlrZnI/b4rTMwezMM/kP24oVixDHuYDB27GYLlpjgOyWl2PQAJDVAcoyfXybUOxyL5OG0Y9HH4J/Yg=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 by SN6PR10MB2944.namprd10.prod.outlook.com (2603:10b6:805:ce::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 14:56:54 +0000
Received: from SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::c12a:cfad:520a:2c94]) by SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::c12a:cfad:520a:2c94%3]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 14:56:54 +0000
Message-ID: <b2d4183c-6867-6725-52ea-f48dd772e765@oracle.com>
Date:   Mon, 20 Sep 2021 09:57:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: Fw: [syzbot] KASAN: use-after-free Read in
 copy_page_from_iter_atomic
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20210919161900.ea7a5a46dad30cac229d1ff4@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20210919161900.ea7a5a46dad30cac229d1ff4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:20::17) To SA2PR10MB4665.namprd10.prod.outlook.com
 (2603:10b6:806:fb::17)
MIME-Version: 1.0
Received: from [192.168.0.162] (68.201.65.98) by SA9PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 14:56:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c35915d-722f-4335-74ce-08d97c46e290
X-MS-TrafficTypeDiagnostic: SN6PR10MB2944:
X-Microsoft-Antispam-PRVS: <SN6PR10MB294464C32A6F1F5C768E3FAA87A09@SN6PR10MB2944.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ol1Hq3auAT7OPDAadOn5fFMlkoplQvfMErxrAtNACAXDdYjkVDsbQRIHcWeIOKdecXUufn6tLYGiVfMH0CMABVmM11Uvy3xfYpxt9zG15ByYwayGfDkxIDEWdCs4IW450bKdwUVcrU0V6qk84x1qPsqzAPJT5XXkEmQzRoau+NLmUu9ao+BCqC5XSWf30rKJrOexzlgtScnV0PytxeR6RQVwCV8+22qZ1j1QgKtHyRJglgiN8vNwiqigFN1qMgjDrTSCULZwqegHBInuh9hmLq4wRH5wn5edZ4J+kY8JCF8+txUv+vye/av76oS3TP5PiiVNsNZ7fyo2co6arsTJUg/R1yqmxrRt1joCZ17PkqU0V6WAMCoVISNF2a930fTpWl6AM95m0y6d9y1nSyAlO4hKgj8aPxu/A/dVhW1zSe+zr75bfl1aFQQKoX2xzlKoLzG7bJDqoMBuWu/Qtu84rbHjzobO83oeSCke0KstxUHzLf8Ijb2XLiOQVl1WgAhse+hy7c7W3r9ygbdrZN1Xtztt3yi0aquLC44crslfuMAV26Xw2dtDTmpUSzLZVTUD0TYQK2ITTiW7dVpqZb+TEl6sJTX+Mm30/iZfgKMHD6UFsoUVzR7nAiNCNvvpj2AkGDIGMPz/GD5+MA+kKJEr9HO5m2vBnSIk29CeQ83LrpbIxblm/MuaZNwRRaL7lfNudLUXstQ+CUFJXbsq402X3koa/9MEWpfeqE5Eu+JsoBR3dy+7bRLfAxs/vtL0C5ELalz+koSMOZFZAxZMWkUoXFcjFwzut8qPOmjCbZZxaelDRz4oYFu63si02IeiL8Mk9fFJtdsU+suPadOHcIB4fWlGg5qgIpgJPXh7nHXZcBfSlPsUZXHCjUR5P63/B7U2SZe6Fsq4ZaU/oL55avhzpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4665.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(376002)(346002)(2906002)(16576012)(6916009)(66556008)(186003)(966005)(478600001)(8936002)(5660300002)(2616005)(956004)(36756003)(316002)(44832011)(4326008)(86362001)(8676002)(31686004)(31696002)(6486002)(83380400001)(66476007)(6666004)(26005)(38100700002)(53546011)(66946007)(99710200001)(45980500001)(43740500002)(505234006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2dKamdjZEJKK3pzNldnMTdndkxjV3RUTVFWMzQ2QjloNHpXSHg5N3d4akt2?=
 =?utf-8?B?aWw3cjZaSXQ2V1gybU5YZmxDam8xWktub1VQRUNCNmk0dXM5M0RpRlkvQmxh?=
 =?utf-8?B?bVNxL3hjY0l1eFFZM29uR3VaVzhkcjE4NExKMktnTm5aazlRTE1DSjlRRld1?=
 =?utf-8?B?VUYvRy9PUUV3MnVUYm0yM1o3M3RGTEpqWUVCR3R3eWV4cnc2NXZYQ3gvbmM2?=
 =?utf-8?B?cktmOWt1QlFPOG52VVdLaSs0Qm9sSjZWRlROTjYrNWgzZVlEdmtjYXBHOGtY?=
 =?utf-8?B?a2FMd2VhVEd1cVFaY1VnOHhMNVV5QlU0a2pOUkk5WnhJUm96Z1cxbjIwaVVy?=
 =?utf-8?B?L0VJVnN1Qm8vTDZObFI0c1BrMWsvTEtzbm9oRVcyTHlOWDhRMW5YWHRJOEJs?=
 =?utf-8?B?ZE1aS1cyT2l2cy9Bd0c5eUY5VlI1U3ArRFFYZ3Evd0ZaNFB5QUZ1a0tFbDNU?=
 =?utf-8?B?YlJtbUg5OGErd0NrSVVvdnZwZkw0NnBPaGd5SGJGSXB3QU1laElacEhkYk5s?=
 =?utf-8?B?c1k3S1NMMjAyVmUyczZLUUVaNWtFazl4bUFEdGI2V05USGliUE9JMk4wdU93?=
 =?utf-8?B?bzdkUkw2cklzbE03cXJ3bXJkQUptT0JtNEsxL2JHUzlqcGdKdG5Uc2ZET0Z3?=
 =?utf-8?B?TTc0RFJWN3hZTGhZWkpYUk4zVFQ5RXMyTktNSVQwUGt2S25xTGFEODBDOXI3?=
 =?utf-8?B?SGZhWTh2OEx5U0tiK0I4Q2w5L0JxN29Qc2dOU1RFejVvYS96WHFOUWpXdlZp?=
 =?utf-8?B?V1VKT1dqZ0Y3ZGtKTHpHUXhPSHpBWVFxcW5qa2svUEx5c3VOOTVvTEIwLzZR?=
 =?utf-8?B?QjFQak8vOGhVRUpJZUhYaFVhb1Fzc3p3OWZiMjlqTVhYaFd3aHBZOUtEQkVK?=
 =?utf-8?B?R2xCNm5yenJYR2UwNlAzSUc2V20zNEhCdGZiT2RmOWZyeTVPcjdPYVhvWUh2?=
 =?utf-8?B?bVpRekoyNVdIU2dSVW0vb0JRRmJPOGNxTzlwbG5UYnlBa2dXNERobStQbGlO?=
 =?utf-8?B?SGtaZC81c1Q2V0JkUWgwTWptK1M4NTdvNWVHWVFmMVc2Y040bTZhMHV0QTdF?=
 =?utf-8?B?WjBqZU9WY1hYaFJIaHR2d2puU1pjbUIwdXQ5VEtYbCtCcC9Rd2diY29xZURG?=
 =?utf-8?B?NE52QkdNL1hGbC9ZNWptL0xZV3lQSzlFRWczSU1xdzFQWWRlQXZJcHpGc3cy?=
 =?utf-8?B?WlN5Vjhud24xK3R5UTFKMG0wdzFOV25JQ1RlbUJCSTYybFNYVDR3TnhhUEVi?=
 =?utf-8?B?S0pYVVFzekovUmxlaVNSbEs0ZlpvNDR1cVFDcVlNR2tvaVpnQVNabnZsbVVM?=
 =?utf-8?B?dmpoYy9BUStTUU5KdUYydVlWZ01rWlkwT0QyazNlN3hHZXBKRkhKd1p4VGJr?=
 =?utf-8?B?QVVZdmZsNXVWVStuNjhuanZlSWdTT08zZ3l2TnpIc2lKcU14TFpDYkVNTVVK?=
 =?utf-8?B?c3J5elNFTzZLVzZOOUJ4YnBLM0hHTy9QN0k3TzM5WWZmdmxlT1NKR0ZFMDJ2?=
 =?utf-8?B?cHUwbEZEaEpJWVJIdFlwSXFqbTEzVE5tZVVBK29zdjRiaGRsK0lsczRCYUlU?=
 =?utf-8?B?ajZ4Y0RyWlVPcVllaVhRL0ZVOW5xbkRNK0svN3pyT3h3K2R0cWFEbW5zT1Nh?=
 =?utf-8?B?cFhFN1FCZGJkaFgyL0duUDN3VUdzbkROYkJVL0hwS095ZEFXNE5hOU5KcWEr?=
 =?utf-8?B?WmxaaDIyTmhxY20xNk1SZCtKbjhqNXg0bER2MW9NZkZ1N3dhTUtYSWc2cGlV?=
 =?utf-8?Q?G/mkOlQ/7N02vtNnVfXqzjc1dhhCQXJQ0V7SbS0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c35915d-722f-4335-74ce-08d97c46e290
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4665.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 14:56:54.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNFOLY8DiSCOCtT2Km56+BCvDQjpqOIehBoiiXv4LX6gvPtLNUBUOP9mg7JXlIyB/Qc6ao9xptsihTfswHcOrzPsbGHkmxMkBc4iXHJcDko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2944
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200096
X-Proofpoint-ORIG-GUID: XOQ149qtohdHGK2wNKSmdUnLJuF_4slG
X-Proofpoint-GUID: XOQ149qtohdHGK2wNKSmdUnLJuF_4slG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/21 18:19, Andrew Morton wrote:
> might be a loop-vs-jfs thing?

It may be just a buggy, rarely-taken error path in jfs_fill_super that 
happened to get caught in the loop code. I'll have to dig through this.

Shaggy

> 
> Begin forwarded message:
> 
> Date: Fri, 17 Sep 2021 09:33:28 -0700
> From: syzbot <syzbot+ffc4eceb22dfcf9fd6a0@syzkaller.appspotmail.com>
> To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
> Subject: [syzbot] KASAN: use-after-free Read in copy_page_from_iter_atomic
> 
> 
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d2a07b76933 Linux 5.14
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12fe8af5300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=113c5df900d8cf12
> dashboard link: https://syzkaller.appspot.com/bug?extid=ffc4eceb22dfcf9fd6a0
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ffc4eceb22dfcf9fd6a0@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in copy_page_from_iter_atomic+0x9c7/0x1520 lib/iov_iter.c:918
> Read of size 4096 at addr ffff8880298b0000 by task kworker/u4:8/11701
> 
> CPU: 0 PID: 11701 Comm: kworker/u4:8 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: loop5 loop_rootcg_workfn
> Call Trace:
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
>   print_address_description+0x66/0x3b0 mm/kasan/report.c:233
>   __kasan_report mm/kasan/report.c:419 [inline]
>   kasan_report+0x163/0x210 mm/kasan/report.c:436
>   check_region_inline mm/kasan/generic.c:135 [inline]
>   kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
>   memcpy+0x25/0x60 mm/kasan/shadow.c:65
>   copy_page_from_iter_atomic+0x9c7/0x1520 lib/iov_iter.c:918
>   generic_perform_write+0x2dd/0x580 mm/filemap.c:3664
>   __generic_file_write_iter+0x225/0x5a0 mm/filemap.c:3783
>   generic_file_write_iter+0xa7/0x1b0 mm/filemap.c:3815
>   do_iter_readv_writev+0x566/0x770 include/linux/fs.h:2108
>   do_iter_write+0x16c/0x5f0 fs/read_write.c:866
>   lo_write_bvec+0x267/0x6f0 drivers/block/loop.c:328
>   lo_write_simple drivers/block/loop.c:350 [inline]
>   do_req_filebacked drivers/block/loop.c:668 [inline]
>   loop_handle_cmd drivers/block/loop.c:2204 [inline]
>   loop_process_work+0x21c2/0x2cc0 drivers/block/loop.c:2244
>   process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
>   worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
>   kthread+0x453/0x480 kernel/kthread.c:319
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> 
> The buggy address belongs to the page:
> page:ffffea0000a62c00 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x298b0
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 ffffea0000bb3348 ffffea0000d492c8 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as freed
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0xdc0(GFP_KERNEL|__GFP_ZERO), pid 20552, ts 462739681694, free_ts 462770335978
>   prep_new_page mm/page_alloc.c:2436 [inline]
>   get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4168
>   __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5390
>   lbmLogInit fs/jfs/jfs_logmgr.c:1824 [inline]
>   lmLogInit+0x2fc/0x1e90 fs/jfs/jfs_logmgr.c:1278
>   open_inline_log fs/jfs/jfs_logmgr.c:1183 [inline]
>   lmLogOpen+0x505/0x1190 fs/jfs/jfs_logmgr.c:1077
>   jfs_mount_rw+0xe7/0x710 fs/jfs/jfs_mount.c:260
>   jfs_fill_super+0x64c/0xc20 fs/jfs/super.c:570
>   mount_bdev+0x26c/0x3a0 fs/super.c:1368
>   legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>   vfs_get_tree+0x86/0x270 fs/super.c:1498
>   do_new_mount fs/namespace.c:2923 [inline]
>   path_mount+0x1981/0x2c10 fs/namespace.c:3253
>   do_mount fs/namespace.c:3266 [inline]
>   __do_sys_mount fs/namespace.c:3474 [inline]
>   __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3451
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> page last free stack trace:
>   reset_page_owner include/linux/page_owner.h:24 [inline]
>   free_pages_prepare mm/page_alloc.c:1346 [inline]
>   free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1397
>   free_unref_page_prepare mm/page_alloc.c:3332 [inline]
>   free_unref_page+0x7e/0x550 mm/page_alloc.c:3411
>   lbmLogShutdown fs/jfs/jfs_logmgr.c:1872 [inline]
>   lmLogShutdown+0x4ad/0x920 fs/jfs/jfs_logmgr.c:1692
>   lmLogClose+0x2c2/0x560 fs/jfs/jfs_logmgr.c:1468
>   jfs_umount+0x297/0x370 fs/jfs/jfs_umount.c:116
>   jfs_fill_super+0x8e5/0xc20 fs/jfs/super.c:605
>   mount_bdev+0x26c/0x3a0 fs/super.c:1368
>   legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>   vfs_get_tree+0x86/0x270 fs/super.c:1498
>   do_new_mount fs/namespace.c:2923 [inline]
>   path_mount+0x1981/0x2c10 fs/namespace.c:3253
>   do_mount fs/namespace.c:3266 [inline]
>   __do_sys_mount fs/namespace.c:3474 [inline]
>   __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3451
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Memory state around the buggy address:
>   ffff8880298aff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff8880298aff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff8880298b0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                     ^
>   ffff8880298b0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff8880298b0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
