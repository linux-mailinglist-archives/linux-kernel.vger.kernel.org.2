Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026C1370AD1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhEBIwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 04:52:12 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47277 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhEBIwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 04:52:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7B2A5580561;
        Sun,  2 May 2021 04:51:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 02 May 2021 04:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nAMKrF
        +bnNdI3pkgmLhVLX5VUAzgUMzelRzJuMYbyMs=; b=BUCCTogNZaYRRxzyJztiVI
        xShJGneV54rIEyRyoSlS+fmXKMKcey9oOslb2tvsFHr5VTuXYNaJ7Wkdk15kKg+I
        UXPFbX/sEpkLPozL30ovUQF1Nd++3oO29OGeXtHzOeweopCe5SoW4mB/g6+iKmFv
        XQx3kuSsLHz+x2GEMld5s0kGTzDq3QyVtdZH+u7+ZPRtOTNV/BVa+ij9ccXdFbsz
        WDNfDZz6bqLxs60DgQq54JGerzqFjNv7r7K5a5lagbQjg9DkyDgNN8nAGxf0eHye
        yRht/U0kvcLiPz6kisiP3i6Qiqp/tDf7drGFmPfVYh65ry3AOfEE+O7Z8vMCcVXw
        ==
X-ME-Sender: <xms:B2iOYFUftyVxfNPqkT8bZZjNufyoqjRJ7vV5kG6yG2sCP8Lw5QHcVw>
    <xme:B2iOYFnRcHWA-imQSrqnhGS3TUZE2T1XoLRkaqPbWtaE7KRJXZNscq6JHuS0mMFqR
    VYA9bJqviR_Reo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefuddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeuteegheehgeduueehffeltdegveelteeukeetteethfeltddvhfdtuedvueei
    feenucffohhmrghinhepnhhvihguihgrrdgtohhmpdgrrhhishhtrgdrtghomhenucfkph
    epudelfedrgeejrdduieehrddvhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:B2iOYBZxi4C23t6ZeW46_azG74D8pjdyHVcbx-L9YKDyYk5Pvh691Q>
    <xmx:B2iOYIVWJJwr7H30sC2-afbXy0C_xF49HOBTeEX4XeSiNUIuttjHCQ>
    <xmx:B2iOYPkYFHa-nLk3EPr2yoanlpfGqTN7G_x-UAcr0mIjK5vFX4wOog>
    <xmx:CGiOYNVjBeLpxGXQKta1U2dLOXvtkGrDeFU3Ha1LsEWgcN3_rgOWcQ>
Received: from localhost (unknown [193.47.165.251])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sun,  2 May 2021 04:51:18 -0400 (EDT)
Date:   Sun, 2 May 2021 11:51:15 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Pavel Balaev <mail@void.so>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH v6 net-next 1/3] net/ipv4: multipath routing:
 configurable seed
Message-ID: <YI5oA8XtW+DVE8xD@shredder>
References: <YIlVpYMCn/8WfE1P@rnd>
 <YIrQ0Nyse0fnwpEC@shredder.lan>
 <YIvr0bohU95kDzU+@rnd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIvr0bohU95kDzU+@rnd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 02:36:49PM +0300, Pavel Balaev wrote:
> On Thu, Apr 29, 2021 at 06:29:20PM +0300, Ido Schimmel wrote:
> > On Wed, Apr 28, 2021 at 03:31:33PM +0300, Pavel Balaev wrote:
> > This looks overly complex to me and I believe a lot of users will ask
> > themselves why they need to specify a seed using two hex numbers
> > separated by a comma. Looking at other implementations that already
> > allow specifying the seed, it is specified as a single integer.
> > 
> > 32-bit in Cumulus:
> > https://docs.nvidia.com/networking-ethernet-software/cumulus-linux-43/Layer-3/Routing/Equal-Cost-Multipath-Load-Sharing-Hardware-ECMP/#configure-a-hash-seed-to-avoid-hash-polarization
> > 
> > Up to 16-bit in Arista:
> > https://eos.arista.com/hashing-for-l2-port-channels-and-l3-ecmp/
> > 
> > I believe you chose this interface because of the structure of the
> > SipHash key that is used for the multipath hash calculation. This is an
> > internal implementation detail and should not determine the user
> > interface.
> > 
> > Looking at the history of the code, the flow dissector was migrated to
> > SipHash in commit 55667441c84f ("net/flow_dissector: switch to
> > siphash"). The motivating use case was flow label generation since these
> > are sent on the wire together with the fields from which they were
> > computed, not multipath hash calculation that also happens to rely on
> > the flow dissector.
> > 
> > Given the above, do you see a problem with having the user specify a
> > 32-bit number for the multipath hash seed? Note that SipHash is still
> > used and that the number can be used to fill the entire 128-bit space.
> 
> Do you mean take 32-bit number from user and multiply it like this:
> u32 key = val;
> u64 key64;
> memset(&key64, val, sizeof(u32));
> memset(&key64 + sizeof(u32), val, sizeof(u32));
> memset(seed.key[0], &key64, sizeof(u64));
> memset(seed.key[1], &key64, sizeof(u64));
> ?

Something like that, yes. It's still only 32-bit of user input, but it
can't hurt. Do you see a need to specify more than 32 bits for multipath
hash seed when the purpose is to force the same seed on multiple
machines?
