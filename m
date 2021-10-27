Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918A443D378
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbhJ0VFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbhJ0VFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:05:32 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB74C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:03:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w193so5320682oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=K1cJbfN0OSOMsbFbVCJ0EO8mI0HlFfWYSQvqTD00ru4=;
        b=e35MzeQrMXHSsSdMjyOv+zh1luLWn9GrVbs5Hb4Oy5C4QMhydNIfOOCx+V/4wuT2OA
         JpTpTEp4av9Ds5cnAqZqJVPlFqwB9A1Ib8loZUcuXgaKd/EJzTs9oikW/u8LH6DR7IdR
         hSoYLWZ60pjeAEQxTcKpMn041AieviHlkwWbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=K1cJbfN0OSOMsbFbVCJ0EO8mI0HlFfWYSQvqTD00ru4=;
        b=h+UugJQX3Iv4AmQkhSdbjTRqcJsepug+xGrYXuG0aJsf71AdUgKIjg6H9atwc3k29F
         OmW9ynMtOqxd0B9iP5k0dRiteUX4/eMtX+wao0Gs8rJ5/KAxotgESbdChH1VCiO6yG3l
         atTCSSbwTaha30MToSl6vhJyBxa03pfd02WXdFVVi7x2UeJX6FDLM5MBPFRFnoovxCry
         FHKTvDWwCSxJIsHH1MvxWMk1IgQ+pHHJMlAOHFVcFc1aaWsTStv4oXYdjTr/hNKJLjrl
         n76rcG0ChiH9PvtwOSWIkD1It2YDfWct4DHaVEhDnY1kb83Bb3EfGU4nctrQsZc+goBc
         xqYw==
X-Gm-Message-State: AOAM530y5Byf9IIECD/OOOriwjO8tOfjvb7HZn0MecBRObaQM+A61Iwp
        4luKGES432GSFDcMHPXnBQgyf7AkPp3UDt+P4cJdxw==
X-Google-Smtp-Source: ABdhPJxHw7dmKoTIvG/anG/8Dw0L4C9jo9mZ+kAZqCRF0a97PQ4X738EkYlKk/qVhI6mGSLA+AD4D7F/zXlNIYK+1ME=
X-Received: by 2002:a05:6808:23c2:: with SMTP id bq2mr5657582oib.32.1635368585748;
 Wed, 27 Oct 2021 14:03:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Oct 2021 14:03:05 -0700
MIME-Version: 1.0
In-Reply-To: <1635250764-13994-2-git-send-email-srivasam@codeaurora.org>
References: <1635250764-13994-1-git-send-email-srivasam@codeaurora.org> <1635250764-13994-2-git-send-email-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 27 Oct 2021 14:03:05 -0700
Message-ID: <CAE-0n51A80C3J6t+GeADU8e4dVJBu6JX-DmVXquWK+a9ysfyWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ASoC: qcom: soundwire: Disable soundwire rxtx cgcr
 hardware control
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-10-26 05:19:22)
> Update soundwire master rxtx cgcr register field to make clock gating control as
> software controllable.
> It is required for soundwire v1.6.0 and above for RX and TX path to work.

Why not do that when the clk driver probes?
