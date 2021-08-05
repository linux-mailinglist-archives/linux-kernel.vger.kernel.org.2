Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611F13E13B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbhHELTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:19:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14458 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240942AbhHELTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:19:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175BDuZP004268;
        Thu, 5 Aug 2021 11:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=WhiHknm2fleqkLexBpx3v1cYM06jqnOUXmrWQkpTwzo=;
 b=ztHfbZChC+PSUbyMTxY/jZCtZJDlDFGTjUVfSZDCEUxyoZmqfnbp2RhCTelDC63rnW/V
 WXAAwYQ7ktelCeWChTjI43Ll2FLwW8v62ijBQtdTsCB2fIOp2yCLXBl0MVHq083ocngb
 XBc7K32tShU/0kWnlfXtpoxcXpOm0zcxvEfN4pooDi5ppdH3kmuscbNPcr6HuVW2MPEY
 jGIMgPG1/UDodSlaHyKlMZysjsL6m+W9aNxhk5vRpPyxJjxUwb6k9jncazqdW7xdz/5S
 QozOOQISXkLC/qgqP7DlhlJz9vTAkntqdzZYosSBHDeXxprWPRzKGNB0i5ZJOo03EgUJ oA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=WhiHknm2fleqkLexBpx3v1cYM06jqnOUXmrWQkpTwzo=;
 b=u1u8OOv36W8Xdj7m7iXGElOMdX9UYOpS3tTnwPwCMYo/vBFdmNAmj21nSqljSRls8ZqW
 Bv/LOfnzZMH8lxvn3HJ8MIy5hJaxD38jOhexro4TOvdKTmJpK/azGmASQpBOBylUb1nA
 6WyKoCLSjNoA7nrmFXPX+Yioku8ua5Q8gQ4lTHNZxo7ZmWmMqVwh4+L5W4QpgtQfvOdt
 fZEgo6nd49UyS8HeaXGKRV9Q9T/mip0s/mUP77gujDlsvUm2CGCyA9zCk1XK9gZNbBjv
 FEBquljgbBvemyKwkV2ParaDTyZSy23x1KMHOXAskB2JEGcRwMp7G+xBohOaGX/3KtvA vQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq0ccy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 11:19:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175BBZeu069080;
        Thu, 5 Aug 2021 11:19:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3030.oracle.com with ESMTP id 3a4un3jvt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 11:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQfeaOxUGGEvFG/XKwdHkXzDfUrYZNl3pOhxbE5pv0v2VW+PD6REarVU7uIWb06Q3h+ML3YowC/AjFHi+MBCqQ3FH4Rq5qi0Y1R8mUv3iye5nuDDasQ8sRwlTmi4nNrAa+nugLN+zKwpHtn8rFc9kMNv0uVBrVTZ+JTAGXMQd5HKzJf/bIddrJB9fIaTl62EP6eoxBZszQZXRIvMDcED6I/Y3aAoChUrPE/LRvwwNl+9l89Y7dxNTdSEoGNs2vkkrX3j/cG0WYyO5jdGEJ9rleQ25NkwEvjFek9IegtYbAECIzKRvtPT47NoEgggbNjuWVVinK/vgsDe7WDlQe7pjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhiHknm2fleqkLexBpx3v1cYM06jqnOUXmrWQkpTwzo=;
 b=YbtzyudOIgzk8s7Syi2j1XpfLQjdKzKp73xOmWHLCqM4ezUra1CCMJ6wgM9UgV9VHusWe+Lt5EeQj9PBS3x/TxrLtOriiXhZGo9N6IP5Zzec8yxO69ZSm+YLBASm78QS8YYcWN3YtGkoDOBTG+/ZzdYppAVXxDM6PbMPExcxwIUdbAlD16BU3NrPyR6LQ3n3YnLo817s3s/A/TS4zN4stE7jkfaXfIyhN9qGt1vshF+MSgDdzjaEgYcfmIIPJNWyAyZ8fN+vNKVa1jM/JVGiMG6OndIfWJtVO1toJnTb8cRhd9ckJAZEBXO1kjKwh31EiwId/vsYNInIbmt6N3nmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhiHknm2fleqkLexBpx3v1cYM06jqnOUXmrWQkpTwzo=;
 b=ASPAYizADJIasTp468zqMmDErj2tDFhKqp7gGjbAnvsnap3ilCU25vb2un5E9c1q8e5ylyvMA+uep88yzyhkEHsvI/1vl+0CXrwj0vu/6p88ltW1rUkfHkfU20e/kurTX+kVJACl8NZQGFRrRFNIY9SXRRoOzb2vi5Diq1epaLY=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Thu, 5 Aug
 2021 11:18:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 11:18:55 +0000
Date:   Thu, 5 Aug 2021 14:18:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Coly Li <colyli@suse.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bcache:nvdimm-meta 11/12] drivers/md/bcache/journal.c:114
 journal_read_bucket() error: potentially dereferencing uninitialized 'j'.
Message-ID: <202108050754.7KPm2WwN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 11:18:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9581fe44-768c-451b-1d1a-08d95802cff3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23654C0E2A1DCE9F7A89E05C8EF29@MWHPR1001MB2365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWL5/gw2qXrFQhjzLStGKoGqJFfVMQx3OXQU/5Cck8KRa4UUf9BLN9IAVhaEgFt2c5AvW5acYnliaNYfnEXfPncZfJB3gUh/cQWhKfJYbllemATqL30S2QBx7qmOFF6tiTLYRtLWnbkJWY52CCymXf8jS+1gEjUnF8GM2JWrWPX586fqrfRaTuWGK2wRYLEfkhNGcfQFJZ1+MOkAI6BPOryaybWJaXEapin83/YgYJT2yBANi35RQLZ/VSSeSlrIrL99QCFsKJS3aYz6YFIDFyno1rIB8u43k+Mhqv+Vg6x04mg2kx0dxdG0G4+YxaF1YOUSGrsFsTGwBlSHal8XMg3e3BSNry3lY8xSlmIzCPV0Hltmtr2QrL+yHIudCcv9bJcPagqrYR04Jgz8m7B45GNkSZ/cccmqa0NDeKxqOlSQPOR4jyaa0Vxe5Rxq6hTzaXGO5WAZa90HszFp8nL1HoT2dYB8kuv2CHCHwFX5A5Vlx8rO6pbd6X3uSYq8RVZtuKC7DkMXymkGBqLtiWbbOKRvDMzIQxhb0o7YNtpTJ7IMXYy5gZOvB2H50jhEBv1fj14Zx41eaFsRjL9Dr9kV5nvQWkH6L+s27GN+pOFWAZW4G51u/RBwN8EAIMswxJ17CyXz/mcos56/P5bpSk10nP09PXW7F+6jH2a2SmEkGm9M+h/+gvXLg0UfyhGwaS1qjNNbgBf2rtyYXrCc9GxjbM6I8skw4DnfYQViqcu60ne1u00SMyGWaeZcne0A2INeaX8nL2YHEtxpQLbtBGP8OxEZElHP5/FYi6+tnHso3SeFzQqkk9mI4+6FbgTrB1XpmKZxRNkAl/Is8EnDeJ9oZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(66476007)(966005)(4326008)(66946007)(1076003)(66556008)(83380400001)(44832011)(478600001)(38350700002)(38100700002)(9686003)(5660300002)(6666004)(86362001)(8936002)(26005)(956004)(8676002)(186003)(36756003)(6916009)(6486002)(2906002)(316002)(6496006)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xUn/cOeyba2BWB3tJQ25/YwOZq1ynidgLlyqbRnvF3EI4xXzl3NH2X3neYbS?=
 =?us-ascii?Q?QI6iNSPZDxa+LHPrXIpQdOYk06EC3FCD8TorewX59m1OLSnhvZyB8WVF3mzx?=
 =?us-ascii?Q?IBnLSVlY0flX6D/cXDOJszw33TWpwFuUnYwxQJeUWSqNfPHb7v/TE3xaTHNr?=
 =?us-ascii?Q?/xgmS5/a2ry/fhL9qCU5Xs06aa2+Fzbl25tObkPpbWUWfnkoN6YoZw+joWrR?=
 =?us-ascii?Q?UInUQpH8l3gEDQ6XY7B7McsYyVtJ/aV6N2sxOUPAmoW4C3uOcAcVYPyeNatY?=
 =?us-ascii?Q?TrJD1XeEw6ztmhltlLXtogqFx3ctdXYhR/V5+FEjQ41tsVaiQiQzyVRyRWew?=
 =?us-ascii?Q?fR1qRT9uRRUVYF7Kxx2kxs5qIuk4J3NVYH4r1BZd4KZEe1I2xMO2rOIHeipl?=
 =?us-ascii?Q?YarWaPHhnzGvWI+lREyshj1lXe4199E+KAogGWZ7zvPURrRVK8qGoRuG/338?=
 =?us-ascii?Q?aw0IAb6b9JsNlI2Vxjy117uCNlChVJzxmNiiYm7u7tXNTR4rLKLDCNiw1y3n?=
 =?us-ascii?Q?nt9YjEqhFLFQpqFoCQvWdqgQp3bqjdQMmR804mZeqB64VU+IKp7yXNq2bpup?=
 =?us-ascii?Q?kERrCvuKyigewHdZEUPAxcZWtUKcliw2qeF0Ecaw2L2w84YYuM7n0G+g1wNR?=
 =?us-ascii?Q?3JiSpIQ2/dVg8pzjD9kJYxwjM4GIjkXJ6uFzB6tLK9T00G5MwWa/EZpa4orJ?=
 =?us-ascii?Q?aAR2Vw5tapC9XOOrlHTt1BlNreHw8xDZ3tbanwXZs8JQte4pq1qPU3CuppzF?=
 =?us-ascii?Q?0WlkVIx9j9KrW3+x+pkipdPgvRm5sEgFYgjWTecKuMYzUIkDy60DdoDphHfV?=
 =?us-ascii?Q?xATmm5Fdwbts1eUQ6GQruSeKQ641e2jnaT3m1Q4DykTx4ioURKNqqmg7helh?=
 =?us-ascii?Q?hHu0Smz1S5nVzUnMF3FBxLrlPPAhbS8tzENYDkvLMNreYOwUPETsd/5so255?=
 =?us-ascii?Q?RxgC8IdFmk6GY4uMaLvLTqiXV9CcUs0bWjs0XZpVfGT8tE4kwR8j7sLsNZJ7?=
 =?us-ascii?Q?REMwIyrHbajovJC5+6LPKZhriMm184GO/b2SCDULYC2mhhAfKedrsCJeLpcV?=
 =?us-ascii?Q?bNb3MEXnf30A14uMBsT9vaFaEZGpIZ2tLU6iSMva5IxmuMbG8kSWBVKtYqL1?=
 =?us-ascii?Q?clvqFTXUAYGqF3k3HTF7x3tmHIE6w5Pj6wiihICzwFDhQL5WCmIeF7KwkGUx?=
 =?us-ascii?Q?wE6i/mZYxvKl2pf1V+zd2QeR/iDPAJEMMYM3ifLMMdGYR4EJ7CM0pru0v01s?=
 =?us-ascii?Q?lO2zvpDO9TUHGui73KWDw4p5xHud3DBRHuTTPqlNJgzGNSXImmwvXGNiWiAX?=
 =?us-ascii?Q?XpWEfM7qqcqyJhhKNQIK/256?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9581fe44-768c-451b-1d1a-08d95802cff3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 11:18:55.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHGNaeE2GSdXUU1UKAzF5KPvmlSvVGpgLQE9iLPUUwBWNyBndVL4l+v0xreVkuIFDbCI8uHF4IZsX/M6SV6FtIVCTWq3ldqMsJBfiKRvdUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2365
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050068
X-Proofpoint-ORIG-GUID: KVorURGhVsvmP5TSbNZE1pkoQi-cP9_f
X-Proofpoint-GUID: KVorURGhVsvmP5TSbNZE1pkoQi-cP9_f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git nvdimm-meta
head:   a12f8ec824edd1317f14882c7d0aee5e5c941edd
commit: 5f408d113974d2bb3eb1b237d549724f7509ab23 [11/12] bcache: read jset from NVDIMM pages for journal replay
config: x86_64-randconfig-m001-20210804 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/md/bcache/journal.c:114 journal_read_bucket() error: potentially dereferencing uninitialized 'j'.

vim +/j +114 drivers/md/bcache/journal.c

cafe563591446c Kent Overstreet   2013-03-23  106  
cafe563591446c Kent Overstreet   2013-03-23  107  		/* This function could be simpler now since we no longer write
cafe563591446c Kent Overstreet   2013-03-23  108  		 * journal entries that overlap bucket boundaries; this means
cafe563591446c Kent Overstreet   2013-03-23  109  		 * the start of a bucket will always have a valid journal entry
cafe563591446c Kent Overstreet   2013-03-23  110  		 * if it has any journal entries at all.
cafe563591446c Kent Overstreet   2013-03-23  111  		 */

On my kernel there is a "j = data;" line here, but I guess it got
removed so that's why Smatch is complaining?

cafe563591446c Kent Overstreet   2013-03-23  112  		while (len) {
cafe563591446c Kent Overstreet   2013-03-23  113  			struct list_head *where;
cafe563591446c Kent Overstreet   2013-03-23 @114  			size_t blocks, bytes = set_bytes(j);
                                                                                                         ^

cafe563591446c Kent Overstreet   2013-03-23  115  
b3fa7e77e67e64 Kent Overstreet   2013-08-05  116  			if (j->magic != jset_magic(&ca->sb)) {
46f5aa8806e34f Joe Perches       2020-05-27  117  				pr_debug("%u: bad magic\n", bucket_index);
cafe563591446c Kent Overstreet   2013-03-23  118  				return ret;
b3fa7e77e67e64 Kent Overstreet   2013-08-05  119  			}
cafe563591446c Kent Overstreet   2013-03-23  120  
b3fa7e77e67e64 Kent Overstreet   2013-08-05  121  			if (bytes > left << 9 ||
b3fa7e77e67e64 Kent Overstreet   2013-08-05  122  			    bytes > PAGE_SIZE << JSET_BITS) {
46f5aa8806e34f Joe Perches       2020-05-27  123  				pr_info("%u: too big, %zu bytes, offset %u\n",
b3fa7e77e67e64 Kent Overstreet   2013-08-05  124  					bucket_index, bytes, offset);
cafe563591446c Kent Overstreet   2013-03-23  125  				return ret;
b3fa7e77e67e64 Kent Overstreet   2013-08-05  126  			}
cafe563591446c Kent Overstreet   2013-03-23  127  
cafe563591446c Kent Overstreet   2013-03-23  128  			if (bytes > len << 9)
cafe563591446c Kent Overstreet   2013-03-23  129  				goto reread;
cafe563591446c Kent Overstreet   2013-03-23  130  
b3fa7e77e67e64 Kent Overstreet   2013-08-05  131  			if (j->csum != csum_set(j)) {
46f5aa8806e34f Joe Perches       2020-05-27  132  				pr_info("%u: bad csum, %zu bytes, offset %u\n",
b3fa7e77e67e64 Kent Overstreet   2013-08-05  133  					bucket_index, bytes, offset);
cafe563591446c Kent Overstreet   2013-03-23  134  				return ret;
b3fa7e77e67e64 Kent Overstreet   2013-08-05  135  			}
cafe563591446c Kent Overstreet   2013-03-23  136  
4e1ebae3ee4e0c Coly Li           2020-10-01  137  			blocks = set_blocks(j, block_bytes(ca));
cafe563591446c Kent Overstreet   2013-03-23  138  
2464b693148e5d Coly Li           2019-06-28  139  			/*
2464b693148e5d Coly Li           2019-06-28  140  			 * Nodes in 'list' are in linear increasing order of
2464b693148e5d Coly Li           2019-06-28  141  			 * i->j.seq, the node on head has the smallest (oldest)
2464b693148e5d Coly Li           2019-06-28  142  			 * journal seq, the node on tail has the biggest
2464b693148e5d Coly Li           2019-06-28  143  			 * (latest) journal seq.
2464b693148e5d Coly Li           2019-06-28  144  			 */
2464b693148e5d Coly Li           2019-06-28  145  
2464b693148e5d Coly Li           2019-06-28  146  			/*
2464b693148e5d Coly Li           2019-06-28  147  			 * Check from the oldest jset for last_seq. If
2464b693148e5d Coly Li           2019-06-28  148  			 * i->j.seq < j->last_seq, it means the oldest jset
2464b693148e5d Coly Li           2019-06-28  149  			 * in list is expired and useless, remove it from
9c9b81c45619e7 Bhaskar Chowdhury 2021-04-11  150  			 * this list. Otherwise, j is a candidate jset for
2464b693148e5d Coly Li           2019-06-28  151  			 * further following checks.
2464b693148e5d Coly Li           2019-06-28  152  			 */
cafe563591446c Kent Overstreet   2013-03-23  153  			while (!list_empty(list)) {
cafe563591446c Kent Overstreet   2013-03-23  154  				i = list_first_entry(list,
cafe563591446c Kent Overstreet   2013-03-23  155  					struct journal_replay, list);
cafe563591446c Kent Overstreet   2013-03-23  156  				if (i->j.seq >= j->last_seq)
cafe563591446c Kent Overstreet   2013-03-23  157  					break;
cafe563591446c Kent Overstreet   2013-03-23  158  				list_del(&i->list);
cafe563591446c Kent Overstreet   2013-03-23  159  				kfree(i);
cafe563591446c Kent Overstreet   2013-03-23  160  			}
cafe563591446c Kent Overstreet   2013-03-23  161  
2464b693148e5d Coly Li           2019-06-28  162  			/* iterate list in reverse order (from latest jset) */
cafe563591446c Kent Overstreet   2013-03-23  163  			list_for_each_entry_reverse(i, list, list) {
cafe563591446c Kent Overstreet   2013-03-23  164  				if (j->seq == i->j.seq)
cafe563591446c Kent Overstreet   2013-03-23  165  					goto next_set;
cafe563591446c Kent Overstreet   2013-03-23  166  
2464b693148e5d Coly Li           2019-06-28  167  				/*
2464b693148e5d Coly Li           2019-06-28  168  				 * if j->seq is less than any i->j.last_seq
2464b693148e5d Coly Li           2019-06-28  169  				 * in list, j is an expired and useless jset.
2464b693148e5d Coly Li           2019-06-28  170  				 */
cafe563591446c Kent Overstreet   2013-03-23  171  				if (j->seq < i->j.last_seq)
cafe563591446c Kent Overstreet   2013-03-23  172  					goto next_set;
cafe563591446c Kent Overstreet   2013-03-23  173  
2464b693148e5d Coly Li           2019-06-28  174  				/*
2464b693148e5d Coly Li           2019-06-28  175  				 * 'where' points to first jset in list which
2464b693148e5d Coly Li           2019-06-28  176  				 * is elder then j.
2464b693148e5d Coly Li           2019-06-28  177  				 */
cafe563591446c Kent Overstreet   2013-03-23  178  				if (j->seq > i->j.seq) {
cafe563591446c Kent Overstreet   2013-03-23  179  					where = &i->list;
cafe563591446c Kent Overstreet   2013-03-23  180  					goto add;
cafe563591446c Kent Overstreet   2013-03-23  181  				}
cafe563591446c Kent Overstreet   2013-03-23  182  			}
cafe563591446c Kent Overstreet   2013-03-23  183  
cafe563591446c Kent Overstreet   2013-03-23  184  			where = list;
cafe563591446c Kent Overstreet   2013-03-23  185  add:
cafe563591446c Kent Overstreet   2013-03-23  186  			i = kmalloc(offsetof(struct journal_replay, j) +
cafe563591446c Kent Overstreet   2013-03-23  187  				    bytes, GFP_KERNEL);
cafe563591446c Kent Overstreet   2013-03-23  188  			if (!i)
cafe563591446c Kent Overstreet   2013-03-23  189  				return -ENOMEM;
cafe563591446c Kent Overstreet   2013-03-23  190  			memcpy(&i->j, j, bytes);
2464b693148e5d Coly Li           2019-06-28  191  			/* Add to the location after 'where' points to */
cafe563591446c Kent Overstreet   2013-03-23  192  			list_add(&i->list, where);
cafe563591446c Kent Overstreet   2013-03-23  193  			ret = 1;
cafe563591446c Kent Overstreet   2013-03-23  194  
a231f07a5fe30a Coly Li           2019-06-28  195  			if (j->seq > ja->seq[bucket_index])
cafe563591446c Kent Overstreet   2013-03-23  196  				ja->seq[bucket_index] = j->seq;
cafe563591446c Kent Overstreet   2013-03-23  197  next_set:
cafe563591446c Kent Overstreet   2013-03-23  198  			offset	+= blocks * ca->sb.block_size;
cafe563591446c Kent Overstreet   2013-03-23  199  			len	-= blocks * ca->sb.block_size;
cafe563591446c Kent Overstreet   2013-03-23  200  			j = ((void *) j) + blocks * block_bytes(ca);
cafe563591446c Kent Overstreet   2013-03-23  201  		}
cafe563591446c Kent Overstreet   2013-03-23  202  	}
cafe563591446c Kent Overstreet   2013-03-23  203  
cafe563591446c Kent Overstreet   2013-03-23  204  	return ret;
cafe563591446c Kent Overstreet   2013-03-23  205  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

