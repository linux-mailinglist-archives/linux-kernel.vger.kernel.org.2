Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94426456676
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhKRX32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKRX31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:29:27 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF118C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:26:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m27so33879809lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sxn25WKSedzFWh746oWcibCCar77QExYHJGMgznRJqA=;
        b=vcd/5gzcN3srJaDBh/nf9KNacbcHjPWHaLj7IsroyD8vYd/IAW3ccRvX5VQ6UcjhfL
         jHbZ9963L3LDrqzQb1TkpLexd5KjBZcwjW7+Fm7ZehkiAHC5pOG6LDUffS0iVIHfH1A2
         SmeklmGe/29lxBBbFNiuK4Ui09mn4mUh8mlLihkcNeKJXAtuyJPUDCwmM7FVx4jk0e+t
         1FWygod3ESX6ULfhwKk6/SMe7HlbQ1wO/xJeNmvhOYe4jcmYYlQeQUUH7XsyfHXtGZb4
         DiHANDxDtt3gVRD4UdhC6X7OrBnzpfosor/jnpuIPl9FY2GDR19PIWWIHdS7dZA9ROi7
         crJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxn25WKSedzFWh746oWcibCCar77QExYHJGMgznRJqA=;
        b=GsUdZ7sSgXNaILL/sxlzuXo4+ozQ/4I7FFkLfdJbr+vakJ3ImsdwB56qptfbnlVWuq
         DtSpTPeiETUj3wSfqwu0gg5rVCOBCLNSXBd56TlzHI09PY5qQ08c0FSXHndVSy6d4hMH
         tnSBr1VLYO1bpZOm6alTVw9L7h4ma3mls4I0aZqxurHf9b2mN8eEdtzq6RdcqLjynLX+
         jELmCymVFwQPe06MPkVJt06ti1pjwkcW08YkT1LVusX12b8XXMttVWRSBzowt4AMp/+O
         as/mtzNdsoZQtKgJ4tkOlbM3IoPq1Y9WIKlB4fyiXsOWmpYxWaoSfwBYGEhN61wc3EZE
         ERYg==
X-Gm-Message-State: AOAM533DnGoLsQF2HPlsKT0ztKH8PFtxhgU/2OPiuloDGOlq6qX4yIGr
        yK3Fau08+h7fSqXxTN88KyutMw==
X-Google-Smtp-Source: ABdhPJymo40+Efz4KhJ3rJvxJaLbVHqUWErtOnzyn3InRPitqPTkPNbOtnaF1SSBYYihVYIUX7zfGQ==
X-Received: by 2002:a05:6512:6c7:: with SMTP id u7mr26970344lff.636.1637277984360;
        Thu, 18 Nov 2021 15:26:24 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j15sm157487lfg.167.2021.11.18.15.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:26:23 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id CE503103121; Fri, 19 Nov 2021 02:26:28 +0300 (+03)
Date:   Fri, 19 Nov 2021 02:26:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 5.16-rc1
Message-ID: <20211118232628.hynb5vy6phsqj5oi@box.shutemov.name>
References: <s5hwnlpmt9x.wl-tiwai@suse.de>
 <20211117161855.m45mxcqszkfcetai@box.shutemov.name>
 <s5hmtm2lphf.wl-tiwai@suse.de>
 <20211117174826.23eakoivl33tawb2@box.shutemov.name>
 <s5hfsrulkxk.wl-tiwai@suse.de>
 <s5hpmqxki3h.wl-tiwai@suse.de>
 <s5hilwph05c.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x3jrbqd7uw7o7s57"
Content-Disposition: inline
In-Reply-To: <s5hilwph05c.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x3jrbqd7uw7o7s57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 18, 2021 at 05:57:35PM +0100, Takashi Iwai wrote:
> And it'd be helpful if you can gather the log (from tracing) with the
> patch below (from the start of speaker-test until the stall).

The trace is attached.

-- 
 Kirill A. Shutemov

--x3jrbqd7uw7o7s57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=trace

# tracer: nop
#
# entries-in-buffer/entries-written: 1748/1748   #P:32
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    speaker-test-4543    [002] d..1.   154.331485: snd_usb_endpoint_start: endpoint start
    speaker-test-4543    [002] d..2.   154.331490: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=0, avail=4096
    speaker-test-4543    [002] d..2.   154.331491: prepare_playback_urb: prepare: pkt 0 [0]: avail=4096, counts=5
    speaker-test-4543    [002] d..2.   154.331492: prepare_playback_urb: prepare: pkt 0 [1]: avail=4091, counts=6
    speaker-test-4543    [002] d..2.   154.331493: prepare_playback_urb: prepare: pkt 0 [2]: avail=4085, counts=5
    speaker-test-4543    [002] d..2.   154.331494: prepare_playback_urb: prepare: pkt 0 [3]: avail=4080, counts=6
    speaker-test-4543    [002] d..2.   154.331494: prepare_playback_urb: prepare: pkt 0 [4]: avail=4074, counts=5
    speaker-test-4543    [002] d..2.   154.331495: prepare_playback_urb: prepare: pkt 0 [5]: avail=4069, counts=6
    speaker-test-4543    [002] d..2.   154.331495: prepare_playback_urb: prepare: pkt 0 [6]: avail=4063, counts=5
    speaker-test-4543    [002] d..2.   154.331496: prepare_playback_urb: prepare: pkt 0 [7]: avail=4058, counts=6
    speaker-test-4543    [002] d..2.   154.331496: prepare_playback_urb: prepare: pkt 0 [8]: avail=4052, counts=5
    speaker-test-4543    [002] d..2.   154.331497: prepare_playback_urb: prepare: pkt 0 [9]: avail=4047, counts=6
    speaker-test-4543    [002] d..2.   154.331498: prepare_playback_urb: prepare: pkt 0 [10]: avail=4041, counts=5
    speaker-test-4543    [002] d..2.   154.331498: prepare_playback_urb: prepare: pkt 0 [11]: avail=4036, counts=6
    speaker-test-4543    [002] d..2.   154.331499: prepare_playback_urb: prepare: pkt 0 [12]: avail=4030, counts=5
    speaker-test-4543    [002] d..2.   154.331499: prepare_playback_urb: prepare: pkt 0 [13]: avail=4025, counts=6
    speaker-test-4543    [002] d..2.   154.331500: prepare_playback_urb: prepare: pkt 0 [14]: avail=4019, counts=5
    speaker-test-4543    [002] d..2.   154.331500: prepare_playback_urb: prepare: pkt 0 [15]: avail=4014, counts=6
    speaker-test-4543    [002] d..2.   154.331501: prepare_playback_urb: prepare: pkt 0 [16]: avail=4008, counts=5
    speaker-test-4543    [002] d..2.   154.331501: prepare_playback_urb: prepare: pkt 0 [17]: avail=4003, counts=6
    speaker-test-4543    [002] d..2.   154.331502: prepare_playback_urb: prepare: pkt 0 [18]: avail=3997, counts=5
    speaker-test-4543    [002] d..2.   154.331503: prepare_playback_urb: prepare: pkt 0 [19]: avail=3992, counts=6
    speaker-test-4543    [002] d..2.   154.331503: prepare_playback_urb: prepare: pkt 0 [20]: avail=3986, counts=5
    speaker-test-4543    [002] d..2.   154.331504: prepare_playback_urb: prepare: pkt 0 [21]: avail=3981, counts=6
    speaker-test-4543    [002] d..2.   154.331504: prepare_playback_urb: prepare: pkt 0 [22]: avail=3975, counts=5
    speaker-test-4543    [002] d..2.   154.331505: prepare_playback_urb: prepare: pkt 0 [23]: avail=3970, counts=6
    speaker-test-4543    [002] d..2.   154.331505: prepare_playback_urb: prepare: pkt 0 [24]: avail=3964, counts=5
    speaker-test-4543    [002] d..2.   154.331506: prepare_playback_urb: prepare: pkt 0 [25]: avail=3959, counts=6
    speaker-test-4543    [002] d..2.   154.331506: prepare_playback_urb: prepare: pkt 0 [26]: avail=3953, counts=5
    speaker-test-4543    [002] d..2.   154.331507: prepare_playback_urb: prepare: pkt 0 [27]: avail=3948, counts=6
    speaker-test-4543    [002] d..2.   154.331507: prepare_playback_urb: prepare: pkt 0 [28]: avail=3942, counts=5
    speaker-test-4543    [002] d..2.   154.331508: prepare_playback_urb: prepare: pkt 0 [29]: avail=3937, counts=6
    speaker-test-4543    [002] d..2.   154.331509: prepare_playback_urb: prepare: pkt 0 [30]: avail=3931, counts=5
    speaker-test-4543    [002] d..2.   154.331509: prepare_playback_urb: prepare: pkt 0 [31]: avail=3926, counts=6
    speaker-test-4543    [002] d..2.   154.331510: prepare_playback_urb: prepare: pkt 0 [32]: avail=3920, counts=5
    speaker-test-4543    [002] d..2.   154.331510: prepare_playback_urb: prepare: pkt 0 [33]: avail=3915, counts=6
    speaker-test-4543    [002] d..2.   154.331511: prepare_playback_urb: prepare: pkt 0 [34]: avail=3909, counts=5
    speaker-test-4543    [002] d..2.   154.331511: prepare_playback_urb: prepare: pkt 0 [35]: avail=3904, counts=6
    speaker-test-4543    [002] d..2.   154.331512: prepare_playback_urb: prepare: pkt 0 [36]: avail=3898, counts=5
    speaker-test-4543    [002] d..2.   154.331512: prepare_playback_urb: prepare: pkt 0 [37]: avail=3893, counts=6
    speaker-test-4543    [002] d..2.   154.331513: prepare_playback_urb: prepare: pkt 0 [38]: avail=3887, counts=5
    speaker-test-4543    [002] d..2.   154.331513: prepare_playback_urb: prepare: pkt 0 [39]: avail=3882, counts=6
    speaker-test-4543    [002] d..2.   154.331514: prepare_playback_urb: prepare: pkt 0 [40]: avail=3876, counts=6
    speaker-test-4543    [002] d..2.   154.331515: urb_ctx_queue_advance: PCM bytes=904, queued=904, inflight=904, hwptr=904
    speaker-test-4543    [002] d..1.   154.331518: snd_usb_endpoint_start: start: pkt 0 submitted
    speaker-test-4543    [002] d..2.   154.331532: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=226, avail=3870
    speaker-test-4543    [002] d..2.   154.331533: prepare_playback_urb: prepare: pkt 1 [0]: avail=3870, counts=5
    speaker-test-4543    [002] d..2.   154.331533: prepare_playback_urb: prepare: pkt 1 [1]: avail=3865, counts=6
    speaker-test-4543    [002] d..2.   154.331534: prepare_playback_urb: prepare: pkt 1 [2]: avail=3859, counts=5
    speaker-test-4543    [002] d..2.   154.331534: prepare_playback_urb: prepare: pkt 1 [3]: avail=3854, counts=6
    speaker-test-4543    [002] d..2.   154.331535: prepare_playback_urb: prepare: pkt 1 [4]: avail=3848, counts=5
    speaker-test-4543    [002] d..2.   154.331535: prepare_playback_urb: prepare: pkt 1 [5]: avail=3843, counts=6
    speaker-test-4543    [002] d..2.   154.331536: prepare_playback_urb: prepare: pkt 1 [6]: avail=3837, counts=5
    speaker-test-4543    [002] d..2.   154.331536: prepare_playback_urb: prepare: pkt 1 [7]: avail=3832, counts=6
    speaker-test-4543    [002] d..2.   154.331537: prepare_playback_urb: prepare: pkt 1 [8]: avail=3826, counts=5
    speaker-test-4543    [002] d..2.   154.331537: prepare_playback_urb: prepare: pkt 1 [9]: avail=3821, counts=6
    speaker-test-4543    [002] d..2.   154.331538: prepare_playback_urb: prepare: pkt 1 [10]: avail=3815, counts=5
    speaker-test-4543    [002] d..2.   154.331538: prepare_playback_urb: prepare: pkt 1 [11]: avail=3810, counts=6
    speaker-test-4543    [002] d..2.   154.331539: prepare_playback_urb: prepare: pkt 1 [12]: avail=3804, counts=5
    speaker-test-4543    [002] d..2.   154.331540: prepare_playback_urb: prepare: pkt 1 [13]: avail=3799, counts=6
    speaker-test-4543    [002] d..2.   154.331540: prepare_playback_urb: prepare: pkt 1 [14]: avail=3793, counts=5
    speaker-test-4543    [002] d..2.   154.331541: prepare_playback_urb: prepare: pkt 1 [15]: avail=3788, counts=6
    speaker-test-4543    [002] d..2.   154.331541: prepare_playback_urb: prepare: pkt 1 [16]: avail=3782, counts=5
    speaker-test-4543    [002] d..2.   154.331542: prepare_playback_urb: prepare: pkt 1 [17]: avail=3777, counts=6
    speaker-test-4543    [002] d..2.   154.331542: prepare_playback_urb: prepare: pkt 1 [18]: avail=3771, counts=5
    speaker-test-4543    [002] d..2.   154.331543: prepare_playback_urb: prepare: pkt 1 [19]: avail=3766, counts=6
    speaker-test-4543    [002] d..2.   154.331543: prepare_playback_urb: prepare: pkt 1 [20]: avail=3760, counts=5
    speaker-test-4543    [002] d..2.   154.331544: prepare_playback_urb: prepare: pkt 1 [21]: avail=3755, counts=6
    speaker-test-4543    [002] d..2.   154.331544: prepare_playback_urb: prepare: pkt 1 [22]: avail=3749, counts=5
    speaker-test-4543    [002] d..2.   154.331545: prepare_playback_urb: prepare: pkt 1 [23]: avail=3744, counts=6
    speaker-test-4543    [002] d..2.   154.331545: prepare_playback_urb: prepare: pkt 1 [24]: avail=3738, counts=5
    speaker-test-4543    [002] d..2.   154.331546: prepare_playback_urb: prepare: pkt 1 [25]: avail=3733, counts=6
    speaker-test-4543    [002] d..2.   154.331546: prepare_playback_urb: prepare: pkt 1 [26]: avail=3727, counts=5
    speaker-test-4543    [002] d..2.   154.331547: prepare_playback_urb: prepare: pkt 1 [27]: avail=3722, counts=6
    speaker-test-4543    [002] d..2.   154.331547: prepare_playback_urb: prepare: pkt 1 [28]: avail=3716, counts=5
    speaker-test-4543    [002] d..2.   154.331548: prepare_playback_urb: prepare: pkt 1 [29]: avail=3711, counts=6
    speaker-test-4543    [002] d..2.   154.331548: prepare_playback_urb: prepare: pkt 1 [30]: avail=3705, counts=5
    speaker-test-4543    [002] d..2.   154.331549: prepare_playback_urb: prepare: pkt 1 [31]: avail=3700, counts=6
    speaker-test-4543    [002] d..2.   154.331549: prepare_playback_urb: prepare: pkt 1 [32]: avail=3694, counts=5
    speaker-test-4543    [002] d..2.   154.331550: prepare_playback_urb: prepare: pkt 1 [33]: avail=3689, counts=6
    speaker-test-4543    [002] d..2.   154.331551: prepare_playback_urb: prepare: pkt 1 [34]: avail=3683, counts=5
    speaker-test-4543    [002] d..2.   154.331551: prepare_playback_urb: prepare: pkt 1 [35]: avail=3678, counts=6
    speaker-test-4543    [002] d..2.   154.331552: prepare_playback_urb: prepare: pkt 1 [36]: avail=3672, counts=5
    speaker-test-4543    [002] d..2.   154.331552: prepare_playback_urb: prepare: pkt 1 [37]: avail=3667, counts=6
    speaker-test-4543    [002] d..2.   154.331553: prepare_playback_urb: prepare: pkt 1 [38]: avail=3661, counts=6
    speaker-test-4543    [002] d..2.   154.331553: prepare_playback_urb: prepare: pkt 1 [39]: avail=3655, counts=5
    speaker-test-4543    [002] d..2.   154.331554: prepare_playback_urb: prepare: pkt 1 [40]: avail=3650, counts=6
    speaker-test-4543    [002] d..2.   154.331555: urb_ctx_queue_advance: PCM bytes=904, queued=904, inflight=1808, hwptr=1808
    speaker-test-4543    [002] d..1.   154.331556: snd_usb_endpoint_start: start: pkt 1 submitted
    speaker-test-4543    [002] d..2.   154.331567: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=452, avail=3644
    speaker-test-4543    [002] d..2.   154.331567: prepare_playback_urb: prepare: pkt 2 [0]: avail=3644, counts=5
    speaker-test-4543    [002] d..2.   154.331568: prepare_playback_urb: prepare: pkt 2 [1]: avail=3639, counts=6
    speaker-test-4543    [002] d..2.   154.331569: prepare_playback_urb: prepare: pkt 2 [2]: avail=3633, counts=5
    speaker-test-4543    [002] d..2.   154.331570: prepare_playback_urb: prepare: pkt 2 [3]: avail=3628, counts=6
    speaker-test-4543    [002] d..2.   154.331570: prepare_playback_urb: prepare: pkt 2 [4]: avail=3622, counts=5
    speaker-test-4543    [002] d..2.   154.331571: prepare_playback_urb: prepare: pkt 2 [5]: avail=3617, counts=6
    speaker-test-4543    [002] d..2.   154.331571: prepare_playback_urb: prepare: pkt 2 [6]: avail=3611, counts=5
    speaker-test-4543    [002] d..2.   154.331572: prepare_playback_urb: prepare: pkt 2 [7]: avail=3606, counts=6
    speaker-test-4543    [002] d..2.   154.331572: prepare_playback_urb: prepare: pkt 2 [8]: avail=3600, counts=5
    speaker-test-4543    [002] d..2.   154.331573: prepare_playback_urb: prepare: pkt 2 [9]: avail=3595, counts=6
    speaker-test-4543    [002] d..2.   154.331574: prepare_playback_urb: prepare: pkt 2 [10]: avail=3589, counts=5
    speaker-test-4543    [002] d..2.   154.331574: prepare_playback_urb: prepare: pkt 2 [11]: avail=3584, counts=6
    speaker-test-4543    [002] d..2.   154.331575: prepare_playback_urb: prepare: pkt 2 [12]: avail=3578, counts=5
    speaker-test-4543    [002] d..2.   154.331575: prepare_playback_urb: prepare: pkt 2 [13]: avail=3573, counts=6
    speaker-test-4543    [002] d..2.   154.331576: prepare_playback_urb: prepare: pkt 2 [14]: avail=3567, counts=5
    speaker-test-4543    [002] d..2.   154.331576: prepare_playback_urb: prepare: pkt 2 [15]: avail=3562, counts=6
    speaker-test-4543    [002] d..2.   154.331577: prepare_playback_urb: prepare: pkt 2 [16]: avail=3556, counts=5
    speaker-test-4543    [002] d..2.   154.331577: prepare_playback_urb: prepare: pkt 2 [17]: avail=3551, counts=6
    speaker-test-4543    [002] d..2.   154.331578: prepare_playback_urb: prepare: pkt 2 [18]: avail=3545, counts=5
    speaker-test-4543    [002] d..2.   154.331578: prepare_playback_urb: prepare: pkt 2 [19]: avail=3540, counts=6
    speaker-test-4543    [002] d..2.   154.331579: prepare_playback_urb: prepare: pkt 2 [20]: avail=3534, counts=5
    speaker-test-4543    [002] d..2.   154.331579: prepare_playback_urb: prepare: pkt 2 [21]: avail=3529, counts=6
    speaker-test-4543    [002] d..2.   154.331580: prepare_playback_urb: prepare: pkt 2 [22]: avail=3523, counts=5
    speaker-test-4543    [002] d..2.   154.331581: prepare_playback_urb: prepare: pkt 2 [23]: avail=3518, counts=6
    speaker-test-4543    [002] d..2.   154.331581: prepare_playback_urb: prepare: pkt 2 [24]: avail=3512, counts=5
    speaker-test-4543    [002] d..2.   154.331582: prepare_playback_urb: prepare: pkt 2 [25]: avail=3507, counts=6
    speaker-test-4543    [002] d..2.   154.331582: prepare_playback_urb: prepare: pkt 2 [26]: avail=3501, counts=5
    speaker-test-4543    [002] d..2.   154.331583: prepare_playback_urb: prepare: pkt 2 [27]: avail=3496, counts=6
    speaker-test-4543    [002] d..2.   154.331583: prepare_playback_urb: prepare: pkt 2 [28]: avail=3490, counts=5
    speaker-test-4543    [002] d..2.   154.331584: prepare_playback_urb: prepare: pkt 2 [29]: avail=3485, counts=6
    speaker-test-4543    [002] d..2.   154.331584: prepare_playback_urb: prepare: pkt 2 [30]: avail=3479, counts=5
    speaker-test-4543    [002] d..2.   154.331585: prepare_playback_urb: prepare: pkt 2 [31]: avail=3474, counts=6
    speaker-test-4543    [002] d..2.   154.331585: prepare_playback_urb: prepare: pkt 2 [32]: avail=3468, counts=5
    speaker-test-4543    [002] d..2.   154.331586: prepare_playback_urb: prepare: pkt 2 [33]: avail=3463, counts=6
    speaker-test-4543    [002] d..2.   154.331586: prepare_playback_urb: prepare: pkt 2 [34]: avail=3457, counts=5
    speaker-test-4543    [002] d..2.   154.331587: prepare_playback_urb: prepare: pkt 2 [35]: avail=3452, counts=6
    speaker-test-4543    [002] d..2.   154.331587: prepare_playback_urb: prepare: pkt 2 [36]: avail=3446, counts=5
    speaker-test-4543    [002] d..2.   154.331588: prepare_playback_urb: prepare: pkt 2 [37]: avail=3441, counts=6
    speaker-test-4543    [002] d..2.   154.331588: prepare_playback_urb: prepare: pkt 2 [38]: avail=3435, counts=6
    speaker-test-4543    [002] d..2.   154.331589: prepare_playback_urb: prepare: pkt 2 [39]: avail=3429, counts=5
    speaker-test-4543    [002] d..2.   154.331589: prepare_playback_urb: prepare: pkt 2 [40]: avail=3424, counts=6
    speaker-test-4543    [002] d..2.   154.331590: urb_ctx_queue_advance: PCM bytes=904, queued=904, inflight=2712, hwptr=2712
    speaker-test-4543    [002] d..1.   154.331592: snd_usb_endpoint_start: start: pkt 2 submitted
          <idle>-0       [010] ..s1.   154.336838: snd_complete_urb: pkt complete 0
          <idle>-0       [010] ..s1.   154.336841: push_back_to_ready_list: pkt 0 push back
          <idle>-0       [010] ..s1.   154.336843: snd_usb_queue_pending_output_urbs: checking queue pkt 0 (active_mask=6)
          <idle>-0       [010] d.s2.   154.336845: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=678, avail=3418
          <idle>-0       [010] d.s2.   154.336846: prepare_playback_urb: prepare: pkt 0 [0]: avail=3418, counts=5
          <idle>-0       [010] d.s2.   154.336846: prepare_playback_urb: prepare: pkt 0 [1]: avail=3413, counts=6
          <idle>-0       [010] d.s2.   154.336847: prepare_playback_urb: prepare: pkt 0 [2]: avail=3407, counts=5
          <idle>-0       [010] d.s2.   154.336848: prepare_playback_urb: prepare: pkt 0 [3]: avail=3402, counts=6
          <idle>-0       [010] d.s2.   154.336848: prepare_playback_urb: prepare: pkt 0 [4]: avail=3396, counts=5
          <idle>-0       [010] d.s2.   154.336849: prepare_playback_urb: prepare: pkt 0 [5]: avail=3391, counts=6
          <idle>-0       [010] d.s2.   154.336849: prepare_playback_urb: prepare: pkt 0 [6]: avail=3385, counts=5
          <idle>-0       [010] d.s2.   154.336850: prepare_playback_urb: prepare: pkt 0 [7]: avail=3380, counts=6
          <idle>-0       [010] d.s2.   154.336850: prepare_playback_urb: prepare: pkt 0 [8]: avail=3374, counts=5
          <idle>-0       [010] d.s2.   154.336851: prepare_playback_urb: prepare: pkt 0 [9]: avail=3369, counts=6
          <idle>-0       [010] d.s2.   154.336851: prepare_playback_urb: prepare: pkt 0 [10]: avail=3363, counts=5
          <idle>-0       [010] d.s2.   154.336852: prepare_playback_urb: prepare: pkt 0 [11]: avail=3358, counts=6
          <idle>-0       [010] d.s2.   154.336853: prepare_playback_urb: prepare: pkt 0 [12]: avail=3352, counts=5
          <idle>-0       [010] d.s2.   154.336853: prepare_playback_urb: prepare: pkt 0 [13]: avail=3347, counts=6
          <idle>-0       [010] d.s2.   154.336854: prepare_playback_urb: prepare: pkt 0 [14]: avail=3341, counts=5
          <idle>-0       [010] d.s2.   154.336854: prepare_playback_urb: prepare: pkt 0 [15]: avail=3336, counts=6
          <idle>-0       [010] d.s2.   154.336855: prepare_playback_urb: prepare: pkt 0 [16]: avail=3330, counts=5
          <idle>-0       [010] d.s2.   154.336855: prepare_playback_urb: prepare: pkt 0 [17]: avail=3325, counts=6
          <idle>-0       [010] d.s2.   154.336856: prepare_playback_urb: prepare: pkt 0 [18]: avail=3319, counts=5
          <idle>-0       [010] d.s2.   154.336856: prepare_playback_urb: prepare: pkt 0 [19]: avail=3314, counts=6
          <idle>-0       [010] d.s2.   154.336857: prepare_playback_urb: prepare: pkt 0 [20]: avail=3308, counts=5
          <idle>-0       [010] d.s2.   154.336857: prepare_playback_urb: prepare: pkt 0 [21]: avail=3303, counts=6
          <idle>-0       [010] d.s2.   154.336858: prepare_playback_urb: prepare: pkt 0 [22]: avail=3297, counts=5
          <idle>-0       [010] d.s2.   154.336858: prepare_playback_urb: prepare: pkt 0 [23]: avail=3292, counts=6
          <idle>-0       [010] d.s2.   154.336859: prepare_playback_urb: prepare: pkt 0 [24]: avail=3286, counts=5
          <idle>-0       [010] d.s2.   154.336859: prepare_playback_urb: prepare: pkt 0 [25]: avail=3281, counts=6
          <idle>-0       [010] d.s2.   154.336860: prepare_playback_urb: prepare: pkt 0 [26]: avail=3275, counts=5
          <idle>-0       [010] d.s2.   154.336860: prepare_playback_urb: prepare: pkt 0 [27]: avail=3270, counts=6
          <idle>-0       [010] d.s2.   154.336861: prepare_playback_urb: prepare: pkt 0 [28]: avail=3264, counts=5
          <idle>-0       [010] d.s2.   154.336862: prepare_playback_urb: prepare: pkt 0 [29]: avail=3259, counts=6
          <idle>-0       [010] d.s2.   154.336862: prepare_playback_urb: prepare: pkt 0 [30]: avail=3253, counts=5
          <idle>-0       [010] d.s2.   154.336863: prepare_playback_urb: prepare: pkt 0 [31]: avail=3248, counts=6
          <idle>-0       [010] d.s2.   154.336863: prepare_playback_urb: prepare: pkt 0 [32]: avail=3242, counts=5
          <idle>-0       [010] d.s2.   154.336864: prepare_playback_urb: prepare: pkt 0 [33]: avail=3237, counts=6
          <idle>-0       [010] d.s2.   154.336864: prepare_playback_urb: prepare: pkt 0 [34]: avail=3231, counts=5
          <idle>-0       [010] d.s2.   154.336865: prepare_playback_urb: prepare: pkt 0 [35]: avail=3226, counts=6
          <idle>-0       [010] d.s2.   154.336865: prepare_playback_urb: prepare: pkt 0 [36]: avail=3220, counts=6
          <idle>-0       [010] d.s2.   154.336866: prepare_playback_urb: prepare: pkt 0 [37]: avail=3214, counts=5
          <idle>-0       [010] d.s2.   154.336866: prepare_playback_urb: prepare: pkt 0 [38]: avail=3209, counts=6
          <idle>-0       [010] d.s2.   154.336867: prepare_playback_urb: prepare: pkt 0 [39]: avail=3203, counts=5
          <idle>-0       [010] d.s2.   154.336867: prepare_playback_urb: prepare: pkt 0 [40]: avail=3198, counts=6
          <idle>-0       [010] d.s2.   154.336869: urb_ctx_queue_advance: PCM bytes=904, queued=904, inflight=2712, hwptr=3616
          <idle>-0       [010] ..s1.   154.336870: snd_usb_queue_pending_output_urbs: pkt 0 submitted
          <idle>-0       [010] ..s1.   154.341966: snd_complete_urb: pkt complete 1
          <idle>-0       [010] ..s1.   154.341969: push_back_to_ready_list: pkt 1 push back
          <idle>-0       [010] ..s1.   154.341970: snd_usb_queue_pending_output_urbs: checking queue pkt 1 (active_mask=5)
          <idle>-0       [010] d.s2.   154.341972: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=904, avail=3192
          <idle>-0       [010] d.s2.   154.341973: prepare_playback_urb: prepare: pkt 1 [0]: avail=3192, counts=5
          <idle>-0       [010] d.s2.   154.341974: prepare_playback_urb: prepare: pkt 1 [1]: avail=3187, counts=6
          <idle>-0       [010] d.s2.   154.341974: prepare_playback_urb: prepare: pkt 1 [2]: avail=3181, counts=5
          <idle>-0       [010] d.s2.   154.341975: prepare_playback_urb: prepare: pkt 1 [3]: avail=3176, counts=6
          <idle>-0       [010] d.s2.   154.341976: prepare_playback_urb: prepare: pkt 1 [4]: avail=3170, counts=5
          <idle>-0       [010] d.s2.   154.341976: prepare_playback_urb: prepare: pkt 1 [5]: avail=3165, counts=6
          <idle>-0       [010] d.s2.   154.341977: prepare_playback_urb: prepare: pkt 1 [6]: avail=3159, counts=5
          <idle>-0       [010] d.s2.   154.341978: prepare_playback_urb: prepare: pkt 1 [7]: avail=3154, counts=6
          <idle>-0       [010] d.s2.   154.341978: prepare_playback_urb: prepare: pkt 1 [8]: avail=3148, counts=5
          <idle>-0       [010] d.s2.   154.341979: prepare_playback_urb: prepare: pkt 1 [9]: avail=3143, counts=6
          <idle>-0       [010] d.s2.   154.341979: prepare_playback_urb: prepare: pkt 1 [10]: avail=3137, counts=5
          <idle>-0       [010] d.s2.   154.341980: prepare_playback_urb: prepare: pkt 1 [11]: avail=3132, counts=6
          <idle>-0       [010] d.s2.   154.341981: prepare_playback_urb: prepare: pkt 1 [12]: avail=3126, counts=5
          <idle>-0       [010] d.s2.   154.341981: prepare_playback_urb: prepare: pkt 1 [13]: avail=3121, counts=6
          <idle>-0       [010] d.s2.   154.341982: prepare_playback_urb: prepare: pkt 1 [14]: avail=3115, counts=5
          <idle>-0       [010] d.s2.   154.341982: prepare_playback_urb: prepare: pkt 1 [15]: avail=3110, counts=6
          <idle>-0       [010] d.s2.   154.341983: prepare_playback_urb: prepare: pkt 1 [16]: avail=3104, counts=5
          <idle>-0       [010] d.s2.   154.341983: prepare_playback_urb: prepare: pkt 1 [17]: avail=3099, counts=6
          <idle>-0       [010] d.s2.   154.341984: prepare_playback_urb: prepare: pkt 1 [18]: avail=3093, counts=5
          <idle>-0       [010] d.s2.   154.341984: prepare_playback_urb: prepare: pkt 1 [19]: avail=3088, counts=6
          <idle>-0       [010] d.s2.   154.341985: prepare_playback_urb: prepare: pkt 1 [20]: avail=3082, counts=5
          <idle>-0       [010] d.s2.   154.341985: prepare_playback_urb: prepare: pkt 1 [21]: avail=3077, counts=6
          <idle>-0       [010] d.s2.   154.341987: urb_ctx_queue_advance: PCM bytes=484, queued=484, inflight=2292, hwptr=4100
          <idle>-0       [010] ..s1.   154.342008: snd_usb_queue_pending_output_urbs: pkt 1 submitted
          <idle>-0       [010] ..s1.   154.347087: snd_complete_urb: pkt complete 2
          <idle>-0       [010] ..s1.   154.347089: push_back_to_ready_list: pkt 2 push back
          <idle>-0       [010] ..s1.   154.347091: snd_usb_queue_pending_output_urbs: checking queue pkt 2 (active_mask=3)
          <idle>-0       [010] d.s2.   154.347093: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=1025, avail=3071
          <idle>-0       [010] d.s2.   154.347094: prepare_playback_urb: prepare: pkt 2 [0]: avail=3071, counts=5
          <idle>-0       [010] d.s2.   154.347095: prepare_playback_urb: prepare: pkt 2 [1]: avail=3066, counts=6
          <idle>-0       [010] d.s2.   154.347095: prepare_playback_urb: prepare: pkt 2 [2]: avail=3060, counts=5
          <idle>-0       [010] d.s2.   154.347096: prepare_playback_urb: prepare: pkt 2 [3]: avail=3055, counts=6
          <idle>-0       [010] d.s2.   154.347096: prepare_playback_urb: prepare: pkt 2 [4]: avail=3049, counts=5
          <idle>-0       [010] d.s2.   154.347097: prepare_playback_urb: prepare: pkt 2 [5]: avail=3044, counts=6
          <idle>-0       [010] d.s2.   154.347098: prepare_playback_urb: prepare: pkt 2 [6]: avail=3038, counts=5
          <idle>-0       [010] d.s2.   154.347098: prepare_playback_urb: prepare: pkt 2 [7]: avail=3033, counts=6
          <idle>-0       [010] d.s2.   154.347099: prepare_playback_urb: prepare: pkt 2 [8]: avail=3027, counts=5
          <idle>-0       [010] d.s2.   154.347099: prepare_playback_urb: prepare: pkt 2 [9]: avail=3022, counts=6
          <idle>-0       [010] d.s2.   154.347100: prepare_playback_urb: prepare: pkt 2 [10]: avail=3016, counts=5
          <idle>-0       [010] d.s2.   154.347100: prepare_playback_urb: prepare: pkt 2 [11]: avail=3011, counts=6
          <idle>-0       [010] d.s2.   154.347101: prepare_playback_urb: prepare: pkt 2 [12]: avail=3005, counts=5
          <idle>-0       [010] d.s2.   154.347101: prepare_playback_urb: prepare: pkt 2 [13]: avail=3000, counts=6
          <idle>-0       [010] d.s2.   154.347102: prepare_playback_urb: prepare: pkt 2 [14]: avail=2994, counts=6
          <idle>-0       [010] d.s2.   154.347102: prepare_playback_urb: prepare: pkt 2 [15]: avail=2988, counts=5
          <idle>-0       [010] d.s2.   154.347103: prepare_playback_urb: prepare: pkt 2 [16]: avail=2983, counts=6
          <idle>-0       [010] d.s2.   154.347104: prepare_playback_urb: prepare: pkt 2 [17]: avail=2977, counts=5
          <idle>-0       [010] d.s2.   154.347104: prepare_playback_urb: prepare: pkt 2 [18]: avail=2972, counts=6
          <idle>-0       [010] d.s2.   154.347105: prepare_playback_urb: prepare: pkt 2 [19]: avail=2966, counts=5
          <idle>-0       [010] d.s2.   154.347105: prepare_playback_urb: prepare: pkt 2 [20]: avail=2961, counts=6
          <idle>-0       [010] d.s2.   154.347106: prepare_playback_urb: prepare: pkt 2 [21]: avail=2955, counts=5
          <idle>-0       [010] d.s2.   154.347106: prepare_playback_urb: prepare: pkt 2 [22]: avail=2950, counts=6
          <idle>-0       [010] d.s2.   154.347107: prepare_playback_urb: prepare: pkt 2 [23]: avail=2944, counts=5
          <idle>-0       [010] d.s2.   154.347107: prepare_playback_urb: prepare: pkt 2 [24]: avail=2939, counts=6
          <idle>-0       [010] d.s2.   154.347108: prepare_playback_urb: prepare: pkt 2 [25]: avail=2933, counts=5
          <idle>-0       [010] d.s2.   154.347108: prepare_playback_urb: prepare: pkt 2 [26]: avail=2928, counts=6
          <idle>-0       [010] d.s2.   154.347109: prepare_playback_urb: prepare: pkt 2 [27]: avail=2922, counts=5
          <idle>-0       [010] d.s2.   154.347109: prepare_playback_urb: prepare: pkt 2 [28]: avail=2917, counts=6
          <idle>-0       [010] d.s2.   154.347110: prepare_playback_urb: prepare: pkt 2 [29]: avail=2911, counts=5
          <idle>-0       [010] d.s2.   154.347111: prepare_playback_urb: prepare: pkt 2 [30]: avail=2906, counts=6
          <idle>-0       [010] d.s2.   154.347111: prepare_playback_urb: prepare: pkt 2 [31]: avail=2900, counts=5
          <idle>-0       [010] d.s2.   154.347112: prepare_playback_urb: prepare: pkt 2 [32]: avail=2895, counts=6
          <idle>-0       [010] d.s2.   154.347112: prepare_playback_urb: prepare: pkt 2 [33]: avail=2889, counts=5
          <idle>-0       [010] d.s2.   154.347113: prepare_playback_urb: prepare: pkt 2 [34]: avail=2884, counts=6
          <idle>-0       [010] d.s2.   154.347113: prepare_playback_urb: prepare: pkt 2 [35]: avail=2878, counts=5
          <idle>-0       [010] d.s2.   154.347114: prepare_playback_urb: prepare: pkt 2 [36]: avail=2873, counts=6
          <idle>-0       [010] d.s2.   154.347115: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2204, hwptr=4916
          <idle>-0       [010] ..s1.   154.347116: snd_usb_queue_pending_output_urbs: pkt 2 submitted
          <idle>-0       [010] ..s1.   154.352212: snd_complete_urb: pkt complete 0
          <idle>-0       [010] ..s1.   154.352215: push_back_to_ready_list: pkt 0 push back
          <idle>-0       [010] ..s1.   154.352217: snd_usb_queue_pending_output_urbs: checking queue pkt 0 (active_mask=6)
          <idle>-0       [010] d.s2.   154.352219: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=1229, avail=2867
          <idle>-0       [010] d.s2.   154.352219: prepare_playback_urb: prepare: pkt 0 [0]: avail=2867, counts=5
          <idle>-0       [010] d.s2.   154.352220: prepare_playback_urb: prepare: pkt 0 [1]: avail=2862, counts=6
          <idle>-0       [010] d.s2.   154.352221: prepare_playback_urb: prepare: pkt 0 [2]: avail=2856, counts=5
          <idle>-0       [010] d.s2.   154.352221: prepare_playback_urb: prepare: pkt 0 [3]: avail=2851, counts=6
          <idle>-0       [010] d.s2.   154.352222: prepare_playback_urb: prepare: pkt 0 [4]: avail=2845, counts=5
          <idle>-0       [010] d.s2.   154.352223: prepare_playback_urb: prepare: pkt 0 [5]: avail=2840, counts=6
          <idle>-0       [010] d.s2.   154.352223: prepare_playback_urb: prepare: pkt 0 [6]: avail=2834, counts=5
          <idle>-0       [010] d.s2.   154.352224: prepare_playback_urb: prepare: pkt 0 [7]: avail=2829, counts=6
          <idle>-0       [010] d.s2.   154.352224: prepare_playback_urb: prepare: pkt 0 [8]: avail=2823, counts=5
          <idle>-0       [010] d.s2.   154.352225: prepare_playback_urb: prepare: pkt 0 [9]: avail=2818, counts=6
          <idle>-0       [010] d.s2.   154.352225: prepare_playback_urb: prepare: pkt 0 [10]: avail=2812, counts=5
          <idle>-0       [010] d.s2.   154.352226: prepare_playback_urb: prepare: pkt 0 [11]: avail=2807, counts=6
          <idle>-0       [010] d.s2.   154.352226: prepare_playback_urb: prepare: pkt 0 [12]: avail=2801, counts=5
          <idle>-0       [010] d.s2.   154.352227: prepare_playback_urb: prepare: pkt 0 [13]: avail=2796, counts=6
          <idle>-0       [010] d.s2.   154.352227: prepare_playback_urb: prepare: pkt 0 [14]: avail=2790, counts=5
          <idle>-0       [010] d.s2.   154.352228: prepare_playback_urb: prepare: pkt 0 [15]: avail=2785, counts=6
          <idle>-0       [010] d.s2.   154.352229: prepare_playback_urb: prepare: pkt 0 [16]: avail=2779, counts=6
          <idle>-0       [010] d.s2.   154.352229: prepare_playback_urb: prepare: pkt 0 [17]: avail=2773, counts=5
          <idle>-0       [010] d.s2.   154.352230: prepare_playback_urb: prepare: pkt 0 [18]: avail=2768, counts=6
          <idle>-0       [010] d.s2.   154.352230: prepare_playback_urb: prepare: pkt 0 [19]: avail=2762, counts=5
          <idle>-0       [010] d.s2.   154.352231: prepare_playback_urb: prepare: pkt 0 [20]: avail=2757, counts=6
          <idle>-0       [010] d.s2.   154.352231: prepare_playback_urb: prepare: pkt 0 [21]: avail=2751, counts=5
          <idle>-0       [010] d.s2.   154.352232: prepare_playback_urb: prepare: pkt 0 [22]: avail=2746, counts=6
          <idle>-0       [010] d.s2.   154.352232: prepare_playback_urb: prepare: pkt 0 [23]: avail=2740, counts=5
          <idle>-0       [010] d.s2.   154.352233: prepare_playback_urb: prepare: pkt 0 [24]: avail=2735, counts=6
          <idle>-0       [010] d.s2.   154.352233: prepare_playback_urb: prepare: pkt 0 [25]: avail=2729, counts=5
          <idle>-0       [010] d.s2.   154.352234: prepare_playback_urb: prepare: pkt 0 [26]: avail=2724, counts=6
          <idle>-0       [010] d.s2.   154.352234: prepare_playback_urb: prepare: pkt 0 [27]: avail=2718, counts=5
          <idle>-0       [010] d.s2.   154.352235: prepare_playback_urb: prepare: pkt 0 [28]: avail=2713, counts=6
          <idle>-0       [010] d.s2.   154.352236: prepare_playback_urb: prepare: pkt 0 [29]: avail=2707, counts=5
          <idle>-0       [010] d.s2.   154.352236: prepare_playback_urb: prepare: pkt 0 [30]: avail=2702, counts=6
          <idle>-0       [010] d.s2.   154.352237: prepare_playback_urb: prepare: pkt 0 [31]: avail=2696, counts=5
          <idle>-0       [010] d.s2.   154.352238: prepare_playback_urb: prepare: pkt 0 [32]: avail=2691, counts=6
          <idle>-0       [010] d.s2.   154.352238: prepare_playback_urb: prepare: pkt 0 [33]: avail=2685, counts=5
          <idle>-0       [010] d.s2.   154.352239: prepare_playback_urb: prepare: pkt 0 [34]: avail=2680, counts=6
          <idle>-0       [010] d.s2.   154.352239: prepare_playback_urb: prepare: pkt 0 [35]: avail=2674, counts=5
          <idle>-0       [010] d.s2.   154.352240: prepare_playback_urb: prepare: pkt 0 [36]: avail=2669, counts=6
          <idle>-0       [010] d.s2.   154.352240: prepare_playback_urb: prepare: pkt 0 [37]: avail=2663, counts=5
          <idle>-0       [010] d.s2.   154.352242: urb_ctx_queue_advance: PCM bytes=836, queued=836, inflight=2136, hwptr=5752
          <idle>-0       [010] ..s1.   154.352243: snd_usb_queue_pending_output_urbs: pkt 0 submitted
          <idle>-0       [010] ..s1.   154.354970: snd_complete_urb: pkt complete 1
          <idle>-0       [010] ..s1.   154.354972: push_back_to_ready_list: pkt 1 push back
          <idle>-0       [010] ..s1.   154.354974: snd_usb_queue_pending_output_urbs: checking queue pkt 1 (active_mask=5)
          <idle>-0       [010] d.s2.   154.354976: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=1438, avail=2658
          <idle>-0       [010] d.s2.   154.354977: prepare_playback_urb: prepare: pkt 1 [0]: avail=2658, counts=6
          <idle>-0       [010] d.s2.   154.354978: prepare_playback_urb: prepare: pkt 1 [1]: avail=2652, counts=5
          <idle>-0       [010] d.s2.   154.354978: prepare_playback_urb: prepare: pkt 1 [2]: avail=2647, counts=6
          <idle>-0       [010] d.s2.   154.354979: prepare_playback_urb: prepare: pkt 1 [3]: avail=2641, counts=5
          <idle>-0       [010] d.s2.   154.354979: prepare_playback_urb: prepare: pkt 1 [4]: avail=2636, counts=6
          <idle>-0       [010] d.s2.   154.354980: prepare_playback_urb: prepare: pkt 1 [5]: avail=2630, counts=5
          <idle>-0       [010] d.s2.   154.354980: prepare_playback_urb: prepare: pkt 1 [6]: avail=2625, counts=6
          <idle>-0       [010] d.s2.   154.354981: prepare_playback_urb: prepare: pkt 1 [7]: avail=2619, counts=5
          <idle>-0       [010] d.s2.   154.354981: prepare_playback_urb: prepare: pkt 1 [8]: avail=2614, counts=6
          <idle>-0       [010] d.s2.   154.354982: prepare_playback_urb: prepare: pkt 1 [9]: avail=2608, counts=5
          <idle>-0       [010] d.s2.   154.354983: prepare_playback_urb: prepare: pkt 1 [10]: avail=2603, counts=6
          <idle>-0       [010] d.s2.   154.354983: prepare_playback_urb: prepare: pkt 1 [11]: avail=2597, counts=5
          <idle>-0       [010] d.s2.   154.354984: prepare_playback_urb: prepare: pkt 1 [12]: avail=2592, counts=6
          <idle>-0       [010] d.s2.   154.354984: prepare_playback_urb: prepare: pkt 1 [13]: avail=2586, counts=5
          <idle>-0       [010] d.s2.   154.354985: prepare_playback_urb: prepare: pkt 1 [14]: avail=2581, counts=6
          <idle>-0       [010] d.s2.   154.354985: prepare_playback_urb: prepare: pkt 1 [15]: avail=2575, counts=5
          <idle>-0       [010] d.s2.   154.354986: prepare_playback_urb: prepare: pkt 1 [16]: avail=2570, counts=6
          <idle>-0       [010] d.s2.   154.354986: prepare_playback_urb: prepare: pkt 1 [17]: avail=2564, counts=5
          <idle>-0       [010] d.s2.   154.354987: prepare_playback_urb: prepare: pkt 1 [18]: avail=2559, counts=6
          <idle>-0       [010] d.s2.   154.354987: prepare_playback_urb: prepare: pkt 1 [19]: avail=2553, counts=6
          <idle>-0       [010] d.s2.   154.354988: prepare_playback_urb: prepare: pkt 1 [20]: avail=2547, counts=5
          <idle>-0       [010] d.s2.   154.354988: prepare_playback_urb: prepare: pkt 1 [21]: avail=2542, counts=6
          <idle>-0       [010] d.s2.   154.354989: prepare_playback_urb: prepare: pkt 1 [22]: avail=2536, counts=5
          <idle>-0       [010] d.s2.   154.354989: prepare_playback_urb: prepare: pkt 1 [23]: avail=2531, counts=6
          <idle>-0       [010] d.s2.   154.354990: prepare_playback_urb: prepare: pkt 1 [24]: avail=2525, counts=5
          <idle>-0       [010] d.s2.   154.354990: prepare_playback_urb: prepare: pkt 1 [25]: avail=2520, counts=6
          <idle>-0       [010] d.s2.   154.354991: prepare_playback_urb: prepare: pkt 1 [26]: avail=2514, counts=5
          <idle>-0       [010] d.s2.   154.354991: prepare_playback_urb: prepare: pkt 1 [27]: avail=2509, counts=6
          <idle>-0       [010] d.s2.   154.354992: prepare_playback_urb: prepare: pkt 1 [28]: avail=2503, counts=5
          <idle>-0       [010] d.s2.   154.354992: prepare_playback_urb: prepare: pkt 1 [29]: avail=2498, counts=6
          <idle>-0       [010] d.s2.   154.354993: prepare_playback_urb: prepare: pkt 1 [30]: avail=2492, counts=5
          <idle>-0       [010] d.s2.   154.354993: prepare_playback_urb: prepare: pkt 1 [31]: avail=2487, counts=6
          <idle>-0       [010] d.s2.   154.354994: prepare_playback_urb: prepare: pkt 1 [32]: avail=2481, counts=5
          <idle>-0       [010] d.s2.   154.354994: prepare_playback_urb: prepare: pkt 1 [33]: avail=2476, counts=6
          <idle>-0       [010] d.s2.   154.354995: prepare_playback_urb: prepare: pkt 1 [34]: avail=2470, counts=5
          <idle>-0       [010] d.s2.   154.354995: prepare_playback_urb: prepare: pkt 1 [35]: avail=2465, counts=6
          <idle>-0       [010] d.s2.   154.354996: prepare_playback_urb: prepare: pkt 1 [36]: avail=2459, counts=5
          <idle>-0       [010] d.s2.   154.354997: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2468, hwptr=6568
          <idle>-0       [010] ..s1.   154.354999: snd_usb_queue_pending_output_urbs: pkt 1 submitted
          <idle>-0       [010] ..s1.   154.359528: snd_complete_urb: pkt complete 2
          <idle>-0       [010] ..s1.   154.359530: push_back_to_ready_list: pkt 2 push back
          <idle>-0       [010] ..s1.   154.359532: snd_usb_queue_pending_output_urbs: checking queue pkt 2 (active_mask=3)
          <idle>-0       [010] d.s2.   154.359534: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=1642, avail=2454
          <idle>-0       [010] d.s2.   154.359535: prepare_playback_urb: prepare: pkt 2 [0]: avail=2454, counts=6
          <idle>-0       [010] d.s2.   154.359535: prepare_playback_urb: prepare: pkt 2 [1]: avail=2448, counts=5
          <idle>-0       [010] d.s2.   154.359536: prepare_playback_urb: prepare: pkt 2 [2]: avail=2443, counts=6
          <idle>-0       [010] d.s2.   154.359537: prepare_playback_urb: prepare: pkt 2 [3]: avail=2437, counts=5
          <idle>-0       [010] d.s2.   154.359537: prepare_playback_urb: prepare: pkt 2 [4]: avail=2432, counts=6
          <idle>-0       [010] d.s2.   154.359538: prepare_playback_urb: prepare: pkt 2 [5]: avail=2426, counts=5
          <idle>-0       [010] d.s2.   154.359538: prepare_playback_urb: prepare: pkt 2 [6]: avail=2421, counts=6
          <idle>-0       [010] d.s2.   154.359539: prepare_playback_urb: prepare: pkt 2 [7]: avail=2415, counts=5
          <idle>-0       [010] d.s2.   154.359539: prepare_playback_urb: prepare: pkt 2 [8]: avail=2410, counts=6
          <idle>-0       [010] d.s2.   154.359540: prepare_playback_urb: prepare: pkt 2 [9]: avail=2404, counts=5
          <idle>-0       [010] d.s2.   154.359540: prepare_playback_urb: prepare: pkt 2 [10]: avail=2399, counts=6
          <idle>-0       [010] d.s2.   154.359541: prepare_playback_urb: prepare: pkt 2 [11]: avail=2393, counts=5
          <idle>-0       [010] d.s2.   154.359541: prepare_playback_urb: prepare: pkt 2 [12]: avail=2388, counts=6
          <idle>-0       [010] d.s2.   154.359542: prepare_playback_urb: prepare: pkt 2 [13]: avail=2382, counts=5
          <idle>-0       [010] d.s2.   154.359542: prepare_playback_urb: prepare: pkt 2 [14]: avail=2377, counts=6
          <idle>-0       [010] d.s2.   154.359543: prepare_playback_urb: prepare: pkt 2 [15]: avail=2371, counts=5
          <idle>-0       [010] d.s2.   154.359544: prepare_playback_urb: prepare: pkt 2 [16]: avail=2366, counts=6
          <idle>-0       [010] d.s2.   154.359544: prepare_playback_urb: prepare: pkt 2 [17]: avail=2360, counts=5
          <idle>-0       [010] d.s2.   154.359545: prepare_playback_urb: prepare: pkt 2 [18]: avail=2355, counts=6
          <idle>-0       [010] d.s2.   154.359545: prepare_playback_urb: prepare: pkt 2 [19]: avail=2349, counts=5
          <idle>-0       [010] d.s2.   154.359546: prepare_playback_urb: prepare: pkt 2 [20]: avail=2344, counts=6
          <idle>-0       [010] d.s2.   154.359546: prepare_playback_urb: prepare: pkt 2 [21]: avail=2338, counts=6
          <idle>-0       [010] d.s2.   154.359547: prepare_playback_urb: prepare: pkt 2 [22]: avail=2332, counts=5
          <idle>-0       [010] d.s2.   154.359547: prepare_playback_urb: prepare: pkt 2 [23]: avail=2327, counts=6
          <idle>-0       [010] d.s2.   154.359548: prepare_playback_urb: prepare: pkt 2 [24]: avail=2321, counts=5
          <idle>-0       [010] d.s2.   154.359548: prepare_playback_urb: prepare: pkt 2 [25]: avail=2316, counts=6
          <idle>-0       [010] d.s2.   154.359549: prepare_playback_urb: prepare: pkt 2 [26]: avail=2310, counts=5
          <idle>-0       [010] d.s2.   154.359549: prepare_playback_urb: prepare: pkt 2 [27]: avail=2305, counts=6
          <idle>-0       [010] d.s2.   154.359550: prepare_playback_urb: prepare: pkt 2 [28]: avail=2299, counts=5
          <idle>-0       [010] d.s2.   154.359550: prepare_playback_urb: prepare: pkt 2 [29]: avail=2294, counts=6
          <idle>-0       [010] d.s2.   154.359551: prepare_playback_urb: prepare: pkt 2 [30]: avail=2288, counts=5
          <idle>-0       [010] d.s2.   154.359551: prepare_playback_urb: prepare: pkt 2 [31]: avail=2283, counts=6
          <idle>-0       [010] d.s2.   154.359552: prepare_playback_urb: prepare: pkt 2 [32]: avail=2277, counts=5
          <idle>-0       [010] d.s2.   154.359552: prepare_playback_urb: prepare: pkt 2 [33]: avail=2272, counts=6
          <idle>-0       [010] d.s2.   154.359553: prepare_playback_urb: prepare: pkt 2 [34]: avail=2266, counts=5
          <idle>-0       [010] d.s2.   154.359554: prepare_playback_urb: prepare: pkt 2 [35]: avail=2261, counts=6
          <idle>-0       [010] d.s2.   154.359554: prepare_playback_urb: prepare: pkt 2 [36]: avail=2255, counts=5
          <idle>-0       [010] d.s2.   154.359556: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2468, hwptr=7384
          <idle>-0       [010] ..s1.   154.359557: snd_usb_queue_pending_output_urbs: pkt 2 submitted
          <idle>-0       [010] ..s1.   154.364337: snd_complete_urb: pkt complete 0
          <idle>-0       [010] ..s1.   154.364340: push_back_to_ready_list: pkt 0 push back
          <idle>-0       [010] ..s1.   154.364342: snd_usb_queue_pending_output_urbs: checking queue pkt 0 (active_mask=6)
          <idle>-0       [010] d.s2.   154.364344: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=1846, avail=2250
          <idle>-0       [010] d.s2.   154.364344: prepare_playback_urb: prepare: pkt 0 [0]: avail=2250, counts=6
          <idle>-0       [010] d.s2.   154.364345: prepare_playback_urb: prepare: pkt 0 [1]: avail=2244, counts=5
          <idle>-0       [010] d.s2.   154.364346: prepare_playback_urb: prepare: pkt 0 [2]: avail=2239, counts=6
          <idle>-0       [010] d.s2.   154.364346: prepare_playback_urb: prepare: pkt 0 [3]: avail=2233, counts=5
          <idle>-0       [010] d.s2.   154.364347: prepare_playback_urb: prepare: pkt 0 [4]: avail=2228, counts=6
          <idle>-0       [010] d.s2.   154.364348: prepare_playback_urb: prepare: pkt 0 [5]: avail=2222, counts=5
          <idle>-0       [010] d.s2.   154.364348: prepare_playback_urb: prepare: pkt 0 [6]: avail=2217, counts=6
          <idle>-0       [010] d.s2.   154.364349: prepare_playback_urb: prepare: pkt 0 [7]: avail=2211, counts=5
          <idle>-0       [010] d.s2.   154.364349: prepare_playback_urb: prepare: pkt 0 [8]: avail=2206, counts=6
          <idle>-0       [010] d.s2.   154.364350: prepare_playback_urb: prepare: pkt 0 [9]: avail=2200, counts=5
          <idle>-0       [010] d.s2.   154.364350: prepare_playback_urb: prepare: pkt 0 [10]: avail=2195, counts=6
          <idle>-0       [010] d.s2.   154.364351: prepare_playback_urb: prepare: pkt 0 [11]: avail=2189, counts=5
          <idle>-0       [010] d.s2.   154.364351: prepare_playback_urb: prepare: pkt 0 [12]: avail=2184, counts=6
          <idle>-0       [010] d.s2.   154.364352: prepare_playback_urb: prepare: pkt 0 [13]: avail=2178, counts=5
          <idle>-0       [010] d.s2.   154.364353: prepare_playback_urb: prepare: pkt 0 [14]: avail=2173, counts=6
          <idle>-0       [010] d.s2.   154.364353: prepare_playback_urb: prepare: pkt 0 [15]: avail=2167, counts=5
          <idle>-0       [010] d.s2.   154.364354: prepare_playback_urb: prepare: pkt 0 [16]: avail=2162, counts=6
          <idle>-0       [010] d.s2.   154.364354: prepare_playback_urb: prepare: pkt 0 [17]: avail=2156, counts=5
          <idle>-0       [010] d.s2.   154.364355: prepare_playback_urb: prepare: pkt 0 [18]: avail=2151, counts=6
          <idle>-0       [010] d.s2.   154.364355: prepare_playback_urb: prepare: pkt 0 [19]: avail=2145, counts=5
          <idle>-0       [010] d.s2.   154.364356: prepare_playback_urb: prepare: pkt 0 [20]: avail=2140, counts=6
          <idle>-0       [010] d.s2.   154.364356: prepare_playback_urb: prepare: pkt 0 [21]: avail=2134, counts=5
          <idle>-0       [010] d.s2.   154.364357: prepare_playback_urb: prepare: pkt 0 [22]: avail=2129, counts=6
          <idle>-0       [010] d.s2.   154.364357: prepare_playback_urb: prepare: pkt 0 [23]: avail=2123, counts=5
          <idle>-0       [010] d.s2.   154.364358: prepare_playback_urb: prepare: pkt 0 [24]: avail=2118, counts=6
          <idle>-0       [010] d.s2.   154.364358: prepare_playback_urb: prepare: pkt 0 [25]: avail=2112, counts=6
          <idle>-0       [010] d.s2.   154.364359: prepare_playback_urb: prepare: pkt 0 [26]: avail=2106, counts=5
          <idle>-0       [010] d.s2.   154.364359: prepare_playback_urb: prepare: pkt 0 [27]: avail=2101, counts=6
          <idle>-0       [010] d.s2.   154.364360: prepare_playback_urb: prepare: pkt 0 [28]: avail=2095, counts=5
          <idle>-0       [010] d.s2.   154.364360: prepare_playback_urb: prepare: pkt 0 [29]: avail=2090, counts=6
          <idle>-0       [010] d.s2.   154.364361: prepare_playback_urb: prepare: pkt 0 [30]: avail=2084, counts=5
          <idle>-0       [010] d.s2.   154.364362: prepare_playback_urb: prepare: pkt 0 [31]: avail=2079, counts=6
          <idle>-0       [010] d.s2.   154.364362: prepare_playback_urb: prepare: pkt 0 [32]: avail=2073, counts=5
          <idle>-0       [010] d.s2.   154.364363: prepare_playback_urb: prepare: pkt 0 [33]: avail=2068, counts=6
          <idle>-0       [010] d.s2.   154.364363: prepare_playback_urb: prepare: pkt 0 [34]: avail=2062, counts=5
          <idle>-0       [010] d.s2.   154.364364: prepare_playback_urb: prepare: pkt 0 [35]: avail=2057, counts=6
          <idle>-0       [010] d.s2.   154.364364: prepare_playback_urb: prepare: pkt 0 [36]: avail=2051, counts=5
          <idle>-0       [010] d.s2.   154.364365: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2448, hwptr=8200
          <idle>-0       [010] ..s1.   154.364387: snd_usb_queue_pending_output_urbs: pkt 0 submitted
          <idle>-0       [010] ..s1.   154.368907: snd_complete_urb: pkt complete 1
          <idle>-0       [010] ..s1.   154.368910: push_back_to_ready_list: pkt 1 push back
          <idle>-0       [010] ..s1.   154.368912: snd_usb_queue_pending_output_urbs: checking queue pkt 1 (active_mask=5)
          <idle>-0       [010] d.s2.   154.368914: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=2050, avail=2046
          <idle>-0       [010] d.s2.   154.368915: prepare_playback_urb: prepare: pkt 1 [0]: avail=2046, counts=6
          <idle>-0       [010] d.s2.   154.368915: prepare_playback_urb: prepare: pkt 1 [1]: avail=2040, counts=5
          <idle>-0       [010] d.s2.   154.368916: prepare_playback_urb: prepare: pkt 1 [2]: avail=2035, counts=6
          <idle>-0       [010] d.s2.   154.368917: prepare_playback_urb: prepare: pkt 1 [3]: avail=2029, counts=5
          <idle>-0       [010] d.s2.   154.368917: prepare_playback_urb: prepare: pkt 1 [4]: avail=2024, counts=6
          <idle>-0       [010] d.s2.   154.368918: prepare_playback_urb: prepare: pkt 1 [5]: avail=2018, counts=5
          <idle>-0       [010] d.s2.   154.368918: prepare_playback_urb: prepare: pkt 1 [6]: avail=2013, counts=6
          <idle>-0       [010] d.s2.   154.368919: prepare_playback_urb: prepare: pkt 1 [7]: avail=2007, counts=5
          <idle>-0       [010] d.s2.   154.368919: prepare_playback_urb: prepare: pkt 1 [8]: avail=2002, counts=6
          <idle>-0       [010] d.s2.   154.368920: prepare_playback_urb: prepare: pkt 1 [9]: avail=1996, counts=5
          <idle>-0       [010] d.s2.   154.368920: prepare_playback_urb: prepare: pkt 1 [10]: avail=1991, counts=6
          <idle>-0       [010] d.s2.   154.368921: prepare_playback_urb: prepare: pkt 1 [11]: avail=1985, counts=5
          <idle>-0       [010] d.s2.   154.368922: prepare_playback_urb: prepare: pkt 1 [12]: avail=1980, counts=6
          <idle>-0       [010] d.s2.   154.368922: prepare_playback_urb: prepare: pkt 1 [13]: avail=1974, counts=5
          <idle>-0       [010] d.s2.   154.368923: prepare_playback_urb: prepare: pkt 1 [14]: avail=1969, counts=6
          <idle>-0       [010] d.s2.   154.368923: prepare_playback_urb: prepare: pkt 1 [15]: avail=1963, counts=5
          <idle>-0       [010] d.s2.   154.368924: prepare_playback_urb: prepare: pkt 1 [16]: avail=1958, counts=6
          <idle>-0       [010] d.s2.   154.368924: prepare_playback_urb: prepare: pkt 1 [17]: avail=1952, counts=5
          <idle>-0       [010] d.s2.   154.368925: prepare_playback_urb: prepare: pkt 1 [18]: avail=1947, counts=6
          <idle>-0       [010] d.s2.   154.368925: prepare_playback_urb: prepare: pkt 1 [19]: avail=1941, counts=5
          <idle>-0       [010] d.s2.   154.368926: prepare_playback_urb: prepare: pkt 1 [20]: avail=1936, counts=6
          <idle>-0       [010] d.s2.   154.368926: prepare_playback_urb: prepare: pkt 1 [21]: avail=1930, counts=5
          <idle>-0       [010] d.s2.   154.368927: prepare_playback_urb: prepare: pkt 1 [22]: avail=1925, counts=6
          <idle>-0       [010] d.s2.   154.368927: prepare_playback_urb: prepare: pkt 1 [23]: avail=1919, counts=5
          <idle>-0       [010] d.s2.   154.368928: prepare_playback_urb: prepare: pkt 1 [24]: avail=1914, counts=6
          <idle>-0       [010] d.s2.   154.368928: prepare_playback_urb: prepare: pkt 1 [25]: avail=1908, counts=5
          <idle>-0       [010] d.s2.   154.368929: prepare_playback_urb: prepare: pkt 1 [26]: avail=1903, counts=6
          <idle>-0       [010] d.s2.   154.368929: prepare_playback_urb: prepare: pkt 1 [27]: avail=1897, counts=6
          <idle>-0       [010] d.s2.   154.368930: prepare_playback_urb: prepare: pkt 1 [28]: avail=1891, counts=5
          <idle>-0       [010] d.s2.   154.368930: prepare_playback_urb: prepare: pkt 1 [29]: avail=1886, counts=6
          <idle>-0       [010] d.s2.   154.368931: prepare_playback_urb: prepare: pkt 1 [30]: avail=1880, counts=5
          <idle>-0       [010] d.s2.   154.368931: prepare_playback_urb: prepare: pkt 1 [31]: avail=1875, counts=6
          <idle>-0       [010] d.s2.   154.368932: prepare_playback_urb: prepare: pkt 1 [32]: avail=1869, counts=5
          <idle>-0       [010] d.s2.   154.368932: prepare_playback_urb: prepare: pkt 1 [33]: avail=1864, counts=6
          <idle>-0       [010] d.s2.   154.368933: prepare_playback_urb: prepare: pkt 1 [34]: avail=1858, counts=5
          <idle>-0       [010] d.s2.   154.368933: prepare_playback_urb: prepare: pkt 1 [35]: avail=1853, counts=6
          <idle>-0       [010] d.s2.   154.368934: prepare_playback_urb: prepare: pkt 1 [36]: avail=1847, counts=5
          <idle>-0       [010] d.s2.   154.368935: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2448, hwptr=9016
          <idle>-0       [010] ..s1.   154.368936: snd_usb_queue_pending_output_urbs: pkt 1 submitted
          <idle>-0       [010] ..s1.   154.373527: snd_complete_urb: pkt complete 2
          <idle>-0       [010] ..s1.   154.373530: push_back_to_ready_list: pkt 2 push back
          <idle>-0       [010] ..s1.   154.373532: snd_usb_queue_pending_output_urbs: checking queue pkt 2 (active_mask=3)
          <idle>-0       [010] d.s2.   154.373534: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=2254, avail=1842
          <idle>-0       [010] d.s2.   154.373535: prepare_playback_urb: prepare: pkt 2 [0]: avail=1842, counts=6
          <idle>-0       [010] d.s2.   154.373536: prepare_playback_urb: prepare: pkt 2 [1]: avail=1836, counts=5
          <idle>-0       [010] d.s2.   154.373536: prepare_playback_urb: prepare: pkt 2 [2]: avail=1831, counts=6
          <idle>-0       [010] d.s2.   154.373537: prepare_playback_urb: prepare: pkt 2 [3]: avail=1825, counts=5
          <idle>-0       [010] d.s2.   154.373538: prepare_playback_urb: prepare: pkt 2 [4]: avail=1820, counts=6
          <idle>-0       [010] d.s2.   154.373538: prepare_playback_urb: prepare: pkt 2 [5]: avail=1814, counts=5
          <idle>-0       [010] d.s2.   154.373539: prepare_playback_urb: prepare: pkt 2 [6]: avail=1809, counts=6
          <idle>-0       [010] d.s2.   154.373539: prepare_playback_urb: prepare: pkt 2 [7]: avail=1803, counts=5
          <idle>-0       [010] d.s2.   154.373540: prepare_playback_urb: prepare: pkt 2 [8]: avail=1798, counts=6
          <idle>-0       [010] d.s2.   154.373540: prepare_playback_urb: prepare: pkt 2 [9]: avail=1792, counts=5
          <idle>-0       [010] d.s2.   154.373541: prepare_playback_urb: prepare: pkt 2 [10]: avail=1787, counts=6
          <idle>-0       [010] d.s2.   154.373541: prepare_playback_urb: prepare: pkt 2 [11]: avail=1781, counts=5
          <idle>-0       [010] d.s2.   154.373542: prepare_playback_urb: prepare: pkt 2 [12]: avail=1776, counts=6
          <idle>-0       [010] d.s2.   154.373543: prepare_playback_urb: prepare: pkt 2 [13]: avail=1770, counts=5
          <idle>-0       [010] d.s2.   154.373543: prepare_playback_urb: prepare: pkt 2 [14]: avail=1765, counts=6
          <idle>-0       [010] d.s2.   154.373544: prepare_playback_urb: prepare: pkt 2 [15]: avail=1759, counts=5
          <idle>-0       [010] d.s2.   154.373544: prepare_playback_urb: prepare: pkt 2 [16]: avail=1754, counts=6
          <idle>-0       [010] d.s2.   154.373545: prepare_playback_urb: prepare: pkt 2 [17]: avail=1748, counts=5
          <idle>-0       [010] d.s2.   154.373545: prepare_playback_urb: prepare: pkt 2 [18]: avail=1743, counts=6
          <idle>-0       [010] d.s2.   154.373546: prepare_playback_urb: prepare: pkt 2 [19]: avail=1737, counts=5
          <idle>-0       [010] d.s2.   154.373546: prepare_playback_urb: prepare: pkt 2 [20]: avail=1732, counts=6
          <idle>-0       [010] d.s2.   154.373547: prepare_playback_urb: prepare: pkt 2 [21]: avail=1726, counts=5
          <idle>-0       [010] d.s2.   154.373547: prepare_playback_urb: prepare: pkt 2 [22]: avail=1721, counts=6
          <idle>-0       [010] d.s2.   154.373548: prepare_playback_urb: prepare: pkt 2 [23]: avail=1715, counts=5
          <idle>-0       [010] d.s2.   154.373548: prepare_playback_urb: prepare: pkt 2 [24]: avail=1710, counts=6
          <idle>-0       [010] d.s2.   154.373549: prepare_playback_urb: prepare: pkt 2 [25]: avail=1704, counts=5
          <idle>-0       [010] d.s2.   154.373549: prepare_playback_urb: prepare: pkt 2 [26]: avail=1699, counts=6
          <idle>-0       [010] d.s2.   154.373550: prepare_playback_urb: prepare: pkt 2 [27]: avail=1693, counts=5
          <idle>-0       [010] d.s2.   154.373550: prepare_playback_urb: prepare: pkt 2 [28]: avail=1688, counts=6
          <idle>-0       [010] d.s2.   154.373551: prepare_playback_urb: prepare: pkt 2 [29]: avail=1682, counts=5
          <idle>-0       [010] d.s2.   154.373551: prepare_playback_urb: prepare: pkt 2 [30]: avail=1677, counts=6
          <idle>-0       [010] d.s2.   154.373552: prepare_playback_urb: prepare: pkt 2 [31]: avail=1671, counts=6
          <idle>-0       [010] d.s2.   154.373552: prepare_playback_urb: prepare: pkt 2 [32]: avail=1665, counts=5
          <idle>-0       [010] d.s2.   154.373553: prepare_playback_urb: prepare: pkt 2 [33]: avail=1660, counts=6
          <idle>-0       [010] d.s2.   154.373553: prepare_playback_urb: prepare: pkt 2 [34]: avail=1654, counts=5
          <idle>-0       [010] d.s2.   154.373554: prepare_playback_urb: prepare: pkt 2 [35]: avail=1649, counts=6
          <idle>-0       [010] d.s2.   154.373554: prepare_playback_urb: prepare: pkt 2 [36]: avail=1643, counts=5
          <idle>-0       [010] d.s2.   154.373556: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2448, hwptr=9832
          <idle>-0       [010] ..s1.   154.373557: snd_usb_queue_pending_output_urbs: pkt 2 submitted
          <idle>-0       [010] ..s1.   154.378153: snd_complete_urb: pkt complete 0
          <idle>-0       [010] ..s1.   154.378156: push_back_to_ready_list: pkt 0 push back
          <idle>-0       [010] ..s1.   154.378158: snd_usb_queue_pending_output_urbs: checking queue pkt 0 (active_mask=6)
          <idle>-0       [010] d.s2.   154.378159: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=2458, avail=1638
          <idle>-0       [010] d.s2.   154.378160: prepare_playback_urb: prepare: pkt 0 [0]: avail=1638, counts=6
          <idle>-0       [010] d.s2.   154.378161: prepare_playback_urb: prepare: pkt 0 [1]: avail=1632, counts=5
          <idle>-0       [010] d.s2.   154.378162: prepare_playback_urb: prepare: pkt 0 [2]: avail=1627, counts=6
          <idle>-0       [010] d.s2.   154.378162: prepare_playback_urb: prepare: pkt 0 [3]: avail=1621, counts=5
          <idle>-0       [010] d.s2.   154.378163: prepare_playback_urb: prepare: pkt 0 [4]: avail=1616, counts=6
          <idle>-0       [010] d.s2.   154.378163: prepare_playback_urb: prepare: pkt 0 [5]: avail=1610, counts=5
          <idle>-0       [010] d.s2.   154.378164: prepare_playback_urb: prepare: pkt 0 [6]: avail=1605, counts=6
          <idle>-0       [010] d.s2.   154.378164: prepare_playback_urb: prepare: pkt 0 [7]: avail=1599, counts=5
          <idle>-0       [010] d.s2.   154.378165: prepare_playback_urb: prepare: pkt 0 [8]: avail=1594, counts=6
          <idle>-0       [010] d.s2.   154.378165: prepare_playback_urb: prepare: pkt 0 [9]: avail=1588, counts=5
          <idle>-0       [010] d.s2.   154.378166: prepare_playback_urb: prepare: pkt 0 [10]: avail=1583, counts=6
          <idle>-0       [010] d.s2.   154.378167: prepare_playback_urb: prepare: pkt 0 [11]: avail=1577, counts=5
          <idle>-0       [010] d.s2.   154.378167: prepare_playback_urb: prepare: pkt 0 [12]: avail=1572, counts=6
          <idle>-0       [010] d.s2.   154.378168: prepare_playback_urb: prepare: pkt 0 [13]: avail=1566, counts=5
          <idle>-0       [010] d.s2.   154.378168: prepare_playback_urb: prepare: pkt 0 [14]: avail=1561, counts=6
          <idle>-0       [010] d.s2.   154.378169: prepare_playback_urb: prepare: pkt 0 [15]: avail=1555, counts=5
          <idle>-0       [010] d.s2.   154.378169: prepare_playback_urb: prepare: pkt 0 [16]: avail=1550, counts=6
          <idle>-0       [010] d.s2.   154.378170: prepare_playback_urb: prepare: pkt 0 [17]: avail=1544, counts=5
          <idle>-0       [010] d.s2.   154.378170: prepare_playback_urb: prepare: pkt 0 [18]: avail=1539, counts=6
          <idle>-0       [010] d.s2.   154.378171: prepare_playback_urb: prepare: pkt 0 [19]: avail=1533, counts=5
          <idle>-0       [010] d.s2.   154.378171: prepare_playback_urb: prepare: pkt 0 [20]: avail=1528, counts=6
          <idle>-0       [010] d.s2.   154.378172: prepare_playback_urb: prepare: pkt 0 [21]: avail=1522, counts=5
          <idle>-0       [010] d.s2.   154.378172: prepare_playback_urb: prepare: pkt 0 [22]: avail=1517, counts=6
          <idle>-0       [010] d.s2.   154.378173: prepare_playback_urb: prepare: pkt 0 [23]: avail=1511, counts=5
          <idle>-0       [010] d.s2.   154.378173: prepare_playback_urb: prepare: pkt 0 [24]: avail=1506, counts=6
          <idle>-0       [010] d.s2.   154.378174: prepare_playback_urb: prepare: pkt 0 [25]: avail=1500, counts=5
          <idle>-0       [010] d.s2.   154.378174: prepare_playback_urb: prepare: pkt 0 [26]: avail=1495, counts=6
          <idle>-0       [010] d.s2.   154.378175: prepare_playback_urb: prepare: pkt 0 [27]: avail=1489, counts=5
          <idle>-0       [010] d.s2.   154.378175: prepare_playback_urb: prepare: pkt 0 [28]: avail=1484, counts=6
          <idle>-0       [010] d.s2.   154.378176: prepare_playback_urb: prepare: pkt 0 [29]: avail=1478, counts=5
          <idle>-0       [010] d.s2.   154.378176: prepare_playback_urb: prepare: pkt 0 [30]: avail=1473, counts=6
          <idle>-0       [010] d.s2.   154.378177: prepare_playback_urb: prepare: pkt 0 [31]: avail=1467, counts=5
          <idle>-0       [010] d.s2.   154.378177: prepare_playback_urb: prepare: pkt 0 [32]: avail=1462, counts=6
          <idle>-0       [010] d.s2.   154.378178: prepare_playback_urb: prepare: pkt 0 [33]: avail=1456, counts=6
          <idle>-0       [010] d.s2.   154.378178: prepare_playback_urb: prepare: pkt 0 [34]: avail=1450, counts=5
          <idle>-0       [010] d.s2.   154.378179: prepare_playback_urb: prepare: pkt 0 [35]: avail=1445, counts=6
          <idle>-0       [010] d.s2.   154.378179: prepare_playback_urb: prepare: pkt 0 [36]: avail=1439, counts=5
          <idle>-0       [010] d.s2.   154.378180: prepare_playback_urb: prepare: pkt 0 [37]: avail=1434, counts=6
          <idle>-0       [010] d.s2.   154.378181: urb_ctx_queue_advance: PCM bytes=840, queued=840, inflight=2472, hwptr=10672
          <idle>-0       [010] ..s1.   154.378183: snd_usb_queue_pending_output_urbs: pkt 0 submitted
          <idle>-0       [010] ..s1.   154.382852: snd_complete_urb: pkt complete 1
          <idle>-0       [010] ..s1.   154.382854: push_back_to_ready_list: pkt 1 push back
          <idle>-0       [010] ..s1.   154.382856: snd_usb_queue_pending_output_urbs: checking queue pkt 1 (active_mask=5)
          <idle>-0       [010] d.s2.   154.382858: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=2668, avail=1428
          <idle>-0       [010] d.s2.   154.382859: prepare_playback_urb: prepare: pkt 1 [0]: avail=1428, counts=5
          <idle>-0       [010] d.s2.   154.382860: prepare_playback_urb: prepare: pkt 1 [1]: avail=1423, counts=6
          <idle>-0       [010] d.s2.   154.382860: prepare_playback_urb: prepare: pkt 1 [2]: avail=1417, counts=5
          <idle>-0       [010] d.s2.   154.382861: prepare_playback_urb: prepare: pkt 1 [3]: avail=1412, counts=6
          <idle>-0       [010] d.s2.   154.382861: prepare_playback_urb: prepare: pkt 1 [4]: avail=1406, counts=5
          <idle>-0       [010] d.s2.   154.382862: prepare_playback_urb: prepare: pkt 1 [5]: avail=1401, counts=6
          <idle>-0       [010] d.s2.   154.382863: prepare_playback_urb: prepare: pkt 1 [6]: avail=1395, counts=5
          <idle>-0       [010] d.s2.   154.382864: prepare_playback_urb: prepare: pkt 1 [7]: avail=1390, counts=6
          <idle>-0       [010] d.s2.   154.382864: prepare_playback_urb: prepare: pkt 1 [8]: avail=1384, counts=5
          <idle>-0       [010] d.s2.   154.382865: prepare_playback_urb: prepare: pkt 1 [9]: avail=1379, counts=6
          <idle>-0       [010] d.s2.   154.382865: prepare_playback_urb: prepare: pkt 1 [10]: avail=1373, counts=5
          <idle>-0       [010] d.s2.   154.382866: prepare_playback_urb: prepare: pkt 1 [11]: avail=1368, counts=6
          <idle>-0       [010] d.s2.   154.382866: prepare_playback_urb: prepare: pkt 1 [12]: avail=1362, counts=5
          <idle>-0       [010] d.s2.   154.382867: prepare_playback_urb: prepare: pkt 1 [13]: avail=1357, counts=6
          <idle>-0       [010] d.s2.   154.382867: prepare_playback_urb: prepare: pkt 1 [14]: avail=1351, counts=5
          <idle>-0       [010] d.s2.   154.382868: prepare_playback_urb: prepare: pkt 1 [15]: avail=1346, counts=6
          <idle>-0       [010] d.s2.   154.382868: prepare_playback_urb: prepare: pkt 1 [16]: avail=1340, counts=5
          <idle>-0       [010] d.s2.   154.382869: prepare_playback_urb: prepare: pkt 1 [17]: avail=1335, counts=6
          <idle>-0       [010] d.s2.   154.382870: prepare_playback_urb: prepare: pkt 1 [18]: avail=1329, counts=5
          <idle>-0       [010] d.s2.   154.382870: prepare_playback_urb: prepare: pkt 1 [19]: avail=1324, counts=6
          <idle>-0       [010] d.s2.   154.382871: prepare_playback_urb: prepare: pkt 1 [20]: avail=1318, counts=5
          <idle>-0       [010] d.s2.   154.382871: prepare_playback_urb: prepare: pkt 1 [21]: avail=1313, counts=6
          <idle>-0       [010] d.s2.   154.382872: prepare_playback_urb: prepare: pkt 1 [22]: avail=1307, counts=5
          <idle>-0       [010] d.s2.   154.382872: prepare_playback_urb: prepare: pkt 1 [23]: avail=1302, counts=6
          <idle>-0       [010] d.s2.   154.382873: prepare_playback_urb: prepare: pkt 1 [24]: avail=1296, counts=5
          <idle>-0       [010] d.s2.   154.382873: prepare_playback_urb: prepare: pkt 1 [25]: avail=1291, counts=6
          <idle>-0       [010] d.s2.   154.382874: prepare_playback_urb: prepare: pkt 1 [26]: avail=1285, counts=5
          <idle>-0       [010] d.s2.   154.382874: prepare_playback_urb: prepare: pkt 1 [27]: avail=1280, counts=6
          <idle>-0       [010] d.s2.   154.382875: prepare_playback_urb: prepare: pkt 1 [28]: avail=1274, counts=5
          <idle>-0       [010] d.s2.   154.382875: prepare_playback_urb: prepare: pkt 1 [29]: avail=1269, counts=6
          <idle>-0       [010] d.s2.   154.382876: prepare_playback_urb: prepare: pkt 1 [30]: avail=1263, counts=5
          <idle>-0       [010] d.s2.   154.382876: prepare_playback_urb: prepare: pkt 1 [31]: avail=1258, counts=6
          <idle>-0       [010] d.s2.   154.382877: prepare_playback_urb: prepare: pkt 1 [32]: avail=1252, counts=5
          <idle>-0       [010] d.s2.   154.382877: prepare_playback_urb: prepare: pkt 1 [33]: avail=1247, counts=6
          <idle>-0       [010] d.s2.   154.382878: prepare_playback_urb: prepare: pkt 1 [34]: avail=1241, counts=5
          <idle>-0       [010] d.s2.   154.382878: prepare_playback_urb: prepare: pkt 1 [35]: avail=1236, counts=6
          <idle>-0       [010] d.s2.   154.382879: prepare_playback_urb: prepare: pkt 1 [36]: avail=1230, counts=6
          <idle>-0       [010] d.s2.   154.382880: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2472, hwptr=11488
          <idle>-0       [010] ..s1.   154.382882: snd_usb_queue_pending_output_urbs: pkt 1 submitted
          <idle>-0       [010] ..s1.   154.387473: snd_complete_urb: pkt complete 2
          <idle>-0       [010] ..s1.   154.387476: push_back_to_ready_list: pkt 2 push back
          <idle>-0       [010] ..s1.   154.387477: snd_usb_queue_pending_output_urbs: checking queue pkt 2 (active_mask=3)
          <idle>-0       [010] d.s2.   154.387479: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=2872, avail=1224
          <idle>-0       [010] d.s2.   154.387480: prepare_playback_urb: prepare: pkt 2 [0]: avail=1224, counts=5
          <idle>-0       [010] d.s2.   154.387481: prepare_playback_urb: prepare: pkt 2 [1]: avail=1219, counts=6
          <idle>-0       [010] d.s2.   154.387481: prepare_playback_urb: prepare: pkt 2 [2]: avail=1213, counts=5
          <idle>-0       [010] d.s2.   154.387482: prepare_playback_urb: prepare: pkt 2 [3]: avail=1208, counts=6
          <idle>-0       [010] d.s2.   154.387482: prepare_playback_urb: prepare: pkt 2 [4]: avail=1202, counts=5
          <idle>-0       [010] d.s2.   154.387483: prepare_playback_urb: prepare: pkt 2 [5]: avail=1197, counts=6
          <idle>-0       [010] d.s2.   154.387483: prepare_playback_urb: prepare: pkt 2 [6]: avail=1191, counts=5
          <idle>-0       [010] d.s2.   154.387484: prepare_playback_urb: prepare: pkt 2 [7]: avail=1186, counts=6
          <idle>-0       [010] d.s2.   154.387485: prepare_playback_urb: prepare: pkt 2 [8]: avail=1180, counts=5
          <idle>-0       [010] d.s2.   154.387485: prepare_playback_urb: prepare: pkt 2 [9]: avail=1175, counts=6
          <idle>-0       [010] d.s2.   154.387486: prepare_playback_urb: prepare: pkt 2 [10]: avail=1169, counts=5
          <idle>-0       [010] d.s2.   154.387486: prepare_playback_urb: prepare: pkt 2 [11]: avail=1164, counts=6
          <idle>-0       [010] d.s2.   154.387487: prepare_playback_urb: prepare: pkt 2 [12]: avail=1158, counts=5
          <idle>-0       [010] d.s2.   154.387487: prepare_playback_urb: prepare: pkt 2 [13]: avail=1153, counts=6
          <idle>-0       [010] d.s2.   154.387488: prepare_playback_urb: prepare: pkt 2 [14]: avail=1147, counts=5
          <idle>-0       [010] d.s2.   154.387488: prepare_playback_urb: prepare: pkt 2 [15]: avail=1142, counts=6
          <idle>-0       [010] d.s2.   154.387489: prepare_playback_urb: prepare: pkt 2 [16]: avail=1136, counts=5
          <idle>-0       [010] d.s2.   154.387489: prepare_playback_urb: prepare: pkt 2 [17]: avail=1131, counts=6
          <idle>-0       [010] d.s2.   154.387490: prepare_playback_urb: prepare: pkt 2 [18]: avail=1125, counts=5
          <idle>-0       [010] d.s2.   154.387490: prepare_playback_urb: prepare: pkt 2 [19]: avail=1120, counts=6
          <idle>-0       [010] d.s2.   154.387491: prepare_playback_urb: prepare: pkt 2 [20]: avail=1114, counts=5
          <idle>-0       [010] d.s2.   154.387492: prepare_playback_urb: prepare: pkt 2 [21]: avail=1109, counts=6
          <idle>-0       [010] d.s2.   154.387492: prepare_playback_urb: prepare: pkt 2 [22]: avail=1103, counts=5
          <idle>-0       [010] d.s2.   154.387493: prepare_playback_urb: prepare: pkt 2 [23]: avail=1098, counts=6
          <idle>-0       [010] d.s2.   154.387493: prepare_playback_urb: prepare: pkt 2 [24]: avail=1092, counts=5
          <idle>-0       [010] d.s2.   154.387494: prepare_playback_urb: prepare: pkt 2 [25]: avail=1087, counts=6
          <idle>-0       [010] d.s2.   154.387494: prepare_playback_urb: prepare: pkt 2 [26]: avail=1081, counts=5
          <idle>-0       [010] d.s2.   154.387495: prepare_playback_urb: prepare: pkt 2 [27]: avail=1076, counts=6
          <idle>-0       [010] d.s2.   154.387495: prepare_playback_urb: prepare: pkt 2 [28]: avail=1070, counts=5
          <idle>-0       [010] d.s2.   154.387496: prepare_playback_urb: prepare: pkt 2 [29]: avail=1065, counts=6
          <idle>-0       [010] d.s2.   154.387496: prepare_playback_urb: prepare: pkt 2 [30]: avail=1059, counts=5
          <idle>-0       [010] d.s2.   154.387497: prepare_playback_urb: prepare: pkt 2 [31]: avail=1054, counts=6
          <idle>-0       [010] d.s2.   154.387497: prepare_playback_urb: prepare: pkt 2 [32]: avail=1048, counts=5
          <idle>-0       [010] d.s2.   154.387498: prepare_playback_urb: prepare: pkt 2 [33]: avail=1043, counts=6
          <idle>-0       [010] d.s2.   154.387498: prepare_playback_urb: prepare: pkt 2 [34]: avail=1037, counts=5
          <idle>-0       [010] d.s2.   154.387499: prepare_playback_urb: prepare: pkt 2 [35]: avail=1032, counts=6
          <idle>-0       [010] d.s2.   154.387499: prepare_playback_urb: prepare: pkt 2 [36]: avail=1026, counts=5
          <idle>-0       [010] d.s2.   154.387501: urb_ctx_queue_advance: PCM bytes=812, queued=812, inflight=2468, hwptr=12300
          <idle>-0       [010] ..s1.   154.387522: snd_usb_queue_pending_output_urbs: pkt 2 submitted
          <idle>-0       [010] ..s1.   154.392234: snd_complete_urb: pkt complete 0
          <idle>-0       [010] ..s1.   154.392237: push_back_to_ready_list: pkt 0 push back
          <idle>-0       [010] ..s1.   154.392239: snd_usb_queue_pending_output_urbs: checking queue pkt 0 (active_mask=6)
          <idle>-0       [010] d.s2.   154.392240: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=3075, avail=1021
          <idle>-0       [010] d.s2.   154.392241: prepare_playback_urb: prepare: pkt 0 [0]: avail=1021, counts=6
          <idle>-0       [010] d.s2.   154.392242: prepare_playback_urb: prepare: pkt 0 [1]: avail=1015, counts=6
          <idle>-0       [010] d.s2.   154.392243: prepare_playback_urb: prepare: pkt 0 [2]: avail=1009, counts=5
          <idle>-0       [010] d.s2.   154.392243: prepare_playback_urb: prepare: pkt 0 [3]: avail=1004, counts=6
          <idle>-0       [010] d.s2.   154.392244: prepare_playback_urb: prepare: pkt 0 [4]: avail=998, counts=5
          <idle>-0       [010] d.s2.   154.392244: prepare_playback_urb: prepare: pkt 0 [5]: avail=993, counts=6
          <idle>-0       [010] d.s2.   154.392245: prepare_playback_urb: prepare: pkt 0 [6]: avail=987, counts=5
          <idle>-0       [010] d.s2.   154.392245: prepare_playback_urb: prepare: pkt 0 [7]: avail=982, counts=6
          <idle>-0       [010] d.s2.   154.392246: prepare_playback_urb: prepare: pkt 0 [8]: avail=976, counts=5
          <idle>-0       [010] d.s2.   154.392247: prepare_playback_urb: prepare: pkt 0 [9]: avail=971, counts=6
          <idle>-0       [010] d.s2.   154.392247: prepare_playback_urb: prepare: pkt 0 [10]: avail=965, counts=5
          <idle>-0       [010] d.s2.   154.392248: prepare_playback_urb: prepare: pkt 0 [11]: avail=960, counts=6
          <idle>-0       [010] d.s2.   154.392248: prepare_playback_urb: prepare: pkt 0 [12]: avail=954, counts=5
          <idle>-0       [010] d.s2.   154.392249: prepare_playback_urb: prepare: pkt 0 [13]: avail=949, counts=6
          <idle>-0       [010] d.s2.   154.392250: prepare_playback_urb: prepare: pkt 0 [14]: avail=943, counts=5
          <idle>-0       [010] d.s2.   154.392250: prepare_playback_urb: prepare: pkt 0 [15]: avail=938, counts=6
          <idle>-0       [010] d.s2.   154.392251: prepare_playback_urb: prepare: pkt 0 [16]: avail=932, counts=5
          <idle>-0       [010] d.s2.   154.392252: prepare_playback_urb: prepare: pkt 0 [17]: avail=927, counts=6
          <idle>-0       [010] d.s2.   154.392252: prepare_playback_urb: prepare: pkt 0 [18]: avail=921, counts=5
          <idle>-0       [010] d.s2.   154.392253: prepare_playback_urb: prepare: pkt 0 [19]: avail=916, counts=6
          <idle>-0       [010] d.s2.   154.392253: prepare_playback_urb: prepare: pkt 0 [20]: avail=910, counts=5
          <idle>-0       [010] d.s2.   154.392254: prepare_playback_urb: prepare: pkt 0 [21]: avail=905, counts=6
          <idle>-0       [010] d.s2.   154.392254: prepare_playback_urb: prepare: pkt 0 [22]: avail=899, counts=5
          <idle>-0       [010] d.s2.   154.392255: prepare_playback_urb: prepare: pkt 0 [23]: avail=894, counts=6
          <idle>-0       [010] d.s2.   154.392255: prepare_playback_urb: prepare: pkt 0 [24]: avail=888, counts=5
          <idle>-0       [010] d.s2.   154.392256: prepare_playback_urb: prepare: pkt 0 [25]: avail=883, counts=6
          <idle>-0       [010] d.s2.   154.392257: prepare_playback_urb: prepare: pkt 0 [26]: avail=877, counts=5
          <idle>-0       [010] d.s2.   154.392257: prepare_playback_urb: prepare: pkt 0 [27]: avail=872, counts=6
          <idle>-0       [010] d.s2.   154.392258: prepare_playback_urb: prepare: pkt 0 [28]: avail=866, counts=5
          <idle>-0       [010] d.s2.   154.392258: prepare_playback_urb: prepare: pkt 0 [29]: avail=861, counts=6
          <idle>-0       [010] d.s2.   154.392259: prepare_playback_urb: prepare: pkt 0 [30]: avail=855, counts=5
          <idle>-0       [010] d.s2.   154.392259: prepare_playback_urb: prepare: pkt 0 [31]: avail=850, counts=6
          <idle>-0       [010] d.s2.   154.392260: prepare_playback_urb: prepare: pkt 0 [32]: avail=844, counts=5
          <idle>-0       [010] d.s2.   154.392260: prepare_playback_urb: prepare: pkt 0 [33]: avail=839, counts=6
          <idle>-0       [010] d.s2.   154.392261: prepare_playback_urb: prepare: pkt 0 [34]: avail=833, counts=5
          <idle>-0       [010] d.s2.   154.392261: prepare_playback_urb: prepare: pkt 0 [35]: avail=828, counts=6
          <idle>-0       [010] d.s2.   154.392262: prepare_playback_urb: prepare: pkt 0 [36]: avail=822, counts=5
          <idle>-0       [010] d.s2.   154.392263: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2444, hwptr=13116
          <idle>-0       [010] ..s1.   154.392264: snd_usb_queue_pending_output_urbs: pkt 0 submitted
          <idle>-0       [010] ..s1.   154.396852: snd_complete_urb: pkt complete 1
          <idle>-0       [010] ..s1.   154.396854: push_back_to_ready_list: pkt 1 push back
          <idle>-0       [010] ..s1.   154.396856: snd_usb_queue_pending_output_urbs: checking queue pkt 1 (active_mask=5)
          <idle>-0       [010] d.s2.   154.396858: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=3279, avail=817
          <idle>-0       [010] d.s2.   154.396859: prepare_playback_urb: prepare: pkt 1 [0]: avail=817, counts=6
          <idle>-0       [010] d.s2.   154.396860: prepare_playback_urb: prepare: pkt 1 [1]: avail=811, counts=5
          <idle>-0       [010] d.s2.   154.396860: prepare_playback_urb: prepare: pkt 1 [2]: avail=806, counts=6
          <idle>-0       [010] d.s2.   154.396861: prepare_playback_urb: prepare: pkt 1 [3]: avail=800, counts=5
          <idle>-0       [010] d.s2.   154.396861: prepare_playback_urb: prepare: pkt 1 [4]: avail=795, counts=6
          <idle>-0       [010] d.s2.   154.396862: prepare_playback_urb: prepare: pkt 1 [5]: avail=789, counts=6
          <idle>-0       [010] d.s2.   154.396862: prepare_playback_urb: prepare: pkt 1 [6]: avail=783, counts=5
          <idle>-0       [010] d.s2.   154.396863: prepare_playback_urb: prepare: pkt 1 [7]: avail=778, counts=6
          <idle>-0       [010] d.s2.   154.396863: prepare_playback_urb: prepare: pkt 1 [8]: avail=772, counts=5
          <idle>-0       [010] d.s2.   154.396864: prepare_playback_urb: prepare: pkt 1 [9]: avail=767, counts=6
          <idle>-0       [010] d.s2.   154.396865: prepare_playback_urb: prepare: pkt 1 [10]: avail=761, counts=5
          <idle>-0       [010] d.s2.   154.396865: prepare_playback_urb: prepare: pkt 1 [11]: avail=756, counts=6
          <idle>-0       [010] d.s2.   154.396866: prepare_playback_urb: prepare: pkt 1 [12]: avail=750, counts=5
          <idle>-0       [010] d.s2.   154.396866: prepare_playback_urb: prepare: pkt 1 [13]: avail=745, counts=6
          <idle>-0       [010] d.s2.   154.396867: prepare_playback_urb: prepare: pkt 1 [14]: avail=739, counts=5
          <idle>-0       [010] d.s2.   154.396867: prepare_playback_urb: prepare: pkt 1 [15]: avail=734, counts=6
          <idle>-0       [010] d.s2.   154.396868: prepare_playback_urb: prepare: pkt 1 [16]: avail=728, counts=5
          <idle>-0       [010] d.s2.   154.396868: prepare_playback_urb: prepare: pkt 1 [17]: avail=723, counts=6
          <idle>-0       [010] d.s2.   154.396869: prepare_playback_urb: prepare: pkt 1 [18]: avail=717, counts=5
          <idle>-0       [010] d.s2.   154.396869: prepare_playback_urb: prepare: pkt 1 [19]: avail=712, counts=6
          <idle>-0       [010] d.s2.   154.396870: prepare_playback_urb: prepare: pkt 1 [20]: avail=706, counts=5
          <idle>-0       [010] d.s2.   154.396870: prepare_playback_urb: prepare: pkt 1 [21]: avail=701, counts=6
          <idle>-0       [010] d.s2.   154.396871: prepare_playback_urb: prepare: pkt 1 [22]: avail=695, counts=5
          <idle>-0       [010] d.s2.   154.396872: prepare_playback_urb: prepare: pkt 1 [23]: avail=690, counts=6
          <idle>-0       [010] d.s2.   154.396872: prepare_playback_urb: prepare: pkt 1 [24]: avail=684, counts=5
          <idle>-0       [010] d.s2.   154.396873: prepare_playback_urb: prepare: pkt 1 [25]: avail=679, counts=6
          <idle>-0       [010] d.s2.   154.396873: prepare_playback_urb: prepare: pkt 1 [26]: avail=673, counts=5
          <idle>-0       [010] d.s2.   154.396874: prepare_playback_urb: prepare: pkt 1 [27]: avail=668, counts=6
          <idle>-0       [010] d.s2.   154.396874: prepare_playback_urb: prepare: pkt 1 [28]: avail=662, counts=5
          <idle>-0       [010] d.s2.   154.396875: prepare_playback_urb: prepare: pkt 1 [29]: avail=657, counts=6
          <idle>-0       [010] d.s2.   154.396875: prepare_playback_urb: prepare: pkt 1 [30]: avail=651, counts=5
          <idle>-0       [010] d.s2.   154.396876: prepare_playback_urb: prepare: pkt 1 [31]: avail=646, counts=6
          <idle>-0       [010] d.s2.   154.396876: prepare_playback_urb: prepare: pkt 1 [32]: avail=640, counts=5
          <idle>-0       [010] d.s2.   154.396877: prepare_playback_urb: prepare: pkt 1 [33]: avail=635, counts=6
          <idle>-0       [010] d.s2.   154.396877: prepare_playback_urb: prepare: pkt 1 [34]: avail=629, counts=5
          <idle>-0       [010] d.s2.   154.396878: prepare_playback_urb: prepare: pkt 1 [35]: avail=624, counts=6
          <idle>-0       [010] d.s2.   154.396878: prepare_playback_urb: prepare: pkt 1 [36]: avail=618, counts=5
          <idle>-0       [010] d.s2.   154.396880: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2444, hwptr=13932
          <idle>-0       [010] ..s1.   154.396881: snd_usb_queue_pending_output_urbs: pkt 1 submitted
          <idle>-0       [010] ..s1.   154.401469: snd_complete_urb: pkt complete 2
          <idle>-0       [010] ..s1.   154.401472: push_back_to_ready_list: pkt 2 push back
          <idle>-0       [010] ..s1.   154.401474: snd_usb_queue_pending_output_urbs: checking queue pkt 2 (active_mask=3)
          <idle>-0       [010] d.s2.   154.401475: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=3483, avail=613
          <idle>-0       [010] d.s2.   154.401476: prepare_playback_urb: prepare: pkt 2 [0]: avail=613, counts=6
          <idle>-0       [010] d.s2.   154.401477: prepare_playback_urb: prepare: pkt 2 [1]: avail=607, counts=5
          <idle>-0       [010] d.s2.   154.401477: prepare_playback_urb: prepare: pkt 2 [2]: avail=602, counts=6
          <idle>-0       [010] d.s2.   154.401478: prepare_playback_urb: prepare: pkt 2 [3]: avail=596, counts=5
          <idle>-0       [010] d.s2.   154.401479: prepare_playback_urb: prepare: pkt 2 [4]: avail=591, counts=6
          <idle>-0       [010] d.s2.   154.401479: prepare_playback_urb: prepare: pkt 2 [5]: avail=585, counts=5
          <idle>-0       [010] d.s2.   154.401480: prepare_playback_urb: prepare: pkt 2 [6]: avail=580, counts=6
          <idle>-0       [010] d.s2.   154.401480: prepare_playback_urb: prepare: pkt 2 [7]: avail=574, counts=6
          <idle>-0       [010] d.s2.   154.401481: prepare_playback_urb: prepare: pkt 2 [8]: avail=568, counts=5
          <idle>-0       [010] d.s2.   154.401481: prepare_playback_urb: prepare: pkt 2 [9]: avail=563, counts=6
          <idle>-0       [010] d.s2.   154.401482: prepare_playback_urb: prepare: pkt 2 [10]: avail=557, counts=5
          <idle>-0       [010] d.s2.   154.401482: prepare_playback_urb: prepare: pkt 2 [11]: avail=552, counts=6
          <idle>-0       [010] d.s2.   154.401483: prepare_playback_urb: prepare: pkt 2 [12]: avail=546, counts=5
          <idle>-0       [010] d.s2.   154.401483: prepare_playback_urb: prepare: pkt 2 [13]: avail=541, counts=6
          <idle>-0       [010] d.s2.   154.401484: prepare_playback_urb: prepare: pkt 2 [14]: avail=535, counts=5
          <idle>-0       [010] d.s2.   154.401484: prepare_playback_urb: prepare: pkt 2 [15]: avail=530, counts=6
          <idle>-0       [010] d.s2.   154.401485: prepare_playback_urb: prepare: pkt 2 [16]: avail=524, counts=5
          <idle>-0       [010] d.s2.   154.401486: prepare_playback_urb: prepare: pkt 2 [17]: avail=519, counts=6
          <idle>-0       [010] d.s2.   154.401486: prepare_playback_urb: prepare: pkt 2 [18]: avail=513, counts=5
          <idle>-0       [010] d.s2.   154.401487: prepare_playback_urb: prepare: pkt 2 [19]: avail=508, counts=6
          <idle>-0       [010] d.s2.   154.401488: prepare_playback_urb: prepare: pkt 2 [20]: avail=502, counts=5
          <idle>-0       [010] d.s2.   154.401488: prepare_playback_urb: prepare: pkt 2 [21]: avail=497, counts=6
          <idle>-0       [010] d.s2.   154.401489: prepare_playback_urb: prepare: pkt 2 [22]: avail=491, counts=5
          <idle>-0       [010] d.s2.   154.401489: prepare_playback_urb: prepare: pkt 2 [23]: avail=486, counts=6
          <idle>-0       [010] d.s2.   154.401490: prepare_playback_urb: prepare: pkt 2 [24]: avail=480, counts=5
          <idle>-0       [010] d.s2.   154.401490: prepare_playback_urb: prepare: pkt 2 [25]: avail=475, counts=6
          <idle>-0       [010] d.s2.   154.401491: prepare_playback_urb: prepare: pkt 2 [26]: avail=469, counts=5
          <idle>-0       [010] d.s2.   154.401492: prepare_playback_urb: prepare: pkt 2 [27]: avail=464, counts=6
          <idle>-0       [010] d.s2.   154.401492: prepare_playback_urb: prepare: pkt 2 [28]: avail=458, counts=5
          <idle>-0       [010] d.s2.   154.401493: prepare_playback_urb: prepare: pkt 2 [29]: avail=453, counts=6
          <idle>-0       [010] d.s2.   154.401493: prepare_playback_urb: prepare: pkt 2 [30]: avail=447, counts=5
          <idle>-0       [010] d.s2.   154.401494: prepare_playback_urb: prepare: pkt 2 [31]: avail=442, counts=6
          <idle>-0       [010] d.s2.   154.401494: prepare_playback_urb: prepare: pkt 2 [32]: avail=436, counts=5
          <idle>-0       [010] d.s2.   154.401495: prepare_playback_urb: prepare: pkt 2 [33]: avail=431, counts=6
          <idle>-0       [010] d.s2.   154.401495: prepare_playback_urb: prepare: pkt 2 [34]: avail=425, counts=5
          <idle>-0       [010] d.s2.   154.401496: prepare_playback_urb: prepare: pkt 2 [35]: avail=420, counts=6
          <idle>-0       [010] d.s2.   154.401496: prepare_playback_urb: prepare: pkt 2 [36]: avail=414, counts=5
          <idle>-0       [010] d.s2.   154.401498: urb_ctx_queue_advance: PCM bytes=816, queued=816, inflight=2448, hwptr=14748
          <idle>-0       [010] ..s1.   154.401499: snd_usb_queue_pending_output_urbs: pkt 2 submitted
          <idle>-0       [010] ..s1.   154.406098: snd_complete_urb: pkt complete 0
          <idle>-0       [010] ..s1.   154.406100: push_back_to_ready_list: pkt 0 push back
          <idle>-0       [010] ..s1.   154.406102: snd_usb_queue_pending_output_urbs: checking queue pkt 0 (active_mask=6)
          <idle>-0       [010] d.s2.   154.406104: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=3687, avail=409
          <idle>-0       [010] d.s2.   154.406105: prepare_playback_urb: prepare: pkt 0 [0]: avail=409, counts=6
          <idle>-0       [010] d.s2.   154.406106: prepare_playback_urb: prepare: pkt 0 [1]: avail=403, counts=5
          <idle>-0       [010] d.s2.   154.406106: prepare_playback_urb: prepare: pkt 0 [2]: avail=398, counts=6
          <idle>-0       [010] d.s2.   154.406107: prepare_playback_urb: prepare: pkt 0 [3]: avail=392, counts=5
          <idle>-0       [010] d.s2.   154.406107: prepare_playback_urb: prepare: pkt 0 [4]: avail=387, counts=6
          <idle>-0       [010] d.s2.   154.406108: prepare_playback_urb: prepare: pkt 0 [5]: avail=381, counts=5
          <idle>-0       [010] d.s2.   154.406109: prepare_playback_urb: prepare: pkt 0 [6]: avail=376, counts=6
          <idle>-0       [010] d.s2.   154.406109: prepare_playback_urb: prepare: pkt 0 [7]: avail=370, counts=5
          <idle>-0       [010] d.s2.   154.406110: prepare_playback_urb: prepare: pkt 0 [8]: avail=365, counts=6
          <idle>-0       [010] d.s2.   154.406110: prepare_playback_urb: prepare: pkt 0 [9]: avail=359, counts=5
          <idle>-0       [010] d.s2.   154.406111: prepare_playback_urb: prepare: pkt 0 [10]: avail=354, counts=6
          <idle>-0       [010] d.s2.   154.406111: prepare_playback_urb: prepare: pkt 0 [11]: avail=348, counts=6
          <idle>-0       [010] d.s2.   154.406112: prepare_playback_urb: prepare: pkt 0 [12]: avail=342, counts=5
          <idle>-0       [010] d.s2.   154.406112: prepare_playback_urb: prepare: pkt 0 [13]: avail=337, counts=6
          <idle>-0       [010] d.s2.   154.406113: prepare_playback_urb: prepare: pkt 0 [14]: avail=331, counts=5
          <idle>-0       [010] d.s2.   154.406113: prepare_playback_urb: prepare: pkt 0 [15]: avail=326, counts=6
          <idle>-0       [010] d.s2.   154.406114: prepare_playback_urb: prepare: pkt 0 [16]: avail=320, counts=5
          <idle>-0       [010] d.s2.   154.406114: prepare_playback_urb: prepare: pkt 0 [17]: avail=315, counts=6
          <idle>-0       [010] d.s2.   154.406115: prepare_playback_urb: prepare: pkt 0 [18]: avail=309, counts=5
          <idle>-0       [010] d.s2.   154.406115: prepare_playback_urb: prepare: pkt 0 [19]: avail=304, counts=6
          <idle>-0       [010] d.s2.   154.406116: prepare_playback_urb: prepare: pkt 0 [20]: avail=298, counts=5
          <idle>-0       [010] d.s2.   154.406116: prepare_playback_urb: prepare: pkt 0 [21]: avail=293, counts=6
          <idle>-0       [010] d.s2.   154.406117: prepare_playback_urb: prepare: pkt 0 [22]: avail=287, counts=5
          <idle>-0       [010] d.s2.   154.406117: prepare_playback_urb: prepare: pkt 0 [23]: avail=282, counts=6
          <idle>-0       [010] d.s2.   154.406118: prepare_playback_urb: prepare: pkt 0 [24]: avail=276, counts=5
          <idle>-0       [010] d.s2.   154.406118: prepare_playback_urb: prepare: pkt 0 [25]: avail=271, counts=6
          <idle>-0       [010] d.s2.   154.406119: prepare_playback_urb: prepare: pkt 0 [26]: avail=265, counts=5
          <idle>-0       [010] d.s2.   154.406120: prepare_playback_urb: prepare: pkt 0 [27]: avail=260, counts=6
          <idle>-0       [010] d.s2.   154.406120: prepare_playback_urb: prepare: pkt 0 [28]: avail=254, counts=5
          <idle>-0       [010] d.s2.   154.406121: prepare_playback_urb: prepare: pkt 0 [29]: avail=249, counts=6
          <idle>-0       [010] d.s2.   154.406121: prepare_playback_urb: prepare: pkt 0 [30]: avail=243, counts=5
          <idle>-0       [010] d.s2.   154.406122: prepare_playback_urb: prepare: pkt 0 [31]: avail=238, counts=6
          <idle>-0       [010] d.s2.   154.406122: prepare_playback_urb: prepare: pkt 0 [32]: avail=232, counts=5
          <idle>-0       [010] d.s2.   154.406123: prepare_playback_urb: prepare: pkt 0 [33]: avail=227, counts=6
          <idle>-0       [010] d.s2.   154.406123: prepare_playback_urb: prepare: pkt 0 [34]: avail=221, counts=5
          <idle>-0       [010] d.s2.   154.406124: prepare_playback_urb: prepare: pkt 0 [35]: avail=216, counts=6
          <idle>-0       [010] d.s2.   154.406124: prepare_playback_urb: prepare: pkt 0 [36]: avail=210, counts=5
          <idle>-0       [010] d.s2.   154.406125: prepare_playback_urb: prepare: pkt 0 [37]: avail=205, counts=6
          <idle>-0       [010] d.s2.   154.406126: urb_ctx_queue_advance: PCM bytes=840, queued=840, inflight=2472, hwptr=15588
          <idle>-0       [010] ..s1.   154.406127: snd_usb_queue_pending_output_urbs: pkt 0 submitted
          <idle>-0       [010] ..s1.   154.410652: snd_complete_urb: pkt complete 1
          <idle>-0       [010] ..s1.   154.410655: push_back_to_ready_list: pkt 1 push back
          <idle>-0       [010] ..s1.   154.410657: snd_usb_queue_pending_output_urbs: checking queue pkt 1 (active_mask=5)
          <idle>-0       [010] d.s2.   154.410658: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=3897, avail=199
          <idle>-0       [010] d.s2.   154.410659: prepare_playback_urb: prepare: pkt 1 [0]: avail=199, counts=5
          <idle>-0       [010] d.s2.   154.410660: prepare_playback_urb: prepare: pkt 1 [1]: avail=194, counts=6
          <idle>-0       [010] d.s2.   154.410661: prepare_playback_urb: prepare: pkt 1 [2]: avail=188, counts=5
          <idle>-0       [010] d.s2.   154.410661: prepare_playback_urb: prepare: pkt 1 [3]: avail=183, counts=6
          <idle>-0       [010] d.s2.   154.410662: prepare_playback_urb: prepare: pkt 1 [4]: avail=177, counts=5
          <idle>-0       [010] d.s2.   154.410662: prepare_playback_urb: prepare: pkt 1 [5]: avail=172, counts=6
          <idle>-0       [010] d.s2.   154.410663: prepare_playback_urb: prepare: pkt 1 [6]: avail=166, counts=5
          <idle>-0       [010] d.s2.   154.410663: prepare_playback_urb: prepare: pkt 1 [7]: avail=161, counts=6
          <idle>-0       [010] d.s2.   154.410664: prepare_playback_urb: prepare: pkt 1 [8]: avail=155, counts=5
          <idle>-0       [010] d.s2.   154.410664: prepare_playback_urb: prepare: pkt 1 [9]: avail=150, counts=6
          <idle>-0       [010] d.s2.   154.410665: prepare_playback_urb: prepare: pkt 1 [10]: avail=144, counts=5
          <idle>-0       [010] d.s2.   154.410666: prepare_playback_urb: prepare: pkt 1 [11]: avail=139, counts=6
          <idle>-0       [010] d.s2.   154.410666: prepare_playback_urb: prepare: pkt 1 [12]: avail=133, counts=6
          <idle>-0       [010] d.s2.   154.410667: prepare_playback_urb: prepare: pkt 1 [13]: avail=127, counts=5
          <idle>-0       [010] d.s2.   154.410667: prepare_playback_urb: prepare: pkt 1 [14]: avail=122, counts=6
          <idle>-0       [010] d.s2.   154.410668: prepare_playback_urb: prepare: pkt 1 [15]: avail=116, counts=5
          <idle>-0       [010] d.s2.   154.410668: prepare_playback_urb: prepare: pkt 1 [16]: avail=111, counts=6
          <idle>-0       [010] d.s2.   154.410669: prepare_playback_urb: prepare: pkt 1 [17]: avail=105, counts=5
          <idle>-0       [010] d.s2.   154.410669: prepare_playback_urb: prepare: pkt 1 [18]: avail=100, counts=6
          <idle>-0       [010] d.s2.   154.410670: prepare_playback_urb: prepare: pkt 1 [19]: avail=94, counts=5
          <idle>-0       [010] d.s2.   154.410670: prepare_playback_urb: prepare: pkt 1 [20]: avail=89, counts=6
          <idle>-0       [010] d.s2.   154.410671: prepare_playback_urb: prepare: pkt 1 [21]: avail=83, counts=5
          <idle>-0       [010] d.s2.   154.410671: prepare_playback_urb: prepare: pkt 1 [22]: avail=78, counts=6
          <idle>-0       [010] d.s2.   154.410672: prepare_playback_urb: prepare: pkt 1 [23]: avail=72, counts=5
          <idle>-0       [010] d.s2.   154.410672: prepare_playback_urb: prepare: pkt 1 [24]: avail=67, counts=6
          <idle>-0       [010] d.s2.   154.410673: prepare_playback_urb: prepare: pkt 1 [25]: avail=61, counts=5
          <idle>-0       [010] d.s2.   154.410674: prepare_playback_urb: prepare: pkt 1 [26]: avail=56, counts=6
          <idle>-0       [010] d.s2.   154.410674: prepare_playback_urb: prepare: pkt 1 [27]: avail=50, counts=5
          <idle>-0       [010] d.s2.   154.410675: prepare_playback_urb: prepare: pkt 1 [28]: avail=45, counts=6
          <idle>-0       [010] d.s2.   154.410675: prepare_playback_urb: prepare: pkt 1 [29]: avail=39, counts=5
          <idle>-0       [010] d.s2.   154.410676: prepare_playback_urb: prepare: pkt 1 [30]: avail=34, counts=6
          <idle>-0       [010] d.s2.   154.410676: prepare_playback_urb: prepare: pkt 1 [31]: avail=28, counts=5
          <idle>-0       [010] d.s2.   154.410677: prepare_playback_urb: prepare: pkt 1 [32]: avail=23, counts=6
          <idle>-0       [010] d.s2.   154.410677: prepare_playback_urb: prepare: pkt 1 [33]: avail=17, counts=5
          <idle>-0       [010] d.s2.   154.410678: prepare_playback_urb: prepare: pkt 1 [34]: avail=12, counts=6
          <idle>-0       [010] d.s2.   154.410678: prepare_playback_urb: prepare: pkt 1 [35]: avail=6, counts=5
          <idle>-0       [010] d.s2.   154.410679: prepare_playback_urb: prepare: pkt 1 [36]: avail=1, counts=-11
          <idle>-0       [010] d.s2.   154.410680: urb_ctx_queue_advance: PCM bytes=792, queued=792, inflight=2448, hwptr=16380
          <idle>-0       [010] ..s1.   154.410682: snd_usb_queue_pending_output_urbs: pkt 1 submitted
          <idle>-0       [010] ..s1.   154.415281: snd_complete_urb: pkt complete 2
          <idle>-0       [010] ..s1.   154.415284: push_back_to_ready_list: pkt 2 push back
          <idle>-0       [010] ..s1.   154.415285: snd_usb_queue_pending_output_urbs: checking queue pkt 2 (active_mask=3)
          <idle>-0       [010] d.s2.   154.415287: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=4095, avail=1
          <idle>-0       [010] d.s2.   154.415288: prepare_playback_urb: prepare: pkt 2 [0]: avail=1, counts=-11
          <idle>-0       [010] ..s1.   154.415289: push_back_to_ready_list: pkt 2 push back
          <idle>-0       [010] ..s1.   154.420028: snd_complete_urb: pkt complete 0
          <idle>-0       [010] ..s1.   154.420031: push_back_to_ready_list: pkt 0 push back
          <idle>-0       [010] ..s1.   154.420033: snd_usb_queue_pending_output_urbs: checking queue pkt 2 (active_mask=2)
          <idle>-0       [010] d.s2.   154.420035: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=4095, avail=1
          <idle>-0       [010] d.s2.   154.420036: prepare_playback_urb: prepare: pkt 2 [0]: avail=1, counts=-11
          <idle>-0       [010] ..s1.   154.420036: push_back_to_ready_list: pkt 2 push back
          <idle>-0       [010] ..s1.   154.424609: snd_complete_urb: pkt complete 1
          <idle>-0       [010] ..s1.   154.424612: push_back_to_ready_list: pkt 1 push back
          <idle>-0       [010] ..s1.   154.424614: snd_usb_queue_pending_output_urbs: checking queue pkt 0 (active_mask=0)
          <idle>-0       [010] d.s2.   154.424616: prepare_playback_urb: prepare: applptr=0, hwptr_base=0, buffer=4096, hwptr=4095, avail=1
          <idle>-0       [010] d.s2.   154.424616: prepare_playback_urb: prepare: pkt 0 [0]: avail=1, counts=-11
          <idle>-0       [010] ..s1.   154.424617: push_back_to_ready_list: pkt 0 push back

--x3jrbqd7uw7o7s57--
