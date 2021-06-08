Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D662239EEEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFHGs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:48:56 -0400
Received: from mail-eopbgr660045.outbound.protection.outlook.com ([40.107.66.45]:32791
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230212AbhFHGsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5G67j8p09BHXZin9sVqD0iw7vMfTiaY+iWQKXyBCbEAHcC1aBbRSsqWShUzuO35+KO4FG7LFLjhBkI1e58k+08E6TsHSkhfVr/kRV0ITxo/roSYH2FtTAuo4lOpRme3MqdxpBICkiCL9KYQqcfx26P5Hcw0r0JlnjnTp5QuJ06TWIVFt1hW1LOv16AeRKz1HJu77neqGzJ6i0i4OK3Q9BcQ6ljLASm9y8/dlck+SK0Tj0RjDl2PBRNtT4/qbd3CBEgE74qBhpfglRG3eTRTxtgGm9DIB9Nb1qMQsxuPhFDwPFbDQpcsKCc+5znWaQ9RSC8HJlFhA2HFtQkCNaratA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQnNrHBYu+c8flz/9fdgLINne9JX069TdCGnbZtblu4=;
 b=RLGLGJ5bojw5dOCgZrMROlvwnJHiBRBOr0SydfAthISw3hzUilDo+tkmLPQblqEuANA6QV2CGYbyzGHQbg+5yf1VAnKTzl0rscT4/3j1uQtUn5peesJGaT7dlo5tnYjjSxD+RT41W+WfLDMh9Cxknrz9Ua1KuSfechbGWZA8OnyLUDaTB0oHXFgvpaiRadx/q9vPqF2cKbkeKF9Uej/oH/3z1JI68GkYtuNv3iGz9cXiPIOjLf1daWKeLFxqYdBgU8V9Ci4fCwX0VLoIURrOe9mnHGUtSv1bL+0rewy3wXS+oVrPMBgIZR1SXY6B8pWn2DPQQZgtNSkaGaDP2cgEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQBPR0101MB4682.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Tue, 8 Jun
 2021 06:46:59 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90eb:8466:4635:4b35%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 06:46:59 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH] staging: rtl8723bs: Fix uninitialized variables
Date:   Mon,  7 Jun 2021 23:46:20 -0700
Message-Id: <20210608064620.74059-1-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607083316.GO1955@kadam>
References: <20210607083316.GO1955@kadam>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [73.63.255.0]
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.63.255.0) by BY5PR16CA0014.namprd16.prod.outlook.com (2603:10b6:a03:1a0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 06:46:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 481bb6be-e1ea-4b88-663f-08d92a493702
X-MS-TrafficTypeDiagnostic: YQBPR0101MB4682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQBPR0101MB46827CAAB142F75E008CB165B2379@YQBPR0101MB4682.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7L1kZ39ScVZE9zbl7F/eytq7AhaMTTvS3xunNkRN3Qz0y+vRdlxE6vC1Hd2NK7On6BNtUW0jBPhGp5EY9S9xxvlbqV7Vz6csSm1jVARhV5aQR8uvn7mI5GAH5+wAcFBPv1imdCA8K8/im9GH/0h0tubD91d0LhpyFQ+OhgLC++t0RISb3aY25su+zzxUkKCGLsZwmwt5ddBsQE/RjRDa94/+hbhFnPdBn18tWHD6rlay+Md9rC4aT4/BJV2erH7ytEOreHTUYCtNUuiAJzdHRkzNF/Ygth+Guxfn5yu/aM8CbfApVyAj2G9B5Tls+auXJFMFobPTAVxtTx81B+4kYgffAagRF0LHezKsn7B9H0WPLu/yaEApF7Zl75cddytc6YO01x0rJuUivalrkkUoFy30PN6SwYIAczb4xr2UvCyWcN+WR+/4HbF0eq0yfh3O4EYd2eraF9XWYIW9dNru1rRwaoqDTW7Ysfhl5iahAtxZj2C9QeTsuqfPzgRHFwLImZ+gKd0eR1HIexTP8xdRW526cqua8BmcqhHgIDVCETGkzT2CP9pmkULugr6e1k7+2M1tFEwVuSZvS04Biij3IA7an5hDlFcrjRL9tFvAwPmz1TzrKzIsXGywab4cmJ84xmphbf9frrmQ8Q6AFYOFf83Qh23kx/PKxOHVHAzLTJxbppNR9RCFBI/x3M68zzBgSvTBj2lOQLOB7w3lMAkPgRRQmBEADCo6hqV6LvMUvn+2ItWjG5pKNbhcLJl5DubejUSbHxTU1YJmfmfqaFIGQU/aTEp/33+LiU8dN9NA5TpjDZgq0bJyM6DD77s9Bg7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(38350700002)(6506007)(8936002)(186003)(2616005)(38100700002)(956004)(110136005)(966005)(316002)(83380400001)(107886003)(786003)(5660300002)(2906002)(16526019)(66476007)(26005)(8676002)(1076003)(36756003)(86362001)(6486002)(478600001)(52116002)(66946007)(66556008)(6512007)(6666004)(4326008)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F305jSUGYEFPRNFkh0/acjgM7gG19YXGZkZrBGEqcXj3FqSFkXQuGW5qI3N1?=
 =?us-ascii?Q?yabGLqSScWSW4AVGDWcpo4wuG9PnAq/YPdNqTkjnl3TnpUzPH1fRV/4D3NRI?=
 =?us-ascii?Q?rlypSUhJ5iDVVR0HPvCjP+aA1vyGPfX0owT7UVdvHD4+ZS9TUzr1pzYzWXzf?=
 =?us-ascii?Q?KVPxq2ygDbSOSrl8RRxeRWXTKCvih2Fu66uFmNQfih0TzIYTs43FvYAyhFH1?=
 =?us-ascii?Q?TqRSrM02lypkJLMV8mVJC0yLukhltK33PPu0IH51Vy3aZoItLBZRokvPqT/8?=
 =?us-ascii?Q?RiHPeWQVQycsPJKuyWlO0Hqqef+hD78yJsP3U2gLA0Ov+NdDBBrgNjPdGBmb?=
 =?us-ascii?Q?SZFGCzzylXJWUJBL1C0KHr/hrIoDgxsL8BqqFMoMU87tFlBkpNwRhAemZEtx?=
 =?us-ascii?Q?PiETWL/QK8Keu6/8ZQyHrHYPs3BfRzsBnZVOhbdUHWwmyeY+I3Jx4G1KAH3f?=
 =?us-ascii?Q?+yIsm7bXz5zM6gNYPX+ljkjwzCr4sAzuA8NOGe6l0I5HxIdLYAl2ZtRY+XLd?=
 =?us-ascii?Q?R2stL/xQ0m/JAXg6Gfj2JoS/ATY6Is87wRKQrbhKnx3MS/C6gvH3UL2lle7l?=
 =?us-ascii?Q?HCsP6NRZ09B2P1WFkvU/cl0wAgLO+bCj0HpZrMCZ0T2xK5frZs5WLnyqhfXQ?=
 =?us-ascii?Q?VueqZCoSqNRIscrxG39oaOfDT2011/ri7isANkF0Nz39SHqQIw2vWrXnbyT7?=
 =?us-ascii?Q?zgcshnrgcgTUNQ52O7DMbDBVNwv4ECImAhZBggZlhiknq6qKAkAeyvCM9dwC?=
 =?us-ascii?Q?1kzHh5FIp3zs667T4bQP7HOHSjcca2wm7vWBCl0bSCmCord/H7T7nTLxT4yn?=
 =?us-ascii?Q?uxOMtY8CLsKUJrF0Y6+52SLwHaWQc2Ot1XP/mV3eLFqxT5aFLL24AmXIq0gL?=
 =?us-ascii?Q?kTftAfmKS7QCmpkuGVlT6PCGd8dxs2dq667Us/Yg0D4jd+2tDzeGQ+fAhI38?=
 =?us-ascii?Q?3Gymi7zaOu0QGOkogJMtGcOsvFvNu9GLdVD+rsdzfs4ZVhfYkq8N6Ih9XHOQ?=
 =?us-ascii?Q?B/cqjpH5VgmilfDg9tWrn6KTrpFh380Tb2uqbcJ7ADFanc2khmX7u8NcC/g3?=
 =?us-ascii?Q?GqDrGnAt7R2NCw5a8+dr395/qxTBUPvV18yBiNlg56lvP04lX/5nGbvjY5br?=
 =?us-ascii?Q?vM6nnc3jk789jgLJlmdi6ko9ax/9r6O4AzDty/k2DDR/aeWyiK+wmvLrsY9k?=
 =?us-ascii?Q?MX3+4Bsc2oihY9iIkt1xwl5bZ8Xs+KQiBKZstyfj37j4IWTMKSflfeW685Vl?=
 =?us-ascii?Q?BrVvJ+e5SHLEBigw1uVB6v5I1Pxr2/j/vljxxNhvlYIKYe0dqp4O57nobZh0?=
 =?us-ascii?Q?zl5Ysz+2uUj9G23MAZeKIhl+?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 481bb6be-e1ea-4b88-663f-08d92a493702
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 06:46:59.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DE8ybLAPtxUm0Yl9SmFFGJb7s1ERXFD3K2xbXNo7dhTjKrDQqAGfavIidLdKF9bXFVXVelM/IsM49DbZ3n+EGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB4682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sinfo.pertid and sinfo.generation variables are not initialized and
it causes a crash when we use this as a wireless access point.

[  456.873025] ------------[ cut here ]------------
[  456.878198] kernel BUG at mm/slub.c:3968!
[  456.882680] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM

  [ snip ]

[  457.271004] Backtrace:
[  457.273733] [<c02b7ee4>] (kfree) from [<c0e2a470>] (nl80211_send_station+0x954/0xfc4)
[  457.282481]  r9:eccca0c0 r8:e8edfec0 r7:00000000 r6:00000011 r5:e80a9480 r4:e8edfe00
[  457.291132] [<c0e29b1c>] (nl80211_send_station) from [<c0e2b18c>] (cfg80211_new_sta+0x90/0x1cc)
[  457.300850]  r10:e80a9480 r9:e8edfe00 r8:ea678cca r7:00000a20 r6:00000000 r5:ec46d000
[  457.309586]  r4:ec46d9e0
[  457.312433] [<c0e2b0fc>] (cfg80211_new_sta) from [<bf086684>] (rtw_cfg80211_indicate_sta_assoc+0x80/0x9c [r8723bs])
[  457.324095]  r10:00009930 r9:e85b9d80 r8:bf091050 r7:00000000 r6:00000000 r5:0000001c
[  457.332831]  r4:c1606788
[  457.335692] [<bf086604>] (rtw_cfg80211_indicate_sta_assoc [r8723bs]) from [<bf03df38>] (rtw_stassoc_event_callback+0x1c8/0x1d4 [r8723bs])
[  457.349489]  r7:ea678cc0 r6:000000a1 r5:f1225f84 r4:f086b000
[  457.355845] [<bf03dd70>] (rtw_stassoc_event_callback [r8723bs]) from [<bf048e4c>] (mlme_evt_hdl+0x8c/0xb4 [r8723bs])
[  457.367601]  r7:c1604900 r6:f086c4b8 r5:00000000 r4:f086c000
[  457.373959] [<bf048dc0>] (mlme_evt_hdl [r8723bs]) from [<bf03693c>] (rtw_cmd_thread+0x198/0x3d8 [r8723bs])
[  457.384744]  r5:f086e000 r4:f086c000
[  457.388754] [<bf0367a4>] (rtw_cmd_thread [r8723bs]) from [<c014a214>] (kthread+0x170/0x174)
[  457.398083]  r10:ed7a57e8 r9:bf0367a4 r8:f086b000 r7:e8ede000 r6:00000000 r5:e9975200
[  457.406828]  r4:e8369900
[  457.409653] [<c014a0a4>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[  457.417718] Exception stack(0xe8edffb0 to 0xe8edfff8)
[  457.423356] ffa0:                                     00000000 00000000 00000000 00000000
[  457.432492] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  457.441618] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  457.449006]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c014a0a4
[  457.457750]  r4:e9975200
[  457.460574] Code: 1a000003 e5953004 e3130001 1a000000 (e7f001f2)
[  457.467381] ---[ end trace 4acbc8c15e9e6aa7 ]---

Link: https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
Fixes: f5ea9120be2e ("nl80211: add generation number to all dumps")
Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 9a6e47877..2b45df79c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2084,7 +2084,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame,
 	struct net_device *ndev = padapter->pnetdev;
 
 	{
-		struct station_info sinfo;
+		struct station_info sinfo = {};
 		u8 ie_offset;
 		if (GetFrameSubType(pmgmt_frame) == WIFI_ASSOCREQ)
 			ie_offset = _ASOCREQ_IE_OFFSET_;
-- 
2.25.1

