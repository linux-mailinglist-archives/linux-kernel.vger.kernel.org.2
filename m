Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B798449747
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhKHPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhKHPAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:00:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC5AE6109D;
        Mon,  8 Nov 2021 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636383460;
        bh=YEqVhK4em1VFCO9boJxA+xqPNafwsUczWij0XIN6s3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qRzecMXHO2vpQ8Ws6TwnnOLDA0KZRY4upe8aU47gM0FhW6/x5febm+AKH0tOArEXb
         rHBn6ces4BB/igmPXZLN/VkQezsY9zuHRqnNjjK/5LOo81uiBCLoR/nRcSYatAJiLY
         xDDc8ZrUQmZwIPi271n9J6wIwNbrUgLianwZDGJAxh1srSGJ1SvLBwTn1fZ8wRiwxK
         RdLfyhak3DZiLNMYtDSP9id6SNZHuR4d4YD0tBuFTd39BW9ff+NDf50qCC8McDU1Ls
         sRQ/SUkwhaGvIqc0IN+aar51ir/mRZ/hQIXLE4KX3j0WZMkvd7DD1f2AQD271PAIcW
         2MLtUyBgNq9Nw==
Received: by mail-ed1-f45.google.com with SMTP id v11so61122808edc.9;
        Mon, 08 Nov 2021 06:57:40 -0800 (PST)
X-Gm-Message-State: AOAM533A7vIcIOBrHCrSE5SFAbQWxK3XhdPR5fneNp/IMXdU+i8JJngJ
        ERutbA+bFbUA9HjOnIeyPaEppLgFodIKs2ptVg==
X-Google-Smtp-Source: ABdhPJz9Id4K2LgbUHCLbfG3HNDwvqjA3xrK6+NMRT0t8Qz4gZPY0IQSk/V/WkB/kt2+6AOQ9MKZ4NySBb3yC7Sk2U8=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr494398ejc.147.1636383459216;
 Mon, 08 Nov 2021 06:57:39 -0800 (PST)
MIME-Version: 1.0
References: <YYG0KwuwSyH2uSqz@robh.at.kernel.org> <CAFr9PXnftX3k3C0sAt=qF4fgOS1apF_j4REqJXKk=wzCTVnBfw@mail.gmail.com>
In-Reply-To: <CAFr9PXnftX3k3C0sAt=qF4fgOS1apF_j4REqJXKk=wzCTVnBfw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Nov 2021 08:57:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HDXdJL69ybGBM16Nm4giS62ZP+5k3_OGsharrRj-PiQ@mail.gmail.com>
Message-ID: <CAL_Jsq+HDXdJL69ybGBM16Nm4giS62ZP+5k3_OGsharrRj-PiQ@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v5.16
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 7:13 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Hi Rob,
>
> On Wed, 3 Nov 2021 at 06:57, Rob Herring <robh@kernel.org> wrote:
> > Rob Herring (22):
> >       kbuild: Enable DT schema checks for %.dtb targets
>
> Sorry for replying to a pull request. I couldn't find the original
> patch email for this commit to reply.

FYI, the link is in the commit and 'b4' makes it easy to get the mbox
to reply to. It's quite nice to be able to reply to *anything*.

> Anyhow, the above commit makes buildroot unhappy.
> I see this when trying to build any of my buildroot environments:
> scripts/dtc/Makefile:23: *** dtc needs libyaml for DT schema
> validation support. Install the necessary libyaml development
> package..  Stop.

If you fix this, then the next thing you will get is the dtschema
python package is needed.

> I think this is some mess with pkg-config from somewhere (the host
> distro, the buildroot host side,..) saying libyaml is available but
> when the build actually happens the header it wants isn't actually
> where it thinks. I think this is a pre-existing problem with
> buildroot.
> buildroot takes a list of the dtbs that you want to build and keep in
> it's config and calls make with that list in the kernel build. So this
> commit causes this issue to trigger when buildroot tries to build the
> configured dtbs.
>
> Not sure what the fix is and I think it's probably a buildroot problem.

I suppose we can keep schema checks optional here, but my intention in
this patch was moving towards the checks being required rather than a
separate target. So we'd be kicking the problem down the road.

Rob
