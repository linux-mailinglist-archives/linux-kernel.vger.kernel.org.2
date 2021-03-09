Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7402331CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCICYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:24:04 -0500
Received: from mail-eopbgr1320051.outbound.protection.outlook.com ([40.107.132.51]:33303
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229797AbhCICXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:23:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3u3cgHjLOi8p/ACnYbVA1AzuwgvSbbsDoN+iZpjBsSnWUXbXC0Cz6f/w7FKRmCjDlBtgGZyCEjLJ/NDMoa2gJx31RtN9BzdRzdm3970Aju/sqGLtyVkuf5mEMKpNhfUC4j2Y+sPQsZjXhrNLAG2x7j9Gyaxykrn5dN4acqHlHUI4lCdeA5wK0sO38u9bKMOqD2nXPLm+gp5ULziUlV2sYFeY44PyIPxDkPTSNEUXYKqqRLt34StbX7GRY8K1zTsLeHzuENn4UrceFiX1JIj4iLayaitdhocJHAcWqfZnvOxVmxi0mdn/5b95HMOaZS7rUJQ3mqGTkaEQ/21k21UtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODusj2zU6rm6VvtfrmKcrL4kaH4ecswbgGljr4xPJTc=;
 b=I3CCxThE9aQ9pz8/21Q31aZ2kJCZdpWgOvRVsxgfelAeC+CaiFT0NWoSuz7JFn/91tMFR51YPi41X8BeWkgD1Ei9ugkNWwuD/woSe1W3sh3CQFydbNiws8uwGQDeXSN0/EmaJpt6xzkWb459+SYEFRe1Wrdbm0WAiCKdEv1qU9SyiQSgDYNzDsAioOc57YXH5sy9e4I36Rl41ggPCVmWCPzidRn+yt40GTzCAw0+k20aMAWzqAdMSgH3ePAnJamfE+LLAlvviLIj/1Zk2T8OPldJxiHwT/K6TaigKisZw8r9oI6/fvAoYm/bVSi8/ygLmLF6qgHDhjCJOzmfjKZuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODusj2zU6rm6VvtfrmKcrL4kaH4ecswbgGljr4xPJTc=;
 b=kLfEW+sg22wD4ILQgwMSCWS4dupRQuvOlYp6Q7Z0bZDox90Xp+Ixp9SOX2vOQbcNODrq92cOLOEO9GZoLg3QYjPZy7QWBMApDdVGYuDSspiHCqfnXN6xORqrY6gCwz5QdreTfCcMfB+FopJYIwRqP4tuooKoBQ5xVGi+3qqAaN8=
Authentication-Results: lists.linux.it; dkim=none (message not signed)
 header.d=none;lists.linux.it; dmarc=none action=none header.from=oppo.com;
Received: from HK0PR02MB2690.apcprd02.prod.outlook.com (2603:1096:203:6e::12)
 by HK2PR02MB3841.apcprd02.prod.outlook.com (2603:1096:202:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Tue, 9 Mar
 2021 02:23:41 +0000
Received: from HK0PR02MB2690.apcprd02.prod.outlook.com
 ([fe80::9cfd:51dc:bd7:62d2]) by HK0PR02MB2690.apcprd02.prod.outlook.com
 ([fe80::9cfd:51dc:bd7:62d2%2]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 02:23:41 +0000
Subject: Re: [LTP] [f2fs] 02eb84b96b: ltp.swapon03.fail
To:     rpalethorpe@suse.de, kernel test robot <oliver.sang@intel.com>
Cc:     "huangjianan@oppo.com" <huangjianan@oppo.com>, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, ltp@lists.linux.it
References: <20210308072510.GA902@xsang-OptiPlex-9020>
 <87h7llhnfe.fsf@suse.de>
From:   Weichao Guo <guoweichao@oppo.com>
Message-ID: <c75229cc-e325-1c8b-0afa-fd236db8319c@oppo.com>
Date:   Tue, 9 Mar 2021 10:23:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <87h7llhnfe.fsf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.252.5.74]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To HK0PR02MB2690.apcprd02.prod.outlook.com
 (2603:1096:203:6e::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.119.35.139] (58.252.5.74) by HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14 via Frontend Transport; Tue, 9 Mar 2021 02:23:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd05546-020b-41d8-0d13-08d8e2a25b14
X-MS-TrafficTypeDiagnostic: HK2PR02MB3841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK2PR02MB3841236F7727D04BC6DAC1DFB6929@HK2PR02MB3841.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+dP7XtK3x/MYNJBgqxnnj0gW4CDV4daZNKl/i1Y++SEk8e+WZJfAu8bKTND+bnd50IYRG1dx1aQBhZx49XojSoyei2ZvTnjSDuTAoibl75wNfzwZu5AQjYR2Hnhp+VPwaPpk3P4SxwGsSZ2I12lcfV4Y2/Xt/+zoBmdgT62c4iQB8IPpnLsrDPJsOJCuh5TcP7jYRer14le3hNS2hie6kgiwkGGMlROGaUcGNxFhkJClU+UhcSfP9RoCxQcrtQSpso++BsLgVmsuec5nmns4fIiWqLybGOMY19E/1K2GoK8KmJfIJtCeWRDPf39Usbwrj6y0EZO1PYT9LRzI0Sxq8wGDjCQGT2GCIKnAQ9xBRk8YV+jVu/HE/0GJBLu+5P4IYuuZFbLmz1wNRrMmGI9hQhvaSXb+ltR2XGkKGcLcmXB+j4DqF1zWnZXwDiwQzgVlQ88vQW4jEe3fzZSU0fytWW/ZTBCErMawn5m3V2bhZq2WgydtfP4oFjJDa9x8WYPtcz25IPSWtHcvT1jnWTtbl2kkF5jK8OMJrF2qR9gEZxctvdSsJbKCAuVxPF0uk5uTbbNdXA/q/Pp6IjAG/fbMMqq0YJ7rZlLE9khAmWRmvJC4tJRDcORVp3Q/iw0Nkvz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB2690.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(8676002)(2616005)(31686004)(66946007)(6666004)(83380400001)(8936002)(2906002)(4326008)(26005)(16526019)(66476007)(5660300002)(54906003)(316002)(16576012)(6486002)(36756003)(31696002)(53546011)(186003)(52116002)(478600001)(66556008)(6916009)(86362001)(956004)(11606007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1ovQ0xGTEg0T2NvWEFXYWozbm94ZkR2dStlcWhIVWNRVXlEdW85T1loWGJh?=
 =?utf-8?B?cTlBQ1UwNDRqVXlKWkdYSEZyZHVDS296Sk5BWW0vbWdoYU5hVk5OUitHZlNE?=
 =?utf-8?B?dmluUmdGZFJCdWJPYytLY1JBUVp4aEhEU0FoWGljb1IxV2w3NE5XOWpNT0F4?=
 =?utf-8?B?WVZYeW5SRzBBejVQVW1USFVVVnM4M0tOQWpLb1F2QklKNVFWMnpSQW81VEMw?=
 =?utf-8?B?bUdHR0Q0VVNTa244MTJTOFllWE16a2pBTnZvWmZaYnh2ekZydklCb1J1SGgw?=
 =?utf-8?B?Q2ZuTEp3TFc5a2FHRWpFT0twZXJvQ3paaFlkMW1NRWI2dHVXL0c3Q05BMEFX?=
 =?utf-8?B?TG5sc1ByL0RqZGZLZkUrOWFRbkpkVitxTWVjWTF4OUJjMGR1L0JZVVRtY00z?=
 =?utf-8?B?MnlmR1N6OUJaVml6SkMrMWUyWGIvN09sVGJpT3dvSDVKZWRSakQyS1R5SnRi?=
 =?utf-8?B?M21lVXJkaUF1VU5yWGFEbG1hbWMwY1FLcjBBVVc0K1gra2JkWk5qTTNwOXRD?=
 =?utf-8?B?OTQyd2xLSmZqbm5NRnU4Y0xUNmJHQll4dUJVYW9BODM5Vm4ranYxbzUwWWhN?=
 =?utf-8?B?SlBHZVpPMHl2T0Q2dUthK3Q1MkR6Z3grQmNPSlJEK2F1Y0UxRFJad3pHRW9X?=
 =?utf-8?B?WTYxKzhlV1FIYWFtcFlMVnlyS2hVVXJDS0haR3N1WWd0NStHZ0tNbmVpci94?=
 =?utf-8?B?TUV6NWNDQ2VraVd3STZFL3ptT2VlZGJ0c2xKcXpjZ2hoNFpBcXlBQ0s0NDRI?=
 =?utf-8?B?NTFGcXhlbTFwRGdoQ0VDaE5RTnlWVE44RGtSQXg4clFWa3FyNjdPM1lTRDEv?=
 =?utf-8?B?QW5ncG93a0czTXR5Wms4aWEzK0hlTlA3SDZWaHlaVytRMEhCd0NPcmN6TXlO?=
 =?utf-8?B?Z2RabFlXOU5rdkkrczZFQ05tdGZVNENUck1QK2Mrd3JWcFlSYkFCbUt4c29O?=
 =?utf-8?B?U3lGcFRrTzBMM0szeU5wMEs0QnlXRzhqYStEZWJjeE5jUEhvMEU3cWtYUUR5?=
 =?utf-8?B?Nm5YbzZ6aWtYcnloeklwQ2kwclQ5ZHdjS2VEWDJXdy9DNGFQU25TeXpjTzRu?=
 =?utf-8?B?UFpOWVIwcCtWN1plN08xcFBnbFJWcmc2MWJwSHlTazg2U3hXeW9BZEoveE84?=
 =?utf-8?B?Q2o5dVlBSXlNeXBQR2xNNjdWb1Noc091WjUwaXJUeGY0WGwvcEs0ODNRcTRa?=
 =?utf-8?B?MzFFTkFLRlc0bG5sRVNYZVQxVDNxYnArUG1ERE1HRU9Uc1dXb3I3ZExvVHNB?=
 =?utf-8?B?WVNuYUx5dUZqZmRaMnB5b0tmdTJSa1BPaEJsc2ZZZHg2OWd0MGJvUjFqQklH?=
 =?utf-8?B?QXVVaTNMT2ZteEVqazNBSHFvVzNVVC9VWVFaam9uZEl2WkxwNEtFNCtoNzNH?=
 =?utf-8?B?QXVOL2lNRkllSkYwWHlTNHovajlBV1lsc1dEVkgwMXRQMlpIOXlRZmQwNndW?=
 =?utf-8?B?NVcrbVFkekFmeXRSczZiRjllbGxlaitTd1paVzdTK1NnVjdGSTROQm04Y2Ns?=
 =?utf-8?B?ZEdYNTk5bGJpTlBYeWZnZTNiNGZDTlRJeE1zUlVHWmdMMHhMN1dvK1NrOFZh?=
 =?utf-8?B?THJNdmZCcFA5VHRselRPb0s2c01OSWU0TWljU2N6YWNnNGkxbk1tRE50alRJ?=
 =?utf-8?B?RmlySEJXblYwTEl3TkdHbHZGdXdwdjNCTTVYQmNub0M5RjVuVmM5MGJYdE5T?=
 =?utf-8?B?UkpCbnFzeHY3VHl5T1ZxOWN6YnpSSFViSHQ0SWpGS1EwY2JjdlVleHp2UzNz?=
 =?utf-8?Q?BxXgqrlCdXrvDQDxq2lW8Fug6WB99neWanegku6?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd05546-020b-41d8-0d13-08d8e2a25b14
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB2690.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 02:23:41.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr8ie6Hax4H5X/NM03HlmHm90Yn5NSafYMncQKYW8LvUc5c6Ri+aKV/nkGqSmXTWZGsGXL3eLKVcDuvfD0j/oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR02MB3841
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 2021/3/8 19:53, Richard Palethorpe wrote:
> Hello,
>
>> kern  :err   : [  187.461914] F2FS-fs (sda1): Swapfile does not align to section
>> commit 02eb84b96bc1b382dd138bf60724edbefe77b025
>> Author: huangjianan@oppo.com <huangjianan@oppo.com>
>> Date:   Mon Mar 1 12:58:44 2021 +0800
>>      f2fs: check if swapfile is section-alligned
>>      If the swapfile isn't created by pin and fallocate, it can't be
>>      guaranteed section-aligned, so it may be selected by f2fs gc. When
>>      gc_pin_file_threshold is reached, the address of swapfile may change,
>>      but won't be synchronized to swap_extent, so swap will write to wrong
>>      address, which will cause data corruption.
>>      Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>>      Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>>      Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>      Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> The test uses fallocate to preallocate the swap file and writes zeros to
> it. I'm not sure what pin refers to?

'pin' refers to pinned file feature in F2FS, the LBA(Logical Block 
Address) of a file is fixed after pinned. Without this operation before 
fallocate, the LBA may not align with section(F2FS GC unit), some LBA of 
the file may be changed by F2FS GC in some extreme cases.

For this test case, how about pin the swap file before fallocate for 
F2FS as following:

ioctl(fd, F2FS_IOC_SET_PIN_FILE, true);


BR,

Weichao

