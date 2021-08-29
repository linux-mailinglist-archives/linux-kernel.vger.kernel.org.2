Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC73FA8A7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 06:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhH2EVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 00:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhH2EVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 00:21:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC5B460F25;
        Sun, 29 Aug 2021 04:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630210818;
        bh=FO8+hdXwOXyLSffpU0Lg6GBDy7gsoTws19hPSn0vJkk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cHJkPjM+w9+Zuv/eZH4cKOZnBvK2KWWh3GfKvhDYH8ThZtNvJEY8hieIirqcRqHPy
         2igT/+EzHAuyW5KE+2b77YA/c2uVfLLzoouoRS1DYmNPrcLjRlE+w9xwLyxI5G4qnD
         9dJM01A0A5BZxobh/raclP3Pl5OZOsh36DFNlMO4iU9ZfAFlbwWGvSkDEqM+4ZuaB2
         Rs7uaIJF2m6qrOQr4PXIwvDfFG3g+QGdqiZ+eUUM7GyiUVwxyPOUicvxSvYV4nvjxy
         vnpDPzaPrfMG6Bwq3vuy6lXuqyB5K3nbir119MHzVHg6uZkJBYrKrGkSpK1hH/xd4D
         mopTVhz12aTDA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210819223237.20115-1-rdunlap@infradead.org>
References: <20210819223237.20115-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] clk: at91: sama7g5: remove all kernel-doc & kernel-doc warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date:   Sat, 28 Aug 2021 21:20:17 -0700
Message-ID: <163021081762.2676726.3435457249459016223@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2021-08-19 15:32:37)
> Remove all "/**" kernel-doc markers from sama7g5.c since they are
> all internal to this driver source file only.
> This eliminates 14 warnings that were reported by the kernel test robot.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Applied to clk-next
