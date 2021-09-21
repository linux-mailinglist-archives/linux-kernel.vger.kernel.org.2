Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12484139E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhIUSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhIUSUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:07 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08842C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:18:39 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w64-20020a9d3646000000b0054716b40005so8545381otb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=wRIT4s1i/ShcOgxfjk26/chTDGk5J7qcbPp6zKx8wL8=;
        b=O/2eYurCO/RmjAPGB8JVzLIkW70Y7fAHFdWVq3FjQYPfJ74EUMPVH+s6by2pFUAiJh
         hnAt2edp59tSX/Sfwq99Bn/jxK9pr0CS917pRSPuQMaWVcEEj2gyxIunGzJB1baLUrwr
         dwnYo+QZQ/wZuSkPQcjSKCd5CrCZyMGlE36EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=wRIT4s1i/ShcOgxfjk26/chTDGk5J7qcbPp6zKx8wL8=;
        b=utY74a0NrhT/NnSiwt+u/nUmVj28NxHf7PER7aHPF3gWi/TBNXUdGuI7ACpyPGazRY
         3vook5c6EaRlv01nnqP4ok0M1oT1J4Y0QqOzZr/pCA/K+ladlIvan/7sLoX2bFaqY9L3
         DKp94z8LsmFejy0UECeKJHWAV5xVuTrmeO+Xos3Q/P2giuj+upbsEOs7ovltseV/u9Ul
         nY4TcqFhuDu3B6bSC7s6K282mDttnxqSjG/8tbpZFUOcNml+v8o9FJlsw8y+6DVo2qBa
         rosD4YSYTuuBHytmXm4lWSXC7/WU6ZF8G1dtp8D3tG6m5bT+cf/q6z8PL09aDxWIqbRM
         NRHw==
X-Gm-Message-State: AOAM531VkPQSWu+TRSVcQc/e3VZdy5ft3XzYD/2W8YlHPMdK1mJcrllG
        /AdBpCIMFE8hwJodEQ5lsGc0xEO4AzyqlvkVhCp7nw==
X-Google-Smtp-Source: ABdhPJw6e8geb8YL/7MJWKkTXO13qz7mPLMAUDCSnLFmjbkfJLLfy1WYN3WJ0fDFhBEaiOzeUbsjdhA6UmV7LoOP+as=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr25758184otp.159.1632248318469;
 Tue, 21 Sep 2021 11:18:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Sep 2021 11:18:38 -0700
MIME-Version: 1.0
In-Reply-To: <1632220746-25943-8-git-send-email-rajpat@codeaurora.org>
References: <1632220746-25943-1-git-send-email-rajpat@codeaurora.org> <1632220746-25943-8-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 21 Sep 2021 11:18:38 -0700
Message-ID: <CAE-0n50aP3u3ZgZXrTA2R1YuKghi8p0BwSsXsceKKxrz97xAVA@mail.gmail.com>
Subject: Re: [PATCH V9 7/8] arm64: dts: sc7280: Add QUPv3 wrapper_1 nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-21 03:39:05)
> From: Roja Rani Yarubandi <rojay@codeaurora.org>
>
> Add QUPv3 wrapper_1 DT nodes for SC7280 SoC.
>
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Same comment here. Please make the cs_gpio nodes unused.
