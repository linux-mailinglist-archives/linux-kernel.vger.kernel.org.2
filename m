Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9740AB32
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhINJ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:56:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57052 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230151AbhINJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:56:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9cdtg006269;
        Tue, 14 Sep 2021 09:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=7MKVcLPMWiXXYATHcGE1BQDyBIq6b+/8J0bXwxz+kDk=;
 b=HERI8o6CCJJqxIrQTrMHU26roQBzGgSFwd7hJ+MlbXsYXcNKNgPhmBobGh0ky6llbstW
 8jv/rNJfl2qrNYcMmtZm4osLqX6rPDplcVi16bm7V7TZPnUPTh3s1dijrb+ZLI/spRzg
 xGe1KPw6UcEldg0fKgBQS54LNRc/fm305Y4VT9ZXJbp2yy4M1JQBgio40bpnkgIDlPLZ
 Cwp/tvMTcxkmeA5Azo5ExCHUAdLBJ2Gur44CHt0Z3EvrLc6BGTyjQauAHdEp6bYrrbPJ
 hHxu+uDmpQcNZYnIa7KJhE/bfwXbUL3oZ0hJqhhrHSa0YZsI0BntX9xirUGyBRq45AxA 2w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=7MKVcLPMWiXXYATHcGE1BQDyBIq6b+/8J0bXwxz+kDk=;
 b=e9UYz7X/ObP+eDY/xCtTfMZ0O9/knf/BZntDgGwQXiPsrsd4TUz0xvvXeT97egTEOsaQ
 bJgGZksQDzQOt7dL7exJAI/S8FKTHR2AH66pGJDjtzAjnF6rbinYYCtT9aOjj5siQw6b
 Ivf+9V78iNeP7SOi49SnfNiHzGLW7WvEbidYsqCq1CvIuQEZQEWOgRZ4+WRTVoewxDam
 A1+UiayRwPHU+g3CdDmGo7jmOYaJrS3rnSRNR+wPa/avqXL3sZ7AHN7SRdA4hj9pymGe
 yTrK3VzmtWyR/O/qrXx4+erhqrQfALNxEKsTKyVRnpYFeHXVXf6onRCd8Pt48zAi77SE 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p4f0t6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:54:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18E9kVTS175756;
        Tue, 14 Sep 2021 09:54:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3030.oracle.com with ESMTP id 3b0jgcuxdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFfsFwiOVvumtuUAq/HaHvbtAr/lwxGXa6SXpu5hnIQ3GkPHasZjBOEyF0SeusLlMnXNRO+Acg5KKwA1K4c7mM/5lNEh35zsYj0GxYDyJmSjlmSn9/dRuPHcmEL29kqWS4I0eMZ8vRuX/xpDOOp1PdvukUzBSpIQ6lMal5rRXo1dxGbTvP1h2V2WWG9xAMHTinlx91Yr5uHY/EjcFi/SD//ueQLxsZb0H/RY8leOP9qTlaRXvQMmIv2S4w+PuEV2Xh5PBeoa3Kxq3tSXerWOCEB7CArsLXaR5xBLlH42Fz5Qas/cwdPy2LF14ZtdrUgruPKllNO3U5kSUdMXEakY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7MKVcLPMWiXXYATHcGE1BQDyBIq6b+/8J0bXwxz+kDk=;
 b=alHN/vVx355/KPsbCD3TkclSYuuWLx4MzsLupqSFIt9KMyfnnnGrwoX6GDKaSdwnEzr9+TwoTW7y8jjl65RDEpt9/kK8XQouob72w8o1XafmQ82iki81190mNybCbre2bd1kpnh1ciEbcVEDIsVrv31b1RiPw2JwvDeLiGzsgCBT22+iiVLi5gUYbj7MQ628lsftMN9Mo/l3G3fmf5gT2yImPDmJ3lQ6BX2T7jcOYAhufVi7RwgJGMWr1FK3xNTGnbDLQ2zDInLz4/8iB78ri81g8mpo4CRFU5dz5g1QEWL8re0XzjV96Mfc8rkicVCQaklYKvU7Z5/IacRrsxyi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MKVcLPMWiXXYATHcGE1BQDyBIq6b+/8J0bXwxz+kDk=;
 b=RphTOeTFQlqwsLppnAJUlQiD1NUmCRH/tXkAwGzcrDiIuD6MDi8HtpObCsmT/9SJcJoDvvAZIWM/vFe8bT9PaU34qHXQbC9uM7BMEsQ1Ppe/nCDPllUrZkdX0mcsyN5Dve7LQ02fMuLh0E6jVuGf3mLbJGXRu2E3LwS0hurvvdo=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2398.namprd10.prod.outlook.com
 (2603:10b6:301:2f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 09:54:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 09:54:31 +0000
Date:   Tue, 14 Sep 2021 12:54:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Maxime Ripard <maxime@cerno.tech>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1046
 vop_plane_atomic_async_check() warn: variable dereferenced before check
 'state' (see line 1027)
Message-ID: <202109121449.EXjz85kn-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 09:54:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7df5ad44-9c57-42a9-0811-08d97765a602
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23985A4B25899E9C5054A5888EDA9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThhR8dKkNU/xvBBFI/vZQHFaodJaDAEtFvNePd99erVwmcTIDxVLxzqXp+S8qAeO3JFstSKeEDcEz8w0rxdwxEf50UBR1GeuP8DXAoCCOPYOx7ZJPpiufimg8EVrbqAkBeXTEkF3XjPjUHXPDp0mERZ5U9TXOeMVBkVXpF838EpFvk4bcqQtYP8aCIf62Ufr4C3rEDRuvMZJB4pQqJC5yesnNiB/O25UB4dONmj+nqBUqv8b1ogrAS3/KKkL+1URBDLxoo7FYh746qATX1cqLS0vtVmVIKndbop/6QEg9jPJMyYM076P8u3KUU6w2PkUkRxtn3W8nLizQPa8y+6bjRR0JyVtY7cUTugszN8xeGuNYY7ewygNnC+VOT0ukwMcZDQKga56LfvaveSucLBMSXXgbvpQTO6OcHh14w6tO5/1JsSuUnwlycFYnQegTkHFjjKtP9vIwRMglY55o6NUDQA68B237A3lwDU5467Pn7qu2OIbTeTtjnXA1vMFhL3+NAb1DHIINQf1bSSNP7qBmpDiYTLKA4fEBpi1dL+KlEzQVmSsqsuf8Iw8CXJsUaOCHXm3HmlnI8487IN0fDDofgAON8TIcZ2fcUz/5CY7YSPrxdrpBkwY7pzpFT31Oxp1MPUz48w0gn7XUD5ZJbRMREfne2z1yJXu0K5h0CwkKXRrgegMZvnOpTzZilH54YzYI9B9wRDT4HXMBd8IrneHsxwIVfoVwlL/HXKH+WPI8G7cH8rRt8bIphiWorOr+y6k4s009guKnCBmyfy5TUXe320okyLXkLRdPok+NINLMsub3f1fkydTpu+7/srT0oo6K0nNaRciXIulcFFkrcODeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(396003)(346002)(38100700002)(38350700002)(6496006)(6666004)(52116002)(6486002)(5660300002)(36756003)(26005)(6916009)(66476007)(44832011)(8936002)(8676002)(186003)(83380400001)(956004)(316002)(4326008)(478600001)(2906002)(86362001)(66946007)(9686003)(966005)(1076003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtrxPA0VvbBvn/6F96eTjZv6KDbx0Zo7F8w0n2A55RRmaoy0K0QV14LR4VTt?=
 =?us-ascii?Q?jkVUHwf0+9Ok6R0Vsv5fpzk4mUPFPXlOWd2erGYwgKbfGBnHFsGhaIp1iqQ7?=
 =?us-ascii?Q?Fl3RDh2FFHSPSFGCVMhSqE0RB0feBWZ+WbsgUWycOz0g+FfuCuSZGk2208RG?=
 =?us-ascii?Q?NChp0pAr0yvWjyjdFdrvWq6lpMui6+4f/aXObQoGUR23NoIXqDPAjFk3X3pd?=
 =?us-ascii?Q?ze0u4mGg9LfGT2giDC3Cyo56nOkdaZUGGNsejabd+OSGQOh4EqMeSUL5CqqF?=
 =?us-ascii?Q?NeoBp7/Es1oKopVitZCLIroyZ3f7Sae8gRZNlAAxr9SQElPA0/VEB/kyN+MV?=
 =?us-ascii?Q?kRzOdBfbjJifV0tl9ksXA/Ba85lRlJqKjDgpPTKcBMFEfjpOYI6B4XAeTMB9?=
 =?us-ascii?Q?5ePV8rUEZ7kD2ZZKdCJM0gqP/qWUJRwB/OqVjFBMAJwq8IEcMpSyJINj1jix?=
 =?us-ascii?Q?e+AVvFFQZbjC3RV1DP+XlDeNIcUzKwmExwRPGTCikylOZTKmKux2uPcSkgKB?=
 =?us-ascii?Q?AK806fpFvVF4wKVQZdtbJGwMv0QU5R30WvxS+2LB5QyyitfQKiLfQ1tv6j2h?=
 =?us-ascii?Q?AV5/iDIB3wZviuFGhfZ9Ham2UGJKEiIzX0bfa5KfggaELnaZWR0QOfl4M+UP?=
 =?us-ascii?Q?7lFcqjR1HB/URiaHq986kfFSnIdJJ3vHM7tjQvcJO93e3nxGQC2ZHjJD6tev?=
 =?us-ascii?Q?hxSLYBg0YOg4shS/gJ0BoUvfouUQVtEYYah1C7H2H+seej8N7vi3JbeeemjI?=
 =?us-ascii?Q?TjPC5EDZEcpAI4sPVzUTWCPJR2RktFjmenfo3AjPU3RutRTsRAxGOrn228wU?=
 =?us-ascii?Q?nG3Wxt2tjQ3UlsNvd1KADLSrhjjC9MTk/klcKLPwN4Zkb1qQiMwFEGKEoyOn?=
 =?us-ascii?Q?wqNjx9+lBrxM0pDPFkiLVGGyng7L0kj2KUu2vpfW78HhUFv2uFf+1A0PEGZf?=
 =?us-ascii?Q?x/G/WpRW71ZOGraUbuWwKIzTK6EcPsv4b4wY4GQgwI97xl8qs0Nv6TCQsbat?=
 =?us-ascii?Q?AHA1AHLENSY6XlcUotuDi/eT1YBC7Rx8yI7AjUXzvNJVuBkm/zRtTuWIwR5R?=
 =?us-ascii?Q?exXdZd0mrvUE9Ms/akBLpu2oR4BHb4k4/65oOfmkK9M4OVWGbZ8RyVQXm8d8?=
 =?us-ascii?Q?PltRCXNQ2SHLbjgc3zU3zrX+vWHycfsGZ0WgpqybnqOQ8kvCQ19Lbp7y4cB7?=
 =?us-ascii?Q?zf7px9/I6QqnNi0jyG5slft+QYyL4L3mUyjOZyHL0eEImCn6N+gfhxFeAlJ7?=
 =?us-ascii?Q?FCO4pwuoyJT8eq7rkZfAUxCGyZMM2UO9Vd/G7dAnqKHhjJE7bblvhOhNbCmt?=
 =?us-ascii?Q?oMWhpmWBQOH304oNdJCF5deR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df5ad44-9c57-42a9-0811-08d97765a602
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 09:54:31.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCu9b4OjdOsjLN01c1RU5gYe9Cl3rZoRy2zI5JgE0OREXMrVOu1u2aLXEo4QceqSFBWO9KhT1Vesigvdr90OrymQMD/F1m56eyUzR9ok5+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140059
X-Proofpoint-GUID: MeruxDsEdM2K2pLZLi9Lg7DW_D7D7m9O
X-Proofpoint-ORIG-GUID: MeruxDsEdM2K2pLZLi9Lg7DW_D7D7m9O
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   78e709522d2c012cb0daad2e668506637bffb7c2
commit: 5ddb0bd4ddc35d9c9376d109398f84277bb8d25e drm/atomic: Pass the full state to planes async atomic check and update
config: riscv-randconfig-m031-20210912 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1046 vop_plane_atomic_async_check() warn: variable dereferenced before check 'state' (see line 1027)

vim +/state +1046 drivers/gpu/drm/rockchip/rockchip_drm_vop.c

15609559a834a5 Enric Balletbo i Serra 2018-12-05  1024  static int vop_plane_atomic_async_check(struct drm_plane *plane,
5ddb0bd4ddc35d Maxime Ripard          2021-02-19  1025  					struct drm_atomic_state *state)
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1026  {
5ddb0bd4ddc35d Maxime Ripard          2021-02-19 @1027  	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
                                                                                                                                         ^^^^^
Dereferenced inside the function.

5ddb0bd4ddc35d Maxime Ripard          2021-02-19  1028  										 plane);
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1029  	struct vop_win *vop_win = to_vop_win(plane);
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1030  	const struct vop_win_data *win = vop_win->data;
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1031  	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1032  					DRM_PLANE_HELPER_NO_SCALING;
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1033  	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1034  					DRM_PLANE_HELPER_NO_SCALING;
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1035  	struct drm_crtc_state *crtc_state;
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1036  
5ddb0bd4ddc35d Maxime Ripard          2021-02-19  1037  	if (plane != new_plane_state->crtc->cursor)
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1038  		return -EINVAL;
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1039  
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1040  	if (!plane->state)
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1041  		return -EINVAL;
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1042  
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1043  	if (!plane->state->fb)
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1044  		return -EINVAL;
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1045  
5ddb0bd4ddc35d Maxime Ripard          2021-02-19 @1046  	if (state)
                                                                    ^^^^^
Checked for NULL.  Too late!

5ddb0bd4ddc35d Maxime Ripard          2021-02-19  1047  		crtc_state = drm_atomic_get_existing_crtc_state(state,
5ddb0bd4ddc35d Maxime Ripard          2021-02-19  1048  								new_plane_state->crtc);
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1049  	else /* Special case for asynchronous cursor updates. */
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1050  		crtc_state = plane->crtc->state;
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1051  
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1052  	return drm_atomic_helper_check_plane_state(plane->state, crtc_state,
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1053  						   min_scale, max_scale,
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1054  						   true, true);
15609559a834a5 Enric Balletbo i Serra 2018-12-05  1055  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

