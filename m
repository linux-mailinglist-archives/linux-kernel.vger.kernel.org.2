Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A134D68B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhC2SCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhC2SCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:02:47 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58838C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:02:46 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k8so13645537iop.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Au5y7OoRawkUEJFPbHpW7802nDwRo0nj5nxIyw0Dfa8=;
        b=Zyv3esmbX3USPfY9NAG7q5qJ25C5cUmKUK84xtlRwZWvmEl9I9Vqc5cxJLsk1TUGi2
         MHGmzk+I9z1q7ecO1VPAa36DUoII1M34Y5/YSt73CTOgG2rthe8T+jq+pM+TT+wZ/ouH
         wMDgcJ7f8eOshtxjUXzmZ8WIqfIJyGirgIKQ66p9iWswBXj2B+Cdaff6XyJ3OyCeiqR/
         R1CRqn/hHZAOAEOFQoDV936hEf9CcA2fqSS7viWb85sEjL1LveJTJQkbxoO10OIgo98T
         oJOqBG0G/D261zEsXroGXVguWv00cRCPbeGpnOpJtvg4yLd69XejIXoU5GJNJxjD64P/
         VA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Au5y7OoRawkUEJFPbHpW7802nDwRo0nj5nxIyw0Dfa8=;
        b=iD8G+IkS+s0vIZ3wff3Pdvrpj26ezVwAkci651xxiIpFlLWZ/S8gTvoCv6aO3poaaf
         8OyuYDrb9pNkyrCbT1ri1y0AWV1OeDbH3YypW7Sbe/ixNmqqCDepAZ7HyIwKMfbxy8G8
         5fsBPMHJsQ6Ciu92+iqJ3y/yYZjLbswdRP6I+6dqYTieYGyd1VVnElATyhjz6mvWqFLc
         Au7XfGSPrrbzpwLlK81ji74iUySjdCRLHqOTT++Y1rq6kkgp3R4NRpSQQ7n1mEX++tV9
         2YwZUd9zknw/KSzSgKvixMDoxriSyf1F6jsHv8Ua71C7EcQDtFSNa/WIsQ6Tro8/6w0k
         ObqQ==
X-Gm-Message-State: AOAM532IraxO3C6DvtPxD+DHaGDAudUxINhD/3L3j/I56Xnv0CyDtEMW
        gMNekTPRcLVlVCkavH4A/YnNxuyhouYC/QOxQ+n3uQ==
X-Google-Smtp-Source: ABdhPJxZkJRqw/QeGv+RrSKRBGLc4oFkV6J1+/TGuuqVGXQHnaoEB7kMLbeNK26s3AKHKzDMmyeObLY3VW0lugoGEc8=
X-Received: by 2002:a05:6602:1c9:: with SMTP id w9mr20873871iot.201.1617040964939;
 Mon, 29 Mar 2021 11:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616135353.git.xji@analogixsemi.com> <189a637c87827f78c433a053e3c2129ebec73188.1616135353.git.xji@analogixsemi.com>
 <CAMavQKLN04F2rzu7J121N4GvQKh7kq9yXGk+fBSUjsC2nbiSiA@mail.gmail.com> <20210329102710.GA1930154@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20210329102710.GA1930154@anxtwsw-Precision-3640-Tower>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 29 Mar 2021 14:02:08 -0400
Message-ID: <CAMavQKJHakp0ZfHFEy77r8wHY+3uaP-6Ab2ren6vA46njpjx3g@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] drm/bridge: anx7625: add HDCP support
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Foss <robert.foss@linaro.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devel@driverdev.osuosl.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sheng Pan <span@analogixsemi.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Bernie Liang <bliang@analogixsemi.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 6:27 AM Xin Ji <xji@analogixsemi.com> wrote:
>
> On Thu, Mar 25, 2021 at 02:19:23PM -0400, Sean Paul wrote:
> > On Fri, Mar 19, 2021 at 2:35 AM Xin Ji <xji@analogixsemi.com> wrote:
> > >
> > > Add HDCP feature, enable HDCP function through chip internal key
> > > and downstream's capability.
> > >
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---

/snip

> > >  static void anx7625_dp_start(struct anx7625_data *ctx)
> > >  {
> > >         int ret;
> > > @@ -643,6 +787,9 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
> > >                 return;
> > >         }
> > >
> > > +       /* HDCP config */
> > > +       anx7625_hdcp_setting(ctx);
> >
> > You should really use the "Content Protection" property to
> > enable/disable HDCP instead of force-enabling it at all times.
> >
> > Sean
> Hi Sean, it's hard to implement "Content Protection" property, we have
> implemented HDCP in firmware, it is not compatible with it. We don't
> have interface to get Downstream Cert.
> Thanks,
> Xin

Hi Xin,
I'm sorry, I don't understand what you mean when you say you don't
have an interface to get Downstream Cert.

The Content Protection property is just a means through which
userspace can turn on and turn off HDCP when it needs. As far as I can
tell, your patch turns on HDCP when the display is enabled and leaves
it on until it is disabled. This is undesirable since it forces HDCP
on the user.

Is it impossible to enable/disable HDCP outside of display
enable/disable on your hardware?

Thanks,

Sean

> >
> > > +
> > >         if (ctx->pdata.is_dpi)
> > >                 ret = anx7625_dpi_config(ctx);
> > >         else

/snip
