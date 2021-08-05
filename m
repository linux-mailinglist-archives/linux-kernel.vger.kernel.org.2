Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270E23E18B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbhHEPwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:52:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50090 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhHEPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:52:07 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175FkpH1020142;
        Thu, 5 Aug 2021 15:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=PwPxmgm5xhEwAt2HHkgjh1MtWAjudY4J4elI8nNZXeI=;
 b=yNuJ1eaZa4Hh8t+0xsW3pyeeinFS6tpAbgJlQFhgCnU67OvVjembVCyfvp5D2blTfOnJ
 rF8ebqZFoThJwcb557KJfsly/uwt/IWJxbTXY1X7LQDVK0vbcPQN5WQU1TjnS4v9KWhx
 LmpNZnVMyZ/nQttMLA8ivzyLxtPha5H0xPCHYbd1Ye5wHgA+XeIwSLHAv5/pKFE1kEtQ
 0ocG55frYzZSzTAG7v9QLl1xcyaF32ZZK8Eo1gbiIEmPYjTa3fS4Oi8hvF7z9QXcsdbk
 sirbbpqfzEYCfvcTz5k1DSiGpG/dh5kXxIUi/zcaQNIpzRKZafJA1W55/J0dkybfx6bV xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=PwPxmgm5xhEwAt2HHkgjh1MtWAjudY4J4elI8nNZXeI=;
 b=M1Fv2gqzvW0LJLLj+zHeemNUxs1IrceLMShk9nzxXstOiXbb2KcGgeVBwVVAtm5DNDph
 pKDbXyzYjsndBFci3uwPu1Cltvfx2d4Bp+iDgSr0muL4LyAbRZglswLMqsvmZZd11OMV
 DFWEpC5PLsorQV+kOclbfKH0kR/V5f1q3fxoXnZ8am42HEjTA0Ws+Fd+vVgKO77SWUUT
 FB63aYul9fk8npa+oKHTha06w3EwXjVCrZk6xueFWgLRZFLl9+NiAxSr5WCicTZeq0hz
 GKV1K0UWXk5T0FyH5OzLvWL/ife1TEDbIQlqONmgGiLGekW95Vxec3Tt8Y9ASkyt02OP zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7wquaqrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 15:51:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175Fk8Xa092072;
        Thu, 5 Aug 2021 15:51:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3a7r49y9sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 15:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1vBt1lTOokugVvD0hYpKSFyw+7P8ASX4q6+hy6O+k0zkPBtHm6vC6ulu5x4CnWCAW3Zm15Flz+GtGZlXZXI1c8fSRPAxl2wPROykZCjCA+fx+u7YX3sZ4YCOx71RnbHY25AV0xNS6uThtSI4Qg2+v8rrPKuAxBMP9JeRnuLvsG3RnjpTspj/J+Vy93yaJNDkWpVGvRTtVv6iKKU5Omz0Qx1C+uWB38/iMnsZSAfZX8bBV3tdujVOY1mvD7UMbQBkeREWzxKn0ERvxC83g8CnxlgSeTPqokJFeS2gQNxQO60Fi5ZutWOOE/jUvdERHtpvVD4cR8N+q0dnhrZbxagtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwPxmgm5xhEwAt2HHkgjh1MtWAjudY4J4elI8nNZXeI=;
 b=DWnCHpiADkCxt87TCbQGbZcknbrjWM0v7i6xhhT2ABB6igqSbigUdm/gVLH5aDado/MuP4eEnBHouLOwY9wa1c0s+4J+SvI19ExE/uSh/Fq6dHjulIimdOSvZZ0Bqgxu597XbPLeAjqMWDdvq+YUr8ScNb6Y6FhRwN5ji3NFGxgfKUR0RiRFZ8EbnNgljyn+Q56wEtuDL07cvZq5JsEd4ayd+OgodB8RVaijcjDzvxuyYKZrWHT15pT0hgIVM30MGDNXf/XSiBv6emkmieESPDTIs+OUG8Kr1BdRGz6OEiSw2n+6NkJhs6m5QvfiWyLxaDkkFZ2nAGYcekdt/vHe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwPxmgm5xhEwAt2HHkgjh1MtWAjudY4J4elI8nNZXeI=;
 b=ihUgstXcps2P/kp98rScZW1znmit8pit6BlJGolCka8Qw6qf0aXGRd+ivJRcZV/eV07w36GNJ6kVKnZfnzcyzFt1ImvJZV9zdXjBVu+p7ktqok6n2zxKXD/qnLl5n165wx2gtOdYsYw/hJZjlUxxkX+8E3IKYtCwa1giij/BuhM=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 15:51:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 15:51:43 +0000
Date:   Thu, 5 Aug 2021 18:51:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Eran Ben Elisha <eranbe@mellanox.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: [kbuild] drivers/net/ethernet/mellanox/mlx5/core/cmd.c:1036
 wait_func_handle_exec_timeout() warn: should '1 << ent->idx' be a 64 bit
 type?
Message-ID: <202108052103.hfxfjDe3-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: VIPND7VSSURZHZ2ZWGQV3WO6LVSDSR4K
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 15:51:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649f0f2d-8ff3-430f-e9bd-08d95828ec1f
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB540933FF95A7ED4757F140198EF29@CO6PR10MB5409.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIowobhruTjvi8mgNU3lDyt9RiVSxyVtsYVRpGbDiYForveCJRkyK8yjOG2vK74kXIrl5NWxtjIUEdwIyBhAirXorgwJ3CtLqITKvKgHKkBc5vRdx2/98X8kCQH2ta4+I29wGX9H6sZL9pU50A0Eqg3bvPhW1NJkXpZguflpngzohGJ33DSV5mAhNgwCJRZYgPJ5XfBKZaHPpZsZ0d7554aCPhFRhaJ6eWBDF4uVNc2dorUHxT2M2wLbvbCO3gQDEdknrKPG9/rfQjBeykNj2LrI2fcZ9JvqwzEguBntjAnNm3ZH0CqD2UKA/jTWOCqGR6olkUsahQ9Zqfm0JMemN8f3dgLoYCpxlXRueFGPgj9F1UR3WK3PdaEPl1JMCQMPSK5mw29fyUsRfpEhE8Xk7DJGdoTAy2NKAzUbXX9QO6Q88QClXnns2X9qjWHzVYiUOGKkjuFo9bMvwyEahK5Rgv5od9jschDEA3glP1VKNz3OkGHcyUz1F74VMJQQrCGuwQ8els1Bgy5IHLld9KuUl04LM86a0XnuAMfLZBIaU6ReKYMukW8/jmpYHPtaqDuSd5uAkiejOiY21+QjPLeHDSMnxOtEWMNOJc9SapNcng5uV6T5xCXb6qj5p1Wgqq24MN5Zaqzu0wpOLjX925vva+bgE0gcTiWtp+QCRI2+WLIpbfFrm6nQk5uxdp1P69F/Zz2m1U1oVRlx3k4YnLgM8ruwTQhjSRDAeIOA5yYzT1hfhgxeAVfILZHC6SsAZcgchqX91uyjDggQdHqaydMGAXrHeup7d/N1Nb/1093CoSOfOxyJTYbCcW9B1lB52/sYtDEF8I0s4MEEU0Csle5pkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(86362001)(956004)(83380400001)(508600001)(5660300002)(4326008)(36756003)(966005)(38100700002)(38350700002)(6666004)(26005)(6486002)(316002)(8676002)(66556008)(66476007)(9686003)(186003)(1076003)(8936002)(66946007)(6916009)(2906002)(52116002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MwnTJ5C3cAyhkROct9f3KYGzQk0UsKJTbVsMhIPfjxSQ60mBbsvwp21Yc77c?=
 =?us-ascii?Q?jF7TFCPAmh+fr8Byx5tjhPESx2wpYsQsxzbYDgbXYcB2DrrG5iMhLFQOsHjT?=
 =?us-ascii?Q?eI84hSDupoag4YntwhANPC/vnnAexNDFhC3NPZL7UjJJvfr3JBaBYD0va5+m?=
 =?us-ascii?Q?aeWm6IHYP5+l2gPMXYgMQkv4g+WuXFw4Ki/hSzd3nSHsBGJEVDZS2H0Ho8bI?=
 =?us-ascii?Q?H08OvAOAdbtRdlJbJSjpeFPpr4K3mnvu6NEiN6Jth4Ul81K4I+SxC0CQoJ7E?=
 =?us-ascii?Q?hll27j3xiEY2MyeaZ6Y756b6WB43mW3TwEEUiYlu3zvAYnft9gYXN5+GkoGb?=
 =?us-ascii?Q?mXDzfJ2iwnNuJ6xDuLEsCVcaS6l19eBZmzAxK1lWnYJaE/WEGyvxIa4pCdWt?=
 =?us-ascii?Q?PafHmh4WfN9Ntf147VvARDmsBn1AdWLgFE/Qar0dIuXp39Gt8Pp07ZHe9bl6?=
 =?us-ascii?Q?VOugZSZwyUQuDAwYCkHyFJs7beRP0rl293eLSssQ5rivmjjvzuqt/K7RtevU?=
 =?us-ascii?Q?4FFvD0Li/cBXnbbXREHK4aL7KFP/ZKHmXusvSH875rZgbIAQQx91lSCRbMtV?=
 =?us-ascii?Q?KkLmbG/1JZ73xQ9Pu2dOZkcmv+w3lZEMSSG70pGsXjP5nUiGykIBgt71sivr?=
 =?us-ascii?Q?eKpLDxqfluvjeL00Tjf6UwItqAwdPez6RFzMinSuICRSgEDJeX4fJt9VCAss?=
 =?us-ascii?Q?89Td640q/bMU51JPAxoa5VJUKjUm0Fq/e32FCypSLcxSbvW/2FG+Jru7+J6C?=
 =?us-ascii?Q?PfuwB02mHbZNkUnxgbIzwrc8LuI9ipr/TEeL5lDizi/cxOESxacXsTvMFpXf?=
 =?us-ascii?Q?WzevtpOsTAJudXVUSshaz7hOFTlwTzg0bPw2+SDKHTHB89+Bu7rZ1CwpCATa?=
 =?us-ascii?Q?ylUNYc7qyQ2BC4cqYED0SlZ6LVbmLuNFaWZf7SexZLq5i2BHt4eGcRZzHfaZ?=
 =?us-ascii?Q?Ut32x4w5ZgGa7fKHW0GxwiJm5/MYPNxb63mIiyAO6/637mbX/lp4iZ8xsoPp?=
 =?us-ascii?Q?WItRarSI47KooNOVozcYBEfyXkPjKdxB/tHfw5Xz3y0n3iCPay4LbOaXwgSu?=
 =?us-ascii?Q?e9qqhtr9TNJc4ruSMlSSXq43aZqFIWM2btpE0dQZAdQ0Fx2YL6YDKZxVG+T2?=
 =?us-ascii?Q?r7NQ/4VypOhZtow+ZrjM1Vfr95GFtP3c+3cCSR+9TBEDDcbOt6Q2Od7scxBY?=
 =?us-ascii?Q?lPQWDA6tzClOrlbWTMCEgqjDUD1qbGM4aU4U9C2fJCJ7g/L2AAWsSXqx7D/H?=
 =?us-ascii?Q?s5G21d7+JzLxj2gsm8WQx90metmtdjjqiiNRDvMaN4QoxIo52pn1MVqV/fzL?=
 =?us-ascii?Q?y0GHR1O1ILi9tGxC5BAl7F6b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649f0f2d-8ff3-430f-e9bd-08d95828ec1f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 15:51:43.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2A3lmetkdv8jNqa/nm5JYa+MZalJqNWCkaKc4w9OII6hZBCFnx00ZtCIBLsF3WHTkJluM7UhkFdO02/aRZCRZ0YIjKZgh7ULK9dsqhSXnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5409
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050096
X-Proofpoint-GUID: 02nEN88Y-ADSL0wQv1hcYAygyvk37tw0
X-Proofpoint-ORIG-GUID: 02nEN88Y-ADSL0wQv1hcYAygyvk37tw0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   251a1524293d0a90c4d5060f65f42a3016280049
commit: 1d5558b1f0de81f54ddee05f3793acc5260d107f net/mlx5: poll cmd EQ in case of command timeout
config: i386-randconfig-m021-20210804 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/cmd.c:1036 wait_func_handle_exec_timeout() warn: should '1 << ent->idx' be a 64 bit type?

Old smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/cmd.c:868 cb_timeout_handler() warn: should '1 << ent->idx' be a 64 bit type?
drivers/net/ethernet/mellanox/mlx5/core/cmd.c:962 cmd_work_handler() warn: should '1 << ent->idx' be a 64 bit type?
drivers/net/ethernet/mellanox/mlx5/core/cmd.c:976 cmd_work_handler() warn: should '1 << ent->idx' be a 64 bit type?
drivers/net/ethernet/mellanox/mlx5/core/cmd.c:976 cmd_work_handler() warn: inconsistent returns 'sem'.
	(It's hard to see where the semaphore is released in cmd_work_handler().  Add comments?)
drivers/net/ethernet/mellanox/mlx5/core/cmd.c:1417 outlen_write() warn: sscanf doesn't return error codes

vim +1036 drivers/net/ethernet/mellanox/mlx5/core/cmd.c

1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1014  static void wait_func_handle_exec_timeout(struct mlx5_core_dev *dev,
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1015  					  struct mlx5_cmd_work_ent *ent)
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1016  {
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1017  	unsigned long timeout = msecs_to_jiffies(MLX5_CMD_TIMEOUT_RECOVER_MSEC);
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1018  
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1019  	mlx5_cmd_eq_recover(dev);
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1020  
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1021  	/* Re-wait on the ent->done after executing the recovery flow. If the
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1022  	 * recovery flow (or any other recovery flow running simultaneously)
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1023  	 * has recovered an EQE, it should cause the entry to be completed by
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1024  	 * the command interface.
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1025  	 */
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1026  	if (wait_for_completion_timeout(&ent->done, timeout)) {
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1027  		mlx5_core_warn(dev, "cmd[%d]: %s(0x%x) recovered after timeout\n", ent->idx,
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1028  			       mlx5_command_str(msg_to_opcode(ent->in)), msg_to_opcode(ent->in));
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1029  		return;
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1030  	}
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1031  
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1032  	mlx5_core_warn(dev, "cmd[%d]: %s(0x%x) No done completion\n", ent->idx,
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1033  		       mlx5_command_str(msg_to_opcode(ent->in)), msg_to_opcode(ent->in));
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1034  
1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1035  	ent->ret = -ETIMEDOUT;
1d5558b1f0de81 Eran Ben Elisha 2020-07-21 @1036  	mlx5_cmd_comp_handler(dev, 1UL << ent->idx, true);
                                                                                   ^^^^^^^^^^^^^^^
This should be "1ULL << ent->idx".


1d5558b1f0de81 Eran Ben Elisha 2020-07-21  1037  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

