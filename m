Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1322407690
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 14:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbhIKMWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 08:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 08:22:22 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F368C061574;
        Sat, 11 Sep 2021 05:21:10 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id t19so1616414vkk.2;
        Sat, 11 Sep 2021 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JFcWtn6lUh5qSG7OOiLxD5ZahmIxrMGf1j5Q5s8lXfU=;
        b=ooYnU0AqSisGN9gV0Nwzw8AH4IeUcF8jgJbCHu0G/PUcShcVArw2J6lI2X4Ms4B2My
         VpvWZfww5r2EQVNIv1MC3z7HRTimN0vh8BfUVCXbih0m78iAIFaPRrSfjdn3tmCCVYec
         tKSNWscw2gSKm14wIE7CFOR5w1kPL8d8CwlKE3E0GS7QFG/OHsPep/YqMUpEXobd462U
         JG+3L/mknZJR5/6b8wFabqtBlBeEuZkVmV/PhtwOw/ToE5Mg8sFKjLfsmYBebAk4EPtU
         fGVxCh+OSqWgE5520DU5Cqy8EKC1ljmMT18ly+2QeIDL/EibCMN5fPQenbiU/SDSulAU
         Tugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JFcWtn6lUh5qSG7OOiLxD5ZahmIxrMGf1j5Q5s8lXfU=;
        b=l5CbmGT41XZCW/nkYUJmZzuEbpkrLqt5btXN0Flt6k349B8n1JbkPhgtUnzwqRkc5r
         isDmB9wU/yvp3Tue1FcgkKkrEptcR7f+yBAc+n/VPm3jnDopIea3PXfNU2GecSFzX7Ie
         YJn64BzrdCOJvDQ9Et1+BQpZWig23/CBKBYMuxbnPotJP/0K5jslQeA1AdMGhm2dNkRp
         ApC4kMrfUWuUVBJkDPMrle0QA3CB5rG1vlrNBZpQCo66yUHriIRJSVJjsFa0DG/iSppj
         PQMw+QdBp19Ug/exEQ8OlxBmMAnbbL68KQCoynAC+R7b6XHfbk5q9AwRaUF6hEJoi7ef
         u1Sg==
X-Gm-Message-State: AOAM532DgvlnaYokNRqgDTotyLvVzAIMzSeQaWL8NmnBO+qiHgpf6rgg
        6APxJZdCvX3Ju37ZHHuQsNWWZbyrsxZjdXzupeM=
X-Google-Smtp-Source: ABdhPJwrH1e4m8h6HaHj1QK9JEMdnD/N4f+EvyVU7cY41tx7OAAFn/bJT6S+BdYNEzFERGS/IXAURi3UdeeLL+l6HTI=
X-Received: by 2002:a1f:9e11:: with SMTP id h17mr785852vke.16.1631362869518;
 Sat, 11 Sep 2021 05:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210910190322.27058-1-romain.perier@gmail.com>
 <20210910190322.27058-4-romain.perier@gmail.com> <CAFr9PXmwRDfXmDR9UOGoQ2+_LDaSGgmg7n=Ek4RtBdiC2kfuLA@mail.gmail.com>
In-Reply-To: <CAFr9PXmwRDfXmDR9UOGoQ2+_LDaSGgmg7n=Ek4RtBdiC2kfuLA@mail.gmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Sat, 11 Sep 2021 14:20:58 +0200
Message-ID: <CABgxDo+9WnjE5pu=ijN01htLucFYko--w2fJ+ZVazBg_cSLZ1w@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: add vendor prefix for Wireless Tag
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Le sam. 11 sept. 2021 =C3=A0 04:59, Daniel Palmer <daniel@0x0f.com> a =C3=
=A9crit :
>
> Hi Romain,
> Sorry for sending this again. Gmail decided to switch to html email so
> the first version bounced from the mailing lists.
>
> On Sat, 11 Sept 2021 at 04:03, Romain Perier <romain.perier@gmail.com> wr=
ote:
> >
> > This adds a vendor prefix for wireless tag boards and SOMs.
> >
> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index a867f7102c35..b50d62dde7c5 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -517,6 +517,8 @@ patternProperties:
> >      description: International Business Machines (IBM)
> >    "^icplus,.*":
> >      description: IC Plus Corp.
> > +  "^wirelesstag,.*":
> > +    description: Wireless Tag (qiming yunduan)
> >    "^idt,.*":
> >      description: Integrated Device Technologies, Inc.
> >    "^ifi,.*":
> > --
> > 2.33.0
> >
>
> This should be in alphabetical order.
> Also, this commit should be before adding the DT for the board I think.
> The prefix should be in before something that uses it.
>
> Thanks,

Ack, I will fix it.

Cheers,
Romain
