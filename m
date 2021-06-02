Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327D4397D70
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 02:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhFBAFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 20:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhFBAFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 20:05:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6647C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 17:03:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g17so591872qtk.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 17:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wllkZ5VTRKXKgdK5L5Cgnkwqi9EJFNskFbDefsSBlM0=;
        b=QJR1j66iTgeWmuq4lZx1g+UpoySLqtwPkOKpoafsSJWcYACicFUqsc1gB7FVOGKh/S
         XBOL9ncyfo38z72T4ZU7NgDE7MSv3cmFMn2ZV6lvr1+sFTz2xPrc+OwtoFqB95AYdwGv
         ApJYDcKYhnn1iDA87HLiuk+Z+AgxoevJisrko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wllkZ5VTRKXKgdK5L5Cgnkwqi9EJFNskFbDefsSBlM0=;
        b=WS/DdUM4KoLUwvjrXmiwSr+UpzxTP1Kmprm1Wj7EOvdMmTz43aD/0vt7lLJrG23Faa
         WdqC1Drbu7cgdhTQ1LEAcku4jGbd6/LLA4XmsrSI9ZPx1HZUepW/5q9RjlzjUcfJ9Gj6
         JjHVKV6rdRNkGr23baIBmBdX9RMUonr+LjurSp/fUv/SXVw2hX8swKa5U52vYhClzu4X
         Fh54x54EBSBg1fmi0vd/Ett21/WlZz4N5BBHlhQpTsAPIL0uM6Ag9DIIMkCcikj/x5JB
         GDmIuDxmiE7MFZnrlKnfBtNCqoxg/6A/UUKo951n78FBvG7UP6KvzPxutHjM7GWeeNxd
         y/AQ==
X-Gm-Message-State: AOAM530OHt4Ku8R9/ERp86tUVHZi4h0SaLvseq09kNi7GKGyXsx0iver
        4D10pbVLyHqzeNJ4CmSyVGRpiKTYyr030g==
X-Google-Smtp-Source: ABdhPJxErhORY6S+QPERzbdc0aAYz7FYE2sH74puRmh9wnSk9u5RvVl/I8VL6ETpWKOOEpT/VyGNLw==
X-Received: by 2002:ac8:58d6:: with SMTP id u22mr21846897qta.81.1622592196978;
        Tue, 01 Jun 2021 17:03:16 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id h2sm12906906qkf.106.2021.06.01.17.03.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 17:03:16 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id p184so1222518yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 17:03:16 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr43738372ybb.257.1622592196070;
 Tue, 01 Jun 2021 17:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210601185959.3101132-1-swboyd@chromium.org> <20210601185959.3101132-2-swboyd@chromium.org>
In-Reply-To: <20210601185959.3101132-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Jun 2021 17:03:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W_zUuUCo5aixXzMYOBrQ5j1x9FYzdaqf_b+8njSB7gZA@mail.gmail.com>
Message-ID: <CAD=FV=W_zUuUCo5aixXzMYOBrQ5j1x9FYzdaqf_b+8njSB7gZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Remove cros-pd-update on Cheza
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 1, 2021 at 12:00 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This compatible string isn't present upstream. Let's drop the node as it
> isn't used.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
