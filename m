Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FE3F8652
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbhHZLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:24:37 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60715 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241887AbhHZLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:24:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E56E45C010E;
        Thu, 26 Aug 2021 07:23:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 26 Aug 2021 07:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=xhPeWgw2JhcQ2s7hwE0vCi4jbgo
        eiwq015e2qX2II3U=; b=y8friRw+kq1I1NUdW6b4Nx/Ic6OgieoopOT1mRpmWEK
        7aa2JYqsV66qZTlJ66hNjiwWCWjwxkv7kZz0petNudza+JQzsmDb2JUcED5QoSQl
        oZ0Lt5n2O3sI81L9ba4HLg0o+GVnkWt7uVVxgS4HoJz0qznxFDuK2BYX7F4J/YvX
        9PDoKipEmYN5F9qyUbJCsLCLv+n4kgYYXV8QTNV27Z7vsyRCFR89QYqDBpMf9Dyx
        kAXU0OZbivcX8hVQDbikCg382RrbDA98ANpAXPUFAcN4jCfaDc1m4g0p3n5h2KEw
        riwbreoXQjpDzqWLrgnClL98qgfaQdkS8y8iFNWcBwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xhPeWg
        w2JhcQ2s7hwE0vCi4jbgoeiwq015e2qX2II3U=; b=X+efeJc3C7EdFdMCEZZTul
        7hGkYj9j5UkgGwFK6t1P49NoN1vYNEJxTzlMf1Eaprs7YyZslOrbHJQHa/a3nvkM
        ZH7B0WC3g4lyOLGR1MQb1v/gGxjFV31hvGmYXp5bnGA9f/4yJNLYGl0fRth8qWjo
        cZQR/O6Svv1/13zalrEBPhNPQdH3z/BsFOeP6LNpabBe0XEyMfnzqnsjLKpuhpsT
        khyI83eKl2kGBwptYguyqXhrVf7b2drqiwF9Iba0j/t/2QKKGOBe0B2yUFv/JBDl
        MzM2BKb5d5UxW2zbmtRazYx8K+UMta3cmChtymNRFNMPf029+zF4Mj/VvEx5XApw
        ==
X-ME-Sender: <xms:xHknYRnDLDqXOM0ru4pUoW_9qQl2FOJvEi3Em2udy2BuqF0IXsxeIQ>
    <xme:xHknYc2jWc3sZzxQk43_J4QnjCIJXE5oMZFZC9eub2Y4nM4Xl8CeIx4I0icYYZuvK
    OGCIxmuqKUleQ>
X-ME-Received: <xmr:xHknYXpEsbbVRuGu9fGubLHsj-Lqq6NKiiZn-tRgOv-EUOWykokTWDGn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:xHknYRkwWz5L6YEUM9YbXfRJvR88v8DJp0nCYi8ZMAzJFnZBczVbJQ>
    <xmx:xHknYf20WbuWGOWKeSbXb-Y-syZEdsxcpuN8ZOORwSO9LiYlEN2qbA>
    <xmx:xHknYQv67x1_SAfh7QfW20vc64yMmGDM_ERl62GKP7yQOHHO6ZU3Tw>
    <xmx:xHknYYI_gsRLBFCWiLL6E8073SwHGYHoeiTTnkHFOcvhPVQ7J4oNJA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Aug 2021 07:23:45 -0400 (EDT)
Date:   Thu, 26 Aug 2021 13:23:32 +0200
From:   Greg KH <greg@kroah.com>
To:     Niklas Lantau <niklaslantau@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Usb: storage: usb: removed useless cast of void*
Message-ID: <YSd5tKoxq2yABc+U@kroah.com>
References: <20210821121134.23205-1-niklaslantau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821121134.23205-1-niklaslantau@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 02:11:34PM +0200, Niklas Lantau wrote:
> Removed useless cast of a void* and changed __us to data

Why did you do two different things in the same patch?

If you want to work on coding style cleanups, I recommend starting in
the drivers/staging/ area to gain experience before venturing out into
the rest of the kernel.

thanks,

greg k-h
