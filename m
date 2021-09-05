Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5540119A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhIEUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231895AbhIEUw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:52:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C695960555;
        Sun,  5 Sep 2021 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630875082;
        bh=EN7nU+iSum7n5Y5ag0WJ0/Ms0wLl3a2CLSEOne9eMKU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=k1j8zXVgxxMuFqM0x9KwOux+t0FYtDzewKGjBIdX19Zo5V5dfwBCHHUcs5tcXVxVt
         eyyyGm9bUI8Sy823GvLt+XdtkXIbo5Mu2q/oj9LXzRYQ2fzz89kX+9+TYcrJiStlxe
         fa1JlCmP+vKtUIO91TDcQH545ceRJ0F5pXOXbgtAbyIRICskoqeFaFZhDhXVYO7tjF
         A/TOifjmLSlp9e4Jn+8tgccl5ECuKkyildi0EbBQmNaLIZxKvkYrBtNIYaob+CVCrp
         zdpjTELz2MKAWx8R0ZhDMBTU9t8pLG1NwFTWHsuM3xhYVNbouqMu3ncRGgw6mG0R0l
         GWFG8VGGVkL1w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1d269ff8-9219-cc0a-fda7-236bfd4b4510@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org> <20210901050526.45673-5-samuel@sholland.org> <20210903091040.2bngsvhem2ftzhaz@gilmour> <1d269ff8-9219-cc0a-fda7-236bfd4b4510@sholland.org>
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Rename files to match Kconfig and drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Samuel Holland <samuel@sholland.org>
Date:   Sun, 05 Sep 2021 13:51:21 -0700
Message-ID: <163087508158.405991.8011400324694193509@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Samuel Holland (2021-09-03 13:57:14)
> Hi Maxime,
>=20
> On 9/3/21 4:10 AM, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Wed, Sep 01, 2021 at 12:05:22AM -0500, Samuel Holland wrote:
> >> When the drivers are built as modules, the file name will become the
> >> module name. Rename the files so everything matches: the Kconfig symbo=
l,
> >> the platform driver name (as seen in sysfs), and the module name.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >=20
> > I'm not a big fan of big renames like this, it makes merging and
> > backporting patches harder in the long term.
>=20
> I can split this into two commits, first the .c files and then the .h
> files, so everything is a 100% rename, if that makes a difference.
>=20
> > I assume you did this to make the module autoloading work? If so, using
> > MODULE_ALIAS would be less intrusive
>=20
> Autoloading should work anyway, since there is a module alias for the
> compatible string. This change is more about the principle of least
> surprise. The compatible is allwinner,sun50i-a64-ccu, the Kconfig symbol
> is SUN50I_A64_CCU, the driver name (in /sys/bus/platform/drivers) is
> sun50i_a64_ccu, but yet the module name is ccu-sun50i-a64???
>=20
> Once we allow building modules, the names are ABI, and this
> inconsistency will bother me until the end of time :)
>=20
> If there is a way to completely rename the module without renaming the
> files (not adding an alias), then that would be enough for me.

Yes. You have to use Makefile logic to make an object manually that
renames the old one. The linker will build oldname.o as
new-module-name.o and then make a .ko out of it if the final goal is a
module.

  new-module-name-y :=3D oldname.o
  obj-$(CONFIG_YOUR_SYMBOL_HERE) +=3D new-module-name.o
