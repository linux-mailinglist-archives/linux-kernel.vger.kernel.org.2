Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E629139CDC1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFFHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:02:43 -0400
Received: from mail-eopbgr660088.outbound.protection.outlook.com ([40.107.66.88]:11761
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhFFHCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBVsEPv9fILYJEgy7K0n/HUUmfNWfLndJXt/Nswt9IoVkd5eHgOegpyfztq5xOMSpF8+HuDWCh97vG3EQCfHt1xvnMT+m3HpdipEc/DxMHetFxfoFRCPXIwVPXvYoDZ88rEPUtRve6F6ZXKrUX5sUFLAc7rwGARUY6OvuUgMhhW9f8PZeY78zeJPz01kjMN0RbvvtaIkDffmhvLItPVY68bRzYLBSXjcXe+JEzqDojykdDHiDeD5yxHJ9U7QFYScpVQd8xyMCu26Q2s5WR2piKKq0NspfdJjr1m7PJRhK4woLJxeryEXWZxh5BbQkKSrWc8yC+B0OZuY34d1TC4/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xZSrYax78CWXy7ga9i9hISE7YsJfd2OXZNkcMTOQLo=;
 b=QTjzBlbbgqG6AH5hD941mFbqtMNB/a8pXgV3pkKzw9RQ37i/1uurdYnAbdBKjal5wa3H6ClH7GjN6QrhZ0JP/3QVXikxtezpcH/I1Ah2T+TbiKaxqq/OWgzXJtRT9H2OahIpobYz7IwC3Pz58n/mvlO4lkZ5HxSMdTJABDqQ1Y+dWVNVTU7mWILFTJD4YveI7VC2DND43LpQ5hoFXWrKSUIpteCIsU4Wz7Se2kKgVN/T+oP+WSECXPvS5AU91FcNeEgjGtLPF9VQg+AxV9h/lIGYR23k0/32k5CNP2UH8o4yk1TSv+Tk/p6giluSLdQAjN5RzJXH8o0np0fGFKx7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by QB1PR01MB3201.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Sun, 6 Jun
 2021 07:00:51 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35%7]) with mapi id 15.20.4173.037; Sun, 6 Jun 2021
 07:00:51 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH] staging: rtl8723bs: Fix uninitialized variable
Date:   Sun,  6 Jun 2021 00:00:21 -0700
Message-Id: <20210606070021.116284-1-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [73.63.255.0]
X-ClientProxiedBy: BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.63.255.0) by BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Sun, 6 Jun 2021 07:00:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fba14e75-731d-4810-4e60-08d928b8d1fd
X-MS-TrafficTypeDiagnostic: QB1PR01MB3201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <QB1PR01MB32019E7AEC2BFEA81A2A1657B2399@QB1PR01MB3201.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD5FN83pN/YNSZjh0eqKNftOQ2AehbZcul8BfLXMUwg0DNPCD65q7/4vsEsCQNFG/7k3RJPHas3pwSydS+S2FEFddMUm36mKrJv7zIOT0G7gBBy1JB+N+WXAKS9pYDPCfl0s8LmviV/s1kKoenUi8o9Isk81ImIM3DaX9Dtcml4AQLxBv0GWkzFE3Z1vFgQolqhONAPHa4wNvWEAYfT9oVPPQ9ku3kmmGfLTJayS3P15cBf9unESMkAv94rBM2E+RjMoGLowKCZtKU71lUvjnwJIweIjwIiiFQ3i5RV2zZwwtOE/Pr99g28zddq6XnxSacDLR1VQUe7F2uFMmW6DPSjhlxfYXzMetj7OO134ZsL9+R9XIOIdjh/YD6dvNdziG0UdU8RJqPqy9vrGgqSO/Uwzae9ntl0g/csCYp1tYtaNbgxWEX7JLrzaQABZvo719sIsppVN1/YmECjqBNpaGzTjp8ZZQrRE3t6Nc2cpOiEtKZvtjLFNXLSZYbg1B1DvprnrQrKQnqEYyCu3SASGFHOhlCcmWJtfHgcmx7SvLxS1kWAsaPDhTnKj0txv+cmaJGQ9fsRlPQUKGy2vDZzbzjpOmKgioSQjS1fUpSn18vPS/X+jRXk8lgHXhj3Rb/XgYnVlFSGgk8ywg2hvJhwB1lV7zgoqIZUCAOso0Eb+sH58eM1XXRJs4om8yJflDyRWMmuXgalvgr3EQQwPHN9LtgRfMETCLKx/SkhZM8nFNx9S9Kw3CcpkVJ516lg6t0tG41saeqPbN/D+wi0ubWsbwbf2MTDJcr44VBf1lu6o4IbfcKkwYQne9CTRNgmCQGsI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(6506007)(86362001)(4744005)(8676002)(66946007)(2616005)(966005)(956004)(66476007)(6512007)(107886003)(38350700002)(8936002)(26005)(2906002)(4326008)(38100700002)(66556008)(83380400001)(52116002)(316002)(186003)(1076003)(786003)(6666004)(478600001)(16526019)(6486002)(36756003)(5660300002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+gQrHufhJ8zJ3LatVv34gBwSXMNeEdU3laHYLfAfTkJxiyu4DcD/+lI4jp0R?=
 =?us-ascii?Q?mqIIh2/w9YRuwmRlpe/uFdAc8vRVumeh2Uit9yCCSjJA3r9XeAsP9wxBjM3+?=
 =?us-ascii?Q?6EV8ou5hyZ2cn/8f0U0byg0/jVOoiWdKj+b1j5EwipmJNAaG8ZFDFsbK52S0?=
 =?us-ascii?Q?PK3owlQFoKeT2w2+ekUTZ8rzmD9Q+EISfQlhM8DI2e6xNzYiPTl5jPfyOPX3?=
 =?us-ascii?Q?m3Sj8rB11ZLAv0QClMkhoBSeRvMUvELr9MfW21MIlTcnNLYsTwYlBnhv2W4B?=
 =?us-ascii?Q?2jly1mT106Hvhx6/atRVoBya8TQjwcePsd4t4FjgVZ111ITTraxLjbMg9sr4?=
 =?us-ascii?Q?A+WKOyL/NDI/wRGC+i5SJGBdmYWL+KTMsWKY7eDNVD91NKQ5ufnFLDHyGA4y?=
 =?us-ascii?Q?haGqSiIlCzIaf7b35wkBp356Eas3o3O4hoLrChojvXv0e7DWFoIsPPsaXQo/?=
 =?us-ascii?Q?W8mDOSvlau/CnUzUEjN/wDuqqhpXgo25pMhCDbd22k///SfuWmeFp36FvMFz?=
 =?us-ascii?Q?4kZPeQhZBPeV5SIeZYgZK1wdY+gbywnWHVXrYuyRWyZtoAsC5cNf7Iw8L/Ln?=
 =?us-ascii?Q?kmc+9nE1oQ93IieJMRpkgchSwM4PddJ1vNYlB5HAh9MqfisIvL69rOrc5pqX?=
 =?us-ascii?Q?7itdfqUulVExG4wEfpEC1dMOyjY1L3a/EJkVMfWl1jjenjAs0ulQIvocpFz+?=
 =?us-ascii?Q?oTY2RpcMLRUF4TeUCqPR7KAxfixKbddUFP0wFdRFv74cy/1OXzKIb8mzotur?=
 =?us-ascii?Q?yK1udXFSVZxL12hv7SPEljFsDEdBMGiglpsQAcr0kDgId0etmrU914bVQ/Ex?=
 =?us-ascii?Q?7qqV0EkTXbNAsLCMJdDSWyuihStwcp1Nz5gIr4THyxJxvMc1iOn8vjlHmXi5?=
 =?us-ascii?Q?m/6Nil2e2I6z2ZupZXdAWbMpu5pt9bDyDSRG5lh8pjo9shVcdXwflx9Yq4Fl?=
 =?us-ascii?Q?2TwawjHB4FBVhFc16sUgubQjkDe7L+zLXmHdNNWG/4ydcpfl0Lzx14I39y5+?=
 =?us-ascii?Q?xxVNFYGKT4vSJtf3HA35C1EyE+llbznFgvBIjBHm5JGuAbfBAfEIW7+9O+aA?=
 =?us-ascii?Q?jBONmcr4VuzJPGN7Bk5BUExcb8C12TPY1WCxvtBMGCE7pi0dHLO4aGeA4Ui0?=
 =?us-ascii?Q?mwN3nwoZRwUYnIyijmTJTmh9RopVTc2s43Y8SFUHfJtJUWrSc5wyIoPF0zuK?=
 =?us-ascii?Q?Qa43h0YXhDrE/1gI0fn/UNFPT9xT6v9VSGqzMTrCPzeRdj7ZB+AKMbC5sB4E?=
 =?us-ascii?Q?AaMKuLCIy0iYZtjo699GZpBX2NLcK377V9ZcPCbqpXFUgBp2jqp9Mbw5ctvA?=
 =?us-ascii?Q?gU96mQ1PfiHKKKN6J3VvIvPB?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: fba14e75-731d-4810-4e60-08d928b8d1fd
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 07:00:51.4186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHFGV0kq/Mq8c6gIcvz8D35sSF1n3oInvUIwiCICZlooa2paCU78Ch7UJQKtAJzufbo19p7CdHKeas1WPxRWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uninitialized struct with invalid pointer causes BUG and prevents access
point from working. Access point works once I apply this patch.

https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
has more details.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 2fb80b6eb..7308e1185 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2384,7 +2384,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame,
 	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
 
 	{
-		struct station_info sinfo;
+		struct station_info sinfo = {};
 		u8 ie_offset;
 		if (GetFrameSubType(pmgmt_frame) == WIFI_ASSOCREQ)
 			ie_offset = _ASOCREQ_IE_OFFSET_;
-- 
2.25.1

