Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA2411266
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhITJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:59:09 -0400
Received: from mail-dm6nam08on2113.outbound.protection.outlook.com ([40.107.102.113]:52032
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232993AbhITJ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:59:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHVVNGL2bL2Aiq4T5bZtnvMxtdUE+MBODIXSPP0kV5yxPVexLIQiJCABoCLiZBEp2oAYrFQ26I6O79wNBPxz2uEMvk/FawPIk5XDIAAdmmVZeA4CyRVGO8GofQtuqsOiiuChsd/X06DuyV4SqRhw1q29WOndtU2+L3Xy/oh4m0Oiwfw1XhDIy+eVIUls3eI/JV0fNCcb+89q7iX93uh2AWW0etuHkFuI0Xue7iVfifHVB5loebb05crfNYmkPhC7TnFfIKNBgvQ6IO81hvYkr2DrYN2NSbQtQztmIJ6nGRW3E7078ESgJnZweCwuWCC0PyIfJNuQNBz+eU+tWTblaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L8MYpX3WyzodlocaDb+akci0dei0Zp0qUHnhQFBUIf4=;
 b=fYWSlRcsvNsYDqfOBzUKxfzsegkHboDaiQCl0nZ3xgM1XBiPT3TYQqqD5F48zesIFSd9xdX85N+5FIeqyy5416R+N03QJnO4w0PTYzIIcvd9e9sxuCG04xmoGIJgjih+cOMNL4251Lmn3q6hz3muRTlCUaxgrpuduHFjBKQxjbr3tMX2+0iM4Fy5r5GQu6XvgTp99jyAEoOrAsKYomOEc2Ba6PzXpaJBcYIwgwHk3/tgo8O/5X1rFGyjNn+xqDNVUMWYWnJQSp+Fh6gBJog54ZfyrYhCxdLQWEtV2nNpJcy8mk+5UcCX7pcFAT1Sc+EIem7KPZzW1gvbnS248mVgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8MYpX3WyzodlocaDb+akci0dei0Zp0qUHnhQFBUIf4=;
 b=JwicKyKC8rYcUnDpenkpbSUvJ+nOgoGq/CAVowbb8GHGICjpLJVKVfa03F0TcdGTfq8adm2nikIZ7lf79d3uPGjVubzA+RWVjxh60jDBIBBISAQhwPl7dJLOzDqnanSFp8d3RS1CV9oxphnI/8+kKIkrEfef+UG1sPhOhL2kKPs=
Authentication-Results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by DM6PR13MB3785.namprd13.prod.outlook.com (2603:10b6:5:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.9; Mon, 20 Sep
 2021 09:57:33 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::b40c:9bd9:dfcd:7ff0]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::b40c:9bd9:dfcd:7ff0%5]) with mapi id 15.20.4544.013; Mon, 20 Sep 2021
 09:57:33 +0000
Date:   Mon, 20 Sep 2021 11:57:26 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: Re: False positive for 'Possible unnecessary KERN_ERR' warning in
 checkpatch
Message-ID: <YUhbBqTGHX5+y5D5@bismarck.dyn.berto.se>
References: <YUDIOLTCe0/kzVSW@bismarck.dyn.berto.se>
 <faefcecf38e0c108be86f05f79f290e918016c13.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faefcecf38e0c108be86f05f79f290e918016c13.camel@perches.com>
X-ClientProxiedBy: AM5PR0701CA0008.eurprd07.prod.outlook.com
 (2603:10a6:203:51::18) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
Received: from bismarck.dyn.berto.se (84.172.88.146) by AM5PR0701CA0008.eurprd07.prod.outlook.com (2603:10a6:203:51::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Mon, 20 Sep 2021 09:57:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba70349c-ef7f-4a1c-84d7-08d97c1d1127
X-MS-TrafficTypeDiagnostic: DM6PR13MB3785:
X-Microsoft-Antispam-PRVS: <DM6PR13MB37853EC07B83F556FA30F04FE7A09@DM6PR13MB3785.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhrMdjL2ZRAZhmBcZExCG5dy1sRQFUR7/r3wXBioQTeynMq1pIbbJn4H+vkDqWKIp4mBe/CM760lV9F/IwY9lZ0XO4i5OFZAA0H8YjPGbGCWKAaIFp5K1PS5ojeKa8CVEgXvOYEWI6QDhe0f6fEqgHzaq7BB5VNXvWHnCp/eNG4Cxr5L+8ZxLN7yMFwIx+gHaxLU2tFXsnND3M2VMXzAvz8uxA5JMu/IH/gmRqFoggnBzXrMdNue6dPom82FMbJ2EqPSkSHtJLHmu6z6DKFxooF/KBGXQTFf0Rp5CsuT3nto3Wh+4EMYYEaMh2ktI291KtesNvaqv1ik6EnOicotx+FeF/BxiLp6VLJZRQ3qIe/RDAKPxAShtaHu3KiYy6ie7XUM01W5dejL3gqVklfUlW/ksI5qvWv+vyXLJTsySlfTN0HpuxYjE7FrCmfHt+RPwvATRosHJsuUbyov9y8o8NiCz7NPaGvfHTk+7OFPC/jaKGx5EacXnPqQ8QwE2Vs01Lw9F55OzGaCE9zL1K74yw8AzXYZHs9MTxUcfJnxiwa0pUmYR9alEpraoFUTurza3fcPh+Lcc5Q46OhobpGz8vPVmheSx9xu/rD/OJ8f3ogL3t8N0x2qIsQHNr7h/U9cm2z2YkLMEOLxJCWkKEdyMeygMUy8oBADjY8XEUdWPN5G8bqSgaHGk02IBX+m3ixjGk2v4bTykz/KUmm8kAXDNoPfjSOgGWRU/DszElp8PTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39830400003)(376002)(366004)(52116002)(7696005)(8676002)(956004)(4326008)(86362001)(316002)(6506007)(2906002)(53546011)(66476007)(8936002)(66946007)(55016002)(66556008)(186003)(6916009)(38350700002)(38100700002)(66574015)(9686003)(26005)(6666004)(5660300002)(478600001)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?v4G/2o/JQ10xFJtm0lEsOBJTGWaYip7t1Lc0/apUJ1uNX96Be1FfidOWAt?=
 =?iso-8859-1?Q?B1xdJAmXgftzGauKwoqqSMdLt48pDF08+Oean4X2GHYosUHidNZYhUA0uo?=
 =?iso-8859-1?Q?Sqk3FoqofCw8RYMOsQufhj3G0IPSqsefZL9xy8NxW8Dm7QSrYGfkyynXSD?=
 =?iso-8859-1?Q?NYwOPh5+wzoxxvV9J0O6SX83xzGEYVuhRdVUnNFiTY/cGRa8d36eoA3DzO?=
 =?iso-8859-1?Q?dzqKGdjkJvtfjAxOGlH4/WxkNNHM2bWovDQsBgCtKsn6+MPPAhFlG6/lfU?=
 =?iso-8859-1?Q?NXmoB40pW2ZKv8IA3D0qhijttTewYe50+MxAEI9OLE7Xu71mCq3svVMFWd?=
 =?iso-8859-1?Q?MjetfATtLOalVrDw3MLCtFiwsAZP0CcUFAaMFgTttHKJHGduNpf3ChdYes?=
 =?iso-8859-1?Q?KjuaDfR6PW8SptCfY4Z4rXegVw94/npDjxGbj6i7sT++rYhOlExLTUcUfl?=
 =?iso-8859-1?Q?rJF8u0ycW0Q0i22YSqgN0P9JlbP+ZBDWhitiMYFvttexVtkn3bXBhuUpg9?=
 =?iso-8859-1?Q?FkCKrBiFb/xh8ZKBVX6AN9dYgXKtxPOf7d08rH7nkPVuLjf/PKsjDKk29k?=
 =?iso-8859-1?Q?VG6FRZ63F4Kk3VbLZd+TFAJNpsp/Tune16Xx1KN/nDGTOfu0HugRBsvjAo?=
 =?iso-8859-1?Q?MRpEuVeJ0X+FMifJ4UTDeeodVm743PMrVLcsa6DJGHGrzmPSHr0nRdQPQI?=
 =?iso-8859-1?Q?sJMyjc1SphWpPur8EpXv8d+jVtINzXjCiVooqHsJfe62jy6b6OWRPbwDYX?=
 =?iso-8859-1?Q?xLRU88oQI7LRxoQDEEp/EVrLBQuswLKF48I1hGOQ74at/Zl8Xm/rybGw+W?=
 =?iso-8859-1?Q?pzwi4zEBjEmfbR8sUBWbqu9iTmMPQEv4TFsmhlDZoIf8nyswWXUB9F+W/c?=
 =?iso-8859-1?Q?QsN9Syi1Ntj7nhzvrj6gKFFctJzmHTJNn4EWYHQt2V881/1H20RwiPLpwB?=
 =?iso-8859-1?Q?nfkEfGf1+7F+i4o0FlKI6v4sbgZR6CI49Ycskpxb26x0B/qFJwaf9wSTbC?=
 =?iso-8859-1?Q?9m6xWxkK9W9eWB2xiMEsyYJoSZ0CJNH/FlzUoDcos+Qy2s0arvP7Ku/Ozh?=
 =?iso-8859-1?Q?z1XRTKwD9pQUJ5GaOi88KBs4JzcP9F/Fgnv13eXlvFQPemKc0KKjw2jPGx?=
 =?iso-8859-1?Q?HhMgdcYbAv3tgGM3fPoM/eajwuiOw0BuiSeqIO58BjrlqR8cio1rlYhmwF?=
 =?iso-8859-1?Q?lydMcuxDWUh/jxOb3PoSWb+FOcRbc1ANN5PoN+QwauMG4NoSv76HtVLpXX?=
 =?iso-8859-1?Q?VQXMhrzEd8v3O83W5tlwEcsOw8g1h0ptA8/DlXstKdLVvA2t4pakhm91i9?=
 =?iso-8859-1?Q?9+JDx061l+xJST1g2jIkjcagN7uJeP4J56dWui4bTaPSlLTUMJIj0DVIbj?=
 =?iso-8859-1?Q?rx7mQal+VO?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba70349c-ef7f-4a1c-84d7-08d97c1d1127
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 09:57:33.4369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXK4M0KpYBP2fANdMLwityPklFHfOM81K6H3/XRcfy+obP9/R1VjCweMWD3yp/hzc7yuIWbrvviWGIs6WENo/QXuhuyJ9EqMJFLAHmflVCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3785
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Thanks for your help.

I like your solution. Would you like to send a patch for this or would 
you like me to do that with you in a Suggested-by ?

On 2021-09-15 20:46:22 -0700, Joe Perches wrote:
> On Tue, 2021-09-14 at 18:05 +0200, Niklas Söderlund wrote:
> > Hi Joe,
> > 
> > Maybe you are already aware of this, but in case you are not.
> > 
> > The issue is the checkpatch check for unnecessary KERN_<LEVEL> for log 
> > functions. If a single line contains a statement that match a log 
> > function name from $logFunctions, such as foo_err() and the same line 
> > contains a KERN_<LEVEL> statement the 'WARNING: Possible unnecessary 
> > KERN_ERR' is triggered. This is true even if the KERN_<LEVEL> statement 
> > is not part of the arguments to the foo_err() definition that triggers 
> > the first part of the check.
> > 
> > This can be demonstrated by,
> > 
> >     ./scripts/checkpatch.pl --mailback --git c821e617896e99b8
> > 
> > Where we get (among others) the warning,
> > 
> >     WARNING: Possible unnecessary KERN_ERR
> >     #38: FILE: drivers/net/ethernet/netronome/nfp/nfp_net.h:63:
> >     +#define nn_err(nn, fmt, args...)	nn_pr(nn, KERN_ERR, fmt, ## args)
> > 
> > Looking at the code in checkpatch.pl we have,
> > 
> > our $logFunctions = qr{(?x:
> >         printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
> >         (?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
> >         TP_printk|
> >         WARN(?:_RATELIMIT|_ONCE|)|
> >         panic|
> >         MODULE_[A-Z_]+|
> >         seq_vprintf|seq_printf|seq_puts
> > )};
> > 
> > ...
> > 
> > # check for logging functions with KERN_<LEVEL>
> >                 if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
> >                     $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
> >                         my $level = $1;
> >                         if (WARN("UNNECESSARY_KERN_LEVEL",
> >                                  "Possible unnecessary $level\n" . $herecurr) &&
> >                             $fix) {
> >                                 $fixed[$fixlinenr] =~ s/\s*$level\s*//;
> >                         }
> >                 }
> > 
> > Looking at the line from above that triggers the warning,
> > 
> > 	#define nn_err(nn, fmt, args...)   nn_pr(nn, KERN_ERR, fmt, ## args)
> > 
> > We see that the warning is triggers by the regexp but that it matches 
> > the first part on nn_err( and then the second part of on the second 
> > argument to nn_pr, KERN_ERR. I believe this to be a false positive.
> > 
> > Unfortunately my Perl skills are not good enough to fix the check to only 
> > look for KERN_[A-Z]+ inside the argument list to the log function name 
> > that matches the first part of the regexp.
> > 
> 
> I would have avoided it and gotten dynamic debug support at the
> same time with:
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net.h | 48 ++++++++++++++--------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
> index df203738511bf..46178a7244ad8 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
> @@ -25,32 +25,32 @@
>  
>  #include "nfp_net_ctrl.h"
>  
> -#define nn_pr(nn, lvl, fmt, args...)					\
> -	({								\
> -		struct nfp_net *__nn = (nn);				\
> +#define nn_pr(nn, lvl, fmt, ...)					\
> +({									\
> +	struct nfp_net *__nn = (nn);					\
>  									\
> -		if (__nn->dp.netdev)					\
> -			netdev_printk(lvl, __nn->dp.netdev, fmt, ## args); \
> -		else							\
> -			dev_printk(lvl, __nn->dp.dev, "ctrl: " fmt, ## args); \
> -	})
> -
> -#define nn_err(nn, fmt, args...)	nn_pr(nn, KERN_ERR, fmt, ## args)
> -#define nn_warn(nn, fmt, args...)	nn_pr(nn, KERN_WARNING, fmt, ## args)
> -#define nn_info(nn, fmt, args...)	nn_pr(nn, KERN_INFO, fmt, ## args)
> -#define nn_dbg(nn, fmt, args...)	nn_pr(nn, KERN_DEBUG, fmt, ## args)
> -
> -#define nn_dp_warn(dp, fmt, args...)					\
> -	({								\
> -		struct nfp_net_dp *__dp = (dp);				\
> +	if (__nn->dp.netdev)						\
> +		netdev_##lvl(__nn->dp.netdev, fmt, ##__VA_ARGS__);	\
> +	else								\
> +		dev_##lvl(__nn->dp.dev, "ctrl: " fmt, ##__VA_ARGS__);	\
> +})
> +
> +#define nn_err(nn, fmt, ...)	nn_pr(nn, err, fmt, ##__VA_ARGS__)
> +#define nn_warn(nn, fmt, ...)	nn_pr(nn, warn, fmt, ##__VA_ARGS__)
> +#define nn_info(nn, fmt, ...)	nn_pr(nn, info, fmt, ##__VA_ARGS__)
> +#define nn_dbg(nn, fmt, ...)	nn_pr(nn, dbg, fmt, ##__VA_ARGS__)
> +
> +#define nn_dp_warn(dp, fmt, ...)					\
> +({									\
> +	struct nfp_net_dp *__dp = (dp);					\
>  									\
> -		if (unlikely(net_ratelimit())) {			\
> -			if (__dp->netdev)				\
> -				netdev_warn(__dp->netdev, fmt, ## args); \
> -			else						\
> -				dev_warn(__dp->dev, fmt, ## args);	\
> -		}							\
> -	})
> +	if (unlikely(net_ratelimit())) {				\
> +		if (__dp->netdev)					\
> +			netdev_warn(__dp->netdev, fmt, ##__VA_ARGS__);	\
> +		else							\
> +			dev_warn(__dp->dev, fmt, ##__VA_ARGS__);	\
> +	}								\
> +})
>  
>  /* Max time to wait for NFP to respond on updates (in seconds) */
>  #define NFP_NET_POLL_TIMEOUT	5
> 
> 

-- 
Regards,
Niklas Söderlund
