Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7597942890E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhJKIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235253AbhJKIqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:46:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A807A60EE3;
        Mon, 11 Oct 2021 08:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633941872;
        bh=1OwUVdNn4fURn0fs9OTI0ATGKii2OR1THQNdwkRa6Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBodex6jq4+8Stg3cIR0zRyzu22jFms7KPnST1FATnYsPXO7aC+8bZIOkhXyozxQE
         1JDZztGiTOqqWPYeAvBSGre0KRfLkDEztsvCUTk+/f1Y/N3Rg3W9Q0zFiLuyCYy1TM
         MHwon/DQUtonWs8jLRyViH3k5cVmouqgRQqjpDGjt5qXB/toNJC3VG4vUSIVmZai6N
         z4aZEHivtcrGkLjv6qVVfeuAT2S0wjqjn8bFw07TjlrPpmGRGBJep/ADS1OJV0gf8U
         O7fJQYPtDvM1sSy8wqEp8ievo/d41aJdFujHLn6e8TKK8U4fYrqOQax794CQlIZQr+
         GJGdpZVXCCcYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mZqv1-0002NB-DY; Mon, 11 Oct 2021 10:44:24 +0200
Date:   Mon, 11 Oct 2021 10:44:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     heghedus razvan <heghedus.razvan@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: misc: ehset: Workaround for "special" hubs
Message-ID: <YWP5Z6IaD3blIfue@hovoldconsulting.com>
References: <20210915121615.3790-1-heghedus.razvan@gmail.com>
 <YV7KGE9JfibggVVH@hovoldconsulting.com>
 <YV7QSnOlmKHbi94C@kroah.com>
 <CAACGJgbXEV4rnvkmHy-peaO2GiR7Mt=3Y=Q8w1Bnc9mJLwFPnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAACGJgbXEV4rnvkmHy-peaO2GiR7Mt=3Y=Q8w1Bnc9mJLwFPnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please avoid top-posting. ]

On Thu, Oct 07, 2021 at 07:51:00PM +0300, heghedus razvan wrote:
> Hi all,
> 
> This was tested only with some external powered hubs. Indeed for the root
> hub there is
> a problem. I see that in the HCDs in hub_control there is the handling for
> testing
> procedures, but I don't know how they are used for the root hub.

This isn't just an issue with root hubs, the current implementation is
just completely broken for all hubs. Which begs the question of how you
tested this, if at all.

> I want to fix this problem, but I don't know how exactly, because I don't
> have a good
> grasp on the USB code since it's a huge beast. The main problem is how can I
> match the VID:PID of the hub_udev(the hub on which the USB testing device
> was connected) with the hub list for which I need to apply the quirk? I
> tried to
> use usb_match_id because I want to use functionality already in the kernel,
> but it seems that in this context I need to do the checking myself.

You can access the interfaces of a USB device through

	udev->actconfig->interface

but in this case it's probably better to just export
usb_device_match_id(), which seems to be what you need.

Johan
