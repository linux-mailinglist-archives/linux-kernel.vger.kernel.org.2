Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49BE344E43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhCVSRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:17:37 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54263 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229746AbhCVSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:17:10 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B21EC580832;
        Mon, 22 Mar 2021 14:17:09 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Mon, 22 Mar 2021 14:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=ai83ObAamB4LrMOc3G4nVgW5/sy+
        gIqBJIYzf+pgCMY=; b=DuFuR/KwjaKcHaXXBMn2JqyE1eTkT0Sa5EnZ7VumbIz9
        v0dWSGDrGOjsDGDU3kqYGB96ystm8c3PUOsr5A/aUSYEO5zaYd0pebE9GIo8WkDd
        IkOxpgnpq8/Fg0E+/D4w0Kkg0fM7dWqyLAhh+m+Cexmiq2hvM32qcHMxIAAJ+L1G
        setMVvh5n2Kjr33DuXwf4JEb+a/WpjR/nplHw9A8SkVkbCdfnKmTSbj7SdHQbEsc
        ZF1ggZw8YELFIqL7b0pGudPOsZSIcsbdNRAfUSYSBxxRHjnz9PH7V3FUYaDqRQei
        g8YVafRhbn9IkWKuhwZWjsgf1RmSycTMZo7kIvSWNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ai83Ob
        AamB4LrMOc3G4nVgW5/sy+gIqBJIYzf+pgCMY=; b=eZrFgoCxaH62cG8QlWk8eg
        pKZ40WJFfQSMIOV9zoFyuBS7LM27UXZE26C4y/bsgxya2LZeilAxB5UFDRuKWTYC
        sVZMd91BRzjpUHK1mFsqTNdz8tlYGQEwaCPry6sbCKD4VdoqEjQRhWfOsRCN0nzY
        Wyuh90UZIIV9UJ7g2x3xvfWLFCNqLWITbFZ26uNiEmNUZImRSZs/N8239+gfJlgq
        +VxRA0J0+VDu/hpd8b4O4jYL0jLa5/VGh39f5m1wP/OfXoyQ1bhFO+eIltwXIe0c
        O9COzT2p0qkKqX6jSkegg9kxzt8awNDSRFxiWIiLzGlEI5ZO+ec5q/n8s8Sj8HXg
        ==
X-ME-Sender: <xms:I99YYI9tjTasK_ZhXTuE4FaqxkRXRpnr6GVrP23ei15cHQLcaD0HRg>
    <xme:I99YYAs8cJS7jG3WP7ET5nBCQASRjlVsZVl2oONNFowMZXL4ybHOv4lO8qzVxwcMK
    5Auino15NbeGA4mQlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:I99YYODKP-UhuA3X3vZ4UMwQD-ACxt4NsPP9FePDaH0ezkSa3yWp8A>
    <xmx:I99YYIcN0ndJcxpPmCq1q-Cll4e7a37dAoo8rlVlGwquxYrAz0AlfQ>
    <xmx:I99YYNPQToM0YWuNtD7nFQfx-0GqXRe7-QSNZ5j6k0dEJBYgllmM4Q>
    <xmx:Jd9YYBnmKRQeOt2B0vl8-yha0HHOuF-cMHUXIKYiDXDNRWl8xmIrJtoPEEE>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CFA9E51C005E; Mon, 22 Mar 2021 14:17:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-271-g88286cf463-fm-20210318.001-g88286cf4
Mime-Version: 1.0
Message-Id: <957e0f84-efcf-43f1-90b7-ef85a854d463@www.fastmail.com>
In-Reply-To: <1616372137.246877.1475028.nullmailer@robh.at.kernel.org>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <20210320151903.60759-3-sven@svenpeter.dev>
 <1616372137.246877.1475028.nullmailer@robh.at.kernel.org>
Date:   Mon, 22 Mar 2021 19:16:25 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Stan Skowronek" <stan@corellium.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        linux-arm-kernel@lists.infradead.org,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, "Joerg Roedel" <joro@8bytes.org>,
        "Rob Herring" <robh+dt@kernel.org>, "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iommu: add DART iommu bindings
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Mar 22, 2021, at 01:15, Rob Herring wrote:
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

Sorry about that! It looks like I didn't have yamllint installed.
I have fixed the issues and will re-submit.


Thanks,

Sven

