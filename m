Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BB83D399C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhGWK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:59:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22414 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231703AbhGWK7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:59:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NBVElB019020;
        Fri, 23 Jul 2021 11:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=iozL2QkdUGMTBUxL3qiK1+23QfeC7vi2VCeT+NtDYDw=;
 b=wT5mAkT2BzUyMPl0+BLypa+sm0+ibvRzRZf5si+fA9+bZIGL27GykONMqCCZDN83JFh5
 BgrqRJgAG+W0gHsiteC/c7kZG0Q/qK7DLXU3lWyVRCIOaWQ6v2tZphsiEVDXnVQR4nG/
 SOnpOPre4PuZJbyPasrIvOhUVGgHord2b3M/pwD3SiGuVBshNZNylcOKYfRJFoHkozmr
 iLY9aqAl9cXeCxSzFLihm7yPSNDkHVL2NpoCIDIvXLOpHcigB0Au7R2+z/4ww+zQqVEh
 UTckphfzWXiEgdPKm1itQJFWFe0ZD0OR8FZDhcmPtKlw51BHksvyyRAYOCfJFzonPbMs 4w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=iozL2QkdUGMTBUxL3qiK1+23QfeC7vi2VCeT+NtDYDw=;
 b=a3WIpDxpP0iEFkYfgsl8DJzL2sYlizJgqnusryWFCXu7eWMMcsYIW0UBbq5TtmEvwfvR
 pkM6AxtZ/WS5gtmPOP/+s+ey8dmmfuU59aPACO4zsFvRDtbkLp4wGHIAxmPx2A9clAum
 JsRK8eJ3f83HAlg5h54trdyjng/bDtL3eRbfTNUIshGX5jG1ZErtM17oK5/HfeBSGCxp
 Agzg6aM1jYv0+HQiAnQMa80f+n2NcvAOeDJuoIQVkKL1C7dT54E7shgT2gNibkPGkxfM
 iuxQdXdtM5u0CSSeRLqMwnG2L76r10q62t4eCwEcA/o/AfIgAVIu5wjn0uD78GL2MsUG NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ya57a8u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 11:39:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16NBZRUT098601;
        Fri, 23 Jul 2021 11:39:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 39wunqrywa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 11:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZZ+XSgjPFbxzDiKEAFonB8gRv6yLAWoWSGdARAK+hS3AlRbw66/VaLFCfTx57oYh7rxFF7sbd+e46UfTGoLIh0oCUSxPCoaNlD43wVdFCNMjCndie4UtN64NLWZLIwubL26raQG4tHDPB4O0FecoANDoMZnjPN+nVWKaz8S0e7M5LpxSnAA3yXSTaBdQYSgHACMYs2mnbhnKm8ZVOwxcc6axHGQ1XhWuynMIiSWmrX2Pm/wviGeFm8RXq4LmQXu8On8O/eiY+fTOpwZgznbxDmBuvGreUGJC3y42X4s4lKAvn8QhqBLb7edjhNAwh/ApVdKGHtX70O7be13GOc3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iozL2QkdUGMTBUxL3qiK1+23QfeC7vi2VCeT+NtDYDw=;
 b=SGXBbjl11mMVqt8R7QZM+lLYd8JG9/Pkb1udENPMhbdPx+w08jFFRqJZoUHJUeq9++C4txtjTpUYbJm6vBqgl9/TlhO0hNkNqYUaGOLPD4gXqGwnSpYKP8x7BamSyyPhp5A6F79EhknogZ1mFRldYOvG7CwVJpfdw4rOUTU1iKsDNcnIOq+YyWIsJxwMDIzIRA/zLO+dQWAPBJ1cas+TqoWGWwFSZOWT2UEOI4E+XdiLMZdQqRW1XookTPLYmw5a+2UFt3zN2ouW8y2OQuNQU0SRG5FOFSsd50Fuk+FB1ERckDhJ7vTydwNQ17rpZR+650SMBtVsvuncija7Pzb+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iozL2QkdUGMTBUxL3qiK1+23QfeC7vi2VCeT+NtDYDw=;
 b=k3fAYvxKY9J1IERun9uHttv8QoJHtr5UqTeyAJm+toz3P1vx/ZrvBMOWQyqNOhqYBvcRO20hRQ+P+xOr0Qk4iPCFBjbgSp1uOfVmqs+Y9+su660qWEWMjC+v7LblQeLPaCQ5rqznnUSbWPMYhArezuYgyEBazXGM7BkQ874tAHI=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2128.namprd10.prod.outlook.com
 (2603:10b6:301:2d::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Fri, 23 Jul
 2021 11:39:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Fri, 23 Jul 2021
 11:39:42 +0000
Date:   Fri, 23 Jul 2021 14:39:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Sunil Goutham <sgoutham@marvell.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [kbuild] drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:4360
 rvu_mbox_handler_nix_bandprof_free() error: testing array offset 'idx' after
 use.
Message-ID: <202107231909.fA5QxIKe-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 2ID4ZA2IC5SWDXRHR3IJDKM6S7LGKPBD
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 11:39:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c953246c-034d-4b71-cfd2-08d94dce9036
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2128F29A3A6519EA272C9E9A8EE59@MWHPR1001MB2128.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9miczcIz7XBwkjnl2M807uhnGFbG4esIc/bvpMSYGiHGontNZk2nxHSynkEXuZx17YrT8Y3+aYPZET8TKSGyaNmOSwPsK8SjrqBSRntBhBBtbpVuHfnvC36270OBBnLOZef1l/1wpHPZlY+EorQZg5dVOKLa77a4wDT7/KUcriaKf6RE1e8IDailCNP9KioqV10wvvQbRHqbzCqbnG6di+hGbY58/R/VAZKCs2LqrpBPtWdiBs2w0n+cKsXzS+mgVT92Bjcjcp8NTWyhMMbh9AQGA75SiM5dkRwSYzJgnTLEbu4ditTj5Cxir0DIOqdN49qcUQc3LhgTQ2IItJK6tFWVBYTb9FclzRwzArNs1jt57nrapL3Oa6KcK7esyLiFr0oZcVS6z/gqOFPJuupcUgHqkIXkCkKpTnwjK6MCsaTPdwO4lce8i1EzZElOoxJJDA820CvPKZnajNt6+emiQAg4xx/5huszIsijU2ojVWJWBxvz+qFm5mKfv7O3FkwFtFWI0RdJvn6sQp2/Bu/G93Kacv4KO8HcbiemE8b1apyMwH5tr5bLjs5cR5pD6g6YJ4KCp6pMhJ5gnaIi/s/3/0ZayzRmSiXQbKolJ1Jpg1KPQLrG3bVlTDchoGoLHvIHW+qwS+KS3cy43hokClOfLyWNbYWzIeSa+Cd/3U+efoXykRo75Xoo9O94WFddWIHb6u63aPpypc5WmbYRey0z9L6Nlp/9KxWfI5+Pj7UC5l0cs77VYQvgw3ptRZoGiWyUAy0GwEYCgT8kbEVSkNx2hLy5Q3zb9XZzLrnRfUT0xEiJeMwTukvJvyXlhYuEgyOaf7Kyh9bL46CpNHNE8X4Rbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(186003)(6666004)(26005)(478600001)(966005)(6916009)(2906002)(44832011)(9686003)(956004)(66476007)(1076003)(4326008)(6486002)(316002)(52116002)(6496006)(66946007)(66556008)(83380400001)(5660300002)(86362001)(8936002)(8676002)(38350700002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CREx9uF04Vl3WBGWV2LKoBvgFcNSLzQvXFA5BnK9g1SGin1FWwff5xmxjCgP?=
 =?us-ascii?Q?BhujTR7UhfZvhhv95wdFI1+E3atvEX0MOlyA17dd6eLwMMgdD0n4tMolWz4d?=
 =?us-ascii?Q?/AK18/FZH2ZJ1PxaaLfdNAd5pboqrSr4YOCBlRk1Q0FLrFdAX94YHkU3wXrF?=
 =?us-ascii?Q?wtiGqYyvjBQMGOX4TAvEIvIx0/EMMj6deW3787nWEd4oAtUXjO6+pyg6Lzkx?=
 =?us-ascii?Q?ucILMwqrh/ezp6Y+fYKe9DmfyJcvnBdfIBVQ08HCXDA75ABxxCr9sObbzMFM?=
 =?us-ascii?Q?jLD1C2R8DLmGXelwCRGIFUFyD2cbefz9pKI2ubCrnhhZhUGZfqYM1/XhqWQc?=
 =?us-ascii?Q?IZInl7vJOzADhOQQTIaQSQV4dSE/TLtQdz60SW1gPtos3JGxSMDxDO2ne7Q2?=
 =?us-ascii?Q?1E0gLMna+PeBg8IfDltj7ElAB/sXY0YZI+bQthQhfMemqnnrsmY/1KtKoz0d?=
 =?us-ascii?Q?bKXIyp6ty74yozLdz/4RhgQDaSkJ6iN7oM67TQQkyujDSI29mEaGMebNmmA1?=
 =?us-ascii?Q?vEeuOsA/xVBjSqcZ1xLivTyVq9JGiDoBD1iM+/LtrhKEKS3vIF2bqaneroxd?=
 =?us-ascii?Q?/m96skvyvva/CPSqxBf3llmdnv8oCFvyjBYvawTZNMEY5D7Zf5UC1wcH56nX?=
 =?us-ascii?Q?l+gX9tLdBAHCR6GuarMZ5FOyKG3xg3TWyQMBAlB1PomD4VVpeHgU5udQAM+B?=
 =?us-ascii?Q?JglITyWb7mbsVTduzrMA0q81Rws1shZGN5yxTN9fz9e+RziIHMU4hgdk2++T?=
 =?us-ascii?Q?lEjXaThGtAHUN9zfAJaLGsVlOwFtpUpu7XC4q7eDhAA/69hliTVZ/2YY4ZSm?=
 =?us-ascii?Q?KK+AHBf8Oz/y++/VENUzQ6OwpANnBFfcVivs6ALOB3jcjDrlnFZpP0+hd+aN?=
 =?us-ascii?Q?b6PDYx1k06BhxAFtGgETGpgaIXo1lSvr/I698JmuT78esY4ds/LUu5O7AZfM?=
 =?us-ascii?Q?j5u3eysa61uwlE4KN59AwBNcAy8jtOvMfIGXcsq2AwvaMJDZOR13tOx3/G3L?=
 =?us-ascii?Q?DR4wpC9emXdSp8XiMf8G6b5pHOQTlETffac1DSnl0L9rqU5fDvvA01ipkVE9?=
 =?us-ascii?Q?xkFCgp6FxeLq0Cp1XRFzwuNQIl2oDgrGWQe27i8NpTn5qFE1FIAEGioD3mLF?=
 =?us-ascii?Q?GhH2VRGEgeRElIQde8cjfpzCaZCnrql92szhdqTbtAPtCBn+M42b/sTnVRCD?=
 =?us-ascii?Q?DYOWAGMBKQqu7e2qulIjxZG9ktq16Jl0Y75vxrwV2EwB1/7w8ZCxycdKi5BU?=
 =?us-ascii?Q?qgorjio+PrSIAmpdBr7/HZuHgB8pj6xuqGX0sd9eWZtm771O0TVQoc3UnVEK?=
 =?us-ascii?Q?ZdwPqtdZzX39S832lx6pxcB8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c953246c-034d-4b71-cfd2-08d94dce9036
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 11:39:42.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWNfz5B3qASHaAKQ1hV92DniczR+prriKOnE9Zrz229qXTfgaqBP+NXihHMcsjG6NwHxArUZ5eFSykjk/ASlreGe7yc8QNE0MCM06ejxPIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10053 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107230068
X-Proofpoint-GUID: itKva6C5Lx5LH_acCVozruYPwgQ_6U6m
X-Proofpoint-ORIG-GUID: itKva6C5Lx5LH_acCVozruYPwgQ_6U6m
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   8baef6386baaefb776bdd09b5c7630cf057c51c6
commit: e8e095b3b37004a4048af69de60c9af2d2268a1d octeontx2-af: cn10k: Bandwidth profiles config support
config: mips-randconfig-m031-20210723 (attached as .config)
compiler: mips64-linux-gcc (GCC) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:4360 rvu_mbox_handler_nix_bandprof_free() error: testing array offset 'idx' after use.

vim +/idx +4360 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

e8e095b3b37004 Sunil Goutham 2021-06-15  4318  int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
e8e095b3b37004 Sunil Goutham 2021-06-15  4319  				       struct nix_bandprof_free_req *req,
e8e095b3b37004 Sunil Goutham 2021-06-15  4320  				       struct msg_rsp *rsp)
e8e095b3b37004 Sunil Goutham 2021-06-15  4321  {
e8e095b3b37004 Sunil Goutham 2021-06-15  4322  	int blkaddr, layer, prof_idx, idx, err;
e8e095b3b37004 Sunil Goutham 2021-06-15  4323  	u16 pcifunc = req->hdr.pcifunc;
e8e095b3b37004 Sunil Goutham 2021-06-15  4324  	struct nix_ipolicer *ipolicer;
e8e095b3b37004 Sunil Goutham 2021-06-15  4325  	struct nix_hw *nix_hw;
e8e095b3b37004 Sunil Goutham 2021-06-15  4326  
e8e095b3b37004 Sunil Goutham 2021-06-15  4327  	if (req->free_all)
e8e095b3b37004 Sunil Goutham 2021-06-15  4328  		return nix_free_all_bandprof(rvu, pcifunc);
e8e095b3b37004 Sunil Goutham 2021-06-15  4329  
e8e095b3b37004 Sunil Goutham 2021-06-15  4330  	if (!rvu->hw->cap.ipolicer)
e8e095b3b37004 Sunil Goutham 2021-06-15  4331  		return NIX_AF_ERR_IPOLICER_NOTSUPP;
e8e095b3b37004 Sunil Goutham 2021-06-15  4332  
e8e095b3b37004 Sunil Goutham 2021-06-15  4333  	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
e8e095b3b37004 Sunil Goutham 2021-06-15  4334  	if (err)
e8e095b3b37004 Sunil Goutham 2021-06-15  4335  		return err;
e8e095b3b37004 Sunil Goutham 2021-06-15  4336  
e8e095b3b37004 Sunil Goutham 2021-06-15  4337  	mutex_lock(&rvu->rsrc_lock);
e8e095b3b37004 Sunil Goutham 2021-06-15  4338  	/* Free the requested profile indices */
e8e095b3b37004 Sunil Goutham 2021-06-15  4339  	for (layer = 0; layer < BAND_PROF_NUM_LAYERS; layer++) {
e8e095b3b37004 Sunil Goutham 2021-06-15  4340  		if (layer == BAND_PROF_INVAL_LAYER)
e8e095b3b37004 Sunil Goutham 2021-06-15  4341  			continue;
e8e095b3b37004 Sunil Goutham 2021-06-15  4342  		if (!req->prof_count[layer])
e8e095b3b37004 Sunil Goutham 2021-06-15  4343  			continue;
e8e095b3b37004 Sunil Goutham 2021-06-15  4344  
e8e095b3b37004 Sunil Goutham 2021-06-15  4345  		ipolicer = &nix_hw->ipolicer[layer];
e8e095b3b37004 Sunil Goutham 2021-06-15  4346  		for (idx = 0; idx < req->prof_count[layer]; idx++) {
e8e095b3b37004 Sunil Goutham 2021-06-15  4347  			prof_idx = req->prof_idx[layer][idx];
                                                                           ^^^^^^^^^^^^^^^^^^^^^^^^^
This array has MAX_BANDPROF_PER_PFFUNC elements.

e8e095b3b37004 Sunil Goutham 2021-06-15  4348  			if (prof_idx >= ipolicer->band_prof.max ||
e8e095b3b37004 Sunil Goutham 2021-06-15  4349  			    ipolicer->pfvf_map[prof_idx] != pcifunc)
e8e095b3b37004 Sunil Goutham 2021-06-15  4350  				continue;
e8e095b3b37004 Sunil Goutham 2021-06-15  4351  
e8e095b3b37004 Sunil Goutham 2021-06-15  4352  			/* Clear ratelimit aggregation, if any */
e8e095b3b37004 Sunil Goutham 2021-06-15  4353  			if (layer == BAND_PROF_LEAF_LAYER &&
e8e095b3b37004 Sunil Goutham 2021-06-15  4354  			    ipolicer->match_id[prof_idx])
e8e095b3b37004 Sunil Goutham 2021-06-15  4355  				nix_clear_ratelimit_aggr(rvu, nix_hw, prof_idx);
e8e095b3b37004 Sunil Goutham 2021-06-15  4356  
e8e095b3b37004 Sunil Goutham 2021-06-15  4357  			ipolicer->pfvf_map[prof_idx] = 0x00;
e8e095b3b37004 Sunil Goutham 2021-06-15  4358  			ipolicer->match_id[prof_idx] = 0;
e8e095b3b37004 Sunil Goutham 2021-06-15  4359  			rvu_free_rsrc(&ipolicer->band_prof, prof_idx);
e8e095b3b37004 Sunil Goutham 2021-06-15 @4360  			if (idx == MAX_BANDPROF_PER_PFFUNC)
                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If "idx" is set to MAX_BANDPROF_PER_PFFUNC then we already have read
beyond the end of the array.


e8e095b3b37004 Sunil Goutham 2021-06-15  4361  				break;
e8e095b3b37004 Sunil Goutham 2021-06-15  4362  		}
e8e095b3b37004 Sunil Goutham 2021-06-15  4363  	}
e8e095b3b37004 Sunil Goutham 2021-06-15  4364  	mutex_unlock(&rvu->rsrc_lock);
e8e095b3b37004 Sunil Goutham 2021-06-15  4365  	return 0;
e8e095b3b37004 Sunil Goutham 2021-06-15  4366  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

