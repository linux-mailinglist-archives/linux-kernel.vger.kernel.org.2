Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2935D1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhDLU0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237251AbhDLU0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:26:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5157561287;
        Mon, 12 Apr 2021 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618259190;
        bh=VRTKMojKdtuJHFzFHeTyk5iAs1Q1XW/RoReDqe95/PY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a5hbM90jgeBbZy5DXQZpsyRiT8ZFN1jW7xfWb48fGDSVewu1Nlh7spwJ1qNc09oxa
         hHX439tatktCkD5U2cftaq7MlNQsjkmlAQUGLSICT8JPsEI8GS9lnSaFOhoYN/uzDv
         LglgFeGOp75jkVO8WIvHagn2/P89s3J9i4A/K3N1wKDqO6xACbXbgdVDVNmpF+TnoV
         9yMjah6daCGeGLZBPxnSzqIqNPkrvzgKcelcF6dRyiZWtiX3b22cf9ueltiHwQrFuV
         KJ21DEndDqqbkQPfsm3FhdnQW7X6Z16ip8+0UElLY4GTLuZQoyRT8Sn/LBXT/41nN3
         jv9F/WUoSlPXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210410111356.467340-3-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com> <20210410111356.467340-3-jbrunet@baylibre.com>
Subject: Re: [PATCH 2/5] ASoC: wcd934x: use the clock provider API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Date:   Mon, 12 Apr 2021 13:26:28 -0700
Message-ID: <161825918879.3764895.12600274147776655755@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2021-04-10 04:13:53)
> Clock providers should use the clk_hw API

It sort of already is :)

>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
