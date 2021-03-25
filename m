Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B13493F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhCYO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhCYO0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:26:19 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CCC061760
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:26:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z25so3389453lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwetcsVKboaaGI7NOXNHnyGvYuGd+RB0dddZvR4dJYk=;
        b=HnLlDdBGzEt/TgWGyKUmPogRtz8oZQVM03CogodEU/UwYa+YsG6vZA7EP9aRbbnP4f
         E5yi95rKRs907JDF6G/+3OYef1fTAFAP1+qBFhSW7mzeyVUJL237u2l7LBm2jZ3H+/2l
         d9hQZeA5U3EiqJ6rDsZ9HdQy4Eh1gp92TIuRu+KPXd8ctc0e1g7GvTHGTX5c1pufvpKW
         u6NNHIZ6ohMKcDirddqaRBk8zLyijioUnrVIobCFccwipmEmlL0rDZeA1PgAiSlA8cGr
         Y9D1i8QPt2nrKY4y7L1y+ExWE3cSuS2hRVSBmseu/TONVYtDkiMOz9tyz6uNUuWt4yQn
         iukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwetcsVKboaaGI7NOXNHnyGvYuGd+RB0dddZvR4dJYk=;
        b=q8e/sOtbPsZP3hUAIdyBMVQ7aU3PmiJJzPnLvrEBdwp6slq26tiGKlm6B5+C4Nr6N3
         VRlF9Z45zMqAvXQGHfmConYxrDo3rhujEZcTU9JELIwBZKhi+Ye+9Bmria0JgX9S74NQ
         bI8DdFa30QvhgK9C70AKRApxJ6/JKUsIZwhZyzauSX+hq/HPyN/fKlf3cJLjhHLdRFN2
         qVyR2cVqP0YfosvAb4kH/tvYMg+eTxLOhPNVTZKMKvYICONtK7dEXOcl7maX/EbyTeni
         BMF1r9/c1wsoO7FJ0d0w5mIq9I+2CzZnVfpY5kkg4tlbO8ljRPqYS1nj6ke1z9HS9Dyz
         fb+g==
X-Gm-Message-State: AOAM533rBvEdNeeiJ5t1iCQS4DTiFFmMUvQkf1QUTnJqXQKbtAvoCDLR
        67gqM0lpIW6UI82/Rez/M4Cn7lZMHDC+AtQdM5dFBg==
X-Google-Smtp-Source: ABdhPJwXghMxC+jJkN24Dc68V+VPVcQEjT4VLmT55y6SQ+X6rU7+oMMn50hB89bI9yQv19zi6WlDqbz5VNk4XxOb0gA=
X-Received: by 2002:a05:651c:103a:: with SMTP id w26mr5808808ljm.273.1616682376700;
 Thu, 25 Mar 2021 07:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210323131728.2702789-1-arnd@kernel.org>
In-Reply-To: <20210323131728.2702789-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 15:26:05 +0100
Message-ID: <CACRpkdYS9JVnbdW_+_Qi9ujA8j9p-1r7c1UeeKToukQffN1u5w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: fix unintentional string concatenation
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeevan Shriram <jshriram@codeaurora.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> clang is clearly correct to point out a typo in a silly
> array of strings:
>
> drivers/pinctrl/qcom/pinctrl-sdx55.c:426:61: error: suspicious concatenation of string literals in an array initialization; did you mean to separate the elements with a comma? [-Werror,-Wstring-concatenation]
>         "gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19" "gpio20", "gpio21", "gpio22",
>                                                                    ^
> Add the missing comma that must have accidentally been removed.
>
> Fixes: ac43c44a7a37 ("pinctrl: qcom: Add SDX55 pincontrol driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
