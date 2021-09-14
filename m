Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22C740ABB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhINKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:31:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42974 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhINKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:31:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9cq41024454;
        Tue, 14 Sep 2021 10:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=TFYNx9ywUXmRsN2R2w44FbJNa75Ynqgt8UHgkFo9vNM=;
 b=rHGAqvS8Zn6JToU4ok5qtZlo8DGMzhxUY3Dtq27UEN2GncoLPN4fIpuZlQNrBgbEil+p
 AOqIVsqhl7WVwPdoVdr9b0K9bv4RBKa17NhUOi8rEtwdBsZIi9KlbGIkcauWNA8AFKEx
 D/NZiVVNKKuWohHNAVxmvgBmG5Tox28mGT9JR8phEQMMAB+2aaqKhXg4lij+GR5Lueit
 aBsXB2NgFIGLQz6CSJ2ATLtEV7PBIstNVSVCCh+5YvH8Y4LLFEwoNTboM/k+7ntvlZFT
 KW6cUwcPb8AXoh1keOGDcr43lUi67C5yLj+qVnCtHVs8KoaL41wYC36mL8eCE20S4wka Uw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=TFYNx9ywUXmRsN2R2w44FbJNa75Ynqgt8UHgkFo9vNM=;
 b=yS1+aWp4HeB+SAYs+2TS0P1HfPpsbtaPWvmaPDK47zQpf/UeReXIiZhMz4BxvcZQ7aFX
 VI00URu+S7sUPRkaFld4zm9V4HwEzwacmgM1BhNhCbnoVM+YZmQgbs/2zXXDRf8cygkU
 euhGEL96gT/CJdyhIbQOrVIwhyTQdCoIqy+GdPLs15LMF9ayA3Ohljv74oO7VT7aEaoX
 XwhGADT5lXRXzTcU3TmXfQ9sdi9BtU745r97vwgyJIvc5qTKYTo8hH+fyh/YczJQdyJr
 61yww05YjcGVWUM5trxmIg/nTLqkC8CUs3zDCTjIXCnNODwjepCYd3y5rUKPs2AmrBSH Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2pyg8pr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 10:29:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EAFS77022810;
        Tue, 14 Sep 2021 10:29:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 3b167rv4fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 10:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byK1jYyihet2QNgTqtUZ+/3VXYYruONMDMv0xCOKXuzACcLz68NR6jpgsCL0z57QupwuFmZjxz6fHaUIRjnDK+ynpBv6AuNEjhLS2srKxufCkQ076xHwlZOAIJWYj+VIdguVYtDapbklrvSae6A9K6yXxajEYZ+mWilW+G8asYUZIZp72QPbmiXo+ndqM+HrAxWYQMbkZ7ohz+4WTAP8TmANYAC8TDFgT3fZ7B1ERP9QikbT6YP0LH2oAYCS531Prh3uhwgFL4PCwDA9rH5X8RtKnt/bwzqkQu+b44VjfDjgS9gXKsA6kKyHQ9s3b/3etBQK2fL7L8qGlK55uaNdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TFYNx9ywUXmRsN2R2w44FbJNa75Ynqgt8UHgkFo9vNM=;
 b=XyhfWIgqkTYRZbpxnaYqZdfHMeM5K9n4bJR/EuJdot9jv5L/6nPC7ZvqyWn827gTLawxMo8DrGrhAa7oDTFX4QWUC8gqSsne+WvLeX8ecVWoUU6usOWsxRMEgHV8IRJpOoM1P/8qqV7f8iKBzAMDp20dIpSh+Ejf3VUmgUAVruW2NHdSZuDaUlT9gDSGVEk28B9lrVVyK5Z+KUlX0yv/EeabNuuwLichF7JM7oSjTFTEBgOnsHYhgBcCGDZlgSj634roABNiw4yQjPHCr8GS9FqSK7aAaB3KxW9+DIufTAtY/FRpl4dRr3mHyrhjYIxqDH0jnnYssoQNUzumTnnS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFYNx9ywUXmRsN2R2w44FbJNa75Ynqgt8UHgkFo9vNM=;
 b=DgDRGgB4cq2lwNQj+bRcMOgrcjswQjBi3F6fw7UzJA9/s85LpoxOsNB4lDJFGK9+wkIlnhdbq/UlTj2AuSeJ+XlFxXeL73diMDRSUhn1ovqcF0RMctkOdibeyMTAOnXKUEWWYSAsQJcEAsxzGvjvnAar6yMA4U2SR97lmIn6vMo=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 MWHPR10MB1886.namprd10.prod.outlook.com (10.175.53.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.18; Tue, 14 Sep 2021 10:29:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 10:29:49 +0000
Date:   Tue, 14 Sep 2021 13:29:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Huang Rui <ray.huang@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rui:amd-pstate-dev-v1 4/19] drivers/cpufreq/amd-pstate.c:241
 amd_get_max_freq() warn: should 'max_perf << 10' be a 64 bit type?
Message-ID: <202109121736.omuuuQZR-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 10:29:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7237401f-84ad-4998-9d23-08d9776a9452
X-MS-TrafficTypeDiagnostic: MWHPR10MB1886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB188657781759B6942AF0E2258EDA9@MWHPR10MB1886.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxUjOjjdxZbI8lv77a1/wut2neRu3OkSwFdy3uwzSOnlhpCrqwTnscdei7tTYnWbhSZsQzi/wkixU1QN+chIZhJ+8SXomEiWi+MCSFfMUIGghi0sP2o58IKVl36x5Wjf39fo9nycWtiX/69q9LIw5nYIAFns90DD/3Hibj/zzSVFh9lEReonj2nTxHQx4skERv/+tDf2moHQROS4ZZ6tjtt9r8c31oBjPTozHlKXcUxSDMeJigLZQ5aBm4GoM7pX9ma18RF8suTmv1mRSLsRD6wTpF43bj5LYeonHUlU5fM++fzHmx43Wn1qJZqNNSDaSkyhPT6kStzeYKna8u8wkpB6EPPKG5UYHx2lb53o3cpeSeUqQn28RukXaJynH6f0rB8ZA05b+vB3+oq9thvRF9pOfhjBCSd1KtH8B6sB2qaBXL3tO1uX56VcypLsYbREYukbEopnnmuPkk0sMy/+BqTQnt68k0FkIvg0/9XVbujKf0/C50iUt7VFBbK6ZprTqBM1li6BlaxZUykEmZS976R+SDo6arbTnYTVAPnBsJ1MAwQjbD9S0VFUbkzV1UnZSTWI/KBXiv2BBODgy3C6EGGsFyX5+BzF6WFOpEdJw/lUjnNL82OB7vZ8+STG+t8Y9ZrHsEoA1zXQG+XwM5VtBIQGmNb0KvUD8WH64l8jtgC4UhCr/8fxEhRujAkOE/7jcioORBDluuX6uoKdSs7jzebk48Luhz9qJhw5RTEVZhpkc1z6WeLnuYkhD2s/Dbmt+mK6cv9IRVXHA9IKKZ+QeS6CnOd0a6/diZxbm2Qx1oobC9Usb3qENx+OOCOr7GtBwZCAxtxTcXApejun9rIvWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(6496006)(1076003)(956004)(66556008)(316002)(66946007)(6916009)(2906002)(9686003)(86362001)(38100700002)(26005)(52116002)(83380400001)(36756003)(966005)(508600001)(8676002)(6666004)(44832011)(186003)(4326008)(5660300002)(8936002)(38350700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tORBr82cmNh06f4cY29Ul1fPxiAOat7BzBgXK1bhWZA9Gphdv/tPEmDv/Y3n?=
 =?us-ascii?Q?Fx/J2tsJ8VafsjefL8m1zxa2gqIDVugSE70LycAR7o/Il6aimsi7fzh60x0C?=
 =?us-ascii?Q?Ne4nmE+ki8zS36nToL9Gzf+NEwFBxDaPnBUhXJ4/9B8hMRz0SSzk3r8CmoLp?=
 =?us-ascii?Q?HeXzMaeRXSzCL2SqOe+2I9KhHB3POH3hbpOmWwidxp+axETOiKsBi8aoZuMQ?=
 =?us-ascii?Q?LyBYl6U/mg9L96UCyQYTpQQlvEfSTUSqz6BdzL1YT2CJOljYvODGTXQGWFom?=
 =?us-ascii?Q?M2Fb/nFpZd2XV0Q11HkfflB/Bd+IW7/UF57uQxwkw11tDVVz3LBld2CwVijP?=
 =?us-ascii?Q?7WyjiquP3vVkJZd+DJ66ISmxMD7NsqaQ6GR6O354b8z130cv85sbyrvn0Kh8?=
 =?us-ascii?Q?m+j/zqLoz7vSI8DnTeZsEeIYxjGRPuQydxvTCRKdpBBOz8frp++f+odj1u7a?=
 =?us-ascii?Q?LewHFD8s2ovYcBo89CnIIF4vXpf+Sk9T6sQH7W/A5ccUHwWTTUTkPc89gdhS?=
 =?us-ascii?Q?eP6S1uO/wB2kW59fpMrERWknTk2Z9oGI3Ry1BeiKFZx6K32/QKpVRWW41qTe?=
 =?us-ascii?Q?1ohWeWAYZHqV+/kPbA8JeAiHO1794fQ+zD4r08+EuIXIg+vOriV1giQWneY4?=
 =?us-ascii?Q?MEHZfY8MUVptRgWBtCDnN3ralgXIwe4zOYr3YbmCD/5Qoj9+ea5o8iEWNqGo?=
 =?us-ascii?Q?2A308sJ5Zne6VDfbmzmbatvqcBSQwXoTu01tgb2+OlERDgbotViwzGIel3EQ?=
 =?us-ascii?Q?T8H9UV0JRFJE0bIjX+cTxGwNxLbJE3ZmQV16KPwkbMAT36M1srp5JRuyfd+N?=
 =?us-ascii?Q?EASuThwoMbnYnJ2aFGR2K1122Q7U3FAMXu1IVUYwX1ZxtAVhqOjHJAqfbBSf?=
 =?us-ascii?Q?86hXW4CC+y6lWphcqTGezIgIBGv8st7qtOuos5AKaRdj3NPwCyg/pb5xkdjr?=
 =?us-ascii?Q?9zD7cBSTZAhFdw9pAMMWHKROwQ7a6E8vcpoJdMqbSNL8zoQQNVy5+EolMJqO?=
 =?us-ascii?Q?BjCTxdc1F9Hzc/NsKklyE5rjl3lQX13Agpio94MrrOT79nfJwzYBRNsSfE1O?=
 =?us-ascii?Q?Nm/knwAW3m7JwX64PTA5cvMLvPc6RhFXYrGuvkTY0bFEZwTZp0qjz6vBduAf?=
 =?us-ascii?Q?iyrkA4I/ZABlPB4BXyonMSC+g+qZahEtGoc6uggt3DB9aw1H8RRAvwUkrSUl?=
 =?us-ascii?Q?mOaLsC6lQHY6JtGZLf2WncuUO7uvwoCKglWgd2Hh/ta2vu2OYgzc3V60zSyV?=
 =?us-ascii?Q?TRejYhZLjk6EaXJdC11MsFw7jyTfFTOImRDBh3s/5r4S+d0e1qQdJmuaCOYG?=
 =?us-ascii?Q?Og1AfRoWxvdQ8dg5H8f1TD5E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7237401f-84ad-4998-9d23-08d9776a9452
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 10:29:49.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkrULq9XeL4nZFlbNlPFeDYQXNfj/n0emjTANfPD0/9V0s7uNAU1ZRhYg0ZK2RsJgyFT0kSVhxv0cCI7Q7UCw5DqAf2xvtCS1lj1pou9Abw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1886
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140063
X-Proofpoint-GUID: iyRbCQ2BmdtZ_OWdURWBSv-UdKXKbp_Z
X-Proofpoint-ORIG-GUID: iyRbCQ2BmdtZ_OWdURWBSv-UdKXKbp_Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git amd-pstate-dev-v1
head:   abfcbc164c1aa0c63d5e256854bad977a9645586
commit: df9ad0b99a9f0e3371aa94e49fe92a2c2a9fa95d [4/19] cpufreq: amd: introduce a new amd pstate driver to support future processors
config: i386-randconfig-m021-20210912 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/cpufreq/amd-pstate.c:241 amd_get_max_freq() warn: should 'max_perf << 10' be a 64 bit type?
drivers/cpufreq/amd-pstate.c:282 amd_get_lowest_nonlinear_freq() warn: should 'lowest_nonlinear_perf << 10' be a 64 bit type?

vim +241 drivers/cpufreq/amd-pstate.c

df9ad0b99a9f0e Huang Rui 2021-06-10  227  static int amd_get_max_freq(struct amd_cpudata *cpudata)
df9ad0b99a9f0e Huang Rui 2021-06-10  228  {
df9ad0b99a9f0e Huang Rui 2021-06-10  229  	struct cppc_perf_caps cppc_perf;
df9ad0b99a9f0e Huang Rui 2021-06-10  230  	u32 max_perf, max_freq, nominal_freq, nominal_perf;
df9ad0b99a9f0e Huang Rui 2021-06-10  231  	u64 boost_ratio;
df9ad0b99a9f0e Huang Rui 2021-06-10  232  
df9ad0b99a9f0e Huang Rui 2021-06-10  233  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
df9ad0b99a9f0e Huang Rui 2021-06-10  234  	if (ret)
df9ad0b99a9f0e Huang Rui 2021-06-10  235  		return ret;
df9ad0b99a9f0e Huang Rui 2021-06-10  236  
df9ad0b99a9f0e Huang Rui 2021-06-10  237  	nominal_freq = cppc_perf.nominal_freq;
df9ad0b99a9f0e Huang Rui 2021-06-10  238  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
df9ad0b99a9f0e Huang Rui 2021-06-10  239  	max_perf = READ_ONCE(cpudata->highest_perf);
df9ad0b99a9f0e Huang Rui 2021-06-10  240  
df9ad0b99a9f0e Huang Rui 2021-06-10 @241  	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
df9ad0b99a9f0e Huang Rui 2021-06-10  242  			      nominal_perf);

Presumably the max_perf << SCHED_CAPACITY_SHIFT shift can wrap.  The
"max_perf" variable should probably be declared as a u64.  I will also
create a new static checker warning specifically for when div_u64() is
used on a u32.

df9ad0b99a9f0e Huang Rui 2021-06-10  243  
df9ad0b99a9f0e Huang Rui 2021-06-10  244  	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
df9ad0b99a9f0e Huang Rui 2021-06-10  245  
df9ad0b99a9f0e Huang Rui 2021-06-10  246  	/* Switch to khz */
df9ad0b99a9f0e Huang Rui 2021-06-10  247  	return max_freq * 1000;
df9ad0b99a9f0e Huang Rui 2021-06-10  248  }
df9ad0b99a9f0e Huang Rui 2021-06-10  249  
df9ad0b99a9f0e Huang Rui 2021-06-10  250  static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
df9ad0b99a9f0e Huang Rui 2021-06-10  251  {
df9ad0b99a9f0e Huang Rui 2021-06-10  252  	struct cppc_perf_caps cppc_perf;
df9ad0b99a9f0e Huang Rui 2021-06-10  253  	u32 nominal_freq;
df9ad0b99a9f0e Huang Rui 2021-06-10  254  
df9ad0b99a9f0e Huang Rui 2021-06-10  255  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
df9ad0b99a9f0e Huang Rui 2021-06-10  256  	if (ret)
df9ad0b99a9f0e Huang Rui 2021-06-10  257  		return ret;
df9ad0b99a9f0e Huang Rui 2021-06-10  258  
df9ad0b99a9f0e Huang Rui 2021-06-10  259  	nominal_freq = cppc_perf.nominal_freq;
df9ad0b99a9f0e Huang Rui 2021-06-10  260  
df9ad0b99a9f0e Huang Rui 2021-06-10  261  	/* Switch to khz */
df9ad0b99a9f0e Huang Rui 2021-06-10  262  	return nominal_freq * 1000;
df9ad0b99a9f0e Huang Rui 2021-06-10  263  }
df9ad0b99a9f0e Huang Rui 2021-06-10  264  
df9ad0b99a9f0e Huang Rui 2021-06-10  265  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
df9ad0b99a9f0e Huang Rui 2021-06-10  266  {
df9ad0b99a9f0e Huang Rui 2021-06-10  267  	struct cppc_perf_caps cppc_perf;
df9ad0b99a9f0e Huang Rui 2021-06-10  268  	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
df9ad0b99a9f0e Huang Rui 2021-06-10  269  	    nominal_freq, nominal_perf;
df9ad0b99a9f0e Huang Rui 2021-06-10  270  	u64 lowest_nonlinear_ratio;
df9ad0b99a9f0e Huang Rui 2021-06-10  271  
df9ad0b99a9f0e Huang Rui 2021-06-10  272  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
df9ad0b99a9f0e Huang Rui 2021-06-10  273  	if (ret)
df9ad0b99a9f0e Huang Rui 2021-06-10  274  		return ret;
df9ad0b99a9f0e Huang Rui 2021-06-10  275  
df9ad0b99a9f0e Huang Rui 2021-06-10  276  	nominal_freq = cppc_perf.nominal_freq;
df9ad0b99a9f0e Huang Rui 2021-06-10  277  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
df9ad0b99a9f0e Huang Rui 2021-06-10  278  
df9ad0b99a9f0e Huang Rui 2021-06-10  279  	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
df9ad0b99a9f0e Huang Rui 2021-06-10  280  
df9ad0b99a9f0e Huang Rui 2021-06-10  281  	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf <<
df9ad0b99a9f0e Huang Rui 2021-06-10 @282  					 SCHED_CAPACITY_SHIFT, nominal_perf);

Same.

df9ad0b99a9f0e Huang Rui 2021-06-10  283  
df9ad0b99a9f0e Huang Rui 2021-06-10  284  	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
df9ad0b99a9f0e Huang Rui 2021-06-10  285  
df9ad0b99a9f0e Huang Rui 2021-06-10  286  	/* Switch to khz */
df9ad0b99a9f0e Huang Rui 2021-06-10  287  	return lowest_nonlinear_freq * 1000;
df9ad0b99a9f0e Huang Rui 2021-06-10  288  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

