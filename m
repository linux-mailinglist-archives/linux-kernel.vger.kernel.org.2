Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7610E432941
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 23:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhJRVsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 17:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhJRVsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:48:18 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC35C061765
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:46:06 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a13so6982485qkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/q48JXWMaZxMGZNH2ea25Eia5Gi+Z231/aB9DP8nAI=;
        b=AbXn4vfjK9uLMmUsYmIaTqwvikm7krHCabUvqkEkxYmZL4MTWIDdXvuwL/kEFBrfV9
         zPZVrkLmzyzBwxI3K9nd5Y9rwOTOs/nGzLsbeLLEqvGNBfAJXfKiX4RnD5QlFghufypZ
         so3BpGgJaADzX4z+/Uijjwuvn10GiEf/V+rJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/q48JXWMaZxMGZNH2ea25Eia5Gi+Z231/aB9DP8nAI=;
        b=vN9sg2wgqLNM8jblijfUoy7RhjFzFbn7GBVS2NgI0tftI24jxWYg1VfT0OGpjJ6xKV
         Eg/nnly3SGB5d3BKlu1/S38Qdb/dsXdFGvSyB/gXe1aWCLQiKrq4GkyEMi6XcxhSzMmk
         soF6BRyfA2Rj1DBYMfMvdkZ2ptDkwKi2hvmNfHfnEiQXlODbdpoE9qsj5sJ7oDCKFrGm
         fd4csd9FDd+AcHLg2MN21SVNIbWAWbTrTO961aT4m/W9N9ZlUFxxAStV00909idRJXyO
         JCTEh1EsvolGuhIHKcVnnaIA20CzufwZoEHWeyE+IWl9A/bQuxAc1X7tDbqm0sME3vTt
         DyFg==
X-Gm-Message-State: AOAM533S3trUMgAiPwVFUUOLo5Og/1iO/fzG8kOiKEX+Ep0AXw2qqlSX
        7Tp96TgZU1yY5huR1zE4jGyg3Omy4lD02Q==
X-Google-Smtp-Source: ABdhPJzD00zAeAaUoKvoBuAXqlyfiCGoVrJC20XcTaA2Qw9F+Wx7tCzPd82XEGFXGiJHbwgGj2Jomw==
X-Received: by 2002:a05:620a:29d5:: with SMTP id s21mr24607260qkp.174.1634593565963;
        Mon, 18 Oct 2021 14:46:05 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id g5sm6930325qkm.112.2021.10.18.14.46.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 14:46:05 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id o134so1257820ybc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:46:04 -0700 (PDT)
X-Received: by 2002:a5b:102:: with SMTP id 2mr30963560ybx.101.1634593564543;
 Mon, 18 Oct 2021 14:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <1632892123-11006-1-git-send-email-rajpat@codeaurora.org> <CAE-0n51Vnb1YKZKtg-2iSK7r+50RrbURW5TN6Wyvc+9b21jZNA@mail.gmail.com>
In-Reply-To: <CAE-0n51Vnb1YKZKtg-2iSK7r+50RrbURW5TN6Wyvc+9b21jZNA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Oct 2021 14:45:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJQ1J3_Kmz+8tArUQfjmSMBMOs2K=yhMVDaLjusnW+SA@mail.gmail.com>
Message-ID: <CAD=FV=UJQ1J3_Kmz+8tArUQfjmSMBMOs2K=yhMVDaLjusnW+SA@mail.gmail.com>
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7280: Add 200MHz in qspi_opp_table
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        msavaliy@qti.qualcomm.com, satya priya <skakit@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Wed, Sep 29, 2021 at 10:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rajesh Patil (2021-09-28 22:08:43)
> > Add 200MHz OPP in qspi_opp_table
> >
> > Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

If you're still accepting patches for 5.16, it'd be keen if you'd
consider taking this one. Thanks!

-Doug
