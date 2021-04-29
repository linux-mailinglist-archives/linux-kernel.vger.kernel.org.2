Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8783D36EB72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhD2Nkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbhD2Nkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:40:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FFC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 06:39:55 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id u20so34967064qku.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nayZswG1pGWH/1ZVEDlOm+OC2v9MFMOWazufEH7nVHg=;
        b=m2IptUcSZXqa1ZQ2PcIocz7TAM9fkvwY26tRwZC1KB4hwMB/b7f3fZvwKk+IbRrDTv
         TZKSui3NWe0UTSLJSfrfP1NHMSRrFPuoOgFluUMWIY/oUtj90ili9/Z+8EpkuSMDxd9Z
         9gcgKhxEE5WrYbaqR19u+uEFAOQhqvpSt0n6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nayZswG1pGWH/1ZVEDlOm+OC2v9MFMOWazufEH7nVHg=;
        b=n5Jc+9V7c0O8ztDjKxOOekoEEURRFCgH2+1DiSS1rt5GF3pcvkYZQzoA8X43Z7zYoQ
         slDywUifb3jDgtIksKuKwK+FFv9TWZ4/evBfO5s91UTCw/uXqMtzjZvR/xvj7mix0/eI
         1INNxDz0yOjTVuIfSt/HvB4D60J8Of/h6TNsx5oU3SzW1oIElMN8aNvpU5G7oYFkUzcG
         ACoiUOlY3mWo8BWbq+azhmz19S5yiF9Do36ICCJh5Z3+vjx4SoAPGFL0xbELhUc0drlr
         1sa29QoWjjVbEA+VTsgKmS1dphP0i5734TL4GeuwZxj6ybQUf/3F6mhbsdAdd1z5wY70
         qTcw==
X-Gm-Message-State: AOAM532/gEIouqMkcH2bF6k93wpgVyfSymB/hFTWodtUl/MpNb4YqDYn
        dn3kPHgE/VhmSF3e+Wh6Fgy5gR/krsP5xg==
X-Google-Smtp-Source: ABdhPJziynwh4I57w4p+vjpwC9rjJjEUbCMFWIq9DNOECb8WCpy63thaaiFhLTZj2THOdQuziu80wA==
X-Received: by 2002:a37:4017:: with SMTP id n23mr32703184qka.338.1619703594439;
        Thu, 29 Apr 2021 06:39:54 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id a20sm1420656qko.36.2021.04.29.06.39.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 06:39:54 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id i4so40947283ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 06:39:54 -0700 (PDT)
X-Received: by 2002:a05:6902:567:: with SMTP id a7mr20668343ybt.276.1619703593609;
 Thu, 29 Apr 2021 06:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <1619674827-26650-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1619674827-26650-1-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Apr 2021 06:39:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UARyDuE+vEQGX4kTaQdMiPg6rX3K5CuYzkriQaviQbAQ@mail.gmail.com>
Message-ID: <CAD=FV=UARyDuE+vEQGX4kTaQdMiPg6rX3K5CuYzkriQaviQbAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document google,senor board
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

On Wed, Apr 28, 2021 at 10:41 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Document the google,senor board based on sc7280 SoC
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
