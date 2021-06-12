Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3D3A4EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFLM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 08:27:30 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48857 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230191AbhFLM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 08:27:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CAA4758069B;
        Sat, 12 Jun 2021 08:25:26 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sat, 12 Jun 2021 08:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=3PQQZVdLA4n4rlbpJkJAKwEqsxv+
        D18QX971oe6+lnc=; b=t+pToX6ylR7fe3vR3pb6OB46fkMMUWm198p/1XFQzlYa
        mU+LDEFNrDGHzC8HgfOJovx/IZMzSsW2LznbFn720KiIRwOjYDF7KXgb2R+MzM+K
        JW1mhC54J3eW5uNby5olGvI2/A2fheOx1iJlpgbdg5fQAUhk+ENbTs4CbEIQHLvN
        OLY02bhKIcOe202N++fBVeZpsjEhkb4mkW58w8yOOgHF1HPcUDZzladLEKexg4mt
        rmCkEVeJfJuz9J6DcIyfnUAkEXDDYJHEE5LrQ17fRED1ael9BQgr0WINMlQSb6Lc
        Ixc1ZSAjuSu2Rk9qhRJG2rPfcTqbMS0oJHmbM18Vcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3PQQZV
        dLA4n4rlbpJkJAKwEqsxv+D18QX971oe6+lnc=; b=Ny6N8vAlMSgGbeQFUTyrkq
        MPdVvNnienI+/h/kmb77s16Qrp++a1FnaC0wYyj6/Qafk6DZoa4mi3t0M4WbGfWF
        1beaUtLPeEnXFWDIAuua5ZfLD059AZjIOR6FaEqUzTVzWh5P7X5d5DmqZt0ptlYz
        b2DQw+Jf3znqhM3qDbbI7HN8oRSSNhDbC0pZqM5DUF4v7hwotIE05ZYMXHxuiOuM
        +y7ygfyzaTFQDG5Ky4lPdvEVFiE/UD9PbzTbfv1k8Q+Uj53EE5VOf+PXFJvtAgbX
        b47qqrdl21EeTUsG5PqmbIngbpp2FgpQWNpoH/kpCsEb9yXCMv5sm9p+EHtmHXDw
        ==
X-ME-Sender: <xms:tafEYEi3MG55JXV0hCxywKW0vRZ2HafBDz0WAwPlEtKXbv7LCn6sZg>
    <xme:tafEYNDVvl0I-YbiffTXe2foqONeaB_y759N8dWQDHGbqZbAfHk1CUBremEn76tvd
    6MhHxmiC97RzkYqfEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvtddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:tafEYMFBetGL7__tAMLZoxJvuG0ePGGvD8Hmc2A4PHbejjjg0SHZ0Q>
    <xmx:tafEYFTR8EihGqAyXC_pmGZb-7p29sSHv6LI4TXHQOg7SJ28LA-Mlw>
    <xmx:tafEYBxdTnji6KhAu7SZpG9LrOBKeDdSnmHvRICispTjtChOREGZiA>
    <xmx:tqfEYEooqma0hYH0rmDgi-41Y2cOrX_RumCZgg7OVucifelUf89UoQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BE28B51C0060; Sat, 12 Jun 2021 08:25:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <9b226219-bf87-4fd4-8d99-9436861ca3cf@www.fastmail.com>
In-Reply-To: <20210610165244.GA1948260@robh.at.kernel.org>
References: <20210603085003.50465-1-sven@svenpeter.dev>
 <20210603085003.50465-3-sven@svenpeter.dev>
 <20210610165244.GA1948260@robh.at.kernel.org>
Date:   Sat, 12 Jun 2021 14:24:55 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Arnd Bergmann" <arnd@kernel.org>, devicetree@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Petr Mladek via iommu" <iommu@lists.linux-foundation.org>,
        "Alexander Graf" <graf@amazon.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iommu: add DART iommu bindings
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 10, 2021, at 18:52, Rob Herring wrote:
> On Thu, Jun 03, 2021 at 10:50:02AM +0200, Sven Peter wrote:
> > +
> > +examples:
> > +  - |+
> > +    dart1: iommu@82f80000 {
> > +      compatible = "apple,t8103-dart";
> > +      reg = <0x82f80000 0x4000>;
> > +      interrupts = <1 781 4>;
> > +      #iommu-cells = <1>;
> > +    };
> > +
> > +    master1 {
> > +      iommus = <&{/dart1} 0>;
> 
> /dart1 is a path, but 'dart1' is a label. You need '&dart1' (or 
> '&{/iommu@82f80000}' but that doesn't really work here because the 
> examples get prefixed with /example-n/...)
> 
> With that fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Makes sense, thanks for the review!
Fixed for the next version.


Sven
