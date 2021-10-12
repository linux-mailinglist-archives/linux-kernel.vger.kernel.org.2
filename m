Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6910429DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhJLGhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:37:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52952 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233215AbhJLGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:37:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C6Ajo4030335;
        Tue, 12 Oct 2021 06:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=83rJVu4hp36OJOZbYTRKe1umUqRUueUvJ+iTXnhugAM=;
 b=BFSX9y2cRwZGujSB4v6/Up/ilzvu9xAh6CZtiRlT9mbw569+2bsxfc1h0RGiqU3qwxc2
 gsGqZaXks8U7MBPWntQD9j+4W177ZhgHVLca0uSWZlyPdFD9BfhDTZUPrwPrWP+uw8Br
 QDQw1d8SIoFo17zEwGuFv9TxOlXTx57h5kHamV1ezPNeMpesNres3yASh0zFSpXuV1tL
 7I8tgNVv1TydW6aXCXKSVr6k/DK0Be5H0QBRiYYofS4H7Ec+UvMeCaFfBaPw0NbaPSX4
 mxo1lAdN0dc01zJtlSflWUoH91kh4Exl7x2+Het0r/60EF1d5zHETfwMJcXF70mKX1mC DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmv41jwf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 06:35:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19C6YhVw011981;
        Tue, 12 Oct 2021 06:35:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3020.oracle.com with ESMTP id 3bmadxfhna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 06:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwx4Kl5p6SO8LFqa9r6JzTpcAvwoeBDAaP/P/gFp2sqNDci6cKM5+U4SrZF5jN4yivIELV8oUjGlJiZsFOvoKTjHS1NgM5pVLcaMm3wyuMfIm+lwsh426aFU1tfclB++bNg2W8GFloVriFHajGQ8wzTUrW7hv0/J2T3D+4cnyqByWsx3eEYnlckbRZDXsJWlM/duGnwasDWkLMuB6uIhodBj9hbM16ubf6HOHUUPo9ZDHQpQdtSGtgX4iXktoe/2vDPzyWrbFQ3ySREvJXRp+DmFjdhiW+ylKLmEnoFMcYk44JCexDpdPI1CusaB1K7BZ2qsb2wSJsLYRaKakakbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83rJVu4hp36OJOZbYTRKe1umUqRUueUvJ+iTXnhugAM=;
 b=GX/fP+xKvDpRIU1EJ/5uILXl1xLpNdgpu4OoDQF326e3rEcGOeXbSeL714Nksfr6ZIudRQXegf4oya0RDcMy26EU0wBUVjN82B/RQqbUON53BUFx+XnraU3A+ssyHQObdnPrN3zZNL1TVOa3+PL3sIRI8UOwusMHtQwk3oVuOCj786LPK+Ftl6tpawlaT2yh3iaX/iamZzyZ1EpgwlvnLKdpglOmCsg6NOoL6o6ortK92tUNRu9+tbpn0UFcf69Oowf0DtHkiNYlkLAr1ovkqw8q+MxZQBuAa/FYQVxT9zujIMfFbFM5Rok0xvZx0Ncjb5ybF31h0jE1E7TlcxSH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83rJVu4hp36OJOZbYTRKe1umUqRUueUvJ+iTXnhugAM=;
 b=QkXKLAEmCy+IDXxL5WHbpYIC4F0xYEVBJIRfuUBcQvnGwZd0qlPhWrkVKR+PZVdexPnMJKvNbO1aCgWO15dGDGzP3xGGVOVbTuRRhuTH02c6U9kxpD7+utw85OgeiHtSLxxihHpz31b+ALy30oMCDu+d3L8vLQmpWo6SSGkomqw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2320.namprd10.prod.outlook.com
 (2603:10b6:301:2e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Tue, 12 Oct
 2021 06:35:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 06:35:04 +0000
Date:   Tue, 12 Oct 2021 09:34:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: simplify the return
 statement.
Message-ID: <20211012063446.GQ2083@kadam>
References: <YWG3oIchovDZnPl8@user>
 <20211011122631.GA8429@kadam>
 <05689c1a-546b-7d5d-0196-59f1a2caaba4@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05689c1a-546b-7d5d-0196-59f1a2caaba4@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Tue, 12 Oct 2021 06:34:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec86965a-d0e1-40d0-dad2-08d98d4a6cbd
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2320DD69A6598079A601B8628EB69@MWHPR1001MB2320.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YY7Qm5yYFZQ9yrV2twnqS5A2dinb/41v/KuTp1yRwe0KGc89vzp5ejkjNP25W2NPcehIgxFzU2i92ildgv4MCyoWCP40cHDYEkCWAdarbzJVbsp1wQtOK5J2dKEn7kETiPQKHaRpsx7/BALQg12CTqT4gZcIjAeKfE/gij+VzfnrPyriXcUcyGPPskPlb2nYXXKhNPvSi2ksXxhDgY63x/v47/eiRbUyUE18cMO3TR7Xpl38q13Y/2zTo3OhjhskUfWBe91AF0xE9qATH7XOFx/JpeVCo6fZ1zMElJv20Yxk/4UdipfV82G0sQAcdq41EjS3MRP75UdW5wOEVOVRr/Mw4biQZc3QF0St6P7Z7AS8KHYT8j1ty8j6N9NirCeScnJth6d7dXUu80DR4NDBpQVxXbPL685xtWzlk6zTZarU4i/koHjlxmbcDTY7zh9rQigo0x4OzRQPOiNtkwhZbiYWo5x8yUrh3rIU0pQiGQ7rYwmpIWNW1exSCRTeHqCViFYtw0VaXBgN6DtHEyxTOucPrHa+Yb45hwg+UZuxhLi3YiUVGQ+GQYgA+fle2NDWiplb0hpnTcg/JJHa9vacycY6NPW9KfHLurUqK0v2ARFFg6XzkyKUdB3lGxXcRWLLicern7kw8LxcJKDOlMUItRg1J5LsC4eZl+WZwtT38AWydfdFsPs7MqrJb07/q1iJTATaK43/2KIJ9fMy54QZKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(6496006)(38100700002)(55016002)(9686003)(33716001)(52116002)(508600001)(8676002)(8936002)(1076003)(5660300002)(44832011)(33656002)(86362001)(66946007)(66476007)(66556008)(4744005)(186003)(6916009)(4326008)(9576002)(6666004)(316002)(956004)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIzP5WVrRU6ya2jsTCC/0K00TOVrLrplc3FqWDHhBreNQrFV4cYtooNyMDNY?=
 =?us-ascii?Q?ppjsAzktchciiTYwQbFitPODWzRJ+kZY2JC7wDScBwr7Jx1F9zIVP32rMtrr?=
 =?us-ascii?Q?0zjF6ZeIuiL/shqv448BgMApczWfYDCxEPz9qYn40g/TOc/ycdNlPPYUnix9?=
 =?us-ascii?Q?fe9PvTnxh2XusOWa0HJ799uroga6CoJ5trEgrj2v9brEuiaJs9WcpJs4lZNq?=
 =?us-ascii?Q?OHmcy9nq8ZyHO2fV8Qel5W+5S/dHWnZO6mxSet5KzB/P+KQrKf7L+7Ro1Rcd?=
 =?us-ascii?Q?cYqvSOZcULwibBchS5y1vm2ky5t+R8Y7jpEO2w0LbMTu86e1e8oH9YMrJAq6?=
 =?us-ascii?Q?exhCpyzcwZ9znqVsHM8+xT+ootvjcc8OEWNIg06pLs2+teDovhD30GFzNQqL?=
 =?us-ascii?Q?COQlKfo8srkltljvPQoPy5etxiCciZQd3Fg7x72h9pAlMVqvguXKgAwoquvi?=
 =?us-ascii?Q?q/+VRyjGlK+mAXfyKafWlPyz3s+aFMTqYokQnFx3iFaJryZPhle+U6BU0VJo?=
 =?us-ascii?Q?crsO5wq0M0gO6i00pygxmy7tyGRIJ+yKbcCe61wVmJalGJYQCzE2TKy68K4Y?=
 =?us-ascii?Q?0JRl++tiKqBNqHzOEDTSoT0lRTTFnVQMK0Qgxa+e7LwiFqubsbP1Th3XYFxi?=
 =?us-ascii?Q?cmXRH3c8eYKpiHw0tzlrOZ02/eZwT5wDDmqMPT7c124/X809PopoftCKYOqn?=
 =?us-ascii?Q?ZVPa7Q+BW79uToEE1p1d/aAzebaTiHv+I0hmhwl3eu58tw+28A80qJbrULmt?=
 =?us-ascii?Q?88TJwdtA5j9QnKuo8+OzUocHhrwK+it5D+mm8fxdCsZWd0bU7onQ6yNPeq05?=
 =?us-ascii?Q?xuT73Y/XOKbmeX1HrpRxaiAABVhz5l6/wmHL7TUyc/6OSe7kI+zhsssNF0Gq?=
 =?us-ascii?Q?z7h40skbN4DcZjt0R8NmV/rema1hkzdJbisdYIC6zw6LG+0R8xLGVRgtbhTu?=
 =?us-ascii?Q?Tcq/b4qrJrmxXrxNEqEq8M+sKTXkgaELvsDV/6HgRKavi/an30TdSOY58c49?=
 =?us-ascii?Q?3jg13z5gGedwunvwUGD/8VhexxTRxqLrChwdCVRqrGfzqZkNiYL1dM+Q7SQ6?=
 =?us-ascii?Q?htnnEKlTGJ6npbxA0LhSoHV7fI/+lztoBl7u/z5FVvkYzTadqblwGGq7HkWT?=
 =?us-ascii?Q?M8TNJMiTB6nmZBPthy0Dqb4xdPYM/sOHOXC6t2+dlQ1QKO2kZI4vwbbxrt+2?=
 =?us-ascii?Q?STmv26FmobFNe/3NOFt0YA6QCoD0QHh+KJppXaHeBOO8rRozx8cYecRwfdue?=
 =?us-ascii?Q?FVL9Ey/3Gnn7c2Z7pVCQAzpOvkMrHcduL98Z2Wt54lEHMOGrqlqpJreZ/8am?=
 =?us-ascii?Q?hB3jFOFYYFjhwRjLNWOACR0c?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec86965a-d0e1-40d0-dad2-08d98d4a6cbd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 06:35:04.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ctfUtfmj/d8uHtUNrBjLLxDhQMm7Yw5/TziUe1sc3PGU64qDzXQdA2fOp+L5LIap47lAgy7c2eN9okemJ/twZQ65iOPIKMc8tWduIqrTaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2320
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=807 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120035
X-Proofpoint-ORIG-GUID: FkoURdv08XFnz9Hw7RLl0S2qYex9EUIO
X-Proofpoint-GUID: FkoURdv08XFnz9Hw7RLl0S2qYex9EUIO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:56:10PM +0530, Saurav Girepunje wrote:
>
> I didn't removed local variable assignment to NULL on this patch. 
> However I agree this is another improvement possible on this function and can be done along with other changes. 
> Please let me know you opinion whether I should send one patch or multiple patch in a single series.

Since it's on the same line then do it in one patch.

regards,
dan carpenter
