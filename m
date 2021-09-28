Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6941A8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhI1G0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:26:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37798 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239160AbhI1GZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:25:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S5RLwq003183;
        Tue, 28 Sep 2021 06:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=RIt36qqrpVtFku7zgqNKkR4c+TUnzvDB9NpoWt1k7hE=;
 b=lEx+RC048wihPshtSJcfOgvrmyTO0pATRlS9h2j0+83OEFYo0hNEQDyVa2ptwbocYEUT
 ojbl+z/Vmj5ozZG31L9+joj/1jG/gn6unTFuVOh+N6/HwDt0sCHxHn1dcJwKJHp06GBn
 blawLO8TGeFy/+T3Xn3cGQambG9aHFAmP5HsbtcFi3NUy2mBifMAAok7eepzf8ZeWzeB
 X9LDU5UkfzsbXS4AOFPmu9nVLrv2MF/ylJJfecFw5wNFhH0eBKGD2KFIdXcWwRmmWhoo
 3JOkEmzpFzqSyRZUj2I73lYSJSGwVLjDedXg1AvILlwiMMFRNLG6vJ0WnZfSSLOPjDPM PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbejeemrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 06:24:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18S6AOqm129594;
        Tue, 28 Sep 2021 06:24:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3badhs6019-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 06:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPUCSu6M2vj7EU0KhY8mp6n2b3BEILagbPwAv9oKYZn/qecmkNp3DWotWUTs4BCAK85FlXWJxrHYBZDIdFcpxztWNUJkFPvJbsSz0Xl1n4YkjPtqL31Y9N3WuBmOJP7JXo/ggLbfEp59yeJKGjjqIcMTVOy326BprZU9LCGPqZHhxYVFAR5Kq/k4PuCSI6rL6q0dC3vanMLSrLcjHvc5NSXovJv1cIjMpG3+PpSoKio2Su670aaKvOy2lPa+9/Gu5pf+zIlbLjXTaqnO+LDo02LJGnAjnSczriwWZpx0972UtE/D/1CG9BTLRGPRq1nYdTx++IRuNuA2w5bm228rpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RIt36qqrpVtFku7zgqNKkR4c+TUnzvDB9NpoWt1k7hE=;
 b=NWZeJ7f5kPG0BHALeE4pLe+jXNh7IpmZKMk9tDvw4gg7iEpu4a0elOLOaXpo0p+eYayBCxsHuIGKX38SneX4xqoV2i2niDa+8r/7TdSIKHTSLk0fzEnoeEi2j504TMx8X+tc5sAORTRxdce77UD7HB3DCZQjfVMLGXq/gje3XNcjpKUiYwgMs4Z6Hv3Tf02E+CRbWnwQoRhWBCnJXMqEpCKsi3fCFLAzytXXs/Mp3ASIE1wHkQqouJ7tabNivd3pJKKHCVbxvKmPW1R6LHHFAlliL4CzkZyUvTe1q5jqT3IYFDL3T/hMCGC2V1ZkQ+vhk4D5aRO7ntjxTjDJANubZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIt36qqrpVtFku7zgqNKkR4c+TUnzvDB9NpoWt1k7hE=;
 b=i/zeCeVF9jl5m4bBFQrJXSuwMOCj6xZs17Op5veowXyMzOv4u3Dn9fwWs1DtnxeXpqdykw6yGubShwR3tyUL3KON08y5k4RwvMP4AeBIdWulc5Ft/6diiSrHNhGEo2U73o08e3WDPLwTg5fvnUT+/KNG9+faMt2tjBdBz+JqV6A=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5555.namprd10.prod.outlook.com
 (2603:10b6:303:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 06:24:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 06:24:04 +0000
Date:   Tue, 28 Sep 2021 09:23:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: drivers/gpu/drm/i915/gvt/scheduler.c:646 prepare_shadow_wa_ctx()
 warn: inconsistent returns 'wa_ctx->indirect_ctx.obj->base.resv'.
Message-ID: <202109280539.c3pVHuGH-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 06:24:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 578efa27-22a9-4b36-8eb3-08d9824891a1
X-MS-TrafficTypeDiagnostic: CO6PR10MB5555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB555525F02056DF9F0612A3E68EA89@CO6PR10MB5555.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3R3g0I1ZIjcGAdvmGL65UDh1zcCP/dvVpxmqKwDaea6l2YVclsy+QT0SPOawYEcn4BsGpdgykvaARpkfQAwulfSRBjvMpbutixA62nK6xLn/yZ++Pyx+h8mS+m5+MSeyaGjwsygtz4A8HuSBGy/e8LDDi+VAzZ9wTxjUSauZPtulJt2tuFKQLjdhs2akcME59d5CnKP8ZNdOCJ+VKdhMLdJjHgVO1vev14As/X7RNbCcVCp+db3cBkWUSlarvFFqbRheCsq3C04l6B7Io5bOSfuktjz7oAT3q6oR/QNt7i3h2bKlfy+cCsSi8ZEqrOixoQz4XxFNNOJebUoPa8DLH8Fp7vguaHsEUqrNE/oRcwRhL3Vjs/7Y9LzwklorQK4ULvg1SVEjJ8m0FJqEg1PTMVPufQMS4Jn8aFGZUXOcCJ9AV+D9LKJBF4Lma1W/29KsRKEa6RQpv1ciRXw1rmWSGwcEVtghZVaiqQAMMuTANfvdAqMBIAjJ3XJCP7lTgj3UPrhduMwVBxLWxp78PMettnDkTAD6ycrMp3tOlm5aqmbt5xe7t7fIX54apAK2E1zhfRWWrq3KSIxhoVqM9muduEsPUGl3jokqJLOMklNsVceVzumU9zaLZ9G3nJz24GayVxZcDA105Ur6/pCn2gf0vTurXS4rDFOmyPLAoO4QsEBPaSyG3loZMJ/Wjog31/gasZlYy8SHl+Qd0lutQuBWul7XedK5AX+ubwDKy62g1uNVnhL8XeM5xXu91IiH+z4sFzEq0KhucpEpFF0nld4DU3NRC3cnIp1jUbJQ7CDXwsOYuz7H5ktZO37e6mjzTs/S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(186003)(966005)(508600001)(38100700002)(38350700002)(86362001)(6486002)(26005)(2906002)(44832011)(5660300002)(6496006)(52116002)(8936002)(6916009)(1076003)(8676002)(6666004)(9686003)(316002)(83380400001)(66556008)(66476007)(66946007)(36756003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rbm7hTvkcPdDS0LW51O2OS359RAe4OlEzHLoDIr4/4qyPUM/tpOLV5/2dMe8?=
 =?us-ascii?Q?dGfscDHVcxmWG5MezjMgn23LatgRin4behoY+sBdotAiDRmEFBrReG5QUOpg?=
 =?us-ascii?Q?xcQ9Vr3svfnGM1cHPBUPOuwQidr/ZcA8DiGQMGFadMnuWgFeX+4v+w/RnUO0?=
 =?us-ascii?Q?dnX9GQzcmOba2v+VqDFT86gUqmjyg6g3WxuQqg8qOMPjUesjlpywDfaYJCIj?=
 =?us-ascii?Q?+sLogQINBY/N7TEUTpMZrOMTGMpUv45J9YiFXpICibuM+SiWJEQXSTDtVhcn?=
 =?us-ascii?Q?B7447HmpiayLGbdE1slL2kDgs24x8serpNgZOkQ+OHUZF7l4OudKQ9+jtHl0?=
 =?us-ascii?Q?j8COYS+v/60jScKShblVMXxaGmYLXmlzZg7mg4jdf4jj8GZViKaEKiPIPW0k?=
 =?us-ascii?Q?R/yPf7McMh78wuRQ48Ur8Ci1TYDODhR2KTwCCCbjZLqn4X/xeOQYPRF6FlA6?=
 =?us-ascii?Q?DvJA3jQVlDGF+DO1XDCK6rDaWnL8v3gaUkJHE2D1X1TAx4FdpVXJ5UxzWBlH?=
 =?us-ascii?Q?U9VwiocuERV/mNdQUkyaDCIno7wrvNGih85u3MDzCzQEZsCl0UV1CwL2WuSj?=
 =?us-ascii?Q?Od0R7t0YyoUFG6GGk/0YYOgEtG9evImEtRGK58UTQxhJ2P1u1sh4TmNsXoJ3?=
 =?us-ascii?Q?Zq1hyxz5l4P+0pSoKaHS74NVcKz3QvPBKkopGR0Sp+0Vz/AIck12HrS6ywZ4?=
 =?us-ascii?Q?m83ldNTyF+mQAIqraDdQ8s2drxNuCRunAyMvzfGCaDkEHeDVjs+VTbC+S07Z?=
 =?us-ascii?Q?BvlcnuibHfx29MT7Ny0VJPW8vBe+aZ7BWu+fspkSK+n/Mv/G/wub2Z0q27Tc?=
 =?us-ascii?Q?Oe5g/WO9e3E8KWnHsIX2+6VKt+jeiRymcQwnGGx8X6ZW0UTOFjduWhbM5SHS?=
 =?us-ascii?Q?wqj8Jh41dcn9MQ8HxTO2YmbSRlc0kia/iiaVOzSjNPaXcdlG4DF/eBUUfC3D?=
 =?us-ascii?Q?G2h9mJWl+Bcpk3KIh9Uoskytu6WfBF/8MBIcwNvU4dq05a1PTRIVkaCctye3?=
 =?us-ascii?Q?8dSgQXX5gO0T1GX3il7ddoow7QOn1M7/C/7auzvXQIhs21dD37o3nwtStxWH?=
 =?us-ascii?Q?iJJOL+sWuhOENAlhRnMpiyGf8Mtpcpm+ohBpcRv5pjnYngx9MpXtFmiLNRdm?=
 =?us-ascii?Q?GVLck5oHO0aKEUuTiesKm5+/Kv0RSpsJ0nFI0YuwqZMVMhm8QC4FTsn9s0Iu?=
 =?us-ascii?Q?9AU7qeMDu/ak02csz7KdmYKjBAYIYHhRSj9tXW8JJPFS+kRr7/yEcjduK9uV?=
 =?us-ascii?Q?zhtg3cgf+9jGuHzUFxcUiqxUroc/Ae8369PQrx/w5gSyCGrT4HkAx1s3lTn/?=
 =?us-ascii?Q?g7cDzYgZa3DUBQT4IyZSYggU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578efa27-22a9-4b36-8eb3-08d9824891a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 06:24:04.3965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDwVzFKsd3221gA7O/S3jb92pH7rMOw4cvPpPphvrocFC6fPgHk4xZiZIF6jkXy3QjvQfV66kMKNkA5ZaMiKV7SZMjXgQ0TE0+TaOxHdWHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280035
X-Proofpoint-GUID: h6GPOJ67ItJFGbEzDRK8OmotVgjsDHBv
X-Proofpoint-ORIG-GUID: h6GPOJ67ItJFGbEzDRK8OmotVgjsDHBv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92477dd1faa650e50bd3bb35a6c0b8d09198cc35
commit: 67f1120381df022a7016f4acc8d4880da9a66c03 drm/i915/gvt: Introduce per object locking in GVT scheduler.
config: x86_64-randconfig-m001-20210927 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/i915/gvt/scheduler.c:646 prepare_shadow_wa_ctx() warn: inconsistent returns 'wa_ctx->indirect_ctx.obj->base.resv'.

vim +646 drivers/gpu/drm/i915/gvt/scheduler.c

d8235b5e55845d Zhi Wang 2017-09-12  605  static int prepare_shadow_wa_ctx(struct intel_shadow_wa_ctx *wa_ctx)
d8235b5e55845d Zhi Wang 2017-09-12  606  {
d8235b5e55845d Zhi Wang 2017-09-12  607  	struct i915_vma *vma;
d8235b5e55845d Zhi Wang 2017-09-12  608  	unsigned char *per_ctx_va =
d8235b5e55845d Zhi Wang 2017-09-12  609  		(unsigned char *)wa_ctx->indirect_ctx.shadow_va +
d8235b5e55845d Zhi Wang 2017-09-12  610  		wa_ctx->indirect_ctx.size;
67f1120381df02 Zhi Wang 2021-01-10  611  	struct i915_gem_ww_ctx ww;
67f1120381df02 Zhi Wang 2021-01-10  612  	int ret;
d8235b5e55845d Zhi Wang 2017-09-12  613  
d8235b5e55845d Zhi Wang 2017-09-12  614  	if (wa_ctx->indirect_ctx.size == 0)
d8235b5e55845d Zhi Wang 2017-09-12  615  		return 0;
d8235b5e55845d Zhi Wang 2017-09-12  616  
67f1120381df02 Zhi Wang 2021-01-10  617  	i915_gem_ww_ctx_init(&ww, false);
67f1120381df02 Zhi Wang 2021-01-10  618  retry:
67f1120381df02 Zhi Wang 2021-01-10  619  	i915_gem_object_lock(wa_ctx->indirect_ctx.obj, &ww);
67f1120381df02 Zhi Wang 2021-01-10  620  
67f1120381df02 Zhi Wang 2021-01-10  621  	vma = i915_gem_object_ggtt_pin_ww(wa_ctx->indirect_ctx.obj, &ww, NULL,
d8235b5e55845d Zhi Wang 2017-09-12  622  					  0, CACHELINE_BYTES, 0);
67f1120381df02 Zhi Wang 2021-01-10  623  	if (IS_ERR(vma)) {
67f1120381df02 Zhi Wang 2021-01-10  624  		ret = PTR_ERR(vma);
67f1120381df02 Zhi Wang 2021-01-10  625  		if (ret == -EDEADLK) {
67f1120381df02 Zhi Wang 2021-01-10  626  			ret = i915_gem_ww_ctx_backoff(&ww);
67f1120381df02 Zhi Wang 2021-01-10  627  			if (!ret)
67f1120381df02 Zhi Wang 2021-01-10  628  				goto retry;

Does this path result in a double lock?  (I haven't looked carefully).

67f1120381df02 Zhi Wang 2021-01-10  629  		}
67f1120381df02 Zhi Wang 2021-01-10  630  		return ret;

Call i915_gem_object_unlock() before returning.

67f1120381df02 Zhi Wang 2021-01-10  631  	}
67f1120381df02 Zhi Wang 2021-01-10  632  
67f1120381df02 Zhi Wang 2021-01-10  633  	i915_gem_object_unlock(wa_ctx->indirect_ctx.obj);
d8235b5e55845d Zhi Wang 2017-09-12  634  
d8235b5e55845d Zhi Wang 2017-09-12  635  	/* FIXME: we are not tracking our pinned VMA leaving it
d8235b5e55845d Zhi Wang 2017-09-12  636  	 * up to the core to fix up the stray pin_count upon
d8235b5e55845d Zhi Wang 2017-09-12  637  	 * free.
d8235b5e55845d Zhi Wang 2017-09-12  638  	 */
d8235b5e55845d Zhi Wang 2017-09-12  639  
d8235b5e55845d Zhi Wang 2017-09-12  640  	wa_ctx->indirect_ctx.shadow_gma = i915_ggtt_offset(vma);
d8235b5e55845d Zhi Wang 2017-09-12  641  
d8235b5e55845d Zhi Wang 2017-09-12  642  	wa_ctx->per_ctx.shadow_gma = *((unsigned int *)per_ctx_va + 1);
d8235b5e55845d Zhi Wang 2017-09-12  643  	memset(per_ctx_va, 0, CACHELINE_BYTES);
d8235b5e55845d Zhi Wang 2017-09-12  644  
d8235b5e55845d Zhi Wang 2017-09-12  645  	update_wa_ctx_2_shadow_ctx(wa_ctx);
d8235b5e55845d Zhi Wang 2017-09-12 @646  	return 0;
d8235b5e55845d Zhi Wang 2017-09-12  647  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

