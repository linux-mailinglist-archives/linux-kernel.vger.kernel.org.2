Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B764731685A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhBJNyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhBJNyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:54:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85B5264E77;
        Wed, 10 Feb 2021 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612965199;
        bh=yV6TURZhEtJ6Cwgc9q7dRhbULRCstmiM+RHhfwGM2ZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JuFE+/H/htE9E/JO5D55Z9g4jY9h9NX1qVbDUM8eEX8uBvEEq15Yi6eAIg9CL3UTs
         dmSgQzaaBxUTBYQETr46T+2eDsMYyHLJayQLZ/RfqnARndQ3ClGdbCNLNe8RFab8Gl
         NKMj8qtJUfl3h/mBKInuJ3S15ZM3d6sASQDnlqAcB7Bj5YJbz/wC3wqh4HNDk65W1U
         MMzEE1Q532KBw3uluuTIa/PbV2poQ14K32F1pyV/85SZOyGFlFWbSg2ayghHrk9CdD
         V3Gf3PJP3XNUn82c8MTf1ff3AVnCD7TFJX0ySGDqM0ru+oZbTnsMGChgjoi9GJFF1+
         mmS/2czj8Tnzw==
Received: by mail-ot1-f44.google.com with SMTP id l23so1792924otn.10;
        Wed, 10 Feb 2021 05:53:19 -0800 (PST)
X-Gm-Message-State: AOAM53142gQjphtGRhT2WdKJUferF1dwNV6TbTD8dPrnR4bve7rnraoW
        eQBhVm+RUHC62nzmBunBH9sOg8RLJgOEdS44NmE=
X-Google-Smtp-Source: ABdhPJwb9CXfMxZUsIBeiH+dbVDlq4uugNf+KJ+ZAnHaP33UGz/UDaKmzdX0HWNyLIVQBUvu0kkylO78Qv9oAn+xQiA=
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr2159421otf.251.1612965198882;
 Wed, 10 Feb 2021 05:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20210118155242.7172-1-jbx6244@gmail.com> <6598201.ejJDZkT8p0@diego>
 <CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com> <46108228.fMDQidcC6G@diego>
In-Reply-To: <46108228.fMDQidcC6G@diego>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 10 Feb 2021 14:53:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ALgbhTVJ7t3XRXALs9vBM=XBvkGhNKXxB+QTepo-3AQ@mail.gmail.com>
Message-ID: <CAK8P3a0ALgbhTVJ7t3XRXALs9vBM=XBvkGhNKXxB+QTepo-3AQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: dts: rockchip: assign a fixed index to mmc
 devices on rv1108 boards
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:49 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
> Am Mittwoch, 10. Februar 2021, 11:34:41 CET schrieb Arnd Bergmann:
> > On Wed, Feb 10, 2021 at 12:50 AM Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> > > Am Dienstag, 9. Februar 2021, 23:25:40 CET schrieb Arnd Bergmann:
> > Each board should have its own aliases node that describes
> > exactly which of the devices are wired up on that board, and
> > in which order. If there are connectors on the board that
> > are labeled in some form, then the aliases are meant to
> > match what is written on the board or in its documentation.
>
> Then we're at least in the clear for i2c, serial and the rest ... as thes=
e
> are numbered in the soc documentation, and all boards I've seen so
> far use these number also to identify these in schematics.

Ok, that is helpful. It would still be good to ensure that only aliases
exist for nodes that are actually enabled.

> So an i2c2 is always i2c2 even if i2c1 is not populated.
>
> And of course doing
>         i2c0 =3D &i2c2
> would definitly confuse people to no end.

I think that's just an unfortunate choice of the labels here,
it's sometimes easier to just refer to the node by the full
path instead of the label.

      Arnd
