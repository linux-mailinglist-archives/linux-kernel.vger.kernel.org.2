Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42F930CAA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbhBBS4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:56:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237855AbhBBSxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:53:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B15864FB9;
        Tue,  2 Feb 2021 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612291796;
        bh=/jlLMBZXRd8m1tO1wSDH3NcKAWYdUQXy4pcJQyZAW60=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m5xROZ705ZL8kpgLS5SQTDHRTtzTNTjdEh7tC3z0ICfer/WLdvFbh3nCkKi48JG3Q
         D5AKxvFowcJlMX/LJiCKhiCLduh0LUzO6hMVSDlxf3pS/wontZVSgr4jHMPyegPMnY
         M9E/RPZU0mZF1QbrJS3LuXA4vlhJQF8s523PvRIig0JHM4pZyN4HnRaUaIYjEvzZFG
         1p/PZE86TQa1zOsj2P2jDxVWC8/NRLfxHR37uLzojOzyNTt82MzDkukm30bPXjQkXu
         rp/TYrbiLyXKi8XXVDqhUuu63UlYOmi77a8QPAvMMOx0qifSTPiBOY8Gbvp401ZSlm
         TWY389jwaQGRA==
Received: by mail-oi1-f182.google.com with SMTP id k142so9444844oib.7;
        Tue, 02 Feb 2021 10:49:56 -0800 (PST)
X-Gm-Message-State: AOAM533Ep3kiVjkVd7dZsWdW6uLXeQFWlS+xkgd1VUVbzFGzQ3fjn1Ug
        GgRY0zQxThj4Q53+4Y3UCgdfB0e/84DeSNc5trs=
X-Google-Smtp-Source: ABdhPJwE1G9y4a4AlnQQUqGh+dqS7G6yOotjmIlhtR3aeCDZ792hv3N/TN9WB2aSEO/vsqO3+lvv01H8LHKJlxQxSFY=
X-Received: by 2002:aca:d908:: with SMTP id q8mr3611775oig.67.1612291795690;
 Tue, 02 Feb 2021 10:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20210202183646.38602-1-swboyd@chromium.org>
In-Reply-To: <20210202183646.38602-1-swboyd@chromium.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 2 Feb 2021 19:49:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3VOh+gjMHEbX8GGxEnN2eZmyNgHTOFDVP5sGxmHW40kw@mail.gmail.com>
Message-ID: <CAK8P3a3VOh+gjMHEbX8GGxEnN2eZmyNgHTOFDVP5sGxmHW40kw@mail.gmail.com>
Subject: Re: [PATCH for-next] ASoC: da7218: Drop CONFIG_OF ifdef
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 7:36 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This reverts commit a06cd8cf97a3 ("ASoC: da7218: skip of_device_id table
> when !CONFIG_OF") because we want to make of_match_device() stop using
> of_match_ptr() internally, confusing compilers and causing ifdef
> pollution.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please ack so Rob can take through DT tree.

Looks reasonable as a compile-time fix, though I'd remove the of_match_ptr()
usage as well in this case and just always reference the device id table.

Either way:

Acked-by: Arnd Bergmann <arnd@arndb.de>
