Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037783FEFF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbhIBPRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhIBPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:17:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FCFC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 08:16:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h9so5221340ejs.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4DzLI53lYMtZaqfXhMaCm/bYg8peNwO+6H09pZqkys=;
        b=qwE320N5vyznN3Gu7Q26QdV3Fw+hHr+p/bz3aAAIp7Sjpwoy2WgQ1r5xaDh+LngkfA
         NUSGe7bzzl1OUHYP5hfb0ESvxzAf01jnk9rr/OwUNc13XFwNlk/vyoB1G+fFiXT8Lw6h
         ORT6HZhxTWbywtLEsvzHRrHVX5GHazMRINqAFhWM0DgSNjt9wGz8Skz+qvwdgzNGb+9+
         D3p3h0vK1cKs8UZYdvHZbj7xY1SN4aogy48DuINBSZHWAUJrrjJ8SQxNTSbmXWCFGleF
         TCBIA8VQQyTy7ZJfU1f3gItDn9B+lsi08TfmOynN325qVsVtAL8dZpai1T5fkk1jvk36
         cJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4DzLI53lYMtZaqfXhMaCm/bYg8peNwO+6H09pZqkys=;
        b=SUaC4OBDra2cu1NtNGVok/dgXdbANeiWsxE4sBSA5+7+aaTSgWAScNjGFPhqFLAC3g
         hTEzH3MqjRjUmNmhGsmg4ueAN/R/9cTXM3yblriFGdRgTMX2B+Ckqss8ayH+XxvsE2N1
         6yVF95Cs0g4BunyL0bCA2Y9CcnPTDBgMat1GlJaBTqwv4Bhn8yUACtShAAQmZ580pa1z
         5s5IC81P8449X9cpRdVPNliEn0k8Ezgn1NZdjuk4QLbs4DSqwedJ7Yp/HAj5liAtPhhu
         TJruVG/vwaWDI8kBe3ZA9CIB0J84DoWelYQYU0vLZ6urBO2BP8FdRFU2qOobP0zH+wqE
         HBsg==
X-Gm-Message-State: AOAM5325EOFMa+ND9dgIk3nVPcn03bOV0JxfGk1c/m7mBlXEepxABSrJ
        gMGNW9MT2/Q6J1cb7vCQglk=
X-Google-Smtp-Source: ABdhPJz1s6GNbWTftm7CobRsJqR+q3SP4zM3JUCjWymuszgjCJmWH/xfnx2WIsqZFdJ3EAR4F7ko2A==
X-Received: by 2002:a17:906:8489:: with SMTP id m9mr4244252ejx.396.1630595776655;
        Thu, 02 Sep 2021 08:16:16 -0700 (PDT)
Received: from agape.jhs ([5.171.80.234])
        by smtp.gmail.com with ESMTPSA id n13sm1347598edq.91.2021.09.02.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:16:16 -0700 (PDT)
Date:   Thu, 2 Sep 2021 17:16:11 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     tiwai@suse.com, perex@perex.cz, broonie@kernel.org,
        lgirdwood@gmail.com, Hans de Goede <hdegoede@redhat.com>,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: config issue with SoundWire mockup device support
Message-ID: <20210902151610.GC1422@agape.jhs>
References: <20210902143632.GA1422@agape.jhs>
 <10bb39d4-2560-4ceb-bf20-fe5a124142cb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bb39d4-2560-4ceb-bf20-fe5a124142cb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Thu, Sep 02, 2021 at 10:02:05AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 9/2/21 9:36 AM, Fabio Aiuto wrote:
> > Dear Pierre and all sound developers,
> > 
> > I work for some tests on a Lenovo ideapad Miix 300-10IBY,
> > with fedora 34 workstation intalled on.
> > After having pulled the last changes from staging tree I get
> > the following issue by typing:
> > 
> > $ make olddefconfig
> > 
> > WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
> >   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
> > 	&& EXPERT [=n] && SOUNDWIRE [=y]
> >   Selected by [m]:
> >   - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=m] && SOUND [=m] && !UML
> > 	&& SND [=m] && SND_SOC [=m] && SND_SOC_INTEL_MACH [=y]
> > 	&& SND_SOC_SOF_INTEL_SOUNDWIRE [=m] && I2C [=y] && ACPI [=y]
> > 	&& GPIOLIB [=y] && (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])
> > 	&& (SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES [=y] || COMPILE_TEST [=n])
> > 	&& SOUNDWIRE [=y] && SND_HDA_CODEC_HDMI [=m] && SND_SOC_SOF_HDA_AUDIO_CODEC [=y]
> 
> It's a known issue that was reported and fixed by Nathan Chancellor:
> 
> [PATCH v2] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
> 
> https://lore.kernel.org/alsa-devel/20210802212409.3207648-1-nathan@kernel.org/
> 
> I'll ack the missing patch, thanks for reporting this.
> 

you are welcome,

thanks for fast reply,

fabio
