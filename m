Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33C2409F49
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 23:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbhIMVjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244116AbhIMVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 17:39:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C374C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:38:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a15so14116117iot.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTXg4OkxA4gYmaLOUALhExrv2s3LoqS8/onFwK1MnZ8=;
        b=e3VfJk7ASvcBdgvYNAlNBeXh3UUudj7i1P+E2WM/PGgBYfWK72BaoDbXkGBeDE+W1W
         s/kzZmdY5oaQhZAY2YxG3wtGsNfnvmO3jfYqHzo+xjW7gy90Yi4AJNUTTLdYSOwy92UW
         HTAAZNoGrpzoHJ9ThsSQif8yTNpgcZ/hXBOs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTXg4OkxA4gYmaLOUALhExrv2s3LoqS8/onFwK1MnZ8=;
        b=vIk4nog6op4wcnf1V7RXRAffaP60eT6d5Dy5RsqF8+SmBei2N5pOWweb0MhZ8yO4TE
         pzYpmNCPaEOibpnN6flNhT3FToc/+CjPBmJjCgs2QYGgp5Lz8xsrglzDweXZENtPzNbo
         KGsReERc9xPy8mu00S1r03Jc22B1X5qQ2F0gNSCrqsi7UK4hT1w0EaBUy6ShAgfrfdBh
         vZDljnalUH4NR9XGIwWuBIs+ueC8sTyByTJpwEAmDks3JK8eOfTQ+IpbdrMeTLUcp6hH
         ivmftL/ONGHO6MsCCfJvrSTIaqK5JkHoMDkAUbzqYJQ1Dc0AkrYF7Gj8MV/B7rX/9e6v
         NY0w==
X-Gm-Message-State: AOAM531CKQeJlEtPPPmTI2oiGMOQdifpMHx1t1y1+Gmj6iMAfzojEwen
        dI6se+T+lKC6FOOTBGew6NSoJoGEuv/6pg==
X-Google-Smtp-Source: ABdhPJy8BrMue4x+XT0pZHOHQZO337bPZMcYgGm/cSIq8lSP7QtRR7b6PP0lb+8rAbRiOKpDF1afYA==
X-Received: by 2002:a6b:ec0b:: with SMTP id c11mr10783184ioh.207.1631569099708;
        Mon, 13 Sep 2021 14:38:19 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id m11sm5562511ilc.2.2021.09.13.14.38.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 14:38:19 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id i13so11687963ilm.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 14:38:19 -0700 (PDT)
X-Received: by 2002:a92:da0c:: with SMTP id z12mr9421434ilm.120.1631569099034;
 Mon, 13 Sep 2021 14:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <1631530735-19811-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1631530735-19811-1-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Sep 2021 14:38:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Va55WWbBebieNsuS8LE1XBkPAmCT5BMR1nXtBn+EY0EQ@mail.gmail.com>
Message-ID: <CAD=FV=Va55WWbBebieNsuS8LE1XBkPAmCT5BMR1nXtBn+EY0EQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280-idp: Add vcc-supply for qfprom
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 13, 2021 at 4:00 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Add vcc-supply for the IDP boards that was missed when the
> qfprom device tree properties were added for the sc7280 SoC.
>
> Fixes: c1b2189a19cf ("arm64: dts: qcom: sc7280: Add qfprom node")
> Reported-by: satya priya <skakit@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
