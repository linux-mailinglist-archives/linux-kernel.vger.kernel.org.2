Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF85840282C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343626AbhIGMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:06:00 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:28261 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242215AbhIGMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631016292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEuCaucOQlDfG0ryFHeKwBYGR4l7zA4FQQ51ni9uTXg=;
        b=mE8Q40nkht5RRzywnbwG8Em7tR5ztaY36D8bh8eDJx3ti+QNg/2jz3+5aWN90rNG2BWQQ4
        JnH2rneP9KzAM2A23f6DuS4njDyndwcSOFnWMijHXVD2IC8PNcmvTEQoERg4DwdDOHxSpo
        RQI2h8YxC7Lj+bs75fdOvDnrJaLsJaU=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-OVm-SvxQOwytzB7hKxUMTg-1; Tue, 07 Sep 2021 14:04:51 +0200
X-MC-Unique: OVm-SvxQOwytzB7hKxUMTg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ab66C7ASTuno/bPzTb+Y8j3ccwUmyogXm6TzavZcrj3O1j2UW3/wnCZ2nP7GBM07+2VMSttopQsZL3M1bHVqu7tYUEc+WDliNoW3BEUNO1f3gSgOCS0+r4X8aR1pqBDedp6HXO5lezubR1Qv4MoVNJ6U5m66mAh9u5rwABNHjN97tTcsImXOvOGMxQaL0G6vppdK9UXiit4v+bsC+xZTNqamqSnLFR4NX24Sp1wQagy2O/N3o2z1rjcO/G9h81mXo6cqOaPKhdeaM9qWKHn+7FcGNJ4XIwWNYOOY4i9Cu7iIXKsoLRk2/feUE6vaX/DozkY0GVkKtbtO3ctu0PuZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SEuCaucOQlDfG0ryFHeKwBYGR4l7zA4FQQ51ni9uTXg=;
 b=SnzjV8laz/8YNs2cwweqzy/rW8YYs7YM4WCrzowBIoCakPCYY+0oeCSI7xq3kRikMLDC3MrN+iQMP1/pdCtPr68kh09M70foN3neAhMkreiYVR/1OFnmjH19h/svH8ThHFvZnlKn0YSAsKZUO5UZKV0Tg6pgOqY8uQJcg0Nwud0p1ODIupEDs0jXE9JVcJV9hWLf6CqgtfTn7euXlaaCN/apVUgPzGzAFdNQ47YtHGlfTRnTEYpttBBeWdJn/V2wdxmD4hKGUJersUgoS7PBpVV9JzP7GxyIgkGKUSyV0IAy2+rET1Mwh6R1diHaZTeBPLsRM2mCXAQPm8K3Of0uEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.xenproject.org; dkim=none (message not signed)
 header.d=none;lists.xenproject.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB3120.eurprd04.prod.outlook.com (2603:10a6:802:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 12:04:50 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 12:04:50 +0000
Subject: [PATCH 02/12] swiotlb-xen: fix late init retry
From:   Jan Beulich <jbeulich@suse.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
Message-ID: <778299d6-9cfd-1c13-026e-25ee5d14ecb3@suse.com>
Date:   Tue, 7 Sep 2021 14:04:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::30) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.60.236] (37.24.206.209) by AM8P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 12:04:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9b8ee7-e96f-4f6f-ef01-08d971f7b176
X-MS-TrafficTypeDiagnostic: VI1PR04MB3120:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB312064CBD7DFF28BDD6FADD2B3D39@VI1PR04MB3120.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHKbMa/EKtBsFLeDT/7oxzcuXl2CWZ7i5ag6WT3vzfBLj/BZf/2wiynVdBsFfwBjFR8lQyxcbcVHC6zaa5fEomBY28TpP9BkKol0kSN2t05LNKCBlzRCQHnpkqdZNfUgrB92kN+ecLHTh0c/sKEB+zzLxg/SdGpLLNLzv05WUAH664MZ2+mjagQjxzpIqoT+ex3jeN4FoV4HI1iraFb+h+vkXDcQ0aAlK1qnOwLlINYy5m8bk0a+Rey0hL1ZCPNZsPOsF3FWqNsBegKdzu8In7CBbf9+4M/gw+qeHApI9IdCOxZEcvupHWonzSDqCt3Ux6tVNuHtsmfCwRqN9gPtBmRGhWf2YcXJU+o3mPkEqnDaQqC9HTQ4MWEo8RoEMNMT9e+E+TCC54PZ0F2oZS7n1WMOiwt1dja85SH0tgpW4H76/S5R7YmkzNrqWu7LJX9ELS6BELc576RDYpNThRd5/wPznTRkg31Nkfl8/H6VEm7yvcvzwuKAGJAjSzPMldSlV6Pook/oYzXJTgAciuqe12AVk2/OkTetVci1y4EYys/V31S2h3OCNkDIrSjuXS0OBgSAjhZfsFeHd6sLR60RQTGUBIW0CXsB0nq2gaNRKed11EBrqj+D9eI5LL5jw9Sqg5orY35MkRgJLb7thjlFxctCQr2sHBrOi2lstKm0ndzy693fT0/f5ccUvZ4kGTzsHI+mVYQQpcXzTT3CwbC7T+58N4IXA6aSlcEBVqXjYwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(956004)(38100700002)(2616005)(86362001)(316002)(16576012)(26005)(186003)(36756003)(4326008)(2906002)(66946007)(66476007)(478600001)(66556008)(5660300002)(8676002)(31686004)(110136005)(54906003)(8936002)(4744005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVBUeXI3d1htc1BlYVJ6dHlDdVZlT1hOeFVXODN5UUdhTDBQU3NlNVdRVE1G?=
 =?utf-8?B?c0hxbkxpclNmR2h0dkd1RlhDSkpVSXdPY3pLclRNZlJWWDI4MXAzM3pqK1d2?=
 =?utf-8?B?eU9jcVNVN2FGSjg0NTZ4b04zdXFEODIzeWxpbEQyd0JiVWx3Q1lRTnVGSlFW?=
 =?utf-8?B?N3h2TTRyM2R0ekFVc2RraTJxRjNybDZjRzhBejNyNFQzSmJtWEYzVUJCWHFn?=
 =?utf-8?B?NjVTUzg1WitVVFc3akRUVFU2dlBVMVlBdUtTcS9sT1Z2MWRwcnd1aHNFRW04?=
 =?utf-8?B?V2g1Z2FhdUxaRUpGa3JmZEc0bWNPMVp5MDhYWjZqYmxQT2FuTW5zVmRTTVp0?=
 =?utf-8?B?MXBEbzNVR0RCZFI3eFE1TWVzeUh5UU5IWW9MRzJtMzRBbHRkSjI4M0NLc3hQ?=
 =?utf-8?B?b2YzN24ydjUreTIrQVF0TGdhM2syQ0NWSWVCa0hMQlREQkl2dGZTOVJ4d1ov?=
 =?utf-8?B?NVJXNnNZRXdBTDQ5RExkdVp3bElDdEdOczdBU0xZT01jQ0JpN0JpYWxzdGpn?=
 =?utf-8?B?TkRVWXVabmJQVCs2a2hDbUk4Q0xFODViU0srbGpOVVNMUGJvRW5NazJ4NW5N?=
 =?utf-8?B?TVdEclFsYXhEMUtBaks4YXpnVCtqVmhuM3hzcDZwUHN3akRKNkFNTnBVbklK?=
 =?utf-8?B?YU1JdlRyNWc1cFNVRTBFSldhajl3cGJaeEVLRVhURElzK3FienF0NG1yWHRs?=
 =?utf-8?B?bEZFeGw2Zml5Z2QxUmVlQkhRclJBU0Jxa1dGNm41UWxZbXNVellWRzdOTjg2?=
 =?utf-8?B?UUZRMitxZHFrNWhrS3dJNDlWRCs3VDg5NS9wZTJXQ0hFTzgzWEljUlRtcTZy?=
 =?utf-8?B?Wm1qWjUra29zeGM4KzhEdHArMExYaGJMS0ZsbnF3RWtDUjVnNXJaVmRBNHFp?=
 =?utf-8?B?SXZIMk00MDFWMlRCYzdPczZQd083TVRiYWhHT1RjOG11MkdQU2UyYkpLc1lT?=
 =?utf-8?B?YlplWGx5bUNuTnhxYkk0YVNvKzJtSEZFeFlnSWhyRHNzNlNQdjVmMDJ6VVNQ?=
 =?utf-8?B?Y1lHSDF1ZytaWlR4TnlyTWNXd2xuTU5pT2VXTjNiMGRaSE1NbTJvM2lLWkhx?=
 =?utf-8?B?dml5TmE0TzR2bEM4cHpDNUwrTUZrSXVoSlFXd3B2QnpqY2NoVnM1dHMxa2pR?=
 =?utf-8?B?V0p3c05Hc3pidGhWZnFHVTBJT295enBSRm1XNVZlbytHSEo0SlI5a3VIZUNT?=
 =?utf-8?B?Z05BSkFlRThSTDJvb2V0d0RmRFNjc245dE1QSFRFSXlBZHBhSzNwYmRPUmg5?=
 =?utf-8?B?Y0N6d0g5RHVTUFFMeDEvNWhLc3kxNmhGZUhZNHJ2YWp3ZTdyd3VRL2tMZ3V3?=
 =?utf-8?B?OHRvMjJ2N1c5MENuYUtqNk4rL1NiTURNSWk3alBlTE9KbzZEK1dVMHY3Yy8y?=
 =?utf-8?B?T3ZLU2VWOEhxbGtHbk85ZnkwMTdUVngrQUg1cE5rbmM3aDhnMTVqdHpyN2JF?=
 =?utf-8?B?M0sxOFRYY3hpbWNLaVc4aUE2RmNJRHJ1ZFpvRlRYZG1KbzlYb2UzeG9Ic2VK?=
 =?utf-8?B?WTNNOGo2L3ovMmY3TWV5a2tBQitWd1ltZm5PSjd6N1lqeUVrMFI3RTVFNGhk?=
 =?utf-8?B?Qk9CODh1R000aitzaVRJK1BIeThKQ3V5NDZZaTQzek9oenNGdit6UnZOeGZ2?=
 =?utf-8?B?Tkc4QVpmUWVnODZYU2UyblkrQ1BjbndCNWdOY0U3Z29Fb0Yza1JockRxSVNK?=
 =?utf-8?B?b0h3Y1luMXZmdUlvajhaYzZHUE04UXJxUGY5Tkk0Nk9kRDBrekJjU1JuMTBJ?=
 =?utf-8?Q?C0FWkfpAGlLfHYZ6v8Q+PHZu5ejZzKVIfyDuDRj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9b8ee7-e96f-4f6f-ef01-08d971f7b176
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 12:04:49.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ekgPaTEnMDnoeOJ1xNV7KeNLMYISrN0W5UEYEoDo1ZcyumwM/eujCiVHt1UJcgqcmtKVMpXXX7Az4pqdMNEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit referenced below removed the assignment of "bytes" from
xen_swiotlb_init() without - like done for xen_swiotlb_init_early() -
adding an assignment on the retry path, thus leading to excessively
sized allocations upon retries.

Fixes: 2d29960af0be ("swiotlb: dynamically allocate io_tlb_default_mem")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: stable@vger.kernel.org

--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -211,8 +211,8 @@ error:
 	if (repeat--) {
 		/* Min is 2MB */
 		nslabs = max(1024UL, (nslabs >> 1));
-		pr_info("Lowering to %luMB\n",
-			(nslabs << IO_TLB_SHIFT) >> 20);
+		bytes = nslabs << IO_TLB_SHIFT;
+		pr_info("Lowering to %luMB\n", bytes >> 20);
 		goto retry;
 	}
 	pr_err("%s (rc:%d)\n", xen_swiotlb_error(m_ret), rc);

