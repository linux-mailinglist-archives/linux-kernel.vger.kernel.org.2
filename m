Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CF36C72D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhD0Noa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:44:30 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:59145 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhD0No2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:44:28 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2DA2322235;
        Tue, 27 Apr 2021 15:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619531024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ze37HUrwcuaMM/+Jzy68z8algoMq0xuZK6yTkRT4q8M=;
        b=kjI5xZWwFd2IVvSaXVY2fvDhN/Wtg11m4WXlgu9YGwKstX3v4SodNqo5eFvRQ0qJmXdEX/
        JSwoVVTOnEgtzjHklTev48pVZP3/CoQ8Vh2byAOApYJL12U8+F37vqnxIoJvNVbebzloCI
        WROTvUuE83KYkhVODGdu5F8SZLvIaAQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Apr 2021 15:43:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     kernelci-results@groups.io, broonie@kernel.org,
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
In-Reply-To: <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
 <20210427101926.GA4605@sirena.org.uk>
 <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <e20b9c8a2715b5d091a8d1f37ba890b4@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-04-27 14:51, schrieb Guillaume Tucker:
> +Heiko +Michael
> 
> On 27/04/2021 11:19, Mark Brown wrote:
>> On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:
>> 
>>>>> If so, all sai1 - sai6 are using "fsl,vf610-sai",
>>>>> all saiX doesn't have .name. I think it should have different name.
>>>>> In your case, at least, sai5 / sai6 needs to have
>> 
>>>> You could send a patch along with re-adding the three patches I 
>>>> dropped?
>> 
>>> Thanks, I can do it.
>>> But I want to confirm above first.
>>> Let's keep Guillaume's happiness :)
>> 
>> This board is in the Kontron lab - KernelCI is just reporting results
>> from it, we'd need to connect with someone from Kontron for system
>> specific questions.  Guillaume, I don't know what e-mail they wanted 
>> to
>> be used here?
> 
> 
> We can have KernelCI tests re-run with extra kernel patches in
> any lab, but yes for discussing actual changes related to the
> platform it's best to ask Kontron folks directly.
> 
> Heiko, Michael, is this something you can please help with?

Sure, just put me on CC and I can test the patches manually.

-michael
