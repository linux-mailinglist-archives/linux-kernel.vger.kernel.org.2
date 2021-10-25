Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD943A4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhJYU2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbhJYU22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:28:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABEBC04319C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:21:03 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso16639403otv.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2bwvidlggTYqPYdvEnjOvk7VU+AKnEUaEntsTXBWAFo=;
        b=QlMEgpBJ9ktL1Opdpn5bEbYppOzz8dAxIhFM1fS/dyAlTNLIsRZpVMwvZCw8it46TV
         7PsHfIiTCVF3zUe8SyWC2+4ulLziCOVa56PohaFbunFmZYFTwT9O4lRllgezN8Hg/ExP
         i2/v7r23NiyEEQrRxBsnA4u+fn4qQ1rfVcbPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2bwvidlggTYqPYdvEnjOvk7VU+AKnEUaEntsTXBWAFo=;
        b=axg0C79VId9FeNGK5yf9nN5Z6GT4dRb99KqJdD2yG/DtCxRLuE0VuRLSjdS5s4mqzT
         Dvto/9GNoVWvXIC0g4QRa9rXm+pP84mmYIBF6FAMQgcTWzmAUxoJWaoNhb+jcKvS87tV
         DSSYl9rJzjlUY1hyTnVtgWMvumV2Cp1oGi4P06iazVg7UNdH98g5RzD2OIhrMT4tRPnr
         n7/oas4qxifXI9O4jdo0x1UYktclvG9Vt7uP+LhJvwtD3xybNwVHbPx0Ebjx8pRK7IVC
         rEVV7H1C40ReWv8b/nR4xmf/6uUPi+rlWa8qTGS86qLGdnCrQ/9LeDT+JYaKY74hDXad
         BMwA==
X-Gm-Message-State: AOAM531tBuJ20Ok8Pw4xOKIC7dkciyODUdqe5Tlteci7UsIiLcWeoP8a
        NTxc1efY81FH9zIkwWwf6eJQO9q/5rlpmFvdkmFAkQ==
X-Google-Smtp-Source: ABdhPJwdShfN68KpfDhT+2JDhJNv3XDUA5odNLOwOPjxhpTa/LV7X8Gla3x9vxWUHGPtAQOIO8tzMjzdDyBGswkThuE=
X-Received: by 2002:a05:6830:4187:: with SMTP id r7mr15519057otu.126.1635193263072;
 Mon, 25 Oct 2021 13:21:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Oct 2021 13:21:02 -0700
MIME-Version: 1.0
In-Reply-To: <1635070162-21669-1-git-send-email-tdas@codeaurora.org>
References: <1635070162-21669-1-git-send-email-tdas@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 25 Oct 2021 13:21:02 -0700
Message-ID: <CAE-0n51c-og98OmPGPooeV8XaRnpN=VGRM5GuwBKKfvbYzzZLw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add camcc clock node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-10-24 03:09:22)
> Add the camera clock controller node for SC7280 SoC. Also add the header
> file for lpass clock controller.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
