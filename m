Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF564424DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbhJGHKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhJGHKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:10:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F4C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 00:08:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y12so5579685eda.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwbZXV5jSczOvQnQmFQUZmvpQjyi3EVC6JkF6fMhuZs=;
        b=SYAnm6NVK2kthlNvw12cu1PYbcGwU9d1U8T3+c9wzowdzbIrpkuifPU9pDE/ceV6hL
         KmvOCEbmwK/yijpfC/gIt2iZ7b7ss+JfH5PD4N0cJlQo54zT1sXO7KR0UREjuigQJsSB
         kO0N78n/OyHqRJHadvEhN77QjYrfTTl6cS7dyV6TqXllNrjw8DAzAkqJ1ip8Ew1qf5cM
         w4vgcD4Mxw1WQNawBX5L56DICBrCYKW/5OzsYvy717YKxSyG5G1BzLQcFJmArwPlBxQ4
         lfHOf5zJG3BZ/T1Mieqa06RCIqsr+V3clYyFspeeg/A/8Jn4RfRsFrrf05iCUfIL+XQC
         IEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwbZXV5jSczOvQnQmFQUZmvpQjyi3EVC6JkF6fMhuZs=;
        b=r1duETOFmPkqr0g+RTROXZ39NumrL1z6+VTeZdKsB0uKS96lVy4F0Lx2uzhmcmn5eu
         bfXLUY2aZyPxHiqaAmlRqf8xV0LAFdPl0G0iXRDZQ9jfsk2L42LtmDOr/rleZw6rOAG0
         g+B/9grPTTsYXLzPYIadpFHs61/XqnMj033eioN6CX3heDmgd3fLVj7pDlVvjQx3JEn0
         aUrgLG5dALdToNSHm9kckYzMNjzlbi7tk2sODStSgVVHS9mNcw/slVGpNY5mB5gp5paF
         YGRnmvWFpg5a0huexI//j5ddmyG7jsLNxD0uV/czGB+aRmRonrcPtt3QiiEb00GI/Grm
         W1Zw==
X-Gm-Message-State: AOAM531rAUeDMOsQCHAxtHWlhSABZxz+9yo5k27dc+Ygm53PMsbjlWwN
        wSnwe2X3ODO33PMlZwCcMD1u+hHeyJs/7OFXbKQ=
X-Google-Smtp-Source: ABdhPJwIEK/odaRxepSdt44uG5K4KnkH/6nJf5DILqlmOwKchGMXsjI9PiPE/5Ai1mwhLC8uAxAWOOYE5A9HImzm3sg=
X-Received: by 2002:a17:906:1707:: with SMTP id c7mr3353614eje.377.1633590522083;
 Thu, 07 Oct 2021 00:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com> <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
In-Reply-To: <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Oct 2021 10:08:06 +0300
Message-ID: <CAHp75VdiY98mO2Sj_Urv6m3GgpoUrSyDiPttGxTQeCv_z_1DzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ASoC: Intel: bytcht_es8316: Get platform data via dev_get_platdata()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 7:14 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 10/6/21 10:04 AM, Andy Shevchenko wrote:
> > Access to platform data via dev_get_platdata() getter to make code cleaner.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> For the series
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>

Are you sure you gave the correct email here?

-- 
With Best Regards,
Andy Shevchenko
