Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1C3FFB97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348153AbhICIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:12:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25586 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348135AbhICIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:12:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1836FbjT014230;
        Fri, 3 Sep 2021 08:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=pc6hr5xa3OJU1lS4YgFx7+iiYLuiZmKv3rbCWjKnFB4=;
 b=jVs3EWCv/zmd3Lh47Ps4xAS8VEjl0hzhnN8rTSTV5rRG3ngPEBevrg5jH+3wg424keaJ
 9575DI8nYLy0RBruzHO7aR0Nx/K3jaWsnn0MF69cX7h5r7JRRwS34z30edcp5OBZCYia
 tofM6J0IPLR+wEgL2JKY2EGNDdADICc2F6Z6M03HFI/t/MBPjB+uLrDyuVb12fEhn6mp
 tp4y6HT8XyVxaL/KDy0gzPi934/3AnmAx8Wqx5mhDR+e92E6yUmHZAnqhzdMHrxfE0Yc
 lVD53gCb62QkRWFRQYa0u0bVJ3xtTLAmSwpyJ906I/cJ03Vg9EiJBBkhJ1oTlw6yIez9 bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=pc6hr5xa3OJU1lS4YgFx7+iiYLuiZmKv3rbCWjKnFB4=;
 b=G8QwfGW2gfRbySxQr/4eA/TIRakngnKNuQeYeN09e4OnTVLMxlHO4x8xkNF6LgJzq4xV
 mKzpRIrIlFw0V25OPHic+TDDZTas1FmQPaauI2eljLXVzTbovipXIyRZ/rZHUHUwaQDl
 RxjaK6aHtcqljS4dy6i/Gu+/7eZuBf1EFaeb2K5h6YtYIX8RiuEVHNkfak4Mbl8dDDxV
 Q7eCJg8dC1RhD+LnkyHnHzZh4TzqCNfY6XOO2azZMWqCsbk32KBVjJBor2JNnLfbakDl
 OEkKWb0ACYA9RlRE/7MPd5FTTMpPHThuPbE3cUa1vC5vCtf4VpUjWCroHpstKtMD/3rZ cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aue9fr8hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 08:11:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1838A2aR033498;
        Fri, 3 Sep 2021 08:11:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3ate01707q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 08:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqgYM19JK4jLcFUn1H0pCq7pvEZ7RQCgCOq9SHe2/rcQZKbktmoqTZe3Pj6KRZiTS64UxdoGDyHZ8jf24S4Sks0uA7Dn78MyZ7yGjVNr/gEE7clz44XtQAVFI4LnL97b/tvJC5AMfCoFNQWrwdw3RXyDa6kWuWthIAGL0WCjdNvoy7j/xroQmLrItHTBBF6SL/OpZRWwZjDV+OsqyivSxslZmyVpZA15WGQC5pGBkZia7vJdYpinXDVdy7tGATc4uipqvsfyW7fBlY7Bggj4uTh7NAyq4f9XRUUzsClPD9gVPxA770NZ4AyGU9mo9ARq63K23DZTnncrgad4xIc8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pc6hr5xa3OJU1lS4YgFx7+iiYLuiZmKv3rbCWjKnFB4=;
 b=HVRWaSDMk/S7QRZjsJaAm2yfYZ2WCkNetahTJkWGIQUR47+5Vk5xR8F5lrcH5F1oniN1rVu4cuarnTpkwLDkex2qmVuvJ7hk8ojiOjcbm+qqEadJghqL2p0SxnuRNJMsdQwuJgzBXyd8sxQoKRVpM/dBbn1iUNAxdg9CgKrOgK5AufXJrPY5yf5BFa+Wa5N1xM0KwEYcY/cygHDFPnZ9lW1ud0WqqrPdStrSBkAwkTECSJc70Y5RCy8PM2ixflvJ503HxvtM2ze1gbLpidRyFZ3OXngE+jHEqS1n8iKliLyNXK1ebj0eHESF7GpRCe3YKduJB/UVN4ug6PUTWU7pAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc6hr5xa3OJU1lS4YgFx7+iiYLuiZmKv3rbCWjKnFB4=;
 b=Vo7Z6NmmsCd4sSo3+6qdASYPKOluEe4R5TKjh89FXt7bVhXDKQb8wh+ut/nA9Reu71QzfXLSmZ52fx5suZgsdMlNtP4oxTXAJ23KNLAuOo9Sn4346uGGImXZWatKZ1LNoTw3WiMlTN3l+fp38YvqywLvUaGU0En7tO3XiQqPugQ=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1245.namprd10.prod.outlook.com
 (2603:10b6:301:9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 08:11:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 08:11:12 +0000
Date:   Fri, 3 Sep 2021 11:10:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Cai Huoqing <caihuoqing@baidu.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [hverkuil-media:for-v5.16c 7/24]
 drivers/media/usb/siano/smsusb.c:354 smsusb_term_device() error: we
 previously assumed 'dev' could be null (see line 340)
Message-ID: <202109020425.tObTnysX-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 08:11:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 900a570f-be6d-447b-8a49-08d96eb2643b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1245F69A2990A33927BABCED8ECF9@MWHPR10MB1245.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GdgGRn2pXzoy0JdM7F4e6nBvm9wZq0DBedLZk8RFEGkOkIYVBDaKah24I/RwMTaKi1GoCgfXd6rgAnXLwzeLaJf1/N6e0f4rVRV8smkDx+uDTXuw61DDZNwWdlpoQHOoz091GK1MkqNtXIT8ZlZmyUVIgVESqESYiYCK3n3YhUM6DhVM0lXngXv7rmdN0UluKFs8m7Wih9XlG0i3l/jYI2ATRBHHqTZjkC3vPScbeKtyLujsz9E/aYPXe+k950IdfhRX+gnP/Rr56tBGcpwG59wqhTQnPSb6AXpSSOsO8CXlrb3aduKeO4FhaP0olXwW1eMaOb76JqlpA7xCE4QqL/vETCeeWxWBtw0T0uJV+w+P+zyrqQUtDFlkdkfs+PmLqMnlAwIix1bIizhg0FWKyDb8M5gloiMxC8UQMtiTjWocmgogorH27aCxiECaXwfsQj5YGFx3flelLnpG7PLCFvaoABFiSEwoHrrRgJPAXDseRNXPfdY6V0iA/XxE8VpSwPwMMO4wMraUSlpCGR7dkyDVwSnWnon/oHRlc1QrHJJO5d4/w6WRze5bMWzi3SYHlj5fc7A8XZMeGH7L9+oMn15+u/xkQRWWcuMIuGi0Oa52dVXWif/5GDX84Kav1Q0aujKvqzDawf5+hJUClOL7zdeA9kWCB/9+9gH1tI8AbSo8iQjSb/xMLnFvLTAN1/oTYAJDigWeV23ZIbdKt9wqNLuFfO01N6BeaER1spfkdhBQTDS8SM0yPFiSgnrhhtfNWiGAjubYC2m4glcesbgsPSDpIbQIIF+hEj1FfsDfIiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(366004)(39860400002)(38350700002)(9686003)(44832011)(966005)(1076003)(26005)(86362001)(478600001)(2906002)(4001150100001)(36756003)(186003)(8936002)(6496006)(38100700002)(6916009)(8676002)(52116002)(6486002)(6666004)(66946007)(316002)(5660300002)(66556008)(83380400001)(4326008)(956004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DaCce+LBp7SrfkWbBc1cmqdFM+wZTCF7OffBQfhtrQaRIT8tAPWUiOdmQDRK?=
 =?us-ascii?Q?0Hn8nCDACrj0DOzu+8MESZC7kb5YRTxzYUnaZK7bE4O5A1VxexXZtwMQ9Fl7?=
 =?us-ascii?Q?do148Dj3lvy5Gn+qVmKXzBVKMFi/bTH0kIdvaIV867pwSfEUJ1CaHqq92QDM?=
 =?us-ascii?Q?846ZRqY8laMYGnI9m6/s8/Y+pVj/OyAE8Uz+de6lDBLw4pgFusgBTKFqXYO6?=
 =?us-ascii?Q?kgAjIaC1y3cnhWW9zByeaG6agFvejSIW1QOcOhq18FezQ8b/2/DBxAoYX6kh?=
 =?us-ascii?Q?M41QjxMRmq3aW5nnVatdA2x+XoBZnPZkl+NU6QV/9iZkoElJhv0HLJkC2gnO?=
 =?us-ascii?Q?sXd6Qd4NZANfPKjBq+eCZi1G4SIwesAQ20vuPh1pxX7dk1mGy5LIbgdJR4Xp?=
 =?us-ascii?Q?Rs5EYEgt91wclZ6lCuDgSe13fp62qgNXWO/NPhhu7eeMRiH1IyUVMCIgd+HG?=
 =?us-ascii?Q?WQzkMcc8mkhf/xtBaY/sSB1cUw0hJx0lKWbAemSL1zP3eUjGscIgvGaTaNjC?=
 =?us-ascii?Q?8PIgGRZjRPdKf31pWedmYyTv+0Q6ZnS6ranY+9dZ4bbkfw8bnEv82qQ45D/3?=
 =?us-ascii?Q?LJ4FnTOdyItQrPP85/IJWmZVUGsAoYBfmOE6VHlHyaIr6d/+MhrZjfdd29WJ?=
 =?us-ascii?Q?kb1gXrOwFkCd1mf0hwceVGRA9I6A3c1d2rXlpGgaa1mM5Xo6ysSM6M1Q6zbs?=
 =?us-ascii?Q?BHzn+LXH/FW2I6YfivHkTlu/cf2AM2dmHP4ISHp/6TFrAZ+IYQ+VNiHVo8is?=
 =?us-ascii?Q?rVHApwapGlpFns5r5tBjzMqXTMIRyxb2q8vHsUEcjGPg1bsp3gnKanusoLsy?=
 =?us-ascii?Q?vLWOQ+VOcvZi9eyW7tXvi2b37mHQ4ZoJAmfKi+UUDWyZgROedxs9CAsEgtfr?=
 =?us-ascii?Q?YbUGM5tLTMtX2DTqenZ3D0Ta+bWeworKzJ8k3ZHDWDmemLMScyznJRE+KwKq?=
 =?us-ascii?Q?FOcEM3qW/v/ZmUC4fqPiK2mNBAbmBCa2I+cG8P3qrqp/0jBqsHmtxo6mO3PC?=
 =?us-ascii?Q?hQN1yy6m0DE/QkHvNzddFzr46l2lFb+s02Cnk7gkuwQKhYo8IiPWVrw5jQra?=
 =?us-ascii?Q?GkFTaaXCmishEbowAgqovSZKVevQLIdDkja7656WMGBhdVIEstOC/DPQl9Wg?=
 =?us-ascii?Q?MHKyyFdPDCk9MHbO4B2gQ6SUOvLAlOe7+EDcs35zwyjPbmGMOESRCOOpjfUw?=
 =?us-ascii?Q?Y0eE9Y1OVNY+feogY8idazSks+SGzmSc0u3v4SdE0Gl+Keydss0bd4OTjjNe?=
 =?us-ascii?Q?ZUZCzkh+3ex4P31r4Xy0l392spn03FhUQ/z/H9nz2OYukEJoyCs6qEC+pXf7?=
 =?us-ascii?Q?H4vpN1UaJYWWFYWdw3W1T6dU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900a570f-be6d-447b-8a49-08d96eb2643b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 08:11:11.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaOP6MkhvIqS5eOvcbqRT+Ze99DARbZVEZV/HrUe3303gHGQ5egz2eV14QMe8OWQOmUP2Re9UaemJh/ddYuI3AMsOCBd+w0Pa3+l+OdKcOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1245
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030049
X-Proofpoint-GUID: NtoyAnudQSz33tp39TnpXh_wGnrJOOIR
X-Proofpoint-ORIG-GUID: NtoyAnudQSz33tp39TnpXh_wGnrJOOIR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.16c
head:   1ff8a1958e10f52762323ab98ad84bd417c4bd24
commit: 84f96613da19427380d40262262745e27ffc7c75 [7/24] media: smsusb: Use usb_get_dev() for the reference count of udev
config: arm64-randconfig-m031-20210831 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/media/usb/siano/smsusb.c:354 smsusb_term_device() error: we previously assumed 'dev' could be null (see line 340)
drivers/media/usb/siano/smsusb.c:354 smsusb_term_device() error: dereferencing freed memory 'dev'

vim +/dev +354 drivers/media/usb/siano/smsusb.c

0c071f374f66f0 drivers/media/dvb/siano/smsusb.c Michael Krufky        2008-06-21  336  static void smsusb_term_device(struct usb_interface *intf)
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  337  {
8350e1551c27ee drivers/media/dvb/siano/smsusb.c Joe Perches           2010-11-30  338  	struct smsusb_device_t *dev = usb_get_intfdata(intf);
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  339  
822374165d6b11 drivers/media/dvb/siano/smsusb.c Michael Krufky        2008-06-15 @340  	if (dev) {
                                                                                            ^^^
Check for NULL here.  (Unnecessary, "dev" can't be NULL at this point).

05f0ffbc487517 drivers/media/usb/siano/smsusb.c Mauro Carvalho Chehab 2013-03-06  341  		dev->state = SMSUSB_DISCONNECTED;
05f0ffbc487517 drivers/media/usb/siano/smsusb.c Mauro Carvalho Chehab 2013-03-06  342  
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  343  		smsusb_stop_streaming(dev);
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  344  
fa830e8a014a20 drivers/media/dvb/siano/smsusb.c Michael Krufky        2008-06-15  345  		/* unregister from smscore */
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  346  		if (dev->coredev)
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  347  			smscore_unregister_device(dev->coredev);
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  348  
0dd5f20cb35b59 drivers/media/usb/siano/smsusb.c Mauro Carvalho Chehab 2015-02-22  349  		pr_debug("device 0x%p destroyed\n", dev);
08921ac9e9d185 drivers/media/dvb/siano/smsusb.c Jesper Juhl           2011-04-21  350  		kfree(dev);
                                                                                                      ^^^
"dev" is freed.

2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  351  	}
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  352  
2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  353  	usb_set_intfdata(intf, NULL);
84f96613da1942 drivers/media/usb/siano/smsusb.c Cai Huoqing           2021-08-02 @354  	usb_put_dev(dev->udev);
                                                                                                    ^^^
Use after free.

2e5c1ec8865abd drivers/media/mdtv/smsusb.c      Michael Krufky        2008-05-19  355  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

