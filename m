Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7FD33C16A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhCOQQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhCOQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:15:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1BBC061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:15:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 184so16928973ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whezGPX07b3sUPoOpaXH07SshdzQOy4tuu1n0282U3Y=;
        b=IkUaPU2LsXGiZ9t3R2YxU0xvXyAIf4MJNET4D3qz0haaeS6DDR8//ZDuN23aw74Tod
         C6ks7QK1cXE8kzlhgAH6AJ+aYqgUmcMJUmWd4fUA51YFa9gRHB0zGLsY2uPT/A2zmHfv
         k6nZny1yCduUwtvvu3wpc599sGC7hxaA5Bb8uuU+Q/9PIreBdRhbV7g8kuw3Yf3ohovR
         4Zm4eOOu6EYB8dIX7nQDzUusdTqIjnHwV3eLYsoBuVbXQC/Dk48rHHrWQivhYhRZfNJa
         whFia53i3rwrQuP4WP9CdYpW17gmmkxX2TkancRpN1seQQa2X7wX29FoMCk7nqYJ5B/a
         PFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whezGPX07b3sUPoOpaXH07SshdzQOy4tuu1n0282U3Y=;
        b=a5Q5RujCf4+AVSUJntpNnUBJ4yGWuYtv5FsXTFK/KvWmhxBgFFG59F9p6YOf6P5gWb
         8x3MtvK8qEJoB6Xt0wo1bb6c2Ky8leKkilUmANAZN+a6N/ZIpCsJndmBsISCBnKM7BAI
         GPVhWlU6b/7pBzCxY2RgeJ+gfqruacAOUbp5LG3Tg8HWlJ7M4fbLab4tMJekxyYgOu+l
         VwK3Pz+KOoR5OkjoMjXR4VNu0eNhcN0sLsYh++soEIq0YHZJAopzI4pXf6GRJ2Jd0VP+
         NmowmyvOqFGCKGgkGAt5LxP+D+45JKjukuE1uiRTYffgTf4Pb+fHqKAWVY0a+HftW1HY
         /kAg==
X-Gm-Message-State: AOAM533QaNkMo71cSiy1G+V9rsz67o10GUraaYJ0yPgCNj/EoDRqDdNl
        Nv2N6VnguOtvXQKjteBlqdL3O+JKeaK58EdULBu1jA==
X-Google-Smtp-Source: ABdhPJwlxhBzJkkcvbojy4usCRwaY3bkBsWbXm6KSAwvyMDTAsyGhJSQGbZPJqu/Ax4MeK78p7DDeRHVotyxH9Jwr3k=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr10965708ljj.438.1615824943587;
 Mon, 15 Mar 2021 09:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210312034218.3324410-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210312034218.3324410-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Mar 2021 17:15:32 +0100
Message-ID: <CACRpkdZOFGVnOY6wQtncKW8zdxqr1nicB9rRef+QffiFTOCaRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: qcom: sm8350: add GPIO wakeup interrupt map
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Vinod Koul <vinod.koul@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 4:41 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> From: Lina Iyer <ilina@codeaurora.org>
>
> GPIOs that can be configured as wakeup sources, have their interrupt
> lines routed to PDC interrupt controller. Provide the interrupt map of
> the GPIO to its wakeup capable interrupt parent.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This patch 1/2 applied to the pin control tree.
Please take the DTS patch into the qcom SoC tree!

Yours,
Linus Walleij
