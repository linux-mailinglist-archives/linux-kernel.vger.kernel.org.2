Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7377141D470
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348662AbhI3HW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:22:27 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:59851 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348581AbhI3HW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:22:26 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Sep 2021 03:22:25 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CEE1F102A4F05;
        Thu, 30 Sep 2021 09:13:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AE187276E09; Thu, 30 Sep 2021 09:13:33 +0200 (CEST)
Date:   Thu, 30 Sep 2021 09:13:33 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [l1k:nft_egress_v5 4/5] net/netfilter/nfnetlink_hook.c:232:17:
 error: 'netdev' undeclared; did you mean 'net_eq'?
Message-ID: <20210930071333.GB28709@wunner.de>
References: <202109301429.nkI9cvIc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109301429.nkI9cvIc-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:39:37PM +0800, kernel test robot wrote:
>    net/netfilter/nfnetlink_hook.c: In function 'nfnl_hook_entries_head':
> >> net/netfilter/nfnetlink_hook.c:232:17: error: 'netdev' undeclared (first use in this function); did you mean 'net_eq'?
>      232 |                 netdev = dev_get_by_name_rcu(net, dev);
>          |                 ^~~~~~
>          |                 net_eq
>    net/netfilter/nfnetlink_hook.c:232:17: note: each undeclared identifier is reported only once for each function it appears in

Thank you, trusty robot.  I've just fixed up the branch as follows:


diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
index 782d2db..c1559e8 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -185,7 +185,7 @@ static int nfnl_hook_dump_one(struct sk_buff *nlskb,
 nfnl_hook_entries_head(u8 pf, unsigned int hook, struct net *net, const char *dev)
 {
 	const struct nf_hook_entries *hook_head = NULL;
-#ifdef CONFIG_NETFILTER_INGRESS
+#if defined(CONFIG_NETFILTER_INGRESS) || defined(CONFIG_NETFILTER_EGRESS)
 	struct net_device *netdev;
 #endif
 
