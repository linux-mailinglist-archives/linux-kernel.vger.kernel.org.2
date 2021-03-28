Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934C134BBCE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhC1JXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 05:23:44 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58383 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhC1JXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 05:23:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id DF7A4580424;
        Sun, 28 Mar 2021 05:23:10 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 28 Mar 2021 05:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=gbhn5OemD9Ow5QkhhT+PDUUX6xR+
        vJAarCksiI5FZS0=; b=sUwmqaYL/f34wjHBN6wy+4qaJh+WRKLGS+7m8ml5kW0Q
        XfnHMvBlKbbaX+Zmo6GTfjIY5uKjNMNkkUyGJF0m/ezrRFFvdqbFGPAYuajNt5Iz
        zkEb4Ije35L5fe3xA0LdoIA2pHi7UrrnKfYkqxbyE2D9k9uA6XluVpbSh+rcZG6Z
        77inPTBhM7kbPt3eh6pLUWT8swq4E1xn1QkYFpasU/yeJGX5GpXQnvKxmuhm2Nmy
        iGrsR59DkxUb/GU/lN7J0IWN+DMoRVR1+VQkAKO93DLFHcqbWtuccW2O/Aq7Nnut
        w3IbUgr8JOvhDxbq51TeA//SSPfh71nd0KsgxKQC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gbhn5O
        emD9Ow5QkhhT+PDUUX6xR+vJAarCksiI5FZS0=; b=Pq/t+IBbYYVbgx1nnnWjiJ
        pKURemFg4wonUQq6ZMZ8+YUZd4HWQhIb/WI/QmE03jQg3tpbRoos/+A8cKixEjNF
        1qnwZlQwJlaJb9ZAmlvs8HgFDXLBSry30O+GU8Rd3Jaw4YNea8EGqp5ckmZvI30V
        5ATYhtXiimtdzkL1QsrGMEEpDl8VyzDtLogFIi5mx3S7u9+uFCvdgOXeKGtJK6Pc
        wZ0SAU7uXlDiVxadSkGAl+0sNOBLsvlk/psEiKz/DU5eZ5s+4Mbb9gFWa8GNYe8a
        xT5FB+Ct/K4WpVvznhmV+ZCjPfByz15XeE4B9lsuujsSKvHBI4wHuNHumbRyQOnw
        ==
X-ME-Sender: <xms:_EpgYII3V3e3Q6ewvEk4pk36bGBZwLtWnt1OekHEe5vhtNWex6r8jw>
    <xme:_EpgYIKKz1u-ZvrOD4PbPcDFEhQn4hobZ3Sr2uGQJbQ3LEUUGfdN0dAWUkHvgd3p8
    ZAm02AvluoAu7PFi4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:_EpgYIsdB_Hwc_1z8Kc8FENyihSJfI09dMr8hXbwko87utZsyJ4wGw>
    <xmx:_EpgYFbimQ_YfF6h2SvvKkFxIpY-rSVwAkLUyC29vz1DtnJiQeVJPw>
    <xmx:_EpgYPZmal02IKKyLmyqNr-CGN8asUAoSgMiQksx3p4qtsGsGNPXWQ>
    <xmx:_kpgYNBtn-rzzfoku3w1B3x5wS_7Vp2ztQSlLZJvmjJntarn5gjfNRhCKaM>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5CB0B51C005F; Sun, 28 Mar 2021 05:23:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <e05aa388-e1dd-4b94-b427-69cf0d14b7f6@www.fastmail.com>
In-Reply-To: <CAK8P3a3a1k9SyrRLammX8dGF3GjojUVUEZ4cMfb2+g6CXkBNCA@mail.gmail.com>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-3-sven@svenpeter.dev>
 <CAK8P3a3a1k9SyrRLammX8dGF3GjojUVUEZ4cMfb2+g6CXkBNCA@mail.gmail.com>
Date:   Sun, 28 Mar 2021 11:22:47 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iommu: add DART iommu bindings
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Mar 28, 2021, at 10:16, Arnd Bergmann wrote:
> On Sun, Mar 28, 2021 at 9:40 AM Sven Peter <sven@svenpeter.dev> wrote:
> 
> I noticed only one detail here:
> 
> > +  - |+
> > +    dart2a: dart2a@82f00000 {
> > +      compatible = "apple,t8103-dart";
> > +      reg = <0x82f00000 0x4000>;
> > +      interrupts = <1 781 4>;
> > +      #iommu-cells = <1>;
> > +    };
> 
> The name of the iommu should be iommu@82f00000, not dart2a@82f00000.
> 
>        Arnd
>

Thanks, fixed for v3. I've also just noticed that I forgot to update
the filename in MAINTAINERS after I renamed it from apple,t8103-dart.yaml
which I've fixed as well.


Sven

