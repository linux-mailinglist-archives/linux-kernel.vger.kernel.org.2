Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3544B958
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 00:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhKIX2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhKIX2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:28:43 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF263C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 15:25:56 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id m6so1729006oim.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 15:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nL261LfEnE+lH5hQroZYFitjsNXa1tK6YPPcrVYv6c4=;
        b=N1HvdV99468q9bEv5q7ellPorYQd/W8mpCPrWLqn8S4ksJv0XInlTz/z79o91irx8F
         IBinuVJR+3dv3ohTcMOjoLOjds8IlTm/Ay2TbcpMEIQb7TPl2tCqAAaonqYywCgsr4kN
         ZCEWZuQ1MSmhqlppYjbvItwe0X/k2DasKrpK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nL261LfEnE+lH5hQroZYFitjsNXa1tK6YPPcrVYv6c4=;
        b=M9ql3l2ZOfUpQgb8pww5gmeUFXmp9Ej7XWgaxhw5ygY4NuBA6Kx+ubTaTH2ACgrCqD
         Iex+G+YDgx8lEjVzOVvy6TPD+qaBT9AprxpUEYkqcIUDuAgTBFyPVFZVlkpBftQ3rWg6
         Zw+VfWumrYXaGJzEDS9IpDSAQn01HxMzNkP1tY3Hj+WwrplMni5jbMGobWB3SKRutO0I
         c+a0rCKz3CgpKzjIrrqYacT9hxEr6cOxdT20Cc6m0/c5VPNZEYm1tgj+hEYHNZ8eq2M5
         hyf8J6aNsnImNT1+CXtJ7B+QnKcgSHvQcqjBJtDqJziwWXMIzd6GB5dh8uxtmGYJDm2J
         eWIw==
X-Gm-Message-State: AOAM5329oJlr/BKqzSzBnfz7UUNu/Ij6lHpHLVR7jEFPtES8y/XAqiuV
        Maxqrj4VJi4+g34LpLoQhEEWP9z6prOs7Q==
X-Google-Smtp-Source: ABdhPJzMLyumYhcNwCAycZZ0N6qZCzXTc76vr06M3j6453aYTyHltvMqTY+WR5AfTb5LjW3h4K6f+g==
X-Received: by 2002:a05:6808:10d1:: with SMTP id s17mr7471850ois.26.1636500356338;
        Tue, 09 Nov 2021 15:25:56 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id i15sm7708271otu.67.2021.11.09.15.25.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 15:25:55 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso1094597otv.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 15:25:55 -0800 (PST)
X-Received: by 2002:a9d:734a:: with SMTP id l10mr9337755otk.3.1636500354735;
 Tue, 09 Nov 2021 15:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20211109221641.1233217-1-sashal@kernel.org> <20211109221641.1233217-17-sashal@kernel.org>
In-Reply-To: <20211109221641.1233217-17-sashal@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 9 Nov 2021 15:25:39 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNcC4_MpURRjbeXsyXsQ9Qte_YgoXFCJUKtrSWpZsHn-g@mail.gmail.com>
Message-ID: <CA+ASDXNcC4_MpURRjbeXsyXsQ9Qte_YgoXFCJUKtrSWpZsHn-g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 17/82] arm64: dts: rockchip: add Coresight
 debug range for RK3399
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 2:17 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Brian Norris <briannorris@chromium.org>
>
> [ Upstream commit 75dccea503b8e176ad044175e891d7bb291b6ba0 ]
>
> Per Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt.
>
> This IP block can be used for sampling the PC of any given CPU, which is
> useful in certain panic scenarios where you can't get the CPU to stop
> cleanly (e.g., hard lockup).

I don't understand why this is being backported to -stable. First of
all, it won't work because it's missing dependencies (specifically,
around the RK3399 clock driver). But even if it did, I don't see how
this is a candidate for -stable.

Methinks the AI has gone too far again.

Brian
