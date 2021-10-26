Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9515C43B9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhJZSsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:48:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53166 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238415AbhJZSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:48:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QIP3sf007263;
        Tue, 26 Oct 2021 18:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wm0SzoVKCFYEUjRPtcDRkpVipxv85rvzpcVbpYHbHwE=;
 b=qITnfxTK7h2CDAvS6Ivt30Jnc4WjKLUOMSzi53gjTTQSL/z+cm6pK4MJPEZJ+MExT0kz
 IGo0SeX5g48f+C5/oSjKvBfDuv2rYK8xMvYma/atfuXJyDVQtHfzBDRcDaLYsLNt4bN1
 escX5jgSnbhkfMtfWhhmDe6VWrO7xtOY1spnkfOaSBwK3ZM+eCG6A2wSNe8E6tfGdLF+
 IW8liw+CvEe5BgVfCKkbNSfkmecH0zcWU8shoSjgEGUjqv9uQiBr/WwYArawpopVB/cj
 D0YFvr+hiMjjlJym4r5K9RPvuewnUWURWgTJYKVND3zu+MvbFX1hw6teGSOtFG3JSGd1 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bx4fhxhu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 18:44:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19QIZtMd070201;
        Tue, 26 Oct 2021 18:44:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3bx4gpsr1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 18:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCO5XdlCsJpLh5zfaEkNli3wlsTkKASyP6WPkrml/lhMgpcVxgawd+Dy/uL5dwWQZf5bij2TqYkn/vCkc0UUxIMWrzYMr9wvQlqfhWvArmeDO/+sF6qKCK695CI4xURz4lSlRNQlBk+rMHfRSit9ITK8xT0H7mToFFlzYRJguR3t6bZKWPWhKLiJvOsWPurgxvIWdmTCKWrbcM8ahYDouOVnS/RtYekpUY7wTGKzAJW+Q0Fd1DzM2ThMjwha1Ch8UQBkDGOwc2nntGG76XaaatfUpZ1vXMwVSHDT7sRuOtUN6lEPRJgUCja6Cic2IyYPA1IqfontnEOBqvkX+/0yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm0SzoVKCFYEUjRPtcDRkpVipxv85rvzpcVbpYHbHwE=;
 b=BYruZ67ckeF5E/xZN984L4oCU0ATjegahYamfKjGEW0M0gipRuTQ8HhJDdmreQMa/QhGs3y1y+Ctb9rY3nHXjTxvf3bkidETfdKXGxLsB9JsWpp25tLXn3h7FE9ZU3BGB6rG5fUZXHDVoZEYTWi4eWWmLtCTUBdPKVC+FrchyJijrm0MeL3GPV8C3hmnqqrLbG8vMXLbnt6SiwGRgQnQcRSp9B0akcCi0D/+bF+8060Hxs6mlvSAeClAa38NgSIXnUq2xUij6+ztkAxc1Izz5r182AuJn8hXf8z/xsGmuF1bJbz36QOHBMG2fhFRLJOEUQT1i5XkFdUPdrhEcL+d2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm0SzoVKCFYEUjRPtcDRkpVipxv85rvzpcVbpYHbHwE=;
 b=z0cbk2Wf9AdUA4TKxaC7aFyieSVADuQwrSlDns+PZWubQu3IE9iwPbayGbTSo0gmQi3OFqa/1V4zGmnXD3RvpvbhtfjLUSbPMmCpibuK8htZEGc55bcuymaSJzL75Ju6jXXnet+2G/E8TbhRe9pTMr7ifh9zJgaLxiIYHpzphGM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3734.namprd10.prod.outlook.com (2603:10b6:a03:127::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 26 Oct
 2021 18:44:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%8]) with mapi id 15.20.4608.025; Tue, 26 Oct 2021
 18:44:19 +0000
Subject: Re: [RFC 2/8] mm/hugetlb: remove useless set_page_count()
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, anshuman.khandual@arm.com,
        willy@infradead.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-3-pasha.tatashin@soleen.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <57fbf167-b2e8-69f6-7f79-8e989162c889@oracle.com>
Date:   Tue, 26 Oct 2021 11:44:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211026173822.502506-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:300:117::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR03CA0016.namprd03.prod.outlook.com (2603:10b6:300:117::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Tue, 26 Oct 2021 18:44:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad56cf4-5f35-4131-f9f4-08d998b09e99
X-MS-TrafficTypeDiagnostic: BYAPR10MB3734:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3734D8628D6CF84A812EA07BE2849@BYAPR10MB3734.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdgmqP+ShZa02OcupRGZANvlAPQvsZnfZPpthQszCC3sRp6RBrJvxmK7o2+q0RXAM+4EHHAa7pkz2tZaMyp9maMman3z4htcCQC7bHqJMrOyyydQ5MAfbKN4FQDQpu+hIsdeXYJ7N3nqwDuvoRn1B4TVjHTf+FnMj9z7N6KgNcjJaZstBjW/8RGn/5dVvTlFqlBQQZQk2qv9IpIBkFWMyXwHyCj7l5ZeFXJ2i0IufhJ7KR5jAnBZ1a81NyAnQzyFIet6WapIHWhtheKBLNW5nJTBbSo4dIQXSXBSFMpErmptEfB47Zo5xmAmWqxHp3UyCQb6qAARzG5g+y9C0g7ET0lXVVJEcgXYd40NdLPwk8NrkJ8llbD9PoSwizUNsJ2nT7jr4x91fjeawuUCyaxifmGHOq7HHDN5/vU0QUYzAZTLIA7eI5wSjq1HoHbFFIipGjKVp2KlkhEp/e6o70dDiiVtaSQQuGIrhFhCFQyaEUrhRMmG9YBKBxSdD84CgM18InXXKjWoLc1Kp4e+a5Be42BlvUMgRfOE/XmP4iLkohlUyY5uXTk/C5Ype5yHwUyxVdIiyRo7eOvuJTYqUu3T8uon3P24dGFRzitiM56nTjc5vTNE4h6resTjl/awIdQCPMS83+xX/JphtJnJme1w+2lB+kiaJ2pALKRu+8AkQDRqSUQoybn9G+mMVCgPr/JutLdk6iARNm706r+xvrFalyBfFIRQDnU8nLS61H9QetOF27E3u3/+z1UvyUzSV+4Dred00NeeAHR0bPcrXbs6wKIjUJww7h1oDo+lCAzzAEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(2906002)(316002)(16576012)(86362001)(66556008)(7416002)(8676002)(508600001)(66476007)(66946007)(38100700002)(53546011)(38350700002)(83380400001)(31696002)(31686004)(52116002)(6486002)(5660300002)(26005)(36756003)(44832011)(186003)(2616005)(921005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnQ2VWV2UTd6Qm5sWnNhdi9aMEZoc0ZydHV6U3IvYzlqM1VPTjU1Sm9CVG5n?=
 =?utf-8?B?RVlrKzZNZnBUSTVlUkRKeUl4bjBlN25wNTVRbVBjOXlzNkU2UDhPYUtvWEE0?=
 =?utf-8?B?WEhIZnJIcnlqS25Uc2M3SlM0MkdBd0w3UDVmbTFVNHh3Uit2c2d2bUlJaFNr?=
 =?utf-8?B?VHdrNkdFSXVjKzYxdHZWNXhpbndhdS8xa2pobzVzWXF2MXE1cDM0bVRtUW0w?=
 =?utf-8?B?ZmhGUEpSQkVNRVJDVmdHd0VIejZUTU1BYU1tTU9vTzVYTmtZSzZwS01xUlg1?=
 =?utf-8?B?S2psdTFuQ0ovN2I1eGdJMW1yTUN0L2djQTRObXcrcDBybmZiOXdyeFUvcVhv?=
 =?utf-8?B?Um9XVm9JWDk0WlJsZVA1MXpIK0treDdzZ0Q1S0Z2REljeUlFNGZNbm0yRzlX?=
 =?utf-8?B?NnVpc0xITjFXWU80cjNPL1F6SmhBcFhwRmpZZGlRZ2tMTklqeGFLS2NWMDh3?=
 =?utf-8?B?VmJDYTQ3VmRJRWhiUGFyaUhMcHc5OG9oMUk0UWVnUEdPbmxEMFlNTUJ2cHJZ?=
 =?utf-8?B?d1NLRFd6cmVOT0RLQ1FVYnVKb2dNYWgxdVVrWW5vQmV2ZkowTXhMZWsxOWp5?=
 =?utf-8?B?c3BRenlINVVTcnVSNFNNbzVZSE00MEwyTzFKeFFnc0JDaWFXZUJFSlF2ZUdC?=
 =?utf-8?B?ZUhNTDFnMUJ1emNQcC9oVzF2cU94Z0dnbVAxUzMxUUVsN1ZSbWVsSjlFTFRN?=
 =?utf-8?B?Y1FoV0pKOGFLd2pnZVdPTnR6bEZpMkM4eUtGTHFDOXUxV1ZWT2h0VFZiUHNB?=
 =?utf-8?B?N2dYbzYwbjBCaHNUd1ZhejFEMGo4QXhNb0w0cExyYnN1Tmc5WkV5NnNhN1NG?=
 =?utf-8?B?SmVXcWFYWTVWaHg4VXl3QzR0b0JNMkwxcko2TU1ueEJlbjVXSkhuMDFINnh5?=
 =?utf-8?B?SFA2cm82QVMvd2dzTlhTOUQyWldhVW93TW1VOUpDZWpsRiszTUJSSVBPRzhE?=
 =?utf-8?B?b0s5aGVtM0gzRzZZamFVdHA5V01NRHZqeEQ4TWNEUXJybUFaclJwalRiejZu?=
 =?utf-8?B?Qm9rUEQ5dkNtZXRLMXlGL2RxYnU1NGxoNzBjd25UUkJRdGxYT05IUThORGtH?=
 =?utf-8?B?ZkRUNFJnSittREQ2dlY1ZlhTMGZ0RlEzaXVkUUR1SzBXcmZKdHkzb1RHOHpV?=
 =?utf-8?B?MEZ1UEFZMi9ybjlBVlZVVG1FdVZaWUcxVVFTemdxUFdxNi9iUU83T0RIY283?=
 =?utf-8?B?bGhINDdSaXZsYlhXbGo5VzFmWVNFNkZabUo5alZSQjNNbWN4V2xwaDZwTHZD?=
 =?utf-8?B?V0YyTHhzV0svZnpnckxqcFRZZUw2bHNJcjlISlVPZkRud2k1TmRoTjlZQjhR?=
 =?utf-8?B?M0cxN0hxRXRwNFkrSlRNdXJiVVVCRTlRb1hiYVZkSzNLMmVZeUFsVG1VdHlw?=
 =?utf-8?B?MEIvZXJIdU9jaEFzaGZRM3U5NWZ4MGJxdGhhR05uQko1c3RadDFNbFdtWlB4?=
 =?utf-8?B?QUkyTUM5Y3JIM1JwUjUxZ2ZXRTRKaVRPQTNoUFBORUdPeUdvM3Yybk9iaHF2?=
 =?utf-8?B?YllQQ3VHa2lPczJIRU5tQXBwN2gwaGJxOW9NRTBldTkrczRYMUZKQ2NBeDU0?=
 =?utf-8?B?V1pVdlVlUXFoZDFoVVJsY0s1ZTRWUVJuOU5EQkwxcTYrbzlreVpxdTltRm9T?=
 =?utf-8?B?cE9SYjNtM0hFNEpXaGtOR2N1Z21HdlpxMURKaUJQWW0zRmxjRWVhYnRCWXVh?=
 =?utf-8?B?c3o3VFpyTkFMWEp1VDJpQzZlRC9qYzdwVGc1djY4c1BBaDJVZm9jOEUrTGVx?=
 =?utf-8?B?OHJhMDVsKzE4UWRVYWlGSjBTcnEyZmNKTEpjNE5FTDVvbnpiZUN0Rm5GLzVD?=
 =?utf-8?B?NkhZTnl4ZnRFZzArWVV2Y3ZqOThMOWJFUnJRTklveUV0U3J4dGpGMGNGVnZ0?=
 =?utf-8?B?RUZXQ0p1SDJCVUhrMEZtNURwNnZYYmsyQ3VlS2dCckRJMTlwemI1RjY3SFBT?=
 =?utf-8?B?dWhtUk9SOWY1bHpqSm1VK0J4Q1dxeUdNWnNsOWJCdCs1elpybnpldjlxVDZz?=
 =?utf-8?B?OU1xbm5zWGJqcGVhMEdFam5DWVNyY000bFRqS0t3ZXlCSnBJN3FDcGQzVTRn?=
 =?utf-8?B?U1dUYVcwQktQT01IbHRCbld0a2pPOEl4akJNS1J2WUFJRnh0R2FNVnF2WVIz?=
 =?utf-8?B?SnYyQ2F1STdVUVVyMmxzNDdraUVzcUkzdGlqbnhxaHZueEN1ME9yWU5HampY?=
 =?utf-8?Q?MLX0PSuQHALKRROFqh/1alc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad56cf4-5f35-4131-f9f4-08d998b09e99
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:44:19.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD84o4kg4hSYyKrf1b6iFkdE936wWBgVa3OmuUidHzET+a6Bwt1iwwTac7mmgW9s4G1EqZWtWeKfBikWifhpBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3734
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10149 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260103
X-Proofpoint-GUID: 0Y0IpQMD7SxAJLQe1CiAhJMgJfeUgN3k
X-Proofpoint-ORIG-GUID: 0Y0IpQMD7SxAJLQe1CiAhJMgJfeUgN3k
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 10:38 AM, Pasha Tatashin wrote:
> prep_compound_gigantic_page() calls set_page_count(0, p), but it is not
> needed because page_ref_freeze(p, 1) already sets refcount to 0.
> 
> Using, set_page_count() is dangerous, because it unconditionally resets
> refcount from the current value to unrestrained value, and therefore
> should be minimized.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks!

My bad for not removing the set_page_count when adding the page_ref_freeze.

FYI, there have been additional changes to this routine in Andrew's
tree.  Not really sure if we want/need the VM_BUG_ON_PAGE as that would
only check if there was a 'bug' in page_ref_freeze.

-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 95dc7b83381f..7e3996c8b696 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1707,7 +1707,7 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
>  			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
>  			goto out_error;
>  		}
> -		set_page_count(p, 0);
> +		VM_BUG_ON_PAGE(page_count(p), p);
>  		set_compound_head(p, page);
>  	}
>  	atomic_set(compound_mapcount_ptr(page), -1);
> 
