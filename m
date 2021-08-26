Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9A3F8659
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbhHZLZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:25:47 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36669 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241887AbhHZLZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:25:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F0345C0118;
        Thu, 26 Aug 2021 07:24:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 26 Aug 2021 07:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=TgIPuEW2Jsd3FPA7yUga5vaBulj
        umW9gdzJg8zgI5LU=; b=WV6YYMlpRUkW7ZDheO9lnSCYjr3Qo8vachume3VsSQq
        2UVPjlEp+FBxR2lqSdNedm41by8YQJAowxmv8G5GJBHrlfnn2WPpcyVRYcN8RxcK
        Q+d3gkWtsIN8WEYiHRNM7JN+VC+irUpQireW9RzVSUrc2B9q4w6iZu+7iQuiNJ43
        LBOQA5VE0AvXIgsyA18V27ICSriRstoYfaQJLw9ZtAmUYf4YPjt873Skf3FaaZH7
        ExvyEtXGrk/F5IT3x/LDHa7+Wat6dt7DpdBKTonSmGLn6tt3nyoCvjZDzhB60Ozq
        bAE5Jz2Lkpj7zWBUPE+OFAKATQetR7mJWJ2YzgsE5Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TgIPuE
        W2Jsd3FPA7yUga5vaBuljumW9gdzJg8zgI5LU=; b=cOpYs9V91FQg4Csg5MaU2R
        q0kc/LfnVHO8mW9JKU+068dZmf0WINTPNniwnVLLN75robEAruWB2wKwMQVSE30I
        lpj4/DWrAqEhfwB8OqUIEaTFKvT06ycV3+iVFFz8usJr7ccCo8LtKlyMZcz70vzn
        gYSVYX/uMfLkj3ONIzwVwlmobQMFHi5SZMbHzfme8eeaQKtVe2wqcoMKu4KB7x+Z
        9agXR7NpicL7M/M/Uhf2slsjMVL6syzTR1fO9pgHIFDhVsRz2fc2TelcC5Uwmrxf
        eklB4DA+5fNwfIAb0Ls7kutgLfF3fjfGgQhnF38K6peewGQQLuFzNgrxp/dePIVw
        ==
X-ME-Sender: <xms:CnonYZ-MjtzRAw1ScG_orul7918q4JXOtNX8lGPqi2lyHY8gohc7gw>
    <xme:CnonYdvVkseyfaeHysKbuINbF5cOMQt-n8f4rG5-UqWeAZOxTv3taqcwY3NYGUzfM
    s81saxKkP29rQ>
X-ME-Received: <xmr:CnonYXAo7OwK17AfPmSTnV4Nvw2OsjRljNPD61unjTWoGBUK8XubVjgz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduuddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:CnonYddDBbldGAkxmo2vcaGkq2V2GTrGAP93ut6oiBx679WLgWqP9Q>
    <xmx:CnonYePQqLqiKmGXWs3XLY_O8cd-hcYfIW-zeGHkLA84RrB42gcfMw>
    <xmx:CnonYfl-txFaS-9lpac45Tp4o29RaHdex-tbI5aSuI_QwdP8WrIqGw>
    <xmx:C3onYfgMtooJNnNtLQ72g9WbPlM2GNhXD7_dcHdsRFCY8S22_hDBDw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Aug 2021 07:24:57 -0400 (EDT)
Date:   Thu, 26 Aug 2021 13:24:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Niklas Lantau <niklaslantau@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Usb: storage: usb: fixed coding style issues
Message-ID: <YSd6BQnE3BAuwF9a@kroah.com>
References: <20210820223954.2945-1-niklaslantau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820223954.2945-1-niklaslantau@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 12:39:54AM +0200, Niklas Lantau wrote:
> Fixed coding style issues that generated 1 error and 1 warning.

What issues where they?

Always be specific and descriptive, do not make anyone guess.

And you did not use get_maintainer.pl to determine who to send this to?

thanks,

greg k-h
