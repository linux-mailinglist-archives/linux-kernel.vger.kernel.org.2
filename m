Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C955324096
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhBXPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhBXOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:36:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D06C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:35:19 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lEvFx-007ymM-VU; Wed, 24 Feb 2021 15:35:14 +0100
Message-ID: <b4f7d1f0367548d58d870694eea6187293f0a386.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7] PCI support for UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Feb 2021 15:35:11 +0100
In-Reply-To: <CAMuHMdWymKxYQHPC4Rqc1A7WSdQZDm6noaedHgXqfXPttmGV6w@mail.gmail.com> (sfid-20210224_104734_536153_8E0CF38E)
References: <20210223152707.408995-1-johannes@sipsolutions.net>
         <d2c3b464d782809298670b1ecbc199f56d776600.camel@sipsolutions.net>
         <CAMuHMdWymKxYQHPC4Rqc1A7WSdQZDm6noaedHgXqfXPttmGV6w@mail.gmail.com>
         (sfid-20210224_104734_536153_8E0CF38E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > If anyone has any suggestions on a good example PCI device that already
> > has a driver upstream I'd be interested - I looked for something simple
> > like LED or GPIO but no such thing I could find (that wasn't platform
> > dependent in some way). So far I've only implemented a virtual Intel
> > WiFi NIC, but that depends on a large body of code I can't publish. As
> > an example, it would be nice to write (and publish there) a simple PCI
> > device implementation. :)
> 
>  bt8xxgpio?

Yeah, that looks pretty good, thanks for the pointer!

johannes

