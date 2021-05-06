Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2545375424
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhEFMxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhEFMxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:53:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA4C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:52:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w15so6877660ljo.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ODncCv4DxI3Aq/ODkooiUAAKTXprJtoPbmftQgkLcc=;
        b=ZwxR28RuhkC7/43o1A1wHz6J9an0Ie2tKCtYJ8PNtPG0jl9HXqBS6RKpeFVJRCLU/S
         1I3htBcOGHdgpezUSrFlnzjjjIy8QywJQZDmwWZ6uglJxOSyPPNj+qzmkCeqcESLFzGm
         UrSCoQ1dWisvgzl+KLVSHYOq446woRuc53hgfSpJwR0Odo9/QEEP7de/tfWFfZAuX2Ii
         Z8uXuYdtaLGq+MoAerRv1/Gugm0LB80cgnlO+NCvjSV/ObsQ0fbk77k+Wyaaw3v/QeE4
         b2BSH1eWKiPq4Ee8y2TqYruqDgaXqPtLX825/NmgxyeiAyCLFsX7RXwhU3CWfM3bkmB1
         c4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ODncCv4DxI3Aq/ODkooiUAAKTXprJtoPbmftQgkLcc=;
        b=BAMLvn4w5rOnUKn0r130kbupiON9qWfI8lA5aMpF1atygULNdvc9h1Ut6Io7qKpHCm
         sgR7Fe0h2FpiFkt/kcDo859iqU+3FupnREaePL1tNBB6pxMxiimbysAly74B3gUatt0+
         ruGq4g4jNsp7MvnGK9dgaZU1Nx9OdPn5g59Lk2MBE06KlAXmWYj013fPK30ybgHVlZ0W
         yTFFZKWE2DZcebnzh+UaM3XKyH4dGO9N2ebrS7esYk3wktUII812CnuxkQr3Y1yfblCZ
         2qBvIlpGn192dGHU2O5+fhvSNKT0YxbjOB6euZTWzt49n30ilr2NBflV/qEhSKXWYEpI
         7DKw==
X-Gm-Message-State: AOAM53046DuX5rxfXuiNg69b5QebHfCrj2Bhf7EKKaigZTRy9xGeUXJS
        dX8/j4gvdXxATf9F1S8FpJ8wakJHcjplwQzTY0tZFQ==
X-Google-Smtp-Source: ABdhPJygGY4usiqBZQDVEXG3fwiyD+vj4s7NE1eKJr/9nYwn9ZurB0Ua8qc/N3VK7O/hDVMeWZIisrVzAoIWqSMkJo0=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr3151869lji.438.1620305566928;
 Thu, 06 May 2021 05:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-4-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-4-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:52:35 +0200
Message-ID: <CACRpkdZfnbnD5uBT+K9bEo+cEEZWWnLuTO6K6O-CiTVL_S4s6w@mail.gmail.com>
Subject: Re: [PATCH 03/11] mmc: core: Re-structure some code in __mmc_poll_for_busy()
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

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> To make the code a bit more understandable, let's move the check about
> whether polling is allowed or not, out to the caller instead. In this way,
> we can also drop the send_status in-parameter, so let's do that.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
