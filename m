Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E973B3153
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFXObd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:31:33 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:35037 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhFXObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:31:32 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id C109F2B01232;
        Thu, 24 Jun 2021 10:29:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 24 Jun 2021 10:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=FXFoqCBFeCNMlb7IjGBpYzK+n/Q
        QU4EAIyRrm0cbZaw=; b=DYR2k9zJgHdZL8P0amaOkkyfbSTCeUoJLms3qUhZANY
        NT9MN112Yifl9W/JjPA0u72YGHTRFBdUGBD2tPnAQyg82XyTYloPKjb0xHc7R6AO
        D1zEO4aFMaVhxvXQ2gWJmCdaHgGQ1cJSlhk4xyTAf1NUwr25KhveoDFv/NEi1KuQ
        /4wQdNu/h0bJkBF6Ij6Mn0480oJcOVE+60NI7hzjA9E86iKi+oOXafZktZyAAqX8
        9lwGbi4WFtxueqQMjv6+k1aOmP6QtH2ktIGgIruCpI0fCWCcr3Hz9UI8itdVJKat
        t+jPTyTGY4PvoEgvbyOuBzgf0XVp8QODeXqK14xK+tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FXFoqC
        BFeCNMlb7IjGBpYzK+n/QQU4EAIyRrm0cbZaw=; b=cDsGnemmJiQFSY64OQyk4C
        oEAk31StoSzXFgDvXS1dSj6hlEr+vC/Q+3S7dhr3yM8pf2VJlwyoabkCIEe8FrD+
        xd1Ys6xH1vqfJVNZce9g7JlkpeyC9ix2f7nd0QnuJehH2JPa5dCWaliNsnRzOGIW
        xOKU/hwiVXVt8r0D9MAoa3+/nadJXeA9J6aaJ/ntSuHZ30XXRGkUgjEfrU2MLe2n
        ZNK07TxvSB37jk2LJseA+ngt/8hpC/CnqME9XgFbPxGnLPh0rfuAIUOmgEAk45pO
        aFA8ENqJGnIjXYn1UfZg9HztrArSXiJe8kN2GtVfaAEPeC4Y+UiiT5EPYqwrJDdw
        ==
X-ME-Sender: <xms:tpbUYKBr-eXJslIWLq7QlnW8A4HFKVtvinYvrsGWd_1YiaNhdnzqng>
    <xme:tpbUYEivWkHAJTCOYNli5rGUN5kps6uapBR4-BZJmA6D4iC_WX0r3hBtz3nVi3QHD
    CEQsOF3kenVYg>
X-ME-Received: <xmr:tpbUYNmp10oAalD99cq7VncKP-PdLsTaDiYj5uo1lKR-bLjP8-rRbQH4UudYd6xKQy_wyACUiBlNFphKP2tAz6JaKjtRYXW2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeghedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:tpbUYIyzW6c3LVjlPsYfpjIGBU8rXtac3qxmkZ4seOMZqfaX0_TGQQ>
    <xmx:tpbUYPT-rs5EJOSk43OgX7_JWU61JguafBuhLStqHfcC6oL0YnQ7aQ>
    <xmx:tpbUYDZiaFu4A2AlVAjK2HOHUXQGCl4DIJ6_7TjPZdCy-wyw8ACcNw>
    <xmx:t5bUYAB4Bbej1TL8qg0_YUGPbd53Cmrk7MIRLzETEn7pK4msft-qT05EG0o>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jun 2021 10:29:10 -0400 (EDT)
Date:   Thu, 24 Jun 2021 16:29:08 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNSWtCSjJy8CytOL@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 07:24:31AM -0700, Andi Kleen wrote:
> 
> > But first off, why is this symlink suddenly needed?  What is so special
> > about this new hardware that it breaks the existing model?
> 
> The driver can be in two modes:
> 
> - Driver fully knows the hardware and puts in the correct Linux names
> 
> - Driver doesn't know the hardware but is in a fallback mode where it only
> looks at a discovery table. There we don't have the correct names, just an
> numeric identifier for the different hardware sub components.

Why does this matter?  Why would the driver not "know" the hardware?  If
it doesn't know it, why would it bind to it?

> In the later mode the numeric identifier is used in sysfs, in the former
> case the full Linux name. But we want to keep some degree of Linux user
> space compatibility between the two, that is why the full mode creates a
> symlink from the "numeric" name. This way the (ugly) identifiers needed for
> the fallback mode work everywhere.

So what _exactly_ does the symlink do here?  What is it from->to?

And where is it being documented?  What userspace tool needs to be fixed
up so that the symlink can be removed?

thanks,

greg k-h
