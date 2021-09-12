Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D814081C2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhILVJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 17:09:02 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55975 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235034AbhILVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 17:09:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E5EF5C0046;
        Sun, 12 Sep 2021 17:07:46 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute1.internal (MEProxy); Sun, 12 Sep 2021 17:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type:content-transfer-encoding; s=fm1; bh=mk
        RpGHmdJF3f4VUu9ZIMiGiTNXdGreWTcrs7p2zXik0=; b=fxVlL1ozOzGjAqYIva
        rHCoQEROPYliyrGGm2wYbNgm5899u+ceGh6JO/I8JAVxWt39/S9FtDi2Ig5oNLOd
        Lnrvg2zw30rde6yZ3lGLui+CLveWzp9gAJDNG8SL0TWnxYij+CbflsswIbbgLhhJ
        WQi/HheOiq6D0I9yrMRHbkvzR5a8bSmATeVVc7Vj1Sfu0SDsI104XdvW2YrOqIiE
        ZqhKoroSbPk85E3qwUlp1KtNnpKxfYac7Cv16KEvU0NOETZkA662XTmM3zqrvAeX
        ixdAIy/0IelQQk/1Jv8MAP4CNRjebks2TaORa4AG/Km4STG2U0GZNIZMUUb/d8Bb
        0m3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=mkRpGHmdJF3f4VUu9ZIMiGiTNXdGreWTcrs7p2zXi
        k0=; b=RywLMun3lGx6nY6vRq69e7fwogZd6KMauG0ZiVds+qCl2ZdLHKawXRdPg
        d3RRj1VQk0dE9+IWfzKm7In9TdTLtV4zWVuVwpchOqiCmgK1eiToTnruYwu7wJ5Z
        z36djf+MdGvJ2Ns8NWgJ6pXHTBcD6ZeGHuYGS+gH/vUgRX7Jif5OF9R+517R8S1z
        RKitbR7hPZV96tPlg4QxOCG1NmIukQDe+Ne3OFi5N1nDUsymXLxdnlHFReSANsar
        Ef3ORcrLCH4kqyzFKbXn5VL9sAgLxeU5rP1/V9oVKUbjyUUcGVeyg1l1vsf0kw/B
        sYIEY0sAvfLW2eDeK3D5EnJauIQhg==
X-ME-Sender: <xms:IWw-YQDC-kGkFfcw_09Ujh-xGF_gEs_EWIaBlQrRyHX5_uflwC5_vg>
    <xme:IWw-YSi2BoKZg52oVjfhzefa3mV82nFE79J3EpMIYdB4qtGvAUNUAC2YT861rsshm
    0ukrsaMdUtUYq_wQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeghedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ohhhnhcuvfhhohhmshhonhdfuceolhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrsh
    htmhgrihhlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepjedttdejvdfgjeehheek
    veekleelfffgledugefhjeegvdekudduhedtvdfhkeelnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrg
    hu
X-ME-Proxy: <xmx:IWw-YTnXw_jjJirDLoVsqY2PPghn-QkUQaxJauHa8cjSX1mzwQN_Gw>
    <xmx:IWw-YWxFL_pJwgO_42qU07_67D87k9qwKY83SOpXvp32InxljrB7-g>
    <xmx:IWw-YVRbU-Jlb86qTc8hWh17Qhq2JH_HlLLS7tqW43v2ovLa32-Fnw>
    <xmx:Imw-YTPx1CB1tRu61Iuy4HVOSygYwnOs99Iv7eR7wVJ8qadT1w_wbQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 50C2E1EE0064; Sun, 12 Sep 2021 17:07:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <7d1a7607-15fc-4dd6-9317-c6161c4984db@www.fastmail.com>
In-Reply-To: <vrcxh2wnnrl7a7.fsf@plvision.eu>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-4-vadym.kochan@plvision.eu>
 <b54325f156eaaa6535667a1a7fb695c7688d2db4.camel@pengutronix.de>
 <vrcxh2wnnrl7a7.fsf@plvision.eu>
Date:   Sun, 12 Sep 2021 21:06:39 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     "Vadym Kochan" <vadym.kochan@plvision.eu>,
        =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
Cc:     "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Robert Marko" <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 3/3] nvmem: add ONIE nvmem cells parser
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadym,

On Wed, 8 Sep 2021, at 09:56, Vadym Kochan wrote:
>=20
> Hi Jan,
>=20
> Jan L=C3=BCbbe <jlu@pengutronix.de> writes:
=E2=80=A6
>=20
> > I think it would be useful to have a way to express this setup for s=
ystems with
> > many interfaces, but am unsure of where this should be described. Ma=
ybe a "mac-
> > address-offset" property in the generic ethernet controller binding?
> >
> > Regards,
> > Jan
>=20
> May be something like eth_address_provider should be introduced in
> net/ethernet/ ?
>=20
> This provider can provide something like eth_provider_address_next() w=
hich
> will consider "mac-address-num" (or other specific fields).
>=20

A patch series proposed the devicetree property
mac-address-increment, but it did not get support at the time:
of_net: add mac-address-increment support
https://lore.kernel.org/all/20200920095724.8251-4-ansuelsmth@gmail.com/
dt-bindings: net: Document use of mac-address-increment
https://lore.kernel.org/all/20200920095724.8251-5-ansuelsmth@gmail.com/

Cheers,
--=20
  John Thomson
