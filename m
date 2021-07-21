Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABEA3D19CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhGUVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:54:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65346 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229684AbhGUVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:54:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LMUe6R016171;
        Wed, 21 Jul 2021 22:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ai5c0d37s67Igk4ERZad3ZlrB0biRxC8GFVlNL73+Ns=;
 b=wTW6dylat3kG4tHHI+jhfVK8Ch1hm1XGgweiaR5cdA13c4DBJZm9c9pBktyvAQ9KA+3x
 Vw9Hr/3YCuCKNDeY0m/IZM+YzUeAk7VpEU2s+v8CZKm3d5lC9V6IcM0fhSc15bQyUqih
 FTmiYo9IhM/w1bSR6/63U4AAt1bPHop+FeVZAvAvLVKmWv4JhK0XpSK2nDF+oGY0WGXL
 4XLWBu84pisRPKD8LfofXmEZfJ7yb63kh7xD55GX4V5jAdP0HH89QJNcb5HciI9RfTnp
 7B0UBuquFCuoeorABkeoXM7DukgOQ6i97XuHaYU4Wgedusfx52mVUZLGOoYq1tOzb397 fA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ai5c0d37s67Igk4ERZad3ZlrB0biRxC8GFVlNL73+Ns=;
 b=uW7kjoGhQ0leJYGtjrbJdk4JXnjWvlFckjdWZvJ1Y14G3X7bnp8gR8UsmAMGz2sIZala
 z5MtbV9XeZySgTjF2ilKYSg3l+57Tjxgxg4b7dORFN6PGtOSGWdofoSe7BKqcBF40EtH
 iaxsv50iWqkRjrBnnf4C6MlQXKTAlGlennaYaX6QGpUbNNm5XXfnb2i2DZfHkMxfkwtJ
 gFV+gDq1fCXy0upOT4RDl4jR2RTq0VEoNPMf2BheTMnqYEny1Nuv8mO7CNvAFZBpr1ii
 qULXSRJvzq+D9nDxMq5QmoGg3zKYXg0Qj1L3AleVIhZY+0QKGztwvCKHcwbvmRbtxbFF eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xmwgs3ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 22:35:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LMUZsZ070427;
        Wed, 21 Jul 2021 22:35:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 39umb3p8nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 22:35:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZKeJzAktm/ry0UcUnu/yHweQaFeQB3gjUkokQrKhwDRr7ap/tvoHM8HeYyjOsRQLCaBg4H+bs2vAyvudXzNZOLnV1rgiyxxYiBix63xUe6+B6KIZpEBo+ORG6G6zvSuW6G70PM/0sYNICEX9iThCnSNaxAbrql88IrE3F+Nyy/4mMVkXkIHWmMhqX2fg/NURQfgRclkdfEzOdxcNIENNuOLYhHJse2lPkJ/tga83xY1cveBHL2phncrlYW5wdjj/ReZ+0QvDGoVkDusRjvNi+u7yKhDCXZnwENX/EFQiPrX/xYHcvFvO1L1Hg1AIdIlCUZSr3PhKDUhhe++uN6bIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai5c0d37s67Igk4ERZad3ZlrB0biRxC8GFVlNL73+Ns=;
 b=MXULRWSsn69IMg+KZIgiSLkhYqelpYrnrnfdzOpeSS4flxxk8RRZ5tkUeOvQj6J/XKkkPoPOcKDMrb/aUlFqxYAuMhPxTDP0YDi6tcE9X1hdCZZZfIEql6NGSyJPWO6AZTP/KhbTNMLiIbpOPoXjFr9b12WOwLTgLyr7weN5XmSRjL46WBpPAdRLRfszY8ZojxJ2mJ0r6oP43c77EmeVD2IDnPwHQ+kghlEEUOFDje3Vg+OwhUHOH8BhU8gheufHHdToWI2UyAhlJtapME4R7HUXvTvXoiOk+D4iTIrS05gvCIvfpspyjTWawUzKdFCxvhEkVpgHj0C+nNUNKDEkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai5c0d37s67Igk4ERZad3ZlrB0biRxC8GFVlNL73+Ns=;
 b=vhiCVqarCIOtAQHhRqUcB0tszuZIgcruMu/6r9W0sLMmY40ljA1wINUWZoYC8Q8tqBVP39SSoaN1/HrxGY+ouuAyik1oQaqAQpDIPdVRGjFfm+MDMXI9PI3SIW7x5OGLQyG1875asHdcyxPo2efXW3spQNXrE0DwEvLCyOJn3uQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Wed, 21 Jul
 2021 22:35:10 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::b049:95da:3548:61f8]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::b049:95da:3548:61f8%5]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 22:35:10 +0000
Subject: Re: [PATCH resend] mm: compaction: optimize proactive compaction
 deferrals
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        nigupta@nvidia.com
Cc:     vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1626869599-25412-1-git-send-email-charante@codeaurora.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <f515f6a5-07fa-d962-b316-7e5d18706e28@oracle.com>
Date:   Wed, 21 Jul 2021 16:35:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1626869599-25412-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::25) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.154.142.172] (138.3.200.44) by BY5PR20CA0012.namprd20.prod.outlook.com (2603:10b6:a03:1f4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Wed, 21 Jul 2021 22:35:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b278df66-aca1-4dcb-df91-08d94c97cc24
X-MS-TrafficTypeDiagnostic: BN0PR10MB4919:
X-Microsoft-Antispam-PRVS: <BN0PR10MB491990C5ED0B3CF1B38A407B86E39@BN0PR10MB4919.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4BBQPVYRrbuzZp9aA5iHLGR6El9dxIGJSkRsSCMusu+7A8iLvuln1DG/fVRIaww2yKexlVoEHNTOLdZiAkorUUEvVV1qvRaNxHINhKC51WbNNiK2ZV5dYpdWpYMB2WBr5uPSpDPk4T1o0zGPG4OansXeQYcOzStXbT4FT6M7RE/vuq4wR9Vw19y7ZiL12cUYrcxAd/kpKQBy74oXtPTVpDKoPZjR7/O+c06zXTJYt8xsJSusxb6Kp15JKUUW0V9LrKWlH2gfKbokezwu+TlnLk28VAt5WXl0IyCZNSblHNsRj8tpTZSdnzuaaa35/m3fwJB5Vmuc7hqgp8FSYlMHrzYu2a2evha5eXuWaGg+6cXw+6HD2fzGw88N9qwH+55O5sjdF/aTXA0glOeE9I/Nsz0MAzHMPNiCC8kRtOwm6PSjws0WfMLpLP1fz443Q56rs/Y7xGrZHf8ixgfN5t2Sdxi9gPvTdS7jAsqBj8onQAodJoUkHH0pLhbNegPdL0s2fAzkA1bteJyHAMjY4clo9Gz/3vYllEcxxndjV58b1loncejqk9x9f6SdP4DQ00rf/qAxBBFHrRt0Smc+gU/VxnmpEpUPquz4NuqEIoWGKmdcONU7nDJpq7QbsCcjWcbvk03zrrIvB6Qc5OVtZEAAhVWPKZmY3+Ql0sGRgpK0EUNAHYbEqu6rukjQvRplHGIvzi1rdXzEd3w6VNyjAICYBPap6ivmJs6aUiyfM4f2XmIhQd8snuOZ9/ktmRm85ri/CdUSZHGOuFW7tf0A0/Azd+1pgQBWypP0LcuFkKI/D+Awf11j91SbtZWpkIgZX7bd8JcE1GGkeOW3MiAtQzwrvkgikgJGCCLkaWxiZrHGlg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(5660300002)(66946007)(66476007)(38100700002)(4326008)(316002)(66556008)(26005)(6666004)(44832011)(31696002)(8936002)(8676002)(956004)(186003)(31686004)(2616005)(53546011)(86362001)(83380400001)(36756003)(2906002)(6486002)(478600001)(16576012)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjNZN0l5Y1ZMR1RpY0V6UjViSEgxdUF6SmdSUzA3T0RwSllJaGl0emUxc01u?=
 =?utf-8?B?OXNtOFhyS1M2bnlpamJ4SUxhb051U3h6dTRrQ3NxRFVFTmtDeVBTdjBJY2dH?=
 =?utf-8?B?OFJDYWFaenRhc21mdDdONW1MZGJ5OWV5K3Nmc0ROMG1BYVBjVW4vcWxmSm5s?=
 =?utf-8?B?TFNiZ2xVWlU4cm5BK1FBaU5FYkIxT1IyY1c0SjBDdmlweGZkS2wveVVTamNZ?=
 =?utf-8?B?VHRWcFdIMFIyaHdSQnYwc2xHaTlXQ2ZBQXlHUzNrbFI3NTRBZ3BoOWNHWHZP?=
 =?utf-8?B?QmlraXVObkVzRjUrdnRWTEJqYkRHc1hIS2pBenUrdERLR0tVV29KUWYyQlhz?=
 =?utf-8?B?c2VsT1NvNWlrVE43V2lYWVNxVEU1YS9saUx3NzVLbUNWSGZtRnlIUkg1YURN?=
 =?utf-8?B?OXJFKzRFazU4MDJxNnNscHFNVHJTSmZJam1EU0VWUm1DWmtSOTNpRTI3eFda?=
 =?utf-8?B?WmxjWlEyaStPOXk2cDVOWHVVRE9EbFc2dW1JQjQwNHM1NkZ2NExQRUtSMm9k?=
 =?utf-8?B?eHpqZDNWSUwvd1VSM3pzaC8rQkpxZ2crdTYrN1M0UndDYWpUM05jaVRoSFdO?=
 =?utf-8?B?bWVudjkyQkdYUVo4MjNLMWYvbDBMNm5jSWlQVi9RNDhBNVlseElMVXhoUldo?=
 =?utf-8?B?ZEMzYi9PODBzcGhzbEdnUnlUeittSU5IWkFPMjRtalNFeXJKZ3A0M0RKcCtn?=
 =?utf-8?B?dTVZNHM5djBzOFB1RWF1RUlLUWF6MktNalluT0xFL3ZCamwwT0ltR3RKaUFP?=
 =?utf-8?B?K0FRSlA3Y2Qvc1hDSmFXSW8zRCtmOG5RejRNcG1QejVvL2VGcUp3a0hGV1Vu?=
 =?utf-8?B?bUJDampvb3Q0aUU4cTB1VmFkMytUTTdtbjVVUXVObWNPakhIWjZLT3VqdjQw?=
 =?utf-8?B?RmJiUWY2SUJQRHVUTnZBWXpwK0VZbTY5RGZXQW8wTEVXV0psbXlnNWVWeVNW?=
 =?utf-8?B?Tkx3OTJPb2hMZlN0K1FMMUJGaUZSb05LNkVnYmNMTmRSSTlvdFpWd2NQdXhP?=
 =?utf-8?B?YklNbVhrcWM2ZW9OY05hSWR6ZUNlaWl5SDhudUJ6dUZ3SllHT0RDeFRKemdt?=
 =?utf-8?B?QTRZRGtTQUpwYUdZRlQ5SDNkUGxVc2ZndmoyUUwvUUpkOG9CNEdUNml4MThL?=
 =?utf-8?B?TGFOTUpFUXRsQ0taSGxyaGMwaUlUTjBQUXh1bWovR0Q5VXhSVjV4VzJMRE40?=
 =?utf-8?B?TVd4U0JjMDQ2ekk1Q0VYSVFOWkU1WFhOVjNwbVdwYUNmK0l3MVJkb3Y4TlVU?=
 =?utf-8?B?V1l3czhrcldVckxMWFhyaEc0Y1pVQ08ra2RHYWx1T0ZGWHBQeWx1ZVhiNlEw?=
 =?utf-8?B?YTdpVmc4cFVqcVJIRjQwelloVmJ1QVVIYmRjdDRUMzR0SVlVd3J6QXZYakdU?=
 =?utf-8?B?YUNwLytjWjdHQVN5aElzamFWY0N3WnpKdWp4Wm9FNjVnZFJZMDRxWk1oU1BY?=
 =?utf-8?B?MVpSMWMwa3ZkeEtmODJpbUNrUXdVNnJTdjRpRGIzcEVEZzZ1d0JveGphSGZ4?=
 =?utf-8?B?QlFpWHpUZ0NKd1dvbHV6Rjk2S0hEOUFvNFp5SXBJNmZ4dmVkQk0rWE15cVlT?=
 =?utf-8?B?djNsbEZhQW9jRTVqVHZuUkJ2dEp5SXg3TGxha1dYenZGblpRQWtocG45VHN3?=
 =?utf-8?B?YVcyeDgzS3Z4K3NEbHpSQjFiYU9lTWFMSkVpUzBtWi9SR2RvNFRIc1BIdzZy?=
 =?utf-8?B?RkY0ZGNoZkxiMFFjZkVFK0xmbCttVHlyeDh4RXlQMWNFK1d2R3hSU3FsMVcy?=
 =?utf-8?Q?VM2jCVMobeG+fNc3KZP8TJIYRfHS6YkMBMP4kC1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b278df66-aca1-4dcb-df91-08d94c97cc24
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 22:35:10.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgpbv7TqdtT0cG8xctUO/JLF0Rc8rYEThVob/p7rNXDA348MMrS0lrImXSceDWIinDdujmiFNmFrf5lpOyJKhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210134
X-Proofpoint-ORIG-GUID: VFMHTMx3BrsAtpD4jBV3vNSNNkafdQ5Y
X-Proofpoint-GUID: VFMHTMx3BrsAtpD4jBV3vNSNNkafdQ5Y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 6:13 AM, Charan Teja Reddy wrote:
> Vlastimil Babka figured out that when fragmentation score didn't go down
> across the proactive compaction i.e. when no progress is made, next wake
> up for proactive compaction is deferred for 1 <<
> COMPACT_MAX_DEFER_SHIFT, i.e. 64 times, with each wakeup interval of
> HPAGE_FRAG_CHECK_INTERVAL_MSEC(=500). In each of this wakeup, it just
> decrement 'proactive_defer' counter and goes sleep i.e. it is getting
> woken to just decrement a counter. The same deferral time can also
> achieved by simply doing the HPAGE_FRAG_CHECK_INTERVAL_MSEC <<
> COMPACT_MAX_DEFER_SHIFT thus unnecessary wakeup of kcompact thread is
> avoided thus also removes the need of 'proactive_defer' thread counter.
> 
> Link: https://lore.kernel.org/linux-fsdevel/88abfdb6-2c13-b5a6-5b46-742d12d1c910@suse.cz/
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>


Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>


> ---
>   Changes in V1:
>      o Removed the 'proactive_defer' thread counter by optimizing proactive
>      o This is a resend as earlier it was clubbed with other changes posted
>        at https://lore.kernel.org/patchwork/patch/1448789/	
> 
>   mm/compaction.c | 29 +++++++++++++++++++----------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 621508e..db00dbf 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2885,7 +2885,8 @@ static int kcompactd(void *p)
>   {
>   	pg_data_t *pgdat = (pg_data_t *)p;
>   	struct task_struct *tsk = current;
> -	unsigned int proactive_defer = 0;
> +	long default_timeout = msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC);
> +	long timeout = default_timeout;
>   
>   	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>   
> @@ -2902,23 +2903,30 @@ static int kcompactd(void *p)
>   
>   		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
>   		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
> -			kcompactd_work_requested(pgdat),
> -			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
> +			kcompactd_work_requested(pgdat), timeout)) {
>   
>   			psi_memstall_enter(&pflags);
>   			kcompactd_do_work(pgdat);
>   			psi_memstall_leave(&pflags);
> +			/*
> +			 * Reset the timeout value. The defer timeout by
> +			 * proactive compaction can effectively lost
> +			 * here but that is fine as the condition of the
> +			 * zone changed substantionally and carrying on
> +			 * with the previous defer is not useful.
> +			 */
> +			timeout = default_timeout;
>   			continue;
>   		}
>   
> -		/* kcompactd wait timeout */
> +		/*
> +		 * Start the proactive work with default timeout. Based
> +		 * on the fragmentation score, this timeout is updated.
> +		 */
> +		timeout = default_timeout;
>   		if (should_proactive_compact_node(pgdat)) {
>   			unsigned int prev_score, score;
>   
> -			if (proactive_defer) {
> -				proactive_defer--;
> -				continue;
> -			}
>   			prev_score = fragmentation_score_node(pgdat);
>   			proactive_compact_node(pgdat);
>   			score = fragmentation_score_node(pgdat);
> @@ -2926,8 +2934,9 @@ static int kcompactd(void *p)
>   			 * Defer proactive compaction if the fragmentation
>   			 * score did not go down i.e. no progress made.
>   			 */
> -			proactive_defer = score < prev_score ?
> -					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
> +			if (unlikely(score >= prev_score))
> +				timeout =
> +				   default_timeout << COMPACT_MAX_DEFER_SHIFT;
>   		}
>   	}
>   
> 

