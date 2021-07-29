Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2901E3DAB61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhG2SwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhG2Sv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:51:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84EF960F6F;
        Thu, 29 Jul 2021 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627584715;
        bh=tsqDaOZILSnFIe7Ys4Y1mPvwuoKDC2Ozm73ShrxzQvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kA7fiUJK0zDOT2xounu9ATyQIVX6WTV+9hJcy0wUZBqle6fS2Jp4FgplTLhVPSJzX
         69YzTFUiPC71XNvAv1vTBhrbbn8o5gUl3bBZbp/Z4wA5Z4XuvJAJSm/xd/l+UR1i18
         eybR+IQ15ZhE6ftEN3Fr9xR7NyrYCP0+bsE9P2wS9OMi92ZWFYS9ualFcYZwoRS35A
         37V2XS/953dhNJl8AqBu3gx1PVVTPJEIZJrv8A3IDN6odt93XDONN7GTC/CIAIlw7q
         5GTzCUMbeFchwQDUv2Ys7Qlsq11FAZszbzAnQH0cJA7iCjKWvpq8VASuai+vf4R+vq
         hmfOZalAVCJqQ==
Received: by mail-ej1-f53.google.com with SMTP id gn26so12404473ejc.3;
        Thu, 29 Jul 2021 11:51:55 -0700 (PDT)
X-Gm-Message-State: AOAM530gYv5Du+fiv4pNyQO/tdrCmV8CXq5Ltfxn1tRHvi/0tFbW/v3v
        dbl5F5370MRlL8VimPnTlpQ7nmYl3DOJv1S8vw==
X-Google-Smtp-Source: ABdhPJw+U3/xnWkBrMx0ZBUNX+CSiwAtcIvqTL+PFrgW9wAMPznZjq98b9kbNpTcpJRNsVQyJsHOgCT/tviiTxxZkgg=
X-Received: by 2002:a17:906:d287:: with SMTP id ay7mr5751654ejb.360.1627584714064;
 Thu, 29 Jul 2021 11:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <a4rEWQfScKM8Y0B7u0NXSAdvKC6Xzesp1OWGUYjeWaA@cp3-web-016.plabs.ch>
 <20210728171807.GA1269122@robh.at.kernel.org> <yp8UA_I1d4WXcVkLUE7V6sKBGPOzNwpbmKl0UTzLxvyt-l-AgpNKvFcN038I7DDQB8qx8yOnE3OiUlzLrBqY-KY7Yub2FWWRosPmFsu_1jc=@protonmail.com>
In-Reply-To: <yp8UA_I1d4WXcVkLUE7V6sKBGPOzNwpbmKl0UTzLxvyt-l-AgpNKvFcN038I7DDQB8qx8yOnE3OiUlzLrBqY-KY7Yub2FWWRosPmFsu_1jc=@protonmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Jul 2021 12:51:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLNqKOs0WZvBF5L45VZu2OWtjxGyLoMCP-mGA3KbUVxOw@mail.gmail.com>
Message-ID: <CAL_JsqLNqKOs0WZvBF5L45VZu2OWtjxGyLoMCP-mGA3KbUVxOw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: extcon: usbc-tusb320: Add TUSB320L
 compatible string
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:33 AM Yassine Oudjana
<y.oudjana@protonmail.com> wrote:
>
> On Wednesday, July 28th, 2021 at 9:18 PM, Rob Herring <robh@kernel.org> wrote:
>
> > On Tue, 27 Jul 2021 09:57:15 +0000, Yassine Oudjana wrote:
> >
> > > Add a compatible string for TUSB320L.
> > >
> > > Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
> > > -------------------------------------------------------
> > >
> > > .../devicetree/bindings/extcon/extcon-usbc-tusb320.yaml | 4 +++-
> > >
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> >
> > there's no need to repost patches only to add the tags. The upstream
> >
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
>
> I changed indentation in this version to fix a dt_binding_check warning:
> ../Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml:15:6: [warning] wrong indentation: expected 6 but found 5 (indentation)

That's certainly small enough change to keep any tag.

> I wasn't sure if I had to state changes in each individual patch, so
> I ended up only stating them in the cover letter:
> https://lore.kernel.org/lkml/a1IcsWeSdRxWaMFcwV1k7z3l1HaAkyRCo2zLdOWb8w@cp4-web-014.plabs.ch/

It is best to put the changes for specific patches in that patch and
use the cover letter as a summary of changes.

Rob
