Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DABF40ED14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbhIPWGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhIPWF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:05:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3152C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:04:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c8so24515663lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5Lmg3iciAlrjDC4HYZ2C7ch3bH7MUVQ8/StYpsobIE=;
        b=uyRunCrojHHgndv9BlQ2m1MYLAdoTFpcREv/G0+LkWkQwMrb5TmbVV45+d6AARDajn
         LHnK38ZNktHwjDAy96X175bBEs05CMkqLMNtsq0yXjGjZ3bT0jE8+pige7aOc8ZexADw
         FZnYNMPC2WtHR2uqoAuWqZmg1gK5CXh6rrH6bPHEb14LxLDdSkypexUfSZYyR1fDjCAH
         99W+0TKpY8lyQOx+RhgpCqjBRgJDZ12waxlU+XXJsbrJxqQQyqvczRqf/lN8epXDp3Yt
         NvaOB8iQE3qtl1KFvL3zghOSiWK/HrhVgk923F2PHSzhnKHVtjUg3ep0fFDhDy9hf8h5
         CRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5Lmg3iciAlrjDC4HYZ2C7ch3bH7MUVQ8/StYpsobIE=;
        b=EUmHHOrdOCTLZq67xPx4+o5ELAXfqsmOYVTfw60zvWQlD1GTtz2AKTEU7GSJszh2lZ
         TVAhsK0mXX8U7EpnEch2sWNnNhc+PINVamTle5HRDNb6hwRGP1+ztCTgmFrmh3BFxrju
         WirlQHdttCJBUArFyBa+0u1t2xDduHepQhbse8vIpCX8we8EhN+h4bu45Dw827q82nfO
         A+w4rVJK6n+xl6Wbo0LAQeqjH09QN2D31UYIN480sIueLHwZYA1gmDiSdyPtGLPLfw/R
         iPZxZFvzG05VuixLWrO32oIkNjVfquqNy3HbRAf+4X3WtA7UyqbicFa6FRGyEhG3CCM/
         CG0w==
X-Gm-Message-State: AOAM5327Bcn6THAXTqFSTWfIafGA4GlW2S8kOtS7E/aTOC0t2Okd72aN
        ySE3hFnC9mxUwggpSlmNjcTTuNtOtwUmF1lPX/mFlQ==
X-Google-Smtp-Source: ABdhPJz+IOU7LRAUnUDDYa/u7Us4BS0iYQAVccCjV8lzjn3X2MhHKjEqsVxjTkjJaZ09pjLDZo5XcJYChjHD8k22cEQ=
X-Received: by 2002:ac2:4d03:: with SMTP id r3mr5891598lfi.339.1631829874343;
 Thu, 16 Sep 2021 15:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <8b75e5dfd9363f35ebdd7812e119757379678f97.1629877281.git.michal.simek@xilinx.com>
In-Reply-To: <8b75e5dfd9363f35ebdd7812e119757379678f97.1629877281.git.michal.simek@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:04:23 +0200
Message-ID: <CACRpkdZd6NfvVXGYsuqbOEYZ28brQbqNRXYWqCtg1Bei6w4jUA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: core: Remove duplicated world from devm_pinctrl_unregister()
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 9:41 AM Michal Simek <michal.simek@xilinx.com> wrote:

> Remove duplicated "which" from devm_pinctrl_unregister() kernel doc
> description.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Patch applied.

Yours,
Linus Walleij
