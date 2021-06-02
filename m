Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266F397DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFBBUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhFBBUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:20:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA4B5610A0;
        Wed,  2 Jun 2021 01:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622596712;
        bh=1o7gD4OMYY3SBiLWA/WlsTVLiCvzSUr1vbDOlJ+IOkE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=k1fc9rXibtuo6Jg+8JQZpyudl7eWiN01kgJJKGDCqK7yukFbFX4561rHQlNzQGojl
         Y3QRRCv0YnZ63eA6TfBdnfmepcGzrTwXTl7/JEFfT4zmCxfRYu55nOgCbHghDkwxTO
         8i9zDxaeReat/4e0JfrauPWBioPeso5On4hdNXv/eTBq6DJCz0j0RUEJpV7b8kJhV9
         jpjSLBTVJkqquN40+VSIkWlI+nUI2VqA48RbSBkTjd/+IxhPKs3TqqVjjZo+lK6urG
         G7LcOHQyvn1qwdjihLtqCGA1XvABGSWdQuvX/aiwdYn6LutvZqwNFRzqRlljpTIhpO
         zmVTeCFB1F2UA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210520161702.3746174-1-lee.jones@linaro.org>
References: <20210520161702.3746174-1-lee.jones@linaro.org>
Subject: Re: [RESEND 1/1] clk: versatile: remove dependency on ARCH_*
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peter Collingbourne <pcc@google.com>
To:     lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com
Date:   Tue, 01 Jun 2021 18:18:30 -0700
Message-ID: <162259671073.4130789.14746691024562197059@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-05-20 09:17:02)
> From: Peter Collingbourne <pcc@google.com>
>=20
> It is now possible to build a modular kernel for vexpress by
> not setting CONFIG_ARCH_VEXPRESS=3Dy and instead setting =3Dm on the
> drivers that it normally implies. This is with the exception of
> CLK_VEXPRESS_OSC which is currently hidden behind a dependency on
> one of several ARCH_* variables. Remove that dependency so that
> CLK_VEXPRESS_OSC may be enabled without it.
>=20
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I435a21e2e5f6187db54f4ef20=
79b60028ab2ea69
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
