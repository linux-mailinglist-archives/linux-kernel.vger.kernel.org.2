Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A6C336953
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCKA6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCKA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:57:55 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714EBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:57:55 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c19so154880ljn.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSj/dwULrjxVufnDrQsDcLS09iDx+d6/UwmJlnNd/VY=;
        b=cwcp1C80AvtIfL9vAGM+afRexbxSMIx/F8UzcDXUXvAjbsHZ9BVODU2ilVUdcFhSWU
         +I6YUwMMB7/R6WlWEBNvImQPhH0nfFqhk4yzz5CsfxD/ASFQqfV/3HPVEs3K/Fcw4Zzu
         7O4uEdZAcCZrTCQRwxbwNsdHC0vKGF1NIrr/iXZTKDXGLGQhsNQ1lTWgm589PmPHZFq0
         uIuROkxkRmPOk2CQKNvgbK0gfoLbbvxrJEi7j3fIvlss06sPhpN4mOs1U0VbHxyrAU8T
         2puFwQYR0JaB9Gmi/fgryrhzashcruX9FP0JVtx/JBwBkNOzixksH+yXU6owoamCJTch
         KAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSj/dwULrjxVufnDrQsDcLS09iDx+d6/UwmJlnNd/VY=;
        b=LfThOVwMaMnyRw8xc0D/qDKGn8PipBebfXw3Ch+/bZsXFtbXmOMVcaUbpxL862Vvro
         UWhb1ingGyA6VvYgjZNH6YrCdOx4lxnJzTtjj/YipcIpW2bZK9iqvJDKfWhEbKCt+00R
         VfJhhnCOr9bGTFtzBCtb2kZ0fB9Y8nx8QxiN7jNswIzKzJdWFjMDeH1/d2cKl97ZoqW8
         Vj/YaX7vE1bLyJqTqgPZJfFOQ/M1rMdHRq7ItpjH1bUjHaiZq8coLgs2RJCk01qHQ1S3
         CUFsc5pk4VAZoRLB7tRc1hin2EtcxQ+wB69FMebBdNP36DgRg+zXRhWmSX1pYUSEflnA
         2RGA==
X-Gm-Message-State: AOAM530BWS2+kzIXJb2MC7C9aKeUAloMqRKkeY+PN5FYMN0JsOkoVb5w
        n0LEtfH+P9uUGBA5fMZMiZbljzg5X+OuSEVSJS9Xhg==
X-Google-Smtp-Source: ABdhPJysK0fExuH+11P9BQ/mtsfyGAM+Hu/0JEYndG2PKhUbYZml/8qS4OKjWWklTW1wK9sNp3uwaa/aE7+sFct5t8g=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr3331922ljc.368.1615424273882;
 Wed, 10 Mar 2021 16:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org>
 <CACRpkdYUs2W3b_u8YrmYwq_kcUCf0DhZ-o2o6O2EmU5rdtv=BA@mail.gmail.com> <CAD=FV=WDVAj+OcVXaTJRUu8tvdDzySW0KOfiGqZHi5YvP42BTA@mail.gmail.com>
In-Reply-To: <CAD=FV=WDVAj+OcVXaTJRUu8tvdDzySW0KOfiGqZHi5YvP42BTA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 01:57:43 +0100
Message-ID: <CACRpkda1Ast1cqNfVJ_u6zs8610DWSQGykPt4yBw+mFZFrUPSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/panel-simple: Patches for N116BCA-EA1
To:     Doug Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:47 AM Doug Anderson <dianders@chromium.org> wrote:

> I guess what I'd say in summary is:
>
> * If you object to the retries in simple panel, I still hope the rest
> of the series can land.
>
> * If somehow this panel gets out into real users hands and we find
> that the retries are necessary and people still don't want the retries
> in simple panel, I can fork a special panel driver just for it then.

I'm fine with the retries, if it is needed outside of the "simple" (hm)
panel driver then we can certainly factor it out as a helper or
library.

I looked at the patches at lore.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
I see also Stephen has reviewed some patches.

Tell me if you need me to also apply them to drm-misc.
(I guess yes?)

Yours,
Linus Walleij
