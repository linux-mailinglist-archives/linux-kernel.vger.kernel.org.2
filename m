Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6394A3F94E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbhH0HIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:08:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42984 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244365AbhH0HIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:08:14 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6IhZ2024236;
        Fri, 27 Aug 2021 07:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=t1jIFI8a8UqRAkwVS7y+9r8o2AqvusdWvuHVzX0aNls=;
 b=F9DbvZz4zCLz5HZ4TyLcEiKXYg6WkLFXI0BHUhiTyxEPD/Oxxt++v4aXyXtWd7O2Hpna
 sYQVI5QmyqavEbJ2l8nZHKf01g9p8O3Y/o5bnnHsVfErfM9wM0gYBOnL6u/bKdY3SU6T
 bdG0GHi8Bhxcb2eukOZtZFFiM06KqmQ3ZBwK9yIZXuJmCUsHUsoKngdeScZBr8AY5QT2
 E52zoYxufa2ogWGNxgkt7lL/XXTd3CVuAgMDJbLpTYzVe+rOMtpo33yVBBi8RXk0WeU2
 CYI3Ne2kfYLUEkyzBcax5RSegI7axOYhNt06tGZF2tOAW7+jfo8dVoHudsOq/SK32871 YA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=t1jIFI8a8UqRAkwVS7y+9r8o2AqvusdWvuHVzX0aNls=;
 b=SENMiVGHxGhxLoi5rhnhQuIB87BmrIFkzWeGkz0GYrrhuhB8XsSftAQoD/6urM21hX8C
 v2nPRuo0Ue+nz3awBex65usKCqEHYltyOBBeGuOk6Ntz02n0d0Z+m7P9GJ5gyHcIqjs5
 Fq2+Go5NHWKpEL8K29Opo1r9viTnX/PhxT/VxSaOqbiwmNJJ9Mdesj0sjeuEAiPzAUTB
 jsyL68xqpFrxoeRTetrPnXJbXbR4mkr6qjK9vFdvIrRApPWmKGmzhHo/xRqV0mQOTDUY
 Esh+hqyUk8Pf9qYo7Y6EF0G6mP/YmAc/GLjMk3D5nsHtC7a8OEuHJN/3BMFMJPxwFjZv uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap0xpb720-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:07:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R75mhs154575;
        Fri, 27 Aug 2021 07:07:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3ajpm45nt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jhq8AVuGLY4W5FS6mh3/OwqOKYagwWxLK3o5q9xuh9UYYatTZAATPF8e8dLEZoilpCifiv/do+z7iNBwYxlkUXnSgbOOK2Qo+nkO82eQcDynlNKW0lAZ02O1JU7jyHyhTUHstztCMssz24qWDRa8l9EmJ0qHgYI7N2r6nPVpXS21sTdsPXW/MEEoFeEQ+EuDALyD8URqPKEjIYI73r2bFw0D+tvE+QeJau97/mHqo2x3uT3krBRktz/ScWkimCN4tH+DL2l6JdEOi4Me36+renrrkLOW6Cpe8NR3WhznwG0+S8bSlQ6AWzKmXs+AmMWiYI7ZbTGfN8/0nACMEhaVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1jIFI8a8UqRAkwVS7y+9r8o2AqvusdWvuHVzX0aNls=;
 b=aV7L3yiIrzG3ZHf3qGXhxAlnlzITbzmzIShTzC017eA5RTcgdaNAi404lceiJjRDlUbd6Asbs0nFliNvPJTYX+VEwsjoYEalib6ojBhT02cNVAgsuLsZV4W7myWER/UpNMDk7jsFY7YWfYnzTKD4x0DI16I3FxyScofMp/NJh3wS2cb6c2fvvKhXF5WqIN9OcDGThaAAmw1xhlQidTyfnCq9JH2bMo04B40MF/7IGDo6ems+sk7PWAuM2hFCOqmSxrYGZoeqb3oW5ukNW5cyh/kbtrHAOu0o893fspS3IgroJpL6uY2SuicQZ7aMgZC+3lrtUpWU15Gd2wSSumuFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1jIFI8a8UqRAkwVS7y+9r8o2AqvusdWvuHVzX0aNls=;
 b=HXzaA5VpRK/4aWlcBJQnOJe1HpVq70AIAG2ggU3rvIapXg1WqPoUh2hR5wN3rZ7hv0PAcx33fZ2B7cwM+Sl8fam/Lp1ftSHH8to2JDObzCp4VWlcU42p+sX3UtjR2Gq4VXqmTxLVrusum3wyXFzCzazeQUfEnvUEmYz3WjLCyes=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4738.namprd10.prod.outlook.com
 (2603:10b6:303:93::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 07:06:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 07:06:59 +0000
Date:   Fri, 27 Aug 2021 10:06:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [kbuild] drivers/net/ethernet/mscc/ocelot_vsc7514.c:554
 ocelot_xtr_irq_handler() error: uninitialized symbol 'err'.
Message-ID: <202108271503.UUJHV4l5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 5SH2LST6HLWH674CXVCUEGVCOYUY2KMI
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 07:06:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4be8286-a0a3-48f5-65dd-08d9692942ec
X-MS-TrafficTypeDiagnostic: CO1PR10MB4738:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4738AB2506FE137FE4C87FFE8EC89@CO1PR10MB4738.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfV+536WW3eCdGkRs7KbSAAO1scFr6MravMMDLi3kr1DjYdb+M7m8aOFJIrone15LwzB+S9s3GdSwZOdU3iWFfug+tSIzEJY0c1qfcnupQ1uOLystc7x/xejmsPeOnVVW3xdMG3SVtk6s5EStU5vLAzbj5N43xBtLFO7y2yj0WJEmSu1LIWCMQw4jNhdaZ+S2jxMKSvBRlSOpkUpJSctUHrpF6i75riSVD1JCoqgbtndKEaQpWmIPNEBlUa4iDWxJcgjGkz/ozbfpcJJz4w1XB7dEWRNMt+IjWurkL8Mc/XFUJVYgSw+Qi69qbROuV+vb3EHoBdA1pYB7GHoi4WgfqhE5rCY06gvd8YfoMxkuIU9jIRF6DnVAwKo8CdLy2UbCzygFlPatawvcLBVPCvNBiUYYBNz+O6gA+t8Ye/UZ/UBlu9/9Klw6mlizZ9gLxe2fv3CKwNZhSOWOxftV7Kcb2wLOb3iNdxdASIZZvqh/qQW1mC97g9SbIluTmHOboEGus4GQP7XHXRihNViEJgPaKgULsYq3USVBrLMFoIjd/ueylYkMNrnpRdISYzKOP+aP9qhLNgKGc6d0wduNa+7CCfHHdPf3Y8sEtktSsAftxVlWTvA5iBAgrYBAW1+NgBtkG2/mKlCOomeRSL+PBwCxHdno1JvK9FX0H1vMn4ks97DvrA9QT31629VYWtsM3OUMI20KuLlu2rljbwbqkitm6VJBPmlmcONJ4w0vjwNoBw/NCJsEUAh8MCT5Wlce+KhWuP8R+5VmZNc8J5A86L/6iaJQJJWpLjvQqlmnGZDFZEra4lw7mCRpTkiULkgT9IVUMMvW27ZDqKDTdM6RrKsGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(366004)(39860400002)(346002)(66946007)(66556008)(6916009)(478600001)(2906002)(66476007)(8936002)(6496006)(956004)(36756003)(86362001)(316002)(52116002)(83380400001)(5660300002)(9686003)(6486002)(4326008)(966005)(1076003)(186003)(38100700002)(6666004)(8676002)(38350700002)(44832011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8HfJxQeaRJkZeoWGyJp5s70fMi1+m7C1YKkwoP/XdPImIN1orCb9BfknHf5M?=
 =?us-ascii?Q?kjyI4+SdD7GEBMJ+ZPOLm2z1LQ6ywM9Ts0wXdiRo7KGr+1Mx2397a23V9eKR?=
 =?us-ascii?Q?Nk+2hv5k8IFXfkcgAdfeuBcHDIW8uL407100AZXV3p6E1ll2OcGN+zEMUf2Y?=
 =?us-ascii?Q?ySYKDv19vXh4QNDzZ3cjzvXy0wsfoQ47i3LJnVYIhc7mbDzjrNQSZv2rLFrB?=
 =?us-ascii?Q?Bw9o1z/nurXGv+RF+VbfDQyb1Rj/hc0XIXL0sXxYvWtkH0njsEe/Uf2zoWHk?=
 =?us-ascii?Q?cLriP2T+a9bTelvJwiXEKOJtTjKTPuq9MMCH0pHNga/2CpRrTP2verm9TKAL?=
 =?us-ascii?Q?MLE3AAoJLkuUEQPD90xasoJFEmobayGZmsa7EiKj2MpT5nInxVZud6Q3xqJp?=
 =?us-ascii?Q?niLCTjex0Kq6iwSg7c2+VQGwxP2LxA83BA0dSCRSWJqFQgyRZhLa+ENBMsm3?=
 =?us-ascii?Q?elakoRVCR3huY30jtLrWQeOEBXcdHlTGLBdP2CQ1cyamgGGAazC8+WkoBsfk?=
 =?us-ascii?Q?axMnxbVX8uRKDbKjFKtaZhTugHhjij/VnTdqaS2zJvecLHGuw9aWB13TUrfw?=
 =?us-ascii?Q?LGwR7/UVjD6VP60Js1d8OhORDgtDS5AtxeIPJPDu2SdLMpQsFfZLvztIuYtx?=
 =?us-ascii?Q?gewLlk7k8HZ2HlrPc08DzgtA6tS+lUfW+P2V55kZ+Dqxm/NBxXW7H9inYiAF?=
 =?us-ascii?Q?NF1LgeG3kxpxDue0HHfZqLnk8WEUGWgIuf/DB3DtYGt19eCcqPHsOeesBb+m?=
 =?us-ascii?Q?XCK0VstV2KJ0oGkZYiZ0It8qmYnoUlTfHovg2bbRkWZgrZTwNQyQzcI90l1s?=
 =?us-ascii?Q?iobFCNRbefVgGcLuBIHBYJjK8cob1t6to0m4/40FhuxZA+toYPcYT1iyjAqv?=
 =?us-ascii?Q?2iGXCPVhEXEHrSJlLps7ECsyo05LuJfxBisitRbsMm8pIUnj2h6Jke+XmdHK?=
 =?us-ascii?Q?HY82MQMeRdZBSVVQq5oWll0kJrWqBgeEJBTNNsE/DKrnc/AhFHugPgRhJo1P?=
 =?us-ascii?Q?tDmFUQhCj4r9ZNPPYeDMFy5SJYaej8jAQ8syrVQqFCwiilmePtB0szWcEwx/?=
 =?us-ascii?Q?8ljyaFc9KDME/3xRqcoqO2VqXGkSE+FAdnQZ6a5nmyDx4EkS7BZLyGPAOgVB?=
 =?us-ascii?Q?rbMebxgMq/lO4SWLefByDrB7qLXvZ24wh8HYfZWMhflV8bPiGOx/Hol4A3WW?=
 =?us-ascii?Q?3tXgDRXmnJHzJuAOIpedeI6WdvXYneifsYQ82eVtyQPxjaVQz51dcAOCF7Se?=
 =?us-ascii?Q?Kx+8GYmqFstFjZV50OMqw/qDT4EhHM2o39Dek/HaAcarvWSGjuHTdcAqWtrc?=
 =?us-ascii?Q?8wiEL1CxkUsCOTR3xvnKKhaX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4be8286-a0a3-48f5-65dd-08d9692942ec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 07:06:58.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLOE7iwHv5hlHNevj+BEN5a/FxI78ouArU2MUNqX63Capk5HWbn2Zp9p6xLWSWfoyU+A/fraTTdP7I/vAvW6WDvwLu/JhzxfI+iPG7Tvsf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4738
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270046
X-Proofpoint-GUID: TYIIhLoWaExWmbIqqlOGBJlOeRVBDYks
X-Proofpoint-ORIG-GUID: TYIIhLoWaExWmbIqqlOGBJlOeRVBDYks
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   77dd11439b86e3f7990e4c0c9e0b67dca82750ba
commit: 924ee317f72459a49ac4130272c7d33063e60339 net: mscc: ocelot: refactor ocelot_xtr_irq_handler into ocelot_xtr_poll
config: openrisc-randconfig-m031-20210827 (attached as .config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/mscc/ocelot_vsc7514.c:554 ocelot_xtr_irq_handler() error: uninitialized symbol 'err'.

vim +/err +554 drivers/net/ethernet/mscc/ocelot_vsc7514.c

a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  534  static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  535  {
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  536  	struct ocelot *ocelot = arg;
924ee317f72459 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  537  	int grp = 0, err;
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  538  
f833ca293dd121 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  539  	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {

Can this condition be false on the first iteration through the loop?

4e3b0468e6d7f3 drivers/net/ethernet/mscc/ocelot_board.c   Antoine Tenart    2019-08-12  540  		struct sk_buff *skb;
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  541  
924ee317f72459 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  542  		err = ocelot_xtr_poll_frame(ocelot, grp, &skb);
924ee317f72459 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  543  		if (err)
a94306cea56fe4 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  544  			goto out;
a94306cea56fe4 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  545  
924ee317f72459 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  546  		skb->dev->stats.rx_bytes += skb->len;
924ee317f72459 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  547  		skb->dev->stats.rx_packets++;
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  548  
b2e118f638fb89 drivers/net/ethernet/mscc/ocelot_board.c   Antoine Tenart    2020-05-26  549  		if (!skb_defer_rx_timestamp(skb))
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  550  			netif_rx(skb);
f833ca293dd121 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  551  	}
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  552  
a94306cea56fe4 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14  553  out:
d7795f8f26d944 drivers/net/ethernet/mscc/ocelot_vsc7514.c Vladimir Oltean   2021-02-14 @554  	if (err < 0)
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  555  		while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp))
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  556  			ocelot_read_rix(ocelot, QS_XTR_RD, grp);
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  557  
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  558  	return IRQ_HANDLED;
a556c76adc052c drivers/net/ethernet/mscc/ocelot_board.c   Alexandre Belloni 2018-05-14  559  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

