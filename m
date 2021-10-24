Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0E6438C14
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhJXV1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJXV1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:27:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EE4C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bi35so332154lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJzHF/Z5fjP27mQA1nxiLi/yTI4xtj61op5B1TuJ3fM=;
        b=JUH7zF8hHI+MToSfVcMh/cTdGxkOximv7meXju66VAwbJSkiZLFr16B736nOIVlCpa
         c1HSZBPsypTgwn4o6WPBFkkPZjyNvt7grmfFmm2opWqCQv0TXW7Myq0F8QJxz+yHz8mI
         R5VhK2W/NU2dmp15mTmO6rPh9qgPhBz7Ezjrv5/b7SrO3R11PJAtR+IlNHuQIs5mTodn
         a40cOvriUHccOc19z4iLZoodLBPILC1qxTiW5yWaJa7KwgqI9zruLo6QNoT32JahzGLK
         Gb45S0Jew+xgl5GGVp5ri8fODC2YvxxGr76eb5aZG6uwg3Osntie2arMB0DoSDtY2kxn
         jgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJzHF/Z5fjP27mQA1nxiLi/yTI4xtj61op5B1TuJ3fM=;
        b=zdJuLyUussckD2BjIFlW/Bmc8fsgE6A6yzgHo5YQj1gxC7natItgir8ykNf9hO9X8U
         fGpudMY29FwTcbkJBZufVd2BYtybeOSnBOEFkNUFgLUnyTPXyXMgVmsljA1RyxU2z0/9
         jxV1WAgLfqHE9cU15ag3kCO67gGvTspGXztdUkXNqjn74ACjhdvGI/Yn/02L5BclVHk+
         iYXQF9ISCKIqCJtn3b59iqaNNXoQdnB/2ebjpYhELuI8GzM3mXu240AeJUMRBcbGX7K5
         DsBzZo7NUnzl8+KWqCq6Z/Ur0Y6gWZKDNX3V/evEOXiu+rM91dKwGeSl2BAPTVleBkr8
         qqng==
X-Gm-Message-State: AOAM530cFtL4XvVjzv8M+cA5k0udaMPl3cQ/dvNGO3RpuOCrEOFKW5tX
        /fnmgidY+X7KMt9it/xd4LXeaWlqenUEFTmhl8F4sQ==
X-Google-Smtp-Source: ABdhPJwt8o9K1DIszxN50TffhxTaQ1oO3M2G1LgnK0x2wMJGhMOsGef7TeP/cw6Sisz5Ih7aFrtZZE9PxXNMs3rMAek=
X-Received: by 2002:a19:c10d:: with SMTP id r13mr13151970lff.339.1635110726022;
 Sun, 24 Oct 2021 14:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211018121815.3017-1-pshete@nvidia.com> <20211018121815.3017-2-pshete@nvidia.com>
In-Reply-To: <20211018121815.3017-2-pshete@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Oct 2021 23:25:14 +0200
Message-ID: <CACRpkdYQMOAPdQaOb9TXtQmr5ez-xhwDguYusiGxK4DCHHX92A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: tegra: Add pinmux support for Tegra194
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Suresh Mangipudi <smangipudi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prathamesh,

I don't have a maintainer for the Tegra pin control driver
in MAINTAINERS, and I have seen different people contribute
to it over the years. Definitely Tegra 194 should be fixed up
now as it's been around for a while and it's great that you're
dealing with it.

Anyways I applied these two patches for now and let's see
what happens.

If you're working with this extensively maybe you should
simply list yourself (and Suresh?) as maintainer(s) in
MAINTAINERS for this driver? You can add Thierry or
Jonathan as comaintainer maybe since they made some
patches the last year or two.

Yours,
Linus Walleij
