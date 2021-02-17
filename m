Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798AA31D661
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 09:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhBQIMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 03:12:34 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51967 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231831AbhBQIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 03:05:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 376C95802F4;
        Wed, 17 Feb 2021 03:04:56 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Wed, 17 Feb 2021 03:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=nE/twV9lmTlIyX6U7fiaqg/3ZI4aMx+
        bPYLO39QK5O0=; b=leKVx17HtaHJn3FrmsRfWtV8fzB2OYxry6LHwsLi2TOoXR6
        GWY4gxCvoCb6laeSYlrndXi+xLE/IkPb0pvqGLXB1+i5nW20zpm+N/7+kDDMPIkd
        EPTeAw3132A0wOz0nBXXgjtTdrpil26/Cal4Xo/1pEyihPWrJwZUTjTCzSh8/lAI
        A3EsqQZe4zm2JmKBNUyLF9KqgAIgD414plXpciBPjKc043OAhIxmfLX9DiajDgAT
        ZDEWwykIeIdo+eNq+XDnzw0uGupXJMAWJ8wnAHL7PtxKU2L5IvfrtlhKWqtWBUDI
        a531LmQgmy7KYI1/kWRvKsv33G2m9AdOCuuVa+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nE/twV
        9lmTlIyX6U7fiaqg/3ZI4aMx+bPYLO39QK5O0=; b=RsFtyn4/5ZrsYMmsUH8fiK
        ss76if/+SFU/X+mGqQSL0zlT/WAu2mdzS26/z5dUntdtmIk70LgFK9s0L0qY1Fcg
        Uj5TI05PU6+RvmtKowYtxFfWvRwf8Kp4el5AAkC5QXlByDoy22hsh7AjsAKold1G
        ahfB0x3+oxs/JFutjIpjALprWb53ZaTsfHScUux+OIw8WEKT3j3VsYMUE0httU8K
        JQ72ug4dz943Oq+oVq6n3AMz8T/cxcMOitzPXVZwpWv7axyVfFYCJsWlEu0TaioS
        Tp3Z2FyAdqK7E2mHXS7K7mqjU3YHleHIVY6Vsfq01G39DMuyBmzqzuz6EDdvha5w
        ==
X-ME-Sender: <xms:Js4sYK4Rhd2CEdnUu0JfJhnOCl7qBxXZ1m7-YA5iGbdB06t_7QKrOw>
    <xme:Js4sYD736FfHDDvk_otqV6Yg5n0YvuQfvuzx9_0zz9VA7qK8gmRQaILkI26oT9r5Q
    J4CfwtA10ycvs3i2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjedugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:Js4sYJdR22Rn3jHyJqjtGULmYpgkTUHm1MFJ5bT9q4v3cWn8iPPQyA>
    <xmx:Js4sYHLTxmq6iU6FeOcRHtlEAp-0qjhwmBEjJDYQm2iZQMIHXWQEnw>
    <xmx:Js4sYOI3_B2V1lnlgMXmRTP5ZGtcilhyvXv_K8V9hhuUTs9IfmpSMw>
    <xmx:KM4sYEyBoR5ITQLvEbc2ZLN-LAwg-mHHOPQFi2IfN-RnRn5WorcBfg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 961C3A00060; Wed, 17 Feb 2021 03:04:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <26958980-d998-407d-926a-40c370cfc8c6@www.fastmail.com>
In-Reply-To: <CACPK8XdFLKg9k6snLSZrRzorxBeg1fLoqakm6J_8VCXh_=JEQA@mail.gmail.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
 <85f00459-4a39-441e-8119-8e12f8132cfe@www.fastmail.com>
 <HK0PR06MB3779B25984A461E4A1ADEF1191869@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <CACPK8XdFLKg9k6snLSZrRzorxBeg1fLoqakm6J_8VCXh_=JEQA@mail.gmail.com>
Date:   Wed, 17 Feb 2021 18:34:25 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc:     BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "Corey Minyard" <minyard@acm.org>,
        "Robert Lippert" <rlippert@google.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "Haiyue Wang" <haiyue.wang@linux.intel.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Feb 2021, at 18:14, Joel Stanley wrote:
> Hi Chaiwei,
> 
> On Wed, 17 Feb 2021 at 07:40, ChiaWei Wang <chiawei_wang@aspeedtech.com> wrote:
> >
> > Hi All,
> >
> > Do you have update on this patch series?
> > Aspeed has subsequent LPC module upstream plan.
> > We hope that the following patches can be on the basis of the fixed LPC layout.
> 
> Andrew has expressed his support for your changes. I will take time to
> closely review your proposal this week.
> 
> We will set the goal of having this rework merged for the next merge window.
> 

FWIW I have a patch series that builds on top of Chiawei's changes. Once
some weather has passed and some power is restored I should be able to test
then send it out.

Andrew
