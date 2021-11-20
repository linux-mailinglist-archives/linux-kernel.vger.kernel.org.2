Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C64458134
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhKTX7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhKTX7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:59:02 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D006C061748
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:58 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so22759015otm.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dOZcbvvxoV5kK+4KDYjWpfED8ish1Yaz0C1X7kuA90=;
        b=uK3fFmy85udSaFtezHy0jsVeokGkGwZ3GalHznxImHgPLGj0nmRcrIw7Pgi6USCz7m
         3NsSYtxGLuryzz4nhbX+AmFAXJzYg0LtW1tBH2JKld17K9lhrGdhAJedDingJlyX9I39
         bwFQVkXoQh0bHGed4bkBhTHcU0/vXuEGAaeppzqaZ/9AHsJ5Tx4PHU4K/Orhioc6GHny
         eNPaWbd45pt+a5qndz6uJdcHT3RPwWKfTf8ospUlwoR7LBmwA5mR6NsPo9JYzZA2Fdwu
         jpvKGV3z10923KH/dH8Sn6WC4uSi7gPkTcaN30YGadI5LYxTszP6i3Ico1Zss/iYQbIJ
         4ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dOZcbvvxoV5kK+4KDYjWpfED8ish1Yaz0C1X7kuA90=;
        b=uR2/o7t63dKMLl+9RAwhH92ztpxrj9O00N6YhPdPq2qtlkGrlsygcbKQLOq1WgY1I1
         o7GPVO9shuF/sLaHnC3rYC+h1JRRh8gg3jM1CbW6453tQsR26OhwwvDom+hRayWliAXk
         2+MVIz5AaHiHfChgiwwYvOo1vZO8v/EdXLSWrs11Jxu1Bj4qwCBAz9/G7/VpnKNiqUyH
         7t55Wu7fErFuLRGe9pR/W49Xf00ftMq7UspSHVATLkbH7CAhdEQfvv5lZe72L6c0L1fC
         EXlg/+YgHEYJFacbTUVtfXj+tIMAYh+jvgGqvq9ugkQwjTXcz4xWAj9I/DyNmBM7kEDv
         v4Wg==
X-Gm-Message-State: AOAM531pStEPocfu7XxeK3O3HuIzE6lDp8kI98lDicY/qrqwKA8g6y/N
        Bez4sbKTB1S5028BdhVCpZXUUg==
X-Google-Smtp-Source: ABdhPJxYfJijDDMeOgStUfT71Qf1HtDr0gkAOahPqdBMH5xDiHh3sMLuehkKYkoe5VvTCH9qof0Ncw==
X-Received: by 2002:a9d:6a56:: with SMTP id h22mr14443064otn.135.1637452557725;
        Sat, 20 Nov 2021 15:55:57 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o26sm828474otj.14.2021.11.20.15.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 15:55:57 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH] arm64: dts: qcom: c630: disable crypto due to serror
Date:   Sat, 20 Nov 2021 17:55:33 -0600
Message-Id: <163745250542.1078332.123070491536318039.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105035235.2392-1-steev@kali.org>
References: <20211105035235.2392-1-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2021 22:52:32 -0500, Steev Klimaszewski wrote:
> Disable the crypto due to it causing an serror when cryptomanager tests
> are enabled.  Add a fixme comment so that someone way smarter than I can
> come along and fix it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: c630: disable crypto due to serror
      commit: 36be92f490a7f403c7b1ea7662c92e100e8c3096

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
