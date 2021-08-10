Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83F13E855D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhHJVeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhHJVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:34:09 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745FC061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:33:47 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id y14-20020a4acb8e0000b029028595df5518so82846ooq.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=K89ryxZKdGzSi1l6ZgbY5SW5/B4L1gkXo7ILZAccfU4=;
        b=iBzrlbp6mNut88ED6fWJqIB9hl9saDzoC0ziK0cNST5Dd4rpzrrfFer7Ih/9Wm+rQQ
         3c0d9XcwLXshbkR3X5DbIRHOytVjh2ZYKOq+DRRa1euJMdl5rNdXD2Y4zPcXTn587tsM
         yQtL1P8eTdlE5WsraMeaSEvpIQigKz8gi2cW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=K89ryxZKdGzSi1l6ZgbY5SW5/B4L1gkXo7ILZAccfU4=;
        b=pmCcDOdoUF7yBPnOCw4MQV6oYzKQrM0lKAHn5dXv9Y6Ta194xZIojh3WcgcvoDVW2Z
         mHEQ2qkYb+pzaBkTqRAXj+JgeV2AsStyEJtztX3LeD1WkXM7V3QSjM3yqOIOLvnhNDzJ
         iCn41kyTZcF4bVWlZ1jXJ93Ly3v44xeqePxqPs+01iTkmehGg2q9byuX/LApEYagiysJ
         rzWZfJflqnbG3Ylm8iWiJVnzNr7Yx4p/5lF0wwXKBKsBbwnsgF+NLBPeHlxGd3oXk8zf
         oQpgHKWvX0/K05X9OnAa2Cd+YNYmHFFc+iL0blj3b9nFEObNXDGaXlTunJe9dJxB2hxE
         Ne4g==
X-Gm-Message-State: AOAM531Gj2CGDv9yhGJbUaMnrYRTxxwUlphWt1n7WNy+5a/mn0QE/LyB
        NF5Bm1TltShZQbeXDrXbhwupmwJcCbKkCjYH1qFcyw==
X-Google-Smtp-Source: ABdhPJzMSqm7mlJWw7m6cKtMxq0odiWwUHDwLozyyqB71lusEKk+/E8sZ86F1JfKGqRqGY8ymvo2r2rYgeFoZrYEHrc=
X-Received: by 2002:a4a:c60e:: with SMTP id l14mr18621189ooq.80.1628631226738;
 Tue, 10 Aug 2021 14:33:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 14:33:46 -0700
MIME-Version: 1.0
In-Reply-To: <1628196295-7382-5-git-send-email-khsieh@codeaurora.org>
References: <1628196295-7382-1-git-send-email-khsieh@codeaurora.org> <1628196295-7382-5-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 14:33:46 -0700
Message-ID: <CAE-0n535+OOwQ=td-ow71MPZNq4=DFjP+hLEvrE1ZaMo+0j1rw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] drm/msm/dp: replug event is converted into an
 unplug followed by an plug events
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-08-05 13:44:53)
> Remove special handling of replug interrupt and instead treat replug event
> as a sequential unplug followed by a plugin event. This is needed to meet
> the requirements of DP Link Layer CTS test case 4.2.1.3.
>
> Changes in V2:
> -- add fixes statement
>
> Changes in V3:
> -- delete EV_HPD_REPLUG_INT
>
> Fixes: f21c8a276c2d ("drm/msm/dp: handle irq_hpd with sink_count = 0 correctly")
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
