Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC27D306DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 07:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhA1GgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 01:36:21 -0500
Received: from muru.com ([72.249.23.125]:53788 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhA1GgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:36:19 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2C6A680A9;
        Thu, 28 Jan 2021 06:35:39 +0000 (UTC)
Date:   Thu, 28 Jan 2021 08:35:30 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, broonie@kernel.org,
        aaro.koskinen@iki.fi, spinal.by@gmail.com,
        jarkko.nikula@bitmer.com, merlijn@wizzup.org, sre@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        phone-devel@vger.kernel.org, kuninori.morimoto.gx@renesas.com,
        Carl Philipp Klemm <philipp@uvos.xyz>
Subject: Re: [PATCH] ASoC: ti: Allocate dais dynamically for TDM and audio
 graph card
Message-ID: <YBJbMqt4PbeU/fD4@atomide.com>
References: <20210124092713.GA22195@amd>
 <2a9e7655-3d32-feb5-080c-8928a96f417e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a9e7655-3d32-feb5-080c-8928a96f417e@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Péter Ujfalusi <peter.ujfalusi@gmail.com> [210126 06:00]:
> On 1/24/21 11:27 AM, Pavel Machek wrote:
> > From: Tony Lindgren <tony@atomide.com>
> > +	for (i = 0; i < mcbsp->dai_count; i++) {
> > +		struct snd_soc_dai_driver *dai = &mcbsp->dais[i];
> > +
> > +		dai->name = devm_kasprintf(mcbsp->dev, GFP_KERNEL, "%s-dai%i",
> > +					   dev_name(mcbsp->dev), i);
> > +
> > +		if (i == 0) {
> > +			dai->probe = omap_mcbsp_probe;
> > +			dai->remove = omap_mcbsp_remove;
> > +			dai->ops = &mcbsp_dai_ops;
> > +		}
> 
> You are effectively creating extra dummy-dais (no ops), but naming them as
> McBSP.
> The dummy-dais will only work if the real dai is in use and the dai link
> which contains the real dai must be configured (TDM slots, format, channels)
> to accomodate the link which contains the dummy-dai.
> 
> The idea did not aged well for me ;)
> It still looks and sounds like a hack to model the TDM slots on a single DAI
> as multiple DAIs just to satisfy a generic binding which is not aimed to
> satisfy the droid4 setup (which is far from anything simple).

After thinking about this a bit more, I think the voice call dai should be
created by the voice dai. When we have an active voice call, the data
transfer is completely out of control of the kernel mcbsp driver. It needs
to be only configured on the pmic.

So I'm suggesting tha we create the modem voice call dai as a child for
sound/soc/codecs/cpcap.c, does that sound OK to you guys?

I think from snd-soc-audio-graph-card binding point of view, we'd just move
the cpu_dai_mdm endpoint out of the mcbsp in the device tree and drop the
$subject patch. Then the dts for the pmic voice codec becomes something
like this (untested):

cpcap_audio: audio-codec {
	#sound-dai-cells = <1>;
	#address-cells = <1>;
	#size-cells = <0>;

	port@0 {
		reg = <0>;
		cpcap_audio_codec0: endpoint {
		};
	};
	port@1 {
		reg = <1>;
		cpcap_audio_codec1: endpoint@0 {
		};
		cpu_dai_mdm: endpoint@1 {
			reg = <1>;
			dai-format = "dsp_a";
			frame-master = <&cpcap_audio_codec1>;
			bitclock-master = <&cpcap_audio_codec1>;
			remote-endpoint = <&mot_mdm6600_audio_codec0>;
		};
        };
};

For things like recording a voice call, I think mcbsp could be configured
to also listen on the traffic and dump it out. I guess that could also
happen directly with calls from the sound/soc/codecs/cpcap.c driver to
the mcbsp driver since we havethe audio graph mapping. Anyways, that's a
separate series of patches, still something to consider.

Regards,

Tony
