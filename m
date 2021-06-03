Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532E439AE8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFCXWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:22:07 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35633 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:22:06 -0400
Received: by mail-ot1-f48.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so7421530otg.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 16:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hQgUp3SEy3n12KWwuAp4G7saP1ifGjcDT5qP0d3bq/E=;
        b=dMw4w7yxFEkhi6vIaddcnLjcLM9HD7Bdor+5wMklitaNgESzmyjwbVCYp83kEgr808
         KSntBQqo9bbbM211K4tkXi9sNUjE4f4PhDVmPJ/Rn2H9Hth+OVAUF0PFVTncL9x5lUfr
         5ZkeZ6HA0BvpA07a1Zaq9BDmGimZBL3vm3qpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hQgUp3SEy3n12KWwuAp4G7saP1ifGjcDT5qP0d3bq/E=;
        b=n5F4IaJ+RofQN5nPL8wYLP6zZyfXtjboCgbJEkJ4rEpfLtltYmUIDmPdBk5aQTsDxH
         5OagcbBCupbpIl3+NpIo2+On5avTfUIumxqdpGTViUsOSn79amFp5fyfNRtZMr8lqdjX
         0z8qkODtpynDGPOv10vnUQ1C0e5ueXGlYlMihytAtJqPW02wInx9gb+4BnpJthN3P1ol
         NH75RRu8XQM7rGIFbLCtoZDjgRlOcaQJaZUgA53+EAoCG3p2Qv80plDJMfvIGmTF+L99
         jrv61KeesaLHibFKTWWivD+AmpdnhJbbSykxU6meN2Vk94hZnIK+wYuNUII4P7vYE6rG
         L7gg==
X-Gm-Message-State: AOAM531reWDQekBRQaYxwR9btPOehNnK4gXUmEuJr3vLSiWth+/4fvvV
        NaLHmjkNCcw//hLMSxFHPcn4T2C/VnuVl7dTOs9Gvw==
X-Google-Smtp-Source: ABdhPJxzdb4WdqDahQ8sBCMrVHSxCw07OebJeAIROoN0SDmUX2m3leUZaXQLLfQu8qBsngegdJHo3AzpwpdErBvGuxA=
X-Received: by 2002:a05:6830:1f51:: with SMTP id u17mr1428545oth.25.1622762347800;
 Thu, 03 Jun 2021 16:19:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jun 2021 23:19:07 +0000
MIME-Version: 1.0
In-Reply-To: <3f62fc2142f6089c43ec3a4b7b10cadc@codeaurora.org>
References: <1622734846-14179-1-git-send-email-khsieh@codeaurora.org>
 <CAE-0n51-CsHPwYmceUq1kTaG=L+ifG3kX2pxJxTG_=r4Xm67_g@mail.gmail.com> <3f62fc2142f6089c43ec3a4b7b10cadc@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 3 Jun 2021 23:19:07 +0000
Message-ID: <CAE-0n52P+xZwL5xWnEnj3qQpmrhhLhXnaYvJST_-NM8hnXZdvQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/msm/dp: power off DP phy at suspend
To:     khsieh@codeaurora.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-06-03 14:59:49)
> On 2021-06-03 13:22, Stephen Boyd wrote:
> > Can you Cc dri-devel?
> >
> Sorry for dropping this cc.
> Should I re submit this v5 with cc=dri-devel?
>

Yes please. Then the patchwork stuff will catch it.
