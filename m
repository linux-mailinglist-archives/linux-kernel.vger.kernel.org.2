Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3688A30B63B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhBBENZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:13:25 -0500
Received: from mail-eopbgr1320073.outbound.protection.outlook.com ([40.107.132.73]:10560
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231520AbhBBENJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:13:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOH+K5hb7NGwxXIyFNyoBQU9CvgoqvI47UrjWbFrM44h1axD4SCbyPrsik2yhzuXRVYcY70FgQk4hBNKw+tKDJPz6DSyDD5kLscXlovx+JohQbmwS1f115O5JuER7KwvhIo7AqBA6i5VwVjMEx8RbB9Vig/wF6+dKYrYhDT3DRWqgDUnP7mOkgSqysHt7m1B/Z3CLOIJy+nxzDVjvnhcGVDS3EpJL9V65rn4hNl5tdSrWwlqsuo6p1ydhjMuDLUQyf7ZOG3+KVjWC86461arx/5J0RrF5jemC4rPNztkdM3P3p9trrtzeNcsALPbt9S9XO9Jc111lNixp3EdWeq6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPbJT9fNdemNDbVH1fGREgpJG+npitnJG1/uwi/JTKw=;
 b=itjymLfYHMZ79/qG+EPQjUlvJ/C6HpmTD/2XX+/OGMQEa8mmXH77dXf2BIS1Zo/g5pgXfBl4USjlzIDYYONYK0HXUZTqzB2caa+xfzZhrx+CYLt1ZDj5oic/w6uIyAkS1jnCdm49X1zrnoZ2tgc7usgzfJdI71Iw67ZDMWZIjwLb9IhUFsft7GZiCyBlXfYncdnvdXTS5NLhaIvld4zDdypbfOAwWmYhM9PBYrLj+FD/EAj8p9eeYflnU+gKS0UdQZrY0J6S2v0pHV3NEy65VGU3BfPgeuLtn2zSByYhzFE3ES4XfVVWXEjjdH7jePf3A5kKWwqq7q2roTuKH1eeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPbJT9fNdemNDbVH1fGREgpJG+npitnJG1/uwi/JTKw=;
 b=op9UJjhVM7jVIau4y6NauD2u+iVZyUfTMP66+qd9ErMU9Wid1HjzessIDNopGYKIhZEVHB+qjQWTs+gdyCDq/iS4NtBKKMP8TaRZYZsRFnBMSXbrydD8o5lvJlRUfMvUHs5dCz5T8vPon88QO+K807EkNIxqcXj163VD+dXitqw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2699.apcprd02.prod.outlook.com (2603:1096:4:58::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Tue, 2 Feb 2021 04:11:35 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 04:11:35 +0000
Subject: Re: [PATCH] fuse: avoid deadlock when write fuse inode
To:     fuse-devel@lists.sourceforge.net
Cc:     guoweichao@oppo.com, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
References: <20210202040830.26043-1-huangjianan@oppo.com>
From:   Huang Jianan <huangjianan@oppo.com>
Message-ID: <ced84fb1-0dc1-a18f-0e61-556cd9e28003@oppo.com>
Date:   Tue, 2 Feb 2021 12:11:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210202040830.26043-1-huangjianan@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by HK0PR03CA0109.apcprd03.prod.outlook.com (2603:1096:203:b0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Tue, 2 Feb 2021 04:11:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe0f236-95f2-4d00-ee0b-08d8c730a14a
X-MS-TrafficTypeDiagnostic: SG2PR02MB2699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB269962029D49DE88FE3837ABC3B59@SG2PR02MB2699.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03s+z4x92p1CMskEnbCPkybPSPwbpcyVONnJjCjj1xleii06QNQjH9twGc5bDScfzkOt2ecAvLpCguk8E9UYelve58u9tU6lPu2pRgkk3hyr+ZBZrGF6s0hFaYEDr2OJAyD2qRDC+qjQdw5ahE9nSRKJ3zApaT/fPHj064niDaUB589H0UISLdeZ8K28FkqK33+aq3JdHJlRXkGEKVPX2/t5G1lEMU7VCA1vgL1evfhVKpGK3UCkEaTor33lOQHHHeACkTGM5bEsEJUmMmbkwdd7apNWAPT14kfA31h40xB9+S1qf21cHF9KNlFTF3Q3hLakKrY6x3i66uaVltAXY8DVuvLY6qu6Z3Ud7AF+NbZ6tGdrrKhio5zLfCyRZAeVgU/5EioWXXcDhd8Uwz+4aIFEYuIdwTcKWLXllIe9zxbXXYObK+xW6qYglQw6r3sQuVG4GOaGwKAj5cRtoj+M0Jrr588qB3YXvg53mRDVo/bGFrvoikcHGVWWdqJGjHWyW3J7dKRAu5cyhq0YlPDAnZdp0C2lLHcsQ4aRwCMjAjR51iLDcvmj4imQuwJrEoiKWxCdOYarE4EY72hOHtLBMlrNdlZ/tnG4agcu9o6gT8M61/fHbtIQ9TltjFHWFxXX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(36756003)(316002)(16526019)(66946007)(8676002)(2616005)(6486002)(66556008)(66476007)(5660300002)(956004)(52116002)(16576012)(6916009)(478600001)(53546011)(86362001)(26005)(83380400001)(4326008)(31686004)(31696002)(2906002)(8936002)(186003)(11606006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFYvYnl1MWJyNHRoLytkeE16bXNjZ1ZNcVBnSjRTNHZWV0ZtQ0Y0dmpzQ0dp?=
 =?utf-8?B?OFZ3TkRpMVhIL0p1QjJDeUVONG5TVWtpZndoZ1RZa0JaNERNYXNxdWFNcXFV?=
 =?utf-8?B?R09wK0xIRC80b2JaUy80TFA2Mm9Wd2dLeWhYWE1iUUdXaEdtWjFXZUY4bW9a?=
 =?utf-8?B?T0Rwc2QxRVhJSURiU1VJU1dlQ0txWkpLUVJjelprdnhzQlpza2tKb1l4Q2N0?=
 =?utf-8?B?aHo4M2cwTUExMnFyTWhOdkVQVElhSVQ5WHBsTXlSSzNQR3JVUW5IZmxuczQx?=
 =?utf-8?B?cHhaS2FIWTRVRGs4bGZMelJuN2t6VWVBTUtuN2krRysyc0dmWThrenhhdTBy?=
 =?utf-8?B?cjY1dGtHSUlsV3luRWttQWF6cjAzR0dEZTdIdkNHMkgva3c2aHRmYzluaS9O?=
 =?utf-8?B?NXY2NHZVdmpzeE81bjdZTUVsTll3SFZWRTRSSG5taXl1ZWg0OHlyNkZyQjJo?=
 =?utf-8?B?QTE4Y1N5VGZCeHBqV2tiTTA5eTRTbit6SnFUUnpZVERhZGF3NzNndUY3cVVW?=
 =?utf-8?B?aGZ4NjU3djBEQ21PTDRucldMdzBmWVBiUm5yKzBXNzBQM3NaTFhPY0dCc1VR?=
 =?utf-8?B?MjZCMnUrTmh2MS9YanMyZlQrZ09rREI2V3p5aDFYRVlMQnBlQnBubEVjdW8y?=
 =?utf-8?B?SEdzMkMyMGdzcWpYTGd4ZmVYTUt4K1NOemRTQnFLejZ5OXJ4TS9GN2htN29a?=
 =?utf-8?B?YkEvMElxcmRKYzZhdzBYbHI4cUJVRnA3UDB3SndHbFdZWTZpNEo3NVFxUVdP?=
 =?utf-8?B?Wm5SSjV5L2d6RGk4bU1adjBmSDUxUGFHUlo5bU9LY0RiM1ZvbUVWK3ZOSFNT?=
 =?utf-8?B?cEt2Wnd1WDdXSHRBM1VRWlJOMFo3VnFYQWNoN1R3SkdOSkJlQTlyelZaR3hW?=
 =?utf-8?B?cnBSWG5zclBSUlNDZnJOZ2FnUUU3NGY1b1hxZDNSU2ZBaWMrV0RkVEFGQU1C?=
 =?utf-8?B?ZDBpQXZrUGlVU2k2aFU1QUFDekJBeVlCS2Q4azlxNHJxWERzbjUvVDdzTnNT?=
 =?utf-8?B?ay9ybHhObmxaMDVPTXVsaXZ4NjFPcXRyN3RzRkhZSDNkc0JHMXhIdEF6V3I3?=
 =?utf-8?B?VVR4MUZlUE1SZEZUdzQ1ZWdQS01EUEE2MHNkTkZXRkxRaFNhTi9iMjFPR3BY?=
 =?utf-8?B?YzVMVi9seTlqVWRUeEZteXlsQ0cvbjBZZHhEcklyamFCTnEyWjhWQTdYWmZr?=
 =?utf-8?B?T3dVVE9uTWhzcU1QbjM0UTVNUWJEME5xRkl5elkwWHNBNmVMa0RaS0N3TjZX?=
 =?utf-8?B?UURsL3IvcFdBL1ZBajRPaWEwbzBPTThJd0dOZHlFRU4zemdHRzZXYnhYbFZO?=
 =?utf-8?B?d2VhSnl1K0hPNitPTGVHY09WTDd6anF4UnlWViszZ2hiZlNmbWhZVnJsbkJo?=
 =?utf-8?B?eXRHSWM0RjF2czBtUlZwaUpYUGxHWlNDcjBodlBtcE5ldzFDaURKVERHUXkv?=
 =?utf-8?Q?bU3SzrO0?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe0f236-95f2-4d00-ee0b-08d8c730a14a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 04:11:35.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRvzQA2dv2CFvW2eazTGp5J5UcHjUXL4JG17d4dzlx9/byj5Oy27lk3SI2mlxxMzNPjbhm2pSC7bPtLpAqqw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2699
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,


This patch works well in our product, but I am not sure this is the correct

way to solve this problem. I think that the inode->i_count shouldn't be

zero after iput is executed in dentry_unlink_inode, then the inode won't

be writeback. But i haven't found where iget is missing.


Thanks,

Jianan

On 2021/2/2 12:08, Huang Jianan wrote:
> We found the following deadlock situations in low memory scenarios:
> Thread A                         Thread B
> - __writeback_single_inode
>   - fuse_write_inode
>    - fuse_simple_request
>     - __fuse_request_send
>      - request_wait_answer
>                                   - fuse_dev_splice_read
>                                    - fuse_copy_fill
>                                     - __alloc_pages_direct_reclaim
>                                      - do_shrink_slab
>                                       - super_cache_scan
>                                        - shrink_dentry_list
>                                         - dentry_unlink_inode
>                                          - iput_final
>                                           - inode_wait_for_writeback
>
> The request and inode processed by Thread A and B are the same, which
> causes a deadlock. To avoid this, we remove the __GFP_FS flag when
> allocating memory in fuse_copy_fill, so there will be no memory
> reclaimation in super_cache_scan.
>
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/fuse/dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 588f8d1240aa..e580b9d04c25 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -721,7 +721,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>   			if (cs->nr_segs >= cs->pipe->max_usage)
>   				return -EIO;
>   
> -			page = alloc_page(GFP_HIGHUSER);
> +			page = alloc_page(GFP_HIGHUSER & ~__GFP_FS);
>   			if (!page)
>   				return -ENOMEM;
>   
