Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F301B38B6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhETTE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:04:26 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41936 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235418AbhETTEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:04:24 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C48FCA0040;
        Thu, 20 May 2021 21:03:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C48FCA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1621537380; bh=y+8k9wqsJtPgUJsqRvi4ZT1JcJem6VoeiPwXOKz49+8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gEuQOqvhKarNj1FC6LYFw4mBdEcl0qARfAhMs0XQlRPvCew6fRX+0iqvmEF32BU75
         LBn4Ysbu9AF4xWVunARQO7ESvwqP0JF/eetbI1lUY2s3Hzn0OKd/qoS9eEs3HeaOns
         EaxecFzu3DutMFCPBkeCUd+09MSjewOnwnI9Al34=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu, 20 May 2021 21:02:49 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] ASoC: tegra: Unify ASoC machine drivers
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Ion Agorria <ion@agorria.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210520175054.28308-1-digetx@gmail.com>
 <20210520175054.28308-3-digetx@gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <8e5d4442-00a4-460b-d37a-8962960dd7ff@perex.cz>
Date:   Thu, 20 May 2021 21:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520175054.28308-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 20. 05. 21 v 19:50 Dmitry Osipenko napsal(a):
> Squash all machine drivers into a single-universal one. This reduces
> code duplication, eases addition of a new drivers and upgrades older
> code to a modern Linux kernel APIs.
> 


> +static struct snd_soc_card snd_soc_tegra_wm9712 = {
> +	.dai_link = &tegra_wm9712_dai,
> +	.num_links = 1,
> +	.fully_routed = true,
> +};
Please, could you also initialize snd_soc_card->components? It may be useful
to pass the codec identification to the user space like:

.components = "codec:wm9712"

The passed information should be consistent. You may look into the Intel ASoC
drivers for the examples (card->components initialization). There are also
hints about the number of connected microphones ("cfg-mic:2" - configuration
with 2 microphones) or the codec purpose ("hs:rt711" - headset codec is RT711)
etc.

					Jaroslav


Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
