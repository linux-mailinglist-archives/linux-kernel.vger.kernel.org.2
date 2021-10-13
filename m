Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888EE42BC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhJMKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:03:24 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56946
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237931AbhJMKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:03:23 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 696A940010
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634119279;
        bh=72qIwnXVGNrfKxhLObQPGF0RNQPHhrmziNaYX8Pmn6k=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=W4+p2OYgCnWCzp8aAIalzoSBu4LQMSeusJYU5/m7shf8Au032jSENO/pDUEH0vPrN
         zOzb2njlwuPQ1MdaGrmQqbxde40wkpz+IgWT5kZVurmGy6Sw2sOI0BiCludijQ1wr7
         MVS5dLAg5dzagVNWzv9wpR1mQdR+UZ+RfnMaTJiEt5EEJn6Q6YK+iOXHB9He6FshSE
         6/3KFxt4MpdrDcYFVchDcfwEeRtsFFf19w9SItEwNbqDX888UPFtbY5vpxK5PqsmGq
         rLLBrkWeurvSRcq26GQlGyCzqusl1HytgKAXVZcPDSqV4OQ70WJ07FqhW5Ef3FVIzt
         uNpaEW2ycZzlA==
Received: by mail-oi1-f200.google.com with SMTP id m5-20020a05680806c500b00276dd287318so1392755oih.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=72qIwnXVGNrfKxhLObQPGF0RNQPHhrmziNaYX8Pmn6k=;
        b=p89Ty8dqPwijhCdfJMLip04EdAgihNrBi90usS9MztOMLyKG+V3yq19qcIAwmya0FO
         sS6Pz2K87JxHuTMRmd89V6OewotSWhPPTIUzhkxgmD/cVwPhe3bsyBCeM+D1wEUunCKd
         BwAFY8fF/2C/ntlPezNx5JVMM4zBW7YnrV5P/x6dKjXqE2JrkWZDgilOyljW8Cnx3+qY
         54lcPwz+BTnZWRIMEp5I7vOAQ+ncWw6cPwW9N/v7BV1rOZY/djSikk8hgikUHnyk0dbo
         Uk6qJO5+rt0H3e5EfhpxMLsDwPSiyad71iEG0TUFeQsFfUG2SV8TWhETjLpuAhBjEeaY
         oKug==
X-Gm-Message-State: AOAM53010PHf4EpKNPi/0MI/K/jdeZBS85ENhyaWNIqGMXm+5RYJE13S
        vpN0915oq8/9SN3M0ujFYvcXHhZIg2YprprM4zNOylrCNyjnOJVOwcirI6ojCJXtWMMCxNjvkr/
        W1P/8XvIRBp/qTkZ1HQCYCODkBvRUJOYoFmQoOgFuxd5M06sYjZ8IOVjwzg==
X-Received: by 2002:a9d:4586:: with SMTP id x6mr4832648ote.155.1634119278308;
        Wed, 13 Oct 2021 03:01:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRbNoT+5vjBaO6avzuE4+i7alOLMD7HAQHPzEjaJby9bEFhDVvy6NozAELmsBiJGECEiNH0ZW4yOwsGiLBpew=
X-Received: by 2002:a9d:4586:: with SMTP id x6mr4832615ote.155.1634119278015;
 Wed, 13 Oct 2021 03:01:18 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 13 Oct 2021 18:01:07 +0800
Message-ID: <CABTNMG2ipP4m4T084QRrHMLL_cGfyVdb_dBNf_E8pruMSDRHJQ@mail.gmail.com>
Subject: The default jack detection type overridden by sof_sdw_quirk
To:     pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
        rander.wang@linux.intel.com, yung-chuan.liao@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com
Cc:     alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I have an Intel AlderLake machine which uses the sof-soundwire
driver for audio functions. When the headset is plugged in, it will
incorrectly trigger the event KEY_PLAYPAUSE and never stops. To fix
the problem, I used to apply the quirk RT711_JD2 proposed in
sound/soc/intel/boards/sof_sdw.c and the jack detect function will
work as expected.
    However, when I look into the code of sound/soc/codecs/rt711.c and
rt711-sdca.c, the default value for jd_src
(https://github.com/torvalds/linux/blob/master/sound/soc/codecs/rt711.c#L1209)
 is already RT711_JD2, which means it is overridden by other drivers.
After digging deeper, the jd_src value is overridden by
rt711_add_codec_device_props() with the value RT711_JD1 comes from
sof_sdw_quirk.
    Is there any reason why sof_sdw_quirk is assigned with RT711_JD1
by default? Can I simply fix it by assigning the sof_sdw_quirk to
RT711_JD_NULL as follows?
-unsigned long sof_sdw_quirk = RT711_JD1;
+unsigned long sof_sdw_quirk = RT711_JD_NULL;

    Please let me know if there's any potential problem I didn't
notice and suggest if there's any better solution. Thanks

Chris
