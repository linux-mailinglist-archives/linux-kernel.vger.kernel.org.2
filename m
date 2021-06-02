Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C50A39832A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFBHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhFBHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:40:22 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 00:38:40 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id m23so759706uao.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+TTh5KqzQy7Y+EAoFlysDwIssfmwwnP8VJI5NXEb/8=;
        b=ui0SAsqvnSKtekZ5xaMzh11I/7tb6Y8cTj9gTGMe0c2ln73DXlIhrzNtUOa+1vynrg
         /cmEUeDyzFYRMqdDbOO2EQjxLgQq3Gb9eW376DtmojBSYF9o3PleaIq4+f6J5P8CXTQ5
         EjEpZfGq6VXaMFeHwTcLGBTwWyrUpenqTZzmX+TYRPp23PnzakSnJZ+Ay7YUp/oPF5Pv
         o/7jLjZb6EF4Miy//21ONjkRZgV8xLVr8RQOlWoh4/1d9g0/Fhy2ESTiEHyn3Q59VGVy
         h1eNVx8WS4qLUopqJDSO6fVMGnD38ZAgoyRedhLkHJmKSfPmdTrXplCUxjHLI6RVKv+C
         xf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+TTh5KqzQy7Y+EAoFlysDwIssfmwwnP8VJI5NXEb/8=;
        b=IZXz50Qn/O/0sm5aVR8vkiTF8Ipm8GkPGdNzP6rMm8+fM5ejFEaWIioUoEaIYEyxHS
         ep4p8ijyhbH8x4YvNH7C3thTwmfK7pBTvHU+xb/cb9d4aPAGV1C1bGoMOvFDSoLYeumx
         qmHbibJuEplqlUjr6fm3y4STdJK7yfUfjN969Q+urBg/J5cTv12YLOoBfin9UWdai4+c
         3pYzDzbe3IgoUHoXUhvyKbIK21Tiw70H32LNV6QC3dbSOFoX+bgE3/6pWxjfwemUSe/M
         q7RYtvS8KEwB8aMkLDAgoOrF3u3s0en3kYhxSO2qkNBXh3OpBzuo8yRPh6qCnSiFy56z
         IOMQ==
X-Gm-Message-State: AOAM530+1/IQTu6gU2J08vphJCxXaN8pdJ53RvrQLiyA6e2IiNIe1Tuz
        GVwzcBJ2aJVznUN9RP7Wp8zak9mYCtS7CtF41aq8zQ==
X-Google-Smtp-Source: ABdhPJzyd7BJ2tG/pzaTds/WFODrDilZ8jvrif516usWWpuQ3h/Tm2Vr5Wt8EbH3eFPPfqiJWc+o7XOTCEPsPWLEuEk=
X-Received: by 2002:ab0:100f:: with SMTP id f15mr20386864uab.100.1622619518153;
 Wed, 02 Jun 2021 00:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210601231003.9845-1-digetx@gmail.com>
In-Reply-To: <20210601231003.9845-1-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Jun 2021 09:38:01 +0200
Message-ID: <CAPDyKFpMCkp5tHHcZJZf6sC4+C_xGGnhUWJg5+6hHbDT8FD_Bg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] NVIDIA Tegra core power domain follow up
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 at 01:10, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Remove the lockdep_set_class(), which Ulf Hansson asked for. And
> prevent core domain syncing if domain node is missing in device-tree,
> which I accidentally missed to add after squashing the standalone
> domain driver into the PMC driver.
>
> Dmitry Osipenko (2):
>   soc/tegra: pmc: Don't sync core domain if it's missing in device-tree
>   soc/tegra: pmc: Remove usage of lockdep_set_class()
>
>  drivers/soc/tegra/pmc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
