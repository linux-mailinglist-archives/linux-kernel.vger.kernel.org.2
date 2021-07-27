Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1C3D72F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhG0KTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:19:38 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54981 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236131AbhG0KTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:19:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 063C93200910;
        Tue, 27 Jul 2021 06:19:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Jul 2021 06:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-id:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=QmLMBA6Xti0HU0XKBmTE0w8Hds9Nrr+uYvql2a6fe88=; b=QxRjhR41
        g4n0z4jYVLmHonJgX3FNAJaMIEF/NoXCx1TlH2QsMb02JXL0ezFhzjmk39nDOQ1h
        VQ+ZReEi0jbBoxB5i3I4C68X0k66e3A/wfCWZcUeQ7OkT+lnoadN8++d3Qy7TDmE
        FYHD+jXQykY0fMU2PIZAAPXs48WmG2vo0L6XqCyGxY+CPgN/4ym+DE7+tpjNcrNw
        wU6aCNs2IJ9c1Ol5UiiKURuCHO1O8p6aVGIlyZFv+tamoXX4kCOoYGuFDeS5z/Ic
        Kjd5PVxfVdWbIps3VRPyirHZQOUbHztBt0s29j8ryluUd/5vTFrt8II1aht5bd8B
        e2AWboh90cOVAg==
X-ME-Sender: <xms:tt3_YIltJaOVvEJ0rNKTS-5CBCTeDzisc1oGWXWhnfn6Fuq1Ogv4Ww>
    <xme:tt3_YH3Vmid0eYzfUDk_QB0u9qwX87c252ukyAtDwnAjWIX-sJ-rLIvrAMJ0fuxxX
    Hhyatoa9XfNlhgO19c>
X-ME-Received: <xmr:tt3_YGqMVyUJ4RGhtQOwYNhWXBxCRCmh3DMlNakMhaCAMNo_Yu17Ee4m93B2i-eKz7r2LmH50PCgkBda216qpgBcnAAqosKVBbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefffejiefgheevheefvefhteeggfeijeeiveeihfffffdugfefkeelfffhgfeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:tt3_YElxCTGW4-w531ASY3g03z02vRrNHpL3473-G9psAQKNSdLlXw>
    <xmx:tt3_YG2WXFbtPmJppa_ARnFdBFjmQzxnZg26EY1oTM_XkdcsMQUlqQ>
    <xmx:tt3_YLuW9KcOeWFSMB4Oz84zsDiCVDodY59ukPwS9lPusI8oDVS1wg>
    <xmx:t93_YLz41GPvB3Hk5MIq00pNy1WdEV0ejmDJBm1sYILr6OC7sUuHrw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jul 2021 06:19:32 -0400 (EDT)
Date:   Tue, 27 Jul 2021 20:19:35 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 1/5] nubus: Simplify check in remove callback
In-Reply-To: <CAMuHMdX=K4S3Yd_ybd5C3e40XefMf5kHs1tWs1+VKTgiWEWEDg@mail.gmail.com>
Message-ID: <194b351c-bae-27a-1875-9ad3c47292e@linux-m68k.org>
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de> <20210727080840.3550927-2-u.kleine-koenig@pengutronix.de> <d74ccd1-116d-9450-5ee4-8d5074998872@linux-m68k.org> <CAMuHMdX=K4S3Yd_ybd5C3e40XefMf5kHs1tWs1+VKTgiWEWEDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-894125592-1627380959=:28"
Content-ID: <4a49a1b2-e172-446c-be33-62c34c8bdc97@nippy.intranet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-894125592-1627380959=:28
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c0f951ce-205b-e695-f5ba-a13ce3cf542d@nippy.intranet>

On Tue, 27 Jul 2021, Geert Uytterhoeven wrote:

> On Tue, Jul 27, 2021 at 11:50 AM Finn Thain <fthain@linux-m68k.org> wrote=
:
> > On Tue, 27 Jul 2021, Uwe Kleine-K=C3=B6nig wrote:
> > > Apart from that, the compiler might already assume dev->driver being=
=20
> > > non-NULL after to_nubus_driver(dev->driver) was called.
> >
> > I don't understand how a compiler can make that assumption. But then,=
=20
> > I don't know why compilers do a lot of the things they do...
>=20
> It is one of those recent optimizations people have been complaining=20
> about.  Once you have dereferenced a pointer, compilers may remove all=20
> further NULL-checks, assuming they can't happen, as the code would have=
=20
> crashed anyway before due to the dereference.

But that's the point -- there is no dereference, just pointer arithmetic.

> Good luck running on bare metal with RAM at zero ;-)

Quite.
---1463811774-894125592-1627380959=:28--
