Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E883DD66B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhHBNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:06:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57706 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233645AbhHBNGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:06:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172D1HKK028080;
        Mon, 2 Aug 2021 13:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=AYKq3CuSpPI1Oz4N6U89Gxl1qXVsyozISTbX/YkRu0E=;
 b=jXc1+QmMOGhrdrdVGTikz9CBRDMIpguDPTBY8UvbJ3UcBaFhB9HDYFCOUanJ0th1S2Ii
 HBNoi+9eT6V9U4gH8eGKwxLiiMJ0JmvN9a/kwpEMq4xJ9LcohKdLYaL6U1OK2/iG5EOM
 tYRs4J2w+V0EyeIuYYHYCDQdHkxw4jBzp+VolVOHwl67lvNkG1dsaTn4q374v9Tr1/Hd
 V8prx7QAADlbSoExSYj0fH30fsL6QKHiE1y7q0vDo1/gPrwIXhh9sxFpkNU3ELMhOySG
 YS6g3QpwuO1CxPN/2BX9CGFbRYedycZHCoACO/rjd1VU9m9oQio1SfJiRPtXO+Fjif67 Ng== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=AYKq3CuSpPI1Oz4N6U89Gxl1qXVsyozISTbX/YkRu0E=;
 b=dTmVhd6T/XDkkQrZ33DmGsIBk/e2ht/CpbotQY8g1b7Wmhj9pz9w54K4GPy7435JpABj
 8Icp8CK9h7bIN4ScszAXeZZDtQTNE+OSXeUYnUeI8ucLSm+2z9pSPtddnWqZYRIq25I5
 YPygfHFUkP15d18t/yc/95NYalBsbywlKuVYHLbSuLdFnx3CUuJGSugk0XgjYXM2mRnG
 /ltr5EDkb4ivDcWUOjA2Fo2oQe/lkqvqRASR6cgEfi+WZ+evoPyrAmRYfkQjrIicsKF3
 SG1ZDcmXWuBzjZ7c9gW96/uANoY0HQEQhwiLNHID1d3fS5TChfTlJvKOhwEmt3vJdUg2 Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a65vd972v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 13:06:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172D5rBW025092;
        Mon, 2 Aug 2021 13:06:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3020.oracle.com with ESMTP id 3a4xb4un96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 13:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEMqv2Ju/LD4EPKXMHDRPN5aHMP/aMVudKeaC2/GoQh30lOlpTDyxOIqJ3tSYaNYn605DOPe5ljmLbMDH7CVkLbexrPOM5CzoqLLYtNnc2J0JlCLsVcdsfbEPP2VE0JZOF91gH1BXOGXC0STlUfXBFS2B6PEf0YFY4f+FzyI5+L/F2xXhzjPG8ZPAWnHb9A2IHBpUW7r24OyufuI2zyecWC/wqZbSRL0UXnDYVvDi/WShCiX0+bAADqAY8nIb9Fv/VvMladefbT6IfaVlWZx/TUoQVayFWhgz/H2wfnUJ3dr9uFtXHjJg0Ph85ihEaUWMfEy1u95cA8RcBKvL64Fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYKq3CuSpPI1Oz4N6U89Gxl1qXVsyozISTbX/YkRu0E=;
 b=i1E00AoTEyNFVdxVzkLbN+Y0xtV2/0eZbwmky8n1wyOwqR5u0QdKQj9uDUCDOM9wKpHhKYqwJ3gu97hhIMHLYpxzkKB8CKMTZDGUiaeQtcLGBHVAZda41QKym9uxlxOLKVuNx5gAIG0D35v00UbUVZVn+dDKVe5KGo9ySdxqxHFE+hXva9ykaQNXFB6/c6I+INZYOV4Tn/AAJW5Xlx8KbYigtwKf1gUdm/31mGdVTQVnI44jOIKvK4jLSZaoCulsryQZLkB5frlf9E+PJ2e3qCC31+dWoqjXppfJ+grCOredVNGtkb1/Vsswamw6ZBGPoEagO9DSM2JQDBaZ80V/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYKq3CuSpPI1Oz4N6U89Gxl1qXVsyozISTbX/YkRu0E=;
 b=HU80Si2MRXP55ex+TiDeuTHmWq44C6EBHOk+xg9OgmCj02I5zh+C0zvq7V5hP8+ewdDGK6f5RV8gfdANTZcsnllQ9ExYzi7CLLLP1vJl8Gz7oUWWXjQD5AIzv82tr6V3OOAY+2jaaqmxTImPRXEEL2Dgf+6goCkZXv3FEwJiDTc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1887.namprd10.prod.outlook.com
 (2603:10b6:300:10b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Mon, 2 Aug
 2021 13:06:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 13:06:11 +0000
Date:   Mon, 2 Aug 2021 16:05:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: rtl8723bs: remove unnecessary parentheses
Message-ID: <20210802130551.GY1931@kadam>
References: <cover.1627656773.git.fabioaiuto83@gmail.com>
 <fca83a857ebb158cf395ea31f1834c04402c39e4.1627656773.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca83a857ebb158cf395ea31f1834c04402c39e4.1627656773.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 13:06:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d953982-1201-4c5b-64ad-08d955b64cc1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1887FF334746DB4CF7304ECC8EEF9@MWHPR10MB1887.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZ1lIS+ZtUijBeqwqcvoCNuBUKrcor+nHsx3qYyFNHef4ytmSK+30C9rOFSqTcnaIWYLGEd4tO0L3g6Hpl+6BnlPoSdlNHeGLisG8TpR2M1tTrnOCyR6CvfT7ufiGxZ1053wGGN8ut43Rykmlv5ndXg+YD8PvwcE1Ew0PXUftD4Sn7OOmWaOGlZpteTmBgB2WyyZOAXZUveaMkVC+tiuExPNnfo9nlh6I/y7ZOFtp1pIqf1m8eyBxogOEUnFdc0ezIBxMQbgcuT7q0oTqrcY0kC2JKWQyUQcPqY+Po5m0zrxx35Bzvjr1de3n9uYyljh2RSOlKGxxFMdWhOX3UW61GrypyNhhq4nHgiLe5gpDffRZidvtzrFQ4EGViI+QYVsz9BDHer15/yKRD4mrkXC3kU2CYhTc5byfQA2mDui9Oy9rhMX38NiBkpj/375AjN5Hf8BpZ9a4SKu8r3WA1DdClLYhcHmi/gNWL/vLvfa4kswIz3QXNQWF8KaCOO7hdrj9OL7PLyuvoTLymGGPTHGZzSwl8B19SCrMNdRL44Q5Ah05BHaP9VIQKqDqIrF24Qez1GbQqg3Sx6lfiMZ4pXass4hrD2cI3fpCxm2qArTXqwxxB7PcDmxFVI12OxsFpbouAofTKX6GJ3XuhOGtC3bIftKUfYYQEbs29hdqD7w18chIm4g34ML/7J+xL/8cT0fy3IwTGbqXB8vB7bUFwP92g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(366004)(396003)(44832011)(33656002)(478600001)(5660300002)(55016002)(956004)(6916009)(558084003)(86362001)(6666004)(9686003)(66476007)(66556008)(66946007)(1076003)(26005)(6496006)(8676002)(9576002)(52116002)(186003)(38350700002)(33716001)(316002)(4326008)(38100700002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q2wQshkm34wwnwau6fBhCciDnqY5ZxaXjYDSFOX6V4z/AdaVMTGN+f4aV9Ch?=
 =?us-ascii?Q?zotuIuZe1VOxroNNSINMbmGcu/deUKr3+5dpsnId3Bg9VPzCRDctLLgb5A47?=
 =?us-ascii?Q?3zfS/sb6O1i+bfFEx7SekcnzQj+dI37DVA3JkvEKxfrxLQfqpqwEKNMLRmdY?=
 =?us-ascii?Q?HJDFEhx8Di0N4bI3nYtUuxfRPKQ58fs3XVi6UO+SWXFl5DNpb17onA/Vmyy7?=
 =?us-ascii?Q?f+8KoZ8g+A/qBFmC6XsySLyov9LgMrAL51OJ/ddjRCqE74izhpsj1GlAfwHx?=
 =?us-ascii?Q?0b219fVfpryAUrhNRfYRC4xMETkFDKudolHnjNN2Vicl69QagyBtvh9Z0jbW?=
 =?us-ascii?Q?vVWGtmFN812wcs2sO5hrTbSZD8k6UXnzLSJRLIKUj4da09//FnKDqkgg1J7U?=
 =?us-ascii?Q?jxiDhiif1d47p9aqhWmfonxltWOSGtagy8c8e5/jV5LVlAVw8BCBzv8hwzFu?=
 =?us-ascii?Q?OxnvYyznF0mgIVPZSdEVMPU8Lt9oFILa9Zap8U9vMneXTO5PWnLez519X17x?=
 =?us-ascii?Q?xBfih1eNwwf+NbEYFYLbY73DjKLpWQH4tMC/SmKzYdeVmD0WlKM+6bsfnd0v?=
 =?us-ascii?Q?7Wo/AC5cHSUs9GgDasftVP6C7Gfq7HjkHQarw1csMZ7x1PN1RKdqr//ndc9Y?=
 =?us-ascii?Q?6eB3ySu6uveRE/I8kBEs+jcgGX6kexwtYwmg4rbAand4bzw4ovAZYWYB+G6d?=
 =?us-ascii?Q?Ol4XUuVSjjcuaVfK9Qm6h6PS5b2Mi428dkiGErBFEv5dl1Ian4faJ8L6f/7M?=
 =?us-ascii?Q?VXZmLcooN3B9CKwZJInGqyHMnc2J2Xt73szbWplIZZf1NVCly280Xmf3Palk?=
 =?us-ascii?Q?/8iepcLtAxCdiMx8Y/Ioes3T6kag7dwNioeOICuGCFSSGg1oFznuvKTHtlgo?=
 =?us-ascii?Q?pzswoepT9eD/+luTTaktzj1tXlt/GL552GE0HdJMJ8cLvf8su5+fyrzLLPcn?=
 =?us-ascii?Q?OlAlGLzYDA3rOk87LlDVSZda3jYGoYUeIzv9fUjzOZaJMJarq3vYuX19JIkH?=
 =?us-ascii?Q?KugX6GFMpVnu1H6YidzUzwO5tpXvuToPc+0ghPCAagYpERQ4h231r88OvDxM?=
 =?us-ascii?Q?Lv29HuNgmrqGU9sMLd0zYqQceyKQ6UMrrSpOWsLE4Uom257eL+cU2FcaW0A1?=
 =?us-ascii?Q?XvdDnrKPsxvCQKlhIPJPk+10jlWakUKJGppXfA5SNkGJxA1/HOuUvvBj70vE?=
 =?us-ascii?Q?41MhZuu4PEPxmdh4fa84FutFj/tyKt6Rz5nWpkwurN9ou9YhxibQ54xBhoGN?=
 =?us-ascii?Q?HClDCC4Pf6YAjGIKkeGUNeoVo4xopQt3epovleSrqCgub0Dfk5IgYFi4eP1K?=
 =?us-ascii?Q?Bjm3qByA2lRE42EnyQcX6i6f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d953982-1201-4c5b-64ad-08d955b64cc1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 13:06:11.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5VHBhHiyY+qVE7Rq/a/gTnptymu9EwG3iUBMkc1j0vsI7hgWhbF0sPDjZuJ6RsK6P9ltNXbAdxbBz3iLL4zMZyYDbWoMnh93pvTGfIDF9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1887
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10063 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=988 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108020088
X-Proofpoint-GUID: HM72WT3_XiR00vy3t6iBVopF8Kb1OLN_
X-Proofpoint-ORIG-GUID: HM72WT3_XiR00vy3t6iBVopF8Kb1OLN_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please fold patches 2, 3 and 4 together.  It counts as one patch because
it's "tidying up the condition".

regards,
dan carpenter

