Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197A740B495
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhINQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhINQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:28:16 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64950C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:26:59 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r4so29553101ybp.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M76dEsuG69ayw32JhIfhlHZS7uBRvbcdrb6f1kH90Qw=;
        b=V+Mtue6kXbRncaVsUxk6LcYAHASPeGZsInVIY5z6pb43lPml8uX19Xcu8WOUbVPU91
         +ZvmQfk+0DQpZ+XA5FGATRUz302GXJuFvMRKU/sX8vCkmxz5C2GQxtM42Mo4TGW2D9XF
         y6vV/wywkH/GCTIonsgIc3VvXbxvtpeNhOTECvySUezRquag0Fo/StvsJXWpPUt6C/Dk
         BoPsILnOXLCIfk+hNF1nqJwA5ExgXZt/VGw7HiVFBz0zVH/ryTxk8WMQ1MQL7sxOqBmU
         rUgS3lYXSOHrK952qDPQtUsu2qUCACdg3552nZH5KSBRu9n1TVm9uupz0EYgdz/hn3nD
         b3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M76dEsuG69ayw32JhIfhlHZS7uBRvbcdrb6f1kH90Qw=;
        b=sBLbiEFYqkqT3QxS2DdS6yUqyWe8BsCMbwEYqGbM+hcls/YLZC3G2OtubPOHPExIak
         SlFBjncocY/WRACyBBTgQQFpDq0Mxvl7QYgT9UoWscvip1Q2qIi75f1KbzbwvOqnuDCH
         RSDj02zKOJky0y2MCHP2YuwKekXs/4/1XlRvXNfmnd5M+SBdiGIrxbSuCQebX60IG4TT
         dopKHTZ4E+Es/EZdicCWSzkKWx+aeYR/4OBhqFq/TP+0TFqmllLyNfutBJ5/t8E6KTrx
         VLNAdIYXHnJTLYxAuF1aqf3HbyQ9xNQ2q8/h7i1QA+3JgyjvhsaCfumKUG/jwbkl+sMm
         pouQ==
X-Gm-Message-State: AOAM530OEDFZHXsXh4gF9L3q02HqermZGHo+QA0r+8S4jqAJY7ygZqBw
        3Dpv/1NT/Z64iI6uRcM6k+0hlFuC29Qna3PbTgFqDw==
X-Google-Smtp-Source: ABdhPJwvZaGWva3B2JOje2V/PctRIZ3IVxNzWIuHfWQHaClbmlJfFd4gyW3ewLpwcdsWWo9NFWTt0EZ5CWhUQnth7qw=
X-Received: by 2002:a25:b09d:: with SMTP id f29mr22849855ybj.257.1631636818329;
 Tue, 14 Sep 2021 09:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210914032252.3770756-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210914032252.3770756-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 14 Sep 2021 09:26:46 -0700
Message-ID: <CAD=FV=W7uTQ0OZ_YV7UU-4pGinuX=huF1SkBxfNb2R8T1Dx5Tw@mail.gmail.com>
Subject: Re: [v6 0/4] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 13, 2021 at 8:23 PM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Compared to v5, squash this with patch #3 in the series in
> drm/panel: boe-tv101wum-nl6
>
> yangcong (4):
>   drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
>   dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
>   drm/panel: support for BOE and INX video mode panel
>   dt-bindings: boe, tv101wum-n16: Add compatible for boe tv110c9m-ll3
>     and inx hj110iz-01a
>
>  .../display/panel/boe,tv101wum-nl6.yaml       |   7 +
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 745 +++++++++++++++++-
>  2 files changed, 750 insertions(+), 2 deletions(-)

Still seems OK to me and you carried my Reviewed-by over which is fine with me.

Just to give others time to chime in, I'll reset my snooze and wait
another couple weeks. If I don't hear anything then I'll work on
landing.

-Doug
