Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFE3A7E51
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFOMlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhFOMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:41:49 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:39:45 -0700 (PDT)
Received: from [10.88.0.186] (dslb-084-062-104-230.084.062.pools.vodafone-ip.de [84.62.104.230])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ch@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8653F80EC6;
        Tue, 15 Jun 2021 14:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623760783;
        bh=/himMSkTfivyhxtCVhwVEdFJBtlSgUHF5C534nSY1zc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OfkEtT3rkWUW/EmOvthWli3dCtmF/VbkMUJ1dTkJQdvYNrLKspj42M9CDfMnqjnu/
         W4CHBr9KkzsxLIEm/lhDxTg6dMKGhPQpbHBTBBlaBeGz6uTYxhM74YFLwrBuhSHeow
         XBNmRJ7GJu1jyKCLfebdYHYnc0WfvJsEVZTgtASTuD6W4Ky7/cJD3idrTM88YdseEh
         /3CG0aloWVFE9D6XMoGdUSlSM3SnvN+pHc1vC9NtmWS7C0enPkBviw3R8IuuV76QZt
         orETqX2VGOdQEztl+cy1NGy5wYClMqt6Qt+Xe4mr6tmMrEormt49oJHQrURg73v6P+
         EWyEo9QOq06OA==
Subject: Re: [PATCH 2/3] ASoC: tlv320aic32x4: add support for TAS2505
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Marek Vasut <marex@denx.de>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210615094933.3076392-1-ch@denx.de>
 <20210615094933.3076392-3-ch@denx.de> <20210615122241.GE5149@sirena.org.uk>
From:   Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <4b72d6cd-ef07-fcdd-f90b-1cd53a3e3c8b@denx.de>
Date:   Tue, 15 Jun 2021 14:39:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210615122241.GE5149@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-15 14:22, Mark Brown wrote:
> On Tue, Jun 15, 2021 at 11:49:31AM +0200, Claudius Heine wrote:
> 
>> +static int aic32x4_tas2505_spkdrv_putvol(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
>> +	struct soc_mixer_control *mc =
>> +		(struct soc_mixer_control *)kcontrol->private_value;
>> +	u8 val;
>> +
>> +	val = (ucontrol->value.integer.value[0] & 0x7f);
>> +	val = mc->invert ? mc->max - val : val;
>> +	val = (val < 0) ? 0 : val;
>> +	snd_soc_component_write(component, TAS2505_SPKVOL1, val);
>> +
>> +	return 0;
>> +}
> 
> Controls should return a boolean indicating if they changed their value
> when written.  Other than the hard coded register what's device specific
> here?  It looks like a normal control with a maximum value, it is
> unclear why this is being open coded.

Well probably because I didn't knew any better. Will look into it. Thx!

> 
>> +	SOC_DOUBLE_R_S_TLV("HP Driver Gain Playback Volume", AIC32X4_HPLGAIN,
>> +			AIC32X4_HPLGAIN, 0, -0x6, 0x1d, 5, 0,
>> +			tlv_driver_gain),
> 
> Drop the Gain.  See control-names.rst.
> 

Ok.

Thanks!
Claudius
