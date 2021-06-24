Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A733B34DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhFXRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:38:06 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:48069 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231488AbhFXRiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:38:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 873C92B012D5;
        Thu, 24 Jun 2021 13:35:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 24 Jun 2021 13:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=syn1YILhAfK3M/UNb+KP9SgoCkI
        TBzoHQzyI1Q73vlo=; b=lnHQSXciF28N2qox0++TGJ7z2pNBKwXXr715ocOib1C
        /zbFNcR8d5m+nqByCu8sKDg4nmYQF7ShRs90jzg4dxjPA5C7lW5+rpjLc38tUmuP
        Buenm2LWdZxo/1exDKxsSZpZgK6HeTQ15jFvHJFYiqa8BcR1emqJpa4+s64jN6Av
        j1+p+lKjIuvLtMoNCpy8jVUF+LZ8tHbhC/apkyiiH0aJCOTxFYL9QdXSZmavNQWf
        ubxqBZvY0Igqh4+cPzFyqy3eHcZjlC9HMF54+11lg//oHrJlKkUnDcTXZm5Zch1i
        /lNgQi6eSe/8mehmAEshT+TmhKHGODQTuNRj9MnkQtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=syn1YI
        LhAfK3M/UNb+KP9SgoCkITBzoHQzyI1Q73vlo=; b=mpcDVh/s/HyxIxzVM1jJ1u
        FB6Sr7YTGTzQ6akhRP7xVCROkJ0Tx3KE4gE+43slyrbjYUOEJmBJHHmbMg8STp9N
        bUa1nRXitB6dTYFbSTF/URODu+LAYD7Hw+rTboQlZURDsQZCsuE1e9ICRxdDWFCg
        aC8UEtE/7OLNLXB57hx6sEWnA4grlapCAqb8Xxr2PdmeD3ctuKb+7M60HSeOiZVd
        2LL5GdBe3kYk5Zt6t67rv2LVjdSFAgsz/HdgBXRpHCVlBEi8OKbeBYrCx5nGYi9S
        FfWZZbNf0XV3oxA7UC+Qpx2hbJwpD8xrS/ZZd4v8n+5UpoG1TmRevhTOnwom+xBA
        ==
X-ME-Sender: <xms:b8LUYBpcofhVmQzO2KhMFMnxOfqZfp7e5U6XwV2tAUh9ZUmWutlg4g>
    <xme:b8LUYDqvYZG_e0WiElln-CsRxk8KvaYQOn7JI5bX8p4mE-OhCrpPYNpzs34aYJF2Y
    v5mJBm-WBfDuA>
X-ME-Received: <xmr:b8LUYOMP3nbZ3qjP5Pcfw21z9XhLr-bKKPsQuDSm5eswOX0iNRJgvwOHWV6yx7NJ72QPB0UlVCtq5YA7adQIt2bDlUApO4Je>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeghedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:b8LUYM4h-uL00MH2ayDb1BherWcdPiRb8ferIGjiU944oobxpdzSxw>
    <xmx:b8LUYA49C2mvJ0mX2Gw2kDL0pGa6LXxvU7WQwEpLenAXMwK6TrsQXQ>
    <xmx:b8LUYEgvcsB49pPUbHIhRliZKBGtCbVETRLnjD-AztJB5K8PVF_R2g>
    <xmx:cMLUYMq7RIzNdRaffHQ4hnbwfjJU6SacefRuUsVO-FPjMuy1GZjUxvrMMFA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jun 2021 13:35:42 -0400 (EDT)
Date:   Thu, 24 Jun 2021 19:35:39 +0200
From:   Greg KH <greg@kroah.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNTCa5QO1YMy8fJ0@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <33bccec9-c4c4-d52b-9ee4-9a09e7353812@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33bccec9-c4c4-d52b-9ee4-9a09e7353812@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 01:07:14PM -0400, Liang, Kan wrote:
> 
> 
> On 6/24/2021 11:31 AM, Greg KH wrote:
> > On Thu, Jun 24, 2021 at 08:24:29AM -0700, Andi Kleen wrote:
> > > 
> > > On 6/24/2021 7:29 AM, Greg KH wrote:
> > > > On Thu, Jun 24, 2021 at 07:24:31AM -0700, Andi Kleen wrote:
> > > > > > But first off, why is this symlink suddenly needed?  What is so special
> > > > > > about this new hardware that it breaks the existing model?
> > > > > The driver can be in two modes:
> > > > > 
> > > > > - Driver fully knows the hardware and puts in the correct Linux names
> > > > > 
> > > > > - Driver doesn't know the hardware but is in a fallback mode where it only
> > > > > looks at a discovery table. There we don't have the correct names, just an
> > > > > numeric identifier for the different hardware sub components.
> > > > Why does this matter?  Why would the driver not "know" the hardware?  If
> > > > it doesn't know it, why would it bind to it?
> > > 
> > > It's a similar concept as a PCI class. How to have a driver that can handle
> > > future hardware, but with some restrictions
> > 
> > But this is NOT how busses work in the driver model.
> > 
> > PCI classes are great, but we do NOT suddenly add a symlink in sysfs if
> > a driver goes from being handled by "generic_pci_type_foo" to
> > "vendor_foo".  Userspace can handle the change and life goes on.
> > 
> > > The perf CPU PMU has had a similar concept for a long time. The driver can
> > > be either in architectural mode (with a subset of features), or be fully
> > > enabled. This allows users who are on an older kernel to still use at least
> > > a subset of the functionality.
> > 
> > So a device name will move from "generic" to "specific", right?
> 
> We'd like to keep both names.

That is not how sysfs and the driver model works, sorry.  You don't get
to keep both names, otherwise sysfs would be even more of a mess than it
currently is.  What happens if you need "another" name in the future?
When do you stop?

this isn't ok, please do it right.

greg k-h
