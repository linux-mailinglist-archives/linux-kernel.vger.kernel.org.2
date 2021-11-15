Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE5452857
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhKPDSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbhKPDRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:17:55 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594EEC043192
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:45:47 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so30258335ote.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=DJxnAju8ZcoHymLSy/2zxtKet5bzIUVWZOB8Xt+TFDM=;
        b=MrYtDApAgMWv95IIbmh2ZbmKWIdvEbyaVwK++N/ANKcr1LFdbHpeshfpvFJ7WcKewM
         r3eXc4CSQJ8aLR22q9fFIKN/yy87kzTl24H/tCzYorrOHnp7C8G8W3IQvzIfouWUuMIh
         5wfp5+YNlBMIBeOh1odqjGFG4xRYoQGxUCHgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=DJxnAju8ZcoHymLSy/2zxtKet5bzIUVWZOB8Xt+TFDM=;
        b=zc+Z/PiHa4a17MgtZW6aDNydpMfR3bRAHq378TBacCN/QBnxWcxfJbTxwhGqeXga42
         bjkdjia7yNWukRv3HIGUurSwcnxVXKwCQMzKesLDXt4ZWKg4fJuK2KbR54mWF9sWIOIc
         LtHkuU91ACNoolWCwiZcaGxovVi7O9i3hmTSpVV2fyJeNo+i+5EaIxqLkdIkmHNBVUfr
         Q4Voot1T50uYqWswNO4ch6T4zzw5rl9U9UqTg7MLsdi4MRGNwN+O8vyxpxLd01IqT+Wi
         P/3ykWjw/GE0qR9fYbcwapeJUpVzN36Ueeo2EZohzsesd0tdwI6ks1JmQbEKFQ2JIIYe
         AkJQ==
X-Gm-Message-State: AOAM5322rGj1WmLLZSZYMywwVEg7IDMMNwqyIt2uVn8dnkP5sPbgdk/1
        Ii6YRzZm5+/9LEVjd9yREsDGnF6Gmx1zJ+1K8A/NaWmjbB8=
X-Google-Smtp-Source: ABdhPJxIHTJ4V0v3V0REg6nwGmuD8+3FvwcZO5Cv3CkaMLWJnA1lIGUFiTSPqAkR30MnUa8+OH3cLsFZG0TnE2Wr1mY=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr2410261otl.126.1637019946748;
 Mon, 15 Nov 2021 15:45:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Nov 2021 15:45:46 -0800
MIME-Version: 1.0
In-Reply-To: <20211115030155.9395-1-yangcong5@huaqin.corp-partner.google.com>
References: <20211115030155.9395-1-yangcong5@huaqin.corp-partner.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 15 Nov 2021 15:45:46 -0800
Message-ID: <CAE-0n531-YnSYJ+Yf8v-s3YE7LkF5i9wuBOTZPmr9DzbCM_Nrg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sc7180: Fix ps8640 power sequence for
 Homestar rev4
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, philipchen@chromium.org, robh+dt@kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting yangcong (2021-11-14 19:01:55)
> When powering up the ps8640, we need to deassert PD right
> after we turn on the vdd33 regulator. Unfortunately, the vdd33
> regulator takes some time (~4ms) to turn on. Add in the delay
> for the vdd33 regulator so that when the driver deasserts PD
> that the regulator has had time to ramp.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
