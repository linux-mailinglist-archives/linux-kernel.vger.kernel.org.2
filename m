Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0820331CC99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBPPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:05:19 -0500
Received: from mx0a-002ab301.pphosted.com ([148.163.150.161]:51226 "EHLO
        mx0a-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhBPPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:05:14 -0500
X-Greylist: delayed 1448 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 10:05:13 EST
Received: from pps.filterd (m0118790.ppops.net [127.0.0.1])
        by mx0a-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11GEasH5021663;
        Tue, 16 Feb 2021 09:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acuitybrands.com; h=from : to : cc
 : subject : date : message-id : content-type : mime-version;
 s=pps-01232019; bh=dhZsQTawFfeyWmJtSbfRZs1hqZoOZg8C/iQ63+D91Gg=;
 b=shJnDycsgXjSv8eJACxoSw9rhQwyoGrSODG2OMx+UwNi6sh4oZlHrAKhlfwItMKGYnpe
 pJVdr3WF8u/p89+sctdFB+ojFgHFismXQLQ0hT/2ohr4lVhCkzAoThQ4NyY+HHRky5yM
 yfBFusFZdvqZCyGK+OgpUCzzT10rhVHo260HNk9fP+VvKpEhlBpAwuPMDxNJQH9Q1MpG
 +KTPLntFh+OxCWPg+TAsxEE69NWDjZuwd56ktwVy/SM4ZdJDgm8hxvTHgjvZYGr67jwB
 Sy2YIAHBnxxFeTymCa+wpBLea0YKz8FsPmNemG8AudoSpsB0gTx2L4sIS+OIf2D//DZq hw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-002ab301.pphosted.com with ESMTP id 36pb4ctpfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 09:40:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doykzWKh49M/BMWEzJ8Q5BUCIcQiE35sZQz8yOrDK+skHP+R4KtFqdoKDk3Nrz9gR96nKmf5VLCFsKh5yOQGJ1koZlCZ3qPnx+N2nuC141tr67ZyM+KpycEezZlAmfdUphDF6aVE2WFNrjNWwGksBLNWB4oZsBNu15XuyEgsrgeraIwdojtsalQ5dvKvZTcP259ce11+Klk9aVex0ut8aSE7OQU9FqwEHLU1T64FAvvxLtI9LpxHxQr4kDtcKb+lsmz/UxUsPQ8CLmcIE5QFbajfpZKzwQavumpumlm25O6OfmVwN80ZMEwknts+mXHxoPBytP7N8MjuZSTrGou3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhZsQTawFfeyWmJtSbfRZs1hqZoOZg8C/iQ63+D91Gg=;
 b=kQuTqYN7OCmLgBxLrir/NV9e5NtpLWturyBYfmpS7JL48TI7ra1AViyUY7IqdcOs4NkaEhSlPoi3ARLKiqqfYH8s52y3TtWEC1f7/z+yEy8kzWn5qq2uQQjdkNFjXQ4kpRfu+iM4YFWU65S9QwrRQPPD35vaLbaDqxNn3liP7FkGAiu2cfZCkYCJ1lQyR4uuHOnedz9jgNXV+oOy8LayQlznVggcy0zOIYODzarOywkvwrElMwmzC5BZz/OyjyUmWI74kfjBZQtt/6PAFEJjQY1TLecSxnozrqe+o2UX/Nd8G6ASjee5yDN6mbeMlvkka9fhW8+4v1Zph2EUEZIaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acuitybrands.com; dmarc=pass action=none
 header.from=acuitybrands.com; dkim=pass header.d=acuitybrands.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=acuitybrands.com;
Received: from BN6PR0101MB2995.prod.exchangelabs.com (2603:10b6:405:30::10) by
 BN6PR01MB2467.prod.exchangelabs.com (2603:10b6:404:51::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25; Tue, 16 Feb 2021 14:40:15 +0000
Received: from BN6PR0101MB2995.prod.exchangelabs.com
 ([fe80::8040:b823:92b7:aa14]) by BN6PR0101MB2995.prod.exchangelabs.com
 ([fe80::8040:b823:92b7:aa14%7]) with mapi id 15.20.3805.033; Tue, 16 Feb 2021
 14:40:15 +0000
From:   Karan Singhal <karan.singhal@acuitybrands.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Singhal <karan.singhal@acuitybrands.com>
Subject: [PATCH] USB: serial: cp210x: add IDs for nLight Air Adapter, Acuity Brands, Inc.
Date:   Tue, 16 Feb 2021 09:43:33 -0500
Message-Id: <20210216144333.29262-1-karan.singhal@acuitybrands.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [24.98.66.87]
X-ClientProxiedBy: BN6PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:404:121::32) To BN6PR0101MB2995.prod.exchangelabs.com
 (2603:10b6:405:30::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (24.98.66.87) by BN6PR18CA0022.namprd18.prod.outlook.com (2603:10b6:404:121::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 16 Feb 2021 14:40:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c227187b-56ca-4ad9-8a3c-08d8d288c622
X-MS-TrafficTypeDiagnostic: BN6PR01MB2467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR01MB24676DBDE625D4AA9CBC25DF81879@BN6PR01MB2467.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qZoNIiIhTELuOLBwwLa1uadulCRaWd+EnORUwKcEgPOuCXELy5vbItZeqzONNs+1Gm/iXMC6WOWi2tZ1U/umkQk/j5AQzBh3br2NvXNURxautln9/m7QnRWgRqcnwQPPDp+jAiKHSEN0iz1AWFm20Pwa0UdwxIsbPXFWqrXgsjDXyXe+HwuE+MjCEMzXLTcd9bjR65KqtwD4to8aYgSK+0Zmmm9CAT4m+xCBN0dttj77HIzAfxtU1xPChi4n1BxHY3AKhpEOK2tBHoJs7+m372aRxQFmoAqs6iTPX1xrqE4P0KurRqWtBybsQwudLRGN052Fz0DZCWrooxJd9qO8afElKxXt0fg6/oHERu0v2hrIvpAtxxwui9lm74102wccg3MqDUnkmHYIwVYRmEdtU7EWwCqpC4bo4xhbp0x5x1oNDp47XoxTgTYurXf4YULGY39IyOWYhUynQ4L4Uo4tEyODhv19P0ntQzfTK7/PQdEERc2yVhiBFzpg3VMFgfxAeTBkm0vW1DDZkLS3ZG+oMk+47EsBwxoz6G/aJhj4un7sxx5VHSAA97a/hauZbx+QulF7e8ZxAjmoV5nOLgyFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR0101MB2995.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(86362001)(66556008)(52116002)(69590400012)(66476007)(26005)(6486002)(66946007)(107886003)(6916009)(6666004)(6512007)(8936002)(4744005)(478600001)(2906002)(16526019)(4326008)(8676002)(186003)(956004)(2616005)(5660300002)(36756003)(44832011)(316002)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?51qOAxFZkDRWym9qjETxE43z3JfkiFYEO4nLlidLEhbqEFrYcSkjE4HdafDD?=
 =?us-ascii?Q?57j7yxZ0pVE5Y+Wfi45bglZovjhZ0BoCpII9UREE9l2xAbgMFrjATHGXkpOH?=
 =?us-ascii?Q?ytPzCxXYBoyHFuxLa+h4tWvq8xiaHHUnifIHKxm1RZJFXSX32TiHrLxqbCxd?=
 =?us-ascii?Q?CHgk/J127CcN2/vyerwax8YysrhVPtaMtXZWL2vCqWtHgiPTNQx7oy6towYS?=
 =?us-ascii?Q?oRKiiAI0Q7mrCn6p2G7gTxAq+xHcGthG+gXN9gZWBHvRCfg7h6zq14XvNweB?=
 =?us-ascii?Q?P+llAMfOq70Jj/Qcyqm/9Z55rkUEpCd1hX0PFLru6lgBvgwDSo28uixD69WM?=
 =?us-ascii?Q?vvit2AOjwbZpXzgjBWRtYIvvxCQrTQf4Qqd+Lfmo8xKdP6v8CG21lT7zdTdg?=
 =?us-ascii?Q?fIbgiZLVyRZSke33k1YLfPmI0lZOCPATzju16udpsoIQu95t4U5BqL31AzDI?=
 =?us-ascii?Q?iLDRuKeCBhp+D8stDmo/bRj3X11KeWZR1OSciv/qqPnst4BNyagU2Ud9S8OV?=
 =?us-ascii?Q?nI6iq7rsB4tssM6dqnUHB8vTHRS63yE5fVVG4wcj2HZdTL2PzKdf1WZkgm3I?=
 =?us-ascii?Q?ztfbfBE4JuWSZJC1H4JZxx6rQHwMGkjFcbeDifPQ445IT17h0HInI+vcGAf7?=
 =?us-ascii?Q?hThV1/MmmvsHOFB8Dw8OoEuLtIS/I6YjfPGfq5WWb1uUbudXuHJSq9VMZsJq?=
 =?us-ascii?Q?Iq55E8YIKB1ZHoKtUywOvDsCTE9KND59HSfgVKVKdWT7RLi6xF66nBRIYifI?=
 =?us-ascii?Q?+6HSpFG6lCmYttkToX5umNkK5wXlQeFrcf+1Fb4QUphy3itUytqTqPhkKdZn?=
 =?us-ascii?Q?sXXG8bxbBu4DG2ppBq7yNSvNCBhQmv3dnYrAf74gljnXOAOG7TUovZFnVC2X?=
 =?us-ascii?Q?UULx+A6BLoJ7fTDrSk6XK/Wxg6HvTeOsykQf8+GTvu6TRoUFuTiO/XkmvDLH?=
 =?us-ascii?Q?eqzVa15ofJWvLAcfD05cJPtDvSPts7FXyyRuc59KO0TgSXLy3P80v4azBprp?=
 =?us-ascii?Q?BxUo3K4hV+jDIm5LO9qn0rh9n+lgR1jx44Pmrt+AJR+1LAPAFJYJ0t2Wj1LB?=
 =?us-ascii?Q?OmN+KcPGtYMoAIQYkQJ66yvXcGUkXp/q0qWi61Ic01QaEVx0JeTJZg8qQogJ?=
 =?us-ascii?Q?SwQifmGBalN0YnQo5hTXX9gWDTVIPjUJ9XQJVM9Ihr9fJQL6EE92FMV0DYUz?=
 =?us-ascii?Q?36qBCUevFHo6q0e9Zp0ZEgBLNSED7JZ7hcxl3Y5sN0tCjNebL6U6vOMU65+S?=
 =?us-ascii?Q?8ttiWEQ95eG1bztzGnJ3Eh540zO0axiWf3BUtRBnpBi1kZzxbXo4HNGR7c/M?=
 =?us-ascii?Q?tPp379GKq0V8AP1hfXb6TkFH?=
X-OriginatorOrg: acuitybrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c227187b-56ca-4ad9-8a3c-08d8d288c622
X-MS-Exchange-CrossTenant-AuthSource: BN6PR0101MB2995.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 14:40:15.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ize1GxpVYtI2cmIGSA25D7NdABhDQH/qVJPgA4qQzmOqlHmPN1U00eGiMTitGKkekWD6Xghk/bEsstmUQuvlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2467
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 phishscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 spamscore=0 mlxlogscore=619 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102160135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Karan Singhal <karan.singhal@acuitybrands.com>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 7bec1e730b20..b82bb130710d 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -146,6 +146,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x8857) },	/* CEL EM357 ZigBee USB Stick */
 	{ USB_DEVICE(0x10C4, 0x88A4) }, /* MMB Networks ZigBee USB Device */
 	{ USB_DEVICE(0x10C4, 0x88A5) }, /* Planet Innovation Ingeni ZigBee USB Device */
+	{ USB_DEVICE(0x10C4, 0x88D8) }, /* Acuity Brands nLight Air Adapter */
 	{ USB_DEVICE(0x10C4, 0x88FB) }, /* CESINEL MEDCAL STII Network Analyzer */
 	{ USB_DEVICE(0x10C4, 0x8938) }, /* CESINEL MEDCAL S II Network Analyzer */
 	{ USB_DEVICE(0x10C4, 0x8946) }, /* Ketra N1 Wireless Interface */
-- 
2.17.1

