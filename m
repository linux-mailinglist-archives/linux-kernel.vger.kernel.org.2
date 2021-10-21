Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40406436D56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhJUWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhJUWTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:19:54 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED1C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:17:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j3so2299866ilr.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JFy7nFsjIZMNP55uGrDmjFd/aEPAClHyZ68A9qIzVE=;
        b=VJwXc/ZVC5CUZLkHTjDIByqxk5osMjMN7h7aQ4J8h2tVLelV6+hHSg+C2fokH63IV0
         6JjDH/+k5hm0Wa1zOJXr2CtT1rw9Lgx1csFLw3rv8uetX5qnOvKAbqoppOk/1X0LmjA9
         LanSgLt48Y39s8M8eesZLBiMbRx19FJy59O8IPJUMsWnL2F2GFH6rtTTW/3nMhZi9W1e
         4N7ux1NhoDX4WxiT0SAi/V0RVpLO3T+fYGet6HzBsQja/TGUMBu+LiBHSbFa/BgP2WAp
         E4FYFyh7yYK5WrrEqW2W5acuqzjvt35tqac/WwS/8wKTwlHWDW97PHeBzVrOiQrh0mP3
         PXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JFy7nFsjIZMNP55uGrDmjFd/aEPAClHyZ68A9qIzVE=;
        b=rVIKIm7Nnmw6D2WdSb/dwbV8vwPvGOycib0K5djj7tnaiaGnRp1hMovpKn7JQ93COw
         l92GfT5n/SBTLrUVZd1h2/R3TY+Z+/ULdA2WY8FvtnhJzkbSuVo5gRYg7U+eXE3CZ6rY
         BofGzJ6RPbNfOlrcznPRXbvaGLskTwN9KH0vNWOVHeDQeswF3mbMYYabcNYTMOG7Cbkw
         NFwpHwTBvGS9gy7FVMeaNiXS05A2ZVNPL86vyZcnhxo99bqYurnVFFsz419cDn4OR8N+
         LIGPyIbIeUi03z9x3oodHBXUisVrduyZL4NBVWS/plQtf0uGHsV58o/49U3GKHVkgxHk
         RkuA==
X-Gm-Message-State: AOAM530z7DN0+WZ2gDi7zOcvHIhfJWyFp1m06467RO6a6jWOOIaS3Kdl
        x5djRhEbJCQSr24rQ+3tXQ6P/658MZqloRDJK0woFafb
X-Google-Smtp-Source: ABdhPJx0mfzu48SPB409ri8FD8LFbjnP++KB5aUwmbGYPDe4M7XG//1LxRB/ZWhs2SmvBnpWShOtDJW+arZBbnD1TMY=
X-Received: by 2002:a05:6e02:2141:: with SMTP id d1mr5461706ilv.5.1634854657619;
 Thu, 21 Oct 2021 15:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210729072628.68838-1-denghuiquan@cdjrlc.com>
In-Reply-To: <20210729072628.68838-1-denghuiquan@cdjrlc.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Oct 2021 00:17:26 +0200
Message-ID: <CANiq72=stJrc8iRTyFuPVc2_3tmDj-a78y=Nb0+fFYtqEqJ3MA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: code indent should use tabs where possible
To:     Huiquan Deng <denghuiquan@cdjrlc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 9:27 AM Huiquan Deng <denghuiquan@cdjrlc.com> wrote:
>
>  static int cfag12864bfb_probe(struct platform_device *device)
>  {
> +       struct fb_info *info = framebuffer_alloc(0, &device->dev);
>         int ret = -EINVAL;
> -       struct fb_info *info = framebuffer_alloc(0, &device->dev);

Applied, thanks!

Having said that, I fixed the patch to avoid moving the line above around `ret`.

Cheers,
Miguel
