Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9136C4442F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhKCODY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:03:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231748AbhKCODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:03:22 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3DxOLJ016608;
        Wed, 3 Nov 2021 14:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=pKArqvMwg3CeZmmEqZmpn/5vsVmdh3T7JaqXtAXWskU=;
 b=P7DE52kSkal4pgA0Xr87Tx5bHlOJ1hhRJ7kaTMnKumcZxUUOsHdotnkMATmRLHCmJh48
 mLaTdg77XyaOi80pWpJ+b0qYSF3SL5q0SJmsZugkkh4WWv0eLEcFuFc6ziYFopCjBMCf
 yZ/UphNJmqSR7dNHlvvN8HNUOYySCdMVnsOO7jBt04OwB/Jvm9MWHJWK4ZeyCStX4yTF
 /zqR2TsqJjRE1befISYWVuA/U5mK/Lx4pJRUuhKXM2wvXC0qT4q3QUoQx72NExvSvn5E
 +laeDSU9VwXqO1a3df1cHHJPf3Gw9DLx47Mu4V0NuAVjFfArYjJK1sg38PMDzlEMH5Nd eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3mxh24np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 14:00:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3DfepN172151;
        Wed, 3 Nov 2021 14:00:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3030.oracle.com with ESMTP id 3c3pfxnpae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 14:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcD6qBWJ3fon5L5GGUsYZRwExehE4ffBRWBvDBlMCp6JJfq7Ojj3NOUIGSO7CpBfn7MVt9bjlFSmfn3xom7dRpZiqZN2jxKiJXQWi6Ei6kBjZTcNBKCLV81PYmuD9CTZuHDJj5BLSIOb0TBJtiaRlqYPt9PpSOTnsHv4wJ2U+MArU/+AKe5abNRva0UalhZ7hCxm1or87MBiXEh9nWNNZ7M/uiJ8eLgdrr82e+CheEbGi7sck7PYY4AkcouZiLDo2nu0mJ9Uq2dEk+Q0kMF9HnCmsKOUg1e8KB95bhSB/OxEci2AMFA9dl1Hvadh+Q+S8YN3g9eYZNkmIdUXgT27OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKArqvMwg3CeZmmEqZmpn/5vsVmdh3T7JaqXtAXWskU=;
 b=XN2BIZ/w+SB6jPio3I4poZlqAHDsDY2JFO+2O6Jib+Ax0dxGGDWs2/2M3wV5xfRcV/LZ59v5RpznXqXrWiRCFN7PKV9oHz6HfLb23FnWyc2V+YmqsTb0CsZQE9iwhHOpXNlte3RD22kXV/wxxVntbBkCf07N87RNi284ZaYdlndvS56h5mMiJtJLSHNnyyLfDtVQWAwohe97dmA1kzLFS1Axlun3UJ+wXKDP0rylh4abx1qcLD1GNzlu7HqJXx3BmKI57uVN3yQ1EdyPTE7PZGRNxWYuetr38kdEnoDP+lZdN+ceAWEu7MHcjxi9wpA5XEhnKna7WxyNRSkjCt3b4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKArqvMwg3CeZmmEqZmpn/5vsVmdh3T7JaqXtAXWskU=;
 b=eT3zc3ZoZfx/GK1eNmnk0yvfsup7jrJkC0/pBG0FbuDMrOerXE+SqMNjdGLwVovfwZkNs1J8riTmOTQrXRM9uoaji7pblSQclsj/CaxHpiPKeVS5XjWgwIGX75lEXFZTohULEZspPk/w4UZZwZXojViggaPH9AXPt+vbAf9KPX8=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1317.namprd10.prod.outlook.com
 (2603:10b6:903:28::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Wed, 3 Nov
 2021 14:00:31 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 14:00:30 +0000
Date:   Wed, 3 Nov 2021 17:00:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luis Chamberlain <mcgrof@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20211011-for-axboe-add-disk-error-handling 24/24]
 block/genhd.c:480 device_add_disk() warn: missing error code 'ret'
Message-ID: <202110270056.HnCzP5qD-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 3 Nov 2021 14:00:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e6ad3b1-beca-4366-bc93-08d99ed24bff
X-MS-TrafficTypeDiagnostic: CY4PR10MB1317:
X-Microsoft-Antispam-PRVS: <CY4PR10MB1317FF575B1CADE613811CD08E8C9@CY4PR10MB1317.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfC0C/UmhuCRv3rH0xXZaeu5U5moERvlPR/agFSfK/9fD+gAHx8vJ4p3rkDDZwHVb5HhyEFAxMm0kG+Hjih7WIs9u7MZmQTD9lqJwbDl6Unjv04VLP/77ZM4QU9wpTK4bd9Gj7mlQ5+0xDrojuqGdT2ypQfnbiYcGQZ8enUaTeuGKSdXBoSs8VIL/biBmukrWHRdUsvmvA0RxJUV42UeafTNILX9JAUksdhkvy5E0wuIEzzhFhRAGsISqsF/9i3+06usaLbV39MZ1SPHJhealkWyXsdBITr9o2rGBJsOOQttRxSrZH/2CSfG3kRFMTVxb4mZKW5FQjgXdWaQHrUICOr/dVxo7+rkgQ+OXv3LT4Q2G8d61BO9U34zLzlvO1h3OVqjLdgsNF3hl/dxiLVoOR7dgcJfAoSFHgUS4/zqSCNQBdIlpRPYK1TajRzb1iKvIWb/v+SYB0Anaw9X02avDYgLmn8GUV5jiaOIYItWhoLK3TFyLMc9Zs00uQje/8gfou0DBfuACvjj0zNttqXNW2anGIuW2Pgb4hKlYFp82m96KqQuQ1OEuT/SKlrr/2TWRF7JeQtz2g6Gwj/a3oHhS0ZbuyKzHj0Ks2khfgZG8McOyfmlZlK03mzvrcpRlR+3JSMKvqtjAT3eIqnoxlc9/+2yj74gCX1FsHq1EgH+SjoHzqrwrKjl35z9JedKtx3hdkxw6IgDkS+nqEJpYQ88wsQZwThIij9Lt4Tftv/PG/jwiqbmd0o6u8P6buKYa9nuF88E9jCt57Ko9oDmuosACl9YGSZeEMCXcuyU7Jt7ayLommavUefXS+fAM4qHIYm5hnKYznz7flaWxdJKVmTU1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6486002)(316002)(1076003)(83380400001)(6496006)(508600001)(38100700002)(38350700002)(30864003)(956004)(52116002)(36756003)(44832011)(2906002)(6666004)(8676002)(86362001)(6916009)(9686003)(186003)(4326008)(66946007)(66476007)(66556008)(26005)(8936002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vPmgmcGSA2RvoAUQinJFHxP7XAml5wRfk6NThuO7cJFgw0KEh8uvOl8TmB6z?=
 =?us-ascii?Q?NSGWEpip+5MzFMlh5ALuBJE1HfA+umd0qBxbOD429N4Wm3i1KVpEqL7blivD?=
 =?us-ascii?Q?zKADNrLPwjV3marDCZFux5IZK3ZJMiakxzP6wlqmTEYaO+1c4kVUGc3EUwp/?=
 =?us-ascii?Q?zPqBBCUwEy2/cxxsAGKg+qlUTUTPfPksP5iL5a4RT5LxjV06kCTyYWY3GMlu?=
 =?us-ascii?Q?ArT3UdQ3O6C1oJzNsGmyjfTZDUiBdBIat0vkxJMmX1id1YP+ymVM2QrsSFV1?=
 =?us-ascii?Q?D0jpxtD3GkdT4GlBvDwayNTKf5HqXMELKYbVoDcZAqCi9fFzphRwo9X9O7vz?=
 =?us-ascii?Q?cwB/hXKl3ssj7I9Q9jiu+httIIpvahNZUTgfoodHkPXM6xJQ7OqQ82R3+W0H?=
 =?us-ascii?Q?CCwnsv6hKx6eFhd6rwr3xNGqNCxQx/ocWlqVCM7qlskBLHZmFafEYAnkM8d8?=
 =?us-ascii?Q?hP9AkDAm3xbeE4k0gQqWp6UEYwZVkYYypO+6H65r2+2egid3ABOaCP+dSQMm?=
 =?us-ascii?Q?LmhW+mro2+gGnvvPSR+MQpneS0J+n6On8YsGfd8IqCAyXhM5TCnUoAe99IH1?=
 =?us-ascii?Q?Jv1ZkmCjhKmmIXmwKfCQNk6SArJ0+1267b1beGxu1BYKistmurBlk/r7zdwA?=
 =?us-ascii?Q?zmmHKWW1JVnfjYvMLNmp9tQNtb1dVt13rIArtikU+KU7GZWkBdsauFolrXmw?=
 =?us-ascii?Q?7yiuDKsZxJFhopl/ZH3an7Slyl84MihXlnR8Zzo3ji6X7aj90h+OOIrsUbta?=
 =?us-ascii?Q?XSdj0t0Nudxm75H3ZIOm8iKwZ5K9EaHF6W7U5T83SnutC/Uw5XQQ9iMD31/L?=
 =?us-ascii?Q?FPBsCujfgDgbI8tK404/uglX54+WGzdsZtPkDAWQYF4N5a8dKDrOKJcnatsY?=
 =?us-ascii?Q?Jb0DHkZ/UutC/v23twuM3EnUgnK4GKL1l/l7fG/Kan/ndSjOF1ZKc0r5LFO3?=
 =?us-ascii?Q?+KBKny42iuuHrvEiIDrY3d1/jKstiBTIRN+XaDjOJwI4z8qC2OwD6cVclBjo?=
 =?us-ascii?Q?2iqoKLACIaq0ilulR5a+MAaEdqvJbQkYEaXY1oguZvVL99cD7R5sJBzSoxF+?=
 =?us-ascii?Q?7j5y1cxVQRS+7drgCtdSliSjoy//FxpRitbJMhxMh/gg30enaTy+uDejGMLs?=
 =?us-ascii?Q?HquMwnrQpQL9MhpbgBFETCeYYgE5f0ebh+rOGAf3GMRRbga0ktVnsiS8XDbP?=
 =?us-ascii?Q?1Koo9mf7xgjODIcy21XL41Pac9tQu7G4/bNKVL0p39IL6E6cU62a/nNpgIRJ?=
 =?us-ascii?Q?PT+QH/9ZKD4MivJx/WyUFZrLzHP/H6HhUgIZfJJClfIlbHP0jP3umSA+Py+V?=
 =?us-ascii?Q?q2l45qw4OMkb414U41X6qRj6CImo7eW8fY37kc21rGwrjvF31vs0X8dz9CrW?=
 =?us-ascii?Q?br5RvdWqktxS19VZpxhtkomtuX/SgJtB4WuTL61oLVu0UjHksrFSry4AvIfW?=
 =?us-ascii?Q?6pxzw7QOwEVM5GwBc87RpMFEJ2Ga06+IBKshhkuIHA/oels185mks9dGwMNj?=
 =?us-ascii?Q?KFhb+VjLXcdcGIf4sugE48zCgC7a4isZ/muJ/lHewUZ4/KocIWrysiDlfanz?=
 =?us-ascii?Q?no6xTVrZgsbBjir5rgFbIMYmzBj3b5JDMY25t/4WPun/IfJAcXGNEy+6N0pi?=
 =?us-ascii?Q?2SiXf73TRpZBiG2/RbRJJJ9Kr+iTzilcAZ/nOE73h0HOWBasvu0aoesN678q?=
 =?us-ascii?Q?1LShJA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6ad3b1-beca-4366-bc93-08d99ed24bff
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 14:00:30.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IexqyNaUVxNIlv/EW0DiU4hww8irgRh59sR9B2cftsO0lB6S3wcZ/Us1HmVGbhL8hHA9sQpAfH8E76i4pDS4blMCt/sHIq5YN5x7y38fJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1317
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030079
X-Proofpoint-ORIG-GUID: tevcfhmm4cKWnlH_CM0Tuxkb4PHuAlHQ
X-Proofpoint-GUID: tevcfhmm4cKWnlH_CM0Tuxkb4PHuAlHQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211011-for-axboe-add-disk-error-handling
head:   53099761729ca16d3bb36db8a8cc526f4eb08f28
commit: 53099761729ca16d3bb36db8a8cc526f4eb08f28 [24/24] block: add __must_check for *add_disk*() callers
config: i386-randconfig-m021-20211019 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
block/genhd.c:480 device_add_disk() warn: missing error code 'ret'

vim +/ret +480 block/genhd.c

53099761729ca1 block/genhd.c         Luis Chamberlain  2021-07-15  398  int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
d1254a8749711e block/genhd.c         Christoph Hellwig 2021-08-04  399  				 const struct attribute_group **groups)
d1254a8749711e block/genhd.c         Christoph Hellwig 2021-08-04  400  
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16  401  {
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  402  	struct device *ddev = disk_to_dev(disk);
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  403  	int ret;
cf0ca9fe5dd9e3 block/genhd.c         Peter Zijlstra    2008-04-30  404  
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  405  	/*
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  406  	 * The disk queue should now be all set with enough information about
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  407  	 * the device for the elevator code to pick an adequate default
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  408  	 * elevator if one is needed, that is, for devices requesting queue
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  409  	 * registration.
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  410  	 */
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  411  	elevator_init_mq(disk->queue);
737eb78e82d52d block/genhd.c         Damien Le Moal    2019-09-05  412  
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  413  	/*
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  414  	 * If the driver provides an explicit major number it also must provide
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  415  	 * the number of minors numbers supported, and those will be used to
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  416  	 * setup the gendisk.
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  417  	 * Otherwise just allocate the device numbers for both the whole device
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  418  	 * and all partitions from the extended dev_t space.
3e1a7ff8a0a7b9 block/genhd.c         Tejun Heo         2008-08-25  419  	 */
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  420  	if (disk->major) {
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  421  		if (WARN_ON(!disk->minors))
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  422  			return -EINVAL;
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  423  
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  424  		if (disk->minors > DISK_MAX_PARTS) {
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  425  			pr_err("block: can't allocate more than %d partitions\n",
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  426  				DISK_MAX_PARTS);
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  427  			disk->minors = DISK_MAX_PARTS;
2e3c73fa0c419f block/genhd.c         Christoph Hellwig 2021-05-21  428  		}
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  429  	} else {
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  430  		if (WARN_ON(disk->minors))
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  431  			return -EINVAL;
3e1a7ff8a0a7b9 block/genhd.c         Tejun Heo         2008-08-25  432  
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  433  		ret = blk_alloc_ext_minor();
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  434  		if (ret < 0)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  435  			return ret;
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  436  		disk->major = BLOCK_EXT_MAJOR;
539711d7d6fe38 block/genhd.c         Christoph Hellwig 2021-08-24  437  		disk->first_minor = ret;
0d1feb72ffd857 block/genhd.c         Christoph Hellwig 2021-05-21  438  		disk->flags |= GENHD_FL_EXT_DEVT;
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  439  	}
7c3f828b522b07 block/genhd.c         Christoph Hellwig 2021-05-21  440  
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  441  	ret = disk_alloc_events(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  442  	if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  443  		goto out_free_ext_minor;
9f53d2fe815b40 block/genhd.c         Stanislaw Gruszka 2012-03-02  444  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  445  	/* delay uevents, until we scanned partition table */
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  446  	dev_set_uevent_suppress(ddev, 1);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  447  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  448  	ddev->parent = parent;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  449  	ddev->groups = groups;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  450  	dev_set_name(ddev, "%s", disk->disk_name);
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  451  	if (!(disk->flags & GENHD_FL_HIDDEN))
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  452  		ddev->devt = MKDEV(disk->major, disk->first_minor);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  453  	ret = device_add(ddev);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  454  	if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  455  		goto out_disk_release_events;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  456  	if (!sysfs_deprecated) {
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  457  		ret = sysfs_create_link(block_depr, &ddev->kobj,
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  458  					kobject_name(&ddev->kobj));
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  459  		if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  460  			goto out_device_del;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  461  	}
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  462  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  463  	/*
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  464  	 * avoid probable deadlock caused by allocating memory with
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  465  	 * GFP_KERNEL in runtime_resume callback of its all ancestor
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  466  	 * devices
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  467  	 */
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  468  	pm_runtime_set_memalloc_noio(ddev, true);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  469  
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  470  	ret = blk_integrity_add(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  471  	if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  472  		goto out_del_block_link;
bab53f6b617d9f block/genhd.c         Christoph Hellwig 2021-08-18  473  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  474  	disk->part0->bd_holder_dir =
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  475  		kobject_create_and_add("holders", &ddev->kobj);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  476  	if (!disk->part0->bd_holder_dir)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  477  		goto out_del_integrity;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  478  	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  479  	if (!disk->slave_dir)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18 @480  		goto out_put_holder_dir;
                                                                                        ^^^^^^^^^^^^^^^^^^^^^^^^
This needs a "ret = -ENOMEM;"

52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  481  
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  482  	ret = bd_register_pending_holders(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  483  	if (ret < 0)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  484  		goto out_put_slave_dir;
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  485  
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  486  	ret = blk_register_queue(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  487  	if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  488  		goto out_put_slave_dir;
75f4dca59694df block/genhd.c         Christoph Hellwig 2021-08-18  489  
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  490  	if (disk->flags & GENHD_FL_HIDDEN) {
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  491  		/*
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  492  		 * Don't let hidden disks show up in /proc/partitions,
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  493  		 * and don't bother scanning for partitions either.
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  494  		 */
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  495  		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  496  		disk->flags |= GENHD_FL_NO_PART_SCAN;
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  497  	} else {
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  498  		ret = bdi_register(disk->bdi, "%u:%u",
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  499  				   disk->major, disk->first_minor);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  500  		if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  501  			goto out_unregister_queue;
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  502  		bdi_set_owner(disk->bdi, ddev);
9d5ee6767c8576 block/genhd.c         Christoph Hellwig 2021-08-18  503  		ret = sysfs_create_link(&ddev->kobj,
9d5ee6767c8576 block/genhd.c         Christoph Hellwig 2021-08-18  504  					&disk->bdi->dev->kobj, "bdi");
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  505  		if (ret)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  506  			goto out_unregister_bdi;
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  507  
9d5ee6767c8576 block/genhd.c         Christoph Hellwig 2021-08-18  508  		bdev_add(disk->part0, ddev->devt);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  509  		disk_scan_partitions(disk);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  510  
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  511  		/*
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  512  		 * Announce the disk and partitions after all partitions are
8235b5c1e8c1c0 block/genhd.c         Christoph Hellwig 2021-08-18  513  		 * created. (for hidden disks uevents remain suppressed forever)
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  514  		 */
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  515  		dev_set_uevent_suppress(ddev, 0);
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  516  		disk_uevent(disk, KOBJ_ADD);
8ddcd653257c18 block/genhd.c         Christoph Hellwig 2017-11-02  517  	}
52b85909f85d06 block/genhd.c         Christoph Hellwig 2021-08-18  518  
75f4dca59694df block/genhd.c         Christoph Hellwig 2021-08-18  519  	disk_update_readahead(disk);
77ea887e433ad8 block/genhd.c         Tejun Heo         2010-12-08  520  	disk_add_events(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  521  	return 0;
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  522  
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  523  out_unregister_bdi:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  524  	if (!(disk->flags & GENHD_FL_HIDDEN))
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  525  		bdi_unregister(disk->bdi);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  526  out_unregister_queue:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  527  	blk_unregister_queue(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  528  out_put_slave_dir:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  529  	kobject_put(disk->slave_dir);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  530  out_put_holder_dir:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  531  	kobject_put(disk->part0->bd_holder_dir);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  532  out_del_integrity:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  533  	blk_integrity_del(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  534  out_del_block_link:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  535  	if (!sysfs_deprecated)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  536  		sysfs_remove_link(block_depr, dev_name(ddev));
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  537  out_device_del:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  538  	device_del(ddev);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  539  out_disk_release_events:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  540  	disk_release_events(disk);
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  541  out_free_ext_minor:
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  542  	if (disk->major == BLOCK_EXT_MAJOR)
83cbce9574462c block/genhd.c         Luis Chamberlain  2021-08-18  543  		blk_free_ext_minor(disk->first_minor);
53099761729ca1 block/genhd.c         Luis Chamberlain  2021-07-15  544  	return ret;
^1da177e4c3f41 drivers/block/genhd.c Linus Torvalds    2005-04-16  545  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

