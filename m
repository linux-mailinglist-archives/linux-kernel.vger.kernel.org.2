Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9937931C18E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBOScw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:32:52 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48453 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhBOSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:32:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 400C7F7F;
        Mon, 15 Feb 2021 13:31:43 -0500 (EST)
Received: from imap22 ([10.202.2.72])
  by compute3.internal (MEProxy); Mon, 15 Feb 2021 13:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=0qCRLx0h2AKsHxckh5wv5Va15TvWqZZ
        LVNedxRK01Us=; b=R4gkr88Bdqm/LpB+5hgG8cbkA91QotWhE/lNlW/qWr0ZwqU
        gYFKIY/mJqVxZYyXshAWiSXNUq4+jstIgovKJoetilLj1ArFTl4i7bELem67kaFN
        /X8VT5kW8bK9hOo1+e1Lo6fkL/Zsy+uu25i/gdaZv0AzyEAGSbJxxRzO2fl7Jf13
        TZ3s7D4V4wIzUyEt75L/e9FMtQQNp7n+/L63Oca8cIj9dOjU2oI6s2ZJlTxW0zE+
        1j9dIBE713+vqSJfS1W+9y4dr40312ox/PZ0nwTHIX+ArB8PvBVvUJJwov0taiLI
        KPxqb2m9KhwGWlfiAW6DxfUHt5eIKf0c+5uJTCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0qCRLx
        0h2AKsHxckh5wv5Va15TvWqZZLVNedxRK01Us=; b=kB8WCs9c9ZZsiGChHgJJb0
        KvETPjR7lZmrfTYk0zIdOsx1PGYBKKmp9t1rnJt2Mzm+6A7hbkpCikJasezlldfl
        V1NoJRXqzDtupB9CfgdJ15cTXxWJkkSQXTZfYC00jipsyTgvB92yYRsFp3NH1+Wu
        Miq/tJcA7utmmk/yzq8XG2L48RyTtrlEqnWbjd4B/MkXVl3Tdr7rBm0OXNwQgElR
        SncPpjpuAH1JJ/M8k5eggKb/P6+rlHffYkDYTtLl8nPPGtLHRPr2xlmZ6vAaNgAB
        HlILqEPlbBmc8k7dlg+Q7DniaGx99/zQQASyWruj2dYMaS3m2FIaWPxd1N8JBQVg
        ==
X-ME-Sender: <xms:Dr4qYMmwkEZ2gfWVP9HzpFvlYd-2pmrEo5rRZZ3z0Y4Oa8PpSgKmVA>
    <xme:Dr4qYL33sZkIjEtKWMmijD1AkiJh3iCnsoyaKUN_LqgSL0LeXhWME2laCWF8nK_85
    Z7nKqIF1zG8lbRoTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrieekgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdghihhl
    lhhirghmucffuhhrrghnugdfuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtf
    frrghtthgvrhhnpeevffdttddtvdehtdejueethedtheevkefftdelgfeluddtgfffueel
    vdfgudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpeifihhllhdoghhithesughrnhgurdhmvg
X-ME-Proxy: <xmx:Dr4qYKqh9pTtUzDBWR3_CeHl3Gh6HFVSpqmCCx6VnZv0G52Q-onPiQ>
    <xmx:Dr4qYIn93Lta9w0VAdApO6NXnpm7Zia47saC4LSdVuV5rkO5370jVA>
    <xmx:Dr4qYK3NcE2q9Dk9KfD0IvAAhWnQU4HqjvLEmkxDWPSgxSew1W4TFA>
    <xmx:Dr4qYP_QGFA3yac49ZlhI_jeppKXv_9e7JWvWyucDGW1u40zAqs4yA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 65D0762C005E; Mon, 15 Feb 2021 13:31:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <e9da5d1f-e614-4749-9ad6-7121f0fbe573@www.fastmail.com>
In-Reply-To: <20210215130334.GM2087@kadam>
References: <20210213092014.29466-1-will+git@drnd.me>
 <20210215130334.GM2087@kadam>
Date:   Mon, 15 Feb 2021 19:30:29 +0100
From:   "William Durand" <will+git@drnd.me>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix typo in a function name
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Feb 13, 2021 at 09:20:14AM +0000, William Durand wrote:
> > Other function names use the verb 'query' so this function should
> > probably use it too and that's what this patch is about. I didn't
> > find any other occurrence and the code compiles.
> > 
> 
> It's really just assumed that the code still compiles afterwards.
> Sometimes, it's hard for me to right commit messages confidently because
> I don't know if static checker bugs affect real life.  But in this case
> I really think the commit message could be written more confidently.
> 
> Please write it like this:
> "There is a typo here where it says "qurey" but "query" was intended."

Thanks Dan, I'll update the commit message shortly and send a new patch.

Will
