Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135323B96BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 21:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhGATrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 15:47:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55154 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhGATrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 15:47:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161JWX8t032276;
        Thu, 1 Jul 2021 19:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=1WrtqRKJAS0+N7nQaO0qPORu6WLDoqcuPS1DTu8dOCA=;
 b=cHKfXjvWRx1T15wNeeC+0GeWPArki1J8CzDcIo+Tp9xu+QPS3jWmYJuNYv4HYR52ytVS
 KyXL+lfacVo4IT0ldo6CJ/1vSRbK4Wy5SKQR2KpEZE+PaUqyb9BJAwux8xedu8DX23Qs
 acqy3r42bc5S5XIlBduk+ewDH2GQKII1w9TF0W3mfLKn8IUrQIoij94OPUuuBvStje7+
 35Lt4kR3CTI+lPW5DcBfIGAIDtAugyhqhmvS+gOZhM2cuwCK1f4Qvc5mjUgz++x/wqbA
 XD4TQG+Fw551o1DBy+7KGRqMhn9okxJf66gxvarTcN0OZnr9o7luG3v/wQ4PdmIIlgfc Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gjrwkx3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jul 2021 19:44:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 161JZnu2012826;
        Thu, 1 Jul 2021 19:44:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 39dsc4n64k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jul 2021 19:44:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9e7GpTb+PkCCovWvnpvFjXSniIgBJqBsr7RaDSRFaCNKbglk/KjbnJSBdG/Ve5qImZcYbrNpqFcD4cnV2Jlp2cQPujh4cuXq0U8DsCZZnrmPJy/8SKbHIET/o/xgyzez9f7tdjwxEJs5fHIb+KJRTdxfydcnbIz1GMjecMF9t2DcScY9Q/nldUwXdNycZdagt3hPTe8rt1vFU+7/n+lwhQOU2PEONOrBBxXUqk2PGr6WnToRycbw18zLCrqmu40fpcbGvq9xQEbbBdwKDjMhz3wfAk/eCj8n5+I2j8gqI/mNK46vPxtjlSHSSZWPt3Hzw7ezXd9awhR3GkeGX7kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WrtqRKJAS0+N7nQaO0qPORu6WLDoqcuPS1DTu8dOCA=;
 b=IOcadR4VEA8cU36LlGv+ZebNxlGFHFKfGLsBT9dWmqRnyAmX7h0H5IT8d+55Zwp1UaGIOIpnc6ZI7Vs/8QHJtprs47RzOdFCqhO/0+OWLzVH0RsZJ3L4Mmn6BndtY4a0Wz2NvkgKkP29MFmjW4EbNFaPyHRCH0CR93mkuK/f1ZZw+7+IjD4f/NEoHn0RVD2f/EvRdQpc5g9Co5YTHNgIvAw3fKSSxAoC1eF0Fk0E9fcbWVIk27oTOQn6RcgynEhlUV6enBj4aARFS9IxUVvXsQyxx4jTGZLZki07fZgDkq+MNk6F21EhII0rxY/PqoriYYwBFAugrCLoZVc/kq+cQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WrtqRKJAS0+N7nQaO0qPORu6WLDoqcuPS1DTu8dOCA=;
 b=iPev71bDHLwyYmjYssQ6yEqFq6Ma2V9VooXUIHevJEpe24JlKcM5dehVyCkMKfsiV9cm0oJF0CKYsA3sST97+vgq3yP8ba0nvt+QXd/K0Xr+ygnOZFnupSFTn5KwnBst2IZkY6ae34qIsBQwxoMCIoNlqxpF6MHRfBkI5hh0if0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Thu, 1 Jul
 2021 19:44:40 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::c566:4c25:47f:a51e]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::c566:4c25:47f:a51e%4]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 19:44:40 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] jfs updates for v5.14
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <0a301710-7be3-e1ed-9690-14b4de9e1fb6@oracle.com>
Date:   Thu, 1 Jul 2021 14:44:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [107.182.65.110]
X-ClientProxiedBy: CH0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:610:76::10) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (107.182.65.110) by CH0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:76::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Thu, 1 Jul 2021 19:44:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd8582fb-277a-4f04-5257-08d93cc8aa79
X-MS-TrafficTypeDiagnostic: CH0PR10MB4890:
X-Microsoft-Antispam-PRVS: <CH0PR10MB489034F9D7BE6CA2E642CD0087009@CH0PR10MB4890.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4bcDhqHAWvgjRGkJXjXfIUzdCZfY8EZJzxC6fzd1NGQmhG8Aw1z3990GZLcIcNgU24taw01T/PAAsBPGhqAQrDl1qu03tGLFbD+KC0+BN23T8RgEI0kWo8N8qWNLEL63ROvNst+CgTki75J6U3hdWoOobrfA5WLkxLx5JpgzPmfDkekNZcOJsZOVIvcQhz9Zkvye2vH75uRPR/PFdZ70E06uNFhgmzJa2eoBoiKGGo2ZtSGdw11wKgxvX3o0ESuvlvd1MMJTo6mZyYUgBLr1P1f1NMTd1qP2vDSkUpIRRnhwq1b60SE2G3zq8Tf3qQBrQDWoQqZFJmgLH1sE+sg7j3WmrBOZkVwXoDwmZqmcL7JIb3oUUWUEDY3dFttGToyN7qqMBVRve0BaD8YhAU/aFidS25rm2ma4N+WvegZX25uGgn6Zpz6HfqUYko89qcMdRgKYWTjH9CwfBSNxmixQd5sOp8NJgWVh55wKuKZzb/1Yts+eSa48rZPx66kFBOxGG5xfKjeduQT1M1KLPjLHisIv3hG8Uxb9YZcjvZ/yjv4/LZXm3u1dW3hZcVr22xcyU3aYOp7MDSL3tAqlYoVJ3jPJ5G/32u0u3n98KQ+8mkA9+rHUhqxRI3XGjnRwuFsHwjt8S3IFckHnCM2ax2VVG8mzwlIfEuNt8+Ny3AfE/GnX/DOgwJozZx8NqfLkYaO1a8f3O7Ctyc6ZfKqJUePe/pLCY+t9vtcE+i5u3G4vYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39860400002)(346002)(136003)(8936002)(2616005)(31686004)(956004)(2906002)(66556008)(8676002)(6486002)(478600001)(36756003)(83380400001)(66946007)(44832011)(38100700002)(66476007)(4326008)(26005)(16526019)(6916009)(31696002)(86362001)(5660300002)(186003)(15650500001)(16576012)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhBcXFZelVsb2N6RmV5NXdXbkt3V0lraWtncDUxRnYzU0NDOVFRSjJKbXNu?=
 =?utf-8?B?cGpzajlNODhZUUdnTlh4eWF2ZlRTNm9XcFV0MVg1dktqZWU0NWlrQUlKQ2FP?=
 =?utf-8?B?WEdsREZMUElxUXR6OVdZZCswSEFrdEtqRFFmQ0M1ZkxyYWh0RGZQWmg2YTB2?=
 =?utf-8?B?eGd0djFob0lWekJyaWIzNklocENucW93Q3IwNkZwQnZmV2NveFdJbkRqN0I4?=
 =?utf-8?B?SnBCcll2UkxUT3R4SG85TlZHcDBoSVpPSDlTZ1l4a3VCNnVWdGswbW1UUVEr?=
 =?utf-8?B?aFhrcWZtZVd5bUdZZFQ0S1A4SWk0am1sbm50RXpBbzJiaXhuY0FxcXFaNG94?=
 =?utf-8?B?UmpzZzZYQlZhSDMwUkNrZjVQVjRTZ2VIS21VSnBibkRkcWhTNFZmWkx1U3Yv?=
 =?utf-8?B?WjdOY3BIbHgxTWFqRGJkeHFUbkhDUUNENG4rQm53NnhYV0pkNENCbjArTVJP?=
 =?utf-8?B?eEFzT2dGTEdLVlRlQ3hod2hJc3o3VDVLZ2taTW5qanNjdTVUSjMwakhaMUEr?=
 =?utf-8?B?dU5rclJOcldUOTZNMm9iMkc3Wk9jUG9NaVpabDIzSmRiY2xCaUVlUHE2YVR1?=
 =?utf-8?B?UWZpVENlN0xDclZtWGZPb2pkWkJoOG9wNFU1MkZsS2ZyMjlJUnNhV1lqVXJn?=
 =?utf-8?B?T3JxUVFTMzFCQkRXQ1BsNisySFZOSFp4OXlHMWdMWVIvK2taNlJ3R1lpNHYw?=
 =?utf-8?B?Y1h3a3NkS0ZXYlZFRmsvVzJzQ1lUTXlENHB0SGNnajk0V0owcUt5TmNaTWpZ?=
 =?utf-8?B?UUlONzFudlV0d3ZxQmxGT0tvREpKcFpPelNjWDlGb2NtNmdRQUIwVm9FeG45?=
 =?utf-8?B?Y3Zkek4vSmZySG13SnhCUllWRVN2Mzd2RGpvdkpZQXBST1JtY1JocEd1YWJO?=
 =?utf-8?B?eC9NWmRwQ2hocUJvYXozL1B6OVVGVTNUV0JHcTdkR09MU0Y3TG5ieFVpSC93?=
 =?utf-8?B?STdXSXRRK094M29LWXlSVUhuTXpveW5tVnRmejFLZ1ROd2NjN0VmdDBjVXZu?=
 =?utf-8?B?V3pDMXM0d3BpRm9WKzdPei95OTdnaVAzRjhndEtxZVVxaWxiOW5yMGZHRWVs?=
 =?utf-8?B?aVdOSEtzb3JnVFgrak9BMzZvSzFHRHJ1TXQvZjlUeVJiUitlNHJzMXNnWndM?=
 =?utf-8?B?eGFBZ2UrMXozMXlTbFlodHF3UEpBYUpMUTZHRTQrY3hoUjNnS3VIVEhsaHJ0?=
 =?utf-8?B?L0dVTVJab05RZXhTaHd4SVRFVEVmbnpncm1JODhHQ1YwYWg2bjdvM0RSRU5i?=
 =?utf-8?B?bEZnd2VWK1ZWSWhTSWlzZ2trZWpHTzhCUDJKK05MNVU3ajFjYWpsd2VtOHZh?=
 =?utf-8?B?WDdyaUhVSFNxNkhvNG1jeEp0dkxoakdXUm1NV1VhYkFRejNQbmI1c1lYU1RK?=
 =?utf-8?B?YnFZbjlFL01DK0xQclN6cUNZK0VGOGxLamZMMWVJcEV3S1ExMHlNOUZFYkFy?=
 =?utf-8?B?ZFoyWUR0MmYvOXkyd0RrLzJWRHQ1YnhEbDM4M1hJejJoSU9tTmd4aDFNU21R?=
 =?utf-8?B?eWpHWjJDTHlPcWJiaFFjdkRzRjl6Z2tYSzFOL1BlQkVtMk94YnBqZUhrZkE3?=
 =?utf-8?B?TVBQenFoK0NuZThKbXdvRDBvUkIrUEpobjA5bmNPbTZHT1BwdVdORUI4bmdq?=
 =?utf-8?B?emRhU1hKT3d0ZWxYSVZKQlJHampuVTlaWTNPdGxlRnNvZGVZZHZkWkVPa3Fu?=
 =?utf-8?B?cTFTUWlYTzF4WWVkWmVWUVZoSVdZT1hDZlArdHRTTUxmUFQvaWJNN3FpN3Rz?=
 =?utf-8?Q?s4b6Hb900+KHF8ZpznJxI62DFK0Q7YLIxSw76Ab?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8582fb-277a-4f04-5257-08d93cc8aa79
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 19:44:40.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itiJWx9nbfah51GgSeRKB4ynOO7xG+01t2jBaTzhhkGwwdJI2rkxzkYL0AeYW1kXnCLyfeuyETX0wGw7TZgO0cu0poFBj/Msn9+V3XnkzHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10032 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010114
X-Proofpoint-ORIG-GUID: OzZ3riYYS7xOGYCQcNPzHqMI3qkUyjlv
X-Proofpoint-GUID: OzZ3riYYS7xOGYCQcNPzHqMI3qkUyjlv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 79a106fc6585979022012e65a1e45e3d2d28b77b:

   Merge tag 'drm-fixes-2021-05-21-1' of git://anongit.freedesktop.org/drm/drm (2021-05-20 20:15:43 -1000)

are available in the Git repository at:

   git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.14

for you to fetch changes up to 5d299f44d7658f4423e33a0b9915bc8d81687511:

   jfs: Avoid field-overflowing memcpy() (2021-06-23 09:21:52 -0500)

----------------------------------------------------------------
JFS fixes for 5.14

----------------------------------------------------------------
Huilong Deng (1):
       jfs: Remove trailing semicolon in macros

Jiapeng Chong (1):
       fs/jfs: Fix missing error code in lmLogInit()

Kees Cook (1):
       jfs: Avoid field-overflowing memcpy()

Pavel Skripkin (1):
       jfs: fix GPF in diFree

Zhen Lei (1):
       jfs: remove unnecessary oom message

zuoqilin (1):
       fs: Fix typo issue

  fs/jfs/inode.c      |  3 ++-
  fs/jfs/jfs_dinode.h | 14 ++++++++++----
  fs/jfs/jfs_dmap.c   |  2 +-
  fs/jfs/jfs_imap.c   |  8 +++-----
  fs/jfs/jfs_incore.h | 12 ++++++++++--
  fs/jfs/jfs_logmgr.c |  1 +
  fs/jfs/jfs_txnmgr.c |  2 +-
  fs/jfs/super.c      |  3 ++-
  8 files changed, 30 insertions(+), 15 deletions(-)
