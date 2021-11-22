Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB76458C88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbhKVKqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:46:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57036 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239066AbhKVKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:46:11 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMALqJo024892;
        Mon, 22 Nov 2021 10:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=b039fn3bsnxlfvTpDlqmd1PJo3nfciT05nsDluWW8ps=;
 b=ZtYDHT6+1VekUHnr1JoHICu4NkuhmRUfM+9bka0qcddYm10z++8xMXDw7muu5UP/DnVI
 naFpyRxsyxOq4U/VbEATKYXuMvPQCoALalXbVneGwiMgAFR7mbUrmAH592cj5pWSfscz
 guTUwarS/LH6dmcDoi1rr410xzlTPVHy+IV+kL3tMPGW9wSYXBpVg9qjdbV3zfTTyPE5
 IYLIndfMz/Kbu8XMiQ+VZTT4RkIMPcMHzSDAkiidZTVG2vJnYdZW+mV6kVWNQvbiT9kZ
 hBG2Vj0I9ZDVD9BcTy+P6e6Ql804WZ4LaU4SO9dj+pvUPwz870fUNELNfR7SHhJ6H/V+ WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg69m906g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 10:42:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMAUn5P023630;
        Mon, 22 Nov 2021 10:42:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3030.oracle.com with ESMTP id 3cep4wg5gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 10:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7JSDcrbHFOGm8nTojSwA7GYwYlr00pM7E2qRclCoZiBVWXQNISZi2y88Uvr01pzY4VOEGTuwj9jf0JRxaFR4L4IRKUugNWumVcxH3IcdphPBHtexoPPPZpzeCaChpzawRTqqjOO4l2xIkSS3EqWUHwJm2BoWOmU6aRufK8ucCKjDyFNBfyz/4HwIuCMct8RHpZSxh5gt3Jn3LHueK4RCaX7eV4NmFVfizQTs64aa8WPang5BWAoC68MueZXAPB0NaKzNBXW9PH0Q9ulL85SYkT/CAnb5wj7zSY/HexOWivCuo0BI/KR4A74tr6/tqa6cOgERW5rPqDbYkOKPL4PZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b039fn3bsnxlfvTpDlqmd1PJo3nfciT05nsDluWW8ps=;
 b=aK53SpsmEnBLXxuux+1vhrsxW7jtmIC08ZL9ajGUUiwGcnuuSfi+1qc2cX4bnF1rklr75BlVPESmAYKcUdj1qGuktLUIdu/7nNoH3IMWwdCN6C5Fyfu9ISfLJOVGohjPWwYD8yHnSkSkapHKDtOFJ4HDEud5nJE6OtZWZLM1DcetvDKZnpBbETpC8uILAKmxhVsP9fP5C7v9ZmZFwV0hSZGJIL1UNbucgQKGxLKSjOnRQp1fi4LM7+wbgYrPvDl4mdpfsuJpTwYmDFOgc8BjimUoC9qAT0onnsLadUEjTEttPNimhSupRKhMkakS9420MWeryxXnAsvIY5tBaGVErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b039fn3bsnxlfvTpDlqmd1PJo3nfciT05nsDluWW8ps=;
 b=pCXQE7yLankZanA8E6OHw/6XsS4LnU1SISIZIaikQcPIwKwm7AmD3BiA44x5wTjfO/8agp0qrxI3LK7Es/IS7w9L6eoeUkB1Ird7LFzXu24HnlhEeZhaHMqDNRN1Ltaq/9xAWPBpWifyCTQ6x1QZiUXVszXGwHjCj8BGm2DutC0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5792.namprd10.prod.outlook.com
 (2603:10b6:303:14d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 10:42:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 10:42:52 +0000
Date:   Mon, 22 Nov 2021 13:42:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [ti:ti-rt-linux-5.10.y 7558/10206] drivers/media/mc/mc-entity.c:443
 __media_pipeline_start() error: uninitialized symbol 'ret'.
Message-ID: <202111201702.LfMucF9O-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 10:42:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f7af34-23d0-4cb2-a85f-08d9ada4d5b3
X-MS-TrafficTypeDiagnostic: CO6PR10MB5792:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5792A73D54FCFE684BBA7C298E9F9@CO6PR10MB5792.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1WnwSrg7c8DjeP0cZSYPEZ7GgWU6NUh96lB+UROVy4thgZIBxUTqD+ri/jpk7jdIEEHnnDLflQNlDX1ICRxAePAw8s7dbxlkrDhklVr0EG1x5V0+RS27SawMRP10fOj8fBqBJPL+wPQ8lZKZL8Jo6bF5IA7Yxr0tPkxaq7oWk2W3u4OdWh+jrkCQygP6hZI6QILOwTVV31M3qGGBWRx1Z9i0HDEiX5SMqXmtRRnWBv3Rk7lhFNUheAu35KzfqcW7LupVKiqUemR58nmRNVbWG1Yvq3hoIHS6o2fdwOxDYVb8r6dGh9PqYf986l//bJ+Shpr96EV5qml6u3b/W0eoilvNYhmGNzrnY56JJkfJndNSX3Fwd6/Wf8JwySsiczBZ+2RMtdGHJt0TMwP91aCfwy77gxfU2evXoXAW7noSCRBqByhAaoiomYBvgvCvQV15ON9wpI3e8J2oKvj7LqR8365drWN6YGtNfQFxshOJzVl7B4WV3Gi+XM1kcfDUlKOCUJkiPfD5EbmeyAEHzsQeUG9IXboOsPgmmtTlSQahMvHeACgod5SXzM3Cf685VhqJt/cLYI2mgxQJ7A2O0QPimdRBPPpyx5FOLztPPlaA3FFKdnYp00K4g9OYhs82ok2mzq2+XoRnaL3mEmlsC8SVdaawoLxX5ZJLoG2YFQwqzsuFTNZCkzXdrmJThT1b0dpg1EWueJruhPnOAMONzS6EeXwfkEyzgCIhss8LCyy5GGE78FUnGBsFvTM+Eum/1/W+CzAWOXl1na2dTNSdiIqjoOp+GS/wf6+0VpKRyrYdG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(2906002)(8936002)(1076003)(9686003)(6916009)(5660300002)(83380400001)(44832011)(316002)(956004)(26005)(6486002)(52116002)(4326008)(36756003)(6496006)(86362001)(6666004)(508600001)(966005)(186003)(66556008)(66476007)(38100700002)(38350700002)(8676002)(66946007)(4001150100001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YU0lDH6FjFQ9odGYR9Jagjmt9U2fkPvKvRGf6rjYUd0NmsloF0sZic7Mf4Pi?=
 =?us-ascii?Q?hRCk5CTjwvYna1hw/+msQPYUkhBp3DifWY14NwPViiPEsBZHMQEzxuOAppoj?=
 =?us-ascii?Q?/B0B2lsksKSE2av+R33o4sGULgDqx1xhufsX13UjVxSAnBkpkAhiT7Sq3tRX?=
 =?us-ascii?Q?NNue+ZtsjRgBSH2KBkxpn3HgLANwPfNfZV9U4vmpawn32cwdb7uDEfwTivVG?=
 =?us-ascii?Q?hAdpK81DoAQ/5J4vlPWgi/zyan6CQgdkw4KjrU1J9XQ0s0Z9ywHZ0pFf/sdX?=
 =?us-ascii?Q?UJFKweaQ5DBaZX0Wy+eQC/WiVlTVxptnWxS1FdaJlRze1hu78N+alAIKi6S+?=
 =?us-ascii?Q?m3Y0F0RHng3FdWq6J9GJxVhsviYqulwFfBDQ+alay8J2DcSk5BNikpUrIGmM?=
 =?us-ascii?Q?mMnyPUFFwJG5kBRagMwr09RTtNvhYalKhah+YRofPYELKuCD0Gg2izgRoh7n?=
 =?us-ascii?Q?QXeQCSVNE2CJ6CjhW4+4ylCfTk68jKd8MD4mVsXN85+vChx4yuKWA7k8mbs5?=
 =?us-ascii?Q?plx51ZJa+wLCdOfBjgmQ7sexLxnN1LjTNG/coRayFUj72JSnoZmssAJ1CDHY?=
 =?us-ascii?Q?YgxS0KlD1M3i+lbg6C4tQA6Xxodcq8g1a6lXSUQSIMEAmZy9uwBa3QO9Nq9Z?=
 =?us-ascii?Q?6xmk5c++ZMbEFDuZa21H7pmc94nLdRL9SjAfM38RfrXjXgJNq4YlBrgpVqAY?=
 =?us-ascii?Q?eZGR9uvC8VW85iYHDlCBWrTgN/Ly6i5K1QbzOMVLDNY8unfPEEGItlPF28PO?=
 =?us-ascii?Q?nJxHzuzH9mZ1bTfVp0mdgIZ1HWfe8NEJTkUuPKovuDLQD0jYQchoEHnyI5QH?=
 =?us-ascii?Q?02wqIRJ6ZPL7rjKAR5NhEsS5ZdsiPzp9uLLayPf10QT1bHgBv9/jJsZ1mBJm?=
 =?us-ascii?Q?h4BBGXbB4bHCXh4hJ53CC263av1iXwOER/QN/PuhaLi7kTwTBO61FaHn7AbE?=
 =?us-ascii?Q?b6ITiFkIroTubQTKXW6yzMl/aDx2th8HH/+zF8A8FESUcXNp15HIgnKUKOu0?=
 =?us-ascii?Q?hI0qYRhDu7kaUe41d2JRrj7wRLVchJ2ObFLIsgDFShCrpcmtB1kzCOowf+i/?=
 =?us-ascii?Q?YP40CpBOfKKfYgnQUz10llVXW4sV3qJBVUjdb//tGFGv3WKHUGf0HFBvrfwZ?=
 =?us-ascii?Q?HbqlrZX+aTNM7ucHPY6Xxcf1UUJu1lsvBoXvdIBtDiQTKcuct1ZWgfiGfi29?=
 =?us-ascii?Q?BoDtGwM1Rt62HZ2iyNb/LqQZblo+8U3PL3/DY+Ki2nEabPoLarNWP3Zc+s5/?=
 =?us-ascii?Q?/6K/MpE1wsxLlbrXyKy+tEX79vsqxhzjIBGcsVmzIR0Tmca3D7eKfh+qPxiT?=
 =?us-ascii?Q?wN3f280j7qKE7/gCFnPoPwaZ0lfdaOdp3i+XZk0RmQJMPys5taWn1B63H3Ix?=
 =?us-ascii?Q?0sawf0hbrKW3gYM6a+amdY7aIX673P618aBn/GUJjp9UNayveWxUiEtjCiFp?=
 =?us-ascii?Q?y4wPfpl/bvYLg1JAzNZVgxg4VpQiiOgtloTD4RDgGGzhL6SlES/2d7MNdAhI?=
 =?us-ascii?Q?biqcJjLAC7xKoeL3wr1ZWJSSe8O8ajTm/va4PydUqfJrYuO86jmL1rCCXCDf?=
 =?us-ascii?Q?DHwtbxtjUQDQGcfNCYf/NdWQQTFdZMiioYwnrKJ8Hfs8KcxTcX1N+vEkBb71?=
 =?us-ascii?Q?uvQNxN1J7fuV75IOsVvsvHsU9i+POI32ZUnYd6EFCVgpEIHmBVPcvLL1Z5Kx?=
 =?us-ascii?Q?wMNr/wVSd9ep3H8ULkGSp6HRsHg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f7af34-23d0-4cb2-a85f-08d9ada4d5b3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 10:42:52.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emfBPAHauHVEY1OOYlADV5ZQO080uAGpdenobSOreR1CovscElYAAKSzmUz9/Tl2oNUMp3Lw1VL8qD+sg3+YWPXfMo9njPeUn75vEV1k5Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220055
X-Proofpoint-GUID: 9efAF-glQTDuASYIw4rwdKbUpro8H1-8
X-Proofpoint-ORIG-GUID: 9efAF-glQTDuASYIw4rwdKbUpro8H1-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git ti-rt-linux-5.10.y
head:   0c67d996db8f3c9149598bc98657ae28fee22208
commit: 80dac899053d08524a40f195905022bb08e6104c [7558/10206] media: entity: Move the pipeline from entity to pads
config: x86_64-randconfig-m001-20211116 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/media/mc/mc-entity.c:443 __media_pipeline_start() error: uninitialized symbol 'ret'.

vim +/ret +443 drivers/media/mc/mc-entity.c

20b852273642f4 drivers/media/media-entity.c Sakari Ailus              2016-11-21  406  __must_check int __media_pipeline_start(struct media_entity *entity,
e02188c90f6ef6 drivers/media/media-entity.c Laurent Pinchart          2010-08-25  407  					struct media_pipeline *pipe)
e02188c90f6ef6 drivers/media/media-entity.c Laurent Pinchart          2010-08-25  408  {
d10c98949d1a1f drivers/media/media-entity.c Javier Martinez Canillas  2015-08-19  409  	struct media_device *mdev = entity->graph_obj.mdev;
20b852273642f4 drivers/media/media-entity.c Sakari Ailus              2016-11-21  410  	struct media_graph *graph = &pipe->graph;
cd448544d8c6d3 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  411  	struct media_pad *pad = entity->pads;
cd448544d8c6d3 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  412  	struct media_pad *pad_err = pad;
57208e5e25f263 drivers/media/media-entity.c Mauro Carvalho Chehab     2015-08-07  413  	struct media_link *link;
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  414  	int ret;
                                                                                        ^^^^^^^

e02188c90f6ef6 drivers/media/media-entity.c Laurent Pinchart          2010-08-25  415  
74a4133079f739 drivers/media/media-entity.c Sakari Ailus              2015-12-16  416  	if (!pipe->streaming_count++) {
20b852273642f4 drivers/media/media-entity.c Sakari Ailus              2016-11-21  417  		ret = media_graph_walk_init(&pipe->graph, mdev);
74a4133079f739 drivers/media/media-entity.c Sakari Ailus              2015-12-16  418  		if (ret)
74a4133079f739 drivers/media/media-entity.c Sakari Ailus              2015-12-16  419  			goto error_graph_walk_start;
106b9907c368e3 drivers/media/media-entity.c Sakari Ailus              2015-12-16  420  	}
106b9907c368e3 drivers/media/media-entity.c Sakari Ailus              2015-12-16  421  
cd448544d8c6d3 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  422  	media_graph_walk_start(&pipe->graph, pad);
cd448544d8c6d3 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  423  
cd448544d8c6d3 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  424  	while ((pad = media_graph_walk_next(graph))) {
cd448544d8c6d3 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  425  		struct media_entity *entity = pad->entity;
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  426  		bool skip_validation = pad->pipe != NULL;
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  427  		struct media_pad *iter;
e02188c90f6ef6 drivers/media/media-entity.c Laurent Pinchart          2010-08-25  428  
ef69ee1bc2c10f drivers/media/media-entity.c Mauro Carvalho Chehab     2015-10-01  429  		DECLARE_BITMAP(active, MEDIA_ENTITY_MAX_PADS);
ef69ee1bc2c10f drivers/media/media-entity.c Mauro Carvalho Chehab     2015-10-01  430  		DECLARE_BITMAP(has_no_links, MEDIA_ENTITY_MAX_PADS);
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  431  
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  432  		media_entity_for_each_pad(entity, iter) {
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  433  			if (iter->pipe && iter->pipe != pipe) {
3eb87773dee633 drivers/media/media-entity.c Shuah Khan                2019-02-22  434  				pr_err("Pipe active for %s. Can't start for %s\n",
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  435  				       entity->name, iter->entity->name);
8aaf62b5b9bef7 drivers/media/media-entity.c Sakari Ailus              2015-11-29  436  				ret = -EBUSY;

"ret" is not necessarily initialized on the success path.

80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  437  			} else {
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  438  				iter->pipe = pipe;
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  439  			}
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  440  			iter->stream_count++;
8aaf62b5b9bef7 drivers/media/media-entity.c Sakari Ailus              2015-11-29  441  		}
8aaf62b5b9bef7 drivers/media/media-entity.c Sakari Ailus              2015-11-29  442  
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14 @443  		if (ret)
                                                                                                    ^^^

80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  444  			goto error;
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  445  
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  446  		/* Already part of the pipeline, skip validation. */
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  447  		if (skip_validation)
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  448  			continue;
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  449  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

