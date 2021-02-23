Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8DA322697
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhBWHqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhBWHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:45:54 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A528C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:45:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g20so9334854plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=E8aSo+fojNMRbfefsm/8/aCYi5ReEqYPMb+cwp90nc4=;
        b=gyZyt7YCZhfeQvu8/BDQ5FidId3GpA4WoKJHPDplprFQsqzVjZGajKkfxIj1ZRKBQm
         B+mDKuKnvzSaAytNgsKnkHQPpro9NRMbK1Is5de0H9Tyx+gGI4Ps1ikz9zLCR5urSdZX
         9ASNUFXbcNv7DenZdCl8Z8gTIVP5ALWYEUSzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=E8aSo+fojNMRbfefsm/8/aCYi5ReEqYPMb+cwp90nc4=;
        b=rv0dH8Doub+bFKa3BMSnraEoItb7uMgfcAH8n/QREkbpi6gNGACJlaDuIxfhhrgbsZ
         vErxuK0kBfpue+4hDHp8AA8p16wxRUzSAx8zG1EH7W3/mC5GLymPckuqmsU1Plz1raOm
         1UTL/6Ga8oQKzPG+9Yg6KyCYTIsEMCY6iuH0IWNHUtB3/KxGAoFGqUQkxFNDTF9KBhDe
         ZTlX+HYdjJwZo2JsTfJBHQhrX4OseSw7m4m3Wg6S7w3hhktjWNqcjDEXAwU6NQKM7OSm
         QuM0g0lpF15xpq6LJ2/kJk5C1fVvTsYKjPseeNvQbpvjikiZdRxFx5vXCklf4QHmrRLT
         K2Rg==
X-Gm-Message-State: AOAM531Oda4h2m6mkMa5J+lPSuvih5TIoMJx05U46WfgAliaiWM4addL
        9H7wtxyWUMP5elauUQbkTvgjlg==
X-Google-Smtp-Source: ABdhPJwrPu5C8Bh/RVSHXlvKyO+bsSc3q7BRl9aiIvI4ifrTXiFTZyMV08DNbnl8M9xFSHIE5dgWsw==
X-Received: by 2002:a17:90b:e0d:: with SMTP id ge13mr27658012pjb.83.1614066313050;
        Mon, 22 Feb 2021 23:45:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id x80sm6724761pfc.71.2021.02.22.23.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:45:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613114930-1661-10-git-send-email-rnayak@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org> <1613114930-1661-10-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH 09/13] arm64: dts: qcom: Add reserved memory for fw
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Mon, 22 Feb 2021 23:45:11 -0800
Message-ID: <161406631106.1254594.5935934364229452348@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-02-11 23:28:46)
> From: Maulik Shah <mkshah@codeaurora.org>
>=20
> Add fw reserved memory area for CPUCP and AOP.

Does CPUCP stand for CPU Content Protection? AOP is Always On Processor.
It would help if the commit text told us what these acronyms were.

>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
