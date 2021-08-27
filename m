Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D623F95C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhH0IJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:09:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30104 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232977AbhH0IJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:09:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6IoAK029077;
        Fri, 27 Aug 2021 08:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+NuCIws4Sdej6ZX7nYahQpaK5sBs/Lbw43wYhAROfZs=;
 b=RVVhEk9tsEeSEGi2u+ykM57MyBP3pdrFdLfpfbTKa+003xxJ+dzp4qJFQPPc4X3YyzVz
 pTzzw0m5HCwDZhHtSRuYlMv38As8eOXGtZxQAiMnMahuyYyF4Qhkf5zwcxF+R59iNlF1
 KLx7rR5QNAqEZG4IcYs09D5lg3NpG2gJDW36d6BD/orax3p4/JAJzikZNx79Wptel3Tb
 s58lZxAxJYGgphnlRLIicaAt9X1k/tTchk130hSC7r5HePA1tJjuYMqD0mebUgz2/uFS
 PmfT9A+qmbOMspzWHT/GeT+OMdN6kxm07c5jPLeaowHZ5+acpWgT0e+/Z+q368SGKYKf UA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=+NuCIws4Sdej6ZX7nYahQpaK5sBs/Lbw43wYhAROfZs=;
 b=GNwPinRPUn1HztLyt6o60lTwUCTJ/7gHJGDg8nJXtW8FGKzTUGUpxnUscsyHR6HMBCQq
 CyOz+aGb4f5jqyzgJSc+gIOtCrnGDSZTjqnQpyGqzOsE1HaedM5Le4D6SHlMgmMhQtpG
 55n2adu8pOP91LYZMb5dqTpNOHBRkVkoH4U30pgMZdNIGheSHqwFyCoAUOMjTe7L0rFk
 HP7C3dEWtF1lWv/HGsPTDh3IMRyM0J8G78Pgl8kEdwOLZRuY7VC0jSeXyrIveTih+Yt6
 OsOiCmrtPnox1yWteQ+QQkIyESY+QJ9PHumZ4f67IlCjy70bn6BxrERJ6LM5d5yjdQrl sQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap1r5k7u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 08:08:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R85au4055118;
        Fri, 27 Aug 2021 08:08:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3akb91pj4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 08:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giojqIgd7WklzULO3hRJXKb3QyIPAFQqmFVAWRQvUKZvoTaHMicjtDkfRl9AfESVDzZN+kPgMbrXGG5HO7j6weaI+6JMqxBatTraPKi51gYuME7psuHe/5ezcshmYSLjcyP0MEyZAzN6JPoNphE3YxFE+nNXjF3WnMkr3lyhvaRwOQK5cnt94GNL0tLflwMJKwyqqVVehnzq8hgPmxo/XzbOPJOdRi1OHPw1FHp+4ZEDVKZ1BbTsnmXgbAzqOAk6EPhnyZJBy1N9tdtRuquNvabJ7kC5KSVxQZWRmZGct98OiZfbiUFkz9f3UK2S5V5jL+c+vKmhh2AeRs5Ymrc9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NuCIws4Sdej6ZX7nYahQpaK5sBs/Lbw43wYhAROfZs=;
 b=nY38pjhTgqGrFmlKZJ4hCCZpNfKxd8ItkcQbhrB5/uBCmLwqunYmAx3oAaFNP74goVqd8nyYn2vNjo374lHmQZGoqsM7y7dH/QSQw1DXfZz8QIQgOIZJkdwygJFoX+SwnXJaHKoAefoNYT7xNsGflX46bsWyLivB8F9DJeP1FBrG5trvLyLrgRU9uY6HSErIB+/kUss+Ssfmvls0Mb5RHt00ZPo+nZu+oY2xbM8ydAesAkDR+Oi1NnxamrBhenrU499xJ2W2+60pRJ7XyrjdJAtR0NMYWc0m8hTLLhWqT9ZQrYyJiyZBRshB2R1AUHSRSBDGgjf3Num3Y6FdaPPhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NuCIws4Sdej6ZX7nYahQpaK5sBs/Lbw43wYhAROfZs=;
 b=X8+K+wz7mfV778SnhLsKOGYUYjzNNkp0OSscgdHHcSyKoz/A8hx4YE5K9jbPJOCQNyvVYC7GLvFo/o5DbWhBCZfA23WyswhwlGYFR13ez3gu1YlBzxW4f2HmqJw+5IOOf7f8IkFidEXm8sIxaSr0Cvu/S7JnIlcijQvGhPk78RQ=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1662.namprd10.prod.outlook.com
 (2603:10b6:301:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 08:08:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 08:08:52 +0000
Date:   Fri, 27 Aug 2021 11:08:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luis Chamberlain <mcgrof@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20210820-add-disk-error-handling-next 89/90]
 drivers/block/floppy.c:4540 floppy_probe() error: uninitialized symbol
 'err'.
Message-ID: <202108271344.eCzod273-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Fri, 27 Aug 2021 08:08:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51fdae11-a778-49e5-0b2c-08d96931e814
X-MS-TrafficTypeDiagnostic: MWHPR10MB1662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB166250F3056D8A4F616B3CBB8EC89@MWHPR10MB1662.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /M9nJ751A6IxzrU4TzD+alWIEOpIf3pve0x5boNVex4Mpo0doPekGJ8nHAn45x4DRnmcZ9n1XtMPD9J4vXM7mS/P5xcudDK/yspv3N2b7JP+J2XaBTq0OOd2SQfWT2Lxz5zWyrbnLj/D4PVGyapj2yzbJIRmmNzwl21dFY34nYzG4Ly5C3Bg3NI5Z/KRiMCimilTiV6vtrQv9NY+61Hhzc4F82ZhRh+rsDRNvVAq3yXFbcvZtMk2ejjL+p+UrR+Fw4uNdoecLd0Z5Lfu0DutlF+uTuuMwH0xafeAgfkBljv1rSvD4W5vs8fqf6yYz96+zXwGyJ8f8+QiE8YbXfRCrYgHTBgvDow51GlFmLEcTH2oFUucbod2KlpYp/MhnyvbwGzgsoSjq+VikNHgQ9OZXt+cMxzBpGjpff1ygmkDKNMo5oKJzRQ8CnaF5ecdEZb7E2eUsReslLk3WUJoFpB94fEPK/hrgWLcQ0OIt/JG1b7Jptm02d3Jc36Ee5p/cIhSbClXF3UJ1TBkcTeEOsbO7zWgEv1HEDgUfk0A4eUDnAqPtls7lWddqmh7zxUBSa2jMc2YLgFc2sVT/R6eSbE5SMuZ8vGHp/p+1RdyLN3Otc8pqGUGMPUbRmS6tGCpsjDMrAQYv477sCId18l2wWEJqGkh7jp+XR4TEoqsl73A4c3m8kdkBoNDKIJ+YM+w+X9WH3bI1i7k29mcs2AVs1xUu+C6IKShJ6MghSve4p9o7bmngw64/t8/yzcnU+I0kKfMYUxueuplhB316O5YZtOwZjvc2GmjZieenRQDbSFOUN/Pl/clNFYebByyj1sa65rDMsOxS9SBfhbP0d0DcLQ4kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(316002)(6496006)(38350700002)(6916009)(186003)(86362001)(52116002)(4001150100001)(9686003)(6486002)(38100700002)(5660300002)(966005)(26005)(83380400001)(8936002)(4326008)(956004)(6666004)(66476007)(2906002)(36756003)(66946007)(508600001)(66556008)(44832011)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKaM1aR5Gd2SzRDEPIzjLLYJcXL/xwcbqpQpieaS/MOJeqM2KZfqXD7wHST0?=
 =?us-ascii?Q?cSfmPxwkVeZc4fkMdvCB1h3EkIbMQOpifJQ3x+tIve297mqtrckrG4D7eHmC?=
 =?us-ascii?Q?ux1D027/qTAp/Cv+fYy0HHmNri+bZRHVUlV0WTXTedyou0A4slih9jXynim+?=
 =?us-ascii?Q?FXHmGDM/Q/qqhnkuBJFQuoBXS0fn7OVO4utMV3qqTCJjiJC7hJu0tNKghu7d?=
 =?us-ascii?Q?SOp4PcCDUNk3DkBUj9mgmGiGeCLMNvsjuR/NSSN5R2OLAzNEWuD4wn3/oCBh?=
 =?us-ascii?Q?AyaTfFTk/bCZXU3ny+k7TviZFhai8xGfALtnU5EdyDtAQ5k1MsK2doDDvmh9?=
 =?us-ascii?Q?1s/CMUpiz+LHK2DJoGWtlgRdGZ23BMt0tdZxBhRFLsPILQs/5zvEEFpbmw2u?=
 =?us-ascii?Q?v4gtw+iPJnVh9iSWb5SnILNFwGTkA/s5iP5kZHU2h2McIygNtLjsYBV6DfH3?=
 =?us-ascii?Q?qkvbJ++O+YjlFIDNkG68Z+2ODBttMLYdAPiABFMpCSuLSqNijHVxKCN7d2RR?=
 =?us-ascii?Q?pfYJMUtaqMCPlYk+ez86D3XInPgfqhXFrpPqI18hf6PcbFXlYQiRU+PMXh93?=
 =?us-ascii?Q?SqwOaeM46Mvb4m71cXeeUAsprCjtb0c25vkeVyMI7DAoVqNBragPpgPrJnwh?=
 =?us-ascii?Q?mDsUX0kVrqyBjFw9D3uGKNYul7LODwDlZXZaG91F1HVunV5W3GAoLmNt1yzB?=
 =?us-ascii?Q?edbAoyAvxPRgXGfFk101OAXeltCIpykI5zulPL98sRrL23DdjlpqWOcpp+IO?=
 =?us-ascii?Q?7EiqSJAPI84JZDzAd1rRSaB/liDTgijQRBVa2ZKt65WzWctirZQO78/eUga7?=
 =?us-ascii?Q?bKrq7Fwvz6l+w3hAHUF8bwKrhz9uozV2vOp3Rz4mAqiyZ3L6k04o5WHG7Dxi?=
 =?us-ascii?Q?iwLU+0AOn5Y5qEggxAOdXr8ZoKyKCHXfHKI0Vh08Gm2KBvnpKvHcc1gAamXc?=
 =?us-ascii?Q?wBEBo2TGPL0i5Tb06L1Pfls0xiNfn8qZYcf7FUnBPGwaBywmaeCWY3iDtCi3?=
 =?us-ascii?Q?XvZBFbP3h5pbylnJ3TiyG3G6Y4Imo4OLHTvpDuHb8KSDJ3vnZmz2cCBUHHrw?=
 =?us-ascii?Q?C0st4iPPzuc9+cMSoIDnwSWxKkmTxvYmivBPOyN2088zh8uS0hj7ssbXE568?=
 =?us-ascii?Q?5uqgt8xKM93XRDmIYFoTYyZVVyDp0qcr0KfGZfbnjK5B0UBqlMPglUu3ZUIB?=
 =?us-ascii?Q?1Zfa2H5lRWcVfJ2qk7dpL/vPYpeHqaFmzB4nxADzDEHfms7qhAmdb1A5vDuV?=
 =?us-ascii?Q?p/5J6BETiruJlAcP9DEBoZ5jfgh6qjq/1GTSPHH/LnAqbRP0NI4yvEzg+JQ7?=
 =?us-ascii?Q?gM8d6Vmljca29VlIHcns27MF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fdae11-a778-49e5-0b2c-08d96931e814
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 08:08:52.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpjNdTGumM7Mx+WEAM0j8OtdExnUpE6iva8ux+lrQeuu6vQRPgmVRMMvvP6Gx7RfE07vHh6PyRyYak+ncfLJ6z4LxmUUd9FXPgCl1MPb0sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1662
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270053
X-Proofpoint-GUID: HgWsBxlgGTGYyajmwhoE6hHbo5ehECV8
X-Proofpoint-ORIG-GUID: HgWsBxlgGTGYyajmwhoE6hHbo5ehECV8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210820-add-disk-error-handling-next
head:   9a845121f1e14033032e7cbb772ca21f24be0cb3
commit: b08dbe6faf0fc2f3589d5e9b191899b7d9ab0b6d [89/90] block: make __register_blkdev() return an error
config: i386-randconfig-m021-20210827 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/block/floppy.c:4540 floppy_probe() error: uninitialized symbol 'err'.

Old smatch warnings:
drivers/block/floppy.c:2794 redo_fd_request() error: we previously assumed 'current_req' could be null (see line 2782)
drivers/block/floppy.c:3543 fd_locked_ioctl() error: uninitialized symbol 'outparam'.

vim +/err +4540 drivers/block/floppy.c

b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4520  static int floppy_probe(dev_t dev)
302cfee150291c Christoph Hellwig 2020-10-29  4521  {
302cfee150291c Christoph Hellwig 2020-10-29  4522  	unsigned int drive = (MINOR(dev) & 3) | ((MINOR(dev) & 0x80) >> 5);
302cfee150291c Christoph Hellwig 2020-10-29  4523  	unsigned int type = (MINOR(dev) >> 2) & 0x1f;
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4524  	int err;
302cfee150291c Christoph Hellwig 2020-10-29  4525  
302cfee150291c Christoph Hellwig 2020-10-29  4526  	if (drive >= N_DRIVE || !floppy_available(drive) ||
302cfee150291c Christoph Hellwig 2020-10-29  4527  	    type >= ARRAY_SIZE(floppy_type))
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4528  		return -EINVAL;
302cfee150291c Christoph Hellwig 2020-10-29  4529  
302cfee150291c Christoph Hellwig 2020-10-29  4530  	mutex_lock(&floppy_probe_lock);
302cfee150291c Christoph Hellwig 2020-10-29  4531  	if (!disks[drive][type]) {
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4532  		if (floppy_alloc_disk(drive, type) == 0) {
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4533  			err = add_disk(disks[drive][type]);
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4534  			if (err)
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4535  				blk_cleanup_disk(disks[drive][type]);
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4536  		}

"err" not set on else path.

302cfee150291c Christoph Hellwig 2020-10-29  4537  	}
302cfee150291c Christoph Hellwig 2020-10-29  4538  	mutex_unlock(&floppy_probe_lock);
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14  4539  
b08dbe6faf0fc2 Luis Chamberlain  2021-07-14 @4540  	return err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  4541  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

