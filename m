Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28E41A8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhI1G36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:29:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21912 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234207AbhI1G34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:29:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S5WYaM000536;
        Tue, 28 Sep 2021 06:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=IV+n9l41NvjADfmqBci/U13RY0XpJk3JZrZ1VX7ekSg=;
 b=x8srsucde1Lhomcb+A0HVhzn0xav4rdzvKThvrja1JU8Osf0I0BCJmKS6qqV/9MpA2s4
 gF1/iGQ4FMCRoL8wSoKKaGrje4ReBwTuzq51lKBoxXSKj+5oAzfHkKkufrwm/GHC2Vyi
 jZaBD0CSsPsPgKP65MD5HsL/UPuStK4uU5m47hZ25t21/L1/Q/kkiMuK6R/c/vZJxU5O
 DwRDl6FN/dhNOq0hFETiS/0+RFuGRa9rBszUm90Prp7ci3tD9C/6vhsIaGv/C/TpJyH9
 A56yNassBVmTuqyYj444KDhq2v2hg4bxL/EYvlvXZ8ce9Q/zchXW59+cKisVgGE24qHJ +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbeu15u9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 06:28:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18S6AMt8129338;
        Tue, 28 Sep 2021 06:28:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 3badhs63se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 06:28:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wad15ypMzchVxWdGXR3ggKgXR4esYIUgVFdk5kplW4bXuU+A/ytTLolhHB322kh9Tv4RyC6jmVuKYn+DRtV4Mgvh0MP8B6k5IUyqR9qTnLuZ8VIP/MRTECG8om+AoE9aMU+LRjauxchCNRgOZm75/Nbbc/o1Kg+bSn6Uc2A+uTgmkwc9kWgUZ4X4HX9vVoNmX9C5TPocJcG1wjCE9Jv98BzfMPX5T4sNIgEd4p0YBJ3fkRY2XEmMLGsTVuw8tVmzKEdDX5BruA3wh7wI7me9icNAcBW6rUFIyxLi8oO9qr9CTojmz6cPeB/JY24gK9E0KShzCe7FnGLGBkEZwbhqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=R30/x4BJDWWAdkITEmSBnIsKFSEd8ycyYQSxPG9QdQ4=;
 b=J3a9MwVkme0pMpzndkiP1u9d7ZHJdqWVmeyAnqLF07R3sQwxN++1AGLH5AeuY6O3qio2W6QSk7zX+FKAEYRSGroiGZlIiuq0l9qkJQmEtmbH1pTy40fOZ7XNdNWK7hlkFw53d5lYsNwc5lmVg+03W1K6T0rzbZoXoBDzYhWM8I0ti7ZuIcBXa+S+yzOL++IS7QsEbwXyY3pVL4QCoxrSjVKiURF+eLwHnd7RkRMGaccEsNLXa3S3AeD/69GrNp02J+AazBDJNNvxkbtlHMZF9rAIFICqUA7sUggoh1zn0ZmJWTRRmKSI/MBCslR6kN3g1Iv4SR+5yvsiURo9m9BrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R30/x4BJDWWAdkITEmSBnIsKFSEd8ycyYQSxPG9QdQ4=;
 b=te9dTw6GXQoyxAjnUfRWaaaFm/+QGYqy0QrK5+0oUJbB0OAZdg01snH29UW+k6HxyW3TNxBHnsUOupP0hET5vIL9n149CYSkSTP0jilYy3oPJxCNWCEsc2dNRWZYTvUl/BhCxy+Hct1mrmZEwPKypoYvKydrYi6YSMNsJPPtNi8=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5555.namprd10.prod.outlook.com
 (2603:10b6:303:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 06:28:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 06:28:11 +0000
Date:   Tue, 28 Sep 2021 09:27:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Imre Deak <imre.deak@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/i915/display/intel_ddi.c:4030
 intel_ddi_encoder_destroy() warn: variable dereferenced before check
 'dig_port' (see line 4022)
Message-ID: <202109281149.iuYlYi31-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Tue, 28 Sep 2021 06:28:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f617dbc-cfb5-423c-2d9a-08d98249251f
X-MS-TrafficTypeDiagnostic: CO6PR10MB5555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5555DA97BCCA53A33486DA338EA89@CO6PR10MB5555.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muLXD++Obv4PiCCgwajY+YBYL7JOaJbhSFLSoB8aSqgZOkwwqU96flktLXdDf/+15Gt9lTAB6y43UTIZhdemlPv8UaVqJG0Vvr2CeBSPAm1M+tAsUJoLhbhVjgzir7IxbQEz7eLbjP/aFLaLHg5OH4OFp4YJ7iA8vVuvZprUer+P7cInZ9FKb2Gm/GMzmzJ6c5wbU0rr+pT62+aq5qghECy+js8sD6dCWJ4whEPJi1jEUxZual99jGpBOwKOP4MMI1FKNKaB2TpCSwaIbFsA2nRAcQ2C6j6pupsBw32+5zq+jYdDOU9yKcVubrJ4uXJ07Kup7kRD7OZ5NxIZbxPgAo/7NXEIJIB+pBVNAzs0jcbEocM+fOq4vGpKk/rWQATxrp5B6e6NpprsgbRUHb53jwOff1isZEh1Jj9DQSZLPLzKLEV1CWOr6LASZPPPEu7Lvqc+CHmMlf59Do9/BO9IrjGV3X9lNyGHBzv/OGdm6/BDtC0LK1rA+LqpCd09UBg2NeSHHzzW6O1B+9Qbu3MmDRzLhGVbXGUNclxKZW/ZtwjfgW8Ipi53QJOPwWX9OG0aqL8WJtiegqK73fSf7grdeg6BqGl/X2XIzKhLLmFkfuGMwCxY84wS2aZZuJOHZwHomPETtZzJRbDDkf1VRKw9f5+mEA0h8jLAuYx/iwdi9MjwJI0JZXWBh+Y2ymp2QOhdijzv/guG58V5BUNDd+JPaLHfjIbNGgZDJ7iNzhKz1mF/D7SNziljzKVB/0O7oNaDAVznS268eB3V352alCQQ8AwFih3wTm7oJjoN+tgB7EBvPyyuApTvV8mTPbUSUaeE/hwUK4gZf3qTubOSwfr+hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(8676002)(6666004)(4001150100001)(5660300002)(6496006)(44832011)(52116002)(8936002)(6916009)(956004)(37006003)(66556008)(66476007)(66946007)(9686003)(316002)(83380400001)(36756003)(86362001)(38100700002)(38350700002)(186003)(966005)(4326008)(508600001)(26005)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?h7AphU8w9IYaFopX+gSxarmIJDmy+CEgyoFbl8JNzQjh1oqJdGk0MHc1sr?=
 =?iso-8859-1?Q?Rrq3RJ74Oicc852bhRJlHQKhVrFqQSmXeLefiJfd2oevjDY4Ex/6PXRKG9?=
 =?iso-8859-1?Q?cmm7/RWSle82cazo6xdm4RIhPkc4xKtmzJnAkEKsyOHHyOFCNE4KTkpGx6?=
 =?iso-8859-1?Q?W6xqBfd3RsWwMEYG2PekBSMmg0KQ1FN8MCPnVuyEQ2kYwq0B6rFzzs3t2/?=
 =?iso-8859-1?Q?4dj6gFqa5ZHTJkfSpjkrHxAaj+wgpoa51tJYRHJjjknWqIpLGq/XfvBnOg?=
 =?iso-8859-1?Q?Yr651ki5wGhJ1k0RrcDoNQqGdUHnwlHmmTJv/wtX0qN5ZMhSiRFn3L5je2?=
 =?iso-8859-1?Q?rKmJZ7MhzpR99s8cv0u8D672psvlMKyk+4+OL6jMBajJViK2aCfl4FG2na?=
 =?iso-8859-1?Q?6Mb9eEYHNWeUtD0CF9bA85IN+AjCI32Yzh7vq/v3DSKYZTJ0jM8p9i7VFZ?=
 =?iso-8859-1?Q?9YjqwQIWrqSvBEotM8MdHSDAuNZeJm955eceOhyPrT6AebPqLqIjkNQ5f1?=
 =?iso-8859-1?Q?sz/MktMcd4eMS6+1Fv3rc7ZVU+P6YuCwwdKSKVhvnaSyloOGSTJFVQ8Ohx?=
 =?iso-8859-1?Q?fRFG6l3ICKTg391Alfgd1M2+XGBxCqcixVlVAIo02dN4xXp45ky1LxnbpK?=
 =?iso-8859-1?Q?Y4YFnhkbrySihoMU3dOab2y1WVr/faFalCIEGdSCdO+vElwbJKcWskdkx3?=
 =?iso-8859-1?Q?uq5jUSIhZ8vanZZQwmny3Q90oqsE3vUjNGuGQd1/nKsAYwEOiS7iLxNGRj?=
 =?iso-8859-1?Q?FzHdBUHq/GXlN9mrN0NGiC1LwrWaZmdDsAEZaYrdYR9Se+xyI3zU8FtJt6?=
 =?iso-8859-1?Q?czpwh4uN3JI+snPDXf0PYFwH/fgWU9TKXmbi8lSzTmpl+VXUTCw0J05kmA?=
 =?iso-8859-1?Q?fw1i8svo9zTr3HkfswKRdcJrLgI3EIrBRsThrDJe+Dx20f5xRmBZvrwKAc?=
 =?iso-8859-1?Q?ueykspDGJ4Pc2ZR358lrhc1Yu9nXmnIiQKx0kDcoR+NbFj/S/LIJBSB1/v?=
 =?iso-8859-1?Q?i2cxBGjFwbUU21q3DUcmskB14JRZESUz+hiVsvbmDgFOme75grrP5kpLAv?=
 =?iso-8859-1?Q?J8oBjtX+SaudxShmBVqNfdgDXf0iakHUrnmfRqhx+uU1jyecFhlyockVjH?=
 =?iso-8859-1?Q?gQVsom/lKUHKlzzetMICFi/gcOW+9/xAPwDQtHWP/YhqJrASbfNmtpLFf7?=
 =?iso-8859-1?Q?xjHk9XMq1B6uuJ3EsyquP7MF6XLGg39OalSbuR/ACC/6uZVi2OfsYDBf/P?=
 =?iso-8859-1?Q?26GKQkjwChE2F9PU0GLHsaAZqOW3SGZYIuHliPFF5ykec/XnWrwizwx1Lz?=
 =?iso-8859-1?Q?/dehwFm1zPvFeE0cgI1P/BLbK/ECdkM3ebw3wpk+c7bdjCT7U+OxBIO2+b?=
 =?iso-8859-1?Q?nTgFns86W5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f617dbc-cfb5-423c-2d9a-08d98249251f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 06:28:11.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5RKbgNEEwRMzIfu94tlbpWMy7/6C90oDqgWfusuIBq9fyh2AXUSGlBNvl5e555dOJouW2zHhyURyFWgayXQn5UNOEqyZjZd8kNvnRKgaR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280035
X-Proofpoint-GUID: tUnIfnxCfCzGEZPVU1ok6CsMju1mKiqm
X-Proofpoint-ORIG-GUID: tUnIfnxCfCzGEZPVU1ok6CsMju1mKiqm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/Imre-Deak/drm-i915-tc-Fix-TypeC-connect-disconnect-sequences/20210922-114722
head:   b4b1e126eb50a8a27bb1348ad13dae05e299a9ac
commit: 295fc54769b7afb65114732f61b1448c3e693011 drm/i915/tc: Fix TypeC PHY connect/disconnect logic on ADL-P
config: x86_64-randconfig-m001-20210927 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/i915/display/intel_ddi.c:4030 intel_ddi_encoder_destroy() warn: variable dereferenced before check 'dig_port' (see line 4022)

vim +/dig_port +4030 drivers/gpu/drm/i915/display/intel_ddi.c

f6bff60e927b2f drivers/gpu/drm/i915/intel_ddi.c         Imre Deak      2018-12-14  4018  static void intel_ddi_encoder_destroy(struct drm_encoder *encoder)
f6bff60e927b2f drivers/gpu/drm/i915/intel_ddi.c         Imre Deak      2018-12-14  4019  {
4a300e65b59b66 drivers/gpu/drm/i915/display/intel_ddi.c Imre Deak      2021-05-26  4020  	struct drm_i915_private *i915 = to_i915(encoder->dev);
b7d02c3a124d9b drivers/gpu/drm/i915/display/intel_ddi.c Ville Syrjälä  2019-12-04  4021  	struct intel_digital_port *dig_port = enc_to_dig_port(to_intel_encoder(encoder));
295fc54769b7af drivers/gpu/drm/i915/display/intel_ddi.c Imre Deak      2021-09-21 @4022  	enum phy phy = intel_port_to_phy(i915, dig_port->base.port);
                                                                                                                                       ^^^^^^^^^^^^^^^^^^^
Dereference.

f6bff60e927b2f drivers/gpu/drm/i915/intel_ddi.c         Imre Deak      2018-12-14  4023  
f6bff60e927b2f drivers/gpu/drm/i915/intel_ddi.c         Imre Deak      2018-12-14  4024  	intel_dp_encoder_flush_work(encoder);
295fc54769b7af drivers/gpu/drm/i915/display/intel_ddi.c Imre Deak      2021-09-21  4025  	if (intel_phy_is_tc(i915, phy))
295fc54769b7af drivers/gpu/drm/i915/display/intel_ddi.c Imre Deak      2021-09-21  4026  		intel_tc_port_flush_work(dig_port);
4a300e65b59b66 drivers/gpu/drm/i915/display/intel_ddi.c Imre Deak      2021-05-26  4027  	intel_display_power_flush_work(i915);
f6bff60e927b2f drivers/gpu/drm/i915/intel_ddi.c         Imre Deak      2018-12-14  4028  
f6bff60e927b2f drivers/gpu/drm/i915/intel_ddi.c         Imre Deak      2018-12-14  4029  	drm_encoder_cleanup(encoder);
a6c6eac947d519 drivers/gpu/drm/i915/display/intel_ddi.c Anshuman Gupta 2021-01-11 @4030  	if (dig_port)
                                                                                                    ^^^^^^^^
Checked too late.

a6c6eac947d519 drivers/gpu/drm/i915/display/intel_ddi.c Anshuman Gupta 2021-01-11  4031  		kfree(dig_port->hdcp_port_data.streams);
f6bff60e927b2f drivers/gpu/drm/i915/intel_ddi.c         Imre Deak      2018-12-14  4032  	kfree(dig_port);
f6bff60e927b2f drivers/gpu/drm/i915/intel_ddi.c         Imre Deak      2018-12-14  4033  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

