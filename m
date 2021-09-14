Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6840AB41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhINJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:58:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhINJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:58:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9cqFd004534;
        Tue, 14 Sep 2021 09:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=D0EcZrclDaTvgrYicxI9v39jtH3zRfAbB0wR4wDT7oE=;
 b=tH5q6Vz+DIgqjTfOwZrTBsbjQRK2Im1ftOfkvyuNLzh/huIQu9V0H2IzQ0HUpTlkjK2H
 L10c50qmQlsyrSe2rq/MPu/dGQzCFyXLP7O4nVF58Tt2JcZqyDP5+GVCRqJjEnzBiKRI
 Vu6AGZpNkLgZAfH+nEiefYIMkhfjfkUHOy6B6H15HoUQhlx2Sa3DsKgbuhah5/DRN0aS
 wmG4DsM2UVfNkwRw3g+C3aBU2hEnQHsIzbeDEYIavgpFQjmxpmyN1vuY9mLg6JFO+Cns
 uK2CPEKNLtIltyKzy11Fu18FHsgkeUuv/RDWI3GvFr6Vb+A+8yljmyyICu5jCfc4qJrk 1w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=D0EcZrclDaTvgrYicxI9v39jtH3zRfAbB0wR4wDT7oE=;
 b=AFvCbuEq2Zv0du6geWzq9SzoCIim7/tIr9V9vVMU68a3AzUHh8LRyaAgOtxRix2vLiLm
 GmsrSDAkwRwyZGVTIaWcsnV5J8eNLSGBJ648B+8r3D32Vn8h2cIgEqKcguglxS/PGbnJ
 bMabbwu8Kx42On3/ViRAcCYw7ESMqvKN/0nJ/9hKjZTvqdbaAtxUznnzjTgdIN0dEDHL
 gvAeNaQl+Q7wvN8n/5RwuO7TvdgKAhtynsU9BKiVe5LVGFl9EnWuQEVnx8VtOr/UCB4n
 x4RJ3AG5BqmhOGoOqQ4DTTIdWZ/sJKfA1Ao9UMYrGhxAhl9NsZ39JtG5ZlEdVoriKpBD QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2j4s9arx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:57:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18E9uV6t010656;
        Tue, 14 Sep 2021 09:57:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 3b0jgcv1fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI8biCEQ55AvuvL3onmYFxDtOP9haG4F243o1vlP6PKTQUp5Ryrv3g6mPuE0usx7uEiGf2DkT7bqEQjL68ElZ8bR3QiiRC+fpCb/slFfYiSEDcqseBvamHiY9NFfrMmfgQzu61u0arJjCY8GJtynVFVZCpcVOdeQQKZkbkNVPaLPqLjbPCC3ea2PBu3Vc/m/Usl7e+eouIiUNuY00aHsP+CtRfzbVjpLx+skZkJ4pqg9xvcefS9dUz5FpspLkIxXYz1CS7xIZgrvPuTz3kHNaT2cmr/e5kez20qjskVkiH6RvySSeP/2kdAOfFAef3nm6pYg7tNZIgAf97u0MMH/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D0EcZrclDaTvgrYicxI9v39jtH3zRfAbB0wR4wDT7oE=;
 b=A3bOmcj9CMbDvpMlyuUQFIRxofIUX+4qkTacqb3IcycWZG1Uq35AfHJDe3JA5bFZ2YowUvQ4P3jahjEYXeGqiJJfjoEHg1chW0wSPECSqJVxYOw7opDHtLxJDrpDq1/No+/6UxROhUe9ne0OiyeEFhxDUtR/LXT++rkImZxn5/3OpcjvKXeDq3eQjydZybGJmo7WxtAC/Yz50XxltWSoUw4NYRwG+RqShTGfr4/NZSFO28pPx/1ai9LtWM59ttUfU47/IfTlh1PRWzfWMI51rT+D4GPXgHCYzvkeZf2Dh7MQNdU7GpdYIgHhGl0n1lAd+QABD/zKLP/AedNsD+pinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0EcZrclDaTvgrYicxI9v39jtH3zRfAbB0wR4wDT7oE=;
 b=tt8CQ3p1frPp0VAPxDJ58OmrUt5H+8KvI5rlAYucgWkUVyrmeyIwRILhNqCJaPILJE3lN+LpHNlI2vjfbVZLZco7SQy5qM9bxSop6zDOPyvltsT2a+xbrKnMtoXUrB+Ck9gJpNttZzjYEoLOallChYf/xoP9Oth1qDiEDdkN5kg=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2398.namprd10.prod.outlook.com
 (2603:10b6:301:2f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 09:57:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 09:57:30 +0000
Date:   Tue, 14 Sep 2021 12:57:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: drivers/mtd/parsers/ofpart_bcm4908.c:41
 bcm4908_partitions_fw_offset() warn: should 'offset << 10' be a 64 bit type?
Message-ID: <202109121458.WnEMVBBo-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 14 Sep 2021 09:57:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a239fde-4548-4e48-6512-08d9776610de
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2398147C631560AA519DF5938EDA9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:54;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpegtrZLxg55TxvBS+pyeTTn4KimVrGKDs/0NXRQicqWjZKexcXjWSqZ6jmQoEoCY3gGoZdNFzUKyCHtQMaSW1T3xapaHYXBFzGR62z5JRbGRMD9dVK7lNhNywj6SC74bjkwG/H2gs70PaJhxZiPh/duTXm36/Zo//KUlTzkDsQ4FKlTslLjge3TRE6yOcSd4PmWtCRRap5vsL0VZ4P1taYuxATUzyH5jLUJJVXI3vjUHC0TSPgL1aSlAur9SquE2V/z/1d/a8qinkYLtzTue7trIALFrS6Iclsi2RKhDVktyHJ0lexYj37YAP1uZP7nmdYmCjapjj8B70dw0azEOsHU8URSkip6Mfxpxwv8dluA+e3bJHFjaIcK7P4ITA3RFJVuQesEKARDpKyhQYxIPcCiBP3uh3YPTnMbJmFX+Z1Y15Wh5M9X3y6f76iSDyD+Lefy5xhMXy9o8jHev5hrbUFqK87JDfreKdwWtFqEW4CHonYo/u4HoiFFOmJCr+EJOL1PxdmCxuY97JWXczI0O/ICGjfzY+1Bf+ccwzRVIzEDAPTqn3rTFBazvWDUePTpU/L3d/gTfvbJ7J9tb5uKhIoteLrpC+v+XV+IS6kvGje6k47oVkgmgApVy+YQPkKauxIM0F751JG2pxgwVfZ61hlm6ngT7l62kKt+0RwgBjf7fSfKHVAHQnilU43OuPNGFqtxP9LVocVjc/Ky7wV/bPfukcMQr5XmDnJiHFBb1cyHIVc0Ak+1O38YOXYp71UE6OZk7Vo4h/ehp02Ak9TeExDbUnMqTBx458NjCGIhjmzFA+BYOgF1I4rPGj3zdUxTh5JDMaYHnQLxGjFwgMaHvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(396003)(346002)(38100700002)(38350700002)(6496006)(6666004)(52116002)(6486002)(5660300002)(36756003)(26005)(6916009)(66476007)(44832011)(8936002)(8676002)(186003)(83380400001)(956004)(316002)(4326008)(478600001)(2906002)(86362001)(66946007)(9686003)(966005)(1076003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXkzdXZURit3T0oraTBURDJQaHpvR1hLNDBBR0NKZnpuVHFYYTk5RHhDS05T?=
 =?utf-8?B?eSt2aWNDMFVjU3hvYTFFMVFVWTByTWJ6eGlqdXc5SEZSMEFZZ1dyT1RnMVVC?=
 =?utf-8?B?MEU5OEljR0padmd2bjZ4MStENGtzWjJURVZqWDhaR1QvdGN6QkRoWWF6YjE4?=
 =?utf-8?B?M1Yxdy81cWd4SElIQ2YvcVZCZEIrcy9tMHdRMmIxYmFQUUxyaG4vYytOa0RV?=
 =?utf-8?B?MVp0RTlYZlJtWXFTcUFtc3FyR0VQTVlQQjJpellWSFJZZGRFVmJPODRHV3c4?=
 =?utf-8?B?dE43MmwvMWhyTVVTUVBDdFhWVmdDTFE1b2JkTW1KVk1UVFhYS0pYL2craEFO?=
 =?utf-8?B?YU0rYUVRbndJV2NrWElNTG13alRjUStlaS8xZWtmclN4aGJmTFdLUUZJT0Fz?=
 =?utf-8?B?eExMMXoranpia3NZV1crUU5LS3dPd0dnNWZOMHlwSHJzR0duUlcvaGZEU2JU?=
 =?utf-8?B?K3NtZDBjREFSbmRrb25jWmdIYWs3a1hPZkQvc2lRRE93YnV1MlovMVN6c3ht?=
 =?utf-8?B?OXV4WU9UUlRVbU9aNHFZcXd2cXZoRHdJcUY5bndrcWdxd29SKzl0dVhaOVBK?=
 =?utf-8?B?VHQ4QXYweWozNHN2bVBhMUtYa3l4NUVEc1hRaDNCS3JWTjVLbXJKWExhaVpZ?=
 =?utf-8?B?b0U3MWVJUnNMOWl6cnphRzZLZ1dlaHY1MUw4Rm5NdmJQVEJkbEtnd3RZY0FK?=
 =?utf-8?B?Ump5NzdXTU9FL3R1Q29OWHN3aExaUkIyY1ZhbGFpdjZFT2V6V0g1ZW1LT25T?=
 =?utf-8?B?U3RGb3dnTEJzTXJFUWdMRWZZejVlN2NvSC8zYm0vZjZHRm1KZFJidVlJbnRN?=
 =?utf-8?B?S3dySW1UYlpjUEl2RGV0NWY2c2JXOUFnYy85YndHVGE5MlhCaHhjRU9uZjJG?=
 =?utf-8?B?OWhMM2ZVeTBKVlNJNW9kNTFPbFQ1UnMwQm0wVWIrbGpjVkY1K0kxYUtLR29B?=
 =?utf-8?B?a1NpWXpJc3BsbWpIL0lSTVFVSXdFbjYzZG1HV2g5VURuV01hcHhhSjVkOG9R?=
 =?utf-8?B?dlEzd0pGWjA4RWtDaEhlSWh1cVFmSCt5ZDczQVYyOU9aMnM3MDJlcmlUOFFU?=
 =?utf-8?B?Nk1mNlVxTEh5Q0htaUxZYUhYdVRFYS9rcTdyc3owY2Z0OWdaQjREOUpoR0Fz?=
 =?utf-8?B?UE9YTEdvaWxVVnNLRHZVcDdpTjA0eXN1ZGpqZGJmZUUzVGtveVBtTXYwUDFI?=
 =?utf-8?B?UG1GSEVjdE5CczVsTEsvM2RYaVptbDZkMUhhUnI0b01INTFXWGdWZUt2Mzhv?=
 =?utf-8?B?MVlwcHNJL3ZvYjhOclZjZFJjTExrWHBhRG9uOXVudmpOUmIzYzN3MFFLRWxx?=
 =?utf-8?B?eE1hdTF3RDc2ZXRCNmFSb1ZuMkpMNzVsSXZpM0FXallQendYS2ZPL0drLzli?=
 =?utf-8?B?WlFoRFpaM0xpWFptbldyL3d0YkljNjI4aDRVbThObkllR05RWjUxclA1R1Vx?=
 =?utf-8?B?aE05ek5TdUxnMENxYy9KQ2FNUjdxVHB5Y2ZGL0NSYnM0TlFBSTNOU2l5WTFh?=
 =?utf-8?B?Rml4OVorMmQ1TWZSdnBROGljZTF0KzVqTXBlV2lFUnZ6Q0Z2N0hPaFljVVBm?=
 =?utf-8?B?R2pWNTRLY2tXcGdZNlV5WjUrK3ZNa3dQNXpOSUdldG92WmQvbU1tQVQzanp4?=
 =?utf-8?B?YTBvUGV4REsxNUJ2SmU2a3RCRGJmdDVaZ3M0ZWdDNVp0R2Nwei91bVRCK090?=
 =?utf-8?B?czlPNjkrYXljaWdPTWVmSFZ3Y2YxS0FaVDBnRk9mMHU3N1hZeExGTUhBZ1NX?=
 =?utf-8?Q?qRDyhAHvFBceiFrQ4EyZUcYgYydukPnHdNfzwuc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a239fde-4548-4e48-6512-08d9776610de
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 09:57:30.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfVPx+3+2Mp5st4Sibd4U3VH+zxx4fs9qsWmSr/ERjmAJ++6liSmY0M6so5Wlhhp49ROAOyNUe3juk1hC6PBK2lWeIyvnUVo5YSDqSFSwSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140060
X-Proofpoint-ORIG-GUID: 7cMfTaS4RU8jz5Oy-nGsRAvuXU_vPo3r
X-Proofpoint-GUID: 7cMfTaS4RU8jz5Oy-nGsRAvuXU_vPo3r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   78e709522d2c012cb0daad2e668506637bffb7c2
commit: bb17230c61a6424b622e92006ec52ba23aa5a967 mtd: parsers: ofpart: support BCM4908 fixed partitions
config: parisc-randconfig-m031-20210912 (attached as .config)
compiler: hppa-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/mtd/parsers/ofpart_bcm4908.c:41 bcm4908_partitions_fw_offset() warn: should 'offset << 10' be a 64 bit type?

vim +41 drivers/mtd/parsers/ofpart_bcm4908.c

bb17230c61a6424b Rafał Miłecki 2021-03-01  17  static long long bcm4908_partitions_fw_offset(void)
bb17230c61a6424b Rafał Miłecki 2021-03-01  18  {
bb17230c61a6424b Rafał Miłecki 2021-03-01  19  	struct device_node *root;
bb17230c61a6424b Rafał Miłecki 2021-03-01  20  	struct property *prop;
bb17230c61a6424b Rafał Miłecki 2021-03-01  21  	const char *s;
bb17230c61a6424b Rafał Miłecki 2021-03-01  22  
bb17230c61a6424b Rafał Miłecki 2021-03-01  23  	root = of_find_node_by_path("/");
bb17230c61a6424b Rafał Miłecki 2021-03-01  24  	if (!root)
bb17230c61a6424b Rafał Miłecki 2021-03-01  25  		return -ENOENT;
bb17230c61a6424b Rafał Miłecki 2021-03-01  26  
bb17230c61a6424b Rafał Miłecki 2021-03-01  27  	of_property_for_each_string(root, "brcm_blparms", prop, s) {
bb17230c61a6424b Rafał Miłecki 2021-03-01  28  		size_t len = strlen(BLPARAMS_FW_OFFSET);
bb17230c61a6424b Rafał Miłecki 2021-03-01  29  		unsigned long offset;
bb17230c61a6424b Rafał Miłecki 2021-03-01  30  		int err;
bb17230c61a6424b Rafał Miłecki 2021-03-01  31  
bb17230c61a6424b Rafał Miłecki 2021-03-01  32  		if (strncmp(s, BLPARAMS_FW_OFFSET, len) || s[len] != '=')
bb17230c61a6424b Rafał Miłecki 2021-03-01  33  			continue;
bb17230c61a6424b Rafał Miłecki 2021-03-01  34  
bb17230c61a6424b Rafał Miłecki 2021-03-01  35  		err = kstrtoul(s + len + 1, 0, &offset);
bb17230c61a6424b Rafał Miłecki 2021-03-01  36  		if (err) {
bb17230c61a6424b Rafał Miłecki 2021-03-01  37  			pr_err("failed to parse %s\n", s + len + 1);
bb17230c61a6424b Rafał Miłecki 2021-03-01  38  			return err;
bb17230c61a6424b Rafał Miłecki 2021-03-01  39  		}
bb17230c61a6424b Rafał Miłecki 2021-03-01  40  
bb17230c61a6424b Rafał Miłecki 2021-03-01 @41  		return offset << 10;

There is a kind of mismatch between offset which is unsigned long and
bcm4908_partitions_fw_offset() which returns u64.

bb17230c61a6424b Rafał Miłecki 2021-03-01  42  	}
bb17230c61a6424b Rafał Miłecki 2021-03-01  43  
bb17230c61a6424b Rafał Miłecki 2021-03-01  44  	return -ENOENT;
bb17230c61a6424b Rafał Miłecki 2021-03-01  45  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

