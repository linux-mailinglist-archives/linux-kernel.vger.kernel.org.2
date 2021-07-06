Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02C3BDD64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhGFSoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 14:44:39 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36525 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhGFSoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 14:44:38 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id D21E42B006E7;
        Tue,  6 Jul 2021 14:41:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Jul 2021 14:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=R968ytTOlwNw+2WYjcHp6doapxo
        hJ0BvC2hmSpYueUU=; b=EUWVdeZHzeCas1GdVUpvefEtK+dgpSZHLPM+ZjqZwbD
        XZjtNQ0pdNaWq8Iymll4qYN/q3H3VLwS1yWdN2m3DbeZV8u8xIR1a5+Y2/FjvF07
        O9K1a95IAm75CE2QctM5ru4WcagKQH2Qdh4rQqv27l9Z1r4YJyjq8ZE+KIJk4D9p
        d1mP1uSwYGd6wYdUPQKSa44YvbgTCZ9GopKXOwGVOciBEGliTW3XkpPgJxtX11NN
        BY7ndhAFlol5WglJ3KrCFyqLrNrV0kro1q9okC2fY1iLnqBvDmUjWiQZ/o8Pkoaz
        tXnKK1Yw/754LxL1LkWbKaCChq3EOulRWVuSqiiLPUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=R968yt
        TOlwNw+2WYjcHp6doapxohJ0BvC2hmSpYueUU=; b=iKP2Uunlg15jYviPB8n3Iq
        /nn83ZoIWP4dO1dWBgLOjQOyH8iJT883cvD0J+qMvO8lvPnsMmABmFdLdhh3wxfr
        yEEJAXah/cr9RFTVBwWeKj9eKNS9H5NJzOSnvmd3k9MCwn3gn+m2r3jYePh1SPdM
        Y1XU9HTOpbtrBnAxHSVluz5dA5jIdamqxO656Zw5bGBfUBywFFckBvYJCj52E49u
        8N/hn1H/s5xDwADEH4S+Q0G9/Pv7o8P23wQ6W/jDeSHw9BqZVTqiyZGhDZ6hCll9
        G5k6MOwbUK0XyaexZ2o0XThZpKqJs+ZoiXrVZAR1TvRHK6/BmiJyvM61hEYM2RmQ
        ==
X-ME-Sender: <xms:9aPkYByvaqyciX7IwxEWGTSRxGd7WVhfin-5QEeaxxamRBfS5ps5tw>
    <xme:9aPkYBTThUAyb5RYoOTZBEXGM_zDfNLfHCjHYg0-fzZPrfZ7eXK5G07muinH2L98G
    IBfG7OVRcMlgQ>
X-ME-Received: <xmr:9aPkYLUvb5ohLvgcru6oW58qPl9HOdLlsfV_wkBHrOytYZ2-T0JxRP1aZKvgaPch40wrPiuET5EAea-iGqisCxZuuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddtgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhrohgrhhdq
    jfgrrhhtmhgrnhcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnh
    eplefggeejffdtgeeutdefveevhfdtfeeufeefjefhleduuefgieegveelueejteffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgse
    hkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:9aPkYDha89voidcSbI0bVumsrjhdHyzWvuhpJu3uiAtk2KBDoQusLg>
    <xmx:9aPkYDB-j0Fg0F2PdgfHDBL21dWB-z6J9vArRVZLdYdaie319UUVFQ>
    <xmx:9aPkYMJ2nkrG5wkIqQYbDXCwZobdh9Dg6Cce7lcaipu82lxxjuE_pg>
    <xmx:9qPkYLYpP6oJhzu0-jubpTnx1mGEBQ3_EtnduXiao0bf6argWNu_OTUmNyc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 14:41:57 -0400 (EDT)
Date:   Tue, 6 Jul 2021 20:41:54 +0200
From:   Kroah-Hartman <greg@kroah.com>
To:     Norbert Manthey <nmanthey@amazon.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Coverity Scan model file, license, public access
Message-ID: <YOSj8kjDtjmUtcVP@kroah.com>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
 <YOSKuEcPoy/dw0st@kroah.com>
 <6f1cb856-fc72-cfd1-9bdd-b4dbf58c558c@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1cb856-fc72-cfd1-9bdd-b4dbf58c558c@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 08:34:16PM +0200, Norbert Manthey wrote:
> With respect to sharing the results: we are allowed to upstream fixes
> that we find with the tool. We contributed in that way already, e.g. [2].

Yes, that is how many companies do this and have for a long time
(Canonical does this a lot).  But that puts all the work on you, and you
can not share the results of the tool with anyone, so you are forced to
do the work to fix problems the tool reports, which feels really wrong
when you are dealing with a scan of a public source tree...

thanks,

greg k-h
