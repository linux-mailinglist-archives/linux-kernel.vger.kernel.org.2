Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C073DC103
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhG3WU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhG3WUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:20:54 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40BEC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:20:48 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k7so10886964qki.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/ut0W8QWQzgc3+TFp0Zpab3f8ktnZebi671B/GRa1s=;
        b=MyagQMiCCsM3Rrn6I1WUv92/Bb4Hoxpt54pGqOpfWtDctdM1tQkL6ciLcbY6UdDKg+
         CHPIMI68YD94tESmrEfcGANjj5Cl0XwRrXRcwNL9k1ZbXaHmbVZH7THGiL7zV/RxUQ1c
         g511pq+mPaWbOHjDMSUZoOWqY8Uja0Hq1ANig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/ut0W8QWQzgc3+TFp0Zpab3f8ktnZebi671B/GRa1s=;
        b=msJ1ejttT3+T3W3Sn6q3jDZIEgWBMyAk1lsHN6KaDCyh7TgE/HlG35+fBUSpmi0TfJ
         ysg4PF9LgRQkla93LKI8B1E6IbiQt2wVC5N/grLWKX9kIH6V4sQFnNq6RHRclK4TXSkr
         phIA74qrK8cGCIuJ9Ats/1yR2tzu5A8rn3z0lOmNRwg3p2KI132p65SPtKkDmmfomvxA
         JJYWWXiEn5QE+74p5URFW19VOr/YmF13CAGUdfyns3lB2ceVE88kVk7ca/JOgpO6ZotS
         mlIU7zZJTnwetq3px9eUW00xyyDDJEpeto0hLrSrCimMvdkMK+oOMPugAKYgKX3zKIhE
         dBSQ==
X-Gm-Message-State: AOAM530CBL5MEvd7CP06ZiLqNXzmrSLWFJsMRQm9sxLstWHDSTJZijUI
        XKpfROngW8UZNoxAM4cGwm6yi75CvrFcGg==
X-Google-Smtp-Source: ABdhPJwBUYhtrEn3zSQwhiJLkHY29TP1fFG8Y97WcTMrZIYaeHzdgfz/kdoOCsf/XvGAmYzHPV4qZQ==
X-Received: by 2002:a05:620a:64c:: with SMTP id a12mr249265qka.377.1627683647690;
        Fri, 30 Jul 2021 15:20:47 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id k15sm1653430qko.84.2021.07.30.15.20.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 15:20:46 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id z18so3506281ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:20:46 -0700 (PDT)
X-Received: by 2002:a25:2904:: with SMTP id p4mr6090679ybp.276.1627683645881;
 Fri, 30 Jul 2021 15:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <1620807083-5451-1-git-send-email-sibis@codeaurora.org> <1620807083-5451-3-git-send-email-sibis@codeaurora.org>
In-Reply-To: <1620807083-5451-3-git-send-email-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jul 2021 15:20:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VfvW1PqJiR7Lh5RNyR6EQ1E8JK0N+KqJiB8DK49oUZ4A@mail.gmail.com>
Message-ID: <CAD=FV=VfvW1PqJiR7Lh5RNyR6EQ1E8JK0N+KqJiB8DK49oUZ4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 12, 2021 at 1:11 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 SoCs.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>
> V3:
>  * Rename cpu opp table nodes [Matthias]
>  * Rename opp phandles [Doug]
>
> Depends on the following patch series:
> L3 Provider Support: https://lore.kernel.org/lkml/1618556290-28303-1-git-send-email-okukatla@codeaurora.org/
> CPUfreq Support: https://lore.kernel.org/lkml/1618020280-5470-2-git-send-email-tdas@codeaurora.org/
> RPMH Provider Support: https://lore.kernel.org/lkml/1619517059-12109-1-git-send-email-okukatla@codeaurora.org/
>
> It also depends on L3 and cpufreq dt nodes from the ^^ series to not have
> overlapping memory regions.
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 215 +++++++++++++++++++++++++++++++++++
>  1 file changed, 215 insertions(+)

I see patch #1 in mainline now. Does that mean it's time to land patch
#2 in the Qualcomm tree now? ...or maybe it needs to be re-posted?

-Doug
