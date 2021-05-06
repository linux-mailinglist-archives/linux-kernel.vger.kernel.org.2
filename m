Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7F375441
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhEFM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhEFM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:58:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47303C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:57:21 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w15so6895180ljo.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9tWSVGqAxyrmuhU0qEueft/17Ve4hq5jQObsYsqKAo=;
        b=kDtQg2xdKGkWOf0VeyihTIH8uqxMlaYNjyGMUGrtha6n1HTfjcr8AzrA0yAwBaJk65
         tj2MF4ZHSAKqplZKiv1MnEkn49gLYQOwBvbwHIe3762SW3NODwUlqxgVS9mvXY2tzCSx
         Caex0Q17aEZWe65Wf69eLMsbY8pkM6FwNlRbuXZDqz4tJy39IXhQ8ucLS0hkbAEG7/lZ
         4X3+zxj3+Mgd58oIwRsoflsZGmZkfJ3LXXTmax8mke3qVjuqvpaOoBCjRzxVSvbuySs9
         kujqmiUUv9s3mPhxlPXQgaWFBX7A6pL/OXi0XPYZj+QWzuBlCNeNN9Mvh9L1D+0ZYqaj
         yBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9tWSVGqAxyrmuhU0qEueft/17Ve4hq5jQObsYsqKAo=;
        b=dD4AECXe/yaDtv2aKWntZvfPYtKN/HHIkkbykm40uD8iMxzX36mkrWdr1+AoKHH7BM
         ogl87xXngi2btmGbMs8vMm+iYz9JB/zqQoUTB6k4Ic8rRgJcNcZVGWnfZlJineyzgAGF
         ISl60DPg4k8J8VwbUS4GXyUMK+oANK5IAA1c6i2HpAW1CAM0nWcSRzHmgwhLNqMWja97
         3tAuBVLHB+wVpN7QNIhTpjOXM96nxfEjm42UVqQRL2tQlqbyBDCFURy/TiEhAZNESksw
         GqhKX44wAcfV+w9uF7d4vjV84BrPcOwlZvxhe0VXfIobfj49RYdS+iCCG5VsEFocibbh
         vIPg==
X-Gm-Message-State: AOAM5308MjsTNykxzlmGTpy25J6ORJ+FpE5YfT4XpNpZZCxDv5H2f9CA
        vE39snaE4tVDB6hSa5QDFqwQpLnrYlbcp3JVStqCcQ==
X-Google-Smtp-Source: ABdhPJzRLocly4lInuLR47A3QjZv308cEaSCErmH7JGkDvbfFfBa8Bfssy1vMvOkZRrd7PWcrDEoc5Xv1VfahSzp81E=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr3396554ljg.74.1620305839834;
 Thu, 06 May 2021 05:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-8-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-8-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:57:08 +0200
Message-ID: <CACRpkdYVqA35th9a4j6CTcOE2A16jamrWiOOQitEbz0iXq=7HQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] mmc: core: Drop open coding in mmc_sd_switch()
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

> The SD_SWITCH (CMD6) is an ADTC type of command with an R1 response, which
> can be sent by using the mmc_send_adtc_data(). Let's do that and drop the
> open coding in mmc_sd_switch().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
