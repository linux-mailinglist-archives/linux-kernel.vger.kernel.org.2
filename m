Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967103183C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBKC4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhBKC4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:56:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C5C264DBA;
        Thu, 11 Feb 2021 02:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613012161;
        bh=/IWRxwCmtIxZBUuHS0+t/oVWw89lAGEyoFWFw7vLZNU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hp2BHKSigiWBJ4auAFAQ6iKu1WtfeLill9ls1jFg3GuePoSNk9+5tMCIBLdX7k7YG
         8fVxmka87bPLRL9+X6MP7N6SjEsYF9h2f8L0ui5MQYMkd6M2xYjQk6opDgHsrliKOn
         6JnUmL0g0a8mAdcZdwN13JApKWhjZI/Y6rGQ+Dh584ZQBV2dOqWCPRrDt6/Ep28e+7
         CvCNINsSdusnRB61L2Vd1AwbYLWVFiBKy3kjE3uBtATeoiOjQxTb5jWm+2u/2Ge5+s
         iSetek+wSgfHrYX8SfBMWQfIi6Pz1wbVWiMT0pQhJHgMJT0lJwsKo86VNyEcxdtdtf
         /qrJrlnE7KCAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFr9PXkGeFUyGCKZgYF+0uJT1ywad42RvPg39ggO8WRngY8uWw@mail.gmail.com>
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-3-daniel@0x0f.com> <160843556037.1580929.13575770228476494246@swboyd.mtv.corp.google.com> <CAFr9PX=f=HyHBk4s3e_vnMDC53R1X18m7sKFCLMMjitPm+8oEQ@mail.gmail.com> <160848984935.1580929.936824086681978646@swboyd.mtv.corp.google.com> <CAFr9PX=oLqQqvykiwOGAGg1H2CG0BTEqn0TuSrijodjxY52LxQ@mail.gmail.com> <161292417080.418021.13416197091150418216@swboyd.mtv.corp.google.com> <CAFr9PXkGeFUyGCKZgYF+0uJT1ywad42RvPg39ggO8WRngY8uWw@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: clk: mstar msc313 mpll binding description
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
To:     Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 10 Feb 2021 18:55:59 -0800
Message-ID: <161301215989.1254594.8224717086717364802@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2021-02-10 18:28:40)
> Hi Stephen,
>=20
> On Wed, 10 Feb 2021 at 11:29, Stephen Boyd <sboyd@kernel.org> wrote:
> > The child clks should be using clk_parent_data to point to the parent
> > clks through DT. That way the name of the clk doesn't matter except for
> > debug purposes.
>=20
> I think I get it now. I was using of_clk_parent_fill() to get the
> parent clocks sourced
> from the mpll but I seems like I should be filling out an array of
> struct clk_parent_data
> with the indices of the parents and using
> clk_register_composite_pdata() etc instead.
>=20

Yes that's the idea. Thanks!
