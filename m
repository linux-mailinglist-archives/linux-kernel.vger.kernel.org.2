Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1C41F697
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354721AbhJAVCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 17:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhJAVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:02:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A4C06177E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 14:00:38 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso13067732otb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NC9cmhLrHdckMuK/r28TvZNjmeIVCX8ECTisIPvM3VE=;
        b=XimCMpcHPEIPcAavsLIBQ7e4UqLEpKZsP5a1nMGqsGf5ozPAwSgkjCn3bwUoBZRJKG
         38ks49GU17lkYI2bUN0zLpXw9zF9ykNXYAGdQOR6LoXpO9e6e7Qk22Vt0qU7gX8ejinL
         9vTstYflDVB0JcqkSbf+/tuaA1by6r7A2zhQkDqQdZyrw0wphZmwvBATHJcr7X6uHDtO
         4e+5tVG7WGVxi3W7EEG8Sv/2kLYkWsUa3qMSPzEieSJ56Ux7OgiTsVd40kvXZvD1GFwA
         yRKjcpF1mNHBtiF7/rZkhigpYnHR6SvtN76kF3sXuZKVzyg8PBs9ClyTcUmqq/SWXvAt
         K4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NC9cmhLrHdckMuK/r28TvZNjmeIVCX8ECTisIPvM3VE=;
        b=dfyFPK3HvvdLZTCnyIlZYED6a4/aiK5ne9JYdv8Rj4m0mt4IpM1ZpXnz1FPaKsO7/b
         gZ2+9GqSzy9PMEMyLPdzog3iWbDOUtpPfIpnj2SGmgScwdDV5CNax5KonjP0UsMXuv5U
         FEQ+0p4yQnQohKe7GfG5BzVUCEy1E9hiw20t+Se2Qpew3xDwEvj+yVakzkzZ7iF6kMED
         E9Ns1h2+HglLotJuOr5p+9jmQIz6fFYv3/P5pBeMvtxDDagtXUrX3Qxh8qt1YrKk3s2D
         LZXq6X29u1fh+zLrQkTxL32426gm55JVBNGMKP/XlVZzDdR8R3/7aHJjFhD3u/hzJkEQ
         ne6Q==
X-Gm-Message-State: AOAM532ss2iuCjyVIAYuT/m7R9DMWpBGeB0BZDwd/dhWVUhJgqAwAoAi
        fSavoUG587qx4HAI+j8Gxyua6A==
X-Google-Smtp-Source: ABdhPJwoHN/UBWInkMgxVgelTcg9Ak/uofV+tp/je2/pG4B/t/W7LZ0cC6Rvth9aFQh6/JZINgrG/Q==
X-Received: by 2002:a9d:6396:: with SMTP id w22mr18800otk.26.1633122038272;
        Fri, 01 Oct 2021 14:00:38 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j24sm539724otq.72.2021.10.01.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 14:00:37 -0700 (PDT)
Date:   Fri, 1 Oct 2021 14:02:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vara Reddy <varar@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Subject: Re: [RFC] drm/msm/dp: Allow attaching a drm_panel
Message-ID: <YVd3YdfgFVc0Br5T@ripper>
References: <20210726231351.655302-1-bjorn.andersson@linaro.org>
 <CAD=FV=UGtHXD==Yy8CVCOioYGb=2hqGQOoNWftD1Jj7OiEp51g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UGtHXD==Yy8CVCOioYGb=2hqGQOoNWftD1Jj7OiEp51g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Aug 13:52 PDT 2021, Doug Anderson wrote:

> Hi,
> 
> On Mon, Jul 26, 2021 at 4:15 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > +static int dp_parser_find_panel(struct dp_parser *parser)
> > +{
> > +       struct device_node *np = parser->pdev->dev.of_node;
> > +       int rc;
> > +
> > +       rc = drm_of_find_panel_or_bridge(np, 2, 0, &parser->drm_panel, NULL);
> 
> Why port 2? Shouldn't this just be port 1 always? The yaml says that
> port 1 is "Output endpoint of the controller". We should just use port
> 1 here, right?
> 

Finally got back to this, changed it to 1 and figured out why I left it
at 2.

drm_of_find_panel_or_bridge() on a DP controller will find the of_graph
reference to the USB-C controller, scan through the registered panels
and conclude that the of_node of the USB-C controller isn't a registered
panel and return -EPROBE_DEFER.

So I picked 2, because I'm not able to figure out a way to distinguish
between a not yet probed panel and the USB-C controller...

Any suggestions?

Regards,
Bjorn
