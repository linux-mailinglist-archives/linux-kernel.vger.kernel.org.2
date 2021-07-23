Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552FF3D35BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhGWHNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:13:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7766 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233291AbhGWHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:13:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16N7jvSx016395;
        Fri, 23 Jul 2021 07:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=/CLyHRu4gGKUnhUcghLI/PGVrLwDaHgStMQigwdia4Q=;
 b=usqvojMmRNDoh0GcxBzenWedavAbNlIDElvPJYrfSt8mLGd9SwCqVMMNd6H2AgL55MfP
 nJ0ZlY/00kC7yFwhOqAdmuEPtixDx6PRoGCWm+I9sUD6xn72SUbIrhopHcpZnt+QvwC/
 AWutfytSQISh0byw6kL7WdMUXcDCSPhUb4PYsdSab5sguLbtpnEZr7nrCOHFOzPNMdlF
 E1Rws+llFcPXUAaUhKgBWYZ3ibil9xMmmGNSYwXum5TdSoJ5JjQFT4iSzOwP71qaS2PK
 RVDKHRJOaqnGFUWjo2ePYLborpLhfNzWYHWiAxkv6u1qY6ZJYRbi3XAPXxcV7Y/UPosC pg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=/CLyHRu4gGKUnhUcghLI/PGVrLwDaHgStMQigwdia4Q=;
 b=MQ50y2Xc712NWcrRdO5PMxZq/1AvnfcP5k9sTs8DaNB2fFuSEk1Tb1b7ioRSdgYRzlKs
 b1B+sgk5NRcna34POnvUshXVNO8194kbka6k2LECDmejU/5t+2+FnqI+DxnjDwJ1xFKY
 RKKWvrBNUxKd17UtO1nu/EUfssq4DmsLpix5vVmLs+Jpm1Lmq1kawXDqktJ+lI4qIZWG
 9n5DyDblc2jNxA2DFK5JN2opn495vJy2ZyiAT7aLeAwbMLUsNjVsu5748f35cMYXsOw5
 DvJeJE5OLiC16bN42ZMcpUxx8GWKAl1fthl8iMNBNJMhKE+zQEo3HILCl/AWrXKlFuJM zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39yesmryvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 07:53:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16N7pGOq080778;
        Fri, 23 Jul 2021 07:53:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 39uq1csasa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 07:53:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXYuKTSP074ziCPU0jafAqDLG/+OTdPwS698KcCAvb9tume1r7wOh2l4MhcHHYxnK3nlVAK0KYK0nN97VKFPVYrq4VrlKlYBiz6aD9xewDkoAHqzLQzmaA1kWQzaRdv3oXoeGG+y5HtPbBwIzc3PB+dA0tmbrqRRyubCfAf5ATwWpL/D3nUXgfKzOwLMHnc+LkELF7NxYwwZV76eKgCx1AysijXbC7JMWo58rjHSaMDhr9Cm4U3Dkbhewq8t1l56jMTWPrL1Syk/sgy/7NDT/qRWk7FOhQvtlpZ7fbDwlLBUC+sZFYpBHOONfpolBd0edEwE5meylcYnHSjHPhbg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CLyHRu4gGKUnhUcghLI/PGVrLwDaHgStMQigwdia4Q=;
 b=MQw49VnvAywsDLpIEzZemDPvr37hqGIAq0NfWjbvhR5MuTk2Il5l/ZLGwPp+gtO/9RvVKL8Y57WYokZPLC33lg+bTu3oybToAsd1bv4Zba+QsQIGhFuH2eM9G0DgyaKTVDoqj3QqiD3Xbf0NF4juLhx/v5Quvk1E2fy+T2wwyvy7tTbC7xJqilNqGmsw7S3HkIlFoPUCHquO6an/EZ7ocP41POuFl19yLCDCW/PhYR2WdolxJE8jP1KjWzbYSh/w2hgs5Vwmdf67pJe/49z5/j8EFDkj599a2UoXj8HpjYTeTy5RbVN2M8Z0vsTsZMshk+xTfg5pj4IUx3Q62Qeetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CLyHRu4gGKUnhUcghLI/PGVrLwDaHgStMQigwdia4Q=;
 b=GPQkkodcHMveEao++Rv1kBDC+IoVi9eIFryym23AKw3R/0WPDLtMwxTchTIymCBBHWXkcqbVXr0sCjPwQv/h3/eALHLQNPduVmrC1JLbIPdkVJhVP3XZIMA5bD3ftvNVwVJ8+RO059Czx8hE+uPYhcLKi1XC3ionaONHJivEff8=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2366.namprd10.prod.outlook.com
 (2603:10b6:301:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 23 Jul
 2021 07:53:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Fri, 23 Jul 2021
 07:53:56 +0000
Date:   Fri, 23 Jul 2021 10:53:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luo bin <luobin9@huawei.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] drivers/net/ethernet/huawei/hinic/hinic_debugfs.c:92
 hinic_dbg_get_func_table() warn: returning -1 instead of -ENOMEM is sloppy
Message-ID: <202107231519.Yk44IWtF-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: DIX6TGV7MERMSCVFWJNIQHTX72DUJ4YU
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 07:53:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 397e1a27-ee02-4b2c-4358-08d94daf0577
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2366920C1E3A00B2A3F5E0B18EE59@MWHPR1001MB2366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:209;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6oFyBBY+VUUV6wSrQyhWLUTVd9E/6F80b8rbIwWVRXHEp4/QT3BoeDh1U53x+Na68mnQNhzAMWYLeqxpBXRTYgNlCvB+JvuQU1VWBMtaCA3q3P1po5jPYDO22sMJFxM4mGtMMzpMlxwRMQEW0MfiKlrQV5BtGXoVq1JCcna8HYPjYx2Pkn3peJFbNJDOvhRyVVTe8M96o4VWJONvCA0UdSBSN5E8QtxP2NSqIt6UGtN+ZJ2MtzRjQnutGhYD/iYbJQURSATuC2H8CDaFN+ZRXwhrSvOyBQWcz1z7J3MoM6fWnvMtt39mQb7aPJnmBOX6Kl1v05A7u6QZShCEgst7h1Ub/ioAT3avL1E+C0kpe/r9/EWDw1deOY0JUq9HHiaV6OkEPOXrkdcjQ0QW7u/QsEoyGNHgqtUFc1vA+8bcwq+fOVGeqFs+FguzP/59MedqkoL3m/uZyQnDmLONLYNHTviD5BiydqarmpxNPcQu3sJcWV7sVTcNUkKVgqHhYfpXgOWjSOCmHUIUoTyIVsTiaYP4ONq8MSMSrbitbdVpUSuOhqkPWKT+9ICGYOfjR8EbG87MZoJEPEKNUj0BIQrrvev4hez2aF1WTt8KlAv/Xe7MzA1OZKSknbn0x4Kf1NDmnJxR3w2a7aUAfrTJBtYOT4FJCemC3o+17+z4cVnpVxO9BncslkpZsI+r8EOtqNwOe9qm8Lo53yd7LVdw78YDATvwmplDNJBRQH10bzgdg+EgoPMlp9yVSzTWas1nS+PpgZ167ujt0eS6BvsHdYjLizzcFH6Qttl/WnE0JpATZgfN5tPpaLOcTLe6ydCm0pOgoTJ6waiPf8EN3l+f7TgQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(136003)(346002)(6486002)(186003)(8676002)(36756003)(86362001)(478600001)(38100700002)(9686003)(66476007)(26005)(5660300002)(6916009)(66556008)(52116002)(4326008)(38350700002)(6496006)(8936002)(1076003)(6666004)(44832011)(316002)(2906002)(83380400001)(956004)(966005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o5+ErPc6ddsWPbtCIz/RKFBi9E02NyTCTPuxOY6CQ+S66CcFvL1h81U6srUA?=
 =?us-ascii?Q?dhlHYRkXtSSXMNR+InO7HuzwXRrimIWUZPNTUQn9gNj0P5XP4xwijSGJx1p1?=
 =?us-ascii?Q?D2m0rgC5u0vxd38edH8lOKCALZNn4wNnH8JDB5wKP7KebUi+sXUPpuduHyuX?=
 =?us-ascii?Q?S85JuVYxFDnScyZoB6eJ+s5apeUZd3ost5PG2H9HizUM54Rbakrw+zwWzAEY?=
 =?us-ascii?Q?bLYcTIQpRA97KI/ydRs7d4dlJZhhtaCpChdTu1+77pam1nVke1vkmy6hkHpa?=
 =?us-ascii?Q?ZbroC+QN25kdwztn/N7BmDUpj9qn35C5eSsQbhuUhqH2lDgHgK6WyzmLAaeY?=
 =?us-ascii?Q?zosOOqK+w2lU+m+5GHoSqEjlefgrJgi5+4HuxvfWzCi5GypcNzRv9ojE6tEi?=
 =?us-ascii?Q?0sP0/ESyohS2Bg1vLfN1zJeC7oeVVOIc2wM0X+2VY/Pgl6mnNpyzm4zqgf0d?=
 =?us-ascii?Q?/kb7acnrTxE5EGFjmwVxGrPpJFAgY6HAjhAD3nCzGhkx/ZJ08HQMpHnn4y6w?=
 =?us-ascii?Q?GcyDsiDeghk9NcHpRU97hX62JDGN7GOTXGgaMTOk5RTkJseZa11GwETSBmrf?=
 =?us-ascii?Q?d85NxrjqsY2N9hB1c1BZnZtz3CJm1IbiwDOucRuAu+tighOdFcdBkoRrVF/P?=
 =?us-ascii?Q?ltBvV131YN+2vtERTpr3FMGoK6I0YM09HMp4Ky7v/adm/UWObcv0xHSIQqzx?=
 =?us-ascii?Q?GBfMbGciGX3XWplBDRoi7oRLURtBkO7n6GIGvwR7uVXl6rJdmfVev1EdIqGC?=
 =?us-ascii?Q?Drcqau78+Yzu9g6pSY/Zqk4IsQ5kinNeaOuypYvq9Qe+/uePysr4a9REfTOq?=
 =?us-ascii?Q?9J1bWOeGLI1swcANWQEFOtH9L/r4DxnXt6NUqcUBjWJ1jiEIkYh3Dm2dHRWj?=
 =?us-ascii?Q?TD9s7D79RSQoLCRpFyKMxLPQ5w8Dame2o0pvBkd3gUC0FnvuwICzAR4wZqkB?=
 =?us-ascii?Q?OrXSVof2++Q+iEFaeab9XPQiboe3DKRON9fnjYyHjy5hFyHwqYzQDLwlemU6?=
 =?us-ascii?Q?FRFV7/JvqAGlZX9Z60Nmc0HBpgMJ/Gajuh7QyQdN07fmOejEgD0KfzgEiFl7?=
 =?us-ascii?Q?LGU2xG3NWO5/07g60FpqIOhuip9MVeu88CLy2VP/d9oJm2/4awj8iZLknE+z?=
 =?us-ascii?Q?kLs+PCM+BHZFKncqKPXJtGPtWliUPOG4dvb1noGhhscmg1SpWK4xMtRJNsV7?=
 =?us-ascii?Q?tlRdNr6scTGqceGKGmKz0BdPHkZJflTfO9Jl6Vv1xn2NXSJQex4Ak5VyscSA?=
 =?us-ascii?Q?do63LQBDdieWOYRGWQZJ9f8s2DWHnqtBIEfog9Ztrj6Az63ASpKdR5QWyrsN?=
 =?us-ascii?Q?IaEBEdfOss3T+UmHi5JFDlQ/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397e1a27-ee02-4b2c-4358-08d94daf0577
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 07:53:55.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6S4xZlKwt/pdBJVtTRP/SZBQz7Z+/E2k1oNFLN7A4O3mczpDCpUw1CAowe4CZbGTaouQwR2PU4Q6IBZdCTqRm7jMz9PQvGWvbEpzWAbphg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2366
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10053 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230045
X-Proofpoint-ORIG-GUID: 3UsMqpwjIC2js1fK44Xre4mU1vL031ci
X-Proofpoint-GUID: 3UsMqpwjIC2js1fK44Xre4mU1vL031ci
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   8baef6386baaefb776bdd09b5c7630cf057c51c6
commit: 5215e16244ee5889cc6135381acdbf4cbcb7905a hinic: add support to query function table
config: x86_64-randconfig-m001-20210723 (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/huawei/hinic/hinic_debugfs.c:92 hinic_dbg_get_func_table() warn: returning -1 instead of -ENOMEM is sloppy

vim +92 drivers/net/ethernet/huawei/hinic/hinic_debugfs.c

5215e16244ee58 Luo bin 2020-08-28   83  static int hinic_dbg_get_func_table(struct hinic_dev *nic_dev, int idx)
5215e16244ee58 Luo bin 2020-08-28   84  {
5215e16244ee58 Luo bin 2020-08-28   85  	struct tag_sml_funcfg_tbl *funcfg_table_elem;
5215e16244ee58 Luo bin 2020-08-28   86  	struct hinic_cmd_lt_rd *read_data;
5215e16244ee58 Luo bin 2020-08-28   87  	u16 out_size = sizeof(*read_data);
5215e16244ee58 Luo bin 2020-08-28   88  	int err;
5215e16244ee58 Luo bin 2020-08-28   89  
5215e16244ee58 Luo bin 2020-08-28   90  	read_data = kzalloc(sizeof(*read_data), GFP_KERNEL);
5215e16244ee58 Luo bin 2020-08-28   91  	if (!read_data)
5215e16244ee58 Luo bin 2020-08-28  @92  		return ~0;
                                                        ^^^^^^^^^
return -ENOMEM;

5215e16244ee58 Luo bin 2020-08-28   93  
5215e16244ee58 Luo bin 2020-08-28   94  	read_data->node = TBL_ID_FUNC_CFG_SM_NODE;
5215e16244ee58 Luo bin 2020-08-28   95  	read_data->inst = TBL_ID_FUNC_CFG_SM_INST;
5215e16244ee58 Luo bin 2020-08-28   96  	read_data->entry_size = HINIC_FUNCTION_CONFIGURE_TABLE_SIZE;
5215e16244ee58 Luo bin 2020-08-28   97  	read_data->lt_index = HINIC_HWIF_FUNC_IDX(nic_dev->hwdev->hwif);
5215e16244ee58 Luo bin 2020-08-28   98  	read_data->len = HINIC_FUNCTION_CONFIGURE_TABLE_SIZE;
5215e16244ee58 Luo bin 2020-08-28   99  
5215e16244ee58 Luo bin 2020-08-28  100  	err = hinic_port_msg_cmd(nic_dev->hwdev, HINIC_PORT_CMD_RD_LINE_TBL, read_data,
5215e16244ee58 Luo bin 2020-08-28  101  				 sizeof(*read_data), read_data, &out_size);
5215e16244ee58 Luo bin 2020-08-28  102  	if (err || out_size != sizeof(*read_data) || read_data->status) {
5215e16244ee58 Luo bin 2020-08-28  103  		netif_err(nic_dev, drv, nic_dev->netdev,
5215e16244ee58 Luo bin 2020-08-28  104  			  "Failed to get func table, err: %d, status: 0x%x, out size: 0x%x\n",
5215e16244ee58 Luo bin 2020-08-28  105  			  err, read_data->status, out_size);
5215e16244ee58 Luo bin 2020-08-28  106  		kfree(read_data);
5215e16244ee58 Luo bin 2020-08-28  107  		return ~0;

return -EIO;?

5215e16244ee58 Luo bin 2020-08-28  108  	}
5215e16244ee58 Luo bin 2020-08-28  109  
5215e16244ee58 Luo bin 2020-08-28  110  	funcfg_table_elem = (struct tag_sml_funcfg_tbl *)read_data->data;
5215e16244ee58 Luo bin 2020-08-28  111  
5215e16244ee58 Luo bin 2020-08-28  112  	switch (idx) {
5215e16244ee58 Luo bin 2020-08-28  113  	case VALID:
5215e16244ee58 Luo bin 2020-08-28  114  		return funcfg_table_elem->dw0.bs.valid;
5215e16244ee58 Luo bin 2020-08-28  115  	case RX_MODE:
5215e16244ee58 Luo bin 2020-08-28  116  		return funcfg_table_elem->dw0.bs.nic_rx_mode;
5215e16244ee58 Luo bin 2020-08-28  117  	case MTU:
5215e16244ee58 Luo bin 2020-08-28  118  		return funcfg_table_elem->dw1.bs.mtu;
5215e16244ee58 Luo bin 2020-08-28  119  	case RQ_DEPTH:
5215e16244ee58 Luo bin 2020-08-28  120  		return funcfg_table_elem->dw13.bs.cfg_rq_depth;
5215e16244ee58 Luo bin 2020-08-28  121  	case QUEUE_NUM:
5215e16244ee58 Luo bin 2020-08-28  122  		return funcfg_table_elem->dw13.bs.cfg_q_num;
5215e16244ee58 Luo bin 2020-08-28  123  	}
5215e16244ee58 Luo bin 2020-08-28  124  
5215e16244ee58 Luo bin 2020-08-28  125  	kfree(read_data);
5215e16244ee58 Luo bin 2020-08-28  126  
5215e16244ee58 Luo bin 2020-08-28  127  	return ~0;

return -EINVAL;

5215e16244ee58 Luo bin 2020-08-28  128  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

