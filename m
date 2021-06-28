Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD953B5683
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhF1BNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF1BNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:13:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67E8061469;
        Mon, 28 Jun 2021 01:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624842659;
        bh=+wS5YIe6dgHqIG4uNVNcfdZ7vb3vGFYJt+H7YQeWAC4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kAKa2cDX2dBCZU/bnjqk7ouxToktEx1wI4kZacvgM3ILZ+rdWfU5PrLjMPrRdiy9o
         Gd9t6FSjt34frhgY9U21a7qbrMMHcxcEkyeVbAEDiCRIXUFVZc7Hzt5rSoQdn+yuqd
         UUPGaGq9fuBuzyjBS+CXd2RIp8x2sdbqURa57TnQRtlhgNk2jKk9FzJHf4Y3BhSbSW
         LxPVUru0XwZ1ryhFILdMfOfvrtP0U3Ur8oA5ue6J2r99aUsfWgRLhOa2Kwq9bexuxT
         +VfytCDdbk0nNagsG3HnEH83Y2i3bUIz1RXEzVxtcQxPegJDQBSGXIOe+SkEgSx+KL
         v0IgApEK0Wv6A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210423004057.283926-3-liambeguin@gmail.com>
References: <20210423004057.283926-1-liambeguin@gmail.com> <20210423004057.283926-3-liambeguin@gmail.com>
Subject: Re: [PATCH v5 2/3] clk: lmk04832: add support for digital delay
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     julia.lawall@inria.fr, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
To:     liambeguin@gmail.com, mturquette@baylibre.com
Date:   Sun, 27 Jun 2021 18:10:58 -0700
Message-ID: <162484265822.3259633.1205812088952427742@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liam Beguin (2021-04-22 17:40:56)
> From: Liam Beguin <lvb@xiphos.com>
>=20
> The digital delay allows outputs to be delayed from 8 to 1023 VCO
> cycles. The delay step can be as small as half the period of the clock
> distribution path. For example, a 3.2-GHz VCO frequency results in
> 156.25-ps steps.  The digital delay value takes effect on the clock
> output phase after a SYNC event.
>=20
> This is required to support JESD204B subclass 1.
>=20
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---

Applied to clk-next
