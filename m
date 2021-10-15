Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC642FDDB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbhJOWJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbhJOWJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:09:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261AC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:07:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y30so25696222edi.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfrvNfe8cIeMC9VL0sueBqNC1Hm+TJOvlEdZe3LO7Ak=;
        b=HNDT+KKahn+9l5vdegEbLOmNFbvNFNqWXYAWDhkbdEYMUNc/sEM2zBM8ujgmkt1WGl
         89NRQPZhMD0ctuXGU+8CRvEOVew/tfir7xFaWIqc2xhSIfMJPuYg/Rc+oJgAZkwB9RSh
         cvYnyZyiFRKlO0rHaZE4k4T7gLLCYxPKSgo0SPJkOyNiVvCeCZtmQLqhYDHKmwI9J/XI
         QeNxx0vJwHyqLuH+RviME2mk+XJeLWPHpbSN6vlCFOd0qPtapsGeZxChswmdFOZA1nRZ
         4iPeHmBImFeWi4y82OqUmHN9vBxXPWimcGeQazGafKvDJnqZUi9yVQCgTQSULTqVjqzy
         Tr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfrvNfe8cIeMC9VL0sueBqNC1Hm+TJOvlEdZe3LO7Ak=;
        b=OudxaCdjIiBbTJXFNzk+YJaGAwnylDEwASenq+P8++lig8KRAxsKkSOUaMVQFhHu2w
         EF+ED6bsGsNTQmz2Gvc4aSs39RVgYiLi0Wj5kqE7Wf1V0KwSRNQj9U07UmGNQdv39lEf
         2kiwZJsNd+Vy2p4Ca0i9UP5loJpg0chY4AbfqFtuWo5OVcb+kt5/iZU28eXhPr2vdHSk
         LHtC4gvVMZV1UrAJMChRAsF1B7RYAaa3IH6osZQvzpr/yGVzuqk2z/ACVsgZLANmky7F
         0jQGMCcxzRCvPeymS9zEgRympbLLn40PbkFmIJIwFwcr/0BsgLd9xHHZV494hD1LP4Ta
         yZXQ==
X-Gm-Message-State: AOAM533lch3Hpe16OayUn2VPa2B9TQMK4rFehmVqDVGNEFNTbPExxBLd
        tuXgz9JJZTOLr0BivR1hbwBgMjyyw+e1S0QFHnQ=
X-Google-Smtp-Source: ABdhPJyiA3feuV5RcRuc8R/2D8DhxlO3N51TUr3uX065PKdazoD72Wacb3BIrg/vh2ntU3s9aLA26Fsrl3E/ZH+5MRk=
X-Received: by 2002:a05:6402:3186:: with SMTP id di6mr20882798edb.225.1634335662519;
 Fri, 15 Oct 2021 15:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211015141107.2430800-1-narmstrong@baylibre.com> <20211015141107.2430800-6-narmstrong@baylibre.com>
In-Reply-To: <20211015141107.2430800-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Oct 2021 00:07:31 +0200
Message-ID: <CAFBinCAqA1s--b-iUYe_Wx+rVU56uiMybe2kYSxYOZUXtOt6jA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drm/meson: rename venc_cvbs to encoder_cvbs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 4:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Rename the cvbs encoder to match the newly introduced meson_encoder_hdmi.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
