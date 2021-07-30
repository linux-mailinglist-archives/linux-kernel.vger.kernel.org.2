Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1303DBF37
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhG3Tr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhG3TrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:47:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEE9960F26;
        Fri, 30 Jul 2021 19:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627674437;
        bh=3qD7KHz51ikHdJzZw6xNwaTXnr9esYUOrmU39Ter0So=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H3aoXHqJ9ib3+RjLjQudivlC/ijcHZ3qsw9J8YxqpTiEDbIlHDqOpxsKfxnFnhRH5
         AZMNElFddQFoml7BxHYZ/oO3oYXuI0J5umY4o8Y+MaMDfTKBW2E1pczCqa7pF7IYiR
         GSd+OcYKDKjopHz/aWmkSKpXwBYsv4t6Y5Pxzpj5QFbt3UhKrSKZ1AHIRr6Z2C8Ti5
         X6SczuEHTfZkmhVq8Vp6T0BxJ5biO8MKil7O7Q6GcFzXF7EaAYkZo94zaB05XDs6ZN
         i5U+9VgjObOsk2KDjx6u+xwxJzIVPweBYRQqDjAW4TuVekbOOv3bUdq3yQNr2pzecp
         I4b65s86POILw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1926284813.753014.1627553002984@mail1.libero.it>
References: <20210725160725.10788-1-dariobin@libero.it> <CAPTRvHkf0cK_4ZidM17rPo99gWDmxgqFt4CDUjqFFwkOeQeFDg@mail.gmail.com> <1926284813.753014.1627553002984@mail1.libero.it>
Subject: Re: [RESEND PATCH v4] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
To:     Dario Binacchi <dariobin@libero.it>,
        Dillon Hua <dillonhua@gmail.com>
Date:   Fri, 30 Jul 2021 12:47:16 -0700
Message-ID: <162767443658.714452.1239845779696330360@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2021-07-29 03:03:22)
> Hi Dillon,
>=20
> > Il 28/07/2021 12:03 Dillon Hua <dillonhua@gmail.com> ha scritto:
> >=20
> > =20
> > Hi Dario,
> >=20
> > I have a similar patch [1] submitted last year.
> > Unfortunately, it did not get accepted by the maintainer.
> >=20
> > Just a reminder here for you, should remove
> >=20
> > { STM32F4_RCC_APB2ENR, 26, "ltdc", "apb2_div" },
>=20
> Thank you for your suggestion.
> While testing the patch on the stm32f469-disco board I didn't
> notice the white screen issue. I'll try to run the tests again.=20
> I will let you know.
>=20

Ok, I'll drop this from the tree.
