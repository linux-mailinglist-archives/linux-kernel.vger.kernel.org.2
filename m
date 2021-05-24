Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DCA38E4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhEXK4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:56:38 -0400
Received: from mail1.perex.cz ([77.48.224.245]:52898 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232397AbhEXK4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:56:36 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E19A2A0040;
        Mon, 24 May 2021 12:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E19A2A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1621853706; bh=SsQADfu4c/5DcA6Rxn7R2IhZKuoFdZKz0HMzZ/XLUd0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ySU4G582M9Vq5C4bhSHgjxixBUY2m0/V0CRlX3VSktSbDx34n6WyYeNLI6GRnfymJ
         zyR7KQqlgwI9cMgKf2CYrTHfCMZ9yLFozlp3mklMBoy0qNkGJYjBOQwODp/87iGptw
         GW8wzqdVhh+Dp1CGuTKxcwc84f0+PFrUmOEapvdc=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 24 May 2021 12:54:55 +0200 (CEST)
Subject: Re: [PATCH v3 3/4] ASoC: tegra: Specify components string for each
 card
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Ion Agorria <ion@agorria.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210523234437.25077-1-digetx@gmail.com>
 <20210523234437.25077-4-digetx@gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <682a8978-a2fa-1a2d-e312-fc13ab3a843e@perex.cz>
Date:   Mon, 24 May 2021 12:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210523234437.25077-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 24. 05. 21 v 1:44 Dmitry Osipenko napsal(a):
> Specify components string for each card of each supported device. It's
> a free form string that describes audio hardware configuration. This
> information is useful for ALSA UCM rules. It allows to generalize UCM
> rules, potentially removing a need to add new UCM rule for each device.
> 
> This patch also adds asoc->components hook that allows to specify
> components description per device.
> 
> Suggested-by: Jaroslav Kysela <perex@perex.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
