Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69613F1B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbhHSOBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbhHSOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:01:33 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E9C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 07:00:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b7so7809503iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6c3uuIqhGJTSiY34t1mdYv7edPTrnbINRnZGTByZPE=;
        b=BlMEWmipA/cQoLoc7SiiP+A3MSQ66TNqzbkmNBmnpGvskMITjFn/AknohpkpB5Cx5K
         CZJB/KgpjJ8YDW9UClJg5zSSGiQN2ZGYlh1qm6kxQfhZ1Fceo8gNb1WMKwYp6bYJ9Ev4
         sEsHaqfDkM7c+VEPq5CWbYKowz4hdkol7jCFwbx5x4vdubM8Ow6Cy0Noq/+bjr2MNT0o
         HSXFBv6a8AuevGClVSgt0lQ5pJVx8B9YFcYRQ4X36dcLXKD/6fxw46A/4Y5L0v4ueiVo
         UFRKnu2N5wL4JIBvfiGjXjUVlddOIiH8eD8DOIA/4E8uIceRI6DMSOXpqwg8bpLRD/71
         YLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6c3uuIqhGJTSiY34t1mdYv7edPTrnbINRnZGTByZPE=;
        b=TmG4xoUWFzZOaR68rPt5iOFPI2T4Xn3N9vKPmuHO7vzrIxsxen2Zn96yKIRvI7tA7o
         bifHxOlGq6Bktw9wPcHtcdjlCNGDJDI4M0Q2OX0+Ffu5KKveWnkmGiEeN/g1si27ZOaS
         r945YIxW2JXt6RenTj5qshfjE3tIC/2Px5T6xQpWcNzG79UbFirLwYIKEsHYQMsRImfN
         nUKZttsTaTURDhbPFK7v3lZG28W0TEvUn4Nrcllhl5oKRXJbL4qM+K+2pcw9Rs2XaQCS
         ZiI9GA+iAadoGyMk6AINTtmToX5nP8+QXCQP965rIsIb/SIvWSoEggqKukaG7+yJAql2
         IvMQ==
X-Gm-Message-State: AOAM530V8yKyI1wRIlB48I82fnIsDPj9e43rJcvGK/6zPh2A03pR4elG
        dltWHMdHeZH3cbIij1DwCdKCQQ46b1twceY6DZ3NAA==
X-Google-Smtp-Source: ABdhPJw66n9J4IMrZVgTxO7APnBV7DuWIAEv3w+5J7Lcm4qG/FVJtex8/Nepg+hMnS2LSgzMkD3z3PWxcRR8LQrpXMs=
X-Received: by 2002:a02:cd2c:: with SMTP id h12mr13065060jaq.84.1629381655653;
 Thu, 19 Aug 2021 07:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210819092943.719433-1-yangcong5@huaqin.corp-partner.google.com> <20210819092943.719433-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210819092943.719433-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 19 Aug 2021 07:00:42 -0700
Message-ID: <CAD=FV=VNLEcPjbUCC7W9Z1TEOud=We+OFdmQGa5Rhwi4TqLcBA@mail.gmail.com>
Subject: Re: [v1 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support
 enabling a 3.3V rail
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

On Thu, Aug 19, 2021 at 2:31 AM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The auo,b101uan08.3 panel (already supported by this driver) has
> a 3.3V rail that needs to be turned on. For previous users of
> this panel this voltage was directly output by pmic. On a new
> user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
> to turn the 3.3V rail on.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> index 38bc1d1b511e..e45de7a4360e 100644
> --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
> @@ -36,6 +36,9 @@ properties:
>    pp1800-supply:
>      description: core voltage supply
>
> +  pp3300-supply:
> +    description: core voltage supply
> +
>    avdd-supply:
>      description: phandle of the regulator that provides positive voltage
>
> @@ -52,6 +55,7 @@ required:
>    - reg
>    - enable-gpios
>    - pp1800-supply
> +  - pp3300-supply

Please send a v2 _without_ this line. Old device trees that don't
specify the 3.3V rail need to keep working fine and thus it's optional
(not required) for people to include the 3.3 V rail.

(NOTE: in the source code things will work fine without any changes
because the regulator framework will automatically create a "dummy"
regulator for you if one wasn't specified in the device tree).

-Doug
