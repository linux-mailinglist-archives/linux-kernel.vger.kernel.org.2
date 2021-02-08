Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C96431408B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhBHUcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235959AbhBHTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612811557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ga/01DJtnt1YQ1TickbSUnZPUyWpDjUziTg4Oj+MDw=;
        b=UrpIYTmPb1BqGcad/3pcSdQ0I9nO7OprhPIptygf9ahU0ND0Ir8D6WbhacrA6AEiumS7fW
        6KL1X3T/8HuGcjgLFfNY8oTDY3iqg0TymsjWUgS969OLow0k5LBwx6xcyYH4zxfx+qayc9
        um44Hb0w7n30XCkv1oNDuWJiseWldX4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-IcWcnGrxNd6VWSmD5jdfyA-1; Mon, 08 Feb 2021 14:12:36 -0500
X-MC-Unique: IcWcnGrxNd6VWSmD5jdfyA-1
Received: by mail-ej1-f70.google.com with SMTP id w16so13056228ejk.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 11:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ga/01DJtnt1YQ1TickbSUnZPUyWpDjUziTg4Oj+MDw=;
        b=WTITHmb6XTE8u36DScJvJzatczech8tNCrEn0hgmWz4B2tHaoPaDxN/skg3Ll64O61
         dBq0GHuUibXwy/X26WqiP+sp4Nfq4FI13QU5QDzHcBS0/rQ8XjxG9l4dTrsJUU7irax0
         TV2hZv5SrAaCLWGujZkidXlZza/eQtCWv32HK+i3BMLHNY1tCwQG/wZ0g+db4ZYJ7X5o
         komzYFs61QUl4i/4trF5Ewdk2agSXeM1lvf9mBVTWe4/gxsjhoqGPQuXEzgJBhql9ll5
         qIvXaNcO5uK+kV1YG1XfMnjqP4+OI0nTZjsOHsDxVGBEEBKRoUjNIPPAAVUUt1GmlbgG
         4+Hg==
X-Gm-Message-State: AOAM530Tub/NZ/cHrOkPK+KvG+gKnbelPcAuu9oi6Bafu7qSN390culu
        DGlGCZMHSde5DgGJF/5f0qvhtfwOVGw9JxD5BtsXFU3agown2gsgS/wVr1vDjGWeSOETh2eSELI
        7JZoB3MRPt5XAnDlfqbRZlQ5Q
X-Received: by 2002:a05:6402:22f6:: with SMTP id dn22mr11621056edb.277.1612811554512;
        Mon, 08 Feb 2021 11:12:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzItzCsMyLoaRlWPHUWtyEGWvLqhTsVHre+EcZmnPs1dPt8yhgvLufn3Kr2SsDE8JIgKx8kQ==
X-Received: by 2002:a05:6402:22f6:: with SMTP id dn22mr11621045edb.277.1612811554354;
        Mon, 08 Feb 2021 11:12:34 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x17sm10032753edd.76.2021.02.08.11.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 11:12:33 -0800 (PST)
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210204112502.88362-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ba9c1add-8ac0-766b-4577-1c2769c0e5e6@redhat.com>
Date:   Mon, 8 Feb 2021 20:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204112502.88362-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Lee,

On 2/4/21 12:24 PM, Hans de Goede wrote:
> Hi all,
> 
> Here is v4 of my series to rework the arizona codec jack-detect support
> to use the snd_soc_jack helpers instead of direct extcon reporting.
> 
> This is a resend with some extra *-by tags collected and with the extcon
> folks added to the "To:" list, which I somehow missed with the original
> v4 posting, sorry.
> 
> This is done by reworking the extcon driver into an arizona-jackdet
> library and then modifying the codec drivers to use that directly,
> replacing the old separate extcon child-devices and extcon-driver.
> 
> This brings the arizona-codec jack-detect handling inline with how
> all other ASoC codec driver do this. This was developed and tested on
> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
> 
> This was also tested by Charles Keepax, one of the Cirrus Codec folks.
> 
> This depends on the previously posted "[PATCH v4 0/5] MFD/ASoC: Add
> support for Intel Bay Trail boards with WM5102 codec" series and there
> are various interdependencies between the patches in this series.
> 
> Lee Jones, the MFD maintainer has agreed to take this series upstream
> through the MFD tree and to provide an immutable branch for the ASoC
> and extcon subsystems to merge.
> 
> Mark and extcon-maintainers may we have your ack for merging these
> through the MFD tree ?

Now that the pre-cursor (1) series to this has been merged, I guess it
is time to decide how to merge this series. 

Chanwoo Choi has given his ack to merge the extcon bits through the MFD
tree and since Mark has expressed a preference for merging ASOC patches
directly I guess that it would be best to merge 1-6 through the MFD
tree and then Lee can send Mark a pull-req and Mark can apply the others? :

1/13  mfd: arizona: Drop arizona-extcon cells
2/13  extcon: arizona: Fix some issues when HPDET IRQ fires after the jack has been unplugged
3/13  extcon: arizona: Fix various races on driver unbind
4/13  extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call
5/13  extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
6/14  ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c

1 is:    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
2-6 are: Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Note patch 6 renames drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c
but it does not touch any other files under sound/soc (including NOT touching
sound/soc/codecs/Makefile that is done in a later patch). So it cannot cause any
conflicts.

Mark, would merging 1-6 through the MFD tree, and you applying the rest
(which are all ASoC patches) work for you ?

Regards,

Hans


1) "[PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards with WM5102 codec"

