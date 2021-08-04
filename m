Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCC3DFFEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbhHDLGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:06:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44120 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhHDLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:06:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174B25W9030392;
        Wed, 4 Aug 2021 11:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=pZK30FTZvvdjCfqmBdt3u/AwNuljBxgeI1qKfWd76dw=;
 b=HfJCGhO17v8r945Xrkt1D2bGPEZo8qV+w+0d57FCnJUUZr5NR8SW8mGdmilTp9hFFN9X
 DvHYiQBCFFZQGPSly5DEPcLmVfzcOX1YXIHhLudqYPq42L0wu75q9CzN/kwzNRvZ6HBF
 Y1kaQbmSmYPPduG+TeA1i1M/nD5Ei25QjScsZ3sgl47Li9nlyPFZFspovYEzbRzrGyIy
 IAFH+XxtcPnRlhBIPrhLaZhdT2VJXdrdMnaVZNI450+o1EI06uzEPCDdVlFg1bB6jar6
 VbqJsFajOZ5gOzKCfTGz7IZqN/K7xecl2GIMzp+LP8lZvflJXjVIydy/g2M5fapxsdhA ug== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=pZK30FTZvvdjCfqmBdt3u/AwNuljBxgeI1qKfWd76dw=;
 b=Eu8Nrx+ULAcP18PrcmTSr+k07o/XmhAu19N6UNwjk7tqaEbDlsJrq9RsIi3lOlBxyMmt
 oE4ZuHXdeyAByzhbcwJJKyNEhE28SNHsIobxULO99BzOKVYkkW6DqDdc2yO7h2TsV9oA
 CC0MqqeNr1V34uCPUyB2ADkP1+g0NsjY2/yzoIQQNByFnbRhY6+ocEtPBo4MQkt7ZoEM
 TIX4tk+96Jlk0fZD1fAatDuWFAO9XKuUtMS9lO+bQDALWy0B9OnXSP1Lmk83pM/tXN6E
 xO8fOFrsUmEfzljiDh+6kaWS7mdCpxvk3OujYrhy9x+qjaWE5LdbmWsTlES+fr2lCBFs Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a70pjugve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 11:06:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174B5wZM019276;
        Wed, 4 Aug 2021 11:06:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3a7r47mkam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 11:06:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aijK86se+LrrcRt1HaFhbWMjNZsXe34U1ucreSy7zWGQL38cfWHL5y8XFJ1XijBuQIcxqURYvb36+1FnAk7TB3DGxpE3gJH80beeT3vV/UpFWrByeIZxIsgafAlS/dJQho/kv/s0pRNeRhoQE/zvO1YPQL721Y07gifOq0dyXuQoGPrmKRD3gPZgqhyLfPEo4GF7SMxQIPZ2R0Br37UcgqR46l4UmsNsr/ysikZMie8z1mXcMVzUow2Ujl3phySEvdmvFEf/hu6+atjXElL6o2PjNrLzBiW7YP455S1N2LTbJgSYnZSB4CWrNOXq5FoJfDSdQJ00ZUBZgKe5h0I0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZK30FTZvvdjCfqmBdt3u/AwNuljBxgeI1qKfWd76dw=;
 b=D7DyigQSruXA5s5DihW43wpEYELxgCu+gaFEvQu1QOP2YCSpTFCfoR+qDhOGdfCindheBFGgKl6VMgxb1sM45pLdocgu72Ho8DyuunwMQXP5d4GfmhU4/CBUMoapYaTZS9ZrW3VFiQS7/881UYXP5ppN0z1zftjPMeutaUDmSCj1U4gdYpoih0DtwA6/CNU4247DCZ8EvBGN9vepSpIGwWs5YB/ZcoiMqwrHO8Gub0UH+9PikinSwn3mcnliKNtrk75BvFBkZWkOyxxMTjbGEllOTvUYLBSWTHH1jGYEvKs/TMrAXMvm/ElCITNcB8LiaXQKAMTqnpYCMo3NC6+g6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZK30FTZvvdjCfqmBdt3u/AwNuljBxgeI1qKfWd76dw=;
 b=cqYMjmVq/tdsE2PVBt8grKAnhupT/ts7gVOttOmIZz2HA2REgKtCwCKojPHWKMXSwQohnkdS4l/v1zlSbbc5UvLe9ezBPU7otuXrAo/sSpeLksWKoAVtTRVqyGNg0yaP3n9v+HEs5zfwK22zbJlPjBUIVUHW/YJeUwNX+cu7Ft8=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1775.namprd10.prod.outlook.com
 (2603:10b6:301:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Wed, 4 Aug
 2021 11:06:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 11:06:18 +0000
Date:   Wed, 4 Aug 2021 14:05:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Allison Henderson <allison.henderson@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [allisonhenderson-xfs_work:delayed_attrs_v22_extended 32/32]
 fs/xfs/xfs_ioctl.c:1834 xfs_ioc_get_parent_pointer() warn: maybe return
 -EFAULT instead of the bytes remaining?
Message-ID: <202108010926.A5KQJjiK-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Wed, 4 Aug 2021 11:06:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc4fd318-1997-4ab5-ad8f-08d95737e284
X-MS-TrafficTypeDiagnostic: MWHPR10MB1775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB17751253F00BAB7A9F4A12068EF19@MWHPR10MB1775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9lr8a0xq2EVA7mYqov3wBPv3lXA+cyWutew/cop88Z9Nz16IIvkbaLa+wY/O+K6OgM2Qfu+A4KRbwwe4nWlP4egy0v7tAfdAu0hihTb96XMdPxNxf3g9lTX01Un9N/IjiM7+iYgBb0gvdrLJr481BboYbmIQIzOOlbbbnypDijwuPF6uj/XBHNNg8+x7MsVtL6CRffLZWcERBa4fi+MLBKI25U8qdwrFLB4fhrzTykx2fTd7NLnsjBhmC6Rx4SCLtNYiGkNWLOCA6MJv7hGEcbruZVUCY1piolyx5MvdqTCSUfP1l8xtT3v6mcCuGoD8WTxmzmybcIBpluwKGIkNxu+RLHbzeq2Xm3gCh21FCROMVDvXs9Jg5JllwyeBy2ThDmE3cJXFSpmrJudEdy9iWxULq/H5AhoFxbn8hIMxj9L+iEyQGVnTDRFni/0f4Pk8pkGdc+KQIARutai65yc6RhlsZ7oSvbQbkcboyVea814yZiYy/NpOfXJ6HMxjXNUIRvDn3Sf9e5BaTEO+9HrH9q7ZoxK+gEvV+IOotYtzAeSzgYsHCMUGYIvNRB/131e5xoJe2MJy9E9DMGnRViHdaJL8tOxFTmGb9sP1D+4n9XWuxB26EtMpMTtmNxGX0lxEil6EQYYzkf7QOXGOGD3BOxKqXLWjYRPCfNnWrDBhjW6hWOE/p1Kzz2KWKRk2vnjD8jQ+1QVHSTv2lVCU3rEmiN3v/UJEkOjdjQBM0A7P1YJU9k4kHqVlLMfaX8iJkWsw0Ju52APcA2quuKmzHbi1owphlno5JKSH8TAj6rEs2Sxsqq/XHOY5Y2zrohWqlUc2+mkK/fjhNFQy6xrpuL/2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(66556008)(36756003)(66946007)(66476007)(86362001)(83380400001)(508600001)(6636002)(6666004)(8676002)(5660300002)(4326008)(6862004)(52116002)(6496006)(44832011)(38350700002)(38100700002)(2906002)(316002)(186003)(8936002)(956004)(9686003)(1076003)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TrmdPgVjGZFcsWSzQGohISuXeUt0x3vAcuUf/5B9VNEUFJRMh+/9RFV+SNvp?=
 =?us-ascii?Q?6zK/9FvuDk1mpFjeoQxG9FSZ5lquYtJN8JJnw0q/dha6qkbbMwOqetgZP66Z?=
 =?us-ascii?Q?XX0OGg0dINaW4sHSE7DdfUk8/oHxagb6qtbYYRtphfDFlEHeFQWXVUZZjwuq?=
 =?us-ascii?Q?wjPHCfhhhGmpTJjuLs/xttEj16JnJ2tjYJV5ScPBaMzEd7fwbbGmdLp5RWaY?=
 =?us-ascii?Q?WRdyvtYcp3I/b4Ll2tkyRCWGfgOjnZ+y1fRYTDniQICyfI5tu6lZMyjVb46W?=
 =?us-ascii?Q?GwSjZvlLARVh2wQOGcdthppuQKpUNpJgKrJhPtpRracPPSKnzb6OiMipGox0?=
 =?us-ascii?Q?DMkv8JhSraRlFOPLqKN5N1G0l0I/uz8i7i0gn5gwJl6WL6NQsA/kxaY3CxZs?=
 =?us-ascii?Q?d6xvAAGGLoRH5Kn3lA59NbXL8dzdxPZv/42gxYX9XzxaBhC0uVKSgIqJIyY7?=
 =?us-ascii?Q?4ICA1TwbDNQjaB25XQszXU5Os6ZHeqZzmBuOsE/mR5Gan1PCfJaDcFVNIqAJ?=
 =?us-ascii?Q?7VM2KowSHYf9ABrc04Z9QxuRnOnyIqAe5xHoj3BTdbiWK4RIzm42GtSZ5+ZJ?=
 =?us-ascii?Q?NvmYiP1HFRkBWJe6tU9vSgenkq/cvbU8wsScKhn24W4Rhud7zf9PUb+Lj+E7?=
 =?us-ascii?Q?BIgBn0vcxFbCjk9UzYsDK8H59Y9zmSbGmycCCpeYUB+t7HFAXlXJidi2yYlH?=
 =?us-ascii?Q?EgQKYN60yWI8BeRJpxkvVXn+t5/TmSISpL+PZrndp4mqZeZ2FI/htPiQIsRe?=
 =?us-ascii?Q?YWsCKDq7U8CBALyIWYd4xzPu3++6tQLMp4Xi3kysC9qBPlsu37AZqYQdCzzG?=
 =?us-ascii?Q?B7dgmzbmd8VncSKZtGanXsJSq2BElR7jGI+TYsUDqxEtBIIdRzTRJvXpzmbG?=
 =?us-ascii?Q?2+YUOSMjRwYLFbXrDSKHELgpsQ0/b1rgcpvHqCNgIPLnrX12dUY7P+DtUTHc?=
 =?us-ascii?Q?MKbvxByBs/r95IH43YaxdU50Tg7PpsEnW5c3xre1iw+WJLVaj9WpvHau+dn3?=
 =?us-ascii?Q?+mvnvU0R+vikr9o+Jrmtvap5JiBhQ16KEIdexVvya2TzDZAUFuQeeq8YQ+YH?=
 =?us-ascii?Q?Ge9dRbqj97T1AeAlx85IijRsgY+SPVwM1XiNw+d96T5e4Grkonz9PhzfGj/C?=
 =?us-ascii?Q?h+fXsnc+PzNrnN812TSN4zSm420RN5523dZ7FkUFoBvxVJXm00ukI1YnRjgZ?=
 =?us-ascii?Q?Rm51mA9gqgLBcZblgx+RpQRnRGLNU3NNLp04t1aTSlzpSUmw/imhlH9bR4TR?=
 =?us-ascii?Q?9U24HTYXWNjuSqcOwc1R9Oq2urdDoGcy+tkXxvdc6y5ubYWrMdkDkxAhrkBK?=
 =?us-ascii?Q?E5AY7daN+tHVd9srYaw9P4SF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4fd318-1997-4ab5-ad8f-08d95737e284
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 11:06:18.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuPamKhHL/Y2MHBBIPvWLqjXwavtfHLvbUUSJdKtywRmLXH5jGDcxkkoKgDCmMUpWDto52+IYMSWeFz/L2zroUhBc2Ggmr3nWI7fV4Qv9Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1775
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040057
X-Proofpoint-GUID: XLKteNZpoqG030y3GYVltWfmSAxBdFeI
X-Proofpoint-ORIG-GUID: XLKteNZpoqG030y3GYVltWfmSAxBdFeI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v22_extended
head:   aff89515c2d9aca9b24ac0296f3806af62cd9206
commit: aff89515c2d9aca9b24ac0296f3806af62cd9206 [32/32] xfs: Add parent pointer ioctl
config: microblaze-randconfig-m031-20210730 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/xfs/xfs_ioctl.c:1834 xfs_ioc_get_parent_pointer() warn: maybe return -EFAULT instead of the bytes remaining?

vim +1834 fs/xfs/xfs_ioctl.c

aff89515c2d9aca Allison Henderson 2021-07-23  1817  	if (ip->i_ino == mp->m_sb.sb_rootino)
aff89515c2d9aca Allison Henderson 2021-07-23  1818  		ppi->pi_flags |= XFS_PPTR_OFLAG_ROOT;
aff89515c2d9aca Allison Henderson 2021-07-23  1819  
aff89515c2d9aca Allison Henderson 2021-07-23  1820  	/* Get the parent pointers */
aff89515c2d9aca Allison Henderson 2021-07-23  1821  	error = xfs_attr_get_parent_pointer(ip, ppi);
aff89515c2d9aca Allison Henderson 2021-07-23  1822  
aff89515c2d9aca Allison Henderson 2021-07-23  1823  	if (error)
aff89515c2d9aca Allison Henderson 2021-07-23  1824  		goto out;
aff89515c2d9aca Allison Henderson 2021-07-23  1825  
aff89515c2d9aca Allison Henderson 2021-07-23  1826  	/* Copy the parent pointers back to the user */
aff89515c2d9aca Allison Henderson 2021-07-23  1827  	error = copy_to_user(arg, ppi,
aff89515c2d9aca Allison Henderson 2021-07-23  1828  			XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size));
aff89515c2d9aca Allison Henderson 2021-07-23  1829  	if (error)
aff89515c2d9aca Allison Henderson 2021-07-23  1830  		goto out;

This needs to be:

	if (copy_to_user(arg, ppi, XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size))) {
		error = -EFAULT;
		goto out;
	}

aff89515c2d9aca Allison Henderson 2021-07-23  1831  
aff89515c2d9aca Allison Henderson 2021-07-23  1832  out:
aff89515c2d9aca Allison Henderson 2021-07-23  1833  	kmem_free(ppi);
aff89515c2d9aca Allison Henderson 2021-07-23 @1834  	return error;
aff89515c2d9aca Allison Henderson 2021-07-23  1835  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

