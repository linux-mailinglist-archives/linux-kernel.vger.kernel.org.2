Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F895405CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbhIISMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbhIISMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:12:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E9C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:11:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j12so4333471ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w4XX6yR0QzRiZJpSGde7fWq2eAjHlmLHnFHbdMV8Zw=;
        b=f8cWzc+qPXq7JuEevYzkWEktyjooBtzN5s+4yG2cN4TTsZYh2v6gDrh7DzBnD/HsUt
         7dG5gNYf+VAJHqprxMeXXmPbMSUowyhN0J0ScQ9rgrLGtjM7perzG3nqOrVNByGfv7m3
         a2Oap21jix6+PYdZXqkBY6EVh1jxBOES7Uwbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w4XX6yR0QzRiZJpSGde7fWq2eAjHlmLHnFHbdMV8Zw=;
        b=pxs8h+lQsHPyX06noUMgpN0Yr7R+cyzuGYPSOUkLvRs3r67MpGUYzMkeVJ8ZqY2yyK
         NGUktzhRxk7d2ggAO/L3y2KqkTgh5AZW3ZBr7Wjqsa3PZIdIisTnKYOxulovojOwbUrk
         YCjo7vf8GNDUebmKnszjdFFL2PN3gRYB9rSUOjoU4qCSbUx3PzxqdyAvDpbqSKvAJG54
         Qk5SoamNxr2U3WBPdzbRcPDilVfmuN20TYsI93Jgn9aGBQ3kxZS2HzLoGdQc2MEfCwf4
         GnOBOAnkeXCuAdGnkrM9IMLj+f+huyZXjGchM4H18FIkJriw6bQilfG8X9LvJOPfeazi
         9cxg==
X-Gm-Message-State: AOAM530ZNl4jbm6CU4WHjXhSOvBxhgFRtSISSPWN14yf8MSm3MJK35BQ
        PTsBWBlQW44gc94Z/MbEUcdEuMsk08ks66slvtM=
X-Google-Smtp-Source: ABdhPJy0fWxkPwZOrQz8MwMSnDnzJRVHIOwbkpMnw7q/3rXNpgUNic+m10HWKE2pMK1z5uhY0ZSc2w==
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr908334ljo.171.1631211079799;
        Thu, 09 Sep 2021 11:11:19 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id p14sm274831ljj.140.2021.09.09.11.11.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 11:11:19 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id j12so4333373ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:11:18 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr899668ljg.31.1631211078697;
 Thu, 09 Sep 2021 11:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <YTg+csY9wy4mk035@matsya>
In-Reply-To: <YTg+csY9wy4mk035@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 11:11:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVLppF6shSBiKK7-B7FRZ3UP_sMVKcLvtRs8AQM+k2vg@mail.gmail.com>
Message-ID: <CAHk-=wiVLppF6shSBiKK7-B7FRZ3UP_sMVKcLvtRs8AQM+k2vg@mail.gmail.com>
Subject: Re: [GIT PULL]: dmaengine updates for v5.15-rc1
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 9:39 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Also contains, bus_remove_return_void-5.15 to resolve dependencies

That one actually has a commit message with explanations about that
branch from Greg.

There are other merges that _don't_ have any reason for them. Like
randomly merging 5.14-rc5 with no explanation.

Or the three random "merge fixes".

Please people. For the Nth time. Merges need commit messages that tell
people _why_ you merge, and what the code is that you merge. Not just
"merge tree X"

             Linus
