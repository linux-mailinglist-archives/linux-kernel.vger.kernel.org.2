Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86833936E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhE0UQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:16:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33512 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhE0UQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:16:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RKDlbA113904;
        Thu, 27 May 2021 20:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YgT7m1lsXcs+LZ5kilu/vMItDxRxX58a4FzM6KlLHk4=;
 b=qP+NptNl8ZGOAs24xo8elvkoEVEZsK9q4NDn2olBrGexDaI9CIdNg5h0O1ncAVF91cyK
 fuObXX4/h7lGwAIo9pui0hWF3IUz/MBUZOUp88xQq6qo9ldLwGr4ooPz98B2+GLgS2zp
 V+LwXJQBl8pondo8GECRsTMcJ7WFq0sTF1KuAj2EtMoFH8Y2Z3GMTTZ9Ph60H51vIcFS
 dJser51UZiWof07iLdZgWyHlSYnVAox4qiYe7WySugy/EmAlTMii5X47ng1kqwYFb+M4
 9w16WA6rJ7B6tSnYSrR/RXPWiadCneYdiSU2Q65LyzYQWR0vQj2g7cy7D0KERmEWUR0V nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38ptkpd7ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 20:13:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RKBZKd171266;
        Thu, 27 May 2021 20:13:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by userp3030.oracle.com with ESMTP id 38pq2ws2nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 20:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYmCDVPYbvuqhWi398qd41OcMIEYqyqBugbLUnuViccGPG24SB9MkBg+mQ3sPJFUbIaGEIa08Z4LSadTXcATQ5ddxYu+JKc49CNqmIYr5WZx/tSdf2frLwEQ8fM6knGUtlEh6ELibZzi5CP12jPPoYpArZH9daacZmBpmxoK9eO5DkWLzu109Em6Uypakw5N1L7pHrANWWqE6J5pMUhzD0brocGe13yi7sUo6VIKA0kL4J3QakLkAGE8+TEZpmgYhKBVIKLnKAHU3udkaLYRh+2fPKoUf12DEQkb8khpEBgDUcMQYgZ/vcdtDHKJFJnBTTvokTzRwGkqJnv8c8S0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgT7m1lsXcs+LZ5kilu/vMItDxRxX58a4FzM6KlLHk4=;
 b=KL9N7JSiCQjdD/MmNX8MFFZ/sl+bk4s06HXbk8J87CSvbmmzdQSiNS0g69pY+xpUFFPTsGugvd2Ww8MJXS8TQ0OzmS9y5ewICinssbt0moLoF9HX0CJeK6DeV/lgLq5NcTv6atZHKnMX1oPGZsPjpNkyW5klznfEzkj8Nb5xjPmaiGG1QXqwJQ19jNJDlxgzIZ1Q05YA6r0XcRZA/RDY35YYdmdz+laTdPDSFpRX2U8xFTzY8kg0tpGUmEBxdT5mbxLWbElyGZYYUCeLMN4/k56Fl6sGyaQ1S0QaySfirnD0QV/16TXMN4cPj3+VlQf92mBXXbbo6qNVkalHESuLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgT7m1lsXcs+LZ5kilu/vMItDxRxX58a4FzM6KlLHk4=;
 b=V0hyTHvIrcUC7DzQTnXwzN4zMmNAZtFRA1C6DDLOnGNF+FkRA44ydfPQpd1SPk9VnsspGZESCT763PZe+8cJmblZI/zoCOXUw+HN8LBcf+Rsp6YsukFkG4ngrT7eAeGZ7lf+HzNkf8W6uoIOyX3mPhAnwoFsq9qQLz3p3NFKDQ0=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1341.namprd10.prod.outlook.com (2603:10b6:300:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 20:13:44 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::61:f162:a41:508d]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::61:f162:a41:508d%7]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 20:13:44 +0000
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix a kernel WARNING triggered by
 maxcpus=1
To:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, ak@linux.intel.com
References: <1622037527-156028-1-git-send-email-kan.liang@linux.intel.com>
From:   John Donnelly <John.p.donnelly@oracle.com>
Message-ID: <fa2f372a-a29a-26f1-f244-6d1408bf5f6d@oracle.com>
Date:   Thu, 27 May 2021 15:13:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <1622037527-156028-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [47.220.66.60]
X-ClientProxiedBy: BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::28) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.126] (47.220.66.60) by BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend Transport; Thu, 27 May 2021 20:13:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 640b724d-700f-4819-a8b5-08d9214bed7e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1341:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1341EC492FBDCDDD7D5D5431C7239@MWHPR10MB1341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2kTQNYEWljrrJJoHdHcnK+m9bJK8FuvYYDv1rxTgh26zbEE3xGhQliC8OEupdH0SLuZSypP+ZgM1RlJYoLdH7Lhi84DUE/+9Rm8G9p2X+aC48h0nXpTxVlBz67U8QleeiDhiz5/7vCePCYhR+4/hS/4tNrQmBrdiETcZch2giPiqB8926JqQ5MeVti6btPL0P9NKM8taJZK1mrhRR/dfUQuBG7wecsz3t4fbX3kF/UTk1TdypjRH/vDrXp88shSmrbXf+11UQy4iFFJ9kAo1BYgRzNx+kF3Jrgawk9wRLRJ+mNEGun2jkkl2Xs3HyO7+o+sIyyLCZIiRtU64t+7tovJhoNAEReeO9XP1hIpkGCSK2yQFiSVpf7CBN3DtK4FOg03FN8HlCfRNRB1gYCeiHmTZJco/cQzfnPzjFB8tw7Gq4ceyXdpsJtk9j7mmu8x9BQR4tSM7o5zE/3Da/8s7W4yNk7k14qSbcK7YB9DPnwJu2Hqtwu0YTP2NJQgVMie+9aAzRxDgK+jJAJgKsXDmxkjdfR1JMWAH9jwQpA+Y+m6NrapYUX+OG2j3QM2NaXIQaN6h00zfZnstAwCAqMVNlmUrbB15qIWFkKocxPtSAJbWuuFuftwAMrj/nNPb73D1pMYblmZ4GwKg+4jeQ/dtdwxpUikEzgsrIziXwrNTIiJ0EoF0MWqQxCpOUiYIYZz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(396003)(376002)(26005)(16526019)(186003)(53546011)(36756003)(66556008)(5660300002)(478600001)(8676002)(31696002)(66476007)(86362001)(6486002)(31686004)(2906002)(66946007)(8936002)(38100700002)(316002)(16576012)(956004)(4326008)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WWlOOUtGVEY3TkFoTDBtMEc5RFE4aDA1eE8rK2RMaWVaSFpza0pYM0VYbzJ2?=
 =?utf-8?B?b3hZQnd3alh3SzRqZGRSOTMzbEY5ZHRNOW5ZUmR5YkFSbkV1RktjY2NLVFNs?=
 =?utf-8?B?NDZWbUpXRGhtcEpWaWdvUXREVXd2c3FzN2VOVUFGTDNXWXVqUndFS0FqVUdL?=
 =?utf-8?B?WDBTK21iVFhzc2RMdmNzVGRXM0RGalRKSmI5RXNWSlBoR3ZveTBEVXpIejJs?=
 =?utf-8?B?d2tRZVZzQVNmV3hHeld0YUhSUkpSV0lyeEN0ME02MXR1S3NHaldxWmdvaTFQ?=
 =?utf-8?B?YUg1ekF5dUx4SXVybkRKamlweWhiY21SSXdxb3V2QkpiWUNMRFh0dlo5ZlRm?=
 =?utf-8?B?OXNaT1gwaG9VK2RDdldZcG1acEtxSjVuZkl6MkpueExvSEE2cTloRlh3dGdx?=
 =?utf-8?B?cXJwMzZlTGRjNG1LeXg3R1VaS3RQTnluWHFzS0QwQzFDR1hzZVowMmdUQ05a?=
 =?utf-8?B?RUhGRnRuKzlzT3YyYUhUNU1USCtLaVlqRm45UXJJYjhkRFRNZjRBWlJEVUVj?=
 =?utf-8?B?S1BYUEx5TGNDdHFaRU5XN3ptNnZQSGFTMjRzbUNUUGRiUTloRm5yaWgycEd2?=
 =?utf-8?B?cGJwSi9STVhuVklJRml5ZzVLa2R4L0VBS21Ma2VCa3lybnBOdTdQOTNOM05K?=
 =?utf-8?B?dEp6R1g5ZURiangvZGJWQUdwM2ZiSmRqMTFBclhCN3R2TS9LZ2xlNlpycDk5?=
 =?utf-8?B?U2VFMVprYjkrcTZZcHA1cDU5NkoyZEVpM0g2dUtPNUJJK3ZJMzhCenMwdk54?=
 =?utf-8?B?R0dsZ0YzeHg4SFhKOFczL212RXV1aUNreVFVU05GUXNJRWJ1emRpZFdrZ3Zn?=
 =?utf-8?B?ZzNsTUtCRnJ3c3EvWSsweVErSjA5WTJoL1dSSGJGMW9qY1J3citBYTdEUjdk?=
 =?utf-8?B?aHByR0ZOcDdnVXRsSVlUSDJOQ2J0dm1NdStSUWxsUnhiVld6eG82b0lYU1Ax?=
 =?utf-8?B?ZGt4YlBnazhmdXR3b3YvOGwvOFE4MktjWms2eU94WUpFZXd4NSszd01NNmdC?=
 =?utf-8?B?TTZTSGhDWDNpejZUcUU0N2tPb2EvcmR3azRVUCtBM3kyaWxWUFFrZXoyRThq?=
 =?utf-8?B?clZWNWgzQ2VBTXczYU1lUStvVlp5QjVVMzZ0Q3FNTWZMUHV4bTZRS0l0dFpN?=
 =?utf-8?B?TEREQVlEUWRXd28ra1dqa2dUcGdGd3BsSVVhMzZwMDhxczRCdkFNNlFiUjV3?=
 =?utf-8?B?T2Jvb2NqckNRRUpLelA5czM5MFMzRjJ4bWcyQmxsUGYxRHE0amlPMFJZc3E1?=
 =?utf-8?B?SkZRTVBuNEFqZ0tXbEVUdU4zWkt4cFBiRWZkRlNyVVBSQWxNSXp1bTVIcmVs?=
 =?utf-8?B?SUgxS2hsMkZiRWtpN0xKMVpvdU53VXUyNDdzT20xUDNkWDZCVzF5NEtuQUpn?=
 =?utf-8?B?UmJUaU9TSjFKeXoxaWZmSXVKSDl2WEJ3RGx4dE8yNThFbDdnRjRUWGpiMDlw?=
 =?utf-8?B?MERjc0N2LytTbW93SkUvZEN2SFVkREtmbWNXQ0x3REw2Z0Z1bVcwK3QyYlJM?=
 =?utf-8?B?YkVnWXcySXdsYXVWK0RZOXlhVC9keUdYM3dSNlZSM3RZVno4VXlpcHJERTNy?=
 =?utf-8?B?VlNXb1ZvLzZtcldmYk80YmYzQUNUeVJiTXllNVB5MVQ1cnJSSnB3cmppMita?=
 =?utf-8?B?ZDk0M2tYSm9JMFJ1ajRlMnd5K1psYlZUZVY1eldWWUc0S3NrMnRGMWJiTy9t?=
 =?utf-8?B?SjdUWXpESHFMamFvdHRIZFNSajI2U3oxNGptbmo4SlI5bkltMU52YjQrMHp0?=
 =?utf-8?Q?geMa3wceByAznXQaAIq5i7Tbo5d5zBatt4i+stH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640b724d-700f-4819-a8b5-08d9214bed7e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 20:13:44.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOcUhjrNtMyiUsUYFet5el6s8DnmY/ZJRaqnc7YzlxxSWwCYfNlKvP8unly+r42CxeZQrcgrmLYA75DDiDpObKj5WSBX9s6LCd/JjIestyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1341
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270129
X-Proofpoint-GUID: pbVbuYn9hQ1Qj4NQlIvMIG2lk-6J0hia
X-Proofpoint-ORIG-GUID: pbVbuYn9hQ1Qj4NQlIvMIG2lk-6J0hia
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 8:58 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A kernel WARNING may be triggered when setting maxcpus=1.
> 
> The uncore counters are Die-scope. When probing a PCI device, only the
> BUS information can be retrieved. The uncore driver has to maintain a
> mapping table used to calculate the logical Die ID from a given BUS#.
> 
> Before the patch ba9506be4e40, the mapping table stores the mapping
> information from the BUS# -> a Physical Socket ID. To calculate the
> logical die ID, perf does,
> - In snbep_pci2phy_map_init(), retrieve the BUS# -> a Physical Socket ID
>    from the UBOX PCI configure space.
> - Calculate the mapping information (a BUS# -> a Physical Socket ID) for
>    the other PCI BUS.
> - In the uncore_pci_probe(), get the physical Socket ID from a given BUS
>    and the mapping table.
> - Calculate the logical Die ID
> 
> Since only the logical Die ID is required, with the patch ba9506be4e40,
> the mapping table stores the mapping information from the BUS# -> a
> logical Die ID. Now perf does,
> - In snbep_pci2phy_map_init(), retrieve the BUS# -> a Physical Socket ID
>    from the UBOX PCI configure space.
> - Calculate the logical Die ID
> - Calculate the mapping information (a BUS# -> a logical Die ID) for the
>    other PCI BUS.
> - In the uncore_pci_probe(), get the logical die ID from a given BUS and
>    the mapping table.
> 
> When calculating the logical Die ID, -1 may be returned, especially when
> maxcpus=1. Here, -1 means the logical Die ID is not found. But when
> calculating the mapping information for the other PCI BUS, -1 indicates
> that it's the other PCI BUS that requires the calculation of the
> mapping. The driver will mistakenly do the calculation.
> 
> Uses the -ENODEV to indicate the case which the logical Die ID is not
> found. The driver will not mess up the mapping table anymore.
> 
> Fixes: ba9506be4e40 ("perf/x86/intel/uncore: Store the logical die id
> instead of the physical die id.")
> Reported-by: John Donnelly <john.p.donnelly@oracle.com>
> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>   arch/x86/events/intel/uncore_snbep.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index f57d9cb..035787c 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1413,6 +1413,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>   						die_id = i;
>   					else
>   						die_id = topology_phys_to_logical_pkg(i);
> +					if (die_id < 0)
> +						die_id = -ENODEV;
>   					map->pbus_to_dieid[bus] = die_id;
>   					break;
>   				}
> @@ -1459,14 +1461,14 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>   			i = -1;
>   			if (reverse) {
>   				for (bus = 255; bus >= 0; bus--) {
> -					if (map->pbus_to_dieid[bus] >= 0)
> +					if (map->pbus_to_dieid[bus] != -1)
>   						i = map->pbus_to_dieid[bus];
>   					else
>   						map->pbus_to_dieid[bus] = i;
>   				}
>   			} else {
>   				for (bus = 0; bus <= 255; bus++) {
> -					if (map->pbus_to_dieid[bus] >= 0)
> +					if (map->pbus_to_dieid[bus] != -1)
>   						i = map->pbus_to_dieid[bus];
>   					else
>   						map->pbus_to_dieid[bus] = i;
> 

