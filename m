Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C49364F56
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 02:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhDTANH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 20:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhDTANG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 20:13:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC1C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 17:12:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 20so14726876pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rt8J787jpJUi8pS/4rygI7oi39vcDhX8pZHJCQEjJ2g=;
        b=ETVqjHpaUwEnXm35E2Hbo0RWmN8d5hdAm5Lrd35VphxFcV3UEgEvQzE6CPlXstKI69
         rCrBzMbjQeQ4cqhWUnYYJ/CZyj7Wz0j3H5lzsXAcTN6PSJhnQKvqBscUMYU3rzJGbGHC
         VW9F38yHUjid7vtd8kqUX3i9Q/ArxYd2mcGVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rt8J787jpJUi8pS/4rygI7oi39vcDhX8pZHJCQEjJ2g=;
        b=qMuu/Z9q/5iFA96DfAL+Jdjd9Os38CSKDVqdOXCj4ws4ebd5TtySdZxY/PCp5jNlhQ
         9qwjsm/pG1XQAOKNgCc4fBr4tzrB6KZYdD/48Uub7YBAaZI+XG9dwYZccao3FBY8pr8x
         6+T1et85WC7vHCftLI5Z1nFHs+pkeWKZUg/xBmpASh3GbzcEaTrfHojINm3aDNffvlUV
         N/hsIBBY5VYsxaySdKqgWRX/jMmC1fAonhFyyifLvVlDEDf9/pKsa2oTuwTUJ9DRw9EM
         /KNSd1OeSViaHjw/HiWYvF1MGcP+HBrddKRjreAjIGVcK5NnkeIF4fbPa0/XOhSWHmTo
         F4hg==
X-Gm-Message-State: AOAM533VEXnxJdjYm/i8hVPrw+A1TPYc54jFbXwjyWEzBeUKZOMw0R0b
        IchL2wyKE6p3PAcecRnCqjwlDg==
X-Google-Smtp-Source: ABdhPJzMuxY7Hv1k6MgV5MC92Qz8dG4hDGs5Ol3MQIrCEr5wWn36KvvbFhashY380CnjJvQojUiXWQ==
X-Received: by 2002:a17:90a:f3cf:: with SMTP id ha15mr1783461pjb.214.1618877555791;
        Mon, 19 Apr 2021 17:12:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7401:678f:e510:6700])
        by smtp.gmail.com with UTF8SMTPSA id w189sm12833295pfc.31.2021.04.19.17.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 17:12:35 -0700 (PDT)
Date:   Mon, 19 Apr 2021 17:12:34 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v6 5/5] usb: dwc3: qcom: Set genpd active wakeup flag for
 usb gdsc
Message-ID: <YH4ccqivriNnXzqq@google.com>
References: <1618567313-25373-1-git-send-email-sanm@codeaurora.org>
 <1618567313-25373-6-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1618567313-25373-6-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:31:53PM +0530, Sandeep Maheswaram wrote:

> Subject: usb: dwc3: qcom: Set genpd active wakeup flag for usb gdsc
>
> Set genpd active wakeup flag for usb gdsc if wakeup capable devices
> are connected so that wake up happens without reenumeration.

Better describe things are a higher level, rather than getting into
the details of how you achieve it. That's what the code is for.

e.g.:

Subject: usb: dwc3: qcom: Keep power domain on to support wakeup

If wakeup capable devices are connected to the controller (directly
or through hubs) at suspend time keep the power domain on in order
to support wakeup from these devices.
