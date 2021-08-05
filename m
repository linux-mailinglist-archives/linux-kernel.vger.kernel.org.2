Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C973E13FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbhHELiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:38:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13922 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240854AbhHELiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:38:16 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175BVoI4007964;
        Thu, 5 Aug 2021 11:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=z85erSchNTliXD2Poldx6DOT8O6LaNSYgr/GrXP86gA=;
 b=Pn5Ka24RvfkWHv7gxF3icRwqUuKh0tIvmnuFFzvcPmHs3NhiNhA+E/lI7bcfu6VxkGVt
 YXzesX4WtsNCs/XI0C+K7+1GBD/IHKdfq6AzvxanuWfn3D+JOGLW/iXOGPIev6kcXdwg
 7yZzIOswx2TuvYAp+dQqp5EHCn3lLQyZcsLQXQVyvGl7pRoY+ZdVjMYfSRrEVTU7iN8f
 sHysPylfJLyu3/dkpTgWss0YHIe+4sNySale9h964uUfaw4nAOZxodh7nCq9pRT7k3KB
 pxAo/0UnW1keNBJD40acsqXf1AD7NeyxsvV8Qx/yIRE4N3n8q5th3QNjoBODZ1I8l4Am bQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=z85erSchNTliXD2Poldx6DOT8O6LaNSYgr/GrXP86gA=;
 b=fKLpOG3erBeqshe1t0G9gxy+gQ4zgrRB8UANwFus/IqGELLrXHh1aKd36FgqduJtJJs0
 WMouYljDk5rxEcJ5ro+QbZRr6Oiv26xPx5br7sqU5Kc+ac1de4N1NTyEbP+/HOgMOTxA
 EjT2o8y+QCcAqQsLfHPz54PW+etakls1nQowREwuGZZ/XVx3sGX3BAjieLTrdZxd5rN4
 L84J9d8kzqm9pdGXhDticze1sApH95DmpBKAZCl3epSg8S/QcwjY3wmMHFDAYx6lSxP1
 +r+JJ21LqrUt21qNtloDK1Ah65+OzOUaFSqT4cTpnbP/4pvHOUsR+zVlt1QW8pPvefb5 nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq0ce86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 11:38:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175BUPH2185427;
        Thu, 5 Aug 2021 11:37:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3020.oracle.com with ESMTP id 3a7r49jhty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 11:37:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF3RJR1h0IHepG3GewmmVolJRk9aLXknvCq2jhcfSfmt5EUbSqMMyX9odxNAB7WVxot3E7p6GeDXAdfzOwmncZUAO6KQPkyhxdPOy7ApxHimldlJpPByqWXUnMTmGeA8c6/Q5/p07SaZgbFO7ECCRos69p4afl2thATzUXC3EfwGVhe6GcYafstl+PvUXWXTlDFle+i80tZwX5Wv53b5/ZWhKT6z+yACTP4rbSZ8QRQZ872wUHwfRd8vxhjJsifT4G0xHcXQKDDjHGK3KmjNyeuB9jhV44Upf8posta4xe+xx5SBuIgFg3mGKBgR82h7bVv2xf6SoK+p8WU91KEpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z85erSchNTliXD2Poldx6DOT8O6LaNSYgr/GrXP86gA=;
 b=nhUpbdailkIgsUPGeMyeu4hjuKMGeZCeQodN4XCgsl8tT8uHoS9kTWWjmJ4KBwYWGl9aIinyjuQs9o4Lt2M0rCkHvdMd/4kIE/w+lhMHPHUnBKzUtIUUwMl+1aPPd/EYMhZdbfUtnx0EfD4zAl10BOhK1P0iyws91MvPRpWqE4b1rdbTOeV3ylalE3STpvQjd3Ux4yfRBS21fOrITXhPGwK1Pcj5E3SnMRb0Z7Jdso0cirPvUX6rYq4tFzBCY6jhAMWM8g4iS4lhRbEFGTpdnXuhvRDr6rHwrf0IRSi7UVQmAHqH37Z2xrr+bTUgwQiCNeXhMDY1aL3puZhFOGM/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z85erSchNTliXD2Poldx6DOT8O6LaNSYgr/GrXP86gA=;
 b=nqc6RtQRKEHoZFhoqOOEziuYo0I4g9W791qYsBIuOOgMs/ipfoEOk0TtCw4nqLLBKJ7RsmK9xm0meo6sItYVHxia/AAwk2HtOnluRRlB83+yFd58j5PgJ1h46gJk3Oh7l2XEq8fSM/mbVlHynUS4uBxgIO8U2mq8M9Z1X5W7LEk=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1549.namprd10.prod.outlook.com
 (2603:10b6:300:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 11:37:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 11:37:56 +0000
Date:   Thu, 5 Aug 2021 14:37:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Subbaraya Sundeep <sbhatta@marvell.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:363
 otx2_tc_parse_actions() error: uninitialized symbol 'rate'.
Message-ID: <202108050950.8asuOx46-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 11:37:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2224e340-0704-49be-be7e-08d95805780a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB15494196DB4DB2A3DF5415BF8EF29@MWHPR10MB1549.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xB1j9xg0QgbPecjdwTcAIpntAHXg60hYmpXI+FvLJAkV2cz1BOT/igeik7HQxozjKxmZKVMOXectc9BgCaJyBhqul2JD+O8jE6a9yrg00fxo/RoT+tZJzSjdGAHYrVUTzVPc+kDWXKvrr2X1PiS3UjQd18eX8c3SUPc5H/vGeV+AaWaas34Lc6M82MyzmqF7f3/2+9EctqGmShBaTb2DwehXGRPYTKwD5EwIzWbeXUM5/IfjA4PdKOgT6Hna/e0pnW01nQn7RmY3trFfmAGKBZCgVBvN2nvldh07fFP81eTn1AyhIABycLVhZWkO/JCB0K/fztiukInOBiqbqoHEo89vZJjshcBtDsFnbxrQdLVkxjGEKMpKG8fvEnbB3Fo7py05lYkRnj2juz3k5H+Os1KaaDOVGO2j4NhC/0sDBnH0MXqxTKt8+8+zG+FxsiHWW8kqc+QY3wNFBBBJEvoNWYzrH4hvv19sPPFoH4l6A6NYjCIcF6ub3ZVzbINQmAXro9D14Nw8cyj14JCAb9mZ7g2iByHSIveukT+sUtvZ13p4Y4Ji8QD1NN9I//pAmRFp0vSmA/WXyUc5mJgeqHS/ZrA9B+xchieBM/NuUN+J9jhmeyBg3clL9mkKKTfKj/W4B9D0KRtl0Oiu+Mx1/9BeM0K2DdIhVMSwbmn/gIcRiQMeCkKAww06iycES9hRrCndzYd0nlLphgSP8Vnk8YfJGSmmpFP7ucdFBkFVcpOyW2btI/Jv5t99nQMf4YuvkJ8DvjmhaMbvllpi1hM6jkOZQC8IIJsMxIiVfL3OO83m1owF72LiRy6qEKgoPBkvu2jO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(83380400001)(966005)(38100700002)(38350700002)(4326008)(36756003)(52116002)(8936002)(86362001)(316002)(6666004)(5660300002)(6916009)(6486002)(8676002)(44832011)(186003)(956004)(1076003)(66476007)(508600001)(66946007)(2906002)(6496006)(66556008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6xvS4n3UZYUOB4jk5+EKDCVPm3cmuPPQeBypehEqSG5vxZ31FhxH4lvGF0w?=
 =?us-ascii?Q?7qdGQhmjAtAfTeL/wgCXG3ioJB54Kn3h9zatpDWlgG86NlIgOdq88Rf1VXfd?=
 =?us-ascii?Q?/cihYwYbiMQbKe1qhMgakcbsNdrBkvBgkh46SoCNw8psrE+s0L3+PTdqETEM?=
 =?us-ascii?Q?57bOpqW+g0ROnuKSoSaTQr4fuq6TcM7sIWW6MlRlDQ0+hV+BUtf5vq9IQHOr?=
 =?us-ascii?Q?ZgnGvlYwDI7exG8l8KyJu+igzsQm+QlkZUdcfwe/d7fwKyaZRA7K9zHw7yNy?=
 =?us-ascii?Q?JNGCsp/ihKxBGT8a/YEZJGRPeIc7hheKfIGk+WZ4FwCVlIReelSX/4xR41kE?=
 =?us-ascii?Q?hfjd46sU/fq9KvoPmRQy2MtYVE7G9DrW9MjuG2/mcWofHuDVvM5YdeFh5ldn?=
 =?us-ascii?Q?Td18ix5fU7n1alnBf3y+DPJwE0kpTxEckdpi7MozDX0Cbrf0j41ZFF1Z/zFR?=
 =?us-ascii?Q?l0ngPr5Tl6IX4vqoq3vkFoEJRO5iuLQNa+i8GrysPGqbkXjZaFFNl+eN4fE7?=
 =?us-ascii?Q?k/aGkJ2Hr3AliZU85U8Eq/bVuCpM30ptIeGABKtoVRUKvyn2mw+K+HcJhCNQ?=
 =?us-ascii?Q?RCPVs9jFNsBtnHkjvAr+hG/M7aT/U1tGa1IQeKEKy38qynmVhfdHeoPvYxWk?=
 =?us-ascii?Q?p+Upd0lcerRiPTp5XMEwoMMakFNgOMYvh67lq3YVybPdLbGraiiadlAbiNDh?=
 =?us-ascii?Q?FO8kBFTeoUrn+bMYu+7ml98zusbj+7wflh+uDLfmoebTxr5saBN1nBxlZBKY?=
 =?us-ascii?Q?Ryl71JPGh9OjkKz+nHGtFM5uWG4OJYmDV5UilusfC7I87HHoSDVAF7r19U3E?=
 =?us-ascii?Q?nMW3QXpG0vOshEsWyt5c8ST7s/egTqJ3K4gRVPC6oKAXKfdcRdp/tUwsmKxh?=
 =?us-ascii?Q?epyVv0l9EuAGhCayV/P9OO4qOa3NWpdVNPqdkWMd+pTrzMPk2AQlW0+eBmSs?=
 =?us-ascii?Q?oAm0TunpZNeOkOxGTbDLSbAhUPwTYUX4m4QamdL/L7phM2Xk2fE2z0o++vjc?=
 =?us-ascii?Q?VwGxCvf2QRKzszmkX2yh12gqnWWeL8/nLBe8ih2lz9+pyUnhftVHVsau9FrM?=
 =?us-ascii?Q?zPhiRHvXYW3kEfeO1suYu3xi2dXriUtKdaB84aqqyNirjePaT7+1La3J8jG5?=
 =?us-ascii?Q?eFUlfJyv/T5FPpTzzA4p4M7kIkoPKgg4abJ40NdzucCzaKRes4EaoFmzgdbZ?=
 =?us-ascii?Q?Hd6WHJh9aASzNTxSi1TdX/skK9qT5+TJagIj6/Sein3ovAc6DmEMH8p1SBz3?=
 =?us-ascii?Q?B9rlAsBZtaJVqv376okjS8+hVgywwuTubQSla4LAw3APeSonLRBNmkfgk1kx?=
 =?us-ascii?Q?yduwdCIMxx8sOLUnr2oBjKQZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2224e340-0704-49be-be7e-08d95805780a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 11:37:56.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN2ZqiuXB0hr2H+YpVoiSxqoBsv7C2K9IsSwUaLncjhJTH+d+BRi68xHOfy2MOWws33Mgi0qHMkyaU2wTfow4cHt8x3DxNuwhFNL2WmSXJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1549
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050069
X-Proofpoint-ORIG-GUID: qroxQlQOdMelIdRgtDYtCFAX8mZ6DHEq
X-Proofpoint-GUID: qroxQlQOdMelIdRgtDYtCFAX8mZ6DHEq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   251a1524293d0a90c4d5060f65f42a3016280049
commit: 68fbff68dbea35f9e6f7649dd22fce492a5aedac octeontx2-pf: Add police action for TC flower
config: ia64-randconfig-m031-20210804 (attached as .config)
compiler: ia64-linux-gcc (GCC) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:363 otx2_tc_parse_actions() error: uninitialized symbol 'rate'.
drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:363 otx2_tc_parse_actions() error: uninitialized symbol 'burst'.

Old smatch warnings:
drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:364 otx2_tc_parse_actions() error: uninitialized symbol 'pps'.

vim +/rate +363 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  279  static int otx2_tc_parse_actions(struct otx2_nic *nic,
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  280  				 struct flow_action *flow_action,
5d2fdd86d517350 Subbaraya Sundeep    2021-06-15  281  				 struct npc_install_flow_req *req,
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  282  				 struct flow_cls_offload *f,
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  283  				 struct otx2_tc_flow *node)
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  284  {
5d2fdd86d517350 Subbaraya Sundeep    2021-06-15  285  	struct netlink_ext_ack *extack = f->common.extack;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  286  	struct flow_action_entry *act;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  287  	struct net_device *target;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  288  	struct otx2_nic *priv;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  289  	u32 burst, mark = 0;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  290  	u8 nr_police = 0;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  291  	bool pps;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  292  	u64 rate;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  293  	int i;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  294  
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  295  	if (!flow_action_has_entries(flow_action)) {
5d2fdd86d517350 Subbaraya Sundeep    2021-06-15  296  		NL_SET_ERR_MSG_MOD(extack, "no tc actions specified");
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  297  		return -EINVAL;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  298  	}
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  299  
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  300  	flow_action_for_each(i, act, flow_action) {
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  301  		switch (act->id) {
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  302  		case FLOW_ACTION_DROP:
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  303  			req->op = NIX_RX_ACTIONOP_DROP;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  304  			return 0;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  305  		case FLOW_ACTION_ACCEPT:
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  306  			req->op = NIX_RX_ACTION_DEFAULT;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  307  			return 0;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  308  		case FLOW_ACTION_REDIRECT_INGRESS:
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  309  			target = act->dev;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  310  			priv = netdev_priv(target);
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  311  			/* npc_install_flow_req doesn't support passing a target pcifunc */
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  312  			if (rvu_get_pf(nic->pcifunc) != rvu_get_pf(priv->pcifunc)) {
5d2fdd86d517350 Subbaraya Sundeep    2021-06-15  313  				NL_SET_ERR_MSG_MOD(extack,
5d2fdd86d517350 Subbaraya Sundeep    2021-06-15  314  						   "can't redirect to other pf/vf");
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  315  				return -EOPNOTSUPP;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  316  			}
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  317  			req->vf = priv->pcifunc & RVU_PFVF_FUNC_MASK;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  318  			req->op = NIX_RX_ACTION_DEFAULT;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  319  			return 0;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  320  		case FLOW_ACTION_VLAN_POP:
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  321  			req->vtag0_valid = true;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  322  			/* use RX_VTAG_TYPE7 which is initialized to strip vlan tag */
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  323  			req->vtag0_type = NIX_AF_LFX_RX_VTAG_TYPE7;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  324  			break;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  325  		case FLOW_ACTION_POLICE:
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  326  			/* Ingress ratelimiting is not supported on OcteonTx2 */
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  327  			if (is_dev_otx2(nic->pdev)) {
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  328  				NL_SET_ERR_MSG_MOD(extack,
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  329  					"Ingress policing not supported on this platform");
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  330  				return -EOPNOTSUPP;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  331  			}
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  332  
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  333  			if (act->police.rate_bytes_ps > 0) {
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  334  				rate = act->police.rate_bytes_ps * 8;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  335  				burst = act->police.burst;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  336  			} else if (act->police.rate_pkt_ps > 0) {
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  337  				/* The algorithm used to calculate rate
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  338  				 * mantissa, exponent values for a given token
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  339  				 * rate (token can be byte or packet) requires
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  340  				 * token rate to be mutiplied by 8.
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  341  				 */
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  342  				rate = act->police.rate_pkt_ps * 8;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  343  				burst = act->police.burst_pkt;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  344  				pps = true;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  345  			}

Smatch is complaining that maybe both these conditions are false.


68fbff68dbea35f Subbaraya Sundeep    2021-06-15  346  			nr_police++;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  347  			break;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  348  		case FLOW_ACTION_MARK:
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  349  			mark = act->mark;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  350  			break;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  351  		default:
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  352  			return -EOPNOTSUPP;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  353  		}
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  354  	}
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  355  
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  356  	if (nr_police > 1) {
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  357  		NL_SET_ERR_MSG_MOD(extack,
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  358  				   "rate limit police offload requires a single action");
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  359  		return -EOPNOTSUPP;
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  360  	}
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  361  
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  362  	if (nr_police)
68fbff68dbea35f Subbaraya Sundeep    2021-06-15 @363  		return otx2_tc_act_set_police(nic, node, f, rate, burst,
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  364  					      mark, req, pps);
68fbff68dbea35f Subbaraya Sundeep    2021-06-15  365  
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  366  	return 0;
1d4d9e42c2406bc Naveen Mamindlapalli 2021-03-18  367  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

