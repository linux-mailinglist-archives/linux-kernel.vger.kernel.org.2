Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07803A1C71
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhFISEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhFISEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:04:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C945C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 11:02:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i10so39408750lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sjr2x+avzINzu41z2ipzcr/zElxxwTl5mt/86GvuO78=;
        b=i+6g1jQB4G2I8N1Psk2Uguv/3DnsRkHyH2COQDi8WIm5rw3QqbG1t7f91qnPIrJ61k
         8d4uJ/OVBoVJakaavCDeca+COmudX04UoRSTX8G9aic3eLRTffz7K8k/SsBEjftOq/b8
         9Nc/+g6yI/TvZgkE/HQ8st3ZJB+uqKl9jhHdce9X19w5VECIV2P8Hg4cqkMrUAnbIdz9
         XMiIhhKaQJYHk6QVX8WPUirAntUxkSktHCFzyV61HOt9cCtuIYq5T90PzOpTMBwytRIV
         VXjdmRm5Q4fIUbft6zRPNE1kZ41sir2rpclsgdLZIWtfVjgEc95oY6IPEOI0pp/1Pwcb
         7ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sjr2x+avzINzu41z2ipzcr/zElxxwTl5mt/86GvuO78=;
        b=KB8aVeDSNduljWUTTX1/6YkhXhgs4qKOtkAvLvb2jvHFWewrHCSL2thnzzziO/YXIu
         gE64M3SqdUsjS2vOXV4JsHoDDCgYTlOayjkVI0fIEV2T14SlidBLyM+o+hdIMkK4/1H7
         6UwIPYbvhvpAedPMmMA8pAnphbdmymQyIgWJ1zAGjJVisScyfTRQs3J6iTqj8398mvtb
         8Axad4OAS6yIZvKFr2I9fKR4h9GEPskRoVkOQv++V2nEu8K+XHkrmoa8scc1EG0jDfDY
         M7WViZeLT2ImJfJK4QQWqhIIaSdQhUlOcSZ9gDsbuF0O8oMLQP7zC7YlIMULAo8y/1ET
         ZX2w==
X-Gm-Message-State: AOAM531uZMLDur+XTy7NPVkKTYa/R9IFJj6GxBCSoVFid3yBQWr+ohF/
        X3Sy21BvoybXFoltGHn0bHUxg0QdIoxGKd0rlFPG9g==
X-Google-Smtp-Source: ABdhPJySrcjcAUzZkp1/bIfsjno1M0a1RGJL9KK+8///E7oqYecOg/XM5cnysq07ieE+gaXp1D7RbznYFzRjzVTqGYc=
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr424530lfb.297.1623261736345;
 Wed, 09 Jun 2021 11:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Jun 2021 11:02:05 -0700
Message-ID: <CAKwvOdmBmsvmkm3LNXgvkaa=u1WYkJMvcALMAuhFFFNbfov3YA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 12:22 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in devfreq_cooling.c comment to remove a
> warning found by kernel-doc.
>
> drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
> devfreq_cooling_em_register_power(). Prototype was for
> devfreq_cooling_em_register() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I'm ok with leaving my reviewed by on _this_ patch because it's so simple but...

In general, when sending a follow up version of a patch, it's _not_ ok
to add a reviewed by tag when a reviewer has not explicitly responded
with "Reviewed-by: ...".  That provides a false sense that a patch has
been thoroughly reviewed.  Responding to a patch does not constitute a
"Reviewed-by:" tag.

And I might be fine with _this_ patch, but that says nothing about
Nathan, whom you've also falsely attributed a reviewed by tag here.

For such a trivial patch, it's not a big deal, but in the future
please do not do that again.  It's ok to send v2, v3, etc, but wait
for reviewers to explicitly state such reviewed by tag. The maintainer
will collect those responses (and can be done so in an automated
fashion via a tool like b4 (https://pypi.org/project/b4/)) when
applying patches.

> ---
>
> Change in v2:
> --replaced s/clang(make W=1 LLVM=1)/kernel-doc/ in commit.
> https://lore.kernel.org/patchwork/patch/1442639/
>
>  drivers/thermal/devfreq_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 3a788ac..5a86cff 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
>  EXPORT_SYMBOL_GPL(devfreq_cooling_register);
>
>  /**
> - * devfreq_cooling_em_register_power() - Register devfreq cooling device with
> + * devfreq_cooling_em_register() - Register devfreq cooling device with
>   *             power information and automatically register Energy Model (EM)
>   * @df:                Pointer to devfreq device.
>   * @dfc_power: Pointer to devfreq_cooling_power.
> --
> 1.8.3.1
>


-- 
Thanks,
~Nick Desaulniers
