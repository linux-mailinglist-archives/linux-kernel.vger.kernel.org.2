Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321FA4437E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhKBVj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhKBVj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:39:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0767603E9;
        Tue,  2 Nov 2021 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635889041;
        bh=Ya+fONfmvirADDdMHaMt54qKY0ywUoCbOp5LZ2iFwS4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=e0FnnWYk+IaROhYz1xy7PlvOK0gKHkohN85YOxM6y2Z+w7gmLvR4EvoheRSXVOtE7
         nxll0ephrFecShtyWqc/haYni3IZsyutXH/pr6QlGduDecd/oEcmZzFFPBXGqbR2FV
         PmC8cVpJuvNZex7zvCVd9NCvB0T1Ys+muvM0BKZ0R54zZMzbV3X8ZWMAK7BruPo2SM
         AZc7hRrirK+w3tPSB6Ebdz0phTTzRa9a/NosTvUZl1fUKKG7tv8tp4PfmdyCimAs9Y
         +NzH5KeKIdLl5pfrkZlrQepZ4mQbb8t2qfxkpd+/hPuVopeWQ5vLH9lfhK1gNbK4SF
         5SGTbCKhg0sKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634000035-3114-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com> <1634000035-3114-3-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: uniphier: Add NX1 clock binding
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 02 Nov 2021 14:37:20 -0700
Message-ID: <163588904039.2993099.10398429736670327036@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kunihiko Hayashi (2021-10-11 17:53:52)
> Update clock binding document for UniPhier NX1 SoC.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Applied to clk-next
