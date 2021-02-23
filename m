Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20B322DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhBWPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhBWPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:47:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47753C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:46:42 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lEZtU-007ReE-Po; Tue, 23 Feb 2021 16:46:37 +0100
Message-ID: <af37cafc60dd0724f76c4be40fc5f70fbe28da13.camel@sipsolutions.net>
Subject: Re: [PATCH 1/7] um: allow disabling NO_IOMEM
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Feb 2021 16:46:35 +0100
In-Reply-To: <CAMuHMdUU40kv6SncuCYGjattnEWR2k7FG2NS+6ffY6K+D1qsiQ@mail.gmail.com> (sfid-20210223_164419_226979_7AEC4F67)
References: <20210223152707.408995-1-johannes@sipsolutions.net>
         <20210223161449.5fbbdace8fea.I7b2fad8378e4fde7f26ef06a03980ae2807d81c9@changeid>
         <CAMuHMdUU40kv6SncuCYGjattnEWR2k7FG2NS+6ffY6K+D1qsiQ@mail.gmail.com>
         (sfid-20210223_164419_226979_7AEC4F67)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Can't you just use the asm-generic versions instead?

Hmm, yes, for fb.h and vga.h that should work, since they should never
be used. For vga.h it would be wrong since it assumes the VGA memory is
mapped into the CPU memory, but since it should never run it would still
address the compilation issues I needed this for.

So yeah, I guess we could just use the asm-generic versions of these
two.

johannes

