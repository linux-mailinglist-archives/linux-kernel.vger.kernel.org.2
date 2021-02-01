Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD62630B288
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBAWFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhBAWEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:04:22 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1DBC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 14:03:42 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id a77so20586636oii.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 14:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B49gml/8cpgz8Os7F0PVegLTz0oYjIQVNIevIep8kh4=;
        b=Gh9nYVSmTAOkcwnoYC7iPOHwxtJA70Mk0Z650ygrrx6ADWq9ub7IYWOPuASCC9cfkR
         GNhMZJWnjvwu8PZuhQEAvjEz9dOe5j3dbaPZKcR1CsU4U6CZJNDNcG3q1TzPmIR7xT5+
         57Fg8AK0YFDpp5Gd6AIZUFWO5td0ItCu3ZNxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B49gml/8cpgz8Os7F0PVegLTz0oYjIQVNIevIep8kh4=;
        b=bjCx9Ca+8Qw/o0Y46BKI7pu53R5TFekay5hkeKQO/sDYEGuNu76nktvnhVmQRQaHzU
         OxqWr3BCUTLfFR6C1gVqYz29LtduiGcFqIgF2Ry4qjKX+UYG8zvmFcuD6lC2tTOVuzTm
         oh4EZnjfD1FK8VTrdkaPibalIAqjL3Kpk792A0RCrDrj/3MN9+OPdhSUYJaDG3fCxP5x
         NY1CfnlIqAant1ePJ/y93R2ZD6D6rbVuS8zcoBJ4+eQADK3HNVqtfE+PZVLOwYqhjSuc
         vpoLFtNlXUS1NlPL8SPo05hHk8O871ewPZoFkS0EOP//6CHITBd91Ya5PIvNTCsPwIGd
         00UA==
X-Gm-Message-State: AOAM532YcRYou+vL/ARGxXLwF9doNcSYw9064+6zpQXawkWBYK51YXMQ
        CEP3x6pqiOHsxmhdgJpkOhSxVO1qR+uhJg==
X-Google-Smtp-Source: ABdhPJxdcq65u3ug52vDbOBzp/bHb/4hjrGaFOo5Ho3z656EM2NdGlx/IQlmiWtQOgWWjEMJ2N+MKg==
X-Received: by 2002:aca:d643:: with SMTP id n64mr643868oig.151.1612217020465;
        Mon, 01 Feb 2021 14:03:40 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id 67sm4137037ott.64.2021.02.01.14.03.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 14:03:39 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id k25so20567713oik.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 14:03:39 -0800 (PST)
X-Received: by 2002:aca:f40c:: with SMTP id s12mr622260oih.105.1612217018531;
 Mon, 01 Feb 2021 14:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20210201070649.1667209-1-yenlinlai@chromium.org>
In-Reply-To: <20210201070649.1667209-1-yenlinlai@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 1 Feb 2021 14:03:26 -0800
X-Gmail-Original-Message-ID: <CA+ASDXO-bVXhEJE+7kSe85e8i31kzACHeypt-8vBD2ZO2_1=3Q@mail.gmail.com>
Message-ID: <CA+ASDXO-bVXhEJE+7kSe85e8i31kzACHeypt-8vBD2ZO2_1=3Q@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: Report connected BSS with cfg80211_connect_bss()
To:     Yen-lin Lai <yenlinlai@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 11:07 PM Yen-lin Lai <yenlinlai@chromium.org> wrote:
> When a network is moved or reconfigured on the different channel, there
> can be multiple BSSes with the same BSSID and SSID in scan result
> before the old one expires. Then, it can cause cfg80211_connect_result
> to map current_bss to a bss with the wrong channel.
>
> Let mwifiex_cfg80211_assoc return the selected BSS and then the caller
> can report it cfg80211_connect_bss.
>
> Signed-off-by: Yen-lin Lai <yenlinlai@chromium.org>

This seems sane to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
