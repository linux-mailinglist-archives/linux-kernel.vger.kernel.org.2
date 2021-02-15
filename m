Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B474531B8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBOMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:15:45 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42357 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229627AbhBOMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:15:43 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DD275D4F;
        Mon, 15 Feb 2021 07:14:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 15 Feb 2021 07:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WT+xHf4HDpWUDkEJS4BLE3/HYUb
        ZfnbMJhfjR/ecjmQ=; b=Lz55wQd4ObqFUMt1hEOvO4kpur3t0TfGbQkz1HAN7Gd
        X6iyiHSSrF7VmeskTAR2coDd0i8wqFFqWGnwh8qeCkxRM+VLilcHkg3mQUFRqHPa
        GJAuYWiOYiJVraBnZbAFhovjbezCHnKq5i0UndRFGfOJdiOmvFSmLvQf/qrQAMrw
        tluYwzNnbCOF3QJZCsIJvMRIhdq9rU1z7dqH8C4iWC3Ns3EKdB7cxyR8JoslkVwy
        fLdbCh2PGYy+PkhEfCr+DC4kah/K3ZqjVWSoS9ZocHeuFZiPrQPK/ex5vXQFn6q1
        WaS4cvW2bMS68fsnfDHHwKtbV0ujPNvmNCn2gDmCc1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WT+xHf
        4HDpWUDkEJS4BLE3/HYUbZfnbMJhfjR/ecjmQ=; b=MRcbPe8jlg7du1Jw7YQsWS
        O9g4tj/fzl1UMu5tOzcunLUmJvsJC5vVST097I/sEzmNd62MuzE56FKRysdOTAlX
        vscuhaF5Yg5W0Y/3wZ7hMmOz25Kix8TAx4mfDd/+NM4yA80iz37XU63EE2eMfcxX
        RFilywDmvhWC++klx1nVd69eKkWGww9Zp/Z6vSfGnhE1FpmDCsDTXEwxR2C+Olo0
        lCiEPTV9IbaIXccujyBN5yAKRjsxucZNPkVlLIhAuao9K8KSeA68LLy06q6F8DFU
        QgHUHowIVrZvBTSFLLRjUINxPx2chYDWoKRuKCxtnl/Pffo7K+dohwRA34a2CJ4g
        ==
X-ME-Sender: <xms:wGUqYKtOngAdQ82G1p2A0vRAbzl5PWF0ILG6GCBNo6D2Jw6OXEd4-Q>
    <xme:wGUqYDwMUesSkVvy1UwB65tL19B6THUPIPtuYT7LqIxyjA4yc_BH9HjlI-vwr80JZ
    3HjOsKp-4TrKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieekgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeeuleeltdehkeeltefhleduuddvhfffuedvffduveegheekge
    eiffevheegfeetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:wGUqYE7QZC2s6jAkDCuHkxgZelaHrYFZYmCOrU7OGCe9bP5SDr2xyA>
    <xmx:wGUqYNW8zERbS_bjb8zfBA1Xx3YX3uI-eaGKLpY4JVVJ2xxoL3zYew>
    <xmx:wGUqYA3NrTvJGgGemUsDMU5BSE-rJiQoqAdZqeuENxhmVEmy6ztpdw>
    <xmx:wWUqYLCntyDvv_rZp2iADwxpMdf88fECGjCAwMduA5g1LJu_ndQzQw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3212E24005D;
        Mon, 15 Feb 2021 07:14:56 -0500 (EST)
Date:   Mon, 15 Feb 2021 13:14:54 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     pablo@netfilter.org, stable-commits@vger.kernel.org
Subject: Re: Patch "netfilter: nftables: fix possible UAF over chains from
 packet path in netns" has been added to the 4.19-stable tree
Message-ID: <YCplvtJjUZc0TK1P@kroah.com>
References: <20210215042956.9644064EC3@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215042956.9644064EC3@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 11:29:55PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     netfilter: nftables: fix possible UAF over chains from packet path in netns
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      netfilter-nftables-fix-possible-uaf-over-chains-from.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 142e293ce46a1c63cb167af6743e2b8abb6581df
> Author: Pablo Neira Ayuso <pablo@netfilter.org>
> Date:   Tue Feb 2 16:07:37 2021 +0100
> 
>     netfilter: nftables: fix possible UAF over chains from packet path in netns
>     
>     [ Upstream commit 767d1216bff82507c945e92fe719dff2083bb2f4 ]
>     
>     Although hooks are released via call_rcu(), chain and rule objects are
>     immediately released while packets are still walking over these bits.
>     
>     This patch adds the .pre_exit callback which is invoked before
>     synchronize_rcu() in the netns framework to stay safe.
>     
>     Remove a comment which is not valid anymore since the core does not use
>     synchronize_net() anymore since 8c873e219970 ("netfilter: core: free
>     hooks with call_rcu").
>     
>     Suggested-by: Florian Westphal <fw@strlen.de>
>     Fixes: df05ef874b28 ("netfilter: nf_tables: release objects on netns destruction")
>     Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 9cc8e92f4b000..e669e20120446 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -7303,6 +7303,17 @@ int __nft_release_basechain(struct nft_ctx *ctx)
>  }
>  EXPORT_SYMBOL_GPL(__nft_release_basechain);
>  
> +static void __nft_release_hooks(struct net *net)
> +{
> +	struct nft_table *table;
> +	struct nft_chain *chain;
> +
> +	list_for_each_entry(table, &net->nft.tables, list) {
> +		list_for_each_entry(chain, &table->chains, list)
> +			nf_tables_unregister_hook(net, table, chain);
> +	}
> +}
> +
>  static void __nft_release_tables(struct net *net)
>  {
>  	struct nft_flowtable *flowtable, *nf;
> @@ -7318,10 +7329,6 @@ static void __nft_release_tables(struct net *net)
>  
>  	list_for_each_entry_safe(table, nt, &net->nft.tables, list) {
>  		ctx.family = table->family;
> -
> -		list_for_each_entry(chain, &table->chains, list)
> -			nf_tables_unregister_hook(net, table, chain);
> -		/* No packets are walking on these chains anymore. */
>  		ctx.table = table;
>  		list_for_each_entry(chain, &table->chains, list) {
>  			ctx.chain = chain;
> @@ -7368,6 +7375,11 @@ static int __net_init nf_tables_init_net(struct net *net)
>  	return 0;
>  }
>  
> +static void __net_exit nf_tables_pre_exit_net(struct net *net)
> +{
> +	__nft_release_hooks(net);
> +}
> +
>  static void __net_exit nf_tables_exit_net(struct net *net)
>  {
>  	mutex_lock(&net->nft.commit_mutex);
> @@ -7379,8 +7391,9 @@ static void __net_exit nf_tables_exit_net(struct net *net)
>  }
>  
>  static struct pernet_operations nf_tables_net_ops = {
> -	.init	= nf_tables_init_net,
> -	.exit	= nf_tables_exit_net,
> +	.init		= nf_tables_init_net,
> +	.pre_exit	= nf_tables_pre_exit_net,
> +	.exit		= nf_tables_exit_net,
>  };
>  
>  static int __init nf_tables_module_init(void)

This breaks the build in 4.19.y, so I've dropped it.

Sasha, did it pass your builders?

thanks,

greg k-h
