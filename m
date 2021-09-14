Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E640A589
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhINEqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhINEqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:46:01 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD4C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:44:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s16so25495852ybe.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1r0TZ84blCBesuKiFn+H2dregrw6ABXsbkmKzg/nQu0=;
        b=c2riprLKxlL27Yyb+7k/Vq2jY0mItg4VJfw5jDxlGCjxtTeG3KWmbBtziHwcvjK0s3
         aWwZtlOjIMDctAYMxHSV9FM3XQrlNRH57/TGW+G31PD7pATUU5GsjIymcuvgVmTVi8Re
         YsXewenPVW0hQXKlfqwLoVkITw/NCWFL4eqvWAxm79ZWMBjCbjfLLM5ZcbXWITR+1RFK
         fMBA58TjwtqITsLD1tggkyfad4+bJ2ozO9bSgQdF+HTSW7gP9ZRl4pymd+56Q13uMlks
         lJIzhn+3c8uFhhcLKo9NlUzP2e3VScbxfs/BDO9AwOVuHrty/thdLbN/tlBK7zYCOYyk
         QCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1r0TZ84blCBesuKiFn+H2dregrw6ABXsbkmKzg/nQu0=;
        b=SjyV4Q/7P57ltI21Sw1Rx80kyEPC5X7ADuv8VFXbXrFt/NcHV7K9UsqY/lmT6C20DM
         ihoxNiv+58+CYFJq4atBl5Z19ZU4pp92MXdgcwOMlg7pb4Dy3Q4/P6QzTfCyayXoK6O9
         4IhRPlCbiV7dbW3BOv/KSlt8yNeUp05mmcNNgiUr/Krdv/FiD730lssxgj2sswZ07SgS
         AL58Vg2BE5LkIcZHu33F98S5j2gwKde4cFZetfbO04U90BbxXT3b7pol1LH1FLTyvtIY
         ZkDyxVJz4ohmziJLTfbW2CU+A64Z1zmQx/KhAfDYik7AZL9F+rtS+eVxFF0MUNUxwmOJ
         loTw==
X-Gm-Message-State: AOAM532LttHJsLEsIixUhZZRxLDEOCUtvaEmywhbKmKqZgJ5o8C0B04X
        DHcT6ePcPQC6DpCo2/mT0svqJo5F6WV2YoMZZE7dmg==
X-Google-Smtp-Source: ABdhPJyC79flKvm/NTskhQXFVLb8a+3+9QFks4On6LuHo0ZaivwVolNpwIdPxosiSI1x0RiEuI3f7yDxY5v64Cy+D2M=
X-Received: by 2002:a25:b94:: with SMTP id 142mr19497766ybl.508.1631594683564;
 Mon, 13 Sep 2021 21:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210908215815eucas1p12d139145cbb80041ca0dce750eed04fb@eucas1p1.samsung.com>
 <20210908215806.2748361-1-saravanak@google.com> <75889ceb-343b-161f-0280-13df347e6628@samsung.com>
 <CAGETcx8peaew90SWiux=TyvuGgvTQOmO4BFALz7aj0Za5QdNFQ@mail.gmail.com>
In-Reply-To: <CAGETcx8peaew90SWiux=TyvuGgvTQOmO4BFALz7aj0Za5QdNFQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 13 Sep 2021 21:44:07 -0700
Message-ID: <CAGETcx-qDPETtsSPKyW+6i=c=x2LG-tcJ+zCu40jCa9FwA-bEA@mail.gmail.com>
Subject: Re: [PATCH v1] RFC: of: property: fix phy-hanlde issue
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 5:54 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Sep 9, 2021 at 1:03 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Hi
> >
> > On 08.09.2021 23:58, Saravana Kannan wrote:
> > > This is a test patch. I'll split it up into multiple commits and clean
> > > it up once it's shown to help.
> > >
> > > Marek, can you please test this and let me know if it helps?
> > I've just checked and nope, it doesn't help for my case. Ethernet is
> > still not probed on Amlogic G12A/B SoC based boards. :(
>
> Hi Marek,
>
> Thanks for testing out the patch. Turns out the issue was a lot more
> complicated than I thought. Thanks to a bunch of debug logs that Rob
> provided off-list, I was able to root cause the actual issue.
>
> Looks like the problem is cyclic dependency between the mdio-multiplexer and the
> ethernet:
> ethmac -(phy-handle)-> external_phy -(parent) ->
> mdio-multiplexer -(mdio-bus-parent)-> mdio0 -(parent)-> ethmac
>
> Relevant parts of the DT combined from multiple files and trimmed and
> pasted below.
>
> If fw_devlink sees a cycle, it'll stop enforcing ordering between all
> the devices in the cycle since it can't figure out which one of the
> dependencies isn't real. So, the confusing part was that, when Andrew
> Lunn gave the patch for adding support for "mdio-bus-parent", that
> should have allowed fw_devlink to see the cycle and stop enforcing the
> dependencies. But that didn't happen because of a bug in fw_devlink
> cycle handling (it worked for most cases, but not for this specific
> ordering in DT). I'll send out a fix for that soon.

Here's the fix I promised:
https://lore.kernel.org/lkml/20210914043928.4066136-2-saravanak@google.com/

> That combined with
> Andrew's "mdio-bus-parent" patch should fix things for you.

Fairly certain the fix above and Andrew's patch should fix it for you
if you want to test it. Rob already verified a very similar patch for me.

-Saravana

> But I
> think I'll revert the phy-handle patch for other reasons (I'll explain
> that in the patch that reverts it).
>
>
> Thanks,
> Saravana
>
> ethmac: ethernet@ff3f0000 {
>     compatible = "amlogic,meson-g12a-dwmac"
>
>     phy-handle = <&external_phy>;
>     mdio0: mdio {
>         compatible = "snps,dwmac-mdio";
>     }
> };
>
> mdio-multiplexer {
>     mdio-bus-parent = <&mdio0>;
>
>     ext_mdio: mdio@0 {
>         /* no compatible prop */
>         external_phy: ethernet-phy@0 {
>             /* no compatible prop */
>         }
>     }
> }
>
> -Saravana
