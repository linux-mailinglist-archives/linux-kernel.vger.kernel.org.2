Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA28B3ED870
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhHPOCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:02:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36308 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231325AbhHPOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:00:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GDvrFH032288;
        Mon, 16 Aug 2021 14:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tSnNPg+z9bZbh7oL883bxShBNsC2jzhA4FJ8ZSwpjis=;
 b=L0XEl8bKH+Dp2WDToLik20KWrTbr4vXIDMhPNPWxGLsJddYzd+Tx346ix0ChJOIKNFwL
 rzGbTepT9KIJkEl2ak091Fw8ASY8XthEG6tP3hTZG3YhfJA6kSptFTeg8i+CnYSfjRg7
 3atnOQf1CQLQmE120k1gbWpIoS4F39JCX6rzYgGEW+7UxVoD8tLAhTxeQNeinZ2vr4Xi
 V8DzJNC6IAy2qJ+cVqCX/iqGqBqsFwI9Fcg6N1HhpumiWu1mOIjNw3KHNmSXh/wqh2ui
 kcGADEBwUfmuBOEOBY4BhITWbSCQcLr1cpmegBNV0jNR5GlBk3OokAX9rAJ/ePrChS8l 1Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=tSnNPg+z9bZbh7oL883bxShBNsC2jzhA4FJ8ZSwpjis=;
 b=M1XjpdXYd7wfCGfs1eqp3gaOS9AWABIDUkJ+pu5nK+c1+Nzo9vUVn8ETs+lPTepHvuOD
 HLH3SQPS3QF6lRWQHeNvRxHS8EVVvZYE/vnt7DjdgypnZ5MRYuJJ4Bb2bLeigJjv9Naq
 ft2+GfiZwjUj7mCMPpvEhkaS2ZZ1e/KjsBe6Rvj2+JhcjK+ztTqJ0UGzaD1TgkiA1ZrU
 T7Mcn6yz4o4Vu37YvBFxP4Wby0S/fIHMk6nHgeI/iCNUdGLinFCnL/b4M3/Uzyd6rCCW
 y76hogZxhtstmq18Gf505uDnQBXymTipCZcz7XRb1sV7kl+dH9rqwhx3M6Q+L9f7Niq8 BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd1fgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 14:00:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GDsrj5191116;
        Mon, 16 Aug 2021 14:00:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3ae2xx8duv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 14:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1SHs1GufcYv7b29xACzc/NhCX+oiI5cEmaCwperfCmVTUR819QjldIe9SarZlRESYKjC/7Rlk5WUJyxb1OUzZnUQroQoEtazStEhm7qpD/wJTGMUIs5mNZDvYrxpFqZ7JYazh3m4uAwwtHde0gzBhlmZaxk/6hwb1k8Tx8fLOgJeS+QENvpK8b/uAgRCPPuQ8n9yuuesLMBG7nRzTxzntNa1uj2DyuNseFIdDXNgiuQEg5MuGn0zbGwbvbeWi/E6RvmcO/NMbqJ1jmBhVcKyB9klkFZg6X2sb0/LfMdn0xAJ3IsdvBJsn/HR6fhodxCZ6vKMC/bXeC5l++9rmfceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSnNPg+z9bZbh7oL883bxShBNsC2jzhA4FJ8ZSwpjis=;
 b=h5E0PHKAbuG2uPJcjUlESz0VPANe9xA2IouwqdCFCV93E0mqB53GdQ4CLn0mgS95P5rKAhnNXZvc+kovPqI/ThFgrlhV8M0p/4moNFVgzx6KcxvNceO+WPj1fUkPGDVxLfvoHvBhgRESzvEieqon/p7edmgqk7Btg6YAfwbDpx11NV78LY88f6CfGDCt8reTEnTEYuXwOQTQ8Is5uIJu0JL2bZksbrffV7lwhtGPPYvdWkao+4bh/cO/A6bPXyhSRvBMOQX9D4yJDWiPdrKjnsTyWk/6cST9cOGLjqgaNRwuqBqLFpZu1Kmv4nhbVAmDJmJdQ7PbCCiZauvbIY30nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSnNPg+z9bZbh7oL883bxShBNsC2jzhA4FJ8ZSwpjis=;
 b=MX3buF0Gw0IiUrcPlz6K75jDtF+OA8NCoAhYw5UFJO4iEPmbFF133J7eqGsmCa7Von6Lkj5+XWpg3uXZEj3d46VqNBIoduD7Jv/egE7Tn8SlQMpAyfGpQSDm6yJM//oQXs970AfIblg+RBIbEvJxgy+vOZ85Yb4ev2K7h5CilkY=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2319.namprd10.prod.outlook.com
 (2603:10b6:301:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 14:00:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 14:00:02 +0000
Date:   Mon, 16 Aug 2021 16:59:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: drivers/net/dsa/ocelot/felix.c:1329 felix_check_xtr_pkt() error:
 uninitialized symbol 'err'.
Message-ID: <202108162120.F2VGdnZb-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JN2P275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Mon, 16 Aug 2021 13:59:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92db8454-3050-4331-9cdf-08d960be2441
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2319829835509FA48C327B6A8EFD9@MWHPR1001MB2319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZ2/j/sQjtrBMUkxOrksTiWBRAHVxL7RqdgLRrvOIva3Ro0x4lMqMjJcVOQlUC3h6IVsS0qPaEqodzcIY5/pu9/XG8pcLu+riE6gQS30lC7TS/6ebVJ8OL4rMkR2tNJGpDuE+26zi9W/bLrz3LhMBLd87rsVcnR+mMhE6x6f60nwBt4jPG41BLkWzrWnz4EU5ADzsnyoeDAQlcpUioX9YP3e4qfL60ymy4nK1OhcgcUHnWkufg+uio0ikQbo3jjQoKYhVbddLrXDcozhv0TmtjgMZXQQTjhDXWLOYV+V53laQ7c2AgpByusKHh6UllpSwS1INVyiR2b37pbkwCvKQcxChEOmp555e1aZYNNMSIdS+A0d9zYscFxOE4gphS6a05Q5NbqL3A1RXpmdPkzGG6Z363u/GAAhVfV/amR9V7nq9fJ7t/Rd1KV2WUxFGtSdXZgvTWyoBmmOGLDp52wGdtZqSzAjy5potYb3UWswbqOlscZxiC6be90Yvws4/14mfFt0eMjWR8pv62gH5/PKTANRB1xuOmk47eCFa6LjHwfAjXOqlKnN1qsff++6CEHq2biN0JRa+iRWC2Tr17tEVIMAW79BA6dvzfs/OXipOQRjkScUOMwNjsfZLemSRuqqH17dwuXVTJHgWUhSkzag0jwA7aMRvg+MtjIZJzu1hgimxhGR1+IImBo6GXprthMASnr+ZESv0Vo1Ex2phNsktN8717E+Ub3HGCT8Yngd5gc1/AuijIjZbMYT3MxTD2aTC0DU+4lM2fdtDdNUqwTaOOtafo68tSsbwBStQjiPapfe2fGOnGWrlI3ujuupCgI4MGpJlGfQ8UQ5u7niBDFCJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(956004)(6486002)(6916009)(508600001)(186003)(38350700002)(66556008)(9686003)(66946007)(66476007)(4326008)(38100700002)(316002)(36756003)(5660300002)(1076003)(6666004)(26005)(8936002)(2906002)(6496006)(8676002)(966005)(83380400001)(52116002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GewDO94w1sNREGN0WMW5TqVyf1c5zQWS66oxsSDcapXXspGhcUIg6X3gXtxv?=
 =?us-ascii?Q?v1P8mXLVkzZb1uLmVRWaumgf1tJAa8wenEWOMy74Lw+FTpnten4SPhLtr6ja?=
 =?us-ascii?Q?zckyEDvWWlHuvvHv/P30c64VhRNNu8NcRd0j4UJq75yZO8aWJvcbGzPeS7KH?=
 =?us-ascii?Q?BZUoY3HwI9sY7an0yIBZIhJN2jHYjJaI5lrAe0J1tKUM8Z5oY/LkPw+kHeoJ?=
 =?us-ascii?Q?mjdfPoCWi1WhBx6Fneg2HYnvt9GK6zaHewuq0RUpF2RuDL4dTIhyEbL/ZXdF?=
 =?us-ascii?Q?QfT8/fbJoMI579DzNxHFUOrEvyqN34jmqNRE3QKwZv6sffhiiHKRTg+spM1A?=
 =?us-ascii?Q?VyUGgDO8ljme1fq+DFemZ2j+KQx2IEUqi7k8/4AF/iJ3SYfvL5nde9p0nmWA?=
 =?us-ascii?Q?ObYpizLTABf87+K8QzAlszditctwhu4dx6KdQd44wnumC0Qi8gHPO07fIHSF?=
 =?us-ascii?Q?PHyucsxP66wOfqQcQ+eVXfY/DxSnB+EAffnKWdWt/FeP35juc6eFP0KrBh41?=
 =?us-ascii?Q?zLDVg1l3Y1LZLxAQ5rLejUZ+axjgQKSM8cCa/whQ3ukbIomHPLLd/7D5Pjc+?=
 =?us-ascii?Q?sHTDt5RhpAZ/tKmk/hgcR3CuOANBpEzKTntTHaP71X+K4hKZrL4kK638xy2O?=
 =?us-ascii?Q?lRR8sMKQvglzFDx81Rrj7sMbeYXKGdg6IJQ8/W94D8RM2eN8vHzBVYNJvV2L?=
 =?us-ascii?Q?lVG2bE8VWd13g1Yo2P5LHqtryOcGI1Tt2OA/nsgTvPQgkRgvpXhDogr35Nub?=
 =?us-ascii?Q?oKS9YpfJR24i3mdzUr5luCJV4JppmIuEfuLmFlT8kaAn0aTdN4Z8SrBaj2MM?=
 =?us-ascii?Q?5qzuePk9UR2brbCxHUJsKeRne/Xoh7Dv1lk/cv+NoPz11/qn3Mmx4qoCiXIV?=
 =?us-ascii?Q?GxnY+Xdl1iac/ef1ktjKbT47UFSN4B2nTIKzQxfCmio73uU+TzQhC4SGf7B9?=
 =?us-ascii?Q?IRoZhi+sEVnaZnqBRdlHfsSaGISNgMrp/SkReHR0bF5egAJov4Ly4PWg4WJT?=
 =?us-ascii?Q?783sckM5krqVWE1LXlVtgP/wYV73ZhNNBvz5apnjLP4I7lQZ6XOUro+/u19D?=
 =?us-ascii?Q?aFo7aQYF83oTwkCMKuKznYKXJ0CPlybja8ypVoWf+o3MN9LoMf/LlkH0yWTR?=
 =?us-ascii?Q?vLzPJxXrvWcaTTNxuaXL6zsgWbjxF8Xt2pW8TXTbcyMZhagOM1ddgMpnBdlj?=
 =?us-ascii?Q?cdAYKaURkMnk8SmI3vwY5JKbcRYGCLi1D/9NKwVzsh6EAhurliEPbdPpUC1+?=
 =?us-ascii?Q?ORoZQPijli6c41a6idswu2UvFEoxfxKqIQwm0jzau/km0ZHgfjkwRvIpyMfV?=
 =?us-ascii?Q?zij6R40KxqxJ+LPRQrgOSDmZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92db8454-3050-4331-9cdf-08d960be2441
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 14:00:02.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhDxbyOGOJaHyMbYWBsV4MumMAMytKfcXGpfba9ng+9t7P9XYQtYh9DCC9bllYpOoQNg3SjqQCS9WVK/kKyvqXuxPgT/YMyIi9wcs8cR2kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2319
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10077 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160088
X-Proofpoint-ORIG-GUID: dNI1LGXXgbkj6ZpkZKt5aPtX9B5t-P9w
X-Proofpoint-GUID: dNI1LGXXgbkj6ZpkZKt5aPtX9B5t-P9w
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c60610d476766e128cc4284bb6349732cbd6606
commit: 0a6f17c6ae2116809a7b7eb6dd3eab59ef5460ef net: dsa: tag_ocelot_8021q: add support for PTP timestamping
config: ia64-randconfig-m031-20210816 (attached as .config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/dsa/ocelot/felix.c:1329 felix_check_xtr_pkt() error: uninitialized symbol 'err'.

vim +/err +1329 drivers/net/dsa/ocelot/felix.c

0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1286  static bool felix_check_xtr_pkt(struct ocelot *ocelot, unsigned int ptp_type)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1287  {
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1288  	struct felix *felix = ocelot_to_felix(ocelot);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1289  	int err, grp = 0;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1290  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1291  	if (felix->tag_proto != DSA_TAG_PROTO_OCELOT_8021Q)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1292  		return false;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1293  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1294  	if (!felix->info->quirk_no_xtr_irq)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1295  		return false;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1296  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1297  	if (ptp_type == PTP_CLASS_NONE)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1298  		return false;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1299  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1300  	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {

Smatch is complaining that this condition could be false on the first
iteration through the loop.

0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1301  		struct sk_buff *skb;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1302  		unsigned int type;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1303  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1304  		err = ocelot_xtr_poll_frame(ocelot, grp, &skb);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1305  		if (err)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1306  			goto out;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1307  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1308  		/* We trap to the CPU port module all PTP frames, but
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1309  		 * felix_rxtstamp() only gets called for event frames.
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1310  		 * So we need to avoid sending duplicate general
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1311  		 * message frames by running a second BPF classifier
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1312  		 * here and dropping those.
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1313  		 */
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1314  		__skb_push(skb, ETH_HLEN);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1315  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1316  		type = ptp_classify_raw(skb);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1317  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1318  		__skb_pull(skb, ETH_HLEN);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1319  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1320  		if (type == PTP_CLASS_NONE) {
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1321  			kfree_skb(skb);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1322  			continue;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1323  		}
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1324  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1325  		netif_rx(skb);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1326  	}
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1327  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1328  out:
0a6f17c6ae2116 Vladimir Oltean 2021-02-14 @1329  	if (err < 0)
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1330  		ocelot_drain_cpu_queue(ocelot, 0);
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1331  
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1332  	return true;
0a6f17c6ae2116 Vladimir Oltean 2021-02-14  1333  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

