Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E90408773
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhIMItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:49:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36960 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238406AbhIMItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:49:40 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18D6hvTn028508;
        Mon, 13 Sep 2021 08:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=WR86ICcW08ks4DCyCvvcAyK56Gk6al7gjHx94rI9Fl4=;
 b=PPX+UhiUd+wRnOdzR4aL/Qj5lLJd5ejnPzr1KTDwDyRu/JkPz5eVco7KgGTE3zPxwMe6
 RGij4xjkRx6xEtWUZHbbsJpbPSr7/MRwr4mN8KX0zAFauQqY6ENPo+Ur/Z0i1DtKIDWW
 z+O9NcTBSyTKiDJ0PmWwMKhPETDWiypCBfPPBk27Onf05OMUi3quoN1aGnn1+mjlwP7D
 wCzhEzQ3RJi0nV+9BZZECfQCtx+sUitJMLCa3QkFXZmqitII6jMmTzBexiVZudJPq9gr
 ys4N+WpucAmGZHb5LixyqidmnGfWjfbFFXwTnoC2vOSo3IyJ3kdXbw5TutU/VpzTqj3u Tw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=WR86ICcW08ks4DCyCvvcAyK56Gk6al7gjHx94rI9Fl4=;
 b=sNJa50ntMsooUsfb1lPrBmp/Q/lwTdAZzAMOSv44URPaqWiUFYX+wkfmOeAfx2Owz21X
 Rp3NRaEffYDvevoUGAhQ0JU9wnHzSTkDC4PRHhEgFmw76Zdm6Bxtyx5UCWtrEOiLUP09
 izCQMbgXZ3jTDAapWUuihaJgwB6lvG3jc88GWwVpqw+HPCr5MSTFiT5qKmd9D368RwE8
 sOEK5jBhf0iifV51Jlxg4jTlTQZX44Y2ZvQIlkmKaj5ZgzZsHAxBtVm+iLdzvPzdNRsB
 wtC44EsqaObxKJp78tdQ5jVtkjPv8i3GafVqfLAE7GQ5HdyiV0fnW6t3Gy6dS1JFW8N+ Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1ka91qxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 08:48:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18D8jJ6K082790;
        Mon, 13 Sep 2021 08:48:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 3b167q54g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 08:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiKZtbCdUyMHuXiYyqJL9U7TGgsJJ8j/z+5VBpR6u2LOny62Y6PrcgmJhoAn7/0I25iIYY+wZhGeq+aGGpoEzMQ7SuNjK/czmIerxoSXNaJ3JyDGWWoFwSe0v/njS9vsRi1Xm3Eo+1eWIIp+PS8sInNn5RsQmnvRADTCsHelZafHDbZiRpcRBj0LK9KE2J9tE6850ZUlhfkku4fJ9CWdRda5t5rCkrgGdEtAI06tFcWU37TselO0XzNFTBNPktzNrv0FIPAnRFkrwzSr6+vno/0k0QlXvE6wWSntn9gXgGwwLFH+1dGLl612mX2OnZ+0WekLZGQZn29qzHsCD9Zugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WR86ICcW08ks4DCyCvvcAyK56Gk6al7gjHx94rI9Fl4=;
 b=PvtHR808OpI7CORJjmRD1093cZghuoSKgxW0hnP/BTYWbiKbxdz5CuMDT2zFgWJRWKVEv3Bc6fhqKB+gvTKmrkt0HrLAkTVV5N/lqyqiRa/WKGNDtoVUfEtgddC2gap9MeMx/ITMGyZ0iZO2nu31t2q1Wvb/nN2bkIxAtp+ALFE6y7eNPwKJ/G9K99qwhvRlSyY7xUiC6aR0NS0mLNt7usATGpjp89KWAwPqcH9lBvcgdu/831QSKp5Qd0pVwYwsQPDJPMkedhd1mpzxUh1GwGgG/lCeQSqI2rCT4xTUaZ4fv9Za8RIfxrESdKcIJyusjNL4ebK87s4PFTzBrYn2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR86ICcW08ks4DCyCvvcAyK56Gk6al7gjHx94rI9Fl4=;
 b=HSbyjVpHti9ASsqeLNnweajSOduZ+Xq1uOQKl+y0/EY9x/2vgpFpICayxM3XzReP2mlbNOS3JOzC5I0beLU66324VZKGb25WJgnphBJ0wQTsFaewhK6x/CkVpe4mmLYg+3KVP+NYaBG4sNJeMItu2RvH2m6/CFpzBmOaODBQs+s=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1485.namprd10.prod.outlook.com
 (2603:10b6:300:25::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 08:48:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 08:48:09 +0000
Date:   Mon, 13 Sep 2021 11:47:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Yafang Shao <laoar.shao@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 13/19] kernel/sched/debug.c:453
 print_cfs_group_stats() warn: variable dereferenced before check 'se' (see
 line 444)
Message-ID: <202109111001.XChyxkS3-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Mon, 13 Sep 2021 08:48:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01867fa1-fd5c-4d4a-542b-08d9769335fb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB14851AB720710FBC36FEB12A8ED99@MWHPR10MB1485.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:250;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38/DNHqckSQwYEd7106ZoREnFhmfADFuVaaOpDkccOxLWKygWtWNNOw7wlkBzz/Mu9Lgg5moeDnuAI/ID6+fXVPum5nMDdgz/vh26lzEA8kV4eV4eiaI3UGU19u8bg9FQP+7H3b2W/kXr1AwV39IwXNwi5/ihdmLueGfpruBIcM/cN9l8xbwkeo/S8/sjk2lukWnx9pC1sX9PZIIKY+BKIBMC3XzVHqpzg0yDeSDflMEiC6D6rj065yaqqugDmAyBBLcgJwgKpW/13UGvDfcwAdJTTQj85pvo0EBL3IWseRP2tjRbIufPun6bvM+bRaAgHNCbBK9Hbg2dh6o1QcQpjYsVqrtXiDdvPGTeGKIHuP4VkQ6SdYAHvyDdHc+aSW06nGMKS3urh+2YUiXNZVQwIHaIGdJFG3n5XoXgS6uOffDyi4Tiixm1l2Dcypzmvax8Ux5xnCJ6g9HXT5PaUaYMd6G0rVI2uhLlut5eU65rN8OkDxvn9r0wA05bOAAdMxFxrbhsgSypnqvz6J/pwIfcMw1RkcHGcuBd8KzoQbJUC4ei0oFPhoz7ymoC90U3EWtaQ7p35Ek9RBk504/YH3GImgHtAJzlQ7ISfWBmeuKHwUWSveWJfNdQANlIxnn0uoSBB50xXAABBmBrqnxYU84Vky71pbM2yydE9+WUhr4Stpz1uLRGx/VAr0vsdigfGKMHUwf49xVWF/r8if+QqI3sm0QK51d5WLXQuiKKko6RuF/ic30xC0dbfAmwxmYnhM9ojRyfgUwsphSRdgnNR+8270Mw5tdwEEJJicQnbbQWnna15oydsUAvid4DDv09Lv8VwfazTzFR3/NbKWnpYIpdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(1076003)(38100700002)(66556008)(8676002)(66476007)(66946007)(38350700002)(6486002)(8936002)(6666004)(83380400001)(4001150100001)(186003)(6916009)(36756003)(9686003)(44832011)(4326008)(956004)(2906002)(52116002)(26005)(6496006)(966005)(478600001)(86362001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0Sb7aToH9ivzu+58QJ2l5R3lHl4zVXjIJgPX8JLB58ezfuMoxIzfIIwTwL9?=
 =?us-ascii?Q?mJgdgZGNye5IiVS9QAiM9YEOwUDMofiveEqXvNvW2WOIWDR5sxTC0a1PUCSe?=
 =?us-ascii?Q?mXCDOREBmOIYN/WPZmskaJuBVavyPj4T0Gm3JH5tcV7o/Oro7HfiIjbsnxBX?=
 =?us-ascii?Q?iwgtQHOR9K3tvbzn2oMjYfVYiLCIO6kPeueXRiuIPe5r7SFEGvsI/P3+OLPY?=
 =?us-ascii?Q?vKeyxZ58Nu2J1w88Zb4aU3Brq2CqXGDktXEO4bFU114Fs2zKYGpyqNwUnXQf?=
 =?us-ascii?Q?m1R5TX8vg288JQtcMYFCcdXQIL4DqzrYJr4yDGm6zVjXF2KWw6MY0EkCuW0s?=
 =?us-ascii?Q?5LJbrNVaMRO+e0df/n3qhc2AQYWvCv6OTHz2m7S+BbK1sD/gBEe3dziSgz6x?=
 =?us-ascii?Q?nNljSiXIr6CogMit/DnXNhLIZF9FfdhJ6kH4Bxu/W+zUrMQJ90X2jcKL8JHk?=
 =?us-ascii?Q?bXQRAzaoMHL8eK365Mu7Xl7o0OTxIf36R/lLRPNGa7RPCo8nzUcRcs8oFFRM?=
 =?us-ascii?Q?4PN5H3M7TzqiGDSNILqiUvqvT+w+iEGcMJj2YV6CzW3FGJofSMmny7XBv8Ip?=
 =?us-ascii?Q?hywBXSPJ9cc3RAeD+8K4P9Rut5uIaVWcFMbOYgUoBszfePYGLFWi2RQd0Eqd?=
 =?us-ascii?Q?bq15EAIccIZ3tbVJU7QhJtEzh9Ci/PVl9fYCcWJmhOjq+OROUfxKVcv7fqWq?=
 =?us-ascii?Q?ODolKXQv5ylW+bJ5U1s+H+UgWsV0HeI2xuLI4o77enO96ijRetK6ZwtCp/qq?=
 =?us-ascii?Q?Wh0/AldsRB934gB571vlZWjMwTiV1VHpq8+1eCeiS++aIkkAwUE5pzdBQd2D?=
 =?us-ascii?Q?KtT9F2dl+ZWsD7M6CGIHvLWgHZDn7EdJUx+e/t72Yn3qMmv+Bl5Bw6r97acK?=
 =?us-ascii?Q?67DTJuK7jeleCOMhs2IMzRh31aE0FfFy8oK/UUxSWnXBWf+LHWktw8RmHIGL?=
 =?us-ascii?Q?mrvMmq+q+qZWAZPBWBLU0rkvSJ6EG/O+2tesZUEw9I8Nx5ZMlnqkUKbUu5G9?=
 =?us-ascii?Q?DMiYy+r1tP8FKoiIfpVdE3xsHhhWSaP9TJTrEHKWeNPpwprzNKhzDOpGBq6r?=
 =?us-ascii?Q?eiIWwUJy0WzZiF0pnqSvS2RxTrlVLqtQLCTPrlszI3lrzyKEi5MD8YwokW6t?=
 =?us-ascii?Q?5h1sIZIbVt4KAvoj0XMl3m5gMHE+YaQGHDzjevon4DGKkMLcjwd671tPxTDu?=
 =?us-ascii?Q?6TJacNOj8r6q/sUW1kHy9+olPCYwqm6/2cMrSyo6f8SPXxJBuBGecuxf/n7z?=
 =?us-ascii?Q?x0fCQKYugpfaIfkntVqVBlIZMdYYixEub6WLIbGWRPbC7qpuvFX6mSeBTphr?=
 =?us-ascii?Q?l7ahptI42FV0nU1GX9qP04iI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01867fa1-fd5c-4d4a-542b-08d9769335fb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:48:08.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfX6wRlsuX8XzTvPbp41bcd0PyH8ZZGdNcuuqesJcur3FO7lvdt4T0chPcPmjo/pWSGYEu9zEKzrIY12cAZtMyl+En7euTcr6/yOucJ/01o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1485
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10105 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130058
X-Proofpoint-GUID: bOJPjSFtzwQd6DU56QwgFZ6ibx8ca0TM
X-Proofpoint-ORIG-GUID: bOJPjSFtzwQd6DU56QwgFZ6ibx8ca0TM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
head:   2dfdb3d20ad50e2ae2cb84cbceb0f0fc75e79e5d
commit: 445d9e8ba05d5e9e4b26956b7fe529223e29d8d1 [13/19] sched: make struct sched_statistics independent of fair sched class
config: x86_64-randconfig-m001-20210910 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/sched/debug.c:453 print_cfs_group_stats() warn: variable dereferenced before check 'se' (see line 444)

vim +/se +453 kernel/sched/debug.c

3866e845ed5222 kernel/sched/debug.c Steven Rostedt (Red Hat  2016-02-22  439) 
ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  440  #ifdef CONFIG_FAIR_GROUP_SCHED
5091faa449ee0b kernel/sched_debug.c Mike Galbraith           2010-11-30  441  static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group *tg)
ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  442  {
ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  443  	struct sched_entity *se = tg->se[cpu];
445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05 @444  	struct sched_statistics *stats = __schedstats_from_se(se);
                                                                                                                                      ^^
New unchecked dereference.

ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  445  
97fb7a0a8944bd kernel/sched/debug.c Ingo Molnar              2018-03-03  446  #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05  447  #define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05  448  		#F, (long long)schedstat_val(stats->F))
97fb7a0a8944bd kernel/sched/debug.c Ingo Molnar              2018-03-03  449  #define PN(F)		SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05  450  #define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
445d9e8ba05d5e kernel/sched/debug.c Yafang Shao              2021-09-05  451  		#F, SPLIT_NS((long long)schedstat_val(stats->F)))
ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  452  
cd126afe838d7e kernel/sched/debug.c Yuyang Du                2015-07-15 @453  	if (!se)
                                                                                    ^^^
The old code assumed "se" can be NULL.

18bf2805d9b30c kernel/sched/debug.c Ben Segall               2012-10-04  454  		return;
18bf2805d9b30c kernel/sched/debug.c Ben Segall               2012-10-04  455  
ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  456  	PN(se->exec_start);
ff9b48c3598732 kernel/sched_debug.c Bharata B Rao            2008-11-10  457  	PN(se->vruntime);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

