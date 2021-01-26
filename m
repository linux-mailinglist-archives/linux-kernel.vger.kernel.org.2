Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B726304FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhA0DfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbhAZVlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:41:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39336C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:40:52 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f1so14892799lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8vg8nrSBbokWCvOz2GKxHA+4NetSMNLDLIlMKnGWdE=;
        b=AgyPUMtnaKDhD61MpdEBnwRiL9IUryf2zXzIPYO/0rVtT1/9xR+mR/KSM4sv0l06Hf
         gOPl3KERBL397kiT1frpON2Y/gCSajh7GF+ZkAV3T+3cjW56mmZqzv8z8pqDRcd9dIsT
         YkcJQeY1MIE7kxU9oFydfc55A1l69qzUxhP/PvK6J0YPj3NlQ9oe+Eqzjr4aG+/xosll
         NrIt3hf9iiQxVw7QU/xlrK9YGn8vRCoyhXq4Vxu0YSAfD7iq3RJXoZOARVk/W/r1N6At
         h0mdE5wuOqnjdkBxXYKWRILUIHcJ2XutIkoZAIYkyGCsgdsOzrzbmE1STCFnN5ULNI1H
         qDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8vg8nrSBbokWCvOz2GKxHA+4NetSMNLDLIlMKnGWdE=;
        b=VaAIQKL4KbqjOnn1QEKF49XDe6bGTUpZrD/LavYHoAFQXTLytZ88nc9gygtxSe/dgl
         JDnbUVpFf6cKC3scvDWPlKmsAhEqWA5t+XaO1e4A9p/2Ew2wpx8JD63ZfgUWnY8VA13a
         nYQoSlPfajVgxbn8Qeh8j7WOF6C05u5rEQkGd5euKhaKWbqkpYUxaSBMWU3EYwJo3wr6
         6MyhHL/O/B+Qb8AbqX5Lx5S6ZBvWZ1aTcOcoI2gCwrlMPmpMEm73vSfXTKfCQnTDxI6U
         B9faHGAVs0WI4TrPvofAeC7USiL6z6T52usRZNWuY+yFVCFeOFL9QfFEFgLxSUIW5XWe
         0PSQ==
X-Gm-Message-State: AOAM532L8AJYqMC0vYuqWvK5p5D/L5ap+5jbtVxR9XRzDG/YTmf3hOaR
        jgj8B/r50M9xZzXWRu4WlvtXHR7YlzBpkGumZa2MoQ==
X-Google-Smtp-Source: ABdhPJwcce3gQgPU5zJRC5HMuJbs9MinMXFfQiG08SzQDzs+LzF/WKC0wOfsLt4XOzEYE7kdtL7mbfEVW6/Q7SzhYFM=
X-Received: by 2002:a19:495d:: with SMTP id l29mr3434206lfj.465.1611697250578;
 Tue, 26 Jan 2021 13:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20210125045631.2345-1-lorenzo.carletti98@gmail.com>
 <20210125045631.2345-2-lorenzo.carletti98@gmail.com> <20210126210837.7mfzkjqsc3aui3fn@skbuf>
In-Reply-To: <20210126210837.7mfzkjqsc3aui3fn@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jan 2021 22:40:39 +0100
Message-ID: <CACRpkdZnVAR2VTY7UM=qt5yLwA0C5z1LUJ2pW7NgmcY5KS2rzw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: dsa: rtl8366rb: standardize init jam tables
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Lorenzo Carletti <lorenzo.carletti98@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:08 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Jan 25, 2021 at 05:56:31AM +0100, Lorenzo Carletti wrote:

> > In the rtl8366rb driver there are some jam tables which contain
> > undocumented values.
> > While trying to understand what these tables actually do,
> > I noticed a discrepancy in how one of those was treated.
>
> And did you manage to find out what these tables actually do?

I think Lorenzo mentioned that he found some settings in there,
I don't know if it was anything substantial though?

I put Lorenzon on track to investigate the driver, we thought
it could be an 8051 CPU so that some of the arrays could
be decoded into 8051 instructions, but so far we didn't get
anywhere with it.

The background was some mumble on the internet on
8051 in RTL8366 switches:
https://news.ycombinator.com/item?id=21040488
https://web.archive.org/web/20190922094616if_/https://twitter.com/whitequark/status/1175701730819895296

> > Most of them were plain u16 arrays, while the ethernet one was
> > an u16 matrix.
> > By looking at the vendor's droplets of source code these tables came from,
> > I found out that they were all originally u16 matrixes.
> >
> > This commit standardizes the jam tables, turning them all into
> > u16 matrixes.
>
> Why? What difference does it make?

I think it's nice that the format is the same on all tables.

Yours,
Linus Walleij
