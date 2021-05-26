Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C149390EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhEZDM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhEZDMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:12:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2685B61430;
        Wed, 26 May 2021 03:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621998633;
        bh=s6K29mOAmYlAEjF6BtifwnY/ffgWwJrfa7x0LxnBi4M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VlofHIgqu+CpFTnqU7dLe/D+0aEEInef8vswnkK7aCkWAxHUKebbyrjNP+xqWviJE
         qH7L4iBeUwpS8jc590dChbe4y1ZJb9dqjg2CZd5QsphctxhC5LmtPjeJECwQfZkdVw
         QbZ+RN7uN3pet29zICBjEArEeyGWxOAA7HiEk0Rb1gW8B3uDEQ6pWGXx7kogOuGh2L
         XuWeL7AwC8vEQ9L84isx8atBw2EX5CgZQqtacRLnwXN8jKhc91JU3BYCc/fhSBd3vN
         rinw0a5Bjqh+civM/QR9MkdNGeqI/dCYqjFKK707oezHmU3KjqodZX/bzJHru6fKxF
         bMG6FW9ZKaarA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210524182745.22923-4-sven@svenpeter.dev>
References: <20210524182745.22923-1-sven@svenpeter.dev> <20210524182745.22923-4-sven@svenpeter.dev>
Subject: Re: [PATCH 3/3] arm64: apple: add uart gate clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Arnd Bergmann <arnd@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Tue, 25 May 2021 20:10:32 -0700
Message-ID: <162199863202.4130789.9536491283421539572@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sven Peter (2021-05-24 11:27:45)
> Now that we have a driver for gate clocks add the proper topology for the
> UART. These are already enabled by the bootloader but are part of the
> clock topology used by devices yet to be implemented.
>=20
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 36 +++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Mostly an FYI; I will not pick up these dts patches in the clk tree. If
you can send these in a different series it makes my life easier because
then I can apply the whole thread without having to manually kick out
the dts bits from the mbox.
