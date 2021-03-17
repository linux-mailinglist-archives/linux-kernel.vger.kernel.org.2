Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A033F13E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCQNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:34:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54880 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhCQNee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:34:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HDXwWJ181918;
        Wed, 17 Mar 2021 13:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wJUO75Kca34xta1ZGngDbzhVXsVMwkTSn6QzjHYBpnQ=;
 b=BNBNiRWZ6fa+bKd/XyJNj4Du1N3Lya/X9iUdXuKEgcp0fWuaRPlb1CoTYMFk83pqbniD
 09tnFbSkUEpSUAOddtBvfVmfSKgwupFsTTNf0sWCd5gfJUa4Vn805AIOYAaDIVtfyryE
 /R4s26d3X9SAK79uk9sYtW8iMNu051UUm0gVetttgM9N0Ygy5uMFF0hAV3qO6QXIDcud
 x7ciLIjuBXC1kq7LleOfLLWqjevvePQJ+wr2EzJihzVTqN5wfuhQFgdqMTxlDXuUSd6J
 ZTS21WJil2scO6WuFpm8IvWyXQKyPic19FqBkhyahdvf6p51luex1rQl8pyQaaZPn3/U Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 378jwbm564-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 13:34:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HDTnh2139688;
        Wed, 17 Mar 2021 13:34:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3020.oracle.com with ESMTP id 3797a2kkfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 13:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTGoD6Y/DzkLSO6/GSfaeepTAlFlW+mSIFJ4NCLopIJvCmGxkjroktMP7np3VkrhyVrQ6pTjewzF5FcWz9uWCY5Xo+9xxd23NfX8Odg79FSfmCi1AtwhYp588liZPNlrVMQ/rBACyu3rfBJoVz1y7Hz6hFYDbaxwpTOcSRsjrtCpfHC2uDQnkpLmZefcpfD55kyou/IVDiAGno77zXqNuSxDoWa+CP7XeEpLpEK2foUfEu8xxV6woKwBWtFif2wvVGj3YNDzrSplQUvfKkNJVQPwqA7ESM0AqY1eCdQnhf3UyEV6PmEVQNzYCuSgeWGTrGtTZ4w7qdvElEDiPrykrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJUO75Kca34xta1ZGngDbzhVXsVMwkTSn6QzjHYBpnQ=;
 b=EOtlVTPJFQs9a7ioA75dd9Q/vtHaGKLvXpQW98f8i4TLc7TjjpNrKDi8IglFt7RQmDv1bGBWVGPkQpJ+GmdrCw3ymo8OlV/6Qgmn7SdKbWjjuptHw4twQoGPfKS8SG/8Q7sxU/6kv01ax00w29YXbEIcJNrD4c8EnhPgYaz9mtW3wR9A7XhM1EZJ5xuKF+H6tvW0fbBkzgfa6dOMd39PYkys1Aqwa8LtXZvD4jnRjGJ5jmv9UBemXgxsMEbVCw3Cu0FIBU7JX36KIwVPBaSy+gIsS3Lv0KndCHGWuB1fihFdHpNapEMSOC1g4LH0inGQamvEZK1yrLPCFCk6WLZssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJUO75Kca34xta1ZGngDbzhVXsVMwkTSn6QzjHYBpnQ=;
 b=BOqdg1Imi43/va9k4PG31cZbr/99ccQdMHOn30uUHOOlmVZJ4jb191Z4o/ODiNv563C2weFMTcyz+OCFL3/73JxEEBZag/YAPzGia9evhMfVA1FpaMMTcInjTqqN69PZJWVIj6xKnzt0/X72j9Egn/TpiatWHpFPmSUQ6Xjrml0=
Authentication-Results: yulong.com; dkim=none (message not signed)
 header.d=none;yulong.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH0PR10MB5225.namprd10.prod.outlook.com (2603:10b6:610:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 13:34:08 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::b4f8:316f:3a25:faac]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::b4f8:316f:3a25:faac%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 13:34:08 +0000
Subject: Re: [PATCH] fs: Fix typo issue
To:     zuoqilin1@163.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
References: <20210317071052.1101-1-zuoqilin1@163.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <0e95b323-8cab-3c48-2299-759ac524f32f@oracle.com>
Date:   Wed, 17 Mar 2021 08:34:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210317071052.1101-1-zuoqilin1@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.201.65.98]
X-ClientProxiedBy: SN4PR0701CA0016.namprd07.prod.outlook.com
 (2603:10b6:803:28::26) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.190] (68.201.65.98) by SN4PR0701CA0016.namprd07.prod.outlook.com (2603:10b6:803:28::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 13:34:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72daff10-d850-4566-adcd-08d8e94956e5
X-MS-TrafficTypeDiagnostic: CH0PR10MB5225:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5225F9521FF370BE8835E294876A9@CH0PR10MB5225.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RztLdhraoYNvfr03s8fU0z7JQMR2Q8akV3Tf1pbe0FdADh6Q1pG5ljyfFVKMn/yppJF8Gguq+8U3DM0eJ4/kJJrNtLA3pslNFGUVjmtz01qG7PD2NiVBWpkik3d9uDgMfNy5wrtzkiUfklPw2ZVi1IiI1IHYZjYl2tIF/ELCjIJpXwb/5J4P4gu9oj4mftMjayVKvG78IavMz4qvewcMfWRL1pfQct8BtCLFpe6ZwTKMqnrXGj8cobdYnWueMOco+era+uISIQ9dB802jkv0e2eQpMUl8oqxaUbXBlTXHHORGNY1hZx6StT9KCVHLH2HzfaHOJLdCHlxeqNfwGPTDveNMUnK1mk8o06seeJQ6RJXIUaBaOMFI6zAVjA/A3kd7hpt8Dx0y+akat/GjW7MQDGf3onNBXTQTeB5c1pgBMEze0Acpv8JNSBnkU1fNSO5LM2vC1zkpx5c+Dx2q9bRl1PI3Y/YI89LIg6+ClPicvozBM9bPDFJF+1ShEunp07S8/XxmaVHerBFaRuBa/t+EGmQWG9NH5E6fuZTkJw2auBGE8c/DhWEabGr1iHz3win+Z3KQbvuDq38sRt9DwTDMP84izEVU8uEiLGM6th63FGPR69l0ML6V3qXG9O0eg9GWGUZsjPD82iHjnkozwZVqodrqvT1+Jwcw4WgdHE0UDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(136003)(39860400002)(346002)(478600001)(2906002)(66476007)(26005)(956004)(2616005)(31696002)(44832011)(16526019)(66946007)(83380400001)(5660300002)(36756003)(4326008)(66556008)(186003)(86362001)(53546011)(4744005)(16576012)(6916009)(8936002)(316002)(31686004)(8676002)(6486002)(1491003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UnQwN2xCaWZlVWRRcENnZkRBZElIeHJVekx5SHBnYi9BSHk0Zi9LZkdVL2dx?=
 =?utf-8?B?a0VaRUxBeVRHT0Z4YXJHZlBoMTdPVmpPMXV5RmNrbC81NFJpUFY5Q2FEekVu?=
 =?utf-8?B?eWlrcElZWkZyY2FzYkJ2ekMrUWg4cHlENzFWUnFnNTRqNjJvay9QeEgwVE5j?=
 =?utf-8?B?dytHbk9OcDl5QUo2dzlVYTFUYjBXRXVBeGc2MDZwM2Q4WStPZ3RGTzhYc1Rn?=
 =?utf-8?B?eCtPbTZMTXAweXh0ZWR3T1FkOUlpSC9Ca0FTOHZYQXU0YzFkaU10cmVKdHR5?=
 =?utf-8?B?eWs4bHhzcFp3UnJPR0h5a3NyNGdFQXRXbHpXSTY2VEgvZ3Q2Y2JiWW8vdVRi?=
 =?utf-8?B?Q0ZUaFY1ZXhNOFl2a0N1NFpIZnMzU0JmMnJDYUhLN1cxSlVBNjNLTmVTU0k4?=
 =?utf-8?B?dmFyWmUxdnh2c0c3UUMra0JpUngyc2FaZHpxa2ZzazVkTjVzVzRScDlyTUl3?=
 =?utf-8?B?dVMvRDl3USs3aXFBQ1VTQW5mUkRxRnhRZ1YwQkkzY1pDaU0yTkRsb2hVM0VP?=
 =?utf-8?B?QmV2amhRNUd4b3phdDByT0gvdFJFell0Zk5FWjNHSmJXVGJEUDQ2RFpSUUpI?=
 =?utf-8?B?ZUIwYmcvb3pFUktiVjhVeXBKeFBsdXRqR2RRaDZFTEZLelk1amFUOElyNXM5?=
 =?utf-8?B?QmtiWGZzV2xaYWlGWFFPWVduL25tWVBmYjFnU3V5dm9mNTFlSUdIaG45ZVps?=
 =?utf-8?B?aXFzWERGNWN5cTRQL2F1OVZtOFdQQXoxLzRpa28rVTRiUC9raWRYanFHbTc1?=
 =?utf-8?B?a2R3ajU2dmo0b0V0cFZKQ0Z1N3IxM0c3dkhxR01kK2Z5MHdUcVZBYTZIcGpv?=
 =?utf-8?B?RmtVNE81ZElIbk1aWThnWCtpd3IvWko4MHNxNkd6RWtYMXFpSzBINldBZlVN?=
 =?utf-8?B?N1luQWxvd0tjUEdHWWdqTmRFRC81b2VRYVVDMERwUndxQVJDK1E0Q1ZMd29V?=
 =?utf-8?B?NFBhVG1nZW1UWWg4dC9lTERIVjJCT0kzYzRZTWZ3L0gvTGZKMEtTQndlOXBw?=
 =?utf-8?B?b2dHTnFxcFdlYUVTQzIzdEZ5cWtkYUY3aTBKZTRVWkJrQjNwS21laDRmK1By?=
 =?utf-8?B?bFlnaVBpWFJkY296WklmR1N5VFRmSzBsYzIwRU01b294QnFCWUM4UkhwaVcx?=
 =?utf-8?B?MkFGckgwWUxmOTJ6d2grUHN5OVhnS0V2U011Z0dYSmN1L29WZFZRbE4wV0pF?=
 =?utf-8?B?eDdyRjJSbms4NmJ1RUYzcWQremtYWTEvcVZUTzB6YmVVSmdjMlZkKzkxeXlL?=
 =?utf-8?B?UElTL2Z2dnBpWFA3bGc4ejhIT2hmTUZaQWhsZW9Mb1N3SDVMMXNOOGp3Ri9q?=
 =?utf-8?B?emNlUERjR2orWE5qK0c2ZEEvNnRyMkNzcEd1VlJsYkwzMWZRSGxtT1Nkck5m?=
 =?utf-8?B?Y0tlUHNKN0F2ZjQraWFSVmVUaWlYR3Z4Q0pnUjdzUlh3UGhZbDJTa29mTE1u?=
 =?utf-8?B?MVNENVMvbTlTWi9vcHNFTE5NQVhJNXZHMk5SOURzZGJDV01Ec1JZSFpwSXpE?=
 =?utf-8?B?WkVQelZaMUYwbFM4ZWNicUl3N1FCL0grWm5uWTJBRitwRmlpWUhEU0txWURx?=
 =?utf-8?B?bnVPbnNyblk5ckEzSnRhTTd5SVV1ekhyeVhHYlNqM3dFWm9WckVYeE1hZHJP?=
 =?utf-8?B?UDBuanZ3ellVdDRKNDFXZUxqeHdNcGcvYmFhODVzMUtlSjFhU1FFSXd4ZGFv?=
 =?utf-8?B?TXNkK0lrS0RRTE5JWWxIR1ErSUhNZFZzYXVaRHhhRmh4ckxNRDByZXlkZlQx?=
 =?utf-8?Q?NicQmHTcIjI1dWlyk+bFu0JzKopEoOZboyEW2Zm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72daff10-d850-4566-adcd-08d8e94956e5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 13:34:08.3445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODHVwWHQ/1ZuRS8zIGDfJyVl2tAx6t2w9Rx1OqVkRsmY1SPLdckQWDrg/79PzWL35aAAIRTD0RVG37Www1xb9YJaT/y9U8oH1epbCyY0/LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5225
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.

Shaggy

On 3/17/21 2:10 AM, zuoqilin1@163.com wrote:
> From: zuoqilin <zuoqilin@yulong.com>
> 
> Change 'inacitve' to 'inactive'.
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
> ---
>   fs/jfs/jfs_dmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 7aee156..91f4ec93 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -3660,7 +3660,7 @@ void dbFinalizeBmap(struct inode *ipbmap)
>   	 * (the leftmost ag with average free space in it);
>   	 */
>   //agpref:
> -	/* get the number of active ags and inacitve ags */
> +	/* get the number of active ags and inactive ags */
>   	actags = bmp->db_maxag + 1;
>   	inactags = bmp->db_numag - actags;
>   	ag_rem = bmp->db_mapsize & (bmp->db_agsize - 1);	/* ??? */
> 
