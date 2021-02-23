Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81AC323335
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhBWVZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhBWVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:25:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD8AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:24:33 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lEfAQ-007Zve-I8; Tue, 23 Feb 2021 22:24:26 +0100
Message-ID: <d2c3b464d782809298670b1ecbc199f56d776600.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7] PCI support for UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 23 Feb 2021 22:24:25 +0100
In-Reply-To: <20210223152707.408995-1-johannes@sipsolutions.net>
References: <20210223152707.408995-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-23 at 16:27 +0100, Johannes Berg wrote:
> In order to simulate some devices and write tests completely
> independent of real PCI devices, we continued the development
> of time-travel and related bits, and are adding PCI support
> here now.
> 
> The way it works is that it communicates with the outside (of
> UML) with virtio, which we previously added using vhost-user,
> and then offers a PCI bus to the inside system, where normal
> PCI probing etc. happens, but all config space & IO accesses
> are forwarded over virtio.

I hadn't sent it out until now, but the userspace bits for all the time-
travel and PCI-over-vhost-user are here:

https://github.com/linux-test-project/usfstl/

If anyone has any suggestions on a good example PCI device that already
has a driver upstream I'd be interested - I looked for something simple
like LED or GPIO but no such thing I could find (that wasn't platform
dependent in some way). So far I've only implemented a virtual Intel
WiFi NIC, but that depends on a large body of code I can't publish. As
an example, it would be nice to write (and publish there) a simple PCI
device implementation. :)

johannes

