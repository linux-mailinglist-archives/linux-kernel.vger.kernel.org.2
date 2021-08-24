Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8F3F5B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbhHXJ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:59:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30738 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235950AbhHXJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:59:14 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O8q28a021191;
        Tue, 24 Aug 2021 09:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ERpTKzm3eztSxNEPPVKRoJhb8ZjkIykjf8M5/mJZhtc=;
 b=DaNlouGhHa0+xphFYCsWJfF7WhRckwYXneU4I2SsCXi8GNfZIErkt+eH/6pGS/5SYWf/
 vrJzrk5veZfQ5zGoE7cG0SbZkYf9dvTn04eevs/wtewZ+wZzqSfU0AC5qi2b3U2M3hRn
 2wq1YnHfGK11FRArGX3RjqyNvZiGcgvc9He5TdAz905Zg0owXEr0xIz7P3MaO9Goej5g
 Bt/lFhkG6dWP8ZN7jectQJomhOU0jIAVqEtjo6Z90shS+AolR+p5X0oZJD3e2PoOEs26
 4KJI16Xk4r5jhgpQWqQIKSCuJ3v5mDHqqI5Fr3sAfUwQPTWxb7ypd9oo03wzmCh9i/cH Fw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ERpTKzm3eztSxNEPPVKRoJhb8ZjkIykjf8M5/mJZhtc=;
 b=Xs2OVW4GhXsqA4YJk55q04YtWnwTotNlQ1v4s+Bxt+U/C1D73RPyO6mkOsesF+muECUh
 K2aUWpH3vwI7pXoRoloXbQHppyJDTk9zF76UyMAW7IZjU5pa8bNjJ3wbUSsWEo3iJGj4
 bjPB2S6jZwFkfSb8DiqCa+xhuVkLPGvZMzCZxWIRwYrSj35GG5vESX8pMoqYPRgqRuvO
 wLwiWoEKT9JSJZ4DfhH1WcxywZQfqkjtVZ0TLW5H29L3fUG16W+2VmEWUZgFFrmyalJN
 76BxwER0SzCcmcfZvVQ+dY0SSDlhaS5CYAMFvivME+XzQLuFLHj6gAc+JnKPCrfVlFsH 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwmv85au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 09:58:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O9tEVv165266;
        Tue, 24 Aug 2021 09:58:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3ajsa50bnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 09:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBcMC9YolMkwHr9C0yCSrcS2DsuOHcDhQWLFdYRcnVOkPZ5ePKtVo2mlLgB8W/xQVs1oN5ndkpG4pH7KsGO3bo98IKcMRudjh7xWTSvBcDEgiPcuIn1MjCtOBtCb/IKlkAaB/xxUqBkPhI37RXUqrpaOcR08GfvTVMrlscTKcf/dtX3TFYc4FF6uuuEem99F1EUOMbpFYDKGNQhHion2eJYN/7dfcopZvYpKOCTNgHzg5fh2RQzLNqqNrWieoa6IGtNCy0LQAzljSHuRlk/nacoT0uDeR38OOo4gy52rU1o3Dsusg3I5zESEWIMqK/oeb3P8sFHmZ3FjBbfH+aqfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERpTKzm3eztSxNEPPVKRoJhb8ZjkIykjf8M5/mJZhtc=;
 b=Ad/9HcA45jkYWz71+faWszn5i5GD0sx4dR1cVS1Fgz1QmB9Yzw5wSEDRjw56j41Zz+pUZsU+L2nILl7fQjJusEpiBuq6zGO6C4zI1d8pmDwvRtRuvn/47abboZBdLPsTGkZvJcMyPuWv1kpo2lPQwopehILZxKLMAJlUydmYaGHiyVgLug3qBU7sfcwiadem2LxYyy4F9dnmOTrroR41NOzzXVzyF91L6iu2f0tEIG5QnkjjoDgc/w1LOJIp+8sUj4VC0/AMBA2EWohcTMlsQGh5fdTYKGKAccj/UmIX4/vT20VHS2JMU94zmEGBBh/x+kcwH5Wac0ejnCS8rZwaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERpTKzm3eztSxNEPPVKRoJhb8ZjkIykjf8M5/mJZhtc=;
 b=DckLBM/fib0PiJI/5aCKIC47MMrDWKaFSNMtNBCiI0zwiwD+0QMXalxIJA+7O0KXBT8s5FoR7JgeLUQwDq16vfaqoB8ATjwLDDoo9gM8U07hrACE3S2uStUT3SjTPDAfPbei/SvwNJPhZxcFO8kjxQlJ0Li/xmL5i7L5CA7gg4s=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2206.namprd10.prod.outlook.com
 (2603:10b6:301:32::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 09:58:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 09:58:22 +0000
Date:   Tue, 24 Aug 2021 12:58:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Adrian Hunter <adrian.hunter@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [mkp-scsi:for-next 276/292] drivers/scsi/ufs/ufshcd.c:7965
 ufshcd_request_sense_async() warn: possible memory leak of 'buffer'
Message-ID: <202108241754.681GIVPd-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 09:58:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a7b8805-0886-4be4-8c66-08d966e5b525
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2206D68CD8ABECBA12C220488EC59@MWHPR1001MB2206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbK/aNGCetoLhOfEJ8hZ3LO4ixO0sZ31LRguv2vlaf0ci7ptIlS/IDs0fct6cx3Z/TKeitrikNPLngE0FUiHP7KWGR4wsLSLylRL6CNe2LmjwLo3b9CruMK+tNdGnZK8ZJypYB2/LD4wz1+7VLmawQyRTDPehTyTDjFdL03osvpcVoxE+Q/baOhtSjZsc5henLubJhFVQsSkUGs/RiGPt8bMv4QVEU5VyphepzPgSfdG6Itl0obp6WcGqbKSctNZh8VUGBk7u/LC3Gxw+IhPcHeFmJMieKaKnaZPMsx6a/Hri/KQdHowxmMW7q0kNxFAWm/TQj56jSPNwSic5F3WSQHLqBItzrTZLtzWDvmdZLb6nnXFoxRfm6VDbNleGzl6TlJhby9gn4dVjjnaCYFxakmNT8y1/k1IJwoo3vUPxkwVjU03YwbdkbyddhoHlq4+zMGYoruF/GJcVmeFFt6vJT8Mb3hC4CRMGkaNhuPkQXJWMYac3SvFNXEviUfx9lPsiT5mM1mHlxS/wMdM3om1BFoZqjZ5GuqQUbAesH8yi7nug7NmgveVfudYM4FSlCP5oKMmgCvDXy33FKMUkLJjMOQflvBT2lHtnKHmGH/n1PE5OiUsHtIAtLqH8/BU5IY2FRfiuovKnKTA5uKhBE+yg+y1ChKJOEU+9cRqsjQVlhpFZ+nwgDPwtBoxYp4tMsESegBXXkDYRjETbvSPlsnQT9x7u7xEAYYQ1e9euyyFdHexc6HgE5qrlblU4+HK1qfcZBa7ieq+hV7HI4/YFKgvI3Oh1JCswFH5rk/0qZlCyZRxf3NRtNqp6aGC5+nvjjpHBLFdofYeYKI86wjzCv5QKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(346002)(396003)(9686003)(83380400001)(186003)(4001150100001)(966005)(956004)(6486002)(66946007)(38100700002)(66476007)(6916009)(478600001)(26005)(5660300002)(66556008)(54906003)(8936002)(8676002)(52116002)(44832011)(6666004)(36756003)(4326008)(2906002)(1076003)(37006003)(6496006)(316002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zVvp0oT8NlyPHd6vQzxIHMFqd2WlZQHZTGYMA8sD7duLwP5gq6BMWDF1dVEe?=
 =?us-ascii?Q?RceBwSsUCvpRj1RUty7te8xbg0sfbNOnHirT6abxgzLSBUblEuzM9t/JfuWu?=
 =?us-ascii?Q?vPDJ7urptZnoQsNokWVFmph+jrjdN34HRXy74vakogH2Sc72MB5ZdQ+b3B6L?=
 =?us-ascii?Q?RXSxh7nq1wntB/J9RT9MJoOlVCrKcdpkRkrM8ZD9Y3wxvOdlgJ8vp5OhNzIr?=
 =?us-ascii?Q?ZQY3qnVpkDRLK9U6atcizwPKU2nPK/VcxJLUFjaRT7xoCaFgrB33hECZ9DAn?=
 =?us-ascii?Q?05i/Rt7ezClgfUKqIo0BwmMnX52dsaKt2LBw9qEN/EZhvoCbvaawSOs5Zoew?=
 =?us-ascii?Q?yAsszkqd5JmKrxV+wp3LEWgY6vr8u0uIlJj4SuME7VovEtIY9ll1wwWz1hax?=
 =?us-ascii?Q?F11Gx8FBeroL+aDn5/a1cZ2gtfiSqaQUbQoR1K/w+/5Rz+6jc8LVGHYJfpjE?=
 =?us-ascii?Q?23PV60OEkPZDkChQ8QG2vgU+yclTJMyK/f+UGXCNVYrJVv3OQ9wxhLYoec8a?=
 =?us-ascii?Q?woAWcCX+bgCTNAdtXmma8aY9YXf5vyS8pmKUwX9iV064NVlcrI1mq1XDftFC?=
 =?us-ascii?Q?ogtjx6FAdVTqoFlDYZzbJX+jJN5LFebt5kUXUpoHbGWikDiAil2K1lmCDGEl?=
 =?us-ascii?Q?JJf9nrlf3cjpTj/uGnxCLPMKc6a/mGhu8Zy+mmfq46LjABbrHoN9jTrLHUOj?=
 =?us-ascii?Q?YN+9f2hk+Xq9G2N1oU7MS3JWnW0vRHiopPrr6PXAHz6cocBGWvWYMObHCZ51?=
 =?us-ascii?Q?76Y84Ascy4Ec/VnVA3qlx+KJjhn/ZJaTvr9kyi5CqOYO7ZIM5MGqHxCjCAza?=
 =?us-ascii?Q?MxJFRWoxsdrB8gObCDEmZ/y/o6IGI3cG+PIwxEEOpLT8HQrnq74RkeMqa7yX?=
 =?us-ascii?Q?6zCmIzyuEJt+eDbX5OeAGtyTWCb5HKHFxNxMsMZldexXXYbcCUrwnqFGX0+4?=
 =?us-ascii?Q?ebdchSx/LBlgxtfjoAhhKWSQgVmiUDEleOSYyFa2pf8Sz7S2k/86TFBNhkUh?=
 =?us-ascii?Q?KsnZZDFRbbvJf2kES+ifm7/4MldN8giYvr+smyfPKk4JrvOdLz5AQlO155NF?=
 =?us-ascii?Q?ZacsNQTYuTrYvvUkpBPRIVow1RGm0tgmcN4s2msITYuklYMMqvwzZzVfSsc4?=
 =?us-ascii?Q?O8ISxZULztOU2krSRLT0Qa2BdqLbzNnLqDc7GGC9JVFEaDx39x6uKfp49N4m?=
 =?us-ascii?Q?jiwTyMBVvOKXfy5Hu8KwO4nyblW+AoQ1zKSufBuS3lzml9+XS2wMi/QGR0N1?=
 =?us-ascii?Q?UddI/6acOkxhzGeX6IT8rXcbtTDDgQQ0uzrbWKyC5xWpLM5KfhQBRa1JkzBn?=
 =?us-ascii?Q?oqWcAk2kDpKDuVKmG+dq04ld?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7b8805-0886-4be4-8c66-08d966e5b525
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 09:58:22.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExNkivYKud/lPeX2fW0yJQL21nWh/nahFmIIzVuN1yRfpu6mw1DvzibmiVGiyAYLK4FyplvrCGKX4Ngs/hC/yAoWskLNaXGSqlau47XEUxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240065
X-Proofpoint-GUID: HGYpJZj_21L2ihgC3xkzHZ1nfT_2gF-b
X-Proofpoint-ORIG-GUID: HGYpJZj_21L2ihgC3xkzHZ1nfT_2gF-b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   d09224115cf67bdce4eef2ca3533f86ab1ea1942
commit: c6b2e1373c89c4ecf2b379720b3eb24cf99844f4 [276/292] scsi: ufs: Fix ufshcd_request_sense_async() for Samsung KLUFG8RHDA-B2D1
config: i386-randconfig-m021-20210824 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/scsi/ufs/ufshcd.c:7965 ufshcd_request_sense_async() warn: possible memory leak of 'buffer'

Old smatch warnings:
drivers/scsi/ufs/ufshcd.c:5254 ufshcd_uic_cmd_compl() error: we previously assumed 'hba->active_uic_cmd' could be null (see line 5242)

vim +/buffer +7965 drivers/scsi/ufs/ufshcd.c

4f3e900b628226 Jaegeuk Kim     2020-11-17  7945  static int
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7946  ufshcd_request_sense_async(struct ufs_hba *hba, struct scsi_device *sdev)
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7947  {
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7948  	/*
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7949  	 * Some UFS devices clear unit attention condition only if the sense
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7950  	 * size used (UFS_SENSE_SIZE in this case) is non-zero.
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7951  	 */
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7952  	static const u8 cmd[6] = {REQUEST_SENSE, 0, 0, 0, UFS_SENSE_SIZE, 0};
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7953  	struct scsi_request *rq;
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7954  	struct request *req;
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7955  	char *buffer;
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7956  	int ret;
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7957  
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7958  	buffer = kzalloc(UFS_SENSE_SIZE, GFP_KERNEL);
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7959  	if (!buffer)
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7960  		return -ENOMEM;
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7961  
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7962  	req = blk_get_request(sdev->request_queue, REQ_OP_DRV_IN,
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7963  			      /*flags=*/BLK_MQ_REQ_PM);
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7964  	if (IS_ERR(req))
ac1bc2ba060f96 Bart Van Assche 2021-07-21 @7965  		return PTR_ERR(req);

kfree(buffer);

ac1bc2ba060f96 Bart Van Assche 2021-07-21  7966  
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7967  	ret = blk_rq_map_kern(sdev->request_queue, req,
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7968  			      buffer, UFS_SENSE_SIZE, GFP_NOIO);
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7969  	if (ret) {
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7970  		blk_put_request(req);
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7971  		kfree(buffer);
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7972  		return ret;
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7973  	}
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7974  
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7975  	rq = scsi_req(req);
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7976  	rq->cmd_len = ARRAY_SIZE(cmd);
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7977  	memcpy(rq->cmd, cmd, rq->cmd_len);
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7978  	rq->retries = 3;
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7979  	req->timeout = 1 * HZ;
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7980  	req->rq_flags |= RQF_PM | RQF_QUIET;
c6b2e1373c89c4 Adrian Hunter   2021-08-23  7981  	req->end_io_data = buffer;
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7982  
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7983  	blk_execute_rq_nowait(/*bd_disk=*/NULL, req, /*at_head=*/true,
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7984  			      ufshcd_request_sense_done);
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7985  	return 0;
ac1bc2ba060f96 Bart Van Assche 2021-07-21  7986  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

