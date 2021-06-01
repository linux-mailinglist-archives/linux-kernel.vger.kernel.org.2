Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ADD38F380
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhEXTLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhEXTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:11:38 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8414C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:10:09 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so26240508otc.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=um2PPLRd0NGsUxBqyX+FbZVlwJTb66L6CWE+yk59KOs=;
        b=cBcMduX6TRRUpe+jEH8fQPaayH6V8RcqkLcmDQzkr9uBEKen5OnbjnnSiW9gTtjHwV
         ftRP9JTMOF31WsuGFbWqOdquRsA3S2jEXQPI6T0QxM12lKAALEA2cXQ0vQs89QXrV2H1
         DMSeiJnifKjcCHKbLzfrC8H+cYc0Jwz/QTMcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=um2PPLRd0NGsUxBqyX+FbZVlwJTb66L6CWE+yk59KOs=;
        b=c+h/3SzGYcoQAcm4vXSGetW3caeCbWSNNAq8QTxXPqM6UJ3dC8X9c7Fz4gYF5g9h7k
         KFDvVeEmh6KYcuBHhtvEibc3DnrRkO+YV/ia6KDqm3NghF6OS31wXrhHHhzOco+SkG3J
         SOo+S7JFwqScCuY7zI2XxtI0JYHk0VqzKS2TSwUH7+HQuezVg5Gd3lHwRblRvzhBLR83
         wtgWxueXczbGaOMfE5KwXaC4YOaZBzOJO5w0Gs077+WWgJ3ZFiJc/uv4t9TwcctdQYgA
         /x1YUtSF8IQa5LBKlpdRNSB6OYxp8NhWi/flytyvY7OAzE6kyTXeKYtNSqc+KRJXpUvK
         bMQA==
X-Gm-Message-State: AOAM532JnM+H79y0LXulzaCGV9t2Q6rTlSKJ8MVN89xcMzLuTM/wY9zO
        nY6b29LpEQYzZwUb3eNL20NG3PcBbH7iEU4t/8dHhQ==
X-Google-Smtp-Source: ABdhPJxTbpmjuA2CnIS3DZHUaKp1uaoBatpXP+OC8g8oTA8tNGzR7meC6kVssKlmSugIRxojjEmZ+CAM0uejvhm7Rv0=
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr2407750ots.233.1621883409262;
 Mon, 24 May 2021 12:10:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 May 2021 19:10:08 +0000
MIME-Version: 1.0
In-Reply-To: <1621635930-30161-1-git-send-email-khsieh@codeaurora.org>
References: <1621635930-30161-1-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 24 May 2021 19:10:08 +0000
Message-ID: <CAE-0n507ahZLDbtfo-s+goBd5kUqBQ9hTqeoCvk1mNb9=XB5wg@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/dp: handle irq_hpd with sink_count = 0 correctly
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-05-21 15:25:30)
> irq_hpd interrupt should be handled after dongle plugged in and
> before dongle unplugged. Hence irq_hpd interrupt is enabled at
> the end of the plugin handle and disabled at the beginning of
> unplugged handle. Current irq_hpd with sink_count = 0 is wrongly
> handled same as the dongle unplugged which tears down the mainlink
> and disables the phy. This patch fixes this problem by only tearing
> down the mainlink but keeping phy enabled at irq_hpd with
> sink_count = 0 handle so that next irq_hpd with sink_count =1 can be
> handled by setup mainlink only. This patch also set dongle into D3
> (power off) state at end of handling irq_hpd with sink_count = 0.
>
> Changes in v2:
> -- add ctrl->phy_Power_count
>
> Changes in v3:
> -- del ctrl->phy_Power_count
> -- add phy_power_off to dp_ctrl_off_link_stream()
>
> Changes in v4:
> -- return immediately if clock disable failed at dp_ctrl_off_link_stream()
>
> Changes in v5:
> -- set dongle to D3 (power off) state at dp_ctrl_off_link_stream()
>
> Changes in v6:
> -- add Fixes tag
>
> Fixes: 94e58e2d06e3 ("drm/msm/dp: reset dp controller only at boot up and pm_resume")
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
