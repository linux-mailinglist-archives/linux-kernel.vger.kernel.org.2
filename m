Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7C447B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhKHINT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhKHINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:13:17 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFDEC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 00:10:33 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id b3so29884309uam.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 00:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+1TTlc9xwZih44a5849v2x4l1vXCAR2nfrUVYgiR3c=;
        b=PmgnMxI87YGsl4UDOvad3MIkBRLFuSbvFbhEvWiqMEulobgpBUjzQ7qsNZFB7TrLfh
         q1Y11AwMECJi3upYjA/iXxZkMCON+W85LdpM5bE5WZj7r23xAr2HNJAqTnlNjQPFKpQh
         H/mrBZjX+BXA5BCvK35sRbvQ6mZP6u/Em4gxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+1TTlc9xwZih44a5849v2x4l1vXCAR2nfrUVYgiR3c=;
        b=VgLeAeZEsdUcf2RA8C2Y8xUci5mN5c7T/B6QbqQwM9BNGOO8jIXrRSeCIvb6Blt9y4
         nQQyjT4TXoJxqv4jNpBpI93nQxGmzmCIySNTviATJ/wA3SobjpqvRH7QVXv6YoqdpXM7
         TGKi6B2yGExOSmG3IvhPD86a4RowmWc2UgvazD+LJJ02/rHfgjpYa5tcoHAxU0LNZnTQ
         cepUd79MlvoL2VZ1aW4WvRcAfVyB+b//mZ/OuEjjj1ZW13srC2v9DPAAilMvX3C65YpU
         xG/zvI0EbphEcO5uuAcInOf/cSNPtm2whjmjppZvYtr3UwPjEgSp6pcBGjIYO20Kgu3B
         1jkQ==
X-Gm-Message-State: AOAM533hVu7/ozPYCspf1tbIB1M/XTbAMjmtHx+53cA1pKAh5JPzTyvp
        qM7btuj2snHGlg2Ziq9E2QivOss7uCerrO6kmwmixg==
X-Google-Smtp-Source: ABdhPJypn5ldFm8d20a28vAsb9VgMeCgEt6OtSsBAo7c+Ifjy+KvBJxcPi60jxce+NO+Q0J7RZ8/XR0P2goqB+MHtQU=
X-Received: by 2002:ab0:3154:: with SMTP id e20mr90919214uam.14.1636359032861;
 Mon, 08 Nov 2021 00:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20211108072711.1628566-1-hsinyi@chromium.org> <20211108072711.1628566-7-hsinyi@chromium.org>
In-Reply-To: <20211108072711.1628566-7-hsinyi@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 8 Nov 2021 16:10:21 +0800
Message-ID: <CAGXv+5GD7KU4i+P--6RShhMu32Rhf-g6SZF8SRDscc4XEG4QrQ@mail.gmail.com>
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

On Mon, Nov 8, 2021 at 3:29 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Add sku22 which uses different audio codec than previous kakadu board.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 99e7f8e294cd03..da5f9ecc1a9b37 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -161,8 +161,11 @@ properties:
>            - const: mediatek,mt8183
>        - description: Google Kakadu (ASUS Chromebook Detachable CM3)
>          items:
> -          - const: google,kakadu-rev3
> -          - const: google,kakadu-rev2
> +          - enum:
> +              - google,kakadu-rev2
> +              - google,kakadu-rev2-sku22
> +              - google,kakadu-rev3
> +              - google,kakadu-rev3-sku22
>            - const: google,kakadu
>            - const: mediatek,mt8183

This matches

    "google,kakadu-rev[23](-sku22)?", "google,kakadu", "mediatek,mt8183",

which isn't what you want. You want:

    "google,kakadu-rev3", "google,kakadu-rev2", "google,kakadu",
    "mediatek,mt8183"

or

    "google,kakadu-rev3-sku22", "google,kakadu-rev2-sku22", "google,kakadu",
    "mediatek,mt8183"

I think the following is closer, but I'm not sure if nesting "items" is valid.

items:
  - oneOf:
    - items:
      - const: google,kakadu-rev3-sku22
      - const: google,kakadu-rev2-sku22
    - items:
      - const: google,kakadu-rev3
      - const: google,kakadu-rev2
  - const: google,kakadu
  - const: mediatek,mt8183


ChenYu
