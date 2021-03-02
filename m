Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1632A0CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576624AbhCBEbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:31:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349111AbhCBCLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:11:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCC5361606;
        Tue,  2 Mar 2021 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614651066;
        bh=vwyUtDxwiNKk+ynoP3q+QLEEjbm/rJVYSWUVbdibiKU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rbKRB3kUrCgw5NeYHrpMgzimtGvCrWXkFsibJcBZjZ3NlolKoBurfLrbqEpwKjUg1
         R3kpc1bIDqVJCviwFqlDOItVDd9kydfT5xsVQkEk0lc2lrLKY+p1xjm8ZFzxe+eTRP
         Q6n4HpeWZb3ItmmT8bFNC92yxnAz55rcqxeuSqg/nQNGwuDbPBEkcXADYJjBS1GNDT
         WQUGO3AvpyeOexLYUTAqM5PzsT5mp9XBYjZj0ObV82NVE0m4hnm8OrBBTwrHwanDYW
         /BswQDCK3RgIBmWJkcrl7+5LM6xY7GGGfOiGwmtt84AF6Y9bizxyBs4Dle8/ap/xJd
         aMqiGN5Thv79w==
Received: by mail-ed1-f41.google.com with SMTP id p1so18849298edy.2;
        Mon, 01 Mar 2021 18:11:05 -0800 (PST)
X-Gm-Message-State: AOAM533mlzcgJYA5ZR/5ktUZR6kMBX24dJrifFDEyFC3vOTQAaMofQJE
        9hCzB1OZTAi65tdV69rlKXXQnm66u9x+SrDh3Q==
X-Google-Smtp-Source: ABdhPJyWebOHWQP7njU4m2dvQglQXnk4r5eZJ4pcMx2WhPXBWc0SlmoYi4n8+GWICYKhfnpGtYXlrCdIRZMY5g5sG20=
X-Received: by 2002:aa7:c991:: with SMTP id c17mr18868381edt.165.1614651064202;
 Mon, 01 Mar 2021 18:11:04 -0800 (PST)
MIME-Version: 1.0
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com> <1614276364-13655-4-git-send-email-spujar@nvidia.com>
In-Reply-To: <1614276364-13655-4-git-send-email-spujar@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 1 Mar 2021 20:10:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
Message-ID: <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] ASoC: audio-graph-card: Add bindings for sysclk
 and pll
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:06 PM Sameer Pujar <spujar@nvidia.com> wrote:
>
> ASoC core provides callbacks snd_soc_dai_set_sysclk() and
> snd_soc_dai_set_pll() for system clock (sysclk) and pll configurations
> respectively. Add bindings for flexible sysclk or pll configurations
> which can be driven from CPU/Codec DAI or endpoint subnode from DT.
> This in turn helps to avoid hard codings in driver and makes it more
> generic.
>
> Also add system-clock related bindings, "system-clock-direction-out"
> and "system-clock-frequency", which are already supported.

This all looks like duplication of what the clock binding can provide.
We don't need 2 ways to describe clocks in DT.

Rob
