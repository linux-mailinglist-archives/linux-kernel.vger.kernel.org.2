Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAA43BADC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhJZTfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbhJZTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:35:33 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BBAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:33:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q129so217956oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=N+6YPLFrjwgdtCUJfPROJUL3QTAN19p6nyz5HyyDtK4=;
        b=bwQVfE1iYX9MIZ9fiCHs3adkHdyfOkx5hhBzkC7jWLgIdcSsCSYWq2QLllwOfVVG9j
         /qobU+jHLvUR++xcY972QXpv1OVxCGwsmhZmihMcmoSLl2uPPg+9RbhrGjogeCK4mDBF
         FsDc4/q9pdianaa3KZJ9DpZsajeQI3ERC7dVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=N+6YPLFrjwgdtCUJfPROJUL3QTAN19p6nyz5HyyDtK4=;
        b=eSHZFlV2wJEiWnX+HN2LCDItXRctxkEXRWFUoZ2uh5ebK86zi1rm0iuhZOAjq7EgFm
         PIPDeaSEclZ9M9o3/iSJPYDoobOH48iH8pe1fqLy+cDPMCtfN3wgEXmNwv9loSbiGqFZ
         Pt6MUaCFyjHPLAi3PBvVZHSQD+HzQDAHn4ORLhhrHMSL5D9LK+Hpn7bK2Se7cYgIFrP2
         sbkJH1KO23XGa79La+xILpa/wqBGhb1k2Jj9cb9dE8jW8owyVfrsbeMau9mSjMHpkq2d
         CzZY2zwvqdQeSTsuMxMlY1EeVkIwxHKvDo+qgCiFCsztkM/pbXMC7fB4AxR5KsnvMt73
         S3uw==
X-Gm-Message-State: AOAM530OJaMnaRqJHLBFZz/4FEubSbKTM08YB9Q9GXjAVb1LnaPmBeyL
        coVSp/cQPW7KESqW60HLhweOFk/wBw+pFNAcFXoMGg==
X-Google-Smtp-Source: ABdhPJz2feIZoXb0OU1UFvKLPQtsVf3EiA3LjrGD6qfKLOXPs1wesM0P/U/URyOya6G/f7joJZ5ris8KEn2SD03vMv8=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr555758oic.64.1635276788733;
 Tue, 26 Oct 2021 12:33:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Oct 2021 12:33:08 -0700
MIME-Version: 1.0
In-Reply-To: <202110262230.8EQoYnHj-lkp@intel.com>
References: <20211026000044.885195-4-swboyd@chromium.org> <202110262230.8EQoYnHj-lkp@intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 26 Oct 2021 12:33:08 -0700
Message-ID: <CAE-0n51k5HnvVuXgRvuOtpUovceTBeqnQdh1hhKzPV=qB0JjsQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/34] component: Introduce the aggregate bus_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kernel test robot (2021-10-26 07:02:03)
>
>    drivers/base/component.c: In function '__component_add':
> >> drivers/base/component.c:858:13: error: variable 'ret' set but not used [-Werror=unused-but-set-variable]
>      858 |         int ret;
>          |             ^~~
>    cc1: all warnings being treated as errors
>
>
> vim +/ret +858 drivers/base/component.c
>
> 2a41e6070dd7ef Russell King  2014-01-10  853
> 3521ee994bca90 Daniel Vetter 2019-02-08  854  static int __component_add(struct device *dev, const struct component_ops *ops,
> 3521ee994bca90 Daniel Vetter 2019-02-08  855    int subcomponent)
> 2a41e6070dd7ef Russell King  2014-01-10  856  {
> 2a41e6070dd7ef Russell King  2014-01-10  857    struct component *component;
> 2a41e6070dd7ef Russell King  2014-01-10 @858    int ret;
> 2a41e6070dd7ef Russell King  2014-01-10  859
> 2a41e6070dd7ef Russell King  2014-01-10  860    component = kzalloc(sizeof(*component), GFP_KERNEL);
> 2a41e6070dd7ef Russell King  2014-01-10  861    if (!component)
> 2a41e6070dd7ef Russell King  2014-01-10  862            return -ENOMEM;
> 2a41e6070dd7ef Russell King  2014-01-10  863
> 2a41e6070dd7ef Russell King  2014-01-10  864    component->ops = ops;
> 2a41e6070dd7ef Russell King  2014-01-10  865    component->dev = dev;
> 3521ee994bca90 Daniel Vetter 2019-02-08  866    component->subcomponent = subcomponent;
> 2a41e6070dd7ef Russell King  2014-01-10  867
> 2a41e6070dd7ef Russell King  2014-01-10  868    dev_dbg(dev, "adding component (ops %ps)\n", ops);
> 2a41e6070dd7ef Russell King  2014-01-10  869
> 2a41e6070dd7ef Russell King  2014-01-10  870    mutex_lock(&component_mutex);
> 2a41e6070dd7ef Russell King  2014-01-10  871    list_add_tail(&component->node, &component_list);
> 2a41e6070dd7ef Russell King  2014-01-10  872    mutex_unlock(&component_mutex);
> 2a41e6070dd7ef Russell King  2014-01-10  873
> 748369f5c5e62a Stephen Boyd  2021-10-25  874    /*
> 748369f5c5e62a Stephen Boyd  2021-10-25  875     * Try to bind.
> 748369f5c5e62a Stephen Boyd  2021-10-25  876     *
> 748369f5c5e62a Stephen Boyd  2021-10-25  877     * Note: we don't check the return value here because component devices
> 748369f5c5e62a Stephen Boyd  2021-10-25  878     * don't care that the aggregate device can actually probe or not. They
> 748369f5c5e62a Stephen Boyd  2021-10-25  879     * only care about adding themselves to the component_list and then
> 748369f5c5e62a Stephen Boyd  2021-10-25  880     * waiting for their component_ops::bind_component callback to be
> 748369f5c5e62a Stephen Boyd  2021-10-25  881     * called.
> 748369f5c5e62a Stephen Boyd  2021-10-25  882     */
> 748369f5c5e62a Stephen Boyd  2021-10-25  883    ret = bus_rescan_devices(&aggregate_bus_type);

Ok I guess I have to print a dev_dbg() as well to silence this.
