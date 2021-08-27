Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB713F9541
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbhH0HlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:41:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38268 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhH0HlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:41:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6IhgU024236;
        Fri, 27 Aug 2021 07:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=5ovhnmZMj6Z6p+H2ILDcHNvx/QDvTPebBpQrJjtc7i8=;
 b=GOxsI0IMyUSsfsl4j+lWsVslILPq3mNEtW+JmD895h3ykpcjsNDOWHUkNrFfTtHxa5mt
 BMQJT30YJF6Rdrnm2sXMNMfDFJONX/OaSo6Dej/sl3qPeCfeHGbCbhY32hf/xEAZEq9E
 s1xaSVHKXW45PKPybVDAkHGrChMKyQ9JE5yIEMSSSqYeQ6j2e7S4uc2x2Uc7xNLFLJQ2
 l50WvwRDhKBSXWtWVY2HkcgTJ0vPWX0PZzX6d9004r3DuNbcE6wcKVcbq0dz3t/D8C0i
 OfORF5S265rkVIQbkr0i8Cf6BbxdwYC3IfXLmkDid7GKRLgsMqAyK8xIJyi6wqi9lLgT XA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=5ovhnmZMj6Z6p+H2ILDcHNvx/QDvTPebBpQrJjtc7i8=;
 b=uRyelKq8X3uqjqbAmdpBOllbFFn7+FYWp7QE5h1b+bs+9s5TE4dluyH+e+MzSEz1nZGm
 JVOlLnUuOLDyAQiRh3Zrla5+gkbpLHJQkcTIUHAa79ocmxLWEWi86jEUyD1XkxjY6jcG
 zQTR69JWnaKg1n56/a3LEiApmYmkf1usdZoO95JBIzCz8mzj3z/alun9/QC4Fjn4vz4D
 OHi7wrLEX5Rntx4cBf2kwHPeC9jnswjq+cZeRxyN6YLbtv1KYEUtQKrYjAM41L9K+3ir
 oAOVedqqmTk/YxM4NsAsnFdQWJiLvKxvax514ZfxZfZpNrctDlAwg51fRcFr0MmnjDly Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap0xpb904-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:40:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R7PaHl126418;
        Fri, 27 Aug 2021 07:40:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3020.oracle.com with ESMTP id 3akb91n87m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaxDfdZALSh8OWCYLszLfXQFC8X3QKPjEHaX+H2dY7gdEt++FgvJNV6omi4ChSqYXFktA/yxRhwapQCpbaIs2PVwxFAWs8wxlW4cJWGwGTa3hPS+PEb7ISc+9hp2PWruAR0kZKGuuaf+NRKJeAapzRvhIwqNl1UMX47ZDRnZrWctPPhW8w5SFLTyxy/LcM5kf2gE2cfZaWsJv+RZia016pWVYQL56/4K9ugtakfU8hVzQG74ppOp88I+MM2My4H6o3tOXYUzkYT/DShVtVRRYrAKOY8HH03cC5V1za6rt9hsun7eSYzyImmAYN9rpCWjGT1BGJBD/DyDHPIiYyDU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ovhnmZMj6Z6p+H2ILDcHNvx/QDvTPebBpQrJjtc7i8=;
 b=cgXoG/yKGwut7Om11rfcKi49dCAr5747d4tKuy+ANK0lfg33nxlZSa+/M80hJ6nn7SzUX+mqQxl503j3C8yEfM5SBWqA0624yK/j8c32xAKzr7Flt3K0qt9hkOUmhPOO4zZxPTxA5lvwVcyRlwKjw5/wiSo04MwW1ewwxMf1d3/2YPULM2YII9IHGJsqabC6Jhbbn+zpuTQLLp5isFwmLEnABlEEZWWrALyb2D/tR18CyHG9sYv3TiT0N7QcQUz0avtREjrYqj0kLbh4GgJIurWm+VxSNgtXm0ze5WRVAI1i2lUqMQxycNiVZaLBnsWoO3FTbPVT+39lEZcV8+qQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ovhnmZMj6Z6p+H2ILDcHNvx/QDvTPebBpQrJjtc7i8=;
 b=PsgPpn24eRonB6rxougoD3la7JVEJI9gJ3YxJtxIYZ7icXhl4ClWgEtHZ9d207LMMKk7p0o8SjowbKO/5EyiSbHFfXx+xjLkSL9EXBW+sszVst9KrD4JUx63S0KcAJTO2lO09y620o6I+VSkNd7Z5TZg0642metXVeQWUIDtkO4=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4499.namprd10.prod.outlook.com
 (2603:10b6:303:6d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 07:40:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 07:40:20 +0000
Date:   Fri, 27 Aug 2021 10:40:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jiri Pirko <jiri@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:linecards 92/112]
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c:398 mlxfw_firmware_flash()
 warn: missing error code 'err'
Message-ID: <202108270535.7MR21KUC-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Fri, 27 Aug 2021 07:40:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d0853a-4766-4bff-e96b-08d9692deba6
X-MS-TrafficTypeDiagnostic: CO1PR10MB4499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB449965FF6636F12EE3CF37828EC89@CO1PR10MB4499.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lr2AqmcCKKoUFAdevjGCId8wa1ApCTA/iV94YulFuL03r05JwCHif38atWBwLrPmlgfueW/os+lAS7Spx+UCsOk1d2diIjhg1jOt1GQ+0NyRSWZSMg+HTJd8uVnpoUfIZrsO2SYFIQBd54PP1bXyVV5PFdNz8e5u3s2szcN/n3MH3iJ9oWUedCewKU1EretWYP4km94uCbL7mtUqPd7DjdQto1Mys3c5DUdLxTGrWJsOpjwspSASw0IDEwMn4yG+2AxTRdFxjCdYnUemzLWMuommKnQirwV7LNmAu5uagbre+jMB5dWfhVVEqTBU50PRlVD+mXFB549uuhz4Dh39QcCI6BPipXevgUYwRAyZ1fofEwMSVoqiuO8sEfKh9VOB5GpGls3FhyTXBUiU5RPU6JI+fiNgcH7l2VrSmN136C+Xa0yg/j37kWHg5TYlM7JuOvcA39CAI3lju+pfCf5kRKjHyXs6JBwnWSdVhmr9HkxKi4ft88zWiIE+PTQrI8NEyZctTnpDmeuc2I6NaTGXMXItSTCm6fWOZbTWuux2XPhemVSA6C+B4A5XlATeUQtgz8hNEzgjYNNoM+sOmGxc2Xc3uKs0k+CgjiBmobxooQzY9/cBKwtgGDo0sCWaQ3b5oj/0x48enu0DiKVitfJWJfmu6SweTvOCuvPeQuY+6+k+FKN/p7CH9osEeryBQnBaq1+AWcccZYNef2WPXOuPgr+J6X1mxdwmGVtzryIRAuDWw24quLt1tva7IS+J7VldA9lQblvRRBHa/zmFoNcHE5W2iAjI2njc3wYc6hyEH+nC5hnvLJSoUVXNCDv3QANOseNGFtR3FCf5xSZ6q6pBlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(396003)(376002)(6486002)(8676002)(6916009)(52116002)(9686003)(6496006)(4326008)(83380400001)(2906002)(66946007)(316002)(26005)(66476007)(66556008)(186003)(6666004)(5660300002)(8936002)(36756003)(44832011)(86362001)(956004)(1076003)(478600001)(966005)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJHdi/HjKNLOhnHvoJBo0DZVbaLAKy7WxJ0QD6Cz53aOvajT5hBmLVFn9KBt?=
 =?us-ascii?Q?tuNEKlA4O/fJeahshZtfIlK164Jnu8YDK8hPcpgnlZLvqZY8IiGMWAKfyOZ0?=
 =?us-ascii?Q?xH9Sjy/wMBNhjs0/cnY04Iw+6X2pbQadB9ZOZzCEcTk9/xNWSiLcp/OY/4wS?=
 =?us-ascii?Q?rT3fFGDUecit1slpbhJbgUn4WqeQ9Lpq6uyXwyJLA58I4ozsm3qaWGPubvs3?=
 =?us-ascii?Q?wrMR+g+p/vMzUVXCnLGfexa8TW3PecwLs8GWuf7RBQIqhaeGQIhp2/kPBSF1?=
 =?us-ascii?Q?ZUCTjS76wmDETwTxjBTENRDGf0ZCjp7bGxUSASEEZ8sC/vGxQCi5xjFfhma8?=
 =?us-ascii?Q?L3ymHSRbXNsit6/3ZBR7SHhFuOnkRRBVDnk49Ac64qrBfWDxuwi5Mx5fECNl?=
 =?us-ascii?Q?UZYqA739koUVtxlKO3QOnpi6VJNSgWtP+fDx7m9wOw4j1PN2zc0sokzMWxpc?=
 =?us-ascii?Q?9KnOIfc5A/xhPQ3+bnfV2B91fYBFxM9OuThSDsy7oIQHV9fYTdTGCp+s5zJs?=
 =?us-ascii?Q?R5Gbo8VOnnNdijQznoI074Z4B289ws7y2EoU3Q7x3U6hLTbvl5fmzBOku8dg?=
 =?us-ascii?Q?RYeqNBuNmZKmYbvqc+jiehwoC4nxe8mb3i/ETYHbap7/z+iFvxOA9/yqwY/G?=
 =?us-ascii?Q?W3wWyTzFN8MfNOPFovg8s4cPZWzqJ1HjHFVi1CUNt1o+GpH3Hi0FZvUIrHmQ?=
 =?us-ascii?Q?QOVIXa9PCFaadxKDulj3EwgC/PAH4l+oVIOyb8S/htmyxGHReefuJOcfm1l1?=
 =?us-ascii?Q?8cdXEDYMcYKYkKR8EFCb/IuZ4+pqwWQJ4M0lkDMRV9UH3vefXOmQWb6miGzt?=
 =?us-ascii?Q?oUYJ6JzgnRflLxeEU9+XoaEmzU5uwlQGTlJmjbhEvGJqQADln+ct8L+H7Lx1?=
 =?us-ascii?Q?BM2FhJX0imsPFrslM5s3kqrgDdp2lEjuWlApuTGcJXLMjBN6oLSX4NSRIMXi?=
 =?us-ascii?Q?PMOXnerLLmaMN6uVzYXS1fW5B0gMOP8tlaf/5u1yB77d9rRtmndKOIoRxmfv?=
 =?us-ascii?Q?l3iCeHS4f1N7chRxt/GKGfDJ+s93PEXaMn33Ecmcjp1ZzkoftxRCf/m9/4RD?=
 =?us-ascii?Q?sZiJ02+8ThzYdgN2poDYDbmFzLv+3XNL5uwxd2EJq+DzbBQXmeCSemi7SHiM?=
 =?us-ascii?Q?XAGds+YbVzcnMJSjr4WwCJSggeKXVlnSdei6rl1CiAXjMMYTcPerMShNTHbF?=
 =?us-ascii?Q?BpH4Wh0YEP81yAB28a/HCDoz/KRut7fRAoq96397y8JGJcw5JgF6iMN/zXsV?=
 =?us-ascii?Q?joemzw13KwEaKQm2rTckpfggdeVi5tV3IDZlgNHtiML5K2zVABpJekuIzHp7?=
 =?us-ascii?Q?a8MGYzmotnRK+g1eR9hN9QB2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d0853a-4766-4bff-e96b-08d9692deba6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 07:40:20.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66MDcK1Fup0kT2xCAV4yK385oo3KtHx+eb2BgDdPBdtVLEdnjYIOlUwOQ+r3TylYmR9WbF2kdxrwDNXBTs2JGsSUjcvd1lzTecEF8xJa8Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270049
X-Proofpoint-GUID: fqqZe2tpVbJUBK2_tJYMQWh1mU7HSIr3
X-Proofpoint-ORIG-GUID: fqqZe2tpVbJUBK2_tJYMQWh1mU7HSIr3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw linecards
head:   a37df1af1f3e6a47a9718298d5e50b842f79b2d2
commit: 6865f62b66dc9b887cfdf27a5a465cc286e8cfcc [92/112] mlxfw: Get the PSID value using op instead of passing it in struct
config: i386-randconfig-m021-20210826 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c:398 mlxfw_firmware_flash() warn: missing error code 'err'

vim +/err +398 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c

410ed13cae39df Yotam Gigi      2017-05-23  347  int mlxfw_firmware_flash(struct mlxfw_dev *mlxfw_dev,
44f18db5c16a83 Jiri Pirko      2019-06-04  348  			 const struct firmware *firmware,
44f18db5c16a83 Jiri Pirko      2019-06-04  349  			 struct netlink_ext_ack *extack)
410ed13cae39df Yotam Gigi      2017-05-23  350  {
410ed13cae39df Yotam Gigi      2017-05-23  351  	struct mlxfw_mfa2_file *mfa2_file;
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  352  	bool reactivate_supp = true;
6865f62b66dc9b Jiri Pirko      2021-06-04  353  	const char *psid;
6865f62b66dc9b Jiri Pirko      2021-06-04  354  	u16 psid_size;
410ed13cae39df Yotam Gigi      2017-05-23  355  	u32 fwhandle;
410ed13cae39df Yotam Gigi      2017-05-23  356  	int err;
410ed13cae39df Yotam Gigi      2017-05-23  357  
410ed13cae39df Yotam Gigi      2017-05-23  358  	if (!mlxfw_mfa2_check(firmware)) {
5042e8b97d4176 Saeed Mahameed  2020-02-21  359  		MLXFW_ERR_MSG(mlxfw_dev, extack,
5042e8b97d4176 Saeed Mahameed  2020-02-21  360  			      "Firmware file is not MFA2", -EINVAL);
410ed13cae39df Yotam Gigi      2017-05-23  361  		return -EINVAL;
410ed13cae39df Yotam Gigi      2017-05-23  362  	}
410ed13cae39df Yotam Gigi      2017-05-23  363  
410ed13cae39df Yotam Gigi      2017-05-23  364  	mfa2_file = mlxfw_mfa2_file_init(firmware);
f7fe7aa88fa25e Saeed Mahameed  2020-02-21  365  	if (IS_ERR(mfa2_file)) {
f7fe7aa88fa25e Saeed Mahameed  2020-02-21  366  		err = PTR_ERR(mfa2_file);
5042e8b97d4176 Saeed Mahameed  2020-02-21  367  		MLXFW_ERR_MSG(mlxfw_dev, extack,
5042e8b97d4176 Saeed Mahameed  2020-02-21  368  			      "Failed to initialize MFA2 firmware file", err);
f7fe7aa88fa25e Saeed Mahameed  2020-02-21  369  		return err;
f7fe7aa88fa25e Saeed Mahameed  2020-02-21  370  	}
410ed13cae39df Yotam Gigi      2017-05-23  371  
6a3f707c0051a5 Saeed Mahameed  2020-02-21  372  	mlxfw_info(mlxfw_dev, "Initialize firmware flash process\n");
5853c41823ddbf Jiri Pirko      2019-06-04  373  	mlxfw_status_notify(mlxfw_dev, "Initializing firmware flash process",
5853c41823ddbf Jiri Pirko      2019-06-04  374  			    NULL, 0, 0);
410ed13cae39df Yotam Gigi      2017-05-23  375  	err = mlxfw_dev->ops->fsm_lock(mlxfw_dev, &fwhandle);
410ed13cae39df Yotam Gigi      2017-05-23  376  	if (err) {
5042e8b97d4176 Saeed Mahameed  2020-02-21  377  		MLXFW_ERR_MSG(mlxfw_dev, extack,
5042e8b97d4176 Saeed Mahameed  2020-02-21  378  			      "Could not lock the firmware FSM", err);
410ed13cae39df Yotam Gigi      2017-05-23  379  		goto err_fsm_lock;
410ed13cae39df Yotam Gigi      2017-05-23  380  	}
410ed13cae39df Yotam Gigi      2017-05-23  381  
410ed13cae39df Yotam Gigi      2017-05-23  382  	err = mlxfw_fsm_state_wait(mlxfw_dev, fwhandle,
44f18db5c16a83 Jiri Pirko      2019-06-04  383  				   MLXFW_FSM_STATE_LOCKED, extack);
410ed13cae39df Yotam Gigi      2017-05-23  384  	if (err)
410ed13cae39df Yotam Gigi      2017-05-23  385  		goto err_state_wait_idle_to_locked;
410ed13cae39df Yotam Gigi      2017-05-23  386  
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  387  	err = mlxfw_fsm_reactivate(mlxfw_dev, extack, &reactivate_supp);
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  388  	if (err)
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  389  		goto err_fsm_reactivate;
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  390  
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  391  	err = mlxfw_fsm_state_wait(mlxfw_dev, fwhandle,
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  392  				   MLXFW_FSM_STATE_LOCKED, extack);
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  393  	if (err)
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  394  		goto err_state_wait_reactivate_to_locked;
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  395  
6865f62b66dc9b Jiri Pirko      2021-06-04  396  	psid = mlxfw_dev->ops->psid_get(mlxfw_dev, &psid_size);
6865f62b66dc9b Jiri Pirko      2021-06-04  397  	if (IS_ERR(psid))
6865f62b66dc9b Jiri Pirko      2021-06-04 @398  		goto err_psid_get;

	err = PTR_ERR(psid);

6865f62b66dc9b Jiri Pirko      2021-06-04  399  
6865f62b66dc9b Jiri Pirko      2021-06-04  400  	err = mlxfw_flash_components(mlxfw_dev, psid, psid_size,
6865f62b66dc9b Jiri Pirko      2021-06-04  401  				     fwhandle, mfa2_file,
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  402  				     reactivate_supp, extack);
6865f62b66dc9b Jiri Pirko      2021-06-04  403  	mlxfw_dev->ops->psid_put(psid);
410ed13cae39df Yotam Gigi      2017-05-23  404  	if (err)
410ed13cae39df Yotam Gigi      2017-05-23  405  		goto err_flash_components;
410ed13cae39df Yotam Gigi      2017-05-23  406  
6a3f707c0051a5 Saeed Mahameed  2020-02-21  407  	mlxfw_dbg(mlxfw_dev, "Activate image\n");
5853c41823ddbf Jiri Pirko      2019-06-04  408  	mlxfw_status_notify(mlxfw_dev, "Activating image", NULL, 0, 0);
410ed13cae39df Yotam Gigi      2017-05-23  409  	err = mlxfw_dev->ops->fsm_activate(mlxfw_dev, fwhandle);
410ed13cae39df Yotam Gigi      2017-05-23  410  	if (err) {
5042e8b97d4176 Saeed Mahameed  2020-02-21  411  		MLXFW_ERR_MSG(mlxfw_dev, extack,
5042e8b97d4176 Saeed Mahameed  2020-02-21  412  			      "Could not activate the downloaded image", err);
410ed13cae39df Yotam Gigi      2017-05-23  413  		goto err_fsm_activate;
410ed13cae39df Yotam Gigi      2017-05-23  414  	}
410ed13cae39df Yotam Gigi      2017-05-23  415  
44f18db5c16a83 Jiri Pirko      2019-06-04  416  	err = mlxfw_fsm_state_wait(mlxfw_dev, fwhandle,
44f18db5c16a83 Jiri Pirko      2019-06-04  417  				   MLXFW_FSM_STATE_LOCKED, extack);
410ed13cae39df Yotam Gigi      2017-05-23  418  	if (err)
410ed13cae39df Yotam Gigi      2017-05-23  419  		goto err_state_wait_activate_to_locked;
410ed13cae39df Yotam Gigi      2017-05-23  420  
6a3f707c0051a5 Saeed Mahameed  2020-02-21  421  	mlxfw_dbg(mlxfw_dev, "Handle release\n");
410ed13cae39df Yotam Gigi      2017-05-23  422  	mlxfw_dev->ops->fsm_release(mlxfw_dev, fwhandle);
410ed13cae39df Yotam Gigi      2017-05-23  423  
6a3f707c0051a5 Saeed Mahameed  2020-02-21  424  	mlxfw_info(mlxfw_dev, "Firmware flash done\n");
5853c41823ddbf Jiri Pirko      2019-06-04  425  	mlxfw_status_notify(mlxfw_dev, "Firmware flash done", NULL, 0, 0);
410ed13cae39df Yotam Gigi      2017-05-23  426  	mlxfw_mfa2_file_fini(mfa2_file);
410ed13cae39df Yotam Gigi      2017-05-23  427  	return 0;
410ed13cae39df Yotam Gigi      2017-05-23  428  
410ed13cae39df Yotam Gigi      2017-05-23  429  err_state_wait_activate_to_locked:
410ed13cae39df Yotam Gigi      2017-05-23  430  err_fsm_activate:
410ed13cae39df Yotam Gigi      2017-05-23  431  err_flash_components:
6865f62b66dc9b Jiri Pirko      2021-06-04  432  err_psid_get:
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  433  err_state_wait_reactivate_to_locked:
958dfd0dc6d845 Eran Ben Elisha 2020-02-21  434  err_fsm_reactivate:
410ed13cae39df Yotam Gigi      2017-05-23  435  err_state_wait_idle_to_locked:
410ed13cae39df Yotam Gigi      2017-05-23  436  	mlxfw_dev->ops->fsm_release(mlxfw_dev, fwhandle);
410ed13cae39df Yotam Gigi      2017-05-23  437  err_fsm_lock:
410ed13cae39df Yotam Gigi      2017-05-23  438  	mlxfw_mfa2_file_fini(mfa2_file);
410ed13cae39df Yotam Gigi      2017-05-23  439  	return err;
410ed13cae39df Yotam Gigi      2017-05-23  440  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

