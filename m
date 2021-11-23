Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8848E459E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhKWIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:48:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55402 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhKWIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:48:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN7pUYr024186;
        Tue, 23 Nov 2021 08:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ygAaCeU0RcPgWBDA3d5SaHoqMzHDeD2esaXq+S+V+X8=;
 b=dIY/xqI5ZVAwgsjLqAmTo1rKiQNXIkO9BJHa0suP73KNO9P/M46/FlkkVuhDeyDV5krx
 lCd+bbKyiEU40iDS/V9udHjVB61kEPQnfDE5mStHKel6RoGJyhjhcmLf5r9+SJCzjvz8
 BxKGmjE3d/GgLVRiO1eiGILqTn6v2a/vN10+dZaT+7mL3R98IwDqyDSaaAyzkYxPZ8X3
 m6qaI1Uo42v2L8jDeRSUdOVjs9tuajJJS/h4EMRjcvbq8x7nvoKNLUyUZhu8zSPzeA7F
 T5XVik3tJ3/0USprcK3l5n+88wfUlerGVzX2epPaXjLXOYXEaeAheHC/yP5GGKmv1J1o YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg5gj7p9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 08:44:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AN8ZPP9070457;
        Tue, 23 Nov 2021 08:44:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3020.oracle.com with ESMTP id 3cfass23fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 08:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy5Xzb+i8P8FpeUY+FcINW3hMRhPiVofUWTzxDKufKdPfazAdMf34OUphHwWVhM3vqNZ6SEc6ux57Qa9u/Lbv6Tdv4XXTq3FbQdDB+I1Do3U4h8tm9AjApYs2Yil9WpmlwK7TJ2PonR5lp/SfffJUywaDrwU7Me7TaqxnPDxJHTWbP1S/p6lc1tcupSEQ4jAr8U+sfExK6nx1pOb4Le9DGY8IQkqc9CzMFI7r6PomTm5ppxPYrHrNPMjpPSRQcKa58JH255AbiG6CgF+WUxAJB7oq3Zk40ewyZb+JrnVgWn7TgYlBOX8j+0Nbr+C1tSnKWiIH2byIFBtUyf/kEgnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygAaCeU0RcPgWBDA3d5SaHoqMzHDeD2esaXq+S+V+X8=;
 b=Or3f9KtdRVu4+lsOpWc47ewVNcsjmdq0XGJ2/SQyQXvD785m0JKB4ETXYFE5UIZTiTZsRgnst/arNQxgrP/cQMgiTNHm6ue5+4KiTe0TrYqKCIaVlk4PACAXH98rk/K9Scx7yOcw3OuyO6LU2JHwPeOkxSVu1QdxDwhrhIT+usqkXVBPsRzgztO5DZXZOtMwWZBPi1vgWMwr6AWlY/Fs0aROnJNInv0GjVYvJQ/JI/Xnx7gcN5j6+eM6DpwsPAfklS9SA9cMJ14TG7ZN4lrh3Yr73XqRJ9qokG9e/HzW+Hnb6Nftj4XvFQ4scOTztuHQUfs4lfUmSfteDLQ4XyGdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygAaCeU0RcPgWBDA3d5SaHoqMzHDeD2esaXq+S+V+X8=;
 b=ct4Tkb/+aEFVIKLRI2at4pUccJuwhe1XZOJ7Cwt8xe34IEbIqN/EKa36E/gTSGVdUYe+TY1hE3Nye3PNM7xqnyJDk+vu47u1XjKV8mZUZZmQ/BArkpjSjOiRdjH0tgsFtb7Vqy9UWkpXsPTGMCYASlr4FvZV1oHfqdI2ychMdT4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5680.namprd10.prod.outlook.com
 (2603:10b6:303:18e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 08:44:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:44:50 +0000
Date:   Tue, 23 Nov 2021 11:44:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Andy Lutomirski <luto@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [luto:sched/lazymm 13/16] kernel/sched/core.c:4982
 __change_current_mm() error: uninitialized symbol 'old_active_mm'.
Message-ID: <202111230549.U0WrDxKK-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 08:44:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c249b9-ba44-4ab0-545b-08d9ae5d8341
X-MS-TrafficTypeDiagnostic: MW4PR10MB5680:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5680A7430CD25CEB1BBD49D58E609@MW4PR10MB5680.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LB0i/ajlA1BMU7HHyEOCAkh7HeYf+ZAZyMck2tgSgOSpwC7LRXvtrymzVDBwHMGUKS9cKroaSFhx+OBI62imRHZU5cTFmDNV4anm7hJxoAIokuQGyCmiAyMpBRpt3vhI1COJRC78KgjzVJucSOHNx3YltWiUQBKjyPO5vosSgzSFS6r0COHbKyN2MMjeWaiKWC7JaQFZwiEA+BvPIu/bIa7pbFhrGZi2/jVxClFF3D8ooEGaPEMLgQnmYAI0l3XWgo7WifnxHFRg/oxYk0W3x0n5ayyEgrm+9zVxb0/hILn/g5gTOLatYKLTZ6aRmpiuo5RtjbE+eOFGT9AgY7aV+hf4c6tzBoB9Kh8qkTeolAoKilT1IHUg/eYDnVmP1frloJZ81ZcaZtvMg9chz9ywT8Q80Atz8j6wM8kwGQOj6DBFEg3O8ZJNc7R1C6OBiYxUTKA2NSDTOt0R0Z6Z2OyKBp3PrYfEHak/Jdiseyrj8urOr7kreKtZUBUxIJV+BQZfkPy/Afr5fN6w5XTIZtsiqa9dJK3RLem7bIyf9mqSxenxpopDcWEjfMWe62zr8cz9yNLbwCx0o2/qcNzl2lvn9WylQFx5ptXPaI16s/GrzjBcsHKTUq9dR3Tkjy+FXYnbt6j6OD+HZFD6cTWvQFYJcI4Fjrw2AP9q+gD9ir07FDoMXCyh/qPDYazivtXDUxUbpEQzLjcw4wIJA/yOHnd4R8apxYFO0u9Hk4QJGB9RrbjJp+WjRDGdxh/IXfd6N7P2AW1e0yXKM3o87eZM2WvBg3Yl9ws1MOVbBlX4mHKtdrQ1GEkxF10cefuAzFGlkWmgZzwmAoTEye+XlDF4gggYjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(1076003)(8936002)(86362001)(5660300002)(6486002)(316002)(186003)(44832011)(9686003)(966005)(6916009)(508600001)(66556008)(26005)(38350700002)(6666004)(66946007)(52116002)(956004)(6496006)(38100700002)(2906002)(66476007)(83380400001)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?999rR/o04bV9xFta3EKYDNKApge5RRfb/qvdqH7Bk/8XAYsmgZXAvDREmEHZ?=
 =?us-ascii?Q?+mLYAHeLs/gWX/HI32lOGLd2oVa46D3h0fJsv/5U74cK6RKU7z/JwQkbCar3?=
 =?us-ascii?Q?7XKCfna3InPzUY2+YbtHd3By2UUOmkyss/KPk7hbpKK8LXSEqu/yfZnuCDjS?=
 =?us-ascii?Q?UyKlC/ywfntrH/OWLBjTaY9Zo7qSbueNG457E8HGdoOlz6BSh8QJauzOw/0n?=
 =?us-ascii?Q?wRwUXZbs34pJktHFTsm2fPryaHIg4F+3YSIS97VwuIrbP52RZxQxau6oP0yT?=
 =?us-ascii?Q?lY1U2kwxJ4dxxSLpiv1E5/zbZxD4X49TAkUlBMjrRWdYYn50XlFZH3tp+fZS?=
 =?us-ascii?Q?IZrWAI0TkkW4gqQhajyktUW11eYMRAp6M9+/6u7kKpByr/6usyjGgCz1T3dY?=
 =?us-ascii?Q?iYJtzh/oGGoy4IPGtUg1YpvkP6TzqmziKWNTAHb0krAC2tP2jxFvb2W3KsXa?=
 =?us-ascii?Q?wop26+aXVK94vXUHQtRy795S0GP+KQSr7bBP6CotupJVG8t6O+mEbqV7VyVp?=
 =?us-ascii?Q?wAl6ffnjJZiWs54TL0yQj30zEtF7ZHg76Gqrj73OKasPzCNAQlcrlRQbmy83?=
 =?us-ascii?Q?b7Eu2BXDN0DdmTlHI/Mm9zvIIH3g4gnncwZSVqe87BuidBP6Z/5G6m9TU53c?=
 =?us-ascii?Q?fwsV7hTJyYGncZLXaQz452cIYDxRHUY+ZU55S7vkZ7b/BUduMN/KvWtAjSsc?=
 =?us-ascii?Q?YVU1LdZVwRtBVUggY9TaZc0stHMbfe6gMCA4Aq+dlqDPpObXqm2EpIT5ZrWs?=
 =?us-ascii?Q?67GPBxygiDnvKHVMu6b8fWfFXnPz+l/4m4i5zGzMYMknArn7b7+JERoBA4N4?=
 =?us-ascii?Q?EGq5wrlPZWydhnJRR7gp/AV7XQjXJWTVwvc10UOD5DLbeTBJlKPYAJFQfXBX?=
 =?us-ascii?Q?+DjhHSYV0FWfBwjTnLgVXl9rah58/vGhkd1kTfNzFVw/27fq2soa4cZcSDIf?=
 =?us-ascii?Q?NcGrlO/Q4RJZBTH0L+YNqKQLeDmdPm2Wq/Q3Rj9RUMFJ93NU+GEz5HJDGxeb?=
 =?us-ascii?Q?bYSib8VKa6FjlPk1A91ByVO42KaWe4CkdAxVjGIW+DBAtDK9AtsUJNTciwhS?=
 =?us-ascii?Q?3NxedaqFVbUI42oU6WBvYfN+hgjgcRQLxwZ6zlrnITZeqZfAS0c44nCbYPf0?=
 =?us-ascii?Q?OvfoozNrpBIp7M7kvHh4lKAzKCMDlLiCb3ZLAxFy+ZLFkGBHL7e7CfgmIO+5?=
 =?us-ascii?Q?PLjGGFGuoa5t8EfNQ/iEadwPSCh9UKcogk1/56cZciKSCgWDMF4oO56d9QFQ?=
 =?us-ascii?Q?+Ffl1/+1Y2dsdSLRAVtDddbmSF14c2wyCRhCQN8HztBBdNjqlV1S7Gj1TVPR?=
 =?us-ascii?Q?UR0ZNtB6v4mBqZlLCJ8siZyCMM1p9YxTtJCvwbwJ0J7nPqUSm6bAFlYNLB3H?=
 =?us-ascii?Q?z92MXaIB79royG7PgsnN4cWr5le5LtHnN6syflkcjzLmVFnO3qjTfTWn+ptT?=
 =?us-ascii?Q?8KEYxwcUTDnAVB1BpE03rFWAqeNdq8pdA/h14rPFstPXvDNHn82+jRUopkvM?=
 =?us-ascii?Q?hdJAS8XFc4PB/F1tMviSai6txrU/r4XWr0iPenQTQ32OdRfNsaoN7scJPnia?=
 =?us-ascii?Q?d3m2fuC8Qi192htE6YE5JHqRy50rk4lB33E0mG4TM3C/DAOiB9s/WBeoaNYC?=
 =?us-ascii?Q?oa/YWbU6AlAV+0jmKYIiFOfHI/QwngWsVPuHltZB9wJnHZ0HM2uyYeux5+jk?=
 =?us-ascii?Q?Ky0zaqE5DDaA4Idw31WnJl+4nPA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c249b9-ba44-4ab0-545b-08d9ae5d8341
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:44:50.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFyYGsCFWLj3BdD2y38OjmU4ydDXxC2RBCcVITpkT83gFkx8zqWr1aApH3Lpsc+QQ0kVdTLWv3cc2vjhmdxgwP4Bz9qZV+xEE3ex2bhqwhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230045
X-Proofpoint-GUID: wsXVM9y3RDT3mWD88dHMBPQVT8okAo_w
X-Proofpoint-ORIG-GUID: wsXVM9y3RDT3mWD88dHMBPQVT8okAo_w
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git sched/lazymm
head:   c0d03d4f2778fd0a7c16e69cdfb3f111296129b5
commit: 4863118ffa6fe6af7cfb18c4d4ee6434537b0c8b [13/16] sched, exec: Factor current mm changes out from exec
config: x86_64-randconfig-m001-20211118 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/sched/core.c:4982 __change_current_mm() error: uninitialized symbol 'old_active_mm'.

vim +/old_active_mm +4982 kernel/sched/core.c

4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4938  void __change_current_mm(struct mm_struct *mm, bool mm_is_brand_new)
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4939  {
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4940  	struct task_struct *tsk = current;
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4941  	struct mm_struct *old_active_mm, *mm_to_drop = NULL;
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4942  
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4943  	BUG_ON(!mm);	/* likely to cause corruption if we continue */
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4944  
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4945  	/*
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4946  	 * We do not want to schedule, nor should procfs peek at current->mm
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4947  	 * while we're modifying it.  task_lock() disables preemption and
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4948  	 * locks against procfs.
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4949  	 */
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4950  	task_lock(tsk);
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4951  	/*
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4952  	 * membarrier() requires a full barrier before switching mm.
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4953  	 */
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4954  	smp_mb__after_spinlock();
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4955  
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4956  	local_irq_disable();
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4957  
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4958  	if (tsk->mm) {
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4959  		/* We're detaching from an old mm.  Sync stats. */
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4960  		sync_mm_rss(tsk->mm);
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4961  	} else {
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4962  		/*
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4963  		 * Switching from kernel mm to user.  Drop the old lazy
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4964  		 * mm reference.
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4965  		 */
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4966  		mm_to_drop = tsk->active_mm;
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4967  	}
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4968  
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4969  	tsk->active_mm = mm;
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4970  	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4971  	membarrier_update_current_mm(mm);
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4972  
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4973  	if (mm_is_brand_new) {
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4974  		/*
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4975  		 * For historical reasons, some architectures want IRQs on
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4976  		 * when activate_mm() is called.  If we're going to call
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4977  		 * activate_mm(), turn on IRQs but leave preemption
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4978  		 * disabled.
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4979  		 */
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4980  		if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4981  			local_irq_enable();
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03 @4982  		activate_mm(old_active_mm, mm);

"old_active_mm" is never initialized.

4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4983  		if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4984  			local_irq_enable();
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4985  	} else {
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4986  		switch_mm_irqs_off(old_active_mm, mm, tsk);
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4987  		local_irq_enable();
4863118ffa6fe6 kernel/sched/core.c Andy Lutomirski  2021-09-03  4988  	}
---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

