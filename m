Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4033FBF92
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbhH3Xw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:52:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10018 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238914AbhH3Xw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:52:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17ULx10h007331;
        Mon, 30 Aug 2021 23:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wullcMhwWLbP274x3EMn/gh/WRO8T6n5VPW7BK6KfFs=;
 b=IhQtj4XyFQPxNmg7TgJHzyimZlrIt33syXBY17Tya3Kry60x3iCQBtLZSLCgikpEo+q8
 z3GkQ5Q5S+J5j1Zn6xO64OK8fklBSTzPV1inAUyZIAxazvK6zhMpDaoiCLTnAtXNSQXD
 SMqpLnbQPwkfwPlRvxn3CZuyMZeMH86r+AKNi3kcSwgoOVn4ClGLgZcYApxkqx2ZX4v0
 pr/SD5LLuPixJhwwJTxwOJN0bBtS0mI+xXQ8E7HzDhKyPThWUtFH3WI6G5cC/C5t6GVb
 BwbwiSi2Xe01p4y8gHHmkYS8vnGkuHTimbKL6V5olca5dEMy9RsqvKRaWLoH/gN00NR4 iA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wullcMhwWLbP274x3EMn/gh/WRO8T6n5VPW7BK6KfFs=;
 b=Vwe6YZOnrPfmSzjB4lV50dxjV4pQldFlUGJ0VcolBz8lt4cUSPxeLJlD9QsP/2QYUJr2
 I4WEl0ZpMUI/h7o8yAlGxuBG+aZCPnm3o4BHF91FzcDb4yBsLnPE835mNQyLN+PZ7BQU
 MFiyrrFhezsQvpAMlHVkGwXY8ZP3mO+TRX6RcOvLVLqCIaFzADLq1g2NiDJFQRhOqHzL
 bNEAvkX3XnV608ZkCg1W+aRYcUTKEXllqNmDgQYuwTkf9cJg0oTCOgWZmdz5Jf3IchHb
 q4/1L3zjDJnmm5H/4vD8FBI5vSlQZY3rriCYzJlAsHySLqRrFyWf9Lc3GRWLCMYtgyav kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxxjwbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 23:51:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UNoB7D151821;
        Mon, 30 Aug 2021 23:51:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3030.oracle.com with ESMTP id 3arpf37qfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 23:51:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4+Rl7ncuq8zZjC84s+NmYcE9XFGYlXPJT+lHmmZxglzVc11YTzcB2Ze3DH6VZF8Q+zWuk/ngLS+Ym6e3nfYD0u4S0jzCeVcNdwbl/JAwinQSjW4Ybr73vRUGdkG6zKdXt39KvgT3B2CDQEyWK47rVoYuR8hwtGXKOvbyIq1UhT3i1KVWeJeHOMHj6pWVqYzVfxB4eD/RlpU6dhpXUZbDNTFz0LQuLCCY4zlJ/0fejCgUkOnK1Mt8PQ8VF0q7XEvjljYB4JcPTfQY/1Zncrpm+M5AZS/Qxfd7DHMBDNl0VeDXR6gVJNj3C1rQ1H+Lvza3Z+BBztph2szfwKwKuC1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wullcMhwWLbP274x3EMn/gh/WRO8T6n5VPW7BK6KfFs=;
 b=eS3Xu1L0ot7oMM4pEifw5mIBEQKn7QaDIdjtoAQLlsOyP2xiLnJn0p5OPHKaLVBQjB/kf3z/Cvyp5SwwzaTltlcucqXSoxshwuoRYOycKCklHlrHsA64AJBR6zQHRuOMoiyDBMj2n8FQFYrJUHib2lubqlsaUgBfmHLTM4Q2mJbK6t31aLp5rA3IjTvdVuDlIVm5a3+48EO3Wo3U/iuY03Tn72RCsZS7Vm1zK5Dup2zqiBHuys/PBNXwPdGLjcSn3RcDIeubj7Cto33DLhE5m/uqUYj/W0XzpbqXdxQ4fHXjFqPFpGuRVzcw3xZ+mjQ0HKmPSHOZiL7uOPHPtujkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wullcMhwWLbP274x3EMn/gh/WRO8T6n5VPW7BK6KfFs=;
 b=aEi3Hxho5KTxY+ALxHlPdPEs3j4Yg2CMcp/eG+/sUqMgUG22hQxE/+y4nXuFzrDeJpMCzkoyzVK7qSqf3noFoCUEP3RqBYxKn5WCgxQ4PcDAGuAY+HrFh4GimSIrMYTq65WRaPc4aKaoywwDhType49uwU2XsrvQZSt7+oGk+OY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3908.namprd10.prod.outlook.com (2603:10b6:a03:1b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 23:51:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Mon, 30 Aug 2021
 23:51:37 +0000
Subject: Re: [v2] hugetlbfs: Extend the definition of hugepages parameter to
 support node allocation
To:     yaozhenguo <yaozhenguo1@gmail.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, yaozhenguo@jd.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
References: <20210827015839.90219-1-yaozhenguo1@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cb57eb20-4812-674c-5488-277449cc06f8@oracle.com>
Date:   Mon, 30 Aug 2021 16:51:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210827015839.90219-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:300:116::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR07CA0023.namprd07.prod.outlook.com (2603:10b6:300:116::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 23:51:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23bbbad5-3f5d-4399-85a1-08d96c111ad9
X-MS-TrafficTypeDiagnostic: BY5PR10MB3908:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3908B1DBD0AD3FE981798D2DE2CB9@BY5PR10MB3908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sdfla+T7UMHGQpCKb7q//x+nMKmq9hwo+ka71HAE86ypp8+1FcYCqloljIVqOBo5r3nVSbG3+CHmtFLXKmoc8Z9rfkjHzdb4HYak88FgMvoL9jk+s7IOQ/Q/MU7oexl10A1T6zwydsqH75OBEZs75KhKL2nK6caIiqGujYl/xbyUZw/48KEKYpO7YIEGtf7vgBXqvfORVAkgzw03o/mC/J3q2rvNsaIo6y/HLIkBOEkOj9rYrk8Uw/2TUduSSq1s5CMZGRRc2JXHGdY2KtvBWdrgBNXU4ekg+8DRNBCxvGdy/IaMD3gLL5REmfZA/IsqlbSj+hxbfc9mxvFVFO8BTRncc6TFZY9Y5yydIJ9MM59yVIJnJ1UrEmf6JPj6ur7IiMawhbjNtDSe9vvCHZ7bkCE9IFJYyiiKdHDZGBdNhrqc7vw03I7t1nFUMyglQSGJYQLknEGUdzmAMm+DtF+L1ctmlZRfUamrkOoaylc8pMl2vv2+HJGzIeyBMQK6+HG/cyWWFwHaNowWNFFB/Oz446CoNnn2AM1pwkBlYFFEqUxIsNR3/G7uF2PbAuUjtSJX/f8zIakvReyR4vOVtB2lmp/2pbNA/llPCxoCe9QsPzXHeHfqN75YViM6ywYn8Rle/hZu5g2F0pAk9DyXZwLCPaXwWp7IFzdZx+QgG80HjM2Tq9vveS6K5oe/57i1xnPl5kSEnUZpivbA12FP9XQIxouI89KZPJ7MxPfF3W20k0e96v5skYtwo/tOD9B4Z5+IJ/FfMmXW0ulSkEw1eX/Ntg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(44832011)(6916009)(6486002)(53546011)(66556008)(30864003)(2616005)(66476007)(83380400001)(956004)(66946007)(478600001)(8676002)(26005)(52116002)(31686004)(4326008)(31696002)(38100700002)(316002)(2906002)(5660300002)(38350700002)(8936002)(16576012)(186003)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNTNEd2Y0NyMFlpMVVYSUt0anhuL21aeW96aDdWSFFCS21zMjdDTmd4ZzYr?=
 =?utf-8?B?OENUZkFPa2lyZjJmZmtCM1J0WXlxMDJ2b3NiZUlMNXgxNFRVS1JlZ2o1d2RS?=
 =?utf-8?B?RnJNcVc4ZFJ3TFIvOCtKSUc4SVFISGRRVmlkaTU1dGRLTi85ZHlSaUozbkV0?=
 =?utf-8?B?bDkxRStBVzBLVE1IYVJTTVNvTjhFcm5kbmkrVnM2WTV0b2Q2VkdNeHJUWS9L?=
 =?utf-8?B?YTVTT2tOT0lUVkxOb29Ceno5aHdRYUgrcDd2bllGbE51WjdzMnljbmgxS3VS?=
 =?utf-8?B?OWxQL29VRUNBelV5WXM3VFNTTFZOeGVpVUlteHZhT1ZOZ2dYbUJNYk81TW5l?=
 =?utf-8?B?Z2ZwcCtYeUJwUTY5cVo5L05Cd1pRSUdJaGpVNTFxSHJaSXpjRW1WbENlR0dz?=
 =?utf-8?B?QmpwSXlNZnh4bHVuUXJDRWlnYXJmTElHeTJuTzFDZXg1dkRyQW95MVVwTC9x?=
 =?utf-8?B?K0pESnhmWlNGMlpSU3RjRWVRM1FmQWZRTmZPYldTR3FVbWhtQXBuTlR4WDZm?=
 =?utf-8?B?TGpOYVhUOHgvMmd1UkhtZzdFdFdhUEtieUNTeldqZzA0azM0cmg0RUNCN3Q5?=
 =?utf-8?B?M0RhcU9tNUFUMkQ5cGtiZy9xZ3p4bGJNK2FpSnFnd3NmWVlxOFZObWNLcXk2?=
 =?utf-8?B?TjcwdjRSVlk3aTR5YWdGZ25sakRMeTBXbUFSNHAxSitGT1V2OGN2SXNvS0h5?=
 =?utf-8?B?VU1xaitkTjZFUlh0dU5wL3JReThwUFI3ZEtRelV1TDd2V0NWWE9ZcmxkV0NQ?=
 =?utf-8?B?eVE4VysxOXNtaUwzYjN6b3o4Z0REZkhTVFdLNCtBMC92UFVpOWdnU0piSGFG?=
 =?utf-8?B?VzRETjA3TjN3UmV6L3BaSWFLYmxYQy8wMkdsM2x0eDFsQWk0NlZMLysvL2s0?=
 =?utf-8?B?RXlDaHBIdkozOEFlRkNxUkhQUis4L0ZlNmw5L3h0dzJaMXNodHQ1UjF4bEpL?=
 =?utf-8?B?RFhpc1kvcGdvMjkxQUhkdDlIVUVaYnlxbXE0aDFIUHBBM0l4d3Y1RWovbkh6?=
 =?utf-8?B?Vm8zV1Faam5rZHF1VzFMRnNyREV0c3ZxQUQwcFNjTExtWG93UXVoZ2l0WTlD?=
 =?utf-8?B?OVIzb1QrOHNqU1pqamJ6aU1oakV6K2tMdzhKZTkzMk5RTk55SFlKQmQ4SVRv?=
 =?utf-8?B?aWUvenk4cXNuN2VKNkw3RGp6aEZPZkJFS3hDVy9lQW1welNWanRZN1VWQnUz?=
 =?utf-8?B?MGQxZS9iRFZ1cnVDT3ZvL2IyY0o4Q3NnL2dDMStWMEFvay9FY2hkTjFtK0xx?=
 =?utf-8?B?RStUQnpSRGkrRS9wSjRtTHZ2NVBXdExFamhyamlzRS96bWU3RFRKV1N6Rldu?=
 =?utf-8?B?TDBmKzNOVmN6SHVkNklHN3FUYVQ1Q1BBTTZVanNvK1JTa0Z4U0pDN0t6UVdT?=
 =?utf-8?B?UFNIeGdjNklVZE9STHhEZWpQSEFzTm04Z3RwUkVlakUrMnpUU0tlVVF3bGs5?=
 =?utf-8?B?V0crSHR0SmNLblV1bUo4c3l4cjkwN1ZXc3MySkprUFF0V2RNd3hQZ0pVU0Ft?=
 =?utf-8?B?MUx4cG5jTkpIM0RtdnlIUW8zOTVhV013M1BYaEJkVU0rYzJpUzArS1BHTmtY?=
 =?utf-8?B?cGhxUm1vaHRDY0VYV0I2SHd4SWxCU2FPZDdXVUM3blZXbGFqbWFpdk91N09m?=
 =?utf-8?B?ZWVTQWJjMXRlV2JXT1AwYVVjV21ISDFiQS9TTUZ1QWk0K01WTVVORGk0SDRq?=
 =?utf-8?B?VWFUN3g5dit3TXdleEV1RXdmd2s3SlBJMnl1N2kwRzY0dkloVm8vYzBUMGxv?=
 =?utf-8?Q?W956pMV9Kw+/Ki1ulF9pP5Pcd1OJlREGZQHBCtj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bbbad5-3f5d-4399-85a1-08d96c111ad9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 23:51:37.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bRWLLBbFva/+rKFXdKIy1gyWoTMP4b0Xt76IYb9d0jGhMpPKbTznKyWkPTl4UFd1Eq+x77m0qoEiYKmfAzHCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300150
X-Proofpoint-ORIG-GUID: HAE6kufl3t_KEBKYLzOG0eUXGL1cxeHB
X-Proofpoint-GUID: HAE6kufl3t_KEBKYLzOG0eUXGL1cxeHB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for continuing to work on this.  Some comments below.

On 8/26/21 6:58 PM, yaozhenguo wrote:
> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepags in one node. For example: DPDK needs hugepages
> which is in the same node as NIC. if DPDK needs four hugepags of 1G
> size in node1 and system has 16 numa nodes. We must reserve 64 hugepags
> in kernel cmdline. But, only four hugepages is used. The others should
> be free after boot.If the system memory is low(for example: 64G), it will
> be an impossible task. So, extend hugepages kernel parameter to specify
> node number of hugepages to allocate at boot.
> For example add following parameter:
> 
> hugepagesz=1G hugepages=0:1,1:3
> 
> It will allocate 1 hugepags in node0 and 3 hugepages in node1.
                     hugepages
> 
> Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
> ---
> v2: 1. add checking for max node to avoid array out of bounds.
>     2. fix wrong max_huge_pages after failed allocation.
>     3. fix wrong behavior when parsing parameter: hugepages=0:1,2,3:4.
>     4. return 0 when parsing invalid parameter in hugepages_setup
> ---
>  .../admin-guide/kernel-parameters.txt         |   8 +-
>  include/linux/hugetlb.h                       |   1 +
>  mm/hugetlb.c                                  | 133 ++++++++++++++++--
>  3 files changed, 126 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdb22006f..64a128924 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1588,9 +1588,11 @@
>  			the number of pages of hugepagesz to be allocated.
>  			If this is the first HugeTLB parameter on the command
>  			line, it specifies the number of pages to allocate for
> -			the default huge page size.  See also
> -			Documentation/admin-guide/mm/hugetlbpage.rst.
> -			Format: <integer>
> +			the default huge page size. If using node format, It
> +			specifies numbers of hugepage in a specific node.
> +			See also Documentation/admin-guide/mm/hugetlbpage.rst.

Documentation/admin-guide/mm/hugetlbpage.rst also describes the
hugepages parameter.  It should also be updated.

> +			Format: <integer> or (node format)
> +				<node>:<numbers>[,<node>:<numbers>]
>  
>  	hugepagesz=
>  			[HW] The size of the HugeTLB pages.  This is used in
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f7ca1a387..5939ecd4f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -605,6 +605,7 @@ struct hstate {
>  	unsigned long nr_overcommit_huge_pages;
>  	struct list_head hugepage_activelist;
>  	struct list_head hugepage_freelists[MAX_NUMNODES];
> +	unsigned int max_huge_pages_node[MAX_NUMNODES];
>  	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>  	unsigned int free_huge_pages_node[MAX_NUMNODES];
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dfc940d52..9e9d94b2a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
>  static unsigned long __initdata default_hstate_max_huge_pages;
>  static bool __initdata parsed_valid_hugepagesz = true;
>  static bool __initdata parsed_default_hugepagesz;
> +static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
>  
>  /*
>   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
> @@ -2842,10 +2843,65 @@ static void __init gather_bootmem_prealloc(void)
>  	}
>  }
>  
> +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> +{
> +	unsigned long i;
> +	char buf[32];
> +
> +	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
> +		if (hstate_is_gigantic(h)) {
> +			struct huge_bootmem_page *m;
> +			void *addr;
> +
> +			addr = memblock_alloc_try_nid_raw(
> +					huge_page_size(h), huge_page_size(h),
> +					0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +			if (!addr)
> +				break;
> +			m = addr;
> +			BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
> +			/* Put them into a private list first because mem_map is not up yet */
> +			INIT_LIST_HEAD(&m->list);
> +			list_add(&m->list, &huge_boot_pages);
> +			m->hstate = h;
> +		} else {
> +			struct page *page;
> +
> +			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +
> +			page = alloc_fresh_huge_page(h, gfp_mask, nid,
> +					&node_states[N_MEMORY], NULL);
> +			if (!page)
> +				break;
> +			put_page(page); /* free it into the hugepage allocator */
> +		}
> +	}
> +	if (i == h->max_huge_pages_node[nid])
> +		return;
> +
> +	string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> +	pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
> +		h->max_huge_pages_node[nid], buf, nid, i);
> +	h->max_huge_pages_node[nid] = i;
> +	h->max_huge_pages -= (h->max_huge_pages_node[nid] - i);
> +}
> +
>  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  {
>  	unsigned long i;
>  	nodemask_t *node_alloc_noretry;
> +	bool hugetlb_node_set = false;
> +
> +	/* do node alloc */
> +	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++) {
> +		if (h->max_huge_pages_node[i] > 0) {
> +			hugetlb_hstate_alloc_pages_onenode(h, i);
> +			hugetlb_node_set = true;
> +		}
> +	}

How does this interact with the hugetlb_cma parameter?  Currently, boot
time allocation of gigantic pages is skipped if hugetlb_cma is
specified.  Looks like the above code will allocate them.

This also brings up the quesiton,  Should hugetlb_cma be changed to be
node specific as well?

For now, I would keep the current behavior and skip all boot time
allocation of gigantic pages if hugetlb_cma.

> +
> +	if (hugetlb_node_set)
> +		return;
>  
>  	if (!hstate_is_gigantic(h)) {
>  		/*
> @@ -3580,6 +3636,9 @@ static int __init hugetlb_init(void)
>  				default_hstate_max_huge_pages;
>  		}
>  	}
> +	for (i = 0; i < nodes_weight(node_states[N_MEMORY]); i++)
> +		if (default_hugepages_in_node[i] > 0)
> +			default_hstate.max_huge_pages_node[i] = default_hugepages_in_node[i];
>  
>  	hugetlb_cma_check();
>  	hugetlb_init_hstates();
> @@ -3649,6 +3708,11 @@ static int __init hugepages_setup(char *s)
>  {
>  	unsigned long *mhp;
>  	static unsigned long *last_mhp;
> +	unsigned int node = NUMA_NO_NODE;
> +	int ret;
> +	int count;
> +	unsigned long tmp;
> +	char *p = s;
>  
>  	if (!parsed_valid_hugepagesz) {
>  		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
> @@ -3656,25 +3720,68 @@ static int __init hugepages_setup(char *s)
>  		return 0;
>  	}
>  
> -	/*
> -	 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
> -	 * yet, so this hugepages= parameter goes to the "default hstate".
> -	 * Otherwise, it goes with the previously parsed hugepagesz or
> -	 * default_hugepagesz.
> -	 */
> -	else if (!hugetlb_max_hstate)
> -		mhp = &default_hstate_max_huge_pages;
> -	else
> -		mhp = &parsed_hstate->max_huge_pages;
> +	while (*p) {
> +		count = 0;
> +		ret = sscanf(p, "%lu%n", &tmp, &count);
> +		if (ret != 1) {
> +			pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> +			return 0;
> +		}
> +		/* Parameter is node format */
> +		if (p[count] == ':') {
> +			node = tmp;
> +			p += count + 1;
> +			if (node < 0 || node >= nodes_weight(node_states[N_MEMORY])) {
> +				pr_warn("HugeTLB: Invalid hugepages parameter node:%d\n", node);
> +				return 0;
> +			}
> +			if (!hugetlb_max_hstate)
> +				mhp = (unsigned long *)
> +					&(default_hugepages_in_node[node]);
> +			else
> +				mhp = (unsigned long *)
> +					&(parsed_hstate->max_huge_pages_node[node]);
> +			/* Parse hugepages */
> +			ret = sscanf(p, "%lu%n", mhp, &count);
> +			if (ret != 1) {
> +				pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> +				return 0;
> +			}
> +			if (!hugetlb_max_hstate)
> +				default_hstate_max_huge_pages += *mhp;
> +			else
> +				parsed_hstate->max_huge_pages += *mhp;
> +			/* Go to parse next node*/
> +			if (p[count] == ',')
> +				p += count + 1;
> +			else
> +				break;
> +		} else if (p == s) {
> +
> +			/*
> +			 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
> +			 * yet, so this hugepages= parameter goes to the "default hstate".
> +			 * Otherwise, it goes with the previously parsed hugepagesz or
> +			 * default_hugepagesz.
> +			 */
> +			if (!hugetlb_max_hstate) {
> +				default_hstate_max_huge_pages = tmp;
> +				mhp = &default_hstate_max_huge_pages;
> +			} else {
> +				parsed_hstate->max_huge_pages = tmp;
> +				mhp = &parsed_hstate->max_huge_pages;
> +			}
> +			break;
> +		}
> +		pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> +		return 0;
> +	}
>  
>  	if (mhp == last_mhp) {
>  		pr_warn("HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=%s\n", s);
>  		return 0;
>  	}

This check for 'mhp == last_mhp' after setting parameters will result in
a change of behavior.  For example, consider the following command line
options:

	hugepagesz=2M hugepages=2 hugepages=5

Before this change,

# dmesg | grep -i huge
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.14.0+.old root=/dev/mapper/fedora_new--host-root ro rd.lvm.lv=fedora_new-host/root rd.lvm.lv=fedora_new-host/swap console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepagesz=2M hugepages=2 hugepages=5
[    0.054206] Kernel command line: BOOT_IMAGE=/vmlinuz-5.14.0+.old root=/dev/mapper/fedora_new--host-root ro rd.lvm.lv=fedora_new-host/root rd.lvm.lv=fedora_new-host/swap console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepagesz=2M hugepages=2 hugepages=5
[    0.054271] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
[    0.054282] HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=5
[    0.054286] Unknown command line parameters: BOOT_IMAGE=/vmlinuz-5.14.0+.old hugepages=5
[    0.412456] HugeTLB: can free 4094 vmemmap pages for hugepages-1048576kB
[    0.424527] HugeTLB registered 2.00 MiB page size, pre-allocated 2 pages
[    0.425459] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    5.168890]     hugepages=5

After this change,

# dmesg | grep -i huge
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.14.0+ root=/dev/mapper/fedora_new--host-root ro rd.lvm.lv=fedora_new-host/root rd.lvm.lv=fedora_new-host/swap console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepagesz=2M hugepages=2 hugepages=5
[    0.054569] Kernel command line: BOOT_IMAGE=/vmlinuz-5.14.0+ root=/dev/mapper/fedora_new--host-root ro rd.lvm.lv=fedora_new-host/root rd.lvm.lv=fedora_new-host/swap console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepagesz=2M hugepages=2 hugepages=5
[    0.054636] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
[    0.054647] HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=5
[    0.054651] Unknown command line parameters: BOOT_IMAGE=/vmlinuz-5.14.0+ hugepages=5
[    0.413714] HugeTLB: can free 4094 vmemmap pages for hugepages-1048576kB
[    0.427774] HugeTLB registered 2.00 MiB page size, pre-allocated 5 pages
[    0.428628] HugeTLB registered 1.

-- 
Mike Kravetz

>  
> -	if (sscanf(s, "%lu", mhp) <= 0)
> -		*mhp = 0;
> -
>  	/*
>  	 * Global state is always initialized later in hugetlb_init.
>  	 * But we need to allocate gigantic hstates here early to still
> 
