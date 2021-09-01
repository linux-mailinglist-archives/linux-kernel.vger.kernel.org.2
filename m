Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F8D3FD320
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbhIAFli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242126AbhIAFlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:41:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DD1361090;
        Wed,  1 Sep 2021 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630474822;
        bh=IvDkmizg58kyeyzMs8vObMqP+kT/IvEFz24k7Ro5FkY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HE5A0kG1VeoXaAd/L4M1SlrkspDgLL1dqgcKugepYq0CLSQSqGp0CykXBPRezqCb+
         7QlWciZRqaLM0ikXufDRIhPqMfH4XPxoUagSJ0+Gg4IPlAVQWES9uEQCq3NpJkbbs1
         P94NSKZ3r3JrTVGKrKKyyyMJZEtozpzXvHsCSGsri9M04tIxs+3RIlyvnHeNimmbQf
         2iMZoFwK75fIlluYTGK5sN7CW+eROyTUOOL4xy9sdm/nTo8YxwRMsQcwSttj1TAyt8
         fwot77ER6tzXa+/MSWOXuO36mKLRHp8FM2yydBOEMPBPSpWypDSv1LihvICRiFDkd/
         +/dz0+9xdOkCw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210831164210.15455-5-miles.chen@mediatek.com>
References: <20210831164210.15455-1-miles.chen@mediatek.com> <20210831164210.15455-5-miles.chen@mediatek.com>
Subject: Re: [PATCH v2 4/4] clk: mediatek: use tristate for COMMON_CLK_MEDAITEK and COMMON_CLK_MT6779
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Tue, 31 Aug 2021 22:40:21 -0700
Message-ID: <163047482135.42057.4815394359554916322@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-08-31 09:42:10)
> Now we have all necessary exported symbols, change
> COMMON_CLK_MEDAITEK and COMMON_CLK_MT6779* to tristate.
>=20

Please squash this with the patch that makes them into modular drivers.

> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Hanks Chen <hanks.chen@mediatek.com>
> Cc: Wendell Lin <wendell.lin@mediatek.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
