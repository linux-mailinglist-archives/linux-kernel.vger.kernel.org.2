Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42F23FB9F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhH3QSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhH3QSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:18:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD56DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:17:49 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l10so16670626ilh.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfzNrOmv2YiRjvQswBNc4WHEh4DSAzBWkoHqRjK3dy8=;
        b=d9/QBDnEGBQ72Erph/eIdUiV6qrcStrNFk8vsZVfX/3Ti4YujTKIU7L4Sh+1jCUi4R
         xUIMFcBgjHUznvgSzlDZQc1yEssjRtTBDNP4lnZpsbamDRPpqAZ9zdtlwRcHZkUgkaYe
         c+EdQRM7fY/JuLvJDKePxSHQfa5jaf4m3UvFNax4Af3yLDgHnuv8zCKbMOgJQif5PX4S
         IQLX+jo0dNI5vkJyZFAZ0++JwYOHnhUuRCfImdwMJwa3Dn2B3ZvxzAduNIOByKS86GQt
         KYQccZyCgVBRnHCaeTidrfMo7q5B15T9GSOlArFmRe2oQsPxyW4CJkXF6cBvU570u4n3
         CwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfzNrOmv2YiRjvQswBNc4WHEh4DSAzBWkoHqRjK3dy8=;
        b=gV5BNoSppE4G5cFRE9zocxRbpQtTFn4YoWTYdBFdmZdy94oerN6aeqs8wkqGDzQ/eV
         SgsKnSxYlMIM8gGOQmBLhWoEHIUpITGUm4ewQ64wKGPQ03n316lM3aclklcPk00zZVPu
         AsEESS6/TQadcaFA3cgsWl+/owMO/XSgSgjO5eiSFvFYudyoCWkORlJbr9eZ85e8ouzB
         8pn1ypsYickqr6UNxBckM0RhYCMD0WCFfY/lk50GURh71Mg6Ge/0qWNAFmKTMPiVvpjn
         c2mKtqsZC71WpduH+uSyQ1AnyvBVoS0QaFhIlfwefynRVeSZmTdMpQiq0T8aJneKO3PT
         FFQQ==
X-Gm-Message-State: AOAM533cHJLXtqiZOph045m2qlyKJOMnB7eVrc83VtGTiKmYPM8KzskL
        nFqNiM9ZNFWhi6arZqBTrzq3zQaGD7vdYGrHcOxwZg==
X-Google-Smtp-Source: ABdhPJxLPJaQvCs6nLDT2CD5K46HzLBsxGup9E2eQR5G9BwCq+36P/T25Gy8JNWJbkdm2pmzlGqOEWHmYw7KDSK8JDc=
X-Received: by 2002:a92:cf4a:: with SMTP id c10mr17367601ilr.269.1630340269053;
 Mon, 30 Aug 2021 09:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210830023849.258839-1-yangcong5@huaqin.corp-partner.google.com> <20210830023849.258839-4-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210830023849.258839-4-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 30 Aug 2021 09:17:35 -0700
Message-ID: <CAD=FV=WcvanAAjWix=qv=irMr_KfhTNQW+Hgauwcs7=03510FA@mail.gmail.com>
Subject: Re: [v4 3/4] drm/panel: support for BOE and INX video mode panel
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

On Sun, Aug 29, 2021 at 7:39 PM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Support for these two panels fits in nicely with the existing
> panel-boe-tv101wum-nl6 driver as suggested by Sam [1]. The main things
> we needed to handle were:
> a) These panels need slightly longer delays in two places. Since these
> new delays aren't much longer, let's just unconditionally increase
> them for the driver.
> b) One of these two panels doesn't support DSI HS mode so this patch
> adds a flag for a panel to disable that.
>
> [1] https://lore.kernel.org/r/YSPAseE6WD8dDRuz@ravnborg.org/
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 915 +++++++++++++++++-
>  1 file changed, 912 insertions(+), 3 deletions(-)

This looks fine to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'm happy to help land this series or for others to land it. For now
my plan is to let them sit for a couple of weeks and if there is
silence I will plan to land them in drm-misc-next. I'm happy to land
earlier with an Ack or I'm happy to step back if someone else wants to
take charge. ;-)

-Doug
