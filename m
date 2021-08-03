Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56283DF63A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbhHCUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbhHCUOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:14:23 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C774AC0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 13:14:11 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o185so136347oih.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=+/u7Fqz7b4vpkLt4MfAZ/z+pcTRWv1PaR2RpZemYy98=;
        b=b9dQbTwK/D4lySrEAu/umOYtkrvoiDNO3Mu0Wcpy0CjtqD0MNuVnnzMQfTqZMe2sB3
         3eezOEhb45vWXDxUhYopOCu8KFl4ApeNBciplagUwPiAI3Tsn3NUD4bqaXBdYUx+T62K
         OrUMmDwHVhyIWF9yon2q1NVN8/hfgpVqGG++8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=+/u7Fqz7b4vpkLt4MfAZ/z+pcTRWv1PaR2RpZemYy98=;
        b=S7AhFs8kDgp/98QG4bzFlPH0F0ykAmNhCCkkil+k4YsUXYTC6cryLAlI6mSrDouSFd
         jA+o6XXsXNSGCqn7VLZStiZBIK72H9yR/fC61tk6iWYEkdYI9rfTHmeMGjXMF+hX6BaA
         pC9dc9iociyvOGCfq6e8C/sc3m6SEi0UUJL8acox2GJsAeHWna6lJFnz1X9tVn3J16ay
         RI12b4uBu8HyH47JMgclCLAawAQt8GBswTH3F8SSLzw8pIJr+9pSk4F5qVyqcrhaApsH
         gZ7Npz8d5zVRssNi40CFhtBMgQBGFHca4I7UquiddtZ2KFpapfMf1Ov18K7iK/kv/HoX
         +olA==
X-Gm-Message-State: AOAM532iQaJ225iupzx/msqbi88lebLls9/7YKv/C4NbeGIlPQ29D6GH
        hleGeD5Q4/Aqn9wF/FMfjrIAFxor5oM1kSN/sbNqiQ==
X-Google-Smtp-Source: ABdhPJwr23vRylG1JcVhTsx1vfrLS9ICAjf5ZYipJ+b5RlDF+2ftl6o18fFFBkKAK+UaEShz4DZg1FNxU2pxHZZYzJQ=
X-Received: by 2002:a05:6808:619:: with SMTP id y25mr167166oih.166.1628021651259;
 Tue, 03 Aug 2021 13:14:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Aug 2021 15:14:10 -0500
MIME-Version: 1.0
In-Reply-To: <1627880576-22391-1-git-send-email-sanm@codeaurora.org>
References: <1627880576-22391-1-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 3 Aug 2021 15:14:10 -0500
Message-ID: <CAE-0n50YSvKm6fYxFm1P6jkmuS-AA2HTCWdsC1c==fdKJDc+zA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add interconnect properties for USB
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratham Pratap <prathampratap@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2021-08-01 22:02:56)
> Add interconnect properties in USB DT nodes for sc7280.
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
