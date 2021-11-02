Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90B4437E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKBVjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhKBVjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:39:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF35961051;
        Tue,  2 Nov 2021 21:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635889035;
        bh=aA13ytwSWWyPeHSJUnpjZ5BiRRVZ+naCeT+Ps1/5ew0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E8PG6ogZxISXkkWjPDkuE+wTwtnm//8Jf+bLjw+pVJntSwI1ncyhycGRqx5kvmQih
         UiCgkh1MQK8d614P61/4mB8gtp+2z6f/9FEWdLjPUH7TJ2WEFpHwv34IOscHjx4+83
         niJ8hgoNW/QN7tnH/FJ/rUsGPJVg9lBKswaQh6powcu+7nr1vnuJvLOLBTjRsgZ1rE
         QUtAwVhIc1w3BMf0gR+zW/bwXbqfgXydNpDyKv8bPCXSQlZb6ohhomVPy6G7rCJgq9
         5UDQo84YKX/2lX5hPnuK2bW51Gy/z6FQTrCZSTBBResUIh2x/i14S2O01EY/gnXY4j
         kzPiB0FxvuowA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634000035-3114-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com> <1634000035-3114-2-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v3 1/5] clk: uniphier: Add audio system and video input clock control for PXs3
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 02 Nov 2021 14:37:14 -0700
Message-ID: <163588903438.2993099.14180630259478245167@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kunihiko Hayashi (2021-10-11 17:53:51)
> Add clocks for audio subsystem (AIO) and video input subsystem (EXIV) on
> UniPhier PXs3 SoC.
>=20
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Applied to clk-next
