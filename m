Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2227D3B1835
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFWKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:44:15 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:6753
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230102AbhFWKoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKOhg/y3Njnuz3pZELNelJpsMT7+vCi1aE4rZg9GQik98VFbFgo48zvvaI8WgmHDgC3ghX8D4AzCQL3Sw5DzFlHNSJND36as+o/p296u5V5iEqHV+Kv3q4RMvEsppMipl6ZvFMO1QFqpwtWQzwG0DOFeY4HPw3o8QDedxmq5iJbzxXmfyJMXHdDSU77sotv6LlTaeSIOqez17VClCsnV0Wq4eeGOc3PBroCQfRdb1cIIfk8V89GZMBx7s7tq3ZBo4Opz3K7T8eM2B6JOlkbaJEqOyPjT5cpNZfmrinbSaVmkPCTi8Pw9AgMEu7/CH2B2xLSGABl7hNgsOhVYb+VlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvItxsWl4zz0QxOIF2IqGKDH+7K2CeQR+vpsIemHBiM=;
 b=VjRkmUgByAN+WUFJD9TTjyfUeRCZw18vzDJzVwnEaUvRuzrJi9oAdXo4BlD0mdUx3n4EEpCgvVfiuUE/vO8m4bvYA5T9BIp4V4RpepBtIk+jSZ++9Zbv3eLDwR8hfrEkIapWk0SxJOHWo7AK+td2aVXrhFvlYi57AhSs3Wg9JY7N54mtoeD8B+bCb+E0DgrMcyT1eKuVkcedQZbA6WvNY2aPj9NSzZQSSDd6lH3VqjXo9fo4bA0OzUWvciErEPUQleorkiImtevMRUMpXdWV2csJJBBRAhWg2XuXoJDR5AmAoOlCKjsG2V0h5Zr2QdN0EymzXeXb4jV0gUk43nsXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvItxsWl4zz0QxOIF2IqGKDH+7K2CeQR+vpsIemHBiM=;
 b=oUSfdpDwTH4rnL3tvgUMQc/7RwdDIPaWdrdsrzKZRmvchJAaWmUlH+9gdtuc/HIt7X478LGoNtFlXzpHhDq2kMMXvbOQIaXVoOznB1E9CvEB5I8szGCAgocpNrWn+ipX4ZrFCgYnXYYhfMNkIoEofh5Ah0XqqHTx95XmCBU8UuQ=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN6PR03MB2610.namprd03.prod.outlook.com (2603:10b6:404:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Wed, 23 Jun
 2021 10:41:53 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%3]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 10:41:53 +0000
Date:   Wed, 23 Jun 2021 18:41:42 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timer: Use static_branch_likely() for
 timers_nohz_active
Message-ID: <20210623184142.255b2769@xhacker.debian>
In-Reply-To: <87o8bydj0n.ffs@nanos.tec.linutronix.de>
References: <20210513143354.096c6baf@xhacker.debian>
        <87o8bydj0n.ffs@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Wed, 23 Jun 2021 10:41:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd9156d2-bffd-48b8-2af0-08d9363383db
X-MS-TrafficTypeDiagnostic: BN6PR03MB2610:
X-Microsoft-Antispam-PRVS: <BN6PR03MB26103C2DD15300601E2131F5ED089@BN6PR03MB2610.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/uMUSNvnmjht32PZVoSqDyynWuhG9SKzWgFxcQ5gzWOnySEAaiQZH9HLbgSuvgCPKEVhiDJoVei8yE0sW0LKP6R8140Rq1IuMeZGhu3V1LhZ3zPLogM0rZ7AVFw3imFsRK7pZBdrlNgfbfP55ndIepxbtFzZNddAsR0Xusr3BEkko2wLKuLUgzvsLbV4ewWNZKeq1mDyAj6xLLeIXBYPWk4R5xyKaURdk16YNs98JQGHz7czwx1HTYQYMuFmll9hLDAi0pSqiza4aYCe61aPms3YmSYFFHvd32d79XaVbtKPr68ghT70dnuCuqnN9wLco/oGlrPA2FJGwWfIAH/mItVe17jeolstTwZo6tpgcHO1FCYTmMZ7hiAeULTccqzsd1Stw3WtLCAuDKvxXpfJrbFaE7abYxObzsZGucfsZxLjxUzAssYryaV0n3RJdezHyA2uy7i4TVuIdNJ5p/uGAyZ+f5tWmyi0uokPMo2s2x4YcQIEtbJC+e6Pmh3w5t5+UtZk2o41a4WoLodIgSjIOa/r7XB4ErwsGjhOJ/a+fB10LFkBkPzOLcWCbfpc/0ZcyBIAmY5AdK82ChpU4XNYjfv5qCCicbkXZlp3jVfRJ9ga+rku1v8xVuj7AZiWjWBxas4TFEVGUP6NXeCvgBWx6XlG7Lu3UzEn5gmjD2fN7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(346002)(376002)(366004)(6916009)(186003)(2906002)(26005)(5660300002)(66556008)(66476007)(66946007)(4326008)(83380400001)(52116002)(16526019)(6506007)(86362001)(478600001)(7696005)(9686003)(55016002)(8676002)(6666004)(8936002)(956004)(1076003)(4744005)(316002)(38350700002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awr6dkpoavFIQXXmP+F6jeAk28h7h5wr3bZh8MFqQkV72cctpVxDC3MrU/ES?=
 =?us-ascii?Q?c1//0cfNNH+pLlsEj6nP1NxazS1F+a6GChjPHeLAfuL6943lsTH7bffs3R/s?=
 =?us-ascii?Q?h2FfUz64/mngc4+owMEh22vWtNwZfc2weuaNGy1Pw8U0mkG388jW/Hmj2qd5?=
 =?us-ascii?Q?GyCBNWigUsACcIbFShYZAsqyWol0FvL3/bWBhMb4YDOGY7kjiKAi9bLz8Hmg?=
 =?us-ascii?Q?v9Ci0cjHcmQLhiIX4xqnfmhVH4/ceIhRbz4yhpVl6Y1j/wFFPVraqYMGjo3A?=
 =?us-ascii?Q?JHEncG4duHhykcii89iZDPIdkSGEtljlC+ORxVAs6QIVHbUZ69QTQsLRxy+u?=
 =?us-ascii?Q?WKRLCy4UxJypxHWM2v994OM/fYULybyIzvU21RbSPEYHdlW00k6qWPGRptTn?=
 =?us-ascii?Q?N9scd8mc2+Zz7ybJJk/7Ch6NGT7TfPq5xW3TDGdfSF25b3LZVKxfFeNEiGFj?=
 =?us-ascii?Q?GeowUXa0SY/iuSKPDPO9KU1nXN3+oQBPXEPSd1AlNASTZLhC6PPqHn927pVF?=
 =?us-ascii?Q?wik4CmEhK0MxZFov3k+MqUX1yjJkoNjM0INl5DE6lONUwq9EsPqzrWdZfcrj?=
 =?us-ascii?Q?VlKdBwdYG9zeLJ5t4XgTzGacvsmzlb9WD2iE6KZVJsNH05DGl6ybaV74s5Ri?=
 =?us-ascii?Q?jwhIFsO39WDaJiXtAdGLhMuAzgXSviWVxT129R5WIXX6yFBwViNkAbQOyW8C?=
 =?us-ascii?Q?BPJDhEx0v16HLl7gBgjvZNuLHLcGFDam1RrObAfAUoXhTl28xAkz96xemgt8?=
 =?us-ascii?Q?AjDZXLk9cqI+fYImN3IiMpJedMq8H6bnljIUlfmH9ZXSJ1Z5u0c+45knMs+R?=
 =?us-ascii?Q?R7bXm5g+SiTU6HEFhU+Fq5bEeC35ybI7523d7DN3JIimUT4rMzlgnXzhKPfG?=
 =?us-ascii?Q?GB+5EXPMuzrbuR3xBYnsLcvUN/cj5zqKPEsOfwwKaWPJIgeJfmxIA0F4DWJZ?=
 =?us-ascii?Q?KuPS2SSwkmHsDIx/8bqRp+o1p8KOnR/3EK2iVsX8UvOAJFzNBHTbt8UjK4XG?=
 =?us-ascii?Q?iSURnmN8iz7Zs7v7lOEiSv5IX7xWnm02ZqwwpgHAyuYcaM1ppZ7Oto73uSR8?=
 =?us-ascii?Q?fQjVC8Wza7Az2CcSYxeQLFF+StAwH1RJ3s7N2HLRqrtEQg2JdAD9NSxnJMol?=
 =?us-ascii?Q?k3HXKLlpkahtSy84RURDEsb2NAO1p9JQTqNVAAlj7RgjPSbuDPH+C/MCV3su?=
 =?us-ascii?Q?nXpsz++bvJeQWpkPT8zFSVsVlAE82+5Vh3vRDSJh1KEq6XwKonOZwSRqmtZS?=
 =?us-ascii?Q?hV7eQXNo5W8dBac3fscAevVvCWThL1PAC3iVc3ysZ3bYunzSgCvPC7IonHJY?=
 =?us-ascii?Q?HA6k0wJiQW1Z56AFfhApf5r+?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9156d2-bffd-48b8-2af0-08d9363383db
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:41:53.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1XGaxxX0DoK/bWUOUB5k+bkBSUS+gpTFON8Qy1d//BDGSAtmUHL9k/K0j3tt3Nk/TiQND5NNOLcJM0MsYdQBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2610
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 17:19:20 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:


> 
> 
> On Thu, May 13 2021 at 14:33, Jisheng Zhang wrote:
> > NOHZ is likely to be enabled, so use static_branch_likely() to  
> 
> Why is it likely to be enabled? Did you make a survey of the wider
> distro universe or what?

One more thought: maybe NOHZ is confusing, what I mean here is:
timers_nohz_active is likely to be true.

If I update the commit msg as the following, is it acceptable?

"timers_nohz_active is likely to be true, so use static_branch_likely() to
reflect this fact. This could improve the finally generated code
a bit for the most likely scenario, I.E save two "jmp" instructions."

Thanks

> 
> > reflect this fact. This could improve the finally generated code  
> 
> could improve? Either it does or it does not.
> 
> Thanks,
> 
>         tglx

