Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3770A3C99F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhGOHw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:52:56 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:34775 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232035AbhGOHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:52:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id AC6A22B01189;
        Thu, 15 Jul 2021 03:50:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Jul 2021 03:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=U
        29kzEGbfUM6Z8XvuEF2py4Ztxj0+cmZ1D2H3aHU1Rk=; b=P/zZfzMQ3jBhkBgtZ
        TBXCgMzWuy3/yttcjD6D6HmiAKv8so5lCut6KHhcZjI5DyGXb5Wj2T0z+PJnkZ0+
        vUlvr1m+e/jNqDNZLT5pIXgVbADLVM0k+VBGQKawTl+hp8E4TEvlgoF2NKYSlTIo
        Zw/COeP2p8kI9El0SC2PiTTQJBkkLTHai8FNeuIk5B/ILf84dIWGmJL4kmpUl601
        aX311EMl08JxE3pynjmXzcuwSiuKyNxIghO3XAMemo825OD3AINCxOneSlBIMfQA
        JQH3LHaaS5mb8vCJ3NN2TQC0qF8h5ox+xKPGL0txcvWN5md/2NFg1/AnGv5PB6B6
        MLpOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=U29kzEGbfUM6Z8XvuEF2py4Ztxj0+cmZ1D2H3aHU1
        Rk=; b=kIE7Kfv+i+lwi3GdUglJydCo6srdsKxhjEVKAz85cKLp13nombLw6jgxb
        rHK5ylbJfS0M4DXTO17zpu/4oonqs0Exmcktf5JzurrHT3AtcaewM2KO7n9D52WK
        pYY1Cv+xdZQScjmjrLVYM5lZ61nsvHfLWBX4XIIGS6lLOdIuQnGq5QFwUCMbc6eX
        D9aLt2C8DQ6S9l0k7unWU++CHqZ5/KqYjzoYYxotEKthVWhIhM5a1XOuZgCBJeNE
        PlUK+AE4ig1OqmVwpy0cJ0m8iRuSP+jBpYcnwt0YHOhUbrjwZVoOjVuWznIaefCv
        QldBWa496rXqx084tqjvRgzdc4ehw==
X-ME-Sender: <xms:qejvYBTU5O-BDYHWIvv5zYYhcZNfdT0shVzU6GG9Wpi8jY49T08G6g>
    <xme:qejvYKxgXt3ANkAlTQsNH5jMZiuBxv0EZVF8ujRtQTSPUvsjsJn-osnIKdDtqFjDl
    78RMZMn8FLqdLNPyus>
X-ME-Received: <xmr:qejvYG0J-klDNHInXJ1vTpaEGyN0Tl9Tt7bO_0B8iocAKnV-zD4WHnqGqDnDtRM02E6APeAmtS-T92THxVRSRSo23EwCAMLZW_cv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudelgddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtqh
    ertddttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegt
    vghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepgfejtedtjefggfffvdetuedthe
    dtheegheeuteekfeeghfdtteejkeeludegvddunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qejvYJBdTZ-uy74WMfOHpf9yGBOFCt9PR00A58yZUdRpOxRuWMj2YQ>
    <xmx:qejvYKj6A7POSj7xPU1a4kgskh3qVuwq7G21x7YLvZFf36ZXVw8N0A>
    <xmx:qejvYNpFqw8gMyB_lT4aeFu58JX5AvG0yzq2UJrCgtf-msAQMtU2Ag>
    <xmx:qujvYFMCtY_0qzASHVQ2b8MW28OCO5d9EraZrt9QM6ywd83Rj9HsL2HK92o>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jul 2021 03:50:01 -0400 (EDT)
Date:   Thu, 15 Jul 2021 09:49:59 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     fengzheng923@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings
 for DMIC controller
Message-ID: <20210715074959.lepsaiyl3ihthy4s@gilmour>
References: <20210711124826.5376-1-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210711124826.5376-1-fengzheng923@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 08:48:26AM -0400, fengzheng923@gmail.com wrote:
> From: Ban Tao <fengzheng923@gmail.com>
>=20
> DT binding documentation for this new ASoC driver.
>=20
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

> ---
> v1->v2:
> 1.Fix some build errors.
> ---
> v2->v3:
> 1.Fix some build errors.
> ---
> v3->v4:
> 1.None.
> ---
> v4->v5:
> 1.Add interrupt.
> 2.Keep clock and reset index.
> ---
> v5->v6:
> 1.None.
> ---

Just as a general comment, you don't need to duplicate the --- all the
time, here something like the following would have been fine

---

v1->v2:
1.Fix some build errors.

v2->v3:
1.Fix some build errors.

v3->v4:
1.None

etc.

git will ignore anything after ---, so it doesn't matter whether there's
one or multiple.

Maxime
