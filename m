Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C75A456657
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhKRXUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhKRXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:20:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED61C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:17:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id n12so34120392lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t6GvCoTsal2+f79BZzeLuS2NRlSdpapuVkKU2eGjYNs=;
        b=gTiE2vWYAQOyhTAaWLAvX5jzkycwbbcvm6UalQ5ULKbx1Ks1cm/6/+bNqGwZ1+756b
         2innhKXkGvo4tr1F64xknikj/lhpXePxSJijJg4Fy2QmN0WAE1YU3x2DTL7xiRaTlQPV
         hmd8ajN77x4bh/8aUkAi79pbBZwltJWx8WUqYKC70CxRY3ro17LINo4pdCFW3iN3ffZd
         l+E/aT2vWGrwCFGraIiyQAB4+UgXo++R3QMu/whTnG6xpBjve0uvRaTmSYcsbqhMVWGU
         yqK1niBK5/qvGfe2z5/e3U+e5zAqqeR4Mtc0xnRoG3QDctpDAl+7lk1d85YOteCUqql7
         lvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t6GvCoTsal2+f79BZzeLuS2NRlSdpapuVkKU2eGjYNs=;
        b=qryUpC97OLxqb/cru2rICx6r1RWCFFotVgz1iFuZcYyIyQBreinFReD4voCIqvK3mB
         F/NK99UM3x3l2xSNISFMEvXB9YeRaVI66oeqwY67oCOYPIGdFvNCgLVdGgkzRbWFFluu
         ayWkcvzemy2IfPnY6IwGeQvrSmiqFVK6LlDzy9jBE1EXoXarg1eKDGpliKtN0POlJWJ5
         Jrhphj4KrRpfpS/tKE74HtiH349HeYNApAXAJC+ZZ35CWHlt85JWawamehCX2rMRrdga
         vMX/CCPT3AliyBT1FRCE4vI+OE9npNp7W3J0ixIFsW443kerWB/JusdSleNkCaO8P8Vg
         7U8g==
X-Gm-Message-State: AOAM533rCAz30c+ABgbWwhv0PJBumYdhd+K7tx3mcLG24xkztq7Qt9Ec
        ZWgJ1NJcs9myDZUv6DVmngr0PQ==
X-Google-Smtp-Source: ABdhPJxZ4qKH18GDchmVCVOsNvGDWF1o0JBVwijWWjFq3zdgIYxCtN2EgDNDceiDi8FnJgdy5WcWOA==
X-Received: by 2002:a2e:7114:: with SMTP id m20mr20643304ljc.229.1637277453725;
        Thu, 18 Nov 2021 15:17:33 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q15sm157729lfp.32.2021.11.18.15.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:17:32 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 345B5103121; Fri, 19 Nov 2021 02:17:37 +0300 (+03)
Date:   Fri, 19 Nov 2021 02:17:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 5.16-rc1
Message-ID: <20211118231737.opqojtvq6dkffh35@box.shutemov.name>
References: <s5hwnlpmt9x.wl-tiwai@suse.de>
 <20211117161855.m45mxcqszkfcetai@box.shutemov.name>
 <s5hmtm2lphf.wl-tiwai@suse.de>
 <20211117174826.23eakoivl33tawb2@box.shutemov.name>
 <s5hfsrulkxk.wl-tiwai@suse.de>
 <s5hpmqxki3h.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="iquykasoghufro7p"
Content-Disposition: inline
In-Reply-To: <s5hpmqxki3h.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iquykasoghufro7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 18, 2021 at 09:01:38AM +0100, Takashi Iwai wrote:
> I checked mine, and all worked fine.  So this doesn't look like a
> generic breakage but somehow specific to certain devices or system.
> 
> Could you verify the lowlatency flag off?

With lowlatency off it works fine.

I attached dump form /proc/asound/card*/pcm*/sub*/* for both cases while
plaing the sample

> Also, the simple aplay invocation (e.g. with a 2-channel 16bit sample)
> also goes to the same problem, I suppose?

Yes.

-- 
 Kirill A. Shutemov

--iquykasoghufro7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=state

hw_params:access: MMAP_INTERLEAVED
hw_params:format: S16_LE
hw_params:subformat: STD
hw_params:channels: 2
hw_params:rate: 44100 (44100/1)
hw_params:period_size: 1024
hw_params:buffer_size: 4096
info:card: 0
info:device: 0
info:subdevice: 0
info:stream: PLAYBACK
info:id: USB Audio
info:name: USB Audio
info:subname: subdevice #0
info:class: 0
info:subclass: 0
info:subdevices_count: 1
info:subdevices_avail: 0
status:state: RUNNING
status:owner_pid   : 4268
status:trigger_time: 335.048357663
status:tstamp      : 362.520920879
status:delay       : -4095
status:avail       : 8191
status:avail_max   : 0
status:-----
status:hw_ptr      : 4095
status:appl_ptr    : 0
sw_params:tstamp_mode: ENABLE
sw_params:period_step: 1
sw_params:avail_min: 1024
sw_params:start_threshold: 1
sw_params:stop_threshold: 4611686018427387904
sw_params:silence_threshold: 0
sw_params:silence_size: 4611686018427387904
sw_params:boundary: 4611686018427387904

--iquykasoghufro7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="state.no-lowlatency"

hw_params:access: MMAP_INTERLEAVED
hw_params:format: S16_LE
hw_params:subformat: STD
hw_params:channels: 2
hw_params:rate: 44100 (44100/1)
hw_params:period_size: 1024
hw_params:buffer_size: 4096
info:card: 0
info:device: 0
info:subdevice: 0
info:stream: PLAYBACK
info:id: USB Audio
info:name: USB Audio
info:subname: subdevice #0
info:class: 0
info:subclass: 0
info:subdevices_count: 1
info:subdevices_avail: 0
status:state: RUNNING
status:owner_pid   : 4351
status:trigger_time: 107.480212212
status:tstamp      : 111.934757272
status:delay       : -196216
status:avail       : 200704
status:avail_max   : 200704
status:-----
status:hw_ptr      : 196608
status:appl_ptr    : 0
sw_params:tstamp_mode: ENABLE
sw_params:period_step: 1
sw_params:avail_min: 1024
sw_params:start_threshold: 1
sw_params:stop_threshold: 4611686018427387904
sw_params:silence_threshold: 0
sw_params:silence_size: 4611686018427387904
sw_params:boundary: 4611686018427387904

--iquykasoghufro7p--
