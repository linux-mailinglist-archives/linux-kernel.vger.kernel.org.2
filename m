Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98B139D084
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 20:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFFSvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 14:51:15 -0400
Received: from mail-eopbgr670081.outbound.protection.outlook.com ([40.107.67.81]:28059
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230139AbhFFSvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 14:51:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaMLQBoBu5xSusOz4yUm4vidGyx2p1sqKGW/x3s2TxaAUdTnqx5ewMzMJGoT7sRkNrZqjK020NsfoefiOPIGVcDiXLpT6v4WaiKcuIWydUphc97rXoB2cj+EsrmcoSOmK4XGX4du7Y2OiK2SquGtNeo63SMMnxk5mRljuE/h/ectL1HIGuzzbJTOeykdBHZ+WdtuxqJWQ3ePZvy0hvD70dRE8JQC7+TELYE4HzIunQ6brDpB8Kf9RTCbig/5Xcqt2w9N0uS+L8H3yPzerFpxJKQkWisR/bToFVuicVsvF5gLqhmuBIJRHTMv9zp4sBTcap2IZOZwWu4CQWrp08H7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaK3biLen1IXRRuqS92pil2ao1Ex6ZLfexBKTHjRHE4=;
 b=a16mcTrQATNQNIPdN3loZK45OeakVNHb4nj++Dp7cPMy/p0abPtMYNCcHwaY4W/Xy3N+P/9BQ9zQQccfYFYgL2eX9pGo5tJoR9M+xIeeUrx2Yidw3rLCVi46O3Yci0/C3uITL9beojLxbf5T/sHkixNGFoVBB68Zg5d976AostKUsaiRFiqVGkqvZZppXL/9JY77kaK+IhqPKJQ+4P8RLgd+76Z4Vrguj7DwGNprFSqSdYXZNeJhapRbFeqo6KRAmJ6w8vzHqJwqfFbrDyOv1CNpVL68KkAhy9WN7lFdBfioi6ql8uG284U96BcVKI7ugFnQjotlJd1kzyyek6OwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YTOPR0101MB1051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:25::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Sun, 6 Jun
 2021 18:49:13 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d0c6:4f06:64a4:5986]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d0c6:4f06:64a4:5986%6]) with mapi id 15.20.4195.030; Sun, 6 Jun 2021
 18:49:13 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH v2] staging: rtl8723bs: Fix uninitialized variable
Date:   Sun,  6 Jun 2021 11:46:38 -0700
Message-Id: <20210606184638.13650-1-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7256195.zb9d8qvCYo@linux.local>
References: <7256195.zb9d8qvCYo@linux.local>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [73.63.255.0]
X-ClientProxiedBy: SJ0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::25) To YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.63.255.0) by SJ0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:33a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Sun, 6 Jun 2021 18:49:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60e3483f-509f-4c01-b0ad-08d9291bc706
X-MS-TrafficTypeDiagnostic: YTOPR0101MB1051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YTOPR0101MB10517B5EBBA4B295D534DD58B2399@YTOPR0101MB1051.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aivn5USlIepGgxI7k4xab9jlOoWss77STj4oAe1jEukyJjohQjFhesTTL2W6YnETO0b0mmITXxC0eoNJ7vOutFtWNQOZE5WI5VfEivtHGNkJzpJhVSi+KXBNarMcYc/695UsW+fujaAS8cNTtCmrfZZbJQOU/yFAJ4im7Fwt2rm4OLDnXReOAWDMlWGg9WZTuznX/gZuwUTRRJrew4UzLK9h1vYUdwEJ84SqUGAxhu+TLkX7Efg82KlCWHbj5Y1jHVVejxsm71c+D1jNpzcmcP7Syhs9IU6csGEx15RTFd1jQQwoipH+4awQHqRauPtudqvW+nfsFGxbedcq/6ug/Bj92zZYF3jrdj8tD9mjNSvQSfuaVfcgB5sJvwQff1vuuAxCFuAT+7Zj1QXzzWa0YaRCEq26Pg/EMt6dAogGH1ZFYWCDgXerorSGdUSar8qpRMrmvVfU2yeuBUBbOuUbemawC78K0n3ogXrjGi6uIsTSib6f3Og7qsszEec9pogIBGSivLzOPwmZZh5DeksCSLxeV3Qm61twndGE3LoR7Z9HN7c7+reJDXBvTpySeJY4MUoznt8mZB6KH3JML/cSZTsUQDxv0FjmoDgHe4KxG6fMMkt01WahIRH3dniMBKo+kPlRUQJClI7CSX4pHcThiTNNfn6qDzF5YaW+ZxV3w560R1UsJFS3MeecY3zL33z4gVjHdb2vGblIKIespxM7ev2gZ6FRstZQ0+3Tt+z9gAZxYE/uWPbFN9dd0DUtNnc0Pz2wmXAD14bVB9qHcDgIxX/fKqzR5Qy0AJMoxSsK3YUd/9szOkVIPsT1QPhAQnnBod74U8dZhhorfhzf407xhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(956004)(5660300002)(478600001)(107886003)(110136005)(66556008)(66476007)(8676002)(86362001)(26005)(8936002)(16526019)(186003)(6506007)(38100700002)(38350700002)(966005)(52116002)(36756003)(786003)(4326008)(316002)(66946007)(83380400001)(2616005)(6666004)(2906002)(1076003)(6512007)(6486002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t2akjpib55udfwZ9u9n6JJS/vQVrexHmS+0JcLy0heb528XckAMtKXKUF3La?=
 =?us-ascii?Q?uZ661riwU804g5atVA3+goH534JKOa4wLg5y91oPxsFWp9xtHn7btbh3Oo/8?=
 =?us-ascii?Q?kLwRkItlV5GPwJaxIK4bHFsWxZRMZBLfPyUCum3dph1Y76NBrPK8WrYG8jsx?=
 =?us-ascii?Q?OTdd1ZU0oAtYHdiYzhRJHNk/X0red0zd3IF67EAHBw3BbGavuhCDanDsuJOZ?=
 =?us-ascii?Q?1cfe3sopSlt/BA9xV2Ip5lUY0GhoBUwmdflDZeLurJUDIAKAdEiqVRM+Lw6Y?=
 =?us-ascii?Q?2X5CVGWW28O2+wdIdsN86UwrklhL7QJLL5qUatZ1ox/mqDr3ZOwPpOKBJ0xq?=
 =?us-ascii?Q?1m+NGyok35gcQJOSpWQyHaT/C/QVFNA/czjDbp0O/HOBEKXcrLHEpq3YBppW?=
 =?us-ascii?Q?7Dtk8psUygHZY34pqQvm+bcm3x1JlFgZYBaDyNn9CbADr7gREBL7lPlgC08n?=
 =?us-ascii?Q?NYpc6ep29RYqDWwkabD+jPZO6fvaujw1wFwVnqLMSb+1ZuAMlEkD7YC4FYIz?=
 =?us-ascii?Q?kLXmsD18rOxiGJm7CgkKdDkpTDY72vcdtzPwngSpLFlHJMfO2V8LhY4AO1HW?=
 =?us-ascii?Q?OSoBRmKj7Q3qmB5smuQbyXS/oG26eCqogN7neVS+ezKUDVz7hIUB5l6OJn3p?=
 =?us-ascii?Q?NHhwJlBLbbdQOmtoNolJh+x6bbeNQGmqy0+Kv1tQA1pwmw8/5arxp7aBgvsj?=
 =?us-ascii?Q?yFw4cNMuK9min9zEBX1KO1isdlMwfDPDedzvFDFCY/Flge543rK+u/q9CbfT?=
 =?us-ascii?Q?KnqsA7BN1vK/qiaQRnyZgbXBRITM9ZJHbtQj8XE8I50ihk7i+pgHBmN16nTf?=
 =?us-ascii?Q?gXdH417TfZSmIwqY/hStdB2whKYgY/q3Ct2jDivA/9Y+1gsAxd5FPYNvtPmY?=
 =?us-ascii?Q?7xJlUNppF8vfkZf6vnnfCCBNdgC9YvXeRLXOQvOw4YtbnM74kQnJgrp0F9Aw?=
 =?us-ascii?Q?xQl176AF9K9avT7TBFtuO5IegWXRXhHATsxF09uelxqHVa3zvKIFqpd9VKxY?=
 =?us-ascii?Q?U5mD8lZUrRj46CaDSyQY32pnRhKbfNwfS4uiRTea4ZytWJ7vHvyOOM82o4YA?=
 =?us-ascii?Q?/5Jp2WbGWUzVzotk2+/STcInkRsF+uMd7BrTquXWZZs74/I8HFFkFFseOH4M?=
 =?us-ascii?Q?1c5jaCvUVjQn3woVgHRU6zesr/sRu+khySZmZp1aTwZOnIfDRNT5ZB+QcMuk?=
 =?us-ascii?Q?7NvPZaeEVDzTSi6Ed9EuBWz1e3LZp50QuGuy+ZjMpMip16xm24P2ylB8JiI0?=
 =?us-ascii?Q?2KVkx2BLiNwGBxClgA2u9yQMwLNcxrXYnF/20+XH5dcla7VQ+JB1AyD816F9?=
 =?us-ascii?Q?bsl1F72SYbXwmbRdaqaVpiV3?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e3483f-509f-4c01-b0ad-08d9291bc706
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 18:49:13.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oXldkt6SNdhOh0qIa33paPHkYOtfzawkVAUDfPTw4O0L9eVx18tN6cC83yKyhjCbdJpEBHo3Tq/NuMOzM/7ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uninitialized struct with invalid pointer causes BUG and prevents access
point from working. Access point works once I apply this patch.

This problem seems to have been present from the time the driver was
added to staging. Most users probably do not use access point so they
will not encounter this bug.

https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
has more details.

kzalloc() seems to be what other drivers are doing in the same situation
of creating struct station_info and calling cfg80211_new_sta.  In
particular, other drivers like ath6kl and mwifiex will silently return
when kzalloc fails, so this seems like the right behavior. (mwifiex
returns -ENOMEM from the place kzalloc is called, but if you follow the
chain of calls, the return value is ultimately ignored)

Links to same situation in other drivers:
https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/ath/ath6kl/main.c#L488
https://github.com/torvalds/linux/blob/f5b6eb1e018203913dfefcf6fa988649ad11ad6e/drivers/net/wireless/marvell/mwifiex/uap_event.c#L120

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---

v1 -> v2: Switched from large stack variable to kzalloc
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 9a6e47877..3bc498558 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2082,20 +2082,22 @@ static int cfg80211_rtw_flush_pmksa(struct wiphy *wiphy,
 void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame, uint frame_len)
 {
 	struct net_device *ndev = padapter->pnetdev;
+	struct station_info *sinfo;
+	u8 ie_offset;
 
-	{
-		struct station_info sinfo;
-		u8 ie_offset;
-		if (GetFrameSubType(pmgmt_frame) == WIFI_ASSOCREQ)
-			ie_offset = _ASOCREQ_IE_OFFSET_;
-		else /*  WIFI_REASSOCREQ */
-			ie_offset = _REASOCREQ_IE_OFFSET_;
-
-		sinfo.filled = 0;
-		sinfo.assoc_req_ies = pmgmt_frame + WLAN_HDR_A3_LEN + ie_offset;
-		sinfo.assoc_req_ies_len = frame_len - WLAN_HDR_A3_LEN - ie_offset;
-		cfg80211_new_sta(ndev, GetAddr2Ptr(pmgmt_frame), &sinfo, GFP_ATOMIC);
-	}
+	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+	if (!sinfo)
+		return;
+
+	if (GetFrameSubType(pmgmt_frame) == WIFI_ASSOCREQ)
+		ie_offset = _ASOCREQ_IE_OFFSET_;
+	else /*  WIFI_REASSOCREQ */
+		ie_offset = _REASOCREQ_IE_OFFSET_;
+
+	sinfo->assoc_req_ies = pmgmt_frame + WLAN_HDR_A3_LEN + ie_offset;
+	sinfo->assoc_req_ies_len = frame_len - WLAN_HDR_A3_LEN - ie_offset;
+	cfg80211_new_sta(ndev, GetAddr2Ptr(pmgmt_frame), sinfo, GFP_ATOMIC);
+	kfree(sinfo);
 }
 
 void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter, unsigned char *da, unsigned short reason)
-- 
2.25.1

