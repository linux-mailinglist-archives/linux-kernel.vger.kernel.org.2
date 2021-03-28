Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5FC34BBF8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 12:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhC1KOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 06:14:30 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44823 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhC1KOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 06:14:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B9087580633;
        Sun, 28 Mar 2021 06:14:08 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 28 Mar 2021 06:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=+AXJmGwULocjJynqc9rpylLzweNF
        zSxl8iMjJTiQzGo=; b=QF0dDnpgWEKT7HUW36rrxpKz/qLNTnKrqcK0PpLif2bX
        b0GbaS8lyKxdH8mcsG+KAEZbDcJv0eeuFPdY2j+cuMQaf0XgH6snrffk+pb81FEs
        xUj7mGm2oyQsq0cx969KulMepwPL11KIEBZFCdXmSHZf1uAsPiXbNlI4Y32c1J9W
        bn+mi8jnqP34daddG7Hkj26Q2UYLc5lyRvvX6DHUsAkWSuXZONm9/LhkWrubCPQm
        l0FHuqsylUPDXr7491dTNonnaLMaxfNPGgy157lNdNKBoD+sZbmy04yUEqsyQ4U4
        k1vY1GFLoMoFBGiV5CZI+BCNpqamYKImhPF9lK9ylQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+AXJmG
        wULocjJynqc9rpylLzweNFzSxl8iMjJTiQzGo=; b=Zgn3D060qZb4jHzgkExj7X
        Z8XcD9zn5ofpyVMx13FhQy+Wn2ezCDQ0avBsQ/YmeJACMg+pGuWPWYBXVmgTQqQv
        eCeOU5AVrMNz8gNJjbiOMqvpk3U+q0CcyA8fUayT9cFu+A/U3DGJwH/9PhaiDP1a
        GF4L+Ri8RTwggiPeVzLGAOjkdk1RT9ZHAnllvz6yrTpWbXmf/zIknJXWsgU0PuaN
        kUu8k6LiD+TizSV8nd7pALlUa40cIgy0KOCSfzgjygMbdIrCr/f9JR1IvJC2U+kU
        3svs5G35jz27h7GxxYwj7BoevcKwOYdWk9f9oEC2w1rz3R66aORjdfve52LME7Mg
        ==
X-ME-Sender: <xms:71ZgYEz8O0xMB9H5jh2WCJiTf3x8fRaVXj5OZ3ilNRcRT7eqazFZWw>
    <xme:71ZgYITQPCD48qo8td6VJyzFkILoLDQSTCY307E5qcAlPI1OC_JcG_tu9TtXLSdUO
    T3oKgOXrEbST6rcuc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:71ZgYGW4SwatHP8q_X3G2WqcuAZVhHlzOX9r0p42VLcYSWWEaPidfg>
    <xmx:71ZgYCit540_EJulUA5F2qecnUa8hm3rUmqdPK1fkNwpJxTLtwWYcg>
    <xmx:71ZgYGBuWh5G3cdCYhRc2uJSguV_uJBv6GhH_wvJfgxoQLt3yMpRWw>
    <xmx:8FZgYC2EHdZpBjk_8RYaGJhA5UQTeMYo-Uh3KScV4apOy0pbSMKsIs_cOdY>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3EFB151C005E; Sun, 28 Mar 2021 06:14:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <2ea0e787-6d00-4412-841d-529e1409eb05@www.fastmail.com>
In-Reply-To: <202103281748.sDyj85s6-lkp@intel.com>
References: <20210328074009.95932-2-sven@svenpeter.dev>
 <202103281748.sDyj85s6-lkp@intel.com>
Date:   Sun, 28 Mar 2021 12:13:46 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "kernel test robot" <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>, devicetree@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>
Subject: Re: [PATCH v2 1/3] iommu: io-pgtable: add DART pagetable format
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 28, 2021, at 11:42, kernel test robot wrote:
> 
> All errors (new ones prefixed by >>):
> 
> >> nios2-linux-ld: drivers/iommu/io-pgtable.o:(.rodata+0x1c): undefined reference to `io_pgtable_apple_dart_init_fns'
> 
>

That one was me not being careful enough when removing the Kconfig flag
compared to v1.

Fixed by moving

	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,

into the #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE region in drivers/iommu/io-pgtable.c
a few lines above.


Thanks,

Sven
