Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4E42949C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhJKQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:31:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12984 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230102AbhJKQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:31:15 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BFi2Lj032253;
        Mon, 11 Oct 2021 16:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XgMsIkyqXEy20LVLj9Hof4Q4SmDaucokLa5hz5HcovE=;
 b=d1xVcELGYfRX2+Zp3QX8BO/9Ccy8TpkYuDoZnQHKSGtSEOiR30jaLqH6a/8HDnjrd0Ol
 NSNKd+m2cvwfaEzrAqrXlABEHT9+njWPwpo1t+rd9Y/wxnB6/xqDe+AvvlUIhLrRWw5H
 bt98KnfzKgIq3eyX/56lQc1e+m4BSCSBBmmcj9gROXwdelKgkIlhQ6JVhMkzN+EnqKyd
 undNuBNdjQwwqrmWXxGQ4BrrTG/KTqpF3l8+FDzW51pXJBl+TfPJc8T3nZHS1cJ39Cc0
 IBgoTYi8HXjIpyPxKT6fDHdxNfFigZBSfCOiKcTTG98TDfAhvrIWOeW04JEpekCk+4tI 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmq29gy2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 16:29:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BGB8xp195794;
        Mon, 11 Oct 2021 16:29:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by userp3020.oracle.com with ESMTP id 3bkyv8h95h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 16:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atdQGiVizMO6uxoM8qXRhpDHxkBEAjXZP0Dr3HB8xG/kJgG1aU6M7l8+lGypFBk5m3aP7P1HUBvVl6ZdcUI+u/OHj3gvP+yl5Nsoy2AjBpOQZjc5VBWvFDtTpAaZjR5+3MLf6a4J5lQliKSpK4XhhTsMwI+3kUqevHLJ+vSPGjc50xmx2cJMkENvGJi4/Lns6XGWyWiqJCWr8brUq+JCAUK1/Vgxp+TfuzBsRrr+9EERnyMNL+ZCCbQhoRgqnH7cthKNpjLGTNHAXysh+b16EtEq+SQQaJ9SM4SXUjUVCvz+jfEvnM8Wso3pmK3dIrSaI4ZpNu52IaJqJ66sUSf8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgMsIkyqXEy20LVLj9Hof4Q4SmDaucokLa5hz5HcovE=;
 b=fQ9jivVdvqXKrQBcweDw4rwVIw0bbS0gXV7QMjiXxWuy4CcX6Ey3WmkSQumlHHpxBxaIMZRYpOh5FwhXnAtc0LAFX4ReymNkJEbr2PDBZbhSFDrQqC8nT1cgyw0IJ11aNQHVisteJzuBS43TXpz9z7oiZRCTAC4peCzDMEWgbwGdOqHFgqjqtSwCrP7Akl9yDSKP8UKb+K8aJUdAnUo7tdBfo20zkIblbbdXC9lVt0Gdljwj9MbesdcuB2h5Hck6GpCtLKjVwFY9q0NqgnKkIFRP72tWuamr+GN/LfJWnJjeJwjIGGqYeMaQasgKKxj2wZf0qQFvfalu1BG8qP1jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgMsIkyqXEy20LVLj9Hof4Q4SmDaucokLa5hz5HcovE=;
 b=ZCklUSish00ufphjYf/bCacuMlvVrgxUUtb8l0I1NueCZMCoNs5jvHa78bV44noBP3h5m3s92X5+3Cr5lbL4ciWRQ9oT1iQaCgpm2l4cxH8p1h/In7LJUyqNX7mPEPbapZVd6KZ1BfOMhNVAWMs4kreHJHCYFJcUhPZt4VJXaQY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 16:29:09 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::958c:1aaa:ad5:40c6]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::958c:1aaa:ad5:40c6%8]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 16:29:09 +0000
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211011151443.12040-1-vegard.nossum@oracle.com>
 <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <47e60186-2408-19cf-3231-92bd9c30483a@oracle.com>
Date:   Mon, 11 Oct 2021 18:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0083.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::23) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
Received: from [192.168.1.13] (86.217.161.200) by PR0P264CA0083.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 16:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d92da99e-2c8c-4f27-8ab2-08d98cd44029
X-MS-TrafficTypeDiagnostic: PH0PR10MB4552:
X-Microsoft-Antispam-PRVS: <PH0PR10MB4552A3C16369C19A1D88DDF897B59@PH0PR10MB4552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xgw67grVPEaO1haTIDz8YDDJOMZIMeHcg6beD9f4Cz2xLaK7R2Gf7BrQ3cFz09ueQzN6PGIgQx+gFFPLXOOLQOM55984NB6Gamb/iIWIuEiNJ+cGFJUoaLJOjXqWZMy3thlYxt2VVgd3cetJzTNplIVO2nonBmivTWefNvmPAAV6vc70JieWXFvBoT9p6Jbk03occIMPu2Mf9VR1VSOhYVwEGVgNfZGTaWpITxVFKc1Qtu8GS28CyEyGnD/yL+gW6wBOkzaf2p88SRhSrd9+gipzG4q4Kcp0xFtcw4Q7ptoW1VbsbgYeBgzFZfGDUWjUHZv29fYdvPL1kCBdKmoHzbUCSj2/hvJsxSi78zmsroclccI0MRcW3p+ox57rOXvnkXgLz55VmP3vwe3zj1jRfxlZ3j9e3YU4VSQRid/2wk3TW5FVhO7LfejPQRwRyVogxU6D49wvj/2/paqCIiOOXPXovB3gdD3pep/ljjlnPjjoHrPdN47WIJ/6CV7UG/Hsx0AKO6KqgFG77ngr3iIkZU/28mst4N89HpX1xdBOwobbdUy8pCRc6iYZNeyMVhOt+hDwcoIgfGfgWU/HaVZId8MEBgUgiO98dVbMTFA2iaEF7DCsadyLuQRAo1QDnDb7FUriwIHTb1tWsZh7Cz3wAlL/lvegvZIwCAt+0JboRWzdPOqmJQtN0DXxhOh37avJCw1eH1Fkuig/C+zL9cFoO6XEdPMGe3u6YVEsvAL8hT2CItL+3kRbfV1MVCvCiSZkmUUeb1q2K6L86RJIppqgVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(38100700002)(83380400001)(8676002)(54906003)(16576012)(8936002)(44832011)(2906002)(316002)(66946007)(186003)(86362001)(31696002)(6486002)(66556008)(66476007)(956004)(2616005)(31686004)(508600001)(5660300002)(4326008)(26005)(6666004)(52116002)(36756003)(6916009)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZneGVZQ3VKYWtWUi8vNzZqQmRFZEo0NzJmRzZpNUZCbUsvb2xwaEpjY1Zm?=
 =?utf-8?B?d1lUczE5STg3dUtiTm9MTms4YnJiVk1QVFB6OTRzeSs3OTRXcTdrVTIwZ2Zm?=
 =?utf-8?B?c1Z1MU02dEJ5NzBDSHpmZFFWck4xZFY5bXYwem9MYzkreEh0MGsyN3RQYzNw?=
 =?utf-8?B?eWViYzE5ZTV6ZWFybVF5WjBzcUxPK3Vvbm5jZHlCNElXV1JrZ3N2cVVVb1Jn?=
 =?utf-8?B?NEYxV3ZmS3lnaVBPTGo0azUxcktLU2tVaFB6Q2xzMVI2R0lkbjVsWUtlV3JP?=
 =?utf-8?B?OVgvS0VvWUk3SGpONVR6MmpQSjg1ZjBzSWRGSHVjemZldkRicFdObXJObk96?=
 =?utf-8?B?N3FZbUREWHlUMEMzd2poMmRTNkFLK0Fpb1hmN0dhcThsTUdPaDYxaHVBR2s5?=
 =?utf-8?B?TWpZbVY4SEdmNzNIb1AydFg2L1AxT2xPV2FWeERvSG9DSUxvcms4OGZzdkVH?=
 =?utf-8?B?U2VMWE5zQ3lxOFVqdEFYQXJVaXdEaVFDMHVnNldFZmhwL2tPQUhSazBkdUJy?=
 =?utf-8?B?SjhtVXlTbERHOThZMWZpZC9NTGxDOERySCtWWEp0TERRdGNNcVFycXRMT3M0?=
 =?utf-8?B?b2V0TnI0MFMyUStFaXRWcEVSUG5jVnNhSGZNQzRKSXptRDQ2ZC9FQ1llVVhP?=
 =?utf-8?B?d2RKSTNhNXcweDNOK0gvS292OGh4QWlPRXd6eTNwck5zdGFTbG14OTV0Qkh0?=
 =?utf-8?B?c3RBdjV1QlpYN1QzN0ViUG5QZWhBZlVhN3hDNHorendwemYyS215QXNkRVdP?=
 =?utf-8?B?ekYyR3p5SEtGd3RFTFFjMmFITUdrb1lWWStQR2VvNzZzdUpZZnlrdjV1RHBE?=
 =?utf-8?B?QzM1VDlvSDk3TnFtc0lKV1hVWFVSLy9XQVhLUUN6Q29iSlRBN3BpVjZySk1C?=
 =?utf-8?B?UStIRFJhQXg4VFVtMVhPZ3Q4Tlp3MXF5UWpibjZzTmpJS1BlckZNdHp6cTlr?=
 =?utf-8?B?RU9RTEdFaWVkeUo1K1ErNENBcmlxc211eW16TDVjV3d2SkgyeXVzcmlCaytW?=
 =?utf-8?B?VGtpdWlEVHZLbkovZU4zM2o0VXJqK2NOQmpibzVkWFVoU29na0MwSlpvRXVz?=
 =?utf-8?B?VWM1TVdYbTMzYWprRkYzdnZHejBLeUlCYzVjV2FEd0Rlc3htUHAyMC9rbDVo?=
 =?utf-8?B?MGt5b1o1UGlLRldOcExaZXBKRXFyUmlzaG9MQ3M3KzFLcTNQOFUvTDloSDFJ?=
 =?utf-8?B?L0M5TTQ2aUV2UFJyRmZKVktka1ZNOHY2UEVmU3NIWHNnZGRqdHFOUzNmOUJ5?=
 =?utf-8?B?SVh3REJjQWc2NWhqRG85Yk5BN3poWERVY0Urb3hiRC9PYWZFNEdNRnYxTnJv?=
 =?utf-8?B?MlNHaFFIRTZvNnpqT1dkRXhGRjEzSmhYcHkwMXB5YkxBdG1kcXZwZkZKMWRp?=
 =?utf-8?B?cXZMTitLWkRPVVFxaElWM3MzUnFHazhzdjRVVWx5b2Z3TWFmK3lpOXBpQ0xC?=
 =?utf-8?B?N0dKeFBJUERZR1ozQlJEdFdCSUh2b2lyNzZYVGhSL2llSStXUVdac0NQTXBT?=
 =?utf-8?B?RDJ1aUxXdnA0TWxBM1Z6VklIYk5ZcjU5cFdJVXF1MWdDZUk2ZkozQVVhaFZK?=
 =?utf-8?B?MmIyYnJMeGx1aVpLOGYyc0RRdDBmcUNxRUJNbmNEMjFyMVNFTlZ0WXgwbEo4?=
 =?utf-8?B?RDJ6YjU2WE90cjlZV3JpRG9UOW8vbDlnNGV5ajA1dERLTmJSMDNkYjF1N2Yz?=
 =?utf-8?B?M0o4ZUxGN08rTGx2dTNjbFJPciszVmRiTks4QkhSYm13a1VmL1NHbVRGRU1B?=
 =?utf-8?Q?j5AyWF48Em/dVbsZvrCKiQeZIXHN4YtkR2Swg9X?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92da99e-2c8c-4f27-8ab2-08d98cd44029
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 16:29:08.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Df5CHGDF6t/3oNPU01E8MZK/mNLLtOE+FwNsjD0czRjiOcTuNXDnOzRaLH7Z+clxj1PPxtfw17Dn8bYAALlMm3AoOp9aXND6oli7a1geSmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110096
X-Proofpoint-ORIG-GUID: GXZJpH77_sWZHIEqryoH6KVHI91ckPb1
X-Proofpoint-GUID: GXZJpH77_sWZHIEqryoH6KVHI91ckPb1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 5:33 PM, Arnd Bergmann wrote:
> On Mon, Oct 11, 2021 at 5:14 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>>
>> Fix the following build/link error by adding a dependency on the CRC32
>> routines:
>>
>>   ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_dynamic_request_descriptor':
>>   firmware_if.c:(.text.unlikely+0xc89): undefined reference to `crc32_le'
>>
>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> 
> Patch looks good to me, I wonder how I never caught that with my own randconfig
> build testing. May I ask how you found it?
> 
> Fixes: 8a43c83fec12 ("habanalabs: load boot fit to device")
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Thanks.

I'm working on a couple of new make targets, satconfig and
satrandconfig, which can generate .configs that respect a set of choices
specified in a .satconfig file (and, of course, the Kconfig files).

In this case, I was just doing satrandconfig builds and noticed that the
crc32_le ones popped up quite often so I just added CONFIG_CRC32=n to my
.satconfig, which means that satrandconfig will generate only configs
that have CRC32=n.

I also suspect that satrandconfig samples the configuration space MUCH
more uniformly than randconfig, in the sense that "make randconfig" will
tend to have CRC32 enabled just because there are so many drivers that
_do_ select it. (Think of it this way, every prompt for an option that
has "select CRC32" in it will be another 50% probability of actually
enabling the option.)

I just tried doing 'make randconfig' 100 times and the result was
CRC32=y every single time.

If I do the same for 'make satrandconfig', I get the following
distribution of values:

48 CRC32=y
10 CRC32=m
42 CRC32=n

That's probably still not really uniform, but quite a bit better, and as
I said I can still put CONFIG_CRC32=n in my .satconfig and get _only_
configs that respect this choice.

The really cool thing about sat{,rand}config IMHO is that you can fairly
easily generate random configs that you know will be bootable (because
you've forced it to only output configs that respect options that you
need to boot on your particular setup).

This project itself is about 11 years old, but I made a breakthrough
recently and I'm polishing the patches for submission now. I thought I
would try to fix the breakage that I could find first so it doesn't
appear as if the tool itself is broken... (that's not to say it doesn't
have any bugs, however!)


Vegard
