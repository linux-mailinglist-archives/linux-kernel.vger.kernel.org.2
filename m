Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7AF42808B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhJJKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:42:36 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52237 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhJJKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:42:34 -0400
Received: from bagend.localnet (86-126-20-31.ftth.glasoperator.nl [31.20.126.86])
        (Authenticated sender: didi.debian@cknow.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7B7CD1C0006;
        Sun, 10 Oct 2021 10:40:31 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Date:   Sun, 10 Oct 2021 12:40:00 +0200
Message-ID: <5069869.zQgEQKRxDW@bagend>
Organization: Connecting Knowledge
In-Reply-To: <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org> <4974503.Y8KB3sNASq@bagend> <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9604810.WXvppzzZfE"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9604810.WXvppzzZfE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Thierry Reding <treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Date: Sun, 10 Oct 2021 12:40:00 +0200
Message-ID: <5069869.zQgEQKRxDW@bagend>
Organization: Connecting Knowledge
In-Reply-To: <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org> <4974503.Y8KB3sNASq@bagend> <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz>

On Sunday, 10 October 2021 10:40:09 CEST Jaroslav Kysela wrote:
> > Unfortunately this change broke multichannel audio on my Rock64 device
> > running Debian. My Rock64 is connected to my AVR (Pioneer SC-1224) via a
> > HDMI cable.
> This looks like an user space configuration problem.

I have placed ALSA card definitions (I think) from LibreELEC on my system from
https://github.com/LibreELEC/LibreELEC.tv/tree/master/projects/Rockchip/
filesystem/usr/share/alsa/cards

I have just prepended "LE-" and appended ".bak" to those files and rebooted and 
that resulted in only "output:stereo-fallback" profiles.
Just like in what I considered 'failures' that I tracked down to this commit.

So it appears that LE's card definitions *gave* me multichannel output, whereas 
I wouldn't have had it otherwise. 
It also explains why the sound issue occurs with LE too.

Note that I took/used LE's work as 'inspiration' to improve things on Debian.
Their work seems very good to me and one of their card definitions was also 
referenced from (kernel) commit 25572fb5aa986bdbb35d06c0fb52a9b9d9b3b2c9 
titled "arm64: dts: rockchip: enable HDMI sound nodes for rk3328-rock64"

> if a PA profile or an UCM configuration is used (in the PA debug log).

While I don't consider myself clueless wrt Linux (running Sid for 10+ years), 
I am clueless wrt how ALSA/PA/audio-in-general works (on Linux).
When I do 'journalctl -b -u pulseaudio --since="2021-10-10 12:00:00"' I get a 
lot of output and also several 'errors', but I have no clue how to interpret 
that. I also get that when AFAIC (from a user standpoint) everything 'works'.
So I'd need some help with that.

I could attach output of (several runs of) "journalctl" and f.e. the output of 
'alsa-info', but I haven't yet as it may not be appropriate and may also no 
longer be considered a kernel problem (and the 'To:' list is (far) larger then 
I'm used to). So I'd need some guidance with that too.

Regards,
  Diederik
--nextPart9604810.WXvppzzZfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCYWLDAAAKCRDXblvOeH7b
bhY0AQCQonSziFIkdstiX3euzGfJ/VA3DGwfPowhsWaKGS3xXwEA1GuxWxCPsYrj
fxWSnqQiikaZvAB1joo64fn0IKyH5Qw=
=blow
-----END PGP SIGNATURE-----

--nextPart9604810.WXvppzzZfE--



