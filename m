Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA73EC756
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 06:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhHOEpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 00:45:45 -0400
Received: from mail-eopbgr1320053.outbound.protection.outlook.com ([40.107.132.53]:28016
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229452AbhHOEpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 00:45:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfkfdIW/7+8xFJ6iELmChb4nwHj918iTj99xcViQfNwD8LvpoGc3W+ZzGyAifwfpN1zaG4HXJ5kFdaY/5LQGwtYloYXO5FGoiSZ0h3h4Jenzw27NmIjoHAi36DKhZy12fp2WFIoDYd2GJmgmEfGpyrko7zBvn4dsX6vGUPzLGqlEcOskc3DRx9YPBGnLciMa76aCQB4S/3ZDnBCS6IdcFSq/Lu9cpdrZwy3xCZ/DfjCHdYUwY2x/d3v+Y5QFVGRVBikE1VeCVbUeZTAZzU91YFyIV99l6mzDEzzl1tRYNY7Sntu0nCLClS8WrF/D4rnncPeY7/4c9fgZhYw8lZGRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljnxoypPyQVhJF92Xt2AuBi6qV2QFIMkzuy8i0fwlpM=;
 b=Sp9bFRGaCXu4Xqilxx81fBBuqdcTknFZSbJshMXQwsGYzpLeVeRvbx1psBdn42Wk7cH+X3dP+sAyKP+gZsVzs65NlnlyxhTGArIgv8VbOmD870HXUSpjlYRm/sNu/0A9+ulJRj+NuP+ASob1PiOUFtFaBoX+7hMOF/EWvyewuKbda3oxDjs+PFnADkZdIhrGxMdyKGnvDn03coyHUcUGNmHUA/bx0BozV9y5NifbBQpwrv8MvNrYu/f3ZB9ZlZVvmpy2Spx+oQcO3Y4JsR2htGy1XHePHWyoVJQcsowSvOvw+OTKPiOui0qBYSRJ0NB4KJc/kOyKgCTpRHTE+49dJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljnxoypPyQVhJF92Xt2AuBi6qV2QFIMkzuy8i0fwlpM=;
 b=ZP6z/wknfIiHyJx5FMqVDUzVWeVCFxfoSQ76zueiROPV8AUWAC2hbQxozKdrw6X9nLMjYt+8IJAJnq3vgAz6Me/MQjYX0ccNfJfw4i/MLWFNaAjr00ofOAuzo7pvhItjBxDdsMzmu2CuSo5qHUhdG3cDjezvIbizynuCsps3Uug=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oppo.com;
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com (2603:1096:203:6b::15)
 by HK0PR02MB3492.apcprd02.prod.outlook.com (2603:1096:203:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Sun, 15 Aug
 2021 04:45:05 +0000
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::3594:f84c:ac41:bd48]) by HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::3594:f84c:ac41:bd48%5]) with mapi id 15.20.4415.022; Sun, 15 Aug 2021
 04:45:05 +0000
From:   liuhailong <liuhailong@oppo.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liuhailong@oppo.com
Subject: Re: [PATCH] mm: add kernel_misc_reclaimable in show_free_areas
Date:   Sun, 15 Aug 2021 12:44:58 +0800
Message-Id: <20210815044458.5803-1-liuhailong@oppo.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210813131320.b9474cb095cf815df1de337b@linux-foundation.org>
References: <20210813131320.b9474cb095cf815df1de337b@linux-foundation.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0021.apcprd04.prod.outlook.com
 (2603:1096:202:2::31) To HK0PR02MB3154.apcprd02.prod.outlook.com
 (2603:1096:203:6b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PE80250894.adc.com (58.252.5.72) by HK2PR0401CA0021.apcprd04.prod.outlook.com (2603:1096:202:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend Transport; Sun, 15 Aug 2021 04:45:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c7afba-177a-4e92-76bc-08d95fa77339
X-MS-TrafficTypeDiagnostic: HK0PR02MB3492:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR02MB3492B4C08AC835251898DABBAFFC9@HK0PR02MB3492.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCZh305QNcV9272TXVYftuPjACZl+eM4sYuySsWdkstSAQssBkQKkRc5lbpephUAD2STuo8flqrXjySy9MvE/mRszHU+OCD2IUl4GJO1Ob4+ORcp9GKHwMoRFt3IIkqVmPM+OIKGS0JfYSnCgCH1/Y6rPP7XofdmxNqn/QRQOA1r9xsDGuAqn8sH/25LtoPJLg534gCFXN0TwNCmaRTTrSP2+i1Vw+c9DVWQlGEwroXzsoeeezn7z/ypcfiCCsbX3CGaCRoZAdKXnuh9GdAGo+yVZdAVNP/pum0CTdifTkn2YPYXVtPGGXj5J5HK2wSQMx/CSL3FCg1WsvcJeOZgXPb+Hwx1pB3MNI13AQaLveBQOaNkinJtGXcIP0isB1dDlt8CxEcNfHg5BawuOPyTTXwwfub596wLx+AaUqlIX+Vbz6pETX7hXDgyg3PmdaTovJOnXBPgRtSsctgyOvyQklvIpCVZG1QhL1LkxEOp4mT8m/OYm8w1LgaAtOR+Aa6iLFI9KG5T12x0OnALICVs0Ko2pDeY8ZYMPkekZxNJNrtB/wnEISD5D1udOGIFBZHqo4i2xQE2ItwgKpJYyG2+XaQw5f/Fg9Bg9qi1sGcxaCq2mk5m1ltat/XFuwc3QUTM1jAuH84IFHI1nJhCnmOf7MwDDl0ezLjbMA9S6mXxwq63bQlxjSM9BD42zJF7eoKgAS87kzWtvzIhVn0ZDJTLtgVBtTAxMddu+DEamggnZ1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB3154.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(38100700002)(38350700002)(4744005)(6666004)(1076003)(86362001)(66556008)(316002)(52116002)(6486002)(4326008)(2906002)(478600001)(26005)(6512007)(5660300002)(956004)(6916009)(8676002)(8936002)(66946007)(36756003)(6506007)(53546011)(2616005)(107886003)(66476007)(186003)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mhx49W17hgnlItQl+sU0wGh2l07IoAWzdMIKKs4sSSerKbBbQIXD9gR8rbBE?=
 =?us-ascii?Q?9BnUWGINpYzlLL41InzuTvFyhlU09srnX8wmO7yFM92vbwpy1BARaONIH1lK?=
 =?us-ascii?Q?xrvrUIo02fTCULvgKZ9az3hst44BGlQa8QpOJ/rN4s4fRlidNWdOxrGcPW+h?=
 =?us-ascii?Q?NuJNTsVilpzJvkVeXECGQ1EQdcIN0XD5qjbbLeS/bErXSIzswplwctlUehzz?=
 =?us-ascii?Q?Vs2eVeUANRbbVyYCuY3sgsksMaZuhXL7myCM07ivW8e423sXETyRRp+STBU4?=
 =?us-ascii?Q?1H+vMAHoGIhwIP6tzRwCSCDy5w0z/3FIgKr7RVGaCqW40pB4SLO0F5roDJZR?=
 =?us-ascii?Q?LqMfNNv9TSBoIO25NaDorVQXa0sz20UDjix2iK2uj9wWdLgE9r1rWF4DAcNu?=
 =?us-ascii?Q?zzQ31+KS+23c6O5VPKMuTlD1ZZyNXtSRp8wXQBysGe01IiHM/svQD7zqgDxO?=
 =?us-ascii?Q?DA33O9B4szW5nkoBLKYSCFcUbp7wfNN8j9NJNq8RbiieY9istTz0HyfbHPPO?=
 =?us-ascii?Q?108p7eKrf8oHEbQYQJoPkxRIYexWsGAGGGE2pEddjCLo8UFKqT/tjxVGjdqQ?=
 =?us-ascii?Q?TVvRLCuncmrOuRnMKw0AtYQS36xfmfJ9Rw8nGP5N2YIdJF/mYpaQwvGQCrvM?=
 =?us-ascii?Q?ZN7DXfpfFjgiyr+SpYzrA5CRHdfyxDNPqKYze8FDPsR0Iv4KNJYiLnp1OY43?=
 =?us-ascii?Q?NOez3G7WBtfPh9sh8ZnV+mxnej6hu/poXUzIr5+erm7meDp5P1PfzQ6Lvhdt?=
 =?us-ascii?Q?wTXwBeJyxARjnVUwXFx35yODz2gtucndtCcgMURfYhN57+/eMV9EWtzLriGB?=
 =?us-ascii?Q?rA9lAGOE1oybvag/QcdJ3LkR2OSEzoeeir0/YKjoKrCV5/Pk2Fxe2iRDmiAv?=
 =?us-ascii?Q?4JmVsrznOWx+yFb4+VOlfCWpppHDgVw6CcODod/nmnAX21SjOozxk7gYMowT?=
 =?us-ascii?Q?fdp9mIDCsuHxsB4IyFWM+io8FGErtXzenaayFWl1xbmrky9kLORcELsrdDdn?=
 =?us-ascii?Q?U6uVx4WJzF1HF5Hqa3cjr6TznKBwqqJe6QY5nvU1m4Qs47vt/zusJh9tHP41?=
 =?us-ascii?Q?pKWoCNcGCQGKxW88urCe33oC0IDDsTGyrjLZiwbqMRcIG+NKvuRTcfVMVtLe?=
 =?us-ascii?Q?9JMiQV6vJsrZ1YXuys2TiOWhGc1tAXIyrQN+qeNnqxf/04u+8ItZY6KCK5M7?=
 =?us-ascii?Q?Cv7UZ6XzJquoBeBLIxCzP+CwGRDDpJ6cAeP5v3ZlFQ7aX5CKelQj6LLtLNKN?=
 =?us-ascii?Q?nHn0bGUObtLmzN8RKCb/sSiPISUMQOZpavZJdEW3ERocgnLpECtUJ15Oltnm?=
 =?us-ascii?Q?Ua9pok39djzDr43I/7cfz+9n?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c7afba-177a-4e92-76bc-08d95fa77339
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3154.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2021 04:45:05.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+LKLUjZ3bXEWUFUWerxhq0J7BnSJTMFvZZ/WKN1PZwWg6mCMg3Zp+HcYolAXLCNnES2BqK3bgJRvL+OOm3CbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB3492
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2021 4:13 AM, Andrew Morton wrote:
> On Fri, 13 Aug 2021 18:47:25 +0800 liuhailong <liuhailong@oppo.com> wrote:
>
>> print NR_KERNEL_MISC_RECLAIMABLE stat from show_free_areas
>> to check whether shrinker work correctly and current mem usage.
>
> What inspired this change?  Are you observing problems with
> misc_reclaimable memory accumulation?

1. although we can get usage from /proc/meminfo, but sometimes we only get kernel msg, so we need this to check memusage
2. some drivers use it, like dma heap page pool or gpu driver mem pool, so it also help us to find whether shrinker work correctly on lowmem condition
3. i thought it's resonable for show_free_areas to print misc_recliamiable
