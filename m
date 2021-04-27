Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFC36C66B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhD0Mwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhD0Mwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:52:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2798C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:51:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id E09B91F425B2
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
To:     kernelci-results@groups.io, broonie@kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Michael Walle <michael@walle.cc>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
 <20210427101926.GA4605@sirena.org.uk>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
Date:   Tue, 27 Apr 2021 13:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427101926.GA4605@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Heiko +Michael

On 27/04/2021 11:19, Mark Brown wrote:
> On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:
> 
>>>> If so, all sai1 - sai6 are using "fsl,vf610-sai",
>>>> all saiX doesn't have .name. I think it should have different name.
>>>> In your case, at least, sai5 / sai6 needs to have
> 
>>> You could send a patch along with re-adding the three patches I dropped?
> 
>> Thanks, I can do it.
>> But I want to confirm above first.
>> Let's keep Guillaume's happiness :)
> 
> This board is in the Kontron lab - KernelCI is just reporting results
> from it, we'd need to connect with someone from Kontron for system
> specific questions.  Guillaume, I don't know what e-mail they wanted to
> be used here?


We can have KernelCI tests re-run with extra kernel patches in
any lab, but yes for discussing actual changes related to the
platform it's best to ask Kontron folks directly.

Heiko, Michael, is this something you can please help with?


Best wishes,
Guillaume


P.S. archive: https://groups.io/g/kernelci-results/topic/broonie_sound_for_next/82277947
