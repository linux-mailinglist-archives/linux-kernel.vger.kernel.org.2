Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC07039B444
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFDHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhFDHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:48:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EDC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 00:46:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p17so11923633lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGN1e1fZoVLsGZaUqzYtHHdtjrUyCytvAb6o6aP63HM=;
        b=msrHTL2y69s+2YhUz62/tGOY+yuNUCSTYg7AhCClV9WNnzICXVziI/JAguQAmC1wqt
         JzQYum0jXmtr+9iCgwqdBn5lLZOmJlhDXHV3wIfxkqDaA1mo3QqC5GRcYjkUpzzRYgqy
         lgo1BqhA3m4EaTUOsOwC0a99cWgorgIMboTGVgXxSCm4RcwlKx5mew8lm89LZE3E4piW
         WMJgrr2t0UVMV2Zq089Dm8Cj4hs/Uf2km5Z2XzhXJNphTurkF9AhNdmGy2WT3iN7dRrZ
         wv0LDRZbQfcfcTTvFKgoHyKAkP6iX8yEomauy5oEvl2ltflW0GY5IwrbbGMd1KUeqz3U
         cIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGN1e1fZoVLsGZaUqzYtHHdtjrUyCytvAb6o6aP63HM=;
        b=SWpkvCBIUt6ccZvROI0eCaeVrl3pFDLrdc0i3zKK04XHAcAiboO+bJ5BZedifg0frz
         DYIT7PhROkvURUOeNxfP4LOiNOygLadmPm9SK19rnbPCQ/RcJHGDRlDbYQDJekOfScg3
         W0pQg/PtApwE22JS2fKvD2ZCeIrOX3SFIYi3PzXosDyaYJlH6n4011JC4ivTCF+tF6um
         onh5JQ1jlfuZyXZYUqeirDzKfvtDgH/z0YuFb7O4cRKD95fVxqTNgz/+OvTHmt3U4NRB
         OVRf+zrClokI0WGC5D+h7g4U7pUqeBVJsA+travKlQ3YeLXEH4XF8VdMfVG+GWA70DHr
         7mpw==
X-Gm-Message-State: AOAM530x2DygWP7ds/m9uDowtj96SnuujbikCop9QSJkCav5HNkwh31p
        LeIiCFUFsGIHNIlD1hRKCjtx5uj3TVahhIE/o/krzg==
X-Google-Smtp-Source: ABdhPJzzCT+RNeP+IY7pbsrAJ1fgWD4dRQI+FAzSlryTiYVtiWkwluM+NFAnLXRjMkG5dfHS0DGoYhOnadRzVoqCYg0=
X-Received: by 2002:a05:6512:3241:: with SMTP id c1mr2003330lfr.29.1622792812519;
 Fri, 04 Jun 2021 00:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210602073820.11011-1-thunder.leizhen@huawei.com> <20210602073820.11011-9-thunder.leizhen@huawei.com>
In-Reply-To: <20210602073820.11011-9-thunder.leizhen@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:46:41 +0200
Message-ID: <CACRpkdZ07GnpfYM0+9XN_Gx0-boQiNSc5ZarB=3fH2w3EuOp1g@mail.gmail.com>
Subject: Re: [PATCH 8/8] rtc: ab8500: use DEVICE_ATTR_RW macro
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joshua Kinard <kumba@gentoo.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc <linux-rtc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 9:38 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Use DEVICE_ATTR_RW macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
