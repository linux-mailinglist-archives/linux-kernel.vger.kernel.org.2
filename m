Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7DC3777F8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 20:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhEISuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhEISuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 14:50:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F37C061574
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 11:49:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y9so18066639ljn.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMJvx5UVUSxWfxal6KmjDPL7AuvEAZJvWWHWo4hAYoo=;
        b=bPH0qO6fe7UoMIwaSSiLTVdTGdPG8Qq8pmPecFEYO8u1EtSnnoARg6IFh6TVjnG/Vo
         UC5kiD2S1FB4SSVHancR/Tfbn/4BeP3rSWIISAwLDVfdLqRQA7GTPIqyR8jxsSXN2Mef
         oCHy7ib2z0Qp+RHR5IddW0zG4FmRCKD5z4EpHMzBxJxorsnBM0TlNUrS3ivW3v/NK7HI
         cMJjc9HJVbyRAERobvQGpHiMPceqBR9f7EnwPXCffob0sYc+71UsYcKHNjy0zuUJY87c
         J3Lq6ROvTJTrRs9E39ivSzG41oN5IkLRB2gGD0FvuU4kVcok43gCxNWOcCfoI41sfgZN
         5pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMJvx5UVUSxWfxal6KmjDPL7AuvEAZJvWWHWo4hAYoo=;
        b=IuAgo30MUFYfmOivW7/vbAu1JZj19u/Vf2waj0vsDeEVhmtkbGL0hi8Fl7+o4lb2F8
         wo/ALNg14ROS6C4TaViYSgXJiSPGhEFYk4eZPMapVVQhqipqLZYTlDf8ZPL19A4Dycr0
         9OTyylutC/vE96jrBwBu/X+4/TGwuULaSI0jVk3DhqBvHPdz98j2hK+56wBvP9z7rIXq
         TOk+67FVDmhP5ViOyVpi78zRCZQFIQO3Qq2C/81WHnrHzrTNZ90rpacggb/fnYamN3Gg
         o7HJdPVcBm+ul1uIfxxsnL7s5vUQspibSbghqnRXqNS6FSyyGT7X9woJ9ti0bJ3qN4U4
         6uoQ==
X-Gm-Message-State: AOAM53134RIm/2YcQo+E0JxYq9arc/zJZm2fH1DFeziVf5uKueRQGf7R
        S+oXID1GT6Zuh3TTG8Ey4o6v1MJLMmtfoQmpPD13QA==
X-Google-Smtp-Source: ABdhPJxFikBt8NEEjavRogVdk7f3yUsdtfJw1Nh5UYxdACqLuIxR2l2Nd4M9r0XGfUMWcsApRPZBl27Zb1VaeLEWIbQ=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr17146118lju.200.1620586146550;
 Sun, 09 May 2021 11:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210506145829.198823-1-ulf.hansson@linaro.org> <20210506145829.198823-2-ulf.hansson@linaro.org>
In-Reply-To: <20210506145829.198823-2-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 May 2021 20:48:54 +0200
Message-ID: <CACRpkdYjwGA+kOdBAg3Yc2VdZ5rPEHNe5PdDSxwBDwd9Y02mWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: Move eMMC cache flushing to a new bus_ops callback
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 4:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> To prepare to add internal cache management for SD cards, let's start by
> moving the eMMC specific code into a new ->flush_cache() bus_ops callback.
>
> In this way, it becomes straight forward to add the SD specific parts,
> as subsequent changes are about to show.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
