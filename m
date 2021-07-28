Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA453D945A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhG1RdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:33:08 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:50152 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG1RdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:33:07 -0400
Date:   Wed, 28 Jul 2021 17:33:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627493584;
        bh=aludK9XryBpkjh7HWZh0FHUmSZi7L5bJJ2UCHCJx14o=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=D4zptFnGtcKEwt8BQbBojQO+HSk5PgLvxiuFru0V9vi0FB4BZGJSE26/gH+RK5qcu
         yGqv4/3si20kJW4TIUnxNiSwurMeCMp2tGR7HRxjo3MZUoOlKVs4/sK593PZCn7v+j
         uco3uoP+1o/yvgaHpeK2tkevWIuebw0+PCLbLIPk=
To:     Rob Herring <robh@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Auchter <michael.auchter@ni.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: extcon: usbc-tusb320: Add TUSB320L compatible string
Message-ID: <yp8UA_I1d4WXcVkLUE7V6sKBGPOzNwpbmKl0UTzLxvyt-l-AgpNKvFcN038I7DDQB8qx8yOnE3OiUlzLrBqY-KY7Yub2FWWRosPmFsu_1jc=@protonmail.com>
In-Reply-To: <20210728171807.GA1269122@robh.at.kernel.org>
References: <a4rEWQfScKM8Y0B7u0NXSAdvKC6Xzesp1OWGUYjeWaA@cp3-web-016.plabs.ch> <20210728171807.GA1269122@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 28th, 2021 at 9:18 PM, Rob Herring <robh@kernel.org> wro=
te:

> On Tue, 27 Jul 2021 09:57:15 +0000, Yassine Oudjana wrote:
>
> > Add a compatible string for TUSB320L.
> >
> > Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
> > -------------------------------------------------------
> >
> > .../devicetree/bindings/extcon/extcon-usbc-tusb320.yaml | 4 +++-
> >
> > 1 file changed, 3 insertions(+), 1 deletion(-)
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>
> there's no need to repost patches only to add the tags. The upstream
>
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

I changed indentation in this version to fix a dt_binding_check warning:
../Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml:15:6: =
[warning] wrong indentation: expected 6 but found 5 (indentation)

I wasn't sure if I had to state changes in each individual patch, so
I ended up only stating them in the cover letter:
https://lore.kernel.org/lkml/a1IcsWeSdRxWaMFcwV1k7z3l1HaAkyRCo2zLdOWb8w@cp4=
-web-014.plabs.ch/

Regards,
Yassine
