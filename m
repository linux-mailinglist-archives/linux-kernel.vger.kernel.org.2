Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B649A36EB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhD2Nk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbhD2NkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:40:24 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4EC06138D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 06:39:37 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a18so25341200qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 06:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgdBnMydFBzwsG7W3uYP/xp1blAOpZ2iF3BFsqoCBR4=;
        b=D72PPw3JOCL5ArWLKUg1LwdWV4i791yrbbio9+d1fGpbB8TfYgO9ZgsEgt9+WcSW0G
         H0/6BTJkS5OExQWGTmZx9vWat6g65+R7TtSNFJ730vVMQDjLQKbnhd/iKtKqeqMhlhVg
         eMD8gTXifjMb9FPkds4hkkYV5AKQSl5Rj5+SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgdBnMydFBzwsG7W3uYP/xp1blAOpZ2iF3BFsqoCBR4=;
        b=rac0jqOle3pGHr+auwQTSS/8QMHrhGdHS8j8cvCEg5uXc0yCr2epxfmezvge8Apc0E
         goS5Dqu35PayiofNPPGLTeitDG72NKR8hYt6JVjoT5TgcwXORiSj3QeJ+MFqvoyX6495
         PWKgWhEdNGuwgMgjDmA0kAGqpAZsREUEyf1F9qxwfsp9oMwfkTP+Kl5Jl4GsBXNwisMY
         ZffXkdBuFI8+AEVKPBG5vYW260cfRA9nc8wbD62CeTrlHb5WePTgnv1lCFpU0nwaebEa
         IcVRkE1daCfVBAyqHwvdxuQNw5Qsh5WJYBwcWxxygzHEWYk5DOvuYOn5bBCyqXINy/4s
         Waww==
X-Gm-Message-State: AOAM531Aaz3An61KZSXGbxlzyWgFcAkCJr0VkND/gyxORm+DRrDu9gLR
        PAs7KXaUZaReBLRX3fzGsuHYJEICrPtLfQ==
X-Google-Smtp-Source: ABdhPJwWjpJ0tY1SYjmvqsuQ6RSgj6QWhf5hv0cpkySyoRl4WUyi4P/JOqMwUK3fPo23XIlIrGd5SA==
X-Received: by 2002:ac8:4b54:: with SMTP id e20mr31961309qts.371.1619703575632;
        Thu, 29 Apr 2021 06:39:35 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id b15sm2112398qkj.95.2021.04.29.06.39.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 06:39:35 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id z1so78484967ybf.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 06:39:34 -0700 (PDT)
X-Received: by 2002:a05:6902:4e2:: with SMTP id w2mr17570245ybs.79.1619703574539;
 Thu, 29 Apr 2021 06:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <1619674827-26650-1-git-send-email-rnayak@codeaurora.org> <1619674827-26650-2-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1619674827-26650-2-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Apr 2021 06:39:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UUowpvn_2uPrOQG9hOCdX6GYZDojBdW+w8hg5q6PfvAQ@mail.gmail.com>
Message-ID: <CAD=FV=UUowpvn_2uPrOQG9hOCdX6GYZDojBdW+w8hg5q6PfvAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add "google,senor" to the compatible
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 28, 2021 at 10:40 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> The sc7280 IDP board is also called senor in the Chrome OS builds.
> Add the "google,senor" compatible so coreboot/depthcharge knows what
> device tree blob to pick
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
