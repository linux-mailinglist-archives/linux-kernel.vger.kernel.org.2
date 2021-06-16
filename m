Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B23A94E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhFPIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:24:03 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36523 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231727AbhFPIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:24:01 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5E96158044E;
        Wed, 16 Jun 2021 04:21:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 16 Jun 2021 04:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=o
        z1afSZtH4HEgY3zg42iH1DY//zDW8wKRe4vHaTi0y0=; b=lN5SUX1uagJ28V30k
        RC1tmY6DI9XAlPzOqVSgDgaMxG/WoeiuBWcBHIdcB1CXm3e4bqlqrWI/tgyNvqQY
        yDt1jRi5zrXeechHiBDfSvLWt5RFInLKRWIVKMadud5QfJdauxI4/nL7swM22SIf
        twheS0P6OfgJsj5/inWXrlarPgGVHEDeZG8kyeel1AXPSPpYaDW8zqRMDXFY8ziX
        WHcF1E6/pISk7f1Z3cPoMl5dqVwmltX/ND8byzqGhrBMJMzjva9KD2tCSBvA8nfq
        HJBX+raIEVE+do2fz8IMPl9i4JdqzdtlNe79s7m90CLs19qunnb5tI9S1n2jo/O+
        Qf2JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=oz1afSZtH4HEgY3zg42iH1DY//zDW8wKRe4vHaTi0
        y0=; b=bmm63I7VxeIVqq+/FRSF68A0XI3F7eCYsCEWYOYvN1IcHMho3Bdb6+tvM
        e7SKSNiRkCRWKx6dobT/WP/YAa/xq65u/NtfnnVMYZ+mnRTbV2Gx14tWEhF7j8yF
        EEygGeX03XWAv7RVxGALJS1arH8DAcyzqkdTpwDhhlHOaD7kLh6d+i9BPyav4Mzf
        jWBujeIa9fdV2xmFhMXQb/ZK+wYvHHVQTRugeJkLmt00uNtcsF3JWKZBmWIDSaYY
        ha+Lj/10tSQ6bJeHQ+NlGmDHfqzXw5nSIYljfpr0K6AnLAF5dnbdBjQlL0Qwcsbv
        5TDTJJyIPJmabmRS9GZYJJWQ1fl2w==
X-ME-Sender: <xms:obTJYJOBnmrghJOugX0l7MBAFgaXxK24GMDyHJDS5x7AqgI2oYQsrQ>
    <xme:obTJYL9ZYQPVBcCEYKzC09vp6b72sKxTvr1EJpQG27SYuu22iiqXyr32n20BZGSV1
    0cyGdsTzK1Vye7DNEQ>
X-ME-Received: <xmr:obTJYIQoiTyb_IzglrDMyDVN10hTgNvkwd0EdPYKBhREetI-NuAbsVZEE8LInqvQLOwGRZhl4-D7T5Piw4oqTIbi60qx6ZmCOzGm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:obTJYFtEYBd5JB3YPDZATxYUAH4HBhQzopmQFc2JT6yom3hYs_AKhg>
    <xmx:obTJYBehjpvFtceQCmkSwIDKUK91vq3Ur-_q277EsSdqEljlrGN9fw>
    <xmx:obTJYB3dj1QPCy50MWLCnS4Dt_uVahxFGaGwFY93tEPsoEMJFzD3FA>
    <xmx:o7TJYP26NQO9-XFDXfXaF0wuXvyOuehZel8F6E58MuvraDMDZVh_PQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jun 2021 04:21:53 -0400 (EDT)
Date:   Wed, 16 Jun 2021 10:21:51 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ASoC: hdmi-codec: Make symbol
 'hdmi_codec_controls' static
Message-ID: <20210616082151.mrcbswfpponkleve@gilmour>
References: <20210615172156.2840576-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210615172156.2840576-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 05:21:56PM +0000, Wei Yongjun wrote:
> The sparse tool complains as follows:
>=20
> sound/soc/codecs/hdmi-codec.c:750:25: warning:
>  symbol 'hdmi_codec_controls' was not declared. Should it be static?
>=20
> This symbol is not used outside of hdmi-codec.c, so marks it static.
>=20
> Fixes: 366b45b97448 ("ASoC: hdmi-codec: Rework to support more controls")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime
