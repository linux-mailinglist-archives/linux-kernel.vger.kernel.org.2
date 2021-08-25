Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F953F702D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhHYHNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:13:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238771AbhHYHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:13:44 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P51e16000899;
        Wed, 25 Aug 2021 07:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=0N4RMAE/INDTVBcVfBj9D/S1EZVXLFRKmowvegLSK0U=;
 b=MRFmqQM0gV3IXW6hwQPI0RjcdbIP9IDpWxY0HlEGBwgsvHOrttnUYKVL+ezJFR1BXRTZ
 v0vSYpNUsWmkNbkvkmZgW1TvSZFVoLNMnbXQIEc1en+8XkCVLpnzmWD95rD5vxtgsgxI
 th/R95LuUV3SaESpNEnNt7lcujb568Do1X73sugrxNBTL+gwBvR3LBQujHhNyCh4v7n3
 AodlwqM5otrWGgw5RyQxqm9Bji7y2bTUs7NXFSdluwKANzhi4RkPRgyHkcW7vsWtinIw
 behmvWE7zXU6Jhp+c59mp+54DPbEbdc6/ABeTuxUn8145/IvlVOn6SA+z6YqgRK0mliD zA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=0N4RMAE/INDTVBcVfBj9D/S1EZVXLFRKmowvegLSK0U=;
 b=asbuOD9iVduoorVSqn15qT6tajkT7Sfd8BaOUgH52um6X/DkEW7T5zT6XY1lfdLyg3h2
 DgA2SZLWpk0NRZiHuq0ORs55fORPph0HxrWAmPiAEyi6RFvROVVEGxusu8IKTnmXgJfF
 yNbuX5eqyY1w7tUrCd6I2oFEZoQBS3h44mCWwc0FGRRgShmyHI06nlOs9u7KQzTs67et
 8CzOimOO4ymRPk+L96EKCYwti5TZUMbJ3i5ILRSOND00ZA0T8YvKNlkoZNy8TP/I7Cne
 9X9tyufgrxgrYt0SL5CTKKmR+L2uIQ+tJq7asQOUgVMaHS7PTGyrwdP3IEXtpPVe4QRx 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwpdajpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 07:12:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P75bjZ155676;
        Wed, 25 Aug 2021 07:12:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3ajpkytjdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 07:12:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsExZJ0w9y0338akR6mcdr4n2e1FgyVfVMESkVDT8cD1CG5FRl+nfoNKGvboZNsrTlsh/BxMo1uT0XfPBxfoB639zrMXyltcT3xR92Y5+Gz4CwjMNoVtOClvhxFmTxbbHaUyg5BqKqFfWIXiOeOShurIhm/uEkVR0LNufSSyHe2zaxfhwMliW9Ti8uPRoocwwwfwBBIaPBRyGdWFQS9Q7QBGJTqMPV8USBXHmz7mFlGu8N2hVBdMiuQeOF4DyPhWOX1H5cphV8vEbqbRbMXT0O3gw3nVZLqFHkuvKJtSoRoTdNCMzeD9sY8wa6+0tEFZJJguwvsrQR769cSbFxf/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N4RMAE/INDTVBcVfBj9D/S1EZVXLFRKmowvegLSK0U=;
 b=jbi5N+Vq0kFPbP2g39rp1bt99IvwBLNhiE0+NN4yXp+QtSLljBBpXfUWb0MNHRPBwWivcgYd7G3jhAkmQZTVv5VQyq+Xvm0CZW9zjW2qkZOOzyJT0Jl5Cw+Kwwoa9ksqAnwVNg/8CGOWPfL2sdtm9jt+hJwTgvRhW6aEjTDvu9WAQAWq06TnUyCNQJwG92eSrhCVxorARTPFmO3I+YgiSDb8Ym9HKGtx/WS6Wt+bFWQW19yutQRF4M0THVxzxddqw0do1aEdu0Z5Z90KnNfHmQaZa+0S9AkQVh/gn6iVNimbRodYez/5+YE0H2CpRlogtAiBuG9cUcVVzfSQE32HfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N4RMAE/INDTVBcVfBj9D/S1EZVXLFRKmowvegLSK0U=;
 b=SqhyXMDQrsltKq7+jqHgBa++Hlw/vMIzG436mxO2MUUWx92agvFwpeUwBWerEhc/qAJdjFNIZpeNCqg1ZyuONR9t6M21gvMIzI10qEi/7hhFUDs4T3pQu7C1180BSkOsVuiiz1G6ohcqZZJ72zULjiSZFy/jAfJzmOUnS6vCVfY=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5570.namprd10.prod.outlook.com
 (2603:10b6:303:145::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 07:12:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 07:12:51 +0000
Date:   Wed, 25 Aug 2021 10:12:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dan Williams <dan.j.williams@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl-cxl:pending 39/40] drivers/cxl/core/bus.c:501
 devm_cxl_add_decoder() warn: variable dereferenced before check 'cxld' (see
 line 497)
Message-ID: <202108250714.GDy2jUg2-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JN2P275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 07:12:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bab008a-2598-48fa-0b15-08d96797c000
X-MS-TrafficTypeDiagnostic: CO6PR10MB5570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5570C6B561EAFAA5DB7AF0878EC69@CO6PR10MB5570.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0K+yqDq4xHIukfAQDldFfjfdzb+O6J9pL+EwRfeGnN7DYUOK4m5WQYKq9NztUP9aVJ8pfOhK6Ga+KN83q6aZcu8YaP0SZZaCmGIXKos/oOkS0lfVZrrQbj29r39c71olOEXuLUZXktigz01ZSyCBPbBVJCxFPXa2M8nZ5L51xOFFst7/PlfhFMh4iz9lOZ2ZreXaqeuNWAG8M5OgoURioNLfGUe3KQHbQrvR96Tm7+2iGBB9S/3oNjB6+R7ohrx9hIwNmb8SBvlTrunZag/Hh7Cfs3tlpZcAbSZEum2i/InvRpAewbI1OQGCBn6f6dmRPT4FCeplVdNVWRjjkvibjD+n7ymyJJ5QJgDoQivrZFrHJI+DpTNC02BvvafmVSjHzWc9IvjqIG/odgIDIGD2XoSM+gEMLkloYvMaHi6k7h9sOmD0Xe1aGibDN/DrUpt9V6FusbP+HHJ9R1ZHydW3mT44tfM7thIhvMv2199X4U4wYfWeKQA2Pj0EBEspXLTOnypyU/Fk3c9NaPt75NFcoILfzHN8CPmmc+VosyK4Tkv2Zo2L8IwMu6GgXu/CMWAGXOAygqG0Q0Af43cFBsmSWIGJrrDHBD22TonHotgEsvDKTd8iI5ZRoRZ50yxxMfvu0NyRmeS3fF4eLVMv3tauAP/miPqp4oHj38E9EeXNFwgyed5ynrlMojQxXtr4AOAjxtIOkBv5fM+yukLaTw0xpTU59O7QLfZrkiNebqrTvd6qOVFtODeRuPm7vbkjwILfFjCe+J7JGJW+wMKYItyKD5NRn5y3JfkK29bLVQ35rXbbWpPak1/1vhC+7dREeYOFvmlnf1DnYS/PxbQScwgZcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(966005)(6486002)(2906002)(54906003)(66556008)(44832011)(37006003)(1076003)(8676002)(66946007)(66476007)(4326008)(316002)(956004)(6916009)(52116002)(478600001)(38100700002)(38350700002)(36756003)(5660300002)(83380400001)(86362001)(26005)(186003)(6666004)(9686003)(8936002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kEodEGsccvW0r7MMIp8BldX1O/jn4gOB03OqMDcOTFApsVZDAFjNKnIfyFpk?=
 =?us-ascii?Q?ok9gk9OyJvJqHUU8E99g1nP1rX34+9NmAPuO8+1oqxKJkEHekHrkKbfwXnEC?=
 =?us-ascii?Q?qsw+vHxHprVEVBvssvYTdsfI8jJH4EzkLSG+/IPPp5epamxOiI9k8/PmmRNe?=
 =?us-ascii?Q?fmckhHjSTj+ShVY8pwgIBwy/4kiWTNEOuOfDuKIltuoApZJpyZNPipm7jPXe?=
 =?us-ascii?Q?AkEMLiD5k6t8GbIpvkQOB4l2FHvxD0sMCXLhgICGs1ro1nW9kcEbMHMc9B3J?=
 =?us-ascii?Q?vL085lmtLRbNDQSlsYW89zaP2p93T/hg3qkrTGo3i0B+YIfSxQZa0ug/UVxD?=
 =?us-ascii?Q?99Ypags11Yl4Ypb1Moui2HLaKkSwlA3alfxURAT+KhcaOrPoKeVr91DFJw4U?=
 =?us-ascii?Q?LVoBFj4pT2+ERAbGoONpLngfD7wH4s6PVwwT5ZcHjcWtetr5Q870hW0yRsUa?=
 =?us-ascii?Q?xuyicAbfOClHyGgrxkzkPO9vp/iwJFFZ7r8wZPrFL4PN7MYzelv3cIAef12D?=
 =?us-ascii?Q?TTnEMQaAMk0NWX3J3V+QTNP9qpPqB7a3bK4KNE1krplRhGkibmwD6+Bg8bA/?=
 =?us-ascii?Q?3mTfWXPDHwUvqecuTD6yGmCg9C/+aUgRxZNlngNXfGhJV2gFHoatocsz3XIo?=
 =?us-ascii?Q?cnvXspqpd3pscMiiYRXUST4t9drXQ0VHAksmDgBHXFYamgD7rD38GE8xLPeU?=
 =?us-ascii?Q?41mMhP3C7E+Pm4ZbSByFqjRfk9M0rtm0OkYBVYfdP4t9HqZ4niJgjLyRNVSb?=
 =?us-ascii?Q?4xvoGSfMy6I2UmafGvDa/wbQXbmdxSm+omiv0NtykEzQ1j7HBeEGDcVDT661?=
 =?us-ascii?Q?losEeIcI+qg3KcdK1hh/gusq8kxIZjjTY5arBFqRsA2b/aye2IcngvzVdJMe?=
 =?us-ascii?Q?20ioh6pOjy2cLCJxWeermqkmeX2ff3Qk0dHArqtfAQye/VT78G0UB1vvRA9O?=
 =?us-ascii?Q?LuomIuvxjq796fjaKczsE9hgpGwbmVHXlPmBatSdMVHJkjvMpCdmqNtCzCxA?=
 =?us-ascii?Q?ycHD3ZhTnSDD6gGjCnVKbY/yyahyi41XOeLQwatVrXpNE7lH4v1HkVw/r1zZ?=
 =?us-ascii?Q?WwXCUY2bJx7cmly23IfBkJSI97UenrDqvJBna7KaRcWwDYBMekSVsB4xCHCD?=
 =?us-ascii?Q?lUEQfeVax6cUgfykXYNYQSbzF8CeDT4/MrJhsKzQG2lJ9ZQzXbSWO8aJaX1C?=
 =?us-ascii?Q?NIgmGVsZeG3rHmAV+3Qf4uGPaYl1U3C+8IHdMZgL2ww8MvB5h1BTuGn/P6lK?=
 =?us-ascii?Q?CDi3SPkA5oOS59G/pSuHMZlYaT4em4lTdIZ/uNp6m1M8xUktbTk86/QB868r?=
 =?us-ascii?Q?VYSjbJL7jKC6fnU7WUZtvTq5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bab008a-2598-48fa-0b15-08d96797c000
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 07:12:50.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHS8iMXCv+ZvLw8XUgdgvldxg9x1wz845VLYCjTqiKtpoqMC+QftfEDDQ2mm/kSVdsF48McE/2z1LikflzzuyvCRZrJhvY2NFkglu2KrsY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250042
X-Proofpoint-ORIG-GUID: JKl_piLK7ELCHZDZQlt9OIpkUSOZRICu
X-Proofpoint-GUID: JKl_piLK7ELCHZDZQlt9OIpkUSOZRICu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
head:   036a16a39e2fab9bf7279201d04cf7e90993521f
commit: b7ca54b625514464bac2db59b754e95c49b66fb5 [39/40] cxl/core: Split decoder setup into alloc + add
config: x86_64-randconfig-m001-20210824 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/cxl/core/bus.c:501 devm_cxl_add_decoder() warn: variable dereferenced before check 'cxld' (see line 497)
drivers/cxl/core/bus.c:541 devm_cxl_add_decoder() error: uninitialized symbol 'dev'.

vim +/cxld +501 drivers/cxl/core/bus.c

b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  494  int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
574d46ed53b527 drivers/cxl/core/bus.c Dan Williams 2021-08-24  495  			 int *target_map)
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  496  {
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24 @497  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
                                                                                                            ^^^^^^^^^^^^^^^^
Dereference

40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  498  	struct device *dev;
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  499  	int rc = 0, i;
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  500  
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24 @501  	if (!cxld)
                                                                            ^^^^^
Checked too late.

b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  502  		return -EINVAL;
574d46ed53b527 drivers/cxl/core/bus.c Dan Williams 2021-08-24  503  
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  504  	if (IS_ERR(cxld))
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  505  		return PTR_ERR(cxld);
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  506  
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  507  	if (cxld->interleave_ways < 1) {
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  508  		rc = -EINVAL;
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  509  		goto err;

"dev" not initialized at this point.

b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  510  	}
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  511  
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  512  	device_lock(&port->dev);
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  513  	if (list_empty(&port->dports))
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  514  		rc = -EINVAL;
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  515  
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  516  	for (i = 0; rc == 0 && target_map && i < cxld->nr_targets; i++) {
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  517  		struct cxl_dport *dport = find_dport(port, target_map[i]);
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  518  
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  519  		if (!dport) {
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  520  			rc = -ENXIO;
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  521  			break;
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  522  		}
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  523  		dev_dbg(host, "%s: target: %d\n", dev_name(dport->dport), i);
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  524  		cxld->target[i] = dport;
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  525  	}
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  526  	device_unlock(&port->dev);
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  527  	if (rc)
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  528  		goto err;
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  529  
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  530  	dev = &cxld->dev;
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  531  	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  532  	if (rc)
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  533  		goto err;
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  534  
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  535  	rc = device_add(dev);
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  536  	if (rc)
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  537  		goto err;
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  538  
b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  539  	return devm_add_action_or_reset(host, unregister_cxl_dev, dev);
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  540  err:
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09 @541  	put_device(dev);

Should be:

	put_device(&cxld->dev);

But it feels like a layering violation to drop a reference that was
aquired by the caller.

b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  542  	return rc;
40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  543  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

