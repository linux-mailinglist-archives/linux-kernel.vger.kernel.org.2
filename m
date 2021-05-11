Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE03637A540
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhEKK6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhEKK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:58:10 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D701C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:57:04 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id l4so3120695vsa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tA+HAj6QjGovtvKkDp5UEFTnS03+4SaXJZVE3yBy0+Q=;
        b=TRDVbvStO/BYnkUY5L6aYpOhwVAt6wSGzK1bWb2x7l2/W04h0NPUNsu9XVYRMq3Pyb
         qd+VP8/EXXMqmP+3v9JTl2/vbNenW+CS/KQCILQPinUR7DeM9WUSxTaCVqe4ShwWsAIE
         wBYrY0tsc4xc2cBc4RWhurIqjxe8W/FeUEL02EGAGej8BJ4R7IqUpzbKJovS8Al3hAXG
         EJlZa3EiHAo3J+wtHHY4FCf1C05fikwff60royOLNsGOV8mEY+/w9Y/DX9h9WtgM6Ab1
         xn2y9KmzMZrwOug+Hv5ApqJXWRcVvrvsmIKkkeEwnxUhg+z6Z5k6jtw/z1L/SXDBI7uX
         iIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tA+HAj6QjGovtvKkDp5UEFTnS03+4SaXJZVE3yBy0+Q=;
        b=V2XoJWaVeLWBWuAMNgrzqi3BkrMIyhMtLt17ExY3vt1evqw98hBqdEFh7oA/J2ScSp
         K/CvJcIL48pf3vOSHUd4OxDafVPfyH6ZPcrIfzHrhiKHOXEgm4PNDYZCMWOjvDCXamFr
         Q9jtq5U2I+CvWgkqIOrah8+KYxThQJAmLsU3cMdSHTgwnan5SfQ7o1vLICrqdDs+kTbm
         auLpkiX545QqK2gvuVygOxt6v7XFagTxJ9qZowQn9T1t9VhoCD/0qYm3XNfH3ALTM0PK
         Eb+qnChhesHG0BR5Drcjw0AWF9koo/cTbVdnvKIhA6sMcu9mATdAW3znRnB8uz95z3I9
         yedg==
X-Gm-Message-State: AOAM532l1DcUqhiNPqUVGvhAetowoaoYkthtvnAXdVFAEfUsja5ctgUi
        T1pHz4xu0bLwrwyD5lmd0SZq3fH6aehHmn4FuxnWog==
X-Google-Smtp-Source: ABdhPJxIK432HCCqtYPspg3aw0lFVqAOvyEvGMv+UPQM5Q80nhjr1o3QqNVF2Tfe5H9pT3oBNGpd4dJvOH6zBNN55ck=
X-Received: by 2002:a05:6102:505:: with SMTP id l5mr20494538vsa.55.1620730623680;
 Tue, 11 May 2021 03:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210428230500.19214-1-s-anna@ti.com>
In-Reply-To: <20210428230500.19214-1-s-anna@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:24 +0200
Message-ID: <CAPDyKFpTdAfRJ2h+VW=qbFeWNygSxzjv+6nebWsxT4+zxYziMA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Remove duplicate ti,j721e-sdhci-4bit
To:     Suman Anna <s-anna@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 at 01:05, Suman Anna <s-anna@ti.com> wrote:
>
> The commit 7c7905df68c5 ("dt-bindings: mmc: sdhci-am654: fix compatible
> for j7200") switched the compatible property from a regular enum to an
> more appropriate combinatorial oneOf convention, and in the process has
> introduced a duplicate ti,j721e-sdhci-4bit.
>
> This generated the following warning on J721E boards that use the
> ti,j721e-sdhci-4bit for two nodes:
>  "mmc@4fb0000: compatible: More than one condition true in oneOf schema"
>  "mmc@4f98000: compatible: More than one condition true in oneOf schema"
>
> Remove the duplicate to fix this.
>
> Fixes: 7c7905df68c5 ("dt-bindings: mmc: sdhci-am654: fix compatible for j7200")
> Signed-off-by: Suman Anna <s-anna@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Hi Ulf,
>
> The warning is a bit more verbose, I have minimized the log in above
> commit message. You can see the issue with dtbs_check on both latest
> master and linux-next using DT_SCHEMA_FILES.
>
> regards
> Suman
>
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 3a79e39253d2..29399e88ac53 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -19,7 +19,6 @@ properties:
>        - const: ti,am654-sdhci-5.1
>        - const: ti,j721e-sdhci-8bit
>        - const: ti,j721e-sdhci-4bit
> -      - const: ti,j721e-sdhci-4bit
>        - const: ti,am64-sdhci-8bit
>        - const: ti,am64-sdhci-4bit
>        - items:
> --
> 2.30.1
>
