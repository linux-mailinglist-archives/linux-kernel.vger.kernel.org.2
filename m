Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8B740B7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhINTVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhINTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:58 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38714C061766
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:19:38 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w144so622230oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=p4aiHjSt5PydyNP4yCr/hWcE1rXRRolEI3z5GimQKiQ=;
        b=Zemn43lr2poy4K8eggMpxhiOpG05mXAnw6FKV5/fQpfVV3R0AX5iHJXV2trQPx/v+h
         GrHzzWRSC+FrWUts3+o6/A1W8eml1SPP7QjzKKfuVEEHI2zM7uuY3Fx09b5usr/lkkjb
         me6dmDPyffxPNH2XUIY2b81uaer96asbwB1cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=p4aiHjSt5PydyNP4yCr/hWcE1rXRRolEI3z5GimQKiQ=;
        b=o+fWdzyi8odqjwwaF5otyIhHOIG1lJprHz3PrZ6j/DBvz0BSSwP3Ey8nQw54sW67q+
         V8OBZRR5lY7ZMsGOlUzoMHPr431gb/NN4G3G5GoNSzDu7nxC/fFbHceADQWkhsgijUE2
         Sf+WYVHzCMV7PniDyPbL/Os0Lslv/L1TzHfPEF9z+A1DABEe9zuL2MwzSqsTXfJYX9qg
         Rzb75potPS0JJLobZWdDa1MnO9gDpmunUxlhFuW+pyn1GIAITycDBN1FaQVGcpTpes8W
         ssVULSPEp6ES0vQozLw8gYB6Od+rTlhqC/0EpOkLeL4JN3lsXTWiCre5S47VMp4WLM76
         oXIQ==
X-Gm-Message-State: AOAM532ipcLhaQntYgiKrbKaayKagRzBymFYjOt91M7fB0LwEO1nVRZR
        41GCAdUaY9W4fYpZnQxMq4b+cooAqO267qIYSKwMrg==
X-Google-Smtp-Source: ABdhPJwW/rk+97bzsU+oU4ww0tVefOIdv/mV2ZiRt6IYFcucdG8dUrd+urFcvffUJbLKgBn39LtA+b31lg1iRxykZQE=
X-Received: by 2002:aca:2310:: with SMTP id e16mr2706663oie.64.1631647177562;
 Tue, 14 Sep 2021 12:19:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Sep 2021 12:19:37 -0700
MIME-Version: 1.0
In-Reply-To: <1631643550-29960-3-git-send-email-pmaliset@codeaurora.org>
References: <1631643550-29960-1-git-send-email-pmaliset@codeaurora.org> <1631643550-29960-3-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 14 Sep 2021 12:19:37 -0700
Message-ID: <CAE-0n51vOW4avQ1beq0_RSNHGpxF_2CP1SbqstWqQTdvwYmxdQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-09-14 11:19:08)
> Add PCIe controller and PHY nodes for sc7280 SOC.
>
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
