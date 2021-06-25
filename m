Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357D33B3C14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhFYFWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:22:19 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56123 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhFYFWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:22:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3EF0558059A;
        Fri, 25 Jun 2021 01:19:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 25 Jun 2021 01:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=XLolmk+8PLMR+wcUsuHwHJRfzOO
        LDvGMmVm9jx8vVKU=; b=DffSXefl/b2ZWRYSW1Q5QZlvyVhO4t5ZxMccwRyppDr
        Yq1t3Igh4B2ZJEmg2379WCvHeNivuPqi7ZncRYjzU6MaDhIz/q/2lHqoepBc7Qos
        xA8UT5fT+zg7nyrTy3UmbFg9DdQSUU0NnKxGMWtxuiXLY1T4t+Z0bsldo33+Rs59
        1cQbY3oWbQRQjuotLYGJBC/RiBpj0oN0BDPxBK5gV8eSzdUjbiyf++YAjRkiW3tj
        IBKj2i5Pfhg5A3FWbvf/xAdK1UBduvc79lur5LiRglvCWc7s5287iAysqiv5uK+L
        54wXxkukajMxXNTkUnZP63EoLWSlVCK46E+ZFPGILEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XLolmk
        +8PLMR+wcUsuHwHJRfzOOLDvGMmVm9jx8vVKU=; b=nOnDMj6tAfoLkpPSymRiyK
        oW3O7cHuSlLgoXF4it5O+G2WwHslYTPQiPxjveGxtr0zWMTPZEF6fZk7Iz3vCu7e
        YcqZm9WthrS6lfa9kEPzBRBxiuRLO6j0ID+Eo1A4+wmkq5ZXuzDEYu2XOojL+LT/
        qN1MyvUymGzmuTZdgbwCPbWsW3InuZQwdSNfq1BEfVUrzCI4+8Ocdn5EnNBcJbbq
        hS7wPg+FLJE7Zxz6Om/gOw/1/1QUQOl+LipU0XQPqAYHRB1GNd2P1walZTGVm3LI
        H6PdHPWCUem+vuI54h0HaHdt78Y146yAUJ1LdZ5+rOxZbW8cZd7TstLeCr/33Ewg
        ==
X-ME-Sender: <xms:fWfVYGh8Xel1k6h8ia54UL14-3oBP44Nox4qYbX68ScGqGv5FbmISQ>
    <xme:fWfVYHCEaYJU09-NJcuvqX2CDCQlqunfcAMioBytkKmGsPgxiSp0bXV3rGgQZy4fk
    NPxGr6ho7vdlQ>
X-ME-Received: <xmr:fWfVYOFbioKCbmP-rApn-Udz1N31aVrHOQPqRxkyhtP9GNHIgRsXEMNJ3bsGdXcU-GUy_UXENbYUEjyfNH2YDuCmRdy6xiUK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegiedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:fWfVYPSwxPl_UC4fL0cP416zu1basml9fqgRgL3c2dH7Z5kovYCSlA>
    <xmx:fWfVYDxU7gRxna0EhTYGW02RSrbz77WaCow9D_iwFb06kbWQheGzJw>
    <xmx:fWfVYN5hXmm1b6T0V07nfm-8p1rsuBJ_W7Hj4iijl-7vp-czn1Lgzw>
    <xmx:fmfVYAg1Og3XA07Lsy6dXE6iBFPCCluQ7DTEiy8fvlWWbnMr4E6L-g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jun 2021 01:19:56 -0400 (EDT)
Date:   Fri, 25 Jun 2021 07:19:52 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNVneO6exCS4ETRt@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 10:28:36AM -0700, Andi Kleen wrote:
> > But a driver does not caer.  And if perf does not care, who cares?
> 
> The users who write scripts that specify the perf events on the perf command
> line.

Great, then as you have deemed the device name part of your documented
api, then keep it stable as that is what you decided to do a long time
ago when it was created.

thanks,

greg k-h
