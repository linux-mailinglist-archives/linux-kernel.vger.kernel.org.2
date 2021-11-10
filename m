Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3095344B9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 01:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhKJA6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 19:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKJA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 19:58:19 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CAAC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 16:55:32 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r26so2036870oiw.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 16:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zuwi8VdgrtneqiZTm5AGRBpIkLfz+Yl+0tOyzAoPJUY=;
        b=AxpcyaLb8qnoVjm6VGIBvrmQPJpBdIrTDymYjlLvgES848fYut9st2UwxNoIzNhART
         HrRUrFj143C9MIKzKTvEf0XMmMNXf7unaYOGoQx5MXOJgRIxfpWl/t+aFA1OAJ292C8x
         oHo/nViAX0gFYIIBOZsN74QFDJmVB9ydapY3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zuwi8VdgrtneqiZTm5AGRBpIkLfz+Yl+0tOyzAoPJUY=;
        b=aQI3PaTTDLbO3c2UKsswtOEpU+7xV1z9qfSlcol63EDlHQP04Kk+uce21n+Q5AjuOH
         P4elFu2r+QuewB0OxM2AO8ZRhz/vbEtGvydEKltudybgyfoqFXTsuBCWas9lJNemXT1z
         LHCfo+8fJ074CE+RhyC0veDO28Y6YJd1Zc5+/65e5LGPZJwsHLaxN6vFYIPRApDp39Ve
         AjWW5LgKrEXZUkDxXKfxb+3QIoYe/O7WyNO5F8SbGsm2konFbE+3YPlbHJUEvXTwYAsa
         Ho6jcnAg2ZiwrqZk0juPNlwZtcfmX0FhfqrkqJAI4+/7trW2bC9BtE8+Fg6ZcbC9HIOJ
         FCsw==
X-Gm-Message-State: AOAM531tJHUSXZ4phOMZtXxfaaludDrg4JMlEDWOX2L9WLjEnnq2nzSV
        xNbpxFLRh/6rwzgvXmHFEHTUPTwozzKGcA==
X-Google-Smtp-Source: ABdhPJzRA5GJMrYmdF5AmVx7Ig4nACYKERI5ey7Emm9oBUwmqpTumLcLI9J/jwV/E2c9WizzQsCR7w==
X-Received: by 2002:a05:6808:bc5:: with SMTP id o5mr9407745oik.129.1636505731300;
        Tue, 09 Nov 2021 16:55:31 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id a23sm7142952ool.3.2021.11.09.16.55.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 16:55:31 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so532598otg.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 16:55:30 -0800 (PST)
X-Received: by 2002:a9d:4b19:: with SMTP id q25mr4612966otf.186.1636505357500;
 Tue, 09 Nov 2021 16:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20211109221641.1233217-1-sashal@kernel.org> <20211109221641.1233217-17-sashal@kernel.org>
 <CA+ASDXNcC4_MpURRjbeXsyXsQ9Qte_YgoXFCJUKtrSWpZsHn-g@mail.gmail.com> <YYsV/OU47QlolwOx@sashalap>
In-Reply-To: <YYsV/OU47QlolwOx@sashalap>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 9 Nov 2021 16:49:05 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMTAi+jgSDpM3vDoD1Bmimsrqv6iQrZ_=HDtQz6jQufYg@mail.gmail.com>
Message-ID: <CA+ASDXMTAi+jgSDpM3vDoD1Bmimsrqv6iQrZ_=HDtQz6jQufYg@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 4:44 PM Sasha Levin <sashal@kernel.org> wrote:
> I'll drop it if it depends on patches that didn't make it in. Thanks!

Well, it won't harm anything as-is I suppose (maybe some logspam from
probe failure? not sure), but it would be extra bad if you managed to
pick up only _some_ of the dependencies. (There were 2 patches, but I
won't tell you which they were.) If you only got one of them, you'd
turn pretty much any RK3399 system into a brick, at least until they
revert their kernel/DTB upgrade.

Brian
