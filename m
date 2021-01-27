Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45823051CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhA0FOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbhA0EpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:45:09 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:36:34 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id f63so369471pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=49fIMM1Lt68y+MNq1Fw+uOVTWwfJDNod7jA43K/soC4=;
        b=d5+W4Rq25QQ5lbgZxfyMueTHo+2W2Mhtmefb1NQeKJi8d4wbt4DnUDzEGY3PpGDxRm
         pgmst3zTL9sok3rDU4/bUAG2ktKxt/yf59usg0i8IA8K3BKoQb8Nm3U4IYjx5wh2UY4A
         Lsl6zrPT7ue4ReUATS6csGZmlwYabF3o5vKvJD/dJH+buoPPLM2b+r4QMvpgAwDZBMXk
         Sr98cz/TctPrardkzwL7hhNNVUyVJ7YftYcZb44N8h4ZpaYeUKQU77B6Fyz9HT2TlT3g
         9Fa13LxZNavkJz5PvcdkH2GpteIXI5wPkIL9B4HgolQ76GZbsHiHy22nA6wROJRPKzaS
         DxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=49fIMM1Lt68y+MNq1Fw+uOVTWwfJDNod7jA43K/soC4=;
        b=rCoSfTnLvcTcitteOsTjj6QS7Em84S8vJTCTCqhoZfyqRgIeUl0ZzE4L/7MX5oRY0P
         MJxajqtztTOlZXP2azXsRW2oQQzciHlqDu9nmW6tPotrS7LODQMiqHij2fTRsUunc7Lz
         fZfPPJu6XX9ns2YZb2cntQ570ERCqegJNe7A8VXFL13WZgPq2rLjP7JVFaRDNAxLJgoo
         yI2DSHE8m/M4P4Ah3sZKT5K2rOwe3sDVeuSp7G4c+s1FkAS1+YvubKBZ76TX1U1XsOfH
         bs90Zpu1ihxdSo/B+bX6Zhr9+bW9LAC0xmZBU1Q4UiQkLtAkzbLp8GOFSe/gXtt1+P14
         68eg==
X-Gm-Message-State: AOAM533wc2rFbJZrO9Sys7LUhEMA6jMPZVN6zxvg04ZmElsAmOajGdZa
        KErxMhDDd/wtdVTfO4iqM7VBQQ==
X-Google-Smtp-Source: ABdhPJwYi4pUQYbnphhGu7hk813JFWOeHnfh/xXxYFNCzCaBaAFCc8L4sUBFE1bwu9Mng8gx4Fh7gQ==
X-Received: by 2002:a62:2c50:0:b029:1b9:1846:b490 with SMTP id s77-20020a622c500000b02901b91846b490mr8613411pfs.76.1611722193690;
        Tue, 26 Jan 2021 20:36:33 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id s21sm439693pjz.13.2021.01.26.20.36.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 20:36:32 -0800 (PST)
Date:   Wed, 27 Jan 2021 10:06:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 19/21] clk: spear: Move prototype to accessible header
Message-ID: <20210127043631.4qqduj4cxwqmoq3m@vireshk-i7>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-20-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126124540.3320214-20-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 12:45, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/clk/spear/spear1310_clock.c:385:13: warning: no previous prototype for ‘spear1310_clk_init’ [-Wmissing-prototypes]
>  drivers/clk/spear/spear1340_clock.c:442:13: warning: no previous prototype for ‘spear1340_clk_init’ [-Wmissing-prototypes]
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-spear/generic.h       | 12 ------------
>  arch/arm/mach-spear/spear13xx.c     |  1 +
>  drivers/clk/spear/spear1310_clock.c |  1 +
>  drivers/clk/spear/spear1340_clock.c |  1 +
>  include/linux/clk/spear.h           | 23 +++++++++++++++++++++++
>  5 files changed, 26 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/clk/spear.h

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
