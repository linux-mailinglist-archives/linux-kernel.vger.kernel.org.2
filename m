Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2869639509E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 13:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhE3LOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 07:14:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40947 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3LN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 07:13:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B85A85C00B9;
        Sun, 30 May 2021 07:12:21 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 30 May 2021 07:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=3ez2TAe/OWNDwi5uEho5QRFODBLJ
        ka13q7B+iIWvjqU=; b=PHyjqNKPAIyTLQTdfcU9y2e0qyZgvMq0ibHsPDVWYsfK
        or1miGvE4behGivSyLtGN/afKNWjl/Obk0hX9TtTCWG0aKVPlh5IgmisdgAX+v+s
        vSuJlhcucLeNFKbMbl/JXMHGFfxJQ8hjkwiYro1qArpggV/VcwnE1Oe1m5UbLjcP
        PX4LRV3IZQu+JTfP7bUElle33k6/+IIFdhcUrg0ze7PDDK4SIDWbPU9m3y+reMWh
        37Pp5cgnLo0UXrBJ6czVvWzGV6r2LkMTDH2ZXMwc1bAfeRLl6/aYmgM0mp4Jnnh6
        ww7YNF16i6Uiw+lpp3khW+LaEmZwYBO6hvLyjRNy+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3ez2TA
        e/OWNDwi5uEho5QRFODBLJka13q7B+iIWvjqU=; b=Cf6GzsIcsyfoIC/GEPSjRS
        awPTVSQqEf2GsDMaqV4I+CTO5fdo0o8MVFRW5llv3Y65/F+qqRdflhyt+tkWeXeD
        zDS9EEAcUrIBPqyw7DgRnKMStQl4DYANzOkn3INd+GCtdepsqA8RJI8ysPfwxx9p
        6CokvzzTzcmTGxQWTVCDh2ZcPvAT0iRtrBhOBzmMBsUzxMt8XXLpDnrNGJNa/Fjr
        8MNJNS9kMAzJHrOzXGL+Vz5QxIKB6jaIvqR61Qp8CmCPm6yiYMcavyYIRT0LoUt8
        FkGV8PnpWZIXhHvotCcbfbuPilJlzgQAH5Y7anPXZji2Q+AtDUi96yh2ezW+Wmtw
        ==
X-ME-Sender: <xms:FHOzYMjUrX_w289KjQrO0vBWHDRxg7WunTknwNDlm3XqgOul_i5EnQ>
    <xme:FHOzYFBlhWoxvcjBD-2eI_-42uCNozYBKwPqIDvpHm4YxYtxQjDgwIPy86hDZ65PW
    XZ9QjkOtfRlUQeuKS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeluddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:FHOzYEFb8vDEgPqKact8xgvpELhhr6pInkEeqSzr7r40FsfQHVz_-w>
    <xmx:FHOzYNSs_BfePTdtyV9VBvMNdUDssHQ0do1NcZrI1WarCy-SPgCqfw>
    <xmx:FHOzYJzSj6Hy5AbrUA8Lco5RLfCVsPTVuqY2KvjtXpfHf0UR-4257g>
    <xmx:FXOzYIzjUvECCTcAANWmvc8YEMx8nT1LOFww9Iwpka5B6PkP379SqQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 94D0451C0060; Sun, 30 May 2021 07:12:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-468-gdb53729b73-fm-20210517.001-gdb53729b
Mime-Version: 1.0
Message-Id: <4d31cb49-f218-473b-a82a-883ecd3c2b06@www.fastmail.com>
In-Reply-To: <162199863202.4130789.9536491283421539572@swboyd.mtv.corp.google.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <20210524182745.22923-4-sven@svenpeter.dev>
 <162199863202.4130789.9536491283421539572@swboyd.mtv.corp.google.com>
Date:   Sun, 30 May 2021 13:11:51 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Stephen Boyd" <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH 3/3] arm64: apple: add uart gate clocks
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, May 26, 2021, at 05:10, Stephen Boyd wrote:
> Quoting Sven Peter (2021-05-24 11:27:45)
> > Now that we have a driver for gate clocks add the proper topology for the
> > UART. These are already enabled by the bootloader but are part of the
> > clock topology used by devices yet to be implemented.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >  arch/arm64/boot/dts/apple/t8103.dtsi | 36 +++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> Mostly an FYI; I will not pick up these dts patches in the clk tree. If
> you can send these in a different series it makes my life easier because
> then I can apply the whole thread without having to manually kick out
> the dts bits from the mbox.
> 

Sure, I'll split the last patch from this series and send it as a one-off patch
once the rest has been reviewed and is acceptable :)

Thanks,

Sven


