Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E98402DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhIGRoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:44:37 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50143 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhIGRog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:44:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF3A45C01B7;
        Tue,  7 Sep 2021 13:43:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Sep 2021 13:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=z
        krYxpxmyK+adj+hCKejbSyS7Z1m9laTt+mMUb/p9ww=; b=Z+oZusxgQLEjF/bo6
        RYFNLbH9FEKQSvdBdAkAyzYUMDDO2sc6szJ/GT57HChLT3uS4AP/8auuK9Si98Yb
        3csQazCMiS0v6Jrb7w+uTbYZvrW7k2oIn9SHkpUeZKCsO7LYb3+V+U49YbTCnJo+
        BP1sZaYbuwqoCqm4NPQtdvr3cSz+W1oVYRIwaY3AfBRN8NvoVlHB5tHQEoiTmBVp
        kHSlTd1ih2q7GptCZaCpy2X0yRrZF0kASmKomYYiPTBNEJPvpVaWLSRiWXA/Ko3t
        Z3dxckVUgXrer+kwxZzZJC2cCo51tBfBYZ+LFPFhCON932KokLrh0N5Bs8ckBE1V
        HwtHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=zkrYxpxmyK+adj+hCKejbSyS7Z1m9laTt+mMUb/p9
        ww=; b=AwhVB5Hrv+dwdXAbibD2+Ww2oMXujC+0Gah1GBo6AA+FaDJNZVRzoMwDD
        mjnVOgbXf9+jGVsTeNDpjsE6hcKSdiKL8vRBtVehVWzn8hD7j5kfAPfEOxAuNy/9
        Ras61q5EjnT4fzEfo5XsT9NCQ9C0JotPBrekyaEagKV4isA5uonExqZULONv5ThU
        6OsjglmYfJZZh8df0oNMgiqk2bllRMnJyd2oao+X6vk2paG/+IgSs1FB4J3zoQaD
        n95T8eVTx+3mzsIq0rTX+ouyOgFgLzBKwebW2dXZ2POK2LGJZ1f0sS4faWrf49Xz
        GhK2JRwu+tnkQBScsdsTA1arkD3tQ==
X-ME-Sender: <xms:vqQ3YQUe0nVECkjDpnGJfEWf-x58VfL3S2pPxhWuD4ZBAFwFlPHkpw>
    <xme:vqQ3YUliATyesEcOz1VGwifiLCkI6Y4dDcFQGKus1f1faycnUTQuIDk8xIdHgiP--
    JE4YY3Wge0zf_h-5ck>
X-ME-Received: <xmr:vqQ3YUbHkKvE2cOQVfRRiZvrwM7An87m5b1x3_OLaR-LNclJUnM0m_Yzb9vxLfeunPiNhAkgH8SHqCBwQYg8u8m0Ps5sL_BtzGzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefhedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeel
    udegvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vqQ3YfUoGc3Q71mZ90lqAP4mctSJssiKF4JLoTGsnAbwm6PNwFOPgw>
    <xmx:vqQ3YalSomLBJ50F_fq4f_neAKYCAdnmUMy0ID83EZa-6iUmKaBuUg>
    <xmx:vqQ3YUekExhWtZySiKuBnOqryGQZxj9ejuGiNt5zaG4qYx2cPL1c4g>
    <xmx:wKQ3YcUQnBp7HDWhES8VCKOiHw2y9dIkvBKQTs3RuK8bQhoVcIJWZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 13:43:26 -0400 (EDT)
Date:   Tue, 7 Sep 2021 19:43:24 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Rename files to match Kconfig and
 drivers
Message-ID: <20210907174324.lho3vdl2z6uealnf@gilmour>
References: <20210901050526.45673-1-samuel@sholland.org>
 <20210901050526.45673-5-samuel@sholland.org>
 <20210903091040.2bngsvhem2ftzhaz@gilmour>
 <1d269ff8-9219-cc0a-fda7-236bfd4b4510@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1d269ff8-9219-cc0a-fda7-236bfd4b4510@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 03, 2021 at 03:57:14PM -0500, Samuel Holland wrote:
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

We can't really do much for the compatible, and it's the standard
practice there anyway. However, it looks much more common for Kconfig to
have a pattern like $FRAMEWORK_$SOC, so maybe we could just rename the
Kconfig (and drivers name) to CCU_SUN50I_A64? It's not been exposed to
the defconfig so far anyway, so we can change them without any real harm

> Once we allow building modules, the names are ABI, and this
> inconsistency will bother me until the end of time :)
>=20
> If there is a way to completely rename the module without renaming the
> files (not adding an alias), then that would be enough for me.

Otherwise, yeah, we can do what Stephen suggested

Maxime
