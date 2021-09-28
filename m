Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3247D41AD18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbhI1Khw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:37:52 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:58427 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240263AbhI1Khv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:37:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id BC1BF2B01641;
        Tue, 28 Sep 2021 06:36:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 28 Sep 2021 06:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        RwK92zCAcula3MPBBDktxTII0lM1AId0zn4FPopqJBE=; b=l+tRcVsSKoY/BzSD
        XUgC5S7Z7jGsbgXjFmiD9kZOjvt5xCcyF2HdjpZqrnCrnuHS5JsL5zon5aoND9ka
        FPylnp2todRNRYdpeRbml9UKBZZN7zzCvxz7LuvFnf5kVeEexJDVxBEgb2sOSiW9
        RkJR8lcytnvVpYuwfQbd+EVDL3CNaMQj/MAgVmc0Gs5z7sMLoNZ2e6ZrVmqC9r2k
        gXR0JwWytoUT85RjA79GXBoYNWUawBc+9suBq/pqc8k337xOMf7tsj0WU3RWty8K
        0M2R53fp42kKlSEe1mQPvcrn0MBt/jo7d7RWbn5M57y8/FQYIpyTOUBTsVbFIb9l
        9E8ttg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=RwK92zCAcula3MPBBDktxTII0lM1AId0zn4FPopqJ
        BE=; b=cEBRJtLtWMGAFQwgl8j7poxmvF04fDxr/haBxO6JSLVGe+X62sHZMCQkk
        AdoHs/0OZo4VN11bVUaZqS/kFzw4CurLZRl4WWUvdoEW9+hhDYPAkKn+aT+fFfrO
        AfSFoMFvhsrRG7aDS8Ipm44ZKt2/pSOg+pbtlAY8eXyzyz2wRcYLlnYCOqwUfEyd
        hI/7MZRDkFhUimyPBPO73PtWrJ3ng58kTyovIda60qNI/fs3O+DIXtWNfIm/lSq0
        LQpzZMNeOcWqj4KlsaCRnB3ymO9DKSkNfkIJdCGC+zKh6hAWgP9zsXSyun7msjep
        wEaVM3o10x7tps9/YqCxBo0k4fjJA==
X-ME-Sender: <xms:GvBSYURnuIEWCMrG491rZRZ9XozZrApEdXSNAan6DcwRQyG3C6I2CA>
    <xme:GvBSYRws8VpiIm9zxC00z8qrby8T4ucrGrGCg_HVHjoyV99O_IY2JFWh3LeilWgT_
    t0KpeqvRENxmF1Q-sk>
X-ME-Received: <xmr:GvBSYR1IgU8J0IjUtabLVY5kdcRtIwN0n4IeMJcXfEDh0QLgKuJa7m04Nr96g1BoCILWes511Js9joTQkTBGDH06pShJwwk1T25TW4xx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudektddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GvBSYYAudea1AqVRXUOp4kqA6zUcxcu5mtt5EwTNAluMC_ajaTfAtA>
    <xmx:GvBSYdiQ74EcUhEqNKBR2ThQuQLwO-ayCGRKhq2AjlmnyfXGEKtpNA>
    <xmx:GvBSYUpYKecyK0v8FAyWYvCcFig_-n1S2VDJLmH5r7nq4d0S-i0LYQ>
    <xmx:GvBSYd5YHGGLRqLSbbUCBvpdMGu--zES1hchig7d1dEEBzGPrT1l8nq1eBE>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Sep 2021 06:36:09 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@intel.com>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Dom Cobley <dom@raspberrypi.com>,
        Sam Ravnborg <sam@ravnborg.org>, Emma Anholt <emma@anholt.net>,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 2/3] drm/probe-helper: Create a HPD IRQ event helper for a single connector
Date:   Tue, 28 Sep 2021 12:36:01 +0200
Message-Id: <163282429897.583318.4373405476730486119.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210914101724.266570-2-maxime@cerno.tech>
References: <20210914101724.266570-1-maxime@cerno.tech> <20210914101724.266570-2-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 12:17:23 +0200, Maxime Ripard wrote:
> The drm_helper_hpd_irq_event() function is iterating over all the
> connectors when an hotplug event is detected.
> 
> During that iteration, it will call each connector detect function and
> figure out if its status changed.
> 
> Finally, if any connector changed, it will notify the user-space and the
> clients that something changed on the DRM device.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
