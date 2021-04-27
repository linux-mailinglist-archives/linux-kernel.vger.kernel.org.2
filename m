Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4836C52B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhD0Lej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhD0Leh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:34:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:33:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q9so4947329wrs.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=NILGFNTQTHr+s2XX/khm6R44dEEBWTF4JMVNpWszCpw=;
        b=mgQK1UKys7c/CR7IlmkslGjxU+v65W7xorF9mhuWXeLOgX8y59vj5aqkHcEvwZUtk+
         0QEUD+IFA3OK6vexGOu9Q5sMC2MLDe1m7RbUsY/zQ4WAk4rHlOsDdr0ElagFLm3hvNi0
         x2Ve6B4SAmAgpDEfzRGRaezxRpqUOwkK2SM/PowJxnEpc3HDNEs5Z/QXVklsAE90mEcu
         AJrgFws5f8azx3GtcMQX2i25x2pKdxIsIxAeHz4b0vvRnI0YoFLWhUyfWZbUS489+PY1
         Ftq2K3YndhBhZn/GE+Olzd68yC5zMJxC//4pcOF7+EGLADwZhIS8SHFVl8sHu8lQTQoN
         nIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=NILGFNTQTHr+s2XX/khm6R44dEEBWTF4JMVNpWszCpw=;
        b=RuPK82PEE8BF6Ygxpt+PX3JMEfFgUauvs2S8mt45YQGIotmzZ6OGJJHIXGj+GbhzGr
         GkitL10iQlcuZ0nn1tE6lvmpoO9SUEL5eTTK7JnUMugo7zJFyWJXJc3d/yaBV8/zGhNs
         6LJR0bVZECQQkIv8k82mYPYBGC1ZEDU/WR98BoikkH5pRHOJ1rwIGmMpIBk3bCtew2DI
         8yjZ9EyapXMjzTEnYMQo/n8MxAW7gMMMm0DQVtE8XqrnhnyRODwym+1T6cPOQMXq9EDB
         tTDMCPh9ySKrybtT1bYAmBzuqtpiRBLuYMg+qEdjdxZT8CIiQYdOSjKdvPVlqLUy1fVo
         25ZA==
X-Gm-Message-State: AOAM530VYhoNMGKN1N1GqqmzXnMM+l6AG58/hS1UAH4mYgO10VQ75lxl
        Pi1r66tHJC0KRrzjqv+ce/iivg==
X-Google-Smtp-Source: ABdhPJxA5Iot94vDDBN7Sbie44++7Hv5kGSYXsGnyBGRKKU9id3d4U3JbhOg060c3YWzvw6vId1sNQ==
X-Received: by 2002:adf:e412:: with SMTP id g18mr16024362wrm.205.1619523231717;
        Tue, 27 Apr 2021 04:33:51 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id f6sm71130wru.72.2021.04.27.04.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:33:51 -0700 (PDT)
References: <20210421120512.413057-1-jbrunet@baylibre.com>
 <20210421120512.413057-6-jbrunet@baylibre.com>
 <69eaa840-ed77-fc01-2925-7e5e9998e80f@linux.intel.com>
 <1j7dkon8jy.fsf@starbuckisacylon.baylibre.com>
 <1jim48jdee.fsf@starbuckisacylon.baylibre.com>
 <20210427102711.GB4605@sirena.org.uk>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ASoC: da7219: properly get clk from the provider
In-reply-to: <20210427102711.GB4605@sirena.org.uk>
Message-ID: <1jfszcj71d.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 27 Apr 2021 13:33:50 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 27 Apr 2021 at 12:27, Mark Brown <broonie@kernel.org> wrote:

> On Tue, Apr 27, 2021 at 11:16:25AM +0200, Jerome Brunet wrote:
>
>> Mark, at this point I think it would be best to revert patches 1 and 5
>> while we work this out in CCF. The other patches are not affected.
>> Sorry for the mess.
>
> Sure, can someone send a patch with a changelog explaining the issue
> please?

Will do
