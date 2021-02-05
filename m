Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3D73113E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhBEVsx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Feb 2021 16:48:53 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:59087 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231250AbhBEVqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:46:39 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.69.177;
Received: from localhost (unverified [78.156.69.177]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23803014-1500050 
        for multiple; Fri, 05 Feb 2021 21:28:53 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <202102051319.E5D8B4528D@keescook>
References: <20210205163752.11932-1-chris@chris-wilson.co.uk> <20210205210610.29837-1-chris@chris-wilson.co.uk> <161255976138.12021.9385501710085642237@build.alporthouse.com> <202102051319.E5D8B4528D@keescook>
Subject: Re: [PATCH v2] kernel: Expose SYS_kcmp by default
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Kees Cook <keescook@chromium.org>
Date:   Fri, 05 Feb 2021 21:28:52 +0000
Message-ID: <161256053234.12021.17815864250035077266@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2021-02-05 21:20:33)
> On Fri, Feb 05, 2021 at 09:16:01PM +0000, Chris Wilson wrote:
> > The subject should of course be changed, as it is no longer being
> > enabled by default.
> 
> "default n" is redundant.

I thought being explicit would be preferred. There are a few other
default n, so at least it's not the odd-one-out!

> I thought Daniel said CONFIG_DRM needed to
> "select" it too, though?

Yes. We will need to select it for any DRM driver so that the Vulkan/GL
stacks can rely on having SYS_kcmp. That deserves to be handled and
explain within drm/Kconfig, and as they are already shipping with calls
to SYS_kcmp we may have to ask for a stable backport.

> Otherwise, yeah, this looks good. Was the
> export due to the 0-day bot failure reports?

Yes.
-Chris
