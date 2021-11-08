Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D3447BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhKHIiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbhKHIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:38:01 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03393C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 00:35:18 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id ay21so29868247uab.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 00:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jE0hvZm1CnV5/i3mmJblxPY/W6dO7LJVD1RwLqkPDw0=;
        b=dCMWyIa/+YrcZHKRoRnQM9gVOfF7IOsyGuDNr/bNc9jbZ5x+9Cn3MntVxnJ1b6/BOr
         ArtTLNIG8l3mgSqb2ilNELaA+tIgs0Arsa+GbaoTHARBrhnA0sAX2xtfXFjf6XNz386r
         31tzYHXj6Du+eYfXEczkpK/hzvHq+7q+1BKRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jE0hvZm1CnV5/i3mmJblxPY/W6dO7LJVD1RwLqkPDw0=;
        b=2Ml6JvI0viIgvFCAZLiXCLHwXYM/4w0Fn7rHqsxR0QnjUqHy8DI/Lte8xlpn9pnHtG
         HZOPor16aQTvovmOCXYcngdJWS+xXYSxHnXxle3QBQ+wYeEyPWzMgJq5HpIyPl+KfLf9
         s9gDOEYAGIT1XXnK6OFUTUe1SULyrKj+sQJvdjNaRE4rGgopB8/j2oQrjlmq0MDWvc4t
         s7qWZePaWpz8BrwiYbYcLjIJK/VR3/7s7vSkIkT9oEbWg28GoOjChgTYpOpAJdT9iWHh
         SqCC63S1R/sj0KSejFXSuDQuMBup2TRSpdi/CJ2q68pwzH73xdU56BZ4he3jfs/9/l7x
         z/lg==
X-Gm-Message-State: AOAM532Gz7pEJLFkxALq5VoKOhg9f1nLRJBpdo6NVLjTdSFbrCz3/1V5
        szceLc0Mi8zlbDGUePTjge7/QiAq5xMuDPBELsvFBQ==
X-Google-Smtp-Source: ABdhPJyjxxZEpepvL9dwdhHLGv6N2wKGk64BSC4O3Ml6VAD6HeqbWhYrzOPXHigQcEzcsIn4fxguH8WhpTH9DZ9EX9M=
X-Received: by 2002:ab0:3ca0:: with SMTP id a32mr48206975uax.63.1636360517198;
 Mon, 08 Nov 2021 00:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20211108072711.1628566-1-hsinyi@chromium.org> <20211108072711.1628566-7-hsinyi@chromium.org>
 <CAGXv+5GD7KU4i+P--6RShhMu32Rhf-g6SZF8SRDscc4XEG4QrQ@mail.gmail.com> <CAJMQK-iHHitbgxk5q2Z8dRt=o2XwX=WK5dbi+xcZ6Jk4MQzzig@mail.gmail.com>
In-Reply-To: <CAJMQK-iHHitbgxk5q2Z8dRt=o2XwX=WK5dbi+xcZ6Jk4MQzzig@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 8 Nov 2021 16:35:06 +0800
Message-ID: <CAGXv+5E-a6Rq-TsnUFrNkOBba0SmGg2_YHayGkd9xYPF0QRu_A@mail.gmail.com>
Subject: Re: [PATCH 7/7] dt-bindings: arm64: dts: mediatek: Add sku22 for
 mt8183 kakadu board
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 4:28 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Mon, Nov 8, 2021 at 4:10 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > On Mon, Nov 8, 2021 at 3:29 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > Add sku22 which uses different audio codec than previous kakadu board.
> > >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > index 99e7f8e294cd03..da5f9ecc1a9b37 100644
> > > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > @@ -161,8 +161,11 @@ properties:
> > >            - const: mediatek,mt8183
> > >        - description: Google Kakadu (ASUS Chromebook Detachable CM3)
> > >          items:
> > > -          - const: google,kakadu-rev3
> > > -          - const: google,kakadu-rev2
> > > +          - enum:
> > > +              - google,kakadu-rev2
> > > +              - google,kakadu-rev2-sku22
> > > +              - google,kakadu-rev3
> > > +              - google,kakadu-rev3-sku22
> > >            - const: google,kakadu
> > >            - const: mediatek,mt8183
> >
> > This matches
> >
> >     "google,kakadu-rev[23](-sku22)?", "google,kakadu", "mediatek,mt8183",
> >
> > which isn't what you want. You want:
> >
> >     "google,kakadu-rev3", "google,kakadu-rev2", "google,kakadu",
> >     "mediatek,mt8183"
> >
> > or
> >
> >     "google,kakadu-rev3-sku22", "google,kakadu-rev2-sku22", "google,kakadu",
> >     "mediatek,mt8183"
> >
> > I think the following is closer, but I'm not sure if nesting "items" is valid.
> >
> > items:
> >   - oneOf:
> >     - items:
> >       - const: google,kakadu-rev3-sku22
> >       - const: google,kakadu-rev2-sku22
> >     - items:
> >       - const: google,kakadu-rev3
> >       - const: google,kakadu-rev2
> >   - const: google,kakadu
> >   - const: mediatek,mt8183
> >
> How about
>
> items:
>   - enum:
>         - google,kakadu-rev2
>         - google,kakadu-rev2-sku22
>   - enum:
>         - google,kakadu-rev3
>         - google,kakadu-rev3-sku22
>   - const: google,kakadu
>    ....

This would also match:

    "google,kakadu-rev2", "google,kakadu-rev3-sku22", ...
    "google,kakadu-rev2-sku22", "google,kakadu-rev3", ...

which is not correct. Also I believe rev3 should be in front of rev2?


ChenYu
