Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76115404076
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349686AbhIHVSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhIHVSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:18:04 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D953CC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 14:16:55 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n24so5111973ion.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zj8C2mmfJJ638Qd3bWay3eU4cSnuwWClo1NJvPy09M=;
        b=f+YQT8Zhcy0WJVMXuqJy2SGXi599VEQcwuateIHU89hho6VH88YCmFtNPQL7F+BwZy
         EbGX1Hd6esS8YLn7GMl5tjV7129L2lj3bnXT5O1GQCN4kS6ooyEADilIHmtURZTu9IJ5
         h8DVzEDyJOpMpGR1KNeUuiee1NF/E/avz1xtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zj8C2mmfJJ638Qd3bWay3eU4cSnuwWClo1NJvPy09M=;
        b=eVCkI6owez3L4RE9o3VEdPT1SMXOViMn/iGSUHDCIKHvi2QPrKIOxMpxlXvu2QRlLw
         ZvLMMfNKnkpq/uZM8TA14oUsZ5Qin4ttK5jh62JppwSppKJMaOp/m2/khtNVuUiY8WIS
         F283qqyZYnEexyk2ke7Zw9OafrL5G2zDHUbtQZYCFPYfeBUhIGs/JGm3d6OQ4S174yjr
         STQq8MhH8aeqdoHZiLOVKl1cnnYW3gzPr1ulkLRZ25SisCdNcDots0U+LtcmPf7YdiXB
         84iW/vC2EM9GnZL2vjAwdRNi5nU4B2Da6vqs3n2EP+jwTGTC78SLVOwBUR1vY1eom4nQ
         ClEw==
X-Gm-Message-State: AOAM530E8PoogtHAP4GtjKro4S9Fo3wMwanqSsVWlKrzcknVTnkhKzEr
        rkNyiZNxbO+M7WBVKuxNkbRT64cjMPyRIA==
X-Google-Smtp-Source: ABdhPJxYZ6cM5JLRwpq08n8FvSFo6m8pTAvqpwPwi/DYR1FUeNg4qTNzYDzQFCNAeNR89b9eeDUqUA==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr248899iop.166.1631135814909;
        Wed, 08 Sep 2021 14:16:54 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id i20sm107164ila.62.2021.09.08.14.16.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 14:16:54 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id s16so3813113ilo.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 14:16:54 -0700 (PDT)
X-Received: by 2002:a92:c8c3:: with SMTP id c3mr171707ilq.165.1631135460113;
 Wed, 08 Sep 2021 14:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210901201934.1084250-1-dianders@chromium.org>
 <20210901131531.v3.10.I77d7a48df0a6585ef2cc2ff140fbe8f236a9a9f7@changeid> <YTUQhnt0GxYxqg/i@ravnborg.org>
In-Reply-To: <YTUQhnt0GxYxqg/i@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Sep 2021 14:10:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-bxUOyLpe+iM_6HNNyoxi6skzWK417_VE9qGy_oSWwQ@mail.gmail.com>
Message-ID: <CAD=FV=U-bxUOyLpe+iM_6HNNyoxi6skzWK417_VE9qGy_oSWwQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] drm/panel-simple: Non-eDP panels don't need
 "HPD" handling
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Steev Klimaszewski <steev@kali.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 5, 2021 at 11:46 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Wed, Sep 01, 2021 at 01:19:28PM -0700, Douglas Anderson wrote:
> > All of the "HPD" handling added to panel-simple recently was for eDP
> > panels. Remove it from panel-simple now that panel-simple-edp handles
> > eDP panels. The "prepare_to_enable" delay only makes sense in the
> > context of HPD, so remove it too. No non-eDP panels used it anyway.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Maybe merge this with the patch that moved all the functionality
> from panel-simple to panel-edp?

Unless you feel strongly about it, I'm going to keep it separate still
in the next version. To try to make diffing easier, I tried hard to
make the minimal changes in the "split the driver in two" patch.

-Doug
