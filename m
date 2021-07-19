Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048E93CCE22
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 08:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhGSGy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:54:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51398 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233689AbhGSGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:54:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16J6g0xY026696;
        Mon, 19 Jul 2021 06:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=SwEjNL2Gfb/ZCwlTPKvh241c6UoJUXjagmK8wxXFpQw=;
 b=nkTUpwmCLfX5dojG16nR46TIZ++XU8x1noDKWjrUabRWdCNTuMtkHLlp/lMe15S6jDiG
 neQkkMxKL4JeAhMnmuwdX2hZ4WjybcBQw2Bhq9Tva6Jr3EOOQISBUtY2qcXkdDQl30ot
 GIqJOWQiE1lHBxgdp56U3P4mmbWTOU2CKP0efTWa42WWu9m87NnRfx3Ip/8vMIg3tIDc
 6kmFsoMHYXrV9Uo/9dcR9MCv06pRP593b9BAW9l8qlB64VNLyynomauD65F16FmCaLcq
 boDPEzHcd7FuMRZjlv/7g7dncqYKpyFHLcEJrwld0o/9IbvTWahF/Tmn/jBjuQwN3jur MQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=SwEjNL2Gfb/ZCwlTPKvh241c6UoJUXjagmK8wxXFpQw=;
 b=tHdaFQzFVCB1h1pbgasZJmoAd8foyi0QrZiUlIr3xDgNVrysffF5Bt3fHEG3jiz/VE34
 LK4D5UiE/S9KNFKzE9JFuYgFQ/uDoHn5cqtvZVaGN9+rAKW37V8goGqcU2E76hbd5V/p
 wFk1dYN2CkAqP9tRZDCKNPBJ/Vf4Mmd+VcY+FUvHv2EJFU6npzUYQJBENWj9b7+pig5s
 9CMuyn5W0mfeZKXiDnxJTSgpx8yyP7X65cjmAAD4l7PLEwKVvpSHqgaSqqOhpLsCa2V6
 16lnsW7+fkW/pQZREcF6YZ4OSGy1ZWu7sbN8PtWSUGtF73KxvHL4+gGPIMogG+VW+QIA Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39uqrtj7ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 06:51:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16J6pDLY080930;
        Mon, 19 Jul 2021 06:51:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 39upe7q5pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 06:51:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNEFhmkxDi7tHYaw/JDVPB/wuqQy/bvr6Rm2rTUgdFqE+7fnhZc/gaVJsvm+zznaCI4HZKm6mxYqTFWXEFhgHgh/6lb8ojuhatOBl/GEd0j5Kg2WrRcc1h+INHJsOhTb5EYr7RSY9JiZoJOZ3S5PMaAMEOkHM7G1t+nPDlx99wLG3gOArJB8QYDLsdHMC1AIz0mgelSjX6pC6bY/mF9HA1VqwdGqOgTduUhpWWJz7u4X1aq31wN5sMbujQctME2Y4RJqN7fPhGsPp0irmOnadvnpOXlXjK7NXhXi/XawzuRg2zFywblU+tHKyOwtpcp+dDw+6ugRA7aYxhXuwpVpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwEjNL2Gfb/ZCwlTPKvh241c6UoJUXjagmK8wxXFpQw=;
 b=e9DhK1cDcH2wMNuUYlsn3BBrWpJ9y4+eidkf5/44PN1riUpTm8NwJUHCVwlZizLyjSsi2aggFjVDtLfIKQ/zuY3dFwGYWYWz3xcexyTIvVwYnobNCW2PurYdLNCAdQGV8UJwqC0Fv8pMj5bbGAhBIshxlTmsdPHO3VBmnq96M1ZWQNcqmc5JSRdd9t4lxUzAU9d9a+pd0YVGEU9ZnanP+zhvX37KCYNpWSyHD3Ys4dI68+9BzviTlWY0Nl61b28FradyhhioY4qatClOTBXf70GNYojk511Uc1deUgMl4gT/GcYdX/IeCqPdCbcksHE0rTWhnqy6N5qK5015no2Viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwEjNL2Gfb/ZCwlTPKvh241c6UoJUXjagmK8wxXFpQw=;
 b=hmlDziVAKX11QzkzRcufM7XRVgoPx455xK6kjakxoi2mU8xo8hDJGBL6TapHO+X8DTqI7dRLkg9/nKjS1UtuBJ+eatWAUOBs4K4LhdNyOzzHncMARZqV/Xv41EHvIxn32Rljav746Os4SU/YQzCRnStStrmCWlswiOFpRp02f0A=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1997.namprd10.prod.outlook.com
 (2603:10b6:300:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 06:51:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 06:51:11 +0000
Date:   Mon, 19 Jul 2021 09:50:50 +0300
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
Subject: [ti:ti-rt-linux-5.10.y 6720/6782] drivers/media/mc/mc-entity.c:443
 __media_pipeline_start() error: uninitialized symbol 'ret'.
Message-ID: <202107181703.hbuG1b05-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 06:51:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7b44c98-43eb-4971-e864-08d94a81980d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1997:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1997DA9CC9CBA63CC42964258EE19@MWHPR10MB1997.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npzDOI0uL0yDRoHEs+OWZ0hfE7aG05zrzyGUbxWtEQISDZXSsTI7fdBOB5kE/7bbcsF++JA09BmXRy7gU+EvjswCwXo5rq3QLsnaq2xpB3PwSGai9hzuxNSL8QZxoNzOQuAYsgb3s4Xwu6aKi6+9gcctG1VbwmEDcdmUL5wT6orGmz9ldNf+AnAy6xtGvE2CtA2m3XrBN+iXJVMJAb1mVVhxR3pHVramM6a9mgyCBlTP0H7GFb7xX6pEQ4BGYxpHink8K9tDKZ7KWrmULbh33gLXtHOn5eInCglkm1tvqLmMCNEp2G5ml2egqkXU2YPy+xRJklgYGMrymSoRw3+gJCzEuWGf2oPVZcKchbrXJFC0QcFJUq3HCu18FW+V3nkkBzpjuwvLWi2XisV098Ep2RubneINW3Ww56tZsTRAf4QZ+88Z3haa7avn0RAaBFlQ67Pj9s9SjFBWOIEK3EcB8PzYI9dRm8aAK+xc7z56TixE8Ac71Fd3YpEfsE0JC+ulnoUodeqO/mL68XH/CzfrTj6MCYlgbqjV8oDsm8Bqb4qkD4POxncu6WezKIDaiBeVEwrEndkCOxUD/YASFIDsBq+3BOL5Hr2bHQNNRfNNRKzEJe4I/6GGQnfaXV+XQIfvJpjeKawVKml8ziEZCS/Q+95cTlS1sg7aVj7GuzXFNdR0H943As8ruODze+qOmpgo4zirztcuZrEylb8TfUU+P6BOjhUc/VOQgXwScb0rRKeKvWTnIprHBXAnbcJI3VfKvTitgBZYR0Z9npyU/FX+6YgzOKSXZByN1m+NrMXrE+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(366004)(396003)(346002)(478600001)(83380400001)(6496006)(8676002)(86362001)(956004)(966005)(6486002)(8936002)(66946007)(26005)(36756003)(6666004)(54906003)(4001150100001)(1076003)(186003)(38350700002)(44832011)(2906002)(52116002)(66556008)(4326008)(6916009)(66476007)(38100700002)(316002)(7416002)(9686003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0JMbeIrKTN8BT7GXZXvPwFNO1Q2pZwbJEoH8Wgk26pXKBg7oMvFGmWusbBxL?=
 =?us-ascii?Q?rmls7pXE0PclzCwNrVwAiWqny14Of7UzrQA3eVCYkoLqOBTx42P2c6jYop0n?=
 =?us-ascii?Q?WfrUZ0H3k42UmhQ23In5BAgqY5CO3Ags5ZMTee3gBJXMXuIoekwCelFS8FJj?=
 =?us-ascii?Q?qrjnQ36RINJ/VHi9w/yQ3kdpo5WJBK2EuhqLbeWO/QcBRg3ip1XS/70s/hIE?=
 =?us-ascii?Q?KlhakXNunm+qrdjRkFQOkjf+DM2JUwr1yrXKlWONLEyWiNIxUzqteZv9x+h8?=
 =?us-ascii?Q?+006zxCyTXAZXP1glhr60rQB3hYZKER0lP9fwELvdvpK7R8VjfN+J8bNtsg7?=
 =?us-ascii?Q?yuL/W3eZxy7f3m2IZEhXgJyTm8nCDoFYIn/mGaIvabxFlMHGUnbVkd450pfn?=
 =?us-ascii?Q?Hm+8PJtk89B/e0opRo7fI5UxxzXCvCnm1fryVallL+BeRmIQKNkvdntmg89i?=
 =?us-ascii?Q?ihrtaMaNSjMRk/cGg1zD1ClIxuCzjX9wnJB+JI5akW29X0VWEoyab0gednVz?=
 =?us-ascii?Q?Q+mZrwjoxifk1KZW70TKzno48hbL6xGC8Ko6kfGmZ7o3j/syLoIYEwZpQbiL?=
 =?us-ascii?Q?Pc6BKWDa2NrH2fQW//DEAybq2K+JbqiPv1rTFBVT2vl5T/03OhDjoj/G+w7d?=
 =?us-ascii?Q?QBZLMbDnfb5295UPhQx35hggxBb7voijgmSYJwZohdcXeibmhgaLHOUlwJZG?=
 =?us-ascii?Q?swntV5COGnCfYtHHiorSpKTcQLraPiij5AkBlNw80ZKS3KkpEgtH7YDPYsjC?=
 =?us-ascii?Q?23IvZ4dbmFVK1u3OnA+MKQZufDKOsNpzdUmk90I2B/z7SsRvgO9TrLCXXqFn?=
 =?us-ascii?Q?PIippFjlxd7rS2ti52hMZDXCg5UAjFz6AgwyH2v1XqPWuYLOWuTucRkNUZ3/?=
 =?us-ascii?Q?lXHJxttsoubf2kZVEt7MRTt6gGao2Eth249nc3j1ZLF1DOogEzGTwi0jpVVa?=
 =?us-ascii?Q?JB9M2hMSLsO8pI5cTvIFjyhPHhR3cErQlMNMmr8iLUiXFFUtJxAiF6rJTz10?=
 =?us-ascii?Q?Em26d+YqAkTH08qOY/aMZwu5oJJRENDhWsMEXmlgdsuSLjsLZDhghb26R72K?=
 =?us-ascii?Q?lPGH9Q+exZrr3C7A87B3J+VjDzyc0kja3qc/A1PayoVWo4idzn/vrMevn25e?=
 =?us-ascii?Q?fR4vUB1zK5znB5v37Co04kme6laSup9hm9Y6x9AYxOOLxrDyLST7JO8ysqpE?=
 =?us-ascii?Q?EDvHpYMUmoK67l9fPSqUl7XOI/pic/SnNT1wCVg3L9+squPgw+W0Q4Khf1/3?=
 =?us-ascii?Q?DMw0+d3rSGhKX1vnTnyBiorWUtkkvp7FJcc1fr3JB+W/rudaU3bovq8+taEV?=
 =?us-ascii?Q?f1CMp2w+2dBrHBglvxmEIW3l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b44c98-43eb-4971-e864-08d94a81980d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 06:51:11.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dh5Kp8KQyTh3ZW5UdUuYTKmTKwqsdAvbAPtBlTs/t/ILkzzvqinuLdI487/vzA1+8j47hN/yrWlylJKJO7jYYVxa5ztpyGSKwhv8ItAKbdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1997
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107190038
X-Proofpoint-ORIG-GUID: A2qt5t_9WkxS2tChgqMJrF0M33dtJmsV
X-Proofpoint-GUID: A2qt5t_9WkxS2tChgqMJrF0M33dtJmsV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git ti-rt-linux-5.10.y
head:   bee192299392dc41c94f4603968b7a3c02f17a1d
commit: 80dac899053d08524a40f195905022bb08e6104c [6720/6782] media: entity: Move the pipeline from entity to pads
config: i386-randconfig-m021-20210718 (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

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
e02188c90f6ef6 drivers/media/media-entity.c Laurent Pinchart          2010-08-25  415  
74a4133079f739 drivers/media/media-entity.c Sakari Ailus              2015-12-16  416  	if (!pipe->streaming_count++) {
20b852273642f4 drivers/media/media-entity.c Sakari Ailus              2016-11-21  417  		ret = media_graph_walk_init(&pipe->graph, mdev);
74a4133079f739 drivers/media/media-entity.c Sakari Ailus              2015-12-16  418  		if (ret)
74a4133079f739 drivers/media/media-entity.c Sakari Ailus              2015-12-16  419  			goto error_graph_walk_start;
106b9907c368e3 drivers/media/media-entity.c Sakari Ailus              2015-12-16  420  	}

Not initialized on else path

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
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  437  			} else {
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  438  				iter->pipe = pipe;
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  439  			}
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  440  			iter->stream_count++;
8aaf62b5b9bef7 drivers/media/media-entity.c Sakari Ailus              2015-11-29  441  		}
8aaf62b5b9bef7 drivers/media/media-entity.c Sakari Ailus              2015-11-29  442  
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14 @443  		if (ret)

Only initialized on failure

80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  444  			goto error;
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  445  
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  446  		/* Already part of the pipeline, skip validation. */
80dac899053d08 drivers/media/mc/mc-entity.c Sakari Ailus              2021-07-14  447  		if (skip_validation)
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  448  			continue;
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  449  
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  450  		if (!entity->ops || !entity->ops->link_validate)
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  451  			continue;
af88be3887c1a0 drivers/media/media-entity.c Sakari Ailus              2012-01-11  452  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

