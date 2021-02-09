Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FD31515A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhBIOPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBIOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:15:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA49FC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:14:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n6so9168447wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hUh/wcUnUiqWLSuZNUcSG49hoBmdkF7bh0pKMix4LK4=;
        b=i6yAEp9fsEQMPTs1jK5sCt2+BjobvrhRaHbWpE75MODFwS+yEZchD4VACw7QMIIiN6
         QuHtxzioIQRtMRVVV3+3+LKHV+UNhWY2ecwdq4iA+KXPR8ewMv2cUHPeGs5yOltgw5gE
         Fj1eyS7FOaOWnNLK7Eo+pjKEgDrwyWqWuxUkNtQbMU7GMJYFKhutN8P2pX2qfJFYWFbS
         hXyRsoS3gk73nRV4AaE6RUrnowQx1tZdJeDPoi222cEew74atJCtuqiT/Hj+bF0KFZOE
         IGyIgfowfy69HxtyqCV4o3+BBEyveBhw7Ltm/HCkIclkhU2sPFKmLUCwKtOYfZWxhp6V
         gUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hUh/wcUnUiqWLSuZNUcSG49hoBmdkF7bh0pKMix4LK4=;
        b=UJ1sFhG0eR8GodD1t72CPJpZGPczIzBWMH7sa5GEDA+IT6hCRZf4g5y0CfbrDSTEsk
         KzYhxH1RcG94mNvyubdBCeFvSQKE5gvBUWgGC3x/zgqVZnVfvMNhtuuJBn///ozdoL3R
         a4tOf+NILFa0R/pJOuV9WOfHHzxXNrxtI9D98yaQaTfLCSJz+N6nHypFR+yJwxzoxZth
         PiGR3Qubn59zidiKDc2msTTHNCBlE/ECZWjCZvqiFJ83vKlATUVh8Yvr9tZq+KsaJBJC
         ck6wCCvfKKxhfoMOMLlM6xonxSvsdfKNB/A7Fes2uYoU7z0+4dbclTG2Dh1vGfV4fIXJ
         QqIA==
X-Gm-Message-State: AOAM530xGiTmNJamxxLILGmffqHOy2V44Ro3utSFTmGm69Bg/wQKp8TP
        o82RevCExzBZ3ZA40AdkQfDJiQ==
X-Google-Smtp-Source: ABdhPJwmnXMhwytoTjOqdn/JsfTqEJ8zMkMFFECn7aCIS0nMMnpkSDd9rrqcgUZNL/CR9gPjIlvyYw==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr25947457wrt.269.1612880062687;
        Tue, 09 Feb 2021 06:14:22 -0800 (PST)
Received: from dell ([91.110.221.187])
        by smtp.gmail.com with ESMTPSA id h207sm5096569wme.18.2021.02.09.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:14:22 -0800 (PST)
Date:   Tue, 9 Feb 2021 14:14:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210209141420.GE4766@dell>
References: <20210204112502.88362-1-hdegoede@redhat.com>
 <ba9c1add-8ac0-766b-4577-1c2769c0e5e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba9c1add-8ac0-766b-4577-1c2769c0e5e6@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Feb 2021, Hans de Goede wrote:

> Hi Mark, Lee,
> 
> On 2/4/21 12:24 PM, Hans de Goede wrote:
> > Hi all,
> > 
> > Here is v4 of my series to rework the arizona codec jack-detect support
> > to use the snd_soc_jack helpers instead of direct extcon reporting.
> > 
> > This is a resend with some extra *-by tags collected and with the extcon
> > folks added to the "To:" list, which I somehow missed with the original
> > v4 posting, sorry.
> > 
> > This is done by reworking the extcon driver into an arizona-jackdet
> > library and then modifying the codec drivers to use that directly,
> > replacing the old separate extcon child-devices and extcon-driver.
> > 
> > This brings the arizona-codec jack-detect handling inline with how
> > all other ASoC codec driver do this. This was developed and tested on
> > a Lenovo Yoga Tablet 1051L with a WM5102 codec.
> > 
> > This was also tested by Charles Keepax, one of the Cirrus Codec folks.
> > 
> > This depends on the previously posted "[PATCH v4 0/5] MFD/ASoC: Add
> > support for Intel Bay Trail boards with WM5102 codec" series and there
> > are various interdependencies between the patches in this series.
> > 
> > Lee Jones, the MFD maintainer has agreed to take this series upstream
> > through the MFD tree and to provide an immutable branch for the ASoC
> > and extcon subsystems to merge.
> > 
> > Mark and extcon-maintainers may we have your ack for merging these
> > through the MFD tree ?
> 
> Now that the pre-cursor (1) series to this has been merged, I guess it
> is time to decide how to merge this series. 
> 
> Chanwoo Choi has given his ack to merge the extcon bits through the MFD
> tree and since Mark has expressed a preference for merging ASOC patches
> directly I guess that it would be best to merge 1-6 through the MFD
> tree and then Lee can send Mark a pull-req and Mark can apply the others? :
> 
> 1/13  mfd: arizona: Drop arizona-extcon cells
> 2/13  extcon: arizona: Fix some issues when HPDET IRQ fires after the jack has been unplugged
> 3/13  extcon: arizona: Fix various races on driver unbind
> 4/13  extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
> 5/13  extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
> 6/14  ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c
> 
> 1 is:    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 2-6 are: Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Note patch 6 renames drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c
> but it does not touch any other files under sound/soc (including NOT touching
> sound/soc/codecs/Makefile that is done in a later patch). So it cannot cause any
> conflicts.
> 
> Mark, would merging 1-6 through the MFD tree, and you applying the rest
> (which are all ASoC patches) work for you ?

What a faff.

I still don't see why they can't all go in and a PR provided.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
