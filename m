Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9098B313E17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhBHSxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234694AbhBHRBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:01:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E982A64E92;
        Mon,  8 Feb 2021 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612803635;
        bh=yOoYYWyBnaMgwgaYOwWASSKZRwf6EPSGY5Y2gB55YrU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BiKi05HuPUWO0NyDGo+vTwrl8yn4f1oal2fETcQUnaAGmzC38CnaEbyQARsT+tH6X
         pUKh3KyfdPY5JwmIEVYEYedR2fKGylWzDhvE/6tvfy4M69Bmitn1gXnwtSAdOM1CvU
         vqBVvyV/X/52jIoi9i5/91XmKLc8A2rK0TwXn4kc9fzqs29DPg+ybp5CNa4qnwK5kf
         M93rTsK3b41MPP6Imi2E7G2AYf0PElJuu9egJss+d7+KYuSzSi0lqtSXTlyLBaeriZ
         BLZHCYvuELdPU6wlACjSdklrpRD4iQAXDrwSKj1GoIAAU2MB2R576DC0ecyBUAs2uf
         Zto2lwox5Xqdg==
Received: by mail-ed1-f44.google.com with SMTP id q2so16059378eds.11;
        Mon, 08 Feb 2021 09:00:34 -0800 (PST)
X-Gm-Message-State: AOAM533zC3IVrdJRaj3jUSz4726+DEVJxGHIwtq1wmIwxaPujgPVt+Fb
        LSmVq1xaAsKJMAw+W6JJGmiOfmYDHJ/lv6qplA==
X-Google-Smtp-Source: ABdhPJyeJTlsX9gsIBVG8nUnP7ypJTVm4p29vhybHvOpO8eI2ltI9fGsLIQPVhbr9eaplAp2PpOexzUJieh/ANtGJEo=
X-Received: by 2002:a50:ee10:: with SMTP id g16mr18027997eds.62.1612803630948;
 Mon, 08 Feb 2021 09:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20210120081921.3315847-1-steen.hegelund@microchip.com>
 <20210120081921.3315847-4-steen.hegelund@microchip.com> <20210205223526.GA3869001@robh.at.kernel.org>
 <23616bd06996c1df9480b879d804220269143f44.camel@microchip.com>
In-Reply-To: <23616bd06996c1df9480b879d804220269143f44.camel@microchip.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Feb 2021 11:00:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BsgvZMi9PaEgAG-Q=1p1TRHsOJxrSJxiHxMSQO08r1w@mail.gmail.com>
Message-ID: <CAL_Jsq+BsgvZMi9PaEgAG-Q=1p1TRHsOJxrSJxiHxMSQO08r1w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: reset: add microchip sparx5 switch
 reset driver
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 7:20 AM Steen Hegelund
<steen.hegelund@microchip.com> wrote:
>
> Hi Rob,
>
> On Fri, 2021-02-05 at 16:35 -0600, Rob Herring wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >
> > On Wed, Jan 20, 2021 at 09:19:21AM +0100, Steen Hegelund wrote:
> > > This provides reset driver support for the Microchip Sparx5 PCB134
> > > and
> > > PCB135 reference boards.
> >
> > This isn't a compatible change. You need an explanation why that's
> > okay
> > if that's intended.
>
> I am not entirely sure that I get your point.
>
> The change (adding the reset driver) is new, and it is optional (but
> strongly recommended) for the  clients to use it, so will this be a
> incompatible change?

I'm assuming something used "microchip,sparx5-chip-reset"?

> I can certainly add a an explanation.  Would that be needed here in the
> bindings, or where do you suggest?

Just need to spell out why dropping that is okay in the commit msg.
But I guess what this looks like will change anyways.

Rob
