Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161BF3FF2DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbhIBRxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:53:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35017 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234387AbhIBRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:53:53 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EA8D5C0057;
        Thu,  2 Sep 2021 13:52:54 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Thu, 02 Sep 2021 13:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=YqDG6FELYXKOGx05z2N/f04eEjXw
        REvo5E6aqK66880=; b=q6R1LZrgITJyno+YBkcW47H7CzcRy60u3A0I4+7Ed5YG
        /1Sz3ghd5vCygyZ0FL+0huY07SLqPAIyuI+Wfs4bSdOI3lwy0ODdFQhTU8MeLPb7
        66PQJd4CVci/xaYSryfUaENVbRm4Oli3d6B2hp6+d8XRim75OLV/0TWs8vzg3cDV
        mCgFdOEFIeae5ceTCVduNA4Wd4kh95ToMKxz2PWit7o8BBCPVRXj9SS4073APCFE
        n1Dp00VP3dynE9BoRSwvclG3tQ7Fchv1Md9TucGaC7QwMku9kfYTd9n/1r6642JQ
        BfqS5EUjPnarZaMm7ClPqGAxRAkl+Kkn79p4c7SfJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YqDG6F
        ELYXKOGx05z2N/f04eEjXwREvo5E6aqK66880=; b=fllLqPk7Y/NEmuGNhK6J9A
        Sqcz3flkEw1h0/403vZ3VE4zRIU2uY1e3VNwIM1m1TTZXA2vYj8Vn4jYxOS2eHpj
        eUIMQvElR1D+Qx+bW+XZLwuQShgKhiN8WwHpf3vap0n0/pDPCkIXYexT1pndODoY
        U02q1nFoMpvvUlZrMJgnsDKXQ4KoLwu+jzzVYgWjHY83bgRw0Pf0pU6AL43eIUrl
        Ky1Guy5njJi9eKvCBoyS+iY3hWp8Sws63LSdldS/ZMzg8izXfAOJJaRCsWdzXeGN
        eLX+oi+13ckJlkdDngnx4N1weHZ0DiqWmTxKH6v1s4iacYnIAUX4LM0wfLN18UYw
        ==
X-ME-Sender: <xms:dQ8xYZplhU5NzFW68vwwfbm6s4Wf0rc1hdhwwa2wvNKyeaSRuNezbw>
    <xme:dQ8xYbq6Asajt_nFqbfezG-UJhcUi1qi7ICleG0dN7Qbu4Q6aJWTkaqdN68a-H6_E
    VR_iSMYC342WZcReJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvhedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:dQ8xYWP1xCmWVwRKARG9YgfO0sbtT6GSteHyhBQ279AeoeZhZsWjWw>
    <xmx:dQ8xYU7ZehOYkVdKKo8puXNS3EV7faEKwyjMf2-5KnnD6L9yVztv_Q>
    <xmx:dQ8xYY5ett60duLk3x73Jty1z7vSKza9FUJrRvI7K9EmrcQIGr50_Q>
    <xmx:dg8xYYFvjZOtmAOfMAlE9LosLCvnQvGiu-PTExwVTMa3paov2tSW-w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1CE8F51C0060; Thu,  2 Sep 2021 13:52:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <3baeca4e-70b5-4fa3-9f79-92d716d2af47@www.fastmail.com>
In-Reply-To: <cd7a9bc2-4993-4a14-c17c-d838351f9396@marcan.st>
References: <20210823151738.6273-1-alyssa@rosenzweig.io>
 <3112bc2c-7c6a-3190-26cd-a873b4029429@marcan.st> <YS/p7Omw+IeyHeaR@sunset>
 <cd7a9bc2-4993-4a14-c17c-d838351f9396@marcan.st>
Date:   Thu, 02 Sep 2021 19:52:31 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH] maintainers: Add Alyssa Rosenzweig as M1 reviewer
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Sep 2, 2021, at 04:38, Hector Martin wrote:
> On 02/09/2021 06.00, Alyssa Rosenzweig wrote:
> >>> Add myself as a reviewer for Asahi Linux (Apple M1) patches.
> >>>
> >>> I would like to be CC'ed on Asahi Linux patches for review and testing.
> >>> I am also collecting Asahi Linux patches downstream, rebasing on
> >>> linux-next periodically, and would like to be notified of what to
> >>> cherry-pick from lists.
> >>>
> >>> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> >>> Cc: Hector Martin <marcan@marcan.st>
> >>> Cc: Sven Peter <sven@svenpeter.dev>
> >>
> >> Acked-by: Hector Martin <marcan@marcan.st>
> > 
> > Do you have commit rights to the kernel? If so, could you push it?
> > Otherwise, could someone else?
> 
> You need an ack from Sven too, since he's the maintainer of DART.
> 

Ugh, sorry, completely forgot about this.

Acked-by: Sven Peter <sven@svenpeter.dev>

