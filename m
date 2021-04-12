Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D161035D1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbhDLU1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238681AbhDLU1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:27:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35E3161287;
        Mon, 12 Apr 2021 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618259251;
        bh=EO26agsZ52yk+XYY7+s4dbantb8ueHlmFx9OyyK0kTo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pLMW7bpyTauye9n/tTJLfkCwDAwwFDRQ88/4wo4aaJ5E66wy3JKxheNS4il9Qk/jB
         FH7i3eNyFMEPR5HQKYSmzXvrBJeZvZaZIOH8NGIe5Wy13B+b5rOodzIx371WIlaWPE
         5GGZhIABHHI/15d2qhtkg6H+nrpd4ND+GlyQw/T83gMkQ9t0Fqom4whs/Bi0soRsDv
         5AYmcwoJ9jwmNC1J4/SoIQeoyNU2MG0xXeXfiSImKpuyjBDzLnVV9chQ5GL4NmcTFx
         llEC3+ommCAYxYRR11zwvCB/rvF1yYLA+wJbIeCJygJsCEZLvlMZgMup13UaFxhH1J
         fxSDuy7HnJ4Zw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210410111356.467340-6-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com> <20210410111356.467340-6-jbrunet@baylibre.com>
Subject: Re: [PATCH 5/5] ASoC: da7219: properly get clk from the provider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Date:   Mon, 12 Apr 2021 13:27:29 -0700
Message-ID: <161825924986.3764895.15935511179507514937@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2021-04-10 04:13:56)
> Instead of using the clk embedded in the clk_hw (which is meant to go
> away), a clock provider which need to interact with its own clock should
> request clk reference through the clock provider API.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
