Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF43F40D221
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 05:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhIPDrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 23:47:46 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:33996 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232541AbhIPDrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 23:47:45 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id ADEF0837F24A;
        Thu, 16 Sep 2021 03:46:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id F3A462EBF98;
        Thu, 16 Sep 2021 03:46:23 +0000 (UTC)
Message-ID: <faefcecf38e0c108be86f05f79f290e918016c13.camel@perches.com>
Subject: Re: False positive for 'Possible unnecessary KERN_ERR' warning in
 checkpatch
From:   Joe Perches <joe@perches.com>
To:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Date:   Wed, 15 Sep 2021 20:46:22 -0700
In-Reply-To: <YUDIOLTCe0/kzVSW@bismarck.dyn.berto.se>
References: <YUDIOLTCe0/kzVSW@bismarck.dyn.berto.se>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.08
X-Stat-Signature: fwkk6k51xd967gxqym9431ci19hbt9hy
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: F3A462EBF98
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/JyTvglfxhNjZM4VK80aLGqvyIKxzQ31Q=
X-HE-Tag: 1631763983-93307
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-14 at 18:05 +0200, Niklas Söderlund wrote:
> Hi Joe,
> 
> Maybe you are already aware of this, but in case you are not.
> 
> The issue is the checkpatch check for unnecessary KERN_<LEVEL> for log 
> functions. If a single line contains a statement that match a log 
> function name from $logFunctions, such as foo_err() and the same line 
> contains a KERN_<LEVEL> statement the 'WARNING: Possible unnecessary 
> KERN_ERR' is triggered. This is true even if the KERN_<LEVEL> statement 
> is not part of the arguments to the foo_err() definition that triggers 
> the first part of the check.
> 
> This can be demonstrated by,
> 
>     ./scripts/checkpatch.pl --mailback --git c821e617896e99b8
> 
> Where we get (among others) the warning,
> 
>     WARNING: Possible unnecessary KERN_ERR
>     #38: FILE: drivers/net/ethernet/netronome/nfp/nfp_net.h:63:
>     +#define nn_err(nn, fmt, args...)	nn_pr(nn, KERN_ERR, fmt, ## args)
> 
> Looking at the code in checkpatch.pl we have,
> 
> our $logFunctions = qr{(?x:
>         printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
>         (?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
>         TP_printk|
>         WARN(?:_RATELIMIT|_ONCE|)|
>         panic|
>         MODULE_[A-Z_]+|
>         seq_vprintf|seq_printf|seq_puts
> )};
> 
> ...
> 
> # check for logging functions with KERN_<LEVEL>
>                 if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
>                     $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
>                         my $level = $1;
>                         if (WARN("UNNECESSARY_KERN_LEVEL",
>                                  "Possible unnecessary $level\n" . $herecurr) &&
>                             $fix) {
>                                 $fixed[$fixlinenr] =~ s/\s*$level\s*//;
>                         }
>                 }
> 
> Looking at the line from above that triggers the warning,
> 
> 	#define nn_err(nn, fmt, args...)   nn_pr(nn, KERN_ERR, fmt, ## args)
> 
> We see that the warning is triggers by the regexp but that it matches 
> the first part on nn_err( and then the second part of on the second 
> argument to nn_pr, KERN_ERR. I believe this to be a false positive.
> 
> Unfortunately my Perl skills are not good enough to fix the check to only 
> look for KERN_[A-Z]+ inside the argument list to the log function name 
> that matches the first part of the regexp.
> 

I would have avoided it and gotten dynamic debug support at the
same time with:
---
 drivers/net/ethernet/netronome/nfp/nfp_net.h | 48 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
index df203738511bf..46178a7244ad8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
@@ -25,32 +25,32 @@
 
 #include "nfp_net_ctrl.h"
 
-#define nn_pr(nn, lvl, fmt, args...)					\
-	({								\
-		struct nfp_net *__nn = (nn);				\
+#define nn_pr(nn, lvl, fmt, ...)					\
+({									\
+	struct nfp_net *__nn = (nn);					\
 									\
-		if (__nn->dp.netdev)					\
-			netdev_printk(lvl, __nn->dp.netdev, fmt, ## args); \
-		else							\
-			dev_printk(lvl, __nn->dp.dev, "ctrl: " fmt, ## args); \
-	})
-
-#define nn_err(nn, fmt, args...)	nn_pr(nn, KERN_ERR, fmt, ## args)
-#define nn_warn(nn, fmt, args...)	nn_pr(nn, KERN_WARNING, fmt, ## args)
-#define nn_info(nn, fmt, args...)	nn_pr(nn, KERN_INFO, fmt, ## args)
-#define nn_dbg(nn, fmt, args...)	nn_pr(nn, KERN_DEBUG, fmt, ## args)
-
-#define nn_dp_warn(dp, fmt, args...)					\
-	({								\
-		struct nfp_net_dp *__dp = (dp);				\
+	if (__nn->dp.netdev)						\
+		netdev_##lvl(__nn->dp.netdev, fmt, ##__VA_ARGS__);	\
+	else								\
+		dev_##lvl(__nn->dp.dev, "ctrl: " fmt, ##__VA_ARGS__);	\
+})
+
+#define nn_err(nn, fmt, ...)	nn_pr(nn, err, fmt, ##__VA_ARGS__)
+#define nn_warn(nn, fmt, ...)	nn_pr(nn, warn, fmt, ##__VA_ARGS__)
+#define nn_info(nn, fmt, ...)	nn_pr(nn, info, fmt, ##__VA_ARGS__)
+#define nn_dbg(nn, fmt, ...)	nn_pr(nn, dbg, fmt, ##__VA_ARGS__)
+
+#define nn_dp_warn(dp, fmt, ...)					\
+({									\
+	struct nfp_net_dp *__dp = (dp);					\
 									\
-		if (unlikely(net_ratelimit())) {			\
-			if (__dp->netdev)				\
-				netdev_warn(__dp->netdev, fmt, ## args); \
-			else						\
-				dev_warn(__dp->dev, fmt, ## args);	\
-		}							\
-	})
+	if (unlikely(net_ratelimit())) {				\
+		if (__dp->netdev)					\
+			netdev_warn(__dp->netdev, fmt, ##__VA_ARGS__);	\
+		else							\
+			dev_warn(__dp->dev, fmt, ##__VA_ARGS__);	\
+	}								\
+})
 
 /* Max time to wait for NFP to respond on updates (in seconds) */
 #define NFP_NET_POLL_TIMEOUT	5


