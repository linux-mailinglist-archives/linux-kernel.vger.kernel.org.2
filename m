Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635D326628
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBZRLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhBZRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:11:17 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17143C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:10:36 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lr13so16031654ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cbXSutADW2HnccBzsx17kylWCaUrrRJFrKcsn0yvik=;
        b=JfbszjOmCX+PVGFopEGBxjB1Jak26rT0UOItBmRUGXhJTtXcJonq69NSSbUk1sIOW3
         LW0urpPkZpl7FR1LLt/bgc6TQZ68AQTowHwzxTxI6wSTZBaSN7knNI7GcIWPf0DR2u9Y
         iD8feA+xWmrW5CGxpGtSI2yDDu4vthuo+eaf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cbXSutADW2HnccBzsx17kylWCaUrrRJFrKcsn0yvik=;
        b=AcixuXDMFXE7hUNEI8jBP2bdjm9Zrb9zhDq5F7gJoZq2QtnICxPPerBpb810+/WkYd
         TjJYFRkwdfVfE6FbIM0jO8wD7Mr8RdUIuTz85q4cjOV8yNWoy1AX3UphijNRqVrXc14z
         1M7Jy6BHbpxkmkH5BtbOpckun7Dr0dUy5Fh9nOCyNyV2XZKFi7KQzwyny1TXYLERav+F
         IlpAe539zYY3gJ9UdNya9k8HSbZWsQKMzs7W6CvFY0eQAGwCqanVR4XjcuHTrqQ1JwaK
         zOgCgShQ0DuOOjFY7I318O/cfjo7IBjz+rmnRQxRobpqKgCmQIbUsqrKKAYqKEeLCGJb
         JJ7g==
X-Gm-Message-State: AOAM531COyVIILhQ+nYeKVtpe+HsXyXsG5GL7zPO9FI9mrW6TlalLRC4
        bALEkeS0GtkUB28GRG8MQYzcaCitITIOrJoEqnWmDQ==
X-Google-Smtp-Source: ABdhPJyoRe19nZ9z4W4jlGo1Iv1K22wYujENsfoQaGitC+8/Bf6NlCl1UQGu+3U13HjQEIT69OXRAFMFqUHPeiblH/o=
X-Received: by 2002:a17:906:3fc3:: with SMTP id k3mr4479825ejj.522.1614359435652;
 Fri, 26 Feb 2021 09:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
 <20210214194102.126146-7-jagan@amarulasolutions.com> <20210226165723.szblbiswz5vgapq2@hendrix>
In-Reply-To: <20210226165723.szblbiswz5vgapq2@hendrix>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 26 Feb 2021 22:40:24 +0530
Message-ID: <CAMty3ZC0ynvk3qnWDSnpMD-_hJiP-edga6+HfqhRH_g0BkAqgg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm: sun4i: dsi: Use drm_panel_bridge, connector API
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:27 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Mon, Feb 15, 2021 at 01:11:01AM +0530, Jagan Teki wrote:
> > Use drm_panel_bridge to replace manual panel handling code.
> >
> > This simplifies the driver to allows all components in the
> > display pipeline to be treated as bridges, paving the way
> > to generic connector handling.
> >
> > Use drm_bridge_connector_init to create a connector for display
> > pipelines that use drm_bridge.
> >
> > This allows splitting connector operations across multiple bridges
> > when necessary, instead of having the last bridge in the chain
> > creating the connector and handling all connector operations
> > internally.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Most of the code removed in that patch was actually introduced earlier
> which feels a bit weird. Is there a reason we can't do that one first,
> and then introduce the bridge support?

This patch adds new bridge API's which requires the driver has to
support the bridge first.

Jagan.
