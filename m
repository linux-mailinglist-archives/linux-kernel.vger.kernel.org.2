Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D593BF2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 02:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhGHAYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 20:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGHAYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 20:24:14 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FEFC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 17:21:33 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so4133181ota.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4Jcoi/05Elu+fjtRGsBy67bn+XnaWnaiX33y57x5HyU=;
        b=LJ/AaTjnptRLUW7CzFFdWX5BhvP80VTDIH3AaF6G4I9qFjmvr/2KfE8Vg+C50eaaMq
         7YJr2OOr46Hd2NJ1J0WWWRd7p463OjFl5lobQl5SCifALPPlPQlexEK0axo6uMr6qG0q
         n8JHZXsiZ0h5qNabNJfhjC6kWrPBmVMDMV6ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4Jcoi/05Elu+fjtRGsBy67bn+XnaWnaiX33y57x5HyU=;
        b=VvMfgHdoiRvuG1CvmTDOx79G8yVhz1VyAStrA8VBO6pqZp3cg7nHm1KJ7X/lgrKQmc
         3nvclcoEXxnEGKjOF/BO+3HQSTwqjip6djEno8TDJ7fZdv/Wb4HuZeA7b/aA7VWuEAmW
         0kd7jL9FWEPAaZ1LIYnrmO2R7FmJUOu4H2gS7ZFc8lUkRUnAQXlorwc/FllOd3wLcGwO
         DIdnP5ObQwk0yZiGY9wf1l4+SCkuohFoVq1x9qqBg7NIFHG5tKm+6lMgIIwDbZ2N+g2k
         8JvZ3rqA0cX2E+Lx99WIEoE4FRa42oCV+7MXYkmP4DB63j+cLPohgeycoiHzHqb1nmf3
         DUSA==
X-Gm-Message-State: AOAM532Yf+2ueHnE8v0oCPcnVFS4PTE0D2VDTsaB67R/Hxv+IqnEXhRF
        858EM0EBpZv4nRe68i5PmmJdIB40jAC1gw2ej2SU0g==
X-Google-Smtp-Source: ABdhPJxkZSDT3o7+bfi83Znt0P+srvdSMLyyBxjSz6HK12eJFcI+NWnaXAGie57cQXIy8dzSEbgbgbsiYK9wRxWQ6eo=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr21941770otf.25.1625703693006;
 Wed, 07 Jul 2021 17:21:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jul 2021 00:21:32 +0000
MIME-Version: 1.0
In-Reply-To: <20210703005416.2668319-2-bjorn.andersson@linaro.org>
References: <20210703005416.2668319-1-bjorn.andersson@linaro.org> <20210703005416.2668319-2-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 8 Jul 2021 00:21:32 +0000
Message-ID: <CAE-0n50EvG4qV0n+Ag+dvFxKKasnUzwH=MA+f-jsgDdBqaqziQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: rpmhpd: Use corner in power_off
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-07-02 17:54:15)
> rpmhpd_aggregate_corner() takes a corner as parameter, but in
> rpmhpd_power_off() the code requests the level of the first corner
> instead.
>
> In all (known) current cases the first corner has level 0, so this
> change should be a nop, but in case that there's a power domain with a
> non-zero lowest level this makes sure that rpmhpd_power_off() actually
> requests the lowest level - which is the closest to "power off" we can
> get.
>
> While touching the code, also skip the unnecessary zero-initialization
> of "ret".
>
> Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

I think this is why qcom folks talk about "virtual corner" and "physical
corner" because there's the one in command DB and the one in hardware.
Maybe we should change rpmhpd_aggregate_corner() to call the argument
'vcorner'? Unfortunately we can't really build a type system here to
make this problem easy to catch with a mismatched type, unless there's
some sort of typedef trick we can play?

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
