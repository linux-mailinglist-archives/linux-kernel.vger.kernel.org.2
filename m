Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4602337028F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhD3VAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235918AbhD3VA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:00:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1E4B6145B;
        Fri, 30 Apr 2021 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619816380;
        bh=sTjsy5WOTgX1u10dfsQUQso5+PDbD5rVnV7Ng/jVLM8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ME0A2FUs/7EEXR/1WE1FVH20j5QwRXH6s5oOgVgmA3+1TjSlUolDTVZwf06KP0KUp
         ccEJLBYxYSkacxlf7II9BhkeyFw+La9xa1hqId3OBHRe8Qj3Dg7ieL0u+yzQC0re8+
         rVr7e9lfHNMhd5pkBnof+krnJtPW2psJWFRH63Ngdd+0rdSwpsbbp3ZXiRikiapMN0
         WfMF65ECWeocstXBAiC4SYpy9uNnyf6gJPBxzVCb+ds/CJAu25+oVqjIowRxRaocl5
         DPuygzxixHJzObbq6Sf7dV8xcN42YjaKqJ2OwaeGu+c/6MssC5Oq7lWn6IDGbmOfor
         OTDMGKIm6AhMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210413101320.321584-1-maxime@cerno.tech>
References: <20210413101320.321584-1-maxime@cerno.tech>
Subject: Re: [PATCH 0/2] clk: Implement a clock request API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Eric Anholt <eric@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-clk@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
To:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mike Turquette <mturquette@baylibre.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Date:   Fri, 30 Apr 2021 13:59:39 -0700
Message-ID: <161981637939.1363782.4943687720432536625@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2021-04-13 03:13:18)
> Hi,
>=20
> This is a follow-up of the discussion here:
> https://lore.kernel.org/linux-clk/20210319150355.xzw7ikwdaga2dwhv@gilmour/
>=20
> This implements a mechanism to raise and lower clock rates based on consu=
mer
> workloads, with an example of such an implementation for the RaspberryPi4=
 HDMI
> controller.
>=20
> There's a couple of things worth discussing:
>=20
>   - The name is in conflict with clk_request_rate, and even though it fee=
ls
>     like the right name to me, we should probably avoid any confusion
>=20
>   - The code so far implements a policy of always going for the lowest ra=
te
>     possible. While we don't have an use-case for something else, this sh=
ould
>     maybe be made more flexible?

I'm definitely confused how it is different from the
clk_set_rate_exclusive() API and associated
clk_rate_exclusive_get()/clk_rate_exclusive_put(). Can you explain
further the differences in the cover letter here?

>=20
> Let me know what you think
> Maxime
>
