Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C863E8B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhHKHeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:34:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28530 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235177AbhHKHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:34:18 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B7VSVc019662;
        Wed, 11 Aug 2021 07:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=3U0HbZI/0jNieu5FDDvRFz6a9mBk9uXFHEV+JuYRFtg=;
 b=nfJvHaNlSJMHmY7wiYNWY0O2RHqanWtnVlhcGbENCqyP2SJvS3o4Hxd8clsKQBAPE30R
 M7YN/KoMZyzXTpmND0S2flVW1ytYs37AnteU/67fKM+CWPNeTIJGiFwxzXZRRXN3VHS6
 xAEgfs0X2LLQOv1/qF1jNNuOSW+matDPIErjxLwZIru2tXm7QDcf8C/tEL5UiDMRxDDv
 dHTGOBXkqIsvF2xSebUyyve1ZSJOdptEnHSIBtAU6V6Nsmf5GqvwJw7Q/GzAri5G4tAO
 ofrC3kEl+7m4o7VDFnqvbCmw51F4OlMQSW0GNSU3EybzWuEyGlEABbe3bz9icCpyfuOb WQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=3U0HbZI/0jNieu5FDDvRFz6a9mBk9uXFHEV+JuYRFtg=;
 b=ydTGLrm6NMHe3ec2cuMYiWJShVA2g/sz+vR7is3yq7XLsioDjUAgYPdfIUlgm0T5Ncob
 v6mOMZC4OzwIUukQakyQ8ZjDh1fzyozAdoA0W5g3fBbzQ5o52U12LoAQy8cljP1+Wajc
 0Qon9Tj9TjwgXV5FHO+1P1GW3hE6rZj0nm0RACiJsVqjYn4Pf4wAWYCpp0SV3cw03O43
 AeYmdLZmel59GC88pk0tYg32VaQdK3LrYKUwBYU9ycTj9rZ1S5zmW8nprp9dVIY23l1w
 PIsi8ZWBNXViN1yAzI9iHbysrLIWUSnIE3fxWKpistpcXbHzMfq40NriZPdL+MDgp4Dp Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17dwdcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 07:33:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17B7UUCT175108;
        Wed, 11 Aug 2021 07:33:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 3a9vv6391p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 07:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW5u8Q4xqVpQoUDe64/5q/239KvQ4xgxWBAeu1Re4ZBQIfl7UkrF/h+iGZkvAW9DFIudQxm/Mz66qAMtXoEjBQHaWi+3Tr+YhCto88geb9DZKyglr5TQuHosJbKWUo1bDmjQmwPz2q/I/oQFNmun0Qn3eI0nRSdEWbLFGQwha/e/wCKSzP470igkWy6jFf5gIVsKFZmfF/hpkCqq9ai0ER4X39m4koY4VNjY6QOHmii0U+yg2+BUbsQge5xr2+zIXv/+H9K9NnKKBs3sD8UnKaddYW1GqwdUz1yqPzA0PRfJVWmbWH8w+0pWmrecGUBHRWHf39fLjaxTMnnDYe+/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGa+O5H7PEVFWcE0/ASI26AVqwAK4S2yGLkRoz9aAJo=;
 b=cvn7E7xACgfOPhZGYzRDEIXeoUdTVd9uwcwrBo0Nrk+03Bpe+rfwf9wZIS0FxRlRg5WxcmK6/z+C6WAoKsgPnZH2Ar+OTkhn+L+iGjzdcP7J75IJym/VFmdaSyILIyx9MXeE/2DiQLhKtROhEERYSOSSfGj+/xd184EeLUGtbRLhuYeUaDhEzCOaej1BFaMnfQ1yJ1E6OK/hdAqtG/0NmL21ejMBwga3jjqbU4ewISEF0N50nLxuCI/I5+7wbiKWcAkPl4zHF4MkouCMCpof75Zp2MkBDt0ackOddHuPn2bU65hybZbWEM90pQDg1DW9tKy4Ik4vw3azb65j5ec0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGa+O5H7PEVFWcE0/ASI26AVqwAK4S2yGLkRoz9aAJo=;
 b=IRfeaBFUoFPGAYMaII2gPcdJdFu3wYHb7Ug54DFqG2H2s3Q2ZQGt/Ru9Xdgw3h++TjZ3E/zkVAiK+N7CTUOfzEAouQG1mk9A3lmaVHG6nGTvjQTtmx6yFRHwD8PER3At/z1g0ywN7EABuq8yaBIcJBsWtBURf32Qr03lPyTB2vA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Wed, 11 Aug
 2021 07:33:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 07:33:34 +0000
Date:   Wed, 11 Aug 2021 10:33:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tuo Li <islituo@gmail.com>
Cc:     gregkh@linuxfoundation.org, will+git@drnd.me,
        davidsondfgl@gmail.com, zhaoxiao@uniontech.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Subject: Re: [BUG] staging: rtl8192e: possible null-pointer dereference in
 rtllib_wx_set_encode()
Message-ID: <20210811073311.GT22532@kadam>
References: <a86f508c-84b0-3523-2a8e-6710e35e5bb3@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a86f508c-84b0-3523-2a8e-6710e35e5bb3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Wed, 11 Aug 2021 07:33:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1acfe90-b8d8-43d4-d7e8-08d95c9a52d1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4754E4CD753518AAE614FB478EF89@CO1PR10MB4754.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYlTKKPyBH2/rccvirPhtBhcS9SnuKh9SwrSYT6lXjgIwdqU6pvh6fXPgWblMFMg5EcE5ZAqLKpOqyP7nzPZdN/YjwC2x9TvI81tqtJC4TAUapHf0lYdAl4gXcIp2WW3BCWcvyDgMdYDwWygK0ncLnaVnODnh5Nv58fBaW6VJRE8IEIEmUTW47lCiAtUgOY3U+vz0IrXyKRFvgxr2UhQx5h7skjBLUPuPXE2hdIy1a6an354cGooxuFpz8IaQbeltDX19BbJsWoD6UzwCXcalBEXB6jA6wGQTjVag9ejXKtZP5Yj3xy0Dr87LfCClFXgX0iEul/fO+wIZlu5JHTYy+8DzHqIBbxtsiCR9n++GUAkzvsutWobkx7evivEA/5B+9rk2KSkUcjFuuhXQwWwAkpaeQgvWOCUO3t+StH8/PwVWsFtKrTiQrGQF7B3HYSLusa50hS2XO7NsLGaje/AeEZl4joCBXDFg8XqB38insLiUJ7fUDoZPkc8jhuohoLOPMuzrByyoA+GagAZ8yl9WAKrYuOfbVLVJbDhLN2DakEs+MFvL/FjkkuCYDXzH0Zq1y+j96J6Kd0YkgUeSqWP/FTWe4Gc3y1xaX0A7mwkHX2lJKgqkhAexVcaSwToMgn30loR3pbzWgAzUApZgLIwFTaQRqVUFnWiz2cb6JOtX55yNdPcwBW3ylJHZDW1T6fhD/IsFhAfHK/2kNdHaJP0VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(33716001)(6916009)(956004)(66946007)(38100700002)(6666004)(478600001)(66556008)(9686003)(55016002)(186003)(4326008)(38350700002)(1076003)(8936002)(44832011)(5660300002)(66476007)(8676002)(33656002)(9576002)(26005)(316002)(2906002)(52116002)(6496006)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hSZuxj1x1dSQcwD5AESi+1VWtrfrMz9MZLr8izhYOj1zQex4Qh8d9yzXqq?=
 =?iso-8859-1?Q?/GEzLx4T6CagCF2qEc6tMPurL1bmCdf79ue6ONHHWLeXp0cRzEV1jWKqKw?=
 =?iso-8859-1?Q?M2vEKXXGxlMwdFiBB8p0J2rbBQPgXHJRVI3eHiMa4tAV/HIYjlz9rt1myI?=
 =?iso-8859-1?Q?525fDDiZ0pyTOatjDdm+oJlIsddxEtlbAXkmaahbv/GtSN9B1bVioKJ8mE?=
 =?iso-8859-1?Q?BXKx7gKA8duZuZHH/vXs5HbYfGCRetsP3MGY7PjMQGhT7mjxfI6rVCTKNI?=
 =?iso-8859-1?Q?008rdJx0dwGFF0V9f6zJ2UtNns1js4McJPI+60U0GbrHgY1cPUu8tPq3+9?=
 =?iso-8859-1?Q?2ySRl+dTPu6/212IZITSeaEp2ayuFh6OT+evHyFBc8AxNBMVvJJheVeFtg?=
 =?iso-8859-1?Q?EegZ7rABWz/x+X3ACyjR2MULmN7zGXBHUgsGVEwBNOWLbWnDMxfPzdfdBA?=
 =?iso-8859-1?Q?Jg9ulYN5RMSXsk1Y3oCr+DbbH7ElZS5rXxP6xuerz/wnOQAlIJCljIquvZ?=
 =?iso-8859-1?Q?Wl7qUdken771y68JbW+12yqEA0f83tYBoJRWXeHSEH7/w0Zd9wCUmmJpje?=
 =?iso-8859-1?Q?vSkGk+r9FMRA7qA/VKXXdjn/DRUKPmTpBB/A2ih+WEn6AgZjvhk4JYlsGB?=
 =?iso-8859-1?Q?Wkd2jG1Wxdm2Suky3vNc9Kc1FPlJllCLBus58ub92nqHUHcOiasB4mgV2E?=
 =?iso-8859-1?Q?UMH6phRUh7+cEbRnSD+f/WN/cxdEiQZsUkma2yZgLYzGLqpP1Gq5qXqGqL?=
 =?iso-8859-1?Q?IZ/6XNHB2CokTA3oYuoxjjUL7eaXjDt5PLg+wyREEjXltHb2w1m77+VeHI?=
 =?iso-8859-1?Q?+nLYgIJChvrbXj5vjd4RV71oElNQrR4qUxzM2SejEeJ6GESck8Lh8B9QTe?=
 =?iso-8859-1?Q?eKN6J9P8mqfqihXgn9tLqszenNWLLsemXq92Xrs+nl9NqPw7PhEetsVqO6?=
 =?iso-8859-1?Q?bnKhXliRtTB/ghWhh+cIlsMBPeln+tP9XAGWKX0IG3x/gh/YV48g/oDBDl?=
 =?iso-8859-1?Q?v5NlUR0gy+Xo71XuT8N5Z1BXz/iJioNoXP7Cg4Fy7/I44U5HfutDmxgaQ6?=
 =?iso-8859-1?Q?C6c0I4GBDflwLQJSIvXMQgrleBLXzLmzGsQfHskSFqb0e4injn0xl4OURo?=
 =?iso-8859-1?Q?gNMtqGD0e++D3LJfGxSitpj2HwEfpZBlzsp1tYj4h7g6lxtPIvHX50KrM5?=
 =?iso-8859-1?Q?8YxA1b8Vpbg/1JjMas2lxe7USFe1D5hiEveN1fWzDG5ltzpvEDmGymlo5C?=
 =?iso-8859-1?Q?7PhXE5LejI6DH0NT5klCr339gO5Qe1d1BQyu00hEwpKIs2yEJcvZSkuvZ6?=
 =?iso-8859-1?Q?yQFtcQCYTT+Z6FNDqjONPvmAK+Pqr2VLNroy0UpRsw/ksyYzOREWZ/EyeZ?=
 =?iso-8859-1?Q?wtc2QkB7+G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1acfe90-b8d8-43d4-d7e8-08d95c9a52d1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 07:33:33.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ8iimwzyZnhFwTc2m9k6AgPoLq4vhVdT8irdybN/8kyc+nxzUdAY8ETXAlvSmTJFyXvjpUshBvM7K8tW1RhFZbYndKloZUGPMsOhcxURs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4754
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=903 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110048
X-Proofpoint-GUID: 9c0PMfCeKyi1XfzGjeJRZVimI5MLpADK
X-Proofpoint-ORIG-GUID: 9c0PMfCeKyi1XfzGjeJRZVimI5MLpADK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 11:33:57AM +0800, Tuo Li wrote:
> Hello,
> 
> Our static analysis tool finds a possible null-pointer dereference in
> rtllib_wx.c in Linux 5.14.0-rc3:
> 
> The variable (*crypt)->ops is checked in:
> 342:    if (*crypt && (*crypt)->ops && strcmp((*crypt)->ops->name, "R-WEP")
> != 0)
> 
> This indicates that it can be NULL. If so, null-pointer dereferences will
> occur:
> 389:    (*crypt)->ops->set_key()
> 400:    len = (*crypt)->ops->get_key()
> 
> I am not quite sure whether this possible null-pointer dereference is real
> and how to fix it if it is real.
> Any feedback would be appreciated, thanks!
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

I don't *think* the check is required.

The data in ieee->crypt_info.crypt[idx] is set in rtllib_wx_set_encode()
and rtllib_wx_set_encode_ext() when we do "*crypt = new_crypt;".  (The
line is the same in both functions).  And in both cases ->ops is
non-NULL.

So probably the check should be removed.

On the other hand, I don't know the code very well and it's possible I
missed something.

regards,
dan carpenter
