Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3193B351F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhFXSCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:02:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F80CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:00:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k8so8918807lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Kwj1QVd2jDusMQC8gwXFpHAaH6OWMrxw5QqC/i3GEc=;
        b=ZvlAH+2XrG33AkkWLeySsdyAhMe+zndJGCq97RXX8FNBxVn/QFKSKBS/WQDciMKoi0
         2UWwwdo2k2OpIiljEH57P/K7FzQXg5l5M+YbWDaDlFVqz985ucWewefublUs3fgJJF8X
         fLk0g9rIyzFsVOABL1tk77nnK/ENlWeLT/J/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Kwj1QVd2jDusMQC8gwXFpHAaH6OWMrxw5QqC/i3GEc=;
        b=sGlfnwocjMmQO5cgb3GGLZK6tpOuj7rHzU04FWZAJKyiLURsNbnMO1GUx06iNpxmWn
         BAGsNcK3OcsRGbNg5guLhN1AuJQlXOcScJoiwj3GxO2trdlDBUY4xbNjC0LMkoIim3Gv
         hv0m4nvUqnmdr7Q6ae0lw1mi7bNt6ycJZDGpXSQlVHxwDAWnJfNaQNO7yn3OHtpYtWkg
         R4XLPFH4vRJgXjxsj2/Z2+e1MPltRDCc1z/u0lhJp37568Iu6SRKCQiemibgYvP+MrQA
         +lnXmapyLk1avyi6iA7yMwa/tQZlye3KXe4jq9osmmtKxnUPBGv6UnMqEdAyaIlzJ+K2
         wG6w==
X-Gm-Message-State: AOAM530zBWBPg1NMM6ms+4X96WvPC79j779KRkOlSzYHC5/0+kU2s9tC
        IKjb2LCIU35LPYz5qxrGn9qMJOcVZQ352oGa
X-Google-Smtp-Source: ABdhPJz84Bn9Unk6nnSTz5rhQ8wt89M5y9db8k5hOm+bdJnc5GQXRUbbFvbccSwlD0/kXgUq/6RqJg==
X-Received: by 2002:a2e:5714:: with SMTP id l20mr4999421ljb.259.1624557628703;
        Thu, 24 Jun 2021 11:00:28 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y5sm286191lfa.148.2021.06.24.11.00.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 11:00:28 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id t17so11813911lfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:00:28 -0700 (PDT)
X-Received: by 2002:a05:6512:15a2:: with SMTP id bp34mr4614034lfb.40.1624557627041;
 Thu, 24 Jun 2021 11:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210624123251.191299-1-ulf.hansson@linaro.org>
In-Reply-To: <20210624123251.191299-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jun 2021 11:00:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
Message-ID: <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
Subject: Re: [GIT PULL] MMC fixes for v5.13-rc8
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 5:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Neil Armstrong (1):
>       mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk

Ugh. How horribly ugly.

Why is that 'host->dram_access_quirk' test _inside_ the loop, rather
than be something like

        if (host->dram_access_quirk)
                return sg_copy_to_buffer(data->sg, data->sg_len,
                                host->bounce_buf, xfer_bytes);

at the top of the function, with meson_mmc_copy_buffer() then only
handling the mmio case?

No, I don't know this code, I'm just looking at the patch and going
"that looks really ugly".

Anyway, I've pulled it, but I thought I'd voice my reaction to it..

              Linus
