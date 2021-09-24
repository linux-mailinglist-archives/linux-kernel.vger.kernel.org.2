Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32384417C21
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348336AbhIXUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:06:51 -0400
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60]:21785
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348341AbhIXUGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:06:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr7YWsTKAYt+q/ppxpPAMcoseNXM766yjZcx0GlkrlrPwVPSDIsmTOjP1pkPgO+iMQBeObjDb/AM4IoQjdYTMPqyF5FvuFtSORLmqbzQRxoo9dPJXCa++vDajJX61AsR9qPMELrVAgAj/4g4wPeovft/xuYn6lPnJqSrPDSk0xI9C8WngYr/pLwzKq8JjBEPC3JJlTrQ9pYnyPjFZzjYy/w2BTKki20Y2AadOHoW0m79Ijgsy7kIpzDwHVeLDF1v5NKXcZhYEWAzbkfnLcfu7cWcHxLvyQ12t4NwMqo5uuWejgs5Vmgl9TaSvGRrzObzf4aC9Iox5IE+aWhOo0J+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=e/Y9SFnmdMI0wtTp7WVgUBzg+JKl9ZYn1b2FLeMcGoE=;
 b=g1fbjpsdPOXyrr2L7fL5bFLpn5cp+ceyEVs7jQujqIg1dk5wJ8dTSmaeddpqRSVzFKkXJHi7uIIOAT4doAbh9rECsI6laEAsKiBHE/gsrqqkTApgYhuLeLvoACzX11vfVQ3KkYZhM6VVu+LiO6Ic7NbfBGnZLGl25x/x6v7CsUmhl/+afx0o263iPQMseVJBuE3U4TFP0RlYLP5NR/Yg5BD/l2EgWiSBEqtwH7KvLgdDyie5TyEgtnb/tMm09VCBm8CAY2eQ7+DTMSJMn3zr94Sr/dB/keoFMP7Z01QuENyytNuDQ9MzPoe4BX3VicJtBtw2FFQSDwGouc1OZ5GBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/Y9SFnmdMI0wtTp7WVgUBzg+JKl9ZYn1b2FLeMcGoE=;
 b=woKneT0L441QFU5MWa+Ap0/iI3FngCd5qy405eJUxdZ7yD9Qha8zi/0fZDmhj73h1sXhN4iHP4YPP2VrWdchhZ29MnyO6rEhNS9ThQNSK6suQbzTnFfdynDyp2LxW2OB8jHLnVszTPQl0JmGcA5XX7rx6QyODWWmHC3ILhlNfok=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2947.namprd12.prod.outlook.com (2603:10b6:408:6c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 20:05:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 20:05:04 +0000
Date:   Fri, 24 Sep 2021 20:04:49 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86/mce: Get rid of the ->quirk_no_way_out()
 indirect call
Message-ID: <YU4vYSKnfdxzJFgZ@yaz-ubuntu>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-5-bp@alien8.de>
 <YUyUhfTfY/3KtDTZ@yaz-ubuntu>
 <YUyZDAGloQB/M4ts@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUyZDAGloQB/M4ts@zn.tnic>
X-ClientProxiedBy: BN8PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:408:d4::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 20:05:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7229d70-cbd5-4e6a-f650-08d97f969925
X-MS-TrafficTypeDiagnostic: BN8PR12MB2947:
X-Microsoft-Antispam-PRVS: <BN8PR12MB294756353448473684F710F6F8A49@BN8PR12MB2947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCt6I2adWj5SVsFZciz55G3x+BW/ftsXxYB25CwzejihT9GQGy/4ZHoKBbwgTz4a8uQ9u4s79IhQWTZCS5vCZnrZOdCfrXi+ITnNo6AngwUmkq+KmR8IXAizB8InlsxKkqDe1f5J5sGgDnVvuzO99fl4XtIjteTDO/XOgqfYNepcMeFGEX3BGPCchj+giQpDclqJztwEGIETQOdd6clLT9tspzRiA7jV6XNzI6znQCfx12YIerM9jraj3iZGTfjAx5vAYpQg06x+Pev3f0Dr5O+rWIbr8eodsCZk+zk6Xy/xJnHEPvGiPFR0/A3Fv11pYYro2HrdAidzRqWurWTJLa6pXbkG3e7voBU/3LwV/hOeRIqwHFsjW1yUxx7bplE9HL+p9ntkXkTDXe3p1upcXknsfv6eY2wVGaY5rDJP9T6GdSPUzPegrMsh2SCShZAiF6LZj4siDbFYAAeCd+HUUPedKdwGf3BVoTLbOIT0cLkXhWG+saeIfHPeLr+baTLBI9+TXJB2lSxyqy+x1ZYV3x8HqNtzct34cA0lkNKu/W5A7YDHzl5tq33SM3Uene73ljUV1jPCPrX0Na+K3P7jahA9qKMuq8MplawckjqUSbeSZ1eYjU1ImoAeuCvncONfv3G8rIm3VcSwuSjuo70ssrFAsiWZyd7CORUT0QEHXQ2M83sf4DxvAMPUe7tjr3sI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(54906003)(508600001)(4744005)(5660300002)(186003)(6916009)(956004)(316002)(8936002)(6666004)(9686003)(44832011)(6496006)(66946007)(66476007)(33716001)(66556008)(86362001)(55016002)(8676002)(4326008)(38100700002)(2906002)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FE75Fsfh72Tj4kUPvcACXvj73S6KkBvNahPX83BU+MiIDA1ph7vHj6bxSd/J?=
 =?us-ascii?Q?gbVTugP0vJ/JVM6XT9lLstCYm+Vi8e0eXHn5ZhT9/tvc6OTxWh5e9iDE8C48?=
 =?us-ascii?Q?8XFRyYBmO18K9jNcI/swHDL1jG0+koZ45+Ssmzz4nGMEC68ppZHu/Njfy4sp?=
 =?us-ascii?Q?Ic0R6Jz7Z6CH9OOeV2WSqH4llKR42vlZU8d0kAcEWHnupmzvnXhvh7wai4Tl?=
 =?us-ascii?Q?fTfvGhaAOhNXvof185Zre7TAth2F9Z6//P/sOUE6VG0gmaZaVXoGckw6YNs8?=
 =?us-ascii?Q?zAWgiwETDWJFGN04OUwmU9ygTJ4fqYWGbQ4ocfU+9QVz5ddBejVDC942/pOQ?=
 =?us-ascii?Q?pLPyYLRJWcocmT5HU4Xn08lr5q98OgQi8Y1ulqwaR70r1ax+NcMYsXnVhjzo?=
 =?us-ascii?Q?6P3vLIjRAQ4DQBULoTwPK3VPwgfPjSyypZ8y5ikxuqJuwj9QPwYyNMCdSE0J?=
 =?us-ascii?Q?WR6PMUGu9Gq+BRbDHHaXt2sDIq+h/eGm+TwppQi9RtZLUZeKn1sgg2t9tJZ2?=
 =?us-ascii?Q?5v9hxH0a8dqHY+kZfGa87NCCGlcW7I7oI9Qmuwb+DvM4rBhPkj+Ln/DlDR5w?=
 =?us-ascii?Q?njjQzBtV6dyPZbFEsZKcyjb/w+HeLNEi4K+bAOPYVAZlrH7sXq64KiCCnYhW?=
 =?us-ascii?Q?ER8UMOjCLQa107Bwmc5Jg6ZfUVhXLNe/LaCXTWfFdn2mrWRk5ZSMrexpBGUz?=
 =?us-ascii?Q?So89ie9ssntCFCW9VLfAxcC9CPIGWfvfoXTjwd32FTjLoZkNrAES8ETDR2em?=
 =?us-ascii?Q?jAflgJukgh17Ab+Ohdj5UHg34GE/yfL+2V6PL9fJNkpmrPrxXzNSPXeDlOXJ?=
 =?us-ascii?Q?5qk3V0K9T1tcqB36BzzhpEFyZvg66Hu/ihEOOszgyLUWvElBKF/bDryC1LBQ?=
 =?us-ascii?Q?t13msuYK511j2SSL7Bpt/LZB4i2mdeyQFtBJNif41ThmUHRnJB7b1iAIx40n?=
 =?us-ascii?Q?bWC5Q9SjlD23kablpFiKgD4eMq/w4ePvcxY6SD+iwlnMOg0QoaRvubInvchq?=
 =?us-ascii?Q?auGCyLi4drJnO4YgZZzD0oFB7FrpzbnZwJssx1zAsqpjSDYNGUwWT4gkoQ+1?=
 =?us-ascii?Q?URM0GcP9X2hZDA7Z8+DSlOKTlQ+dH+m7WlNICoXDptM9SfzanAgQyuHFQs6a?=
 =?us-ascii?Q?KrZWczawXaR3k6SvZD5QD4mSGx/xOzeRjy/xNTGzh9P1XyzB48Wk7nb9Ms/A?=
 =?us-ascii?Q?oXZzGgFjXn7Q6DWy5VnNxHOf8Ew0ksMqTZ2jUwfJXnpt3vxLyqbySvT9SA5d?=
 =?us-ascii?Q?0QJASWw1Cpc6uW1Dr5ieR2I+CbORQTVDvjhuC5VSxTsy5gVQ8xnHx/9Kh6li?=
 =?us-ascii?Q?7iUZN4Qado6JlxbYDaj3iJoF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7229d70-cbd5-4e6a-f650-08d97f969925
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 20:05:04.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiNQUN6LfVmMs1BxzQ9Qc4soRlxB4ry831ZOix8j1bDcNQHyTp8Frp/Tle7atml4S8tLp7OuX6z/UyN+0Cn2ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:11:08PM +0200, Borislav Petkov wrote:
> On Thu, Sep 23, 2021 at 02:51:49PM +0000, Yazen Ghannam wrote:

...

> > Do you recommend this create another quirk flag and follow this patch? Or
> > should the quirks be grouped together somehow?
> 
> Does that quirk match machines with mce_flags.smca=1 per chance?
> 
> :-)
> 

Yes, at the moment it does. So I'll use that. Thanks!

> Also, your test:
> 
> +	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
> +		return;
> 
> should be
> 
> +	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) ==
> 			    (MCG_STATUS_EIPV|MCG_STATUS_RIPV))
> +		return;
> 
> methinks.
> 
> Unless I'm misunderstanding the erratum ofc...
> 
> --

The check is intended to catch the case where both bits are 0. But I'll
double-check with the hardware folks.

Thanks,
Yazen 
