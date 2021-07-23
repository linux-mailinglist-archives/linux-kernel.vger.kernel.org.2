Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25983D4343
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 01:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhGWWZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhGWWZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 18:25:26 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006BC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 16:05:58 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w10so2762030qtj.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXXHRlqkn1UKOJrEoCU/1CKsPV1IVFDrHXzP0rexpUc=;
        b=kVhKTV2jwfU3UL2TDVAx6Od2VUtF8PD0tgQKJyramFzwij7jMAQUysiBLabG1p2Llz
         Ep8C6gJX7kRzIEA1Nu3ClCym8TQf+DSjQflhNSgcme7OBA0D1izAakUn+2PFJbgt5Q4I
         IujYcYZTx1uXzWQVUaqC5JLKexzzgMlgzil4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXXHRlqkn1UKOJrEoCU/1CKsPV1IVFDrHXzP0rexpUc=;
        b=l3BnRJpUC8MCGaDT3oh47TQbiqiy5v3oeu34dq5z8hNIgM3YRZeKouXvQOZLHJw2w0
         Q/fQef99uEOUb6NfEr+bWP9Cz+vUbklWaUa8EDLfsiyHd7YnUZk54gm4VVEjxw6SldbO
         xaBvVtO/0ck1yQ50ak1VFDBdV7Mdu86vu7Dl+p45S7dKnh/u+avOijYYaehqyUmIeKqN
         Jz2jp1vEl1a7HI1mWY1oDz+AJJMc7tm+ZtQcRMPNIIT9TpZYlTk5B0flsET8A4ORPA8g
         IctDO3XMaOQm6EQg+GAapMRuUwvP+1gsSSnnBxkhacSZga8Epl4jZtyTr28zytayNlIC
         zeBw==
X-Gm-Message-State: AOAM532vhX94a2FNdZPtrTdPvBfRILuzETWjD5w2c0POdfEKBRS2e5Vw
        FQDaV4YQ+8Jlh245ZvayTTsnmrShKLhM/A==
X-Google-Smtp-Source: ABdhPJyLKo/CY+UETc1NR7hGcrKHh8O+OF/4EvoCOktzsJySrCnmlTy8fLxCB12gUSZ/pyukYr/j3A==
X-Received: by 2002:ac8:665a:: with SMTP id j26mr6066373qtp.254.1627081557215;
        Fri, 23 Jul 2021 16:05:57 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id g1sm2884022qkd.89.2021.07.23.16.05.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 16:05:56 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id g76so4717115ybf.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 16:05:56 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr9735827ybb.257.1627081555988;
 Fri, 23 Jul 2021 16:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210521134437.v2.1.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
In-Reply-To: <20210521134437.v2.1.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Jul 2021 16:05:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8xgn=ueyryFZVA-VNLEU_sk8H29D08JaEpw2Qh2OFqQ@mail.gmail.com>
Message-ID: <CAD=FV=X8xgn=ueyryFZVA-VNLEU_sk8H29D08JaEpw2Qh2OFqQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: AVS: qcom-cpr: Use nvmem_cell_read_variable_le_u32()
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael / Bjorn,

On Fri, May 21, 2021 at 1:45 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Let's delete the private function cpr_read_efuse() since it does the
> basically the same thing as the new API call
> nvmem_cell_read_variable_le_u32().
>
> Differences between the new API call and the old private function:
> * less error printing (I assume this is OK).
> * will give an error if the value doesn't fit in 32-bits (the old code
>   would have truncated silently).
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I haven't done any more than compile-test this. Mostly I'm just
> writing this patch because it helped provide inspiration for the
> general API function.
>
> Changes in v2:
> - Resending v1 as a singleton patch; dependency is merged in mainline.
>
>  drivers/soc/qcom/cpr.c | 43 +++++-------------------------------------
>  1 file changed, 5 insertions(+), 38 deletions(-)

Are either of you interested in landing this? I guess Rafael landed
most of the recent changes to this driver, but it used to be under the
'power' directory. Now that it's under 'drivers/soc/qcom' maybe it
should go through Bjorn's tree?

-Doug
