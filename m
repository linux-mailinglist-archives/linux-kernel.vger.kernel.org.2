Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0053243D682
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhJ0WWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ0WWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:22:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F44C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:19:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l7so4623302iln.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Lv60x4D/nrcEcm4sCtEtNW+4qC7pIfvz/JXyTp80iA=;
        b=l1JdOp1Hg8fKCBpvQz9NawEiE8jvKtSoFGBqVeBs2itSH5JMqbhqSs1nsKXg23Iy2i
         DTZRvjtRyzjvu1JrFs4Y24+n8Fyc3qCO2KYDVw+SHNRkF+zLPJG7ulFrA6Pf9ctba4+w
         0xzpcl9nmZGXaiQT6G4LXZ8v/CTHN2CAub4bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Lv60x4D/nrcEcm4sCtEtNW+4qC7pIfvz/JXyTp80iA=;
        b=nOk8hUNDEvGdGRQE34omqu4jWOsUKXq9sabHlOfss0csCmkjNFgk+PiJzCS8sMNfzE
         uhusjxrw+ukwP4TjersYOq0Iy3NcjrhD4B7cB4GNqU2FGyFUpDr5WtgBlINPmGOUz3W1
         il2KBnarH5i3lOidhK+9GmDXqH28r8E5ZfMqnAg/4fhcUpLBqPgPORqbjahYSeCt9aef
         liATcA/HoX5LP4PdV1pAe8HaqzUxz5Q4dLoUYbEeJ5I+2i6UsEhNOq/Vrx+zMhXXnrET
         zw5iO2u2pYBy0l8/+czOuX7kBYddefrs3snKs0zSKzRfYURU2VT7ULSMOfMuq590REJT
         uLXw==
X-Gm-Message-State: AOAM530ZAqvzYcNCgQtjY5G16srLuWuEcT3w9Qx6aERtTeJ3BTkr/17F
        LEHqolfOdKudOGarMiuzKTCp+N/raa9ZOA==
X-Google-Smtp-Source: ABdhPJxiQXAN3IGoWrAIsud9oAAliNHo7mdZWF65a2HBeR/gBD8dUgTunlN8KboLJUnEd9Z62hrFAg==
X-Received: by 2002:a05:6e02:1a69:: with SMTP id w9mr361331ilv.1.1635373187428;
        Wed, 27 Oct 2021 15:19:47 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id c4sm567491ioo.48.2021.10.27.15.19.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 15:19:46 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id z144so4479859iof.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 15:19:46 -0700 (PDT)
X-Received: by 2002:a6b:e50f:: with SMTP id y15mr165483ioc.177.1635373186021;
 Wed, 27 Oct 2021 15:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211026145622.v4.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <CAD=FV=WTQG_zdQVDFPe7u8_350Nwr9tSeWjtQO7FD-3N-JMjuQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WTQG_zdQVDFPe7u8_350Nwr9tSeWjtQO7FD-3N-JMjuQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Oct 2021 15:19:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XjmjWY2_J8b_oOz8D2Pw3mVE=7G1gGqJyHuC4U=gNBDw@mail.gmail.com>
Message-ID: <CAD=FV=XjmjWY2_J8b_oOz8D2Pw3mVE=7G1gGqJyHuC4U=gNBDw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/bridge: parade-ps8640: Enable runtime power management
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 27, 2021 at 3:07 PM Doug Anderson <dianders@chromium.org> wrote:
>
> This will also cause a conflict when Sam's change lands [1] so I guess
> we can see whose lands first. Let me review that now and maybe you add
> a Tested-by? If it lands that'll make it easier and you can just
> rebase on both of them?

Ah, whoops! I took a look and it looks like Sam's series needs a spin
anyway. ...so I'd say go ahead and rebase yours atop drm-misc-next and
your and Sam's patch series can race to see which lands first and
which needs to be rebased...

If you can add Sam to your CC list, though, that would probably be a wise idea.


-Doug
