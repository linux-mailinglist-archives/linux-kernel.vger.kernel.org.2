Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C2430A1C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbhJQPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbhJQPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:33:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4024C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:21 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id o4so20915182oia.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1BNeRRH+4pCFYNacV/SnSRJ6/WkMTg9riRV4NgpWaI=;
        b=inBJGGXIeipJ60XqJEqfNPYwCvRqERJvdfzckXf/FQlU71wzj2xsmJCKM9jT7XzJ/2
         BC9S7duklDKg5BtPmWacZJd0pbyzXWhjYFPwV+5XdqS8ZbWmSqmfYosZf63fwiB+OxMF
         GzLqRQ0zFHW8s/kfc0bpv4ca4k4uTTtgD92PaWv5hJPyZy2iBCUxzQXO+XTUdzZzyscI
         dVHv7mVozrZE4TxH9tU5IgepLQkIAVirLb+Q5GJz8va0OLNOfvIuZ4VlUnV8p2DEphXv
         omswBq76lmR2CB+tZAtCRdRhlDXXNqz66pJdfAqsY9WrKiveeGckR6p1ZKAFC4KWHP/i
         qmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1BNeRRH+4pCFYNacV/SnSRJ6/WkMTg9riRV4NgpWaI=;
        b=LuiJg4WScsfuIh69raSFdHfjomMKfRPJK4cdH88SOuLUQe/bPpjkWQxU0PXSp2w1AB
         EBYfLhn8slYZTp55zUu6k8F7z1UTqlBCGMlLlA/EPk0VxXi1D/8nv+IFrRYneHDzj/Aj
         ksbiUzk/ENR8x20QzuFg8BWK5iBGdBY4+XtaraYsaRfCI0bhOJis9wv0X1V+gkzX281L
         OUuDg/Y25cpjJ9JPaDjL9d3LvxYyWjogSIOm828fiS1lSR2oWIxLoZn3552+fCiDXapF
         AHmYELhcnOqfcD/DYF/qjI6ixls2WR/D5yH5v8ed/iQjjepiTpSRToke17K3gnJT6yQa
         RvSg==
X-Gm-Message-State: AOAM530IffyE8B6vucpkVOFFkJ2tysHfUKaS9/2ifiM7/KN4Qwl79YDk
        5ruGPL7DrF313HZ4dp0BRnXQAw==
X-Google-Smtp-Source: ABdhPJwNs6CeqlgS6OrYQ39EbXlETugWmu6Cbv6RgS/P1oLqmnnKTp0wpWhxbPZRXkjeOYXTmmJ9PQ==
X-Received: by 2002:a05:6808:308e:: with SMTP id bl14mr8869305oib.92.1634484681347;
        Sun, 17 Oct 2021 08:31:21 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id x6sm2565698otp.49.2021.10.17.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:31:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] dt-bindings: soc: smem: Make indirection optional
Date:   Sun, 17 Oct 2021 10:31:06 -0500
Message-Id: <163448466184.410927.8544390085953194195.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210930182111.57353-1-bjorn.andersson@linaro.org>
References: <20210930182111.57353-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 11:21:07 -0700, Bjorn Andersson wrote:
> In the modern Qualcomm platform there's no reason for having smem as a
> separate node, so let's change this.
> 
> Bjorn Andersson (4):
>   dt-bindings: sram: Document qcom,rpm-msg-ram
>   dt-bindings: soc: smem: Make indirection optional
>   soc: qcom: smem: Support reserved-memory description
>   arm64: dts: qcom: sdm845: Drop standalone smem node
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sdm845: Drop standalone smem node
      commit: 622adb84b3e7c48a888c3df26fbf28679ded660b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
