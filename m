Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFEF3BF9F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGHMWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:22:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45696 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhGHMWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:22:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168CCtQ2024741;
        Thu, 8 Jul 2021 12:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=jHMvvi12MAomj+adOxtm2J59H7G1P1oOd2SOYfaiilc=;
 b=qT3K/RXDADzwCMNl8gKhJagziqEjbSJB9yw3oe6Tz9xTPSOHPfszjCcCV8YSJ8Rqq/me
 r0XN3OD5p4/92y12SdEEqte+nk5e7ljvF6q4PlTlGU9BLmk/BIVtGBJHfk3kQGVKoNn7
 Jm9ztbWpXNUErdKmCShTl3qSX21myLStckpq2qN9qHwkVvB6yDctfZHvfzxV2dSTN+SP
 9LUbBl0YOPtb35Bx6laoEzY5jWJpKSUVVJGumubLgjJX0xB3a0AqSnueIsOBuwwAbpsu
 q4vVOdZXU0K/CAuExB9UP2GrvfkqrLSj78zAl497azSGdP9OHS4WFyjuC7HjWhIMf/Ms fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nphgh1y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 12:19:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 168CGCQX168717;
        Thu, 8 Jul 2021 12:19:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 39jd15gkjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 12:19:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkBVB40P+/S2bMt8m2xMACDgoZsIf56UOrcAAworAfrDURHjnx8Y/DhEGmwo0+QRM6gkpKjDYsZ6/mKprKgMsYTsAnHZsSOV12//w6GZ1mFA9co5enivhZWvc9FXeMaYlyrONqJGh80lHz7AUuTHmapS0mtameiY6Mpq3pmx05ExuaCUQnFnX8D+uK6dxCgHvpazx391o0igJWmrdJ4BG3WOwemF3+K2I5U5C3/BPZasUb2ZET7asG24+Ber/Wbw+sTLq4O1lFKGh+JeRK3ckGQvWsx/80+1oO4RFkgGLvdFNUC/h8ir+Fzy9A+K9xm7h12QtjnGNNI+qtIbPDLGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHMvvi12MAomj+adOxtm2J59H7G1P1oOd2SOYfaiilc=;
 b=B4r1Nv9FOzl50s/YEP55r1gaa8if006sBj0pUJFr6j9MeBgHRad/2hd+qXMvLVP4PiRgwiL/17K0DyoEVQCYBftelDrERGrSjcza9/2WV2+dqmjZ9AYCby8KG8z3dZvCGkjTX2skHOaNR/NjUFCya311st8Pcu3rMhS7bqF13lOABUFeR/fRPzQaTEJJRhRCecZxQZY8ouAc6Vh0mjZJ7hdbhXLTqLGtcFpHXFaXKOIvCrJLDLpx8VVdamAq6qFXkWe1bM0UV5fu+g/xfq1mWK5W2P5B7NWMHsoualKAFDRVuDtnZxb/azJ5I7dcV+bMYCpO/pgJFdMEr2u+b04GdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHMvvi12MAomj+adOxtm2J59H7G1P1oOd2SOYfaiilc=;
 b=Hu3ZQDco9k4W/GrVyNnVBSpnnW6nAaMkyHf2Txh60Dy6vfOxp5wXIpAqPxRx0lASKf6Ls2JKO4qpSHLtIWPP3FQ4yFGW6IaWNHFYDn1ndgFdeWvIg5K9p0edbWE1Byse8rHx7sw9R71vOhajwT2645+WLZnoEkG23JurwWQHPoM=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4708.namprd10.prod.outlook.com
 (2603:10b6:303:90::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 12:19:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Thu, 8 Jul 2021
 12:19:45 +0000
Date:   Thu, 8 Jul 2021 15:18:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Anup Patel <anup.patel@wdc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_aia_v1 16/18] drivers/irqchip/irq-riscv-imsic.c:851
 imsic_init() warn: possible memory leak of 'priv'
Message-ID: <202107081051.Rool3tJA-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Thu, 8 Jul 2021 12:19:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ebee514-3fa4-4e33-1e2f-08d9420aa452
X-MS-TrafficTypeDiagnostic: CO1PR10MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4708C6FEDB3495AA34E2602B8E199@CO1PR10MB4708.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:29;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 421dWO28py3sROk0GChBFnOetAixnbxcYMf0LgSmIPyNWMhVocnDi7yXnI9oF/a9ebuxSqWVSDFTZc8W7Buayn9x2U7NCxRbldbhLlekgytyOt5PIHVAhYUbDffj6IfkaDdh4PG1mhL1oTr4KsBSZyB/ctltokY0RJ60Zsi+JV/Ur5MXkH4n3PM5NV97f9+z0QlRiSeheE1+fCfppTKDw9UvTWFYQtKbEuIgiaV0jHbRlO5gyKu4ts1yHmcai3wTPwwWK0xNMFeLY+ee3lPUrtCG88enVq0qc7m9k+U1EjAeQTmxcnntofdN9EVapsJrXd2LMVk92zTWnrwGw/VtIbxW2QIu2uC/UhIpGmxTu/CgiyjgFV6QQuFis3znt7F2HKXb0rLG6V/YXiMhuNtJE046B+YwF6YiRuK4qVcwUINRhm/0FKl3kjRzvf4B+xnErrOqFcBd1EwNkFVVwttBaP36RGOb7VJfWjWFbBGaorbTbKSKPqr3vRPrCmmm6ADbySzH7gIl4TJuCafd5PiDtuSAxzj1vhVPMt/3xDoiqY5SI2Tc74RIoh6C65qflxstamDQJDp0JWN6tB7rALF0wKE5rTvOHLTeIpZpfJs4GIqoP6JImkgdMWdTvrSEpKMSILPZqdb7a03AoHYBTxSXStCmY0EQ+0FIq7qSkPjvc9vRsrD4Mwx32NNiVKCsZGJP8sgsBIfq9SfpH2L3su5cDh0mj3K9rZWvufhZhElcryyWIEk4QZ1+PdnP/BduIDPVHR7fHrh6S4ZeI6SPD4u73N8HjrQN0fzcdmQMPc8V4puzpGkkOxahFh82IrBaZb4f6aAJsSl34PDfCzXBBctGEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(136003)(346002)(8936002)(66476007)(66556008)(5660300002)(6666004)(86362001)(186003)(26005)(316002)(6486002)(956004)(6916009)(4326008)(44832011)(478600001)(966005)(8676002)(6496006)(1076003)(2906002)(30864003)(52116002)(83380400001)(9686003)(36756003)(38100700002)(66946007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tyOjfouHs3fS4H2tXDHgg6cbcsbcC0wd+eyAXVmkMi16grA3z3GXOBSlYhKC?=
 =?us-ascii?Q?yUu278cerEwtWLIzZqR3N12BApO5l2ksW5im/mUStZeZaKK/Q1lIF6tGWBcT?=
 =?us-ascii?Q?/EihxduafbM4N6wz0fg97u6v78SvELunwYdA+rWypih1Tw6eq1trZzyo2DK+?=
 =?us-ascii?Q?JUsdCrWOCpl+AJJSTVdjtcmY+B20bW1PQpnOI8GDevTNvaYKaPExSDSJ7HB6?=
 =?us-ascii?Q?ZHlh6zWY+R8ulJruXoBym+zYd3j4mHdMQejrcQ3G+r7aK6vUIbln7nzcrAnn?=
 =?us-ascii?Q?CkUuluWXwXAw9wMs+I0EKF/xIIoZjViV9M5fjnyS3maINCT5Xq5AvcqBsivO?=
 =?us-ascii?Q?J+KgKqnMTvekuoO8AW+4nWVwUOQ+lGeK9V/n38uBb1DG9t1dwfEPHtl3o0Gh?=
 =?us-ascii?Q?2vN1EvuVh0wLIsvpb/CDTDDpQ1Faplu6kqWs9yUXA+82yXG72CusfiHeY4jM?=
 =?us-ascii?Q?VEozafHaO2+H6uVMRqnarvb2nP9HZLRTuuXnV9Rlc9xx0pDRq7dKQomXZ/Oq?=
 =?us-ascii?Q?jBS1gcqayX3XLEO+2skNV1uXz8JwP2RXbhUNvdz5PD32j3r+TS+59fnc2N6m?=
 =?us-ascii?Q?kDZ0bGUrmOQ16pn5mPztBMWAg8PfoeYhjZM5O87UsIcrVM3mbIHk79B/Usgf?=
 =?us-ascii?Q?a2JKHCivYy+Ok36BqH4XIQxaiFBUMMYlypF4CRS/97Sd4oDmCLUL5+dYLczP?=
 =?us-ascii?Q?se3wbACTvjM9xOv4zNuJnJrzamaEZ1EH1iWUTEYMO9p34dxD36VPBFUYLnPy?=
 =?us-ascii?Q?X6uBVju2sRAuNBVG5eAJUDNbEn0QOZSR3IcqZXbqMIj5l91QoFcYuJ85jCS/?=
 =?us-ascii?Q?BqMXCDT9aq8Me0NzYhsZcRGBw1MTLsYKhYDSBkFlMz1wx0+dVv1H4jPt9HjO?=
 =?us-ascii?Q?z619Y2OX425n3M4HgAfIQunoo3BGsmuB+adfWNimDSEPfqBv7UnLAcO5widE?=
 =?us-ascii?Q?KcyHX/nWZd1cysevk8ovBayOxtz2D8ssY0iGtLUZyhwV/gg+VjWsGe4CMFFm?=
 =?us-ascii?Q?lFgldIZllLTk60gBQDz6F/mlsgf/vjoVf08LEZDHgKQ+ZWZlBjeS2NJDHixl?=
 =?us-ascii?Q?6d06VwWmeUeHj4W14RSrjbDZb7u4SFEJd11wGqCTt/+UmridNVzKMpIQY96D?=
 =?us-ascii?Q?+OHsYpiFxIbpf4ivuEokC0ZMFwryfsoBMOmdIdveNGIm7qNjqGji4cxJXojh?=
 =?us-ascii?Q?mq0efI0W/gb+8UJ+G4vPw15k1h5QD43eekYaTXUJNJhwfiTuZ39pitRBlf6X?=
 =?us-ascii?Q?LMIYYeBaMGvpGzTKg5YAxdBfsVWfAvoBxtK0o2Qi4oNJcTluLHHb4t8YHXG1?=
 =?us-ascii?Q?8nLd3YCwsC5x71ktyfan9qZp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebee514-3fa4-4e33-1e2f-08d9420aa452
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 12:19:45.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maTzWadeyCS94Ox+d7J3oVqKQLeJxKx5OMDW3luTq3as0e16fWHNrEGethi+RfDFL+w032WcsMntgeWL+2fQUMSXB+jwa9LHK+pzqPb35TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4708
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10038 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080069
X-Proofpoint-GUID: JdJaHlrRMpxeb68lT6IDiHpzKf2x-ml3
X-Proofpoint-ORIG-GUID: JdJaHlrRMpxeb68lT6IDiHpzKf2x-ml3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_aia_v1
head:   e4b6f153340e5471c82603f7b08226ba6e2c6249
commit: d180bb1147b8790d605daf66388a2a827806b2ed [16/18] irqchip: Add RISC-V incoming MSI controller driver
config: riscv-randconfig-m031-20210707 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/irqchip/irq-riscv-imsic.c:851 imsic_init() warn: possible memory leak of 'priv'

vim +/priv +851 drivers/irqchip/irq-riscv-imsic.c

d180bb1147b879 Anup Patel 2021-04-26   827  static int __init imsic_init(struct device_node *node,
d180bb1147b879 Anup Patel 2021-04-26   828  			     struct device_node *parent)
d180bb1147b879 Anup Patel 2021-04-26   829  {
d180bb1147b879 Anup Patel 2021-04-26   830  	struct resource res;
d180bb1147b879 Anup Patel 2021-04-26   831  	phys_addr_t base_addr;
d180bb1147b879 Anup Patel 2021-04-26   832  	int rc, nr_parent_irqs;
d180bb1147b879 Anup Patel 2021-04-26   833  	struct imsic_mmio *mmio;
d180bb1147b879 Anup Patel 2021-04-26   834  	struct imsic_priv *priv;
d180bb1147b879 Anup Patel 2021-04-26   835  	struct imsic_handler *handler;
d180bb1147b879 Anup Patel 2021-04-26   836  	u32 i, tmp, nr_handlers = 0;
d180bb1147b879 Anup Patel 2021-04-26   837  
d180bb1147b879 Anup Patel 2021-04-26   838  	if (imsic_init_done) {
d180bb1147b879 Anup Patel 2021-04-26   839  		pr_err("%pOFP: already initialized hence ignoring\n", node);
d180bb1147b879 Anup Patel 2021-04-26   840  		return -ENODEV;
d180bb1147b879 Anup Patel 2021-04-26   841  	}
d180bb1147b879 Anup Patel 2021-04-26   842  
d180bb1147b879 Anup Patel 2021-04-26   843  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
d180bb1147b879 Anup Patel 2021-04-26   844  	if (!priv)
d180bb1147b879 Anup Patel 2021-04-26   845  		return -ENOMEM;
d180bb1147b879 Anup Patel 2021-04-26   846  
d180bb1147b879 Anup Patel 2021-04-26   847  	/* Find number of parent interrupts */
d180bb1147b879 Anup Patel 2021-04-26   848  	nr_parent_irqs = of_irq_count(node);
d180bb1147b879 Anup Patel 2021-04-26   849  	if (!nr_parent_irqs) {
d180bb1147b879 Anup Patel 2021-04-26   850  		pr_err("%pOFP: no parent irqs available\n", node);
d180bb1147b879 Anup Patel 2021-04-26  @851  		return -EINVAL;

goto out_free_priv?  Same for a bunch of other error paths as well.

d180bb1147b879 Anup Patel 2021-04-26   852  	}
d180bb1147b879 Anup Patel 2021-04-26   853  
d180bb1147b879 Anup Patel 2021-04-26   854  	/* Find number of guest index bits in MSI address */
d180bb1147b879 Anup Patel 2021-04-26   855  	rc = of_property_read_u32(node, "imsic,guest-index-bits",
d180bb1147b879 Anup Patel 2021-04-26   856  				  &priv->guest_index_bits);
d180bb1147b879 Anup Patel 2021-04-26   857  	if (rc)
d180bb1147b879 Anup Patel 2021-04-26   858  		priv->guest_index_bits = 0;
d180bb1147b879 Anup Patel 2021-04-26   859  	tmp = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
d180bb1147b879 Anup Patel 2021-04-26   860  	if (tmp < priv->guest_index_bits) {
d180bb1147b879 Anup Patel 2021-04-26   861  		pr_err("%pOFP: guest index bits too big\n", node);
d180bb1147b879 Anup Patel 2021-04-26   862  		return -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   863  	}
d180bb1147b879 Anup Patel 2021-04-26   864  
d180bb1147b879 Anup Patel 2021-04-26   865  	/* Find number of HART index bits */
d180bb1147b879 Anup Patel 2021-04-26   866  	rc = of_property_read_u32(node, "imsic,hart-index-bits",
d180bb1147b879 Anup Patel 2021-04-26   867  				  &priv->hart_index_bits);
d180bb1147b879 Anup Patel 2021-04-26   868  	if (rc) {
d180bb1147b879 Anup Patel 2021-04-26   869  		/* Assume default value */
d180bb1147b879 Anup Patel 2021-04-26   870  		priv->hart_index_bits = __fls(nr_parent_irqs);
d180bb1147b879 Anup Patel 2021-04-26   871  		if (BIT(priv->hart_index_bits) < nr_parent_irqs)
d180bb1147b879 Anup Patel 2021-04-26   872  			priv->hart_index_bits++;
d180bb1147b879 Anup Patel 2021-04-26   873  	}
d180bb1147b879 Anup Patel 2021-04-26   874  	tmp = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
d180bb1147b879 Anup Patel 2021-04-26   875  	      priv->guest_index_bits;
d180bb1147b879 Anup Patel 2021-04-26   876  	if (tmp < priv->hart_index_bits) {
d180bb1147b879 Anup Patel 2021-04-26   877  		pr_err("%pOFP: HART index bits too big\n", node);
d180bb1147b879 Anup Patel 2021-04-26   878  		return -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   879  	}
d180bb1147b879 Anup Patel 2021-04-26   880  
d180bb1147b879 Anup Patel 2021-04-26   881  	/* Find number of group index bits */
d180bb1147b879 Anup Patel 2021-04-26   882  	rc = of_property_read_u32(node, "imsic,group-index-bits",
d180bb1147b879 Anup Patel 2021-04-26   883  				  &priv->group_index_bits);
d180bb1147b879 Anup Patel 2021-04-26   884  	if (rc)
d180bb1147b879 Anup Patel 2021-04-26   885  		priv->group_index_bits = 0;
d180bb1147b879 Anup Patel 2021-04-26   886  	tmp = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
d180bb1147b879 Anup Patel 2021-04-26   887  	      priv->guest_index_bits - priv->hart_index_bits;
d180bb1147b879 Anup Patel 2021-04-26   888  	if (tmp < priv->group_index_bits) {
d180bb1147b879 Anup Patel 2021-04-26   889  		pr_err("%pOFP: group index bits too big\n", node);
d180bb1147b879 Anup Patel 2021-04-26   890  		return -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   891  	}
d180bb1147b879 Anup Patel 2021-04-26   892  
d180bb1147b879 Anup Patel 2021-04-26   893  	/* Find first bit position of group index */
d180bb1147b879 Anup Patel 2021-04-26   894  	tmp = IMSIC_MMIO_PAGE_SHIFT + priv->guest_index_bits +
d180bb1147b879 Anup Patel 2021-04-26   895  	      priv->hart_index_bits;
d180bb1147b879 Anup Patel 2021-04-26   896  	rc = of_property_read_u32(node, "imsic,group-index-shift",
d180bb1147b879 Anup Patel 2021-04-26   897  				  &priv->group_index_shift);
d180bb1147b879 Anup Patel 2021-04-26   898  	if (rc)
d180bb1147b879 Anup Patel 2021-04-26   899  		priv->group_index_shift = tmp;
d180bb1147b879 Anup Patel 2021-04-26   900  	if (priv->group_index_shift < tmp) {
d180bb1147b879 Anup Patel 2021-04-26   901  		pr_err("%pOFP: group index shift too small\n", node);
d180bb1147b879 Anup Patel 2021-04-26   902  		return -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   903  	}
d180bb1147b879 Anup Patel 2021-04-26   904  	tmp = priv->group_index_bits + priv->group_index_shift - 1;
d180bb1147b879 Anup Patel 2021-04-26   905  	if (tmp >= BITS_PER_LONG) {
d180bb1147b879 Anup Patel 2021-04-26   906  		pr_err("%pOFP: group index shift too big\n", node);
d180bb1147b879 Anup Patel 2021-04-26   907  		return -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   908  	}
d180bb1147b879 Anup Patel 2021-04-26   909  
d180bb1147b879 Anup Patel 2021-04-26   910  	/* Find number of interrupt identities */
d180bb1147b879 Anup Patel 2021-04-26   911  	rc = of_property_read_u32(node, "imsic,num-ids", &priv->nr_ids);
d180bb1147b879 Anup Patel 2021-04-26   912  	if (rc) {
d180bb1147b879 Anup Patel 2021-04-26   913  		pr_err("%pOFP: number of interrupt identities not found\n",
d180bb1147b879 Anup Patel 2021-04-26   914  		       node);
d180bb1147b879 Anup Patel 2021-04-26   915  		return rc;
d180bb1147b879 Anup Patel 2021-04-26   916  	}
d180bb1147b879 Anup Patel 2021-04-26   917  	if ((priv->nr_ids < IMSIC_MIN_ID) ||
d180bb1147b879 Anup Patel 2021-04-26   918  	    (priv->nr_ids >= IMSIC_MAX_ID) ||
d180bb1147b879 Anup Patel 2021-04-26   919  	    ((priv->nr_ids & IMSIC_MIN_ID) != IMSIC_MIN_ID)) {
d180bb1147b879 Anup Patel 2021-04-26   920  		pr_err("%pOFP: invalid number of interrupt identities\n",
d180bb1147b879 Anup Patel 2021-04-26   921  		       node);
d180bb1147b879 Anup Patel 2021-04-26   922  		return -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   923  	}
d180bb1147b879 Anup Patel 2021-04-26   924  
d180bb1147b879 Anup Patel 2021-04-26   925  	/* Compute base address */
d180bb1147b879 Anup Patel 2021-04-26   926  	rc = of_address_to_resource(node, 0, &res);
d180bb1147b879 Anup Patel 2021-04-26   927  	if (rc) {
d180bb1147b879 Anup Patel 2021-04-26   928  		pr_err("%pOFP: first MMIO resource not found\n", node);
d180bb1147b879 Anup Patel 2021-04-26   929  		return -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   930  	}
d180bb1147b879 Anup Patel 2021-04-26   931  	priv->base_addr = res.start;
d180bb1147b879 Anup Patel 2021-04-26   932  	priv->base_addr &= ~(BIT(priv->guest_index_bits +
d180bb1147b879 Anup Patel 2021-04-26   933  				 priv->hart_index_bits +
d180bb1147b879 Anup Patel 2021-04-26   934  				 IMSIC_MMIO_PAGE_SHIFT) - 1);
d180bb1147b879 Anup Patel 2021-04-26   935  	priv->base_addr &= ~((BIT(priv->group_index_bits) - 1) <<
d180bb1147b879 Anup Patel 2021-04-26   936  			     priv->group_index_shift);
d180bb1147b879 Anup Patel 2021-04-26   937  
d180bb1147b879 Anup Patel 2021-04-26   938  	/* Find number of MMIO register sets */
d180bb1147b879 Anup Patel 2021-04-26   939  	while (!of_address_to_resource(node, priv->num_mmios, &res))
d180bb1147b879 Anup Patel 2021-04-26   940  		priv->num_mmios++;
d180bb1147b879 Anup Patel 2021-04-26   941  
d180bb1147b879 Anup Patel 2021-04-26   942  	/* Allocate MMIO register sets */
d180bb1147b879 Anup Patel 2021-04-26   943  	priv->mmios = kcalloc(priv->num_mmios, sizeof(*mmio), GFP_KERNEL);
d180bb1147b879 Anup Patel 2021-04-26   944  	if (!priv->mmios) {
d180bb1147b879 Anup Patel 2021-04-26   945  		rc = -ENOMEM;
d180bb1147b879 Anup Patel 2021-04-26   946  		goto out_free_priv;
d180bb1147b879 Anup Patel 2021-04-26   947  	}
d180bb1147b879 Anup Patel 2021-04-26   948  
d180bb1147b879 Anup Patel 2021-04-26   949  	/* Parse and map MMIO register sets */
d180bb1147b879 Anup Patel 2021-04-26   950  	for (i = 0; i < priv->num_mmios; i++) {
d180bb1147b879 Anup Patel 2021-04-26   951  		mmio = &priv->mmios[i];
d180bb1147b879 Anup Patel 2021-04-26   952  		rc = of_address_to_resource(node, i, &res);
d180bb1147b879 Anup Patel 2021-04-26   953  		if (rc) {
d180bb1147b879 Anup Patel 2021-04-26   954  			pr_err("%pOFP: unable to parse MMIO regset %d\n",
d180bb1147b879 Anup Patel 2021-04-26   955  				node, i);
d180bb1147b879 Anup Patel 2021-04-26   956  			goto out_iounmap;
d180bb1147b879 Anup Patel 2021-04-26   957  		}
d180bb1147b879 Anup Patel 2021-04-26   958  		mmio->pa = res.start;
d180bb1147b879 Anup Patel 2021-04-26   959  		mmio->size = res.end - res.start + 1;
d180bb1147b879 Anup Patel 2021-04-26   960  
d180bb1147b879 Anup Patel 2021-04-26   961  		base_addr = mmio->pa;
d180bb1147b879 Anup Patel 2021-04-26   962  		base_addr &= ~(BIT(priv->guest_index_bits +
d180bb1147b879 Anup Patel 2021-04-26   963  				   priv->hart_index_bits +
d180bb1147b879 Anup Patel 2021-04-26   964  				   IMSIC_MMIO_PAGE_SHIFT) - 1);
d180bb1147b879 Anup Patel 2021-04-26   965  		base_addr &= ~((BIT(priv->group_index_bits) - 1) <<
d180bb1147b879 Anup Patel 2021-04-26   966  				priv->group_index_shift);
d180bb1147b879 Anup Patel 2021-04-26   967  		if (base_addr != priv->base_addr) {
d180bb1147b879 Anup Patel 2021-04-26   968  			rc = -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   969  			pr_err("%pOFP: address mismatch for regset %d\n",
d180bb1147b879 Anup Patel 2021-04-26   970  				node, i);
d180bb1147b879 Anup Patel 2021-04-26   971  			goto out_iounmap;
d180bb1147b879 Anup Patel 2021-04-26   972  		}
d180bb1147b879 Anup Patel 2021-04-26   973  
d180bb1147b879 Anup Patel 2021-04-26   974  		tmp = BIT(priv->guest_index_bits) - 1;
d180bb1147b879 Anup Patel 2021-04-26   975  		if ((mmio->size / IMSIC_MMIO_PAGE_SZ) & tmp) {
d180bb1147b879 Anup Patel 2021-04-26   976  			rc = -EINVAL;
d180bb1147b879 Anup Patel 2021-04-26   977  			pr_err("%pOFP: size mismatch for regset %d\n",
d180bb1147b879 Anup Patel 2021-04-26   978  			       node, i);
d180bb1147b879 Anup Patel 2021-04-26   979  			goto out_iounmap;
d180bb1147b879 Anup Patel 2021-04-26   980  		}
d180bb1147b879 Anup Patel 2021-04-26   981  
d180bb1147b879 Anup Patel 2021-04-26   982  		mmio->va = of_iomap(node, i);
d180bb1147b879 Anup Patel 2021-04-26   983  		if (!mmio->va) {
d180bb1147b879 Anup Patel 2021-04-26   984  			rc = -EIO;
d180bb1147b879 Anup Patel 2021-04-26   985  			pr_err("%pOFP: unable to map MMIO regset %d\n",
d180bb1147b879 Anup Patel 2021-04-26   986  				node, i);
d180bb1147b879 Anup Patel 2021-04-26   987  			goto out_iounmap;
d180bb1147b879 Anup Patel 2021-04-26   988  		}
d180bb1147b879 Anup Patel 2021-04-26   989  	}
d180bb1147b879 Anup Patel 2021-04-26   990  
d180bb1147b879 Anup Patel 2021-04-26   991  	/* Initialize interrupt identity management */
d180bb1147b879 Anup Patel 2021-04-26   992  	rc = imsic_ids_init(priv);
d180bb1147b879 Anup Patel 2021-04-26   993  	if (rc) {
d180bb1147b879 Anup Patel 2021-04-26   994  		pr_err("%pOFP: failed to initialize interrupt management\n",
d180bb1147b879 Anup Patel 2021-04-26   995  		       node);
d180bb1147b879 Anup Patel 2021-04-26   996  		goto out_iounmap;
d180bb1147b879 Anup Patel 2021-04-26   997  	}
d180bb1147b879 Anup Patel 2021-04-26   998  
d180bb1147b879 Anup Patel 2021-04-26   999  	/* Configure handlers for target CPUs */
d180bb1147b879 Anup Patel 2021-04-26  1000  	for (i = 0; i < nr_parent_irqs; i++) {
d180bb1147b879 Anup Patel 2021-04-26  1001  		struct of_phandle_args parent;
d180bb1147b879 Anup Patel 2021-04-26  1002  		unsigned long reloff;
d180bb1147b879 Anup Patel 2021-04-26  1003  		int j, cpu, hartid;
d180bb1147b879 Anup Patel 2021-04-26  1004  
d180bb1147b879 Anup Patel 2021-04-26  1005  		if (of_irq_parse_one(node, i, &parent)) {
d180bb1147b879 Anup Patel 2021-04-26  1006  			pr_warn("%pOFP: failed to parse parent irq%d\n",
d180bb1147b879 Anup Patel 2021-04-26  1007  				node, i);
d180bb1147b879 Anup Patel 2021-04-26  1008  			continue;
d180bb1147b879 Anup Patel 2021-04-26  1009  		}
d180bb1147b879 Anup Patel 2021-04-26  1010  
d180bb1147b879 Anup Patel 2021-04-26  1011  		/*
d180bb1147b879 Anup Patel 2021-04-26  1012  		 * Skip interrupt pages other than external interrupts for
d180bb1147b879 Anup Patel 2021-04-26  1013  		 * out privilege level.
d180bb1147b879 Anup Patel 2021-04-26  1014  		 */
d180bb1147b879 Anup Patel 2021-04-26  1015  		if (parent.args[0] != RV_IRQ_EXT) {
d180bb1147b879 Anup Patel 2021-04-26  1016  			pr_warn("%pOFP: invalid hwirq for parent irq%d\n",
d180bb1147b879 Anup Patel 2021-04-26  1017  				node, i);
d180bb1147b879 Anup Patel 2021-04-26  1018  			continue;
d180bb1147b879 Anup Patel 2021-04-26  1019  		}
d180bb1147b879 Anup Patel 2021-04-26  1020  
d180bb1147b879 Anup Patel 2021-04-26  1021  		hartid = riscv_of_parent_hartid(parent.np);
d180bb1147b879 Anup Patel 2021-04-26  1022  		if (hartid < 0) {
d180bb1147b879 Anup Patel 2021-04-26  1023  			pr_warn("%pOFP: hart ID for parent irq%d not found\n",
d180bb1147b879 Anup Patel 2021-04-26  1024  				node, i);
d180bb1147b879 Anup Patel 2021-04-26  1025  			continue;
d180bb1147b879 Anup Patel 2021-04-26  1026  		}
d180bb1147b879 Anup Patel 2021-04-26  1027  
d180bb1147b879 Anup Patel 2021-04-26  1028  		cpu = riscv_hartid_to_cpuid(hartid);
d180bb1147b879 Anup Patel 2021-04-26  1029  		if (cpu < 0) {
d180bb1147b879 Anup Patel 2021-04-26  1030  			pr_warn("%pOFP: invalid cpuid for parent irq%d\n",
d180bb1147b879 Anup Patel 2021-04-26  1031  				node, i);
d180bb1147b879 Anup Patel 2021-04-26  1032  			continue;
d180bb1147b879 Anup Patel 2021-04-26  1033  		}
d180bb1147b879 Anup Patel 2021-04-26  1034  
d180bb1147b879 Anup Patel 2021-04-26  1035  		/* Find parent domain and register chained handler */
d180bb1147b879 Anup Patel 2021-04-26  1036  		if (!imsic_parent_irq && irq_find_host(parent.np)) {
d180bb1147b879 Anup Patel 2021-04-26  1037  			imsic_parent_irq = irq_of_parse_and_map(node, i);
d180bb1147b879 Anup Patel 2021-04-26  1038  			if (imsic_parent_irq)
d180bb1147b879 Anup Patel 2021-04-26  1039  				irq_set_chained_handler(imsic_parent_irq,
d180bb1147b879 Anup Patel 2021-04-26  1040  							imsic_handle_irq);
d180bb1147b879 Anup Patel 2021-04-26  1041  		}
d180bb1147b879 Anup Patel 2021-04-26  1042  
d180bb1147b879 Anup Patel 2021-04-26  1043  		/* Find MMIO location of MSI page */
d180bb1147b879 Anup Patel 2021-04-26  1044  		mmio = NULL;
d180bb1147b879 Anup Patel 2021-04-26  1045  		reloff = i * BIT(priv->guest_index_bits) *
d180bb1147b879 Anup Patel 2021-04-26  1046  			  IMSIC_MMIO_PAGE_SZ;
d180bb1147b879 Anup Patel 2021-04-26  1047  		for (j = 0; priv->num_mmios; j++) {
d180bb1147b879 Anup Patel 2021-04-26  1048  			if (reloff < priv->mmios[j].size) {
d180bb1147b879 Anup Patel 2021-04-26  1049  				mmio = &priv->mmios[j];
d180bb1147b879 Anup Patel 2021-04-26  1050  				break;
d180bb1147b879 Anup Patel 2021-04-26  1051  			}
d180bb1147b879 Anup Patel 2021-04-26  1052  
d180bb1147b879 Anup Patel 2021-04-26  1053  			reloff -= priv->mmios[j].size;
d180bb1147b879 Anup Patel 2021-04-26  1054  		}
d180bb1147b879 Anup Patel 2021-04-26  1055  		if (!mmio) {
d180bb1147b879 Anup Patel 2021-04-26  1056  			pr_warn("%pOFP: MMIO not found for parent irq%d\n",
d180bb1147b879 Anup Patel 2021-04-26  1057  				node, i);
d180bb1147b879 Anup Patel 2021-04-26  1058  			continue;
d180bb1147b879 Anup Patel 2021-04-26  1059  		}
d180bb1147b879 Anup Patel 2021-04-26  1060  
d180bb1147b879 Anup Patel 2021-04-26  1061  		handler = per_cpu_ptr(&imsic_handlers, cpu);
d180bb1147b879 Anup Patel 2021-04-26  1062  		if (handler->priv) {
d180bb1147b879 Anup Patel 2021-04-26  1063  			pr_warn("%pOFP: CPU%d handler already configured.\n",
d180bb1147b879 Anup Patel 2021-04-26  1064  				node, cpu);
d180bb1147b879 Anup Patel 2021-04-26  1065  			goto done;
d180bb1147b879 Anup Patel 2021-04-26  1066  		}
d180bb1147b879 Anup Patel 2021-04-26  1067  
d180bb1147b879 Anup Patel 2021-04-26  1068  		cpumask_set_cpu(cpu, &priv->lmask);
d180bb1147b879 Anup Patel 2021-04-26  1069  		handler->msi_pa = mmio->pa + reloff;
d180bb1147b879 Anup Patel 2021-04-26  1070  		handler->msi_va = mmio->va + reloff;
d180bb1147b879 Anup Patel 2021-04-26  1071  		handler->priv = priv;
d180bb1147b879 Anup Patel 2021-04-26  1072  
d180bb1147b879 Anup Patel 2021-04-26  1073  done:
d180bb1147b879 Anup Patel 2021-04-26  1074  		nr_handlers++;
d180bb1147b879 Anup Patel 2021-04-26  1075  	}
d180bb1147b879 Anup Patel 2021-04-26  1076  
d180bb1147b879 Anup Patel 2021-04-26  1077  	/* Initialize IPI domain */
d180bb1147b879 Anup Patel 2021-04-26  1078  	rc = imsic_ipi_domain_init(priv, node);
d180bb1147b879 Anup Patel 2021-04-26  1079  	if (rc) {
d180bb1147b879 Anup Patel 2021-04-26  1080  		pr_err("%pOFP: Failed to initialize IPI domain\n", node);
d180bb1147b879 Anup Patel 2021-04-26  1081  		goto out_ids_cleanup;
d180bb1147b879 Anup Patel 2021-04-26  1082  	}
d180bb1147b879 Anup Patel 2021-04-26  1083  
d180bb1147b879 Anup Patel 2021-04-26  1084  	/* Initialize IRQ and MSI domains */
d180bb1147b879 Anup Patel 2021-04-26  1085  	rc = imsic_irq_domains_init(priv, node);
d180bb1147b879 Anup Patel 2021-04-26  1086  	if (rc) {
d180bb1147b879 Anup Patel 2021-04-26  1087  		pr_err("%pOFP: Failed to initialize IRQ and MSI domains\n",
d180bb1147b879 Anup Patel 2021-04-26  1088  		       node);
d180bb1147b879 Anup Patel 2021-04-26  1089  		goto out_ipi_domain_cleanup;
d180bb1147b879 Anup Patel 2021-04-26  1090  	}
d180bb1147b879 Anup Patel 2021-04-26  1091  
d180bb1147b879 Anup Patel 2021-04-26  1092  	/* Setup cpuhp state */
d180bb1147b879 Anup Patel 2021-04-26  1093  	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
d180bb1147b879 Anup Patel 2021-04-26  1094  			  "irqchip/riscv/imsic:starting",
d180bb1147b879 Anup Patel 2021-04-26  1095  			  imsic_starting_cpu, imsic_dying_cpu);
d180bb1147b879 Anup Patel 2021-04-26  1096  
d180bb1147b879 Anup Patel 2021-04-26  1097  	/*
d180bb1147b879 Anup Patel 2021-04-26  1098  	 * Only one IMSIC instance allowed in a platform for clean
d180bb1147b879 Anup Patel 2021-04-26  1099  	 * implementation of SMP IRQ affinity and per-CPU IPIs.
d180bb1147b879 Anup Patel 2021-04-26  1100  	 *
d180bb1147b879 Anup Patel 2021-04-26  1101  	 * This means on a multi-socket (or multi-die) platform we
d180bb1147b879 Anup Patel 2021-04-26  1102  	 * will have multiple MMIO regions for one IMSIC instance.
d180bb1147b879 Anup Patel 2021-04-26  1103  	 */
d180bb1147b879 Anup Patel 2021-04-26  1104  	imsic_init_done = true;
d180bb1147b879 Anup Patel 2021-04-26  1105  
d180bb1147b879 Anup Patel 2021-04-26  1106  	pr_info("%pOFP: mapped %d interrupts using %d handlers\n",
d180bb1147b879 Anup Patel 2021-04-26  1107  		node, priv->nr_ids, nr_handlers);
d180bb1147b879 Anup Patel 2021-04-26  1108  
d180bb1147b879 Anup Patel 2021-04-26  1109  	return 0;
d180bb1147b879 Anup Patel 2021-04-26  1110  
d180bb1147b879 Anup Patel 2021-04-26  1111  out_ipi_domain_cleanup:
d180bb1147b879 Anup Patel 2021-04-26  1112  	imsic_ipi_domain_cleanup(priv);
d180bb1147b879 Anup Patel 2021-04-26  1113  out_ids_cleanup:
d180bb1147b879 Anup Patel 2021-04-26  1114  	imsic_ids_cleanup(priv);
d180bb1147b879 Anup Patel 2021-04-26  1115  out_iounmap:
d180bb1147b879 Anup Patel 2021-04-26  1116  	for (i = 0; i < priv->num_mmios; i++) {
d180bb1147b879 Anup Patel 2021-04-26  1117  		if (priv->mmios[i].va)
d180bb1147b879 Anup Patel 2021-04-26  1118  			iounmap(priv->mmios[i].va);
d180bb1147b879 Anup Patel 2021-04-26  1119  	}
d180bb1147b879 Anup Patel 2021-04-26  1120  	kfree(priv->mmios);
d180bb1147b879 Anup Patel 2021-04-26  1121  out_free_priv:
d180bb1147b879 Anup Patel 2021-04-26  1122  	kfree(priv);
d180bb1147b879 Anup Patel 2021-04-26  1123  	return rc;
d180bb1147b879 Anup Patel 2021-04-26  1124  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

