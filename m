Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4F4500EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhKOJQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:16:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8988 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229864AbhKOJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:16:09 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AF8w2n2003202;
        Mon, 15 Nov 2021 09:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=dZme3iK+bUU8Sonow8LP6pYLUyVb/c0BGCXZHBTcxH8=;
 b=s3MOEQe1kXgJ3bYitIWOz96QwpLwnRElQXUdA6qnKfvmgSYrlpyYPLkHdsdz6LgNTGKD
 NA4Bust1bN3s+vMxOt/CY4R4xXddbIOu/AoXe43nHz60v8oGNrWDKsshQUe0s/rAnV7W
 bKc93ZVhdl7oXCjRq3I2wGeHVJ0d735Uc0UequW0kwNjZPTIDWFsIG/2Gw8+vpxPfBk5
 BCch4PBznUoB/NqwB1bpDIwSSaofyg1kcDUlSniienmNIiwHWDeTtK7ICNut5eblsEJy
 Doj8OIFVioFX7OIxIE3wAmxnl3eg4GZ0RA10d7pacXmuQ/20nJdtChLXJHPk2XJGrDcA Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3ds030-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 09:13:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AF9C8fk057363;
        Mon, 15 Nov 2021 09:13:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3ca2fu8xaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 09:13:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cINLK35qaUPreD7xNgZmCkzq8b9zGxyhVDw8FUKUPb8u3znpdclgNhjRgcPNzB+gzJWIoQwzZNNh62NCpY0P3FZrk8DuFMexAj1n731Uw2i1EztkUFHyLOxcS3jR3jqI2Ni2oTRH8OMN3P0sKAnLJM/QCk2rnZkDSXsM8Us9ls0Rd/MQ/9+nbiR7MqQLXT0Mz+yp/aLLx8Aggan23PksjosWidPF8GIebPXbfIo6gG/d4QqdveQ3JLNJxAv1oEVOSeWqaVIhxZXBDs4zISUHxcBc+hi0h1p5Spd0frb9CYPuKf3axrMopBiBW3dwVQyxbRZHjYtNun+XwqEMjwIZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZme3iK+bUU8Sonow8LP6pYLUyVb/c0BGCXZHBTcxH8=;
 b=fhVnvLXiFxZudKKpAaFOQSRllYTiaESNR6UjkAvBIIy4qsU9HkiqOsgTFgN3j2E+hBRGdJGptZId3BKGA2oLY1r+Kpi6oW2bStospATRlx9UOwyBxdifVUsHfRfVRi9m+sL1I8Xk74778+4zTQ/bfxLQg5Vu/R1wPYArzySrMsXZtjQ8+fx2EIFRssekk4YjI7WnTm8bIB1pS09T2cUFbWCeob6jC+fF9rCPYckHsAID3Riwd/JTHp7/CcGg+OlvGrVMT0SWKKkRbM7e7+CN/7IWW7K7II+RGQKWsCx6gpfdXQpGA7r/JVFK+VUHN+7PBc0udPozNbHjeU+Bo/rDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZme3iK+bUU8Sonow8LP6pYLUyVb/c0BGCXZHBTcxH8=;
 b=p1GQrrExNdccj7zvQhxwykSCLHXeazsRYg2efuI33ons0zcAVykTUkKV1zoxObDTE1QBs4uLPG7TQ08tzn2MgGHt5CQcihR7kI7WcB1zAP4S3IBb6evwbDgugiGcRBqIODOMDf/1ejztB16e7COxxOp7gWMxZ0WoTNwq4CS1z78=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2399.namprd10.prod.outlook.com
 (2603:10b6:301:30::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 09:13:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Mon, 15 Nov 2021
 09:13:01 +0000
Date:   Mon, 15 Nov 2021 12:12:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ansuel Smith <ansuelsmth@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/dsa/qca8k.c:944 qca8k_parse_port_config() error: testing
 array offset 'cpu_port_index' after use.
Message-ID: <202111120534.jZEya5QR-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 09:12:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a040a6ed-cb25-4dd2-c452-08d9a8181f25
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2399:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB239927B9E3D4E2A4E2C021E38E989@MWHPR1001MB2399.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:336;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NwBjjQu4oMFedhfi/DWAIgJbG6Obgau3zsEqSoRVb2t/XATVoSTMK4pgajEK6F3gOVt+u6e+/2rHP+ar7SS1x1LShTWS21LJKar+olUbd/fMxKjhKDbuLkiY1eybuOAa2ppc0EGNgzI4Lmpfbjvi3K0fcY6Dk6zt6OH88i4IrWoPQeg392w6p7GaJcMXgyNQDyn/8HonpsYozKlTO3+gex4vl9bG7WBROZvZ9SO4q7TaAEZQKkR3HJo/WlPCDvvEmJxGCqD56EeJ2PBykNfPA8mUjhy/LtlbY8GUIGwSeZ4MorXwZBfa+RfrlbRvyyKHWaVr6kAxPmbcslaIQV357KdBm6///fX1AvHQ7dk3S/IGiU5eqwiAtBzUOYUYvvtnfPjnqvQ3wa2JTVG/xXOrv5YYAHIeCMXbvp62Stl/Ih2KBBDchWwoRjh8SpSu261zRkiBYogZCgNQzre6CIXwk5cDZuNMPBk+8k/ux46rrvqR/QFjSfHVVu8FENmqTLyO5lGtJ4K45Ev7cmRKQbuwwiMy+k6S/iPcmT/3ciSG49osPQWvzzR/0B4o4o6CSKRsyIBFQJOzxP17dX64jUPR2JaLwfmOdijnLUseCjwv8IV+ocHKFRPD+FcSHF/mndP2gftGIWDezr8YznI4merfrXFBmhpEa4GYS86NXNCMxoQ+Am/VEMrLMq2p9s92KAF6BkSAoPAIsbmHuNHE+kgklCVaAJqLok7stw6hCkQSZEv6p4trpXep+oJVNUJhMcviYQvcL69zZMBIczaUVADpfOVAjnXfPWzaQu/+q55WbDvQ/qaxqsH7HgK2J+2BkgqcdJuWk0LCf4ph3xslrJbuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(36756003)(6916009)(4326008)(86362001)(186003)(6666004)(1076003)(508600001)(6486002)(38100700002)(9686003)(38350700002)(966005)(956004)(66946007)(26005)(8676002)(6496006)(66556008)(52116002)(66476007)(5660300002)(2906002)(316002)(8936002)(4001150100001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rpIi344dBPk5jWIfh6P5loVZaLXJSXvw4FzY8lajYcBLSmfxH/DpCSo0zYV0?=
 =?us-ascii?Q?gYgKgtkJOrp2ryslikKA2VIgBU4nKFAbWZSAlL6TKuYmCp4w7w72n74/v1eF?=
 =?us-ascii?Q?zwh8VfzmjHdTnaHwpyORpaD+5khpwPXmovqjPjnAGxdFSWKJbcz5/0wxjRJB?=
 =?us-ascii?Q?MGzJf0HUtzRcdYHR/QU4FVGSjnoqDUXeBkIIAaYnTykdS+WrWjzm3PIw5+QU?=
 =?us-ascii?Q?BpvZ6+Yua4Cf4KEUbt9ls4Q+SsUW7YdnKd0cNyW37LrNmFnBhAweXV2EnY+m?=
 =?us-ascii?Q?AYgT+DTfapFMR316uz3AK4K+sQpzwDqZTKs/VRzRtp4/zdaRma2FfUONmSyE?=
 =?us-ascii?Q?I9K98zZYLsFgoWHQxXosL8kpjUyuU/VejlIiGD7Rgw9gA53Iys+8jbKi8mGS?=
 =?us-ascii?Q?ur2RinT8Qw6Z8MaZyiDZeFneReYAlFri5SCnXVtvECTccBySPk3ZSJPTLQd9?=
 =?us-ascii?Q?5fNsoiYGzvxPKL7XgA7ftL9A4NfSph0rY+kxC2wYzcymJfNrg6rmPSMs16ih?=
 =?us-ascii?Q?LEVToPhCUDklp2kLFKMppHXAGSmoEd3IojD0tD97DP7avLpb0j7bCaf0BZDm?=
 =?us-ascii?Q?kuxVxPcBAA/JvzXfRArO6WVE4j7XRJsTFJu6+ajH0+LcYceZVN80zVloG5iZ?=
 =?us-ascii?Q?vud8fNFEbLXAzcRagP4gCO0Ii0lUMaNdox/UHQfgWwlNrx9Ae0fpLOVBfql9?=
 =?us-ascii?Q?ttxhwDzIxoH1lVLPtRtXmB/sCWR1d4gNelzaB95qgDrXPohIazzCiLE9aJ8d?=
 =?us-ascii?Q?c81mXSyc+wcqf5lOkFaKul7v94l+MB/L1oIMS7QyAyWLEPyJgZwWwg4W8j4P?=
 =?us-ascii?Q?n3ungyLgkwZMCxVwHYWyEZITAsWrODpNiTdPbzro4t0uMIThBvz2HE09A3YL?=
 =?us-ascii?Q?c8l6MBJhyNX+BTD3Kp1yDafTwdRIK3F7jGPmU3LnA46Kyh2uaJOSmY1YALXh?=
 =?us-ascii?Q?qa2AW4K2KqhLNl03QBMe9fiu2OucBZTK1Yp55FQb60VwRZ6mGuht0OAB8P85?=
 =?us-ascii?Q?2D2B0vMJ390E1IfvCnNacXEldNWnOZMVTTRhEwDy12okQOewU/hJtJP0hL9N?=
 =?us-ascii?Q?TJlgs35wPL5h4BZ0ZkIEFleRpGVkSkPZDdzbHKzHzOKNg6eQz7cBTQuAq+i0?=
 =?us-ascii?Q?8VtbHBPfH/nuJO1JLd9XtDlmK6gDVUpFubFeTOomTQWFDg7PEoiax1Y1xCej?=
 =?us-ascii?Q?cnjzS3e/6OjmJPmu/HNadIHJbCYSr4yRzsSYvuRMOSCfO67ZD8wiDOFFzqN7?=
 =?us-ascii?Q?wKwdSQFgV/mKPwpk9WE432HoCMY5nfh+sapBrqifZu/8otCAZ81Yy4bTk9Ki?=
 =?us-ascii?Q?Nc0RRyFItHONAdUWT4SlV3pQCNPxqR8B8Bcu6x6VzjjNsEdIuTOvZrUxxg01?=
 =?us-ascii?Q?BplsERhHkcrmX/4yHAS6lCFocs5C8jEjuqFISVcI8Nw0kujQpL18HxpJ9Iqk?=
 =?us-ascii?Q?CG3EIeI02cQAOlO99VDzNP5OWjwwYSg73vDJ2ZCjSXG7Yhix72i2HzZUjUFm?=
 =?us-ascii?Q?xbRIch7ptak0O3vFbTI82DcDHLJRJxyCyIh8AK3jQaJdabiGzk2IL5A87kW6?=
 =?us-ascii?Q?kF54YgQP1NiDFy9Rz20ScR3c+IgXhaocPBqzzxO88rS8V+YJFKcF0ekbgiyO?=
 =?us-ascii?Q?7vcMdAAdNhJkPKZ+beXDZs4uAE4yOq8i1BdkqoSUMcjtqVeKsmgRHilIoCrc?=
 =?us-ascii?Q?a1PbCXyu3O7Bdktpb4R57QdtkZ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a040a6ed-cb25-4dd2-c452-08d9a8181f25
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 09:13:00.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEs95Egfu97s6qoA98zrtiZK6NKcoMNP9/Zx2/et9g8c0KiMfrpF+dLqyw9eSDj4mMc6iUqfOSRQC5uKr/9wGxNqImUPiKCHOjcm0Q1RbnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2399
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150053
X-Proofpoint-GUID: rWP4Sq2-28wnFZGX2p0b6rc-UDrA_66K
X-Proofpoint-ORIG-GUID: rWP4Sq2-28wnFZGX2p0b6rc-UDrA_66K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   debe436e77c72fcee804fb867f275e6d31aa999c
commit: 5654ec78dd7e64b1e04777b24007344329e6a63b net: dsa: qca8k: rework rgmii delay logic and scan for cpu port 6
config: i386-randconfig-m021-20211025 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/dsa/qca8k.c:944 qca8k_parse_port_config() error: testing array offset 'cpu_port_index' after use.

vim +/cpu_port_index +944 drivers/net/dsa/qca8k.c

6c43809bf1bee7 Ansuel Smith 2021-10-14   934  static int
6c43809bf1bee7 Ansuel Smith 2021-10-14   935  qca8k_parse_port_config(struct qca8k_priv *priv)
6c43809bf1bee7 Ansuel Smith 2021-10-14   936  {
5654ec78dd7e64 Ansuel Smith 2021-10-14   937  	int port, cpu_port_index = 0, ret;
6c43809bf1bee7 Ansuel Smith 2021-10-14   938  	struct device_node *port_dn;
6c43809bf1bee7 Ansuel Smith 2021-10-14   939  	phy_interface_t mode;
6c43809bf1bee7 Ansuel Smith 2021-10-14   940  	struct dsa_port *dp;
5654ec78dd7e64 Ansuel Smith 2021-10-14   941  	u32 delay;
6c43809bf1bee7 Ansuel Smith 2021-10-14   942  
6c43809bf1bee7 Ansuel Smith 2021-10-14   943  	/* We have 2 CPU port. Check them */
5654ec78dd7e64 Ansuel Smith 2021-10-14  @944  	for (port = 0; port < QCA8K_NUM_PORTS && cpu_port_index < QCA8K_NUM_CPU_PORTS; port++) {
                                                                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Assume cpu_port_index = QCA8K_NUM_CPU_PORTS - 1;


6c43809bf1bee7 Ansuel Smith 2021-10-14   945  		/* Skip every other port */
6c43809bf1bee7 Ansuel Smith 2021-10-14   946  		if (port != 0 && port != 6)
6c43809bf1bee7 Ansuel Smith 2021-10-14   947  			continue;
6c43809bf1bee7 Ansuel Smith 2021-10-14   948  
6c43809bf1bee7 Ansuel Smith 2021-10-14   949  		dp = dsa_to_port(priv->ds, port);
6c43809bf1bee7 Ansuel Smith 2021-10-14   950  		port_dn = dp->dn;
5654ec78dd7e64 Ansuel Smith 2021-10-14   951  		cpu_port_index++;
                                                        ^^^^^^^^^^^^^^^^^
cpu_port_index is now out of bounds.

6c43809bf1bee7 Ansuel Smith 2021-10-14   952  
6c43809bf1bee7 Ansuel Smith 2021-10-14   953  		if (!of_device_is_available(port_dn))
6c43809bf1bee7 Ansuel Smith 2021-10-14   954  			continue;
6c43809bf1bee7 Ansuel Smith 2021-10-14   955  
6c43809bf1bee7 Ansuel Smith 2021-10-14   956  		ret = of_get_phy_mode(port_dn, &mode);
6c43809bf1bee7 Ansuel Smith 2021-10-14   957  		if (ret)
6c43809bf1bee7 Ansuel Smith 2021-10-14   958  			continue;
6c43809bf1bee7 Ansuel Smith 2021-10-14   959  
5654ec78dd7e64 Ansuel Smith 2021-10-14   960  		switch (mode) {
5654ec78dd7e64 Ansuel Smith 2021-10-14   961  		case PHY_INTERFACE_MODE_RGMII:
5654ec78dd7e64 Ansuel Smith 2021-10-14   962  		case PHY_INTERFACE_MODE_RGMII_ID:
5654ec78dd7e64 Ansuel Smith 2021-10-14   963  		case PHY_INTERFACE_MODE_RGMII_TXID:
5654ec78dd7e64 Ansuel Smith 2021-10-14   964  		case PHY_INTERFACE_MODE_RGMII_RXID:
5654ec78dd7e64 Ansuel Smith 2021-10-14   965  			delay = 0;
5654ec78dd7e64 Ansuel Smith 2021-10-14   966  
5654ec78dd7e64 Ansuel Smith 2021-10-14   967  			if (!of_property_read_u32(port_dn, "tx-internal-delay-ps", &delay))
5654ec78dd7e64 Ansuel Smith 2021-10-14   968  				/* Switch regs accept value in ns, convert ps to ns */
5654ec78dd7e64 Ansuel Smith 2021-10-14   969  				delay = delay / 1000;
5654ec78dd7e64 Ansuel Smith 2021-10-14   970  			else if (mode == PHY_INTERFACE_MODE_RGMII_ID ||
5654ec78dd7e64 Ansuel Smith 2021-10-14   971  				 mode == PHY_INTERFACE_MODE_RGMII_TXID)
5654ec78dd7e64 Ansuel Smith 2021-10-14   972  				delay = 1;
5654ec78dd7e64 Ansuel Smith 2021-10-14   973  
5654ec78dd7e64 Ansuel Smith 2021-10-14   974  			if (delay > QCA8K_MAX_DELAY) {
5654ec78dd7e64 Ansuel Smith 2021-10-14   975  				dev_err(priv->dev, "rgmii tx delay is limited to a max value of 3ns, setting to the max value");
5654ec78dd7e64 Ansuel Smith 2021-10-14   976  				delay = 3;
5654ec78dd7e64 Ansuel Smith 2021-10-14   977  			}
5654ec78dd7e64 Ansuel Smith 2021-10-14   978  
5654ec78dd7e64 Ansuel Smith 2021-10-14   979  			priv->rgmii_tx_delay[cpu_port_index] = delay;
                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Out of bounds

5654ec78dd7e64 Ansuel Smith 2021-10-14   980  
5654ec78dd7e64 Ansuel Smith 2021-10-14   981  			delay = 0;
5654ec78dd7e64 Ansuel Smith 2021-10-14   982  
5654ec78dd7e64 Ansuel Smith 2021-10-14   983  			if (!of_property_read_u32(port_dn, "rx-internal-delay-ps", &delay))
5654ec78dd7e64 Ansuel Smith 2021-10-14   984  				/* Switch regs accept value in ns, convert ps to ns */
5654ec78dd7e64 Ansuel Smith 2021-10-14   985  				delay = delay / 1000;
5654ec78dd7e64 Ansuel Smith 2021-10-14   986  			else if (mode == PHY_INTERFACE_MODE_RGMII_ID ||
5654ec78dd7e64 Ansuel Smith 2021-10-14   987  				 mode == PHY_INTERFACE_MODE_RGMII_RXID)
5654ec78dd7e64 Ansuel Smith 2021-10-14   988  				delay = 2;
5654ec78dd7e64 Ansuel Smith 2021-10-14   989  
5654ec78dd7e64 Ansuel Smith 2021-10-14   990  			if (delay > QCA8K_MAX_DELAY) {
5654ec78dd7e64 Ansuel Smith 2021-10-14   991  				dev_err(priv->dev, "rgmii rx delay is limited to a max value of 3ns, setting to the max value");
5654ec78dd7e64 Ansuel Smith 2021-10-14   992  				delay = 3;
5654ec78dd7e64 Ansuel Smith 2021-10-14   993  			}
5654ec78dd7e64 Ansuel Smith 2021-10-14   994  
5654ec78dd7e64 Ansuel Smith 2021-10-14   995  			priv->rgmii_rx_delay[cpu_port_index] = delay;
                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Out of bounds

5654ec78dd7e64 Ansuel Smith 2021-10-14   996  
5654ec78dd7e64 Ansuel Smith 2021-10-14   997  			break;
5654ec78dd7e64 Ansuel Smith 2021-10-14   998  		case PHY_INTERFACE_MODE_SGMII:
6c43809bf1bee7 Ansuel Smith 2021-10-14   999  			if (of_property_read_bool(port_dn, "qca,sgmii-txclk-falling-edge"))
6c43809bf1bee7 Ansuel Smith 2021-10-14  1000  				priv->sgmii_tx_clk_falling_edge = true;
6c43809bf1bee7 Ansuel Smith 2021-10-14  1001  
6c43809bf1bee7 Ansuel Smith 2021-10-14  1002  			if (of_property_read_bool(port_dn, "qca,sgmii-rxclk-falling-edge"))
6c43809bf1bee7 Ansuel Smith 2021-10-14  1003  				priv->sgmii_rx_clk_falling_edge = true;
5654ec78dd7e64 Ansuel Smith 2021-10-14  1004  
5654ec78dd7e64 Ansuel Smith 2021-10-14  1005  			break;
5654ec78dd7e64 Ansuel Smith 2021-10-14  1006  		default:
5654ec78dd7e64 Ansuel Smith 2021-10-14  1007  			continue;
6c43809bf1bee7 Ansuel Smith 2021-10-14  1008  		}
6c43809bf1bee7 Ansuel Smith 2021-10-14  1009  	}
6c43809bf1bee7 Ansuel Smith 2021-10-14  1010  
6c43809bf1bee7 Ansuel Smith 2021-10-14  1011  	return 0;
6c43809bf1bee7 Ansuel Smith 2021-10-14  1012  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

