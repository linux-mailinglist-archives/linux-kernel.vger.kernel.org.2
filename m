Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9241A3B889D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhF3Slr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234579AbhF3Slq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:41:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10776613F1;
        Wed, 30 Jun 2021 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078357;
        bh=FOBQo1OgPE61390jL8TCzD2bmnI+UvkFZuPZ0xnshbU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g00tUWg2eYAaqMx7Vf2uJnFdKcNf2PF243by4nQ6QaeL1uLLjiyz5XdPLbk56cJFw
         L74NXlt49rJ2GXfR+TaIGKh1nTvMxf3aD1Rx6iHb4k/fVukrZOnWBLkSo+lgep2fw7
         J7qq5k9pXtktcQWsrkt9Xgz6X3c5M8MYTsHpnhC8nqzqVXO1XWcSmgrqgX6fE48FR/
         LiafHRJRtWH2xUx+zlwO+NIeIJhU98SW93py0hmNsxQjU7O61+AWFuBATVMd9UYStE
         XrI6YtiY5WVuh0kQ71jUmSPXYPh1LdzkdA/gKM7ITy9qt5WORo3f3U1eqxWAoW4qRq
         wXjq5jbxOxyxg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com> <20210627223959.188139-3-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to .determine_rate by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Wed, 30 Jun 2021 11:39:15 -0700
Message-ID: <162507835549.3331010.7414706391498029785@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-06-27 15:39:58)
> .determine_rate is meant to replace .round_rate. The former comes with a
> benefit which is especially relevant on 32-bit systems: since
> .determine_rate uses an "unsigned long" (compared to a "signed long"
> which is used by .round_rate) the maximum value on 32-bit systems
> increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).
> Switch to a .determine_rate implementation by default so 32-bit systems
> can benefit from the increased maximum value as well as so we have one
> fewer user of .round_rate.
>=20
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Applied to clk-next
