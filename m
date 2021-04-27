Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4B36C8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhD0PaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhD0PaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:30:22 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFB5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:29:38 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 22EF422258;
        Tue, 27 Apr 2021 17:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619537376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iEVFDUINoOm1rLf1JpF4YSna7leXoZim54DERO49TZg=;
        b=L4N6lp0+PC1eCnVBMbtTlBBkb+IzG0TBsOvw84xVahqO+Sh7B/0/M9CY15dE/d80zOyPbe
        xPQyAn33WuYdxKv0CcnDut2h1bdBkOToAcYb8hue/Muh7BERXKSAYvreEiwaIUTzbXMmlE
        I4JIhiY7P7Ly+JZ4CHEa9PAlxOeT6ts=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Apr 2021 17:29:35 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
In-Reply-To: <cc9a39f977c3765d1060ab1b0038bc79@walle.cc>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
 <20210427101926.GA4605@sirena.org.uk>
 <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
 <e20b9c8a2715b5d091a8d1f37ba890b4@walle.cc>
 <20210427135703.GH4605@sirena.org.uk>
 <cc9a39f977c3765d1060ab1b0038bc79@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a1ec388def4febd9af6ef477245ef2d3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-04-27 16:16, schrieb Michael Walle:
> Am 2021-04-27 15:57, schrieb Mark Brown:
>> On Tue, Apr 27, 2021 at 03:43:42PM +0200, Michael Walle wrote:
>>> Am 2021-04-27 14:51, schrieb Guillaume Tucker:
>>> > On 27/04/2021 11:19, Mark Brown wrote:
>>> > > On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:
>> 
>>> > > > > > If so, all sai1 - sai6 are using "fsl,vf610-sai",
>>> > > > > > all saiX doesn't have .name. I think it should have different name.
>>> > > > > > In your case, at least, sai5 / sai6 needs to have
> 
> Where does that (null) come from? I've briefly tried the following
> patch and I'd assume I get a duplicate for "abc-wm8904-hifi", but I 
> still
> get the old (null)-wm8904-hifi.
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 407a45e48eee..36280008b5c6 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1081,6 +1081,7 @@ static int fsl_sai_probe(struct platform_device 
> *pdev)
>         sai->cpu_dai_drv.symmetric_rate = 1;
>         sai->cpu_dai_drv.symmetric_channels = 1;
>         sai->cpu_dai_drv.symmetric_sample_bits = 1;
> +       sai->cpu_dai_drv.name = "abc";
> 
>         if (of_find_property(np, "fsl,sai-synchronous-rx", NULL) &&
>             of_find_property(np, "fsl,sai-asynchronous", NULL)) {

Ok here it is whats going on:
We have a simple-audio-card. We use
freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts. The codec name is
parsed correctly and set to either f140000.audio-controller or
f150000.audio-controller. Thus have different names. _But_ later
asoc_simple_canonicalize_cpu() will reset the dai_name pointer to
NULL in simple_parse_node() if "single" is 1 and then we end up
having two links with the same name.

Which begs the two questions:
  (1) What is "single" actually and when should it be 1?
  (2) If single is 1, then the sysfs file will be named 
"(null)-codec-name".
      Do we want that?

I guess there is a reason for it to be set to NULL, see [1].

-michael

[1] 
https://elixir.bootlin.com/linux/v5.12/source/sound/soc/generic/simple-card-utils.c#L420
