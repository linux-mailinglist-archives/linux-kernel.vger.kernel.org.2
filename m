Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4D38D07C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhEUWEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhEUWE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:04:29 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF35C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:03:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t24so5531143oiw.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=pzKNRkHD1GNhytbNm0qyC8uugnjVx+JEcDbKcGF2mAQ=;
        b=hzRbJzokd7znZEEz7ntX4xnel0dSN6jBODhNY0TlfutlGOd6LP91lj3MVcyJH4oiId
         XL4+TWRp6BNs8ygjz7cWTvVAJN1XzqlGmRHCNBZ2K0EwFjHijbt4hva1NQ4Nu0WhuKqi
         sbyYhmrB9qP+BmnWFgA0iPDaW+LfVVPsb7TVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=pzKNRkHD1GNhytbNm0qyC8uugnjVx+JEcDbKcGF2mAQ=;
        b=CwnvrVn7N8CdbDr9+5w7vWv19/LIgmJGWgUl/hQJDXQu7ILRs/QDZxdaQN7r51pAb9
         d/LFSLjnrw8MQzBsqN5OS7tk5ACh6viIdI32R5B2AZTool3x1kd1rARjgabY8wT9+liu
         oYRb38YdEbmkVjSSd0UzwIXHMSlpcqHfERVyl2s1QHLLX1xJ7oPe7E5//V5+MtXn/807
         vjYy9v0TVUvgnOjWeKGmjMxoxxxDRWUfSIYv8+ENOgKqJ2402FAsnBWhxmwDHMuayrU9
         aRwlU6eB3a1csxhFyoXbKPcX77Hoc/tYHqlNV3mjZRNLpZxbhbGBg0JRfomx99X3uH0R
         lqDQ==
X-Gm-Message-State: AOAM5328F6n+KdZn7sIgFUJaoKT6Bd+lDp8DSncyKSvYYtOE7FLx9KSd
        WOBM5VweqJQq1EeCUhfleRLRnQNz0PCV+F14dpgIaQ==
X-Google-Smtp-Source: ABdhPJxzZeFCuvEHHfr0jh0BGj8DNe0c+fJulfyLxZyDQ11XRo+6BhrT+IckpYwjcPqigqEUwkDVDNUQ7PR0eevvL4U=
X-Received: by 2002:a54:4501:: with SMTP id l1mr3716630oil.19.1621634585134;
 Fri, 21 May 2021 15:03:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 May 2021 15:03:04 -0700
MIME-Version: 1.0
In-Reply-To: <20210521140031.2.Iaa641db08ce7c571860dcce13e4ce056008b711e@changeid>
References: <20210521140031.1.Ibaca694aedfaff823feefa06b29ae746c641dd1a@changeid>
 <20210521140031.2.Iaa641db08ce7c571860dcce13e4ce056008b711e@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 21 May 2021 15:03:04 -0700
Message-ID: <CAE-0n52GEV=1=-mmHD-A4fvMG+VHD13=WOCHYs+hcM+acPZOdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvmem: qfprom: Improve the comment about regulator setting
To:     Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-05-21 14:00:58)
> In review feedback Joe Perches found the existing comment
> confusing. Let's use something based on the wording proposed by Joe.
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
