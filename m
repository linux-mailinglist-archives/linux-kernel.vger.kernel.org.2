Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2940D04B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhIOXmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhIOXmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:42:51 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:41:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id n2-20020a9d6f02000000b0054455dae485so727514otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbt5QeJWroHF/eXPOUdEJBw4ZMLQs9gYL9GoKdDe+UU=;
        b=oaseJWfWB+M/gQYfqHjmhnJbUq/nwW/pZLp/NZkNxgedEGyLX/G+dQdYt7VnVjseuz
         3Toq5cRvHpFHHfhPopEq+p0bA9UuViyl7QpSnzr8LLRKmz2LwKbTveMzat2FnjU1iCWA
         29WJvgwxvxDGxpeqCjD+CtfF7PkffYzzICEB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbt5QeJWroHF/eXPOUdEJBw4ZMLQs9gYL9GoKdDe+UU=;
        b=d66YoerYXW+jYo8ehiIGEWu/jY6lxN5jVExHnVrzklwjWRix3G4zbMUHVrWoeD+/6i
         qZriCSGsk9cic/IyZ2p6mMPy72/y2mobodd2Ew/EwYJyNCSAKNDcP+Gl+3+ceuzIuNL/
         3brGf/BvJvxK9A9JJj1D1F5QH+jEEgI5ZHYkBOZKUKKzi4UUsvDs46NoNzI+0JP1B4f/
         PN8rEtlxJU5MFWGH9c4rGaTP5d7G85MAH3yF79E3RNkuexxO/nsXleFT2dN3vhSQcB5t
         IgImnVaBtgtEuY09glpgvxo/WfbRjE0iVQQPNc+nMk5YvMJmrnopv0rNME/F/GI+ufcg
         fjng==
X-Gm-Message-State: AOAM532sl7Rkgk7KUibo7vuHK0+W/IdDuDs2LsBSkaQO2fXuW67AsMZr
        zxU0w/EpnAQx5e9637uAlfFlEMxn5fXX/w==
X-Google-Smtp-Source: ABdhPJzWEWv4Yc6Nh2e94Io7m9kd00/xDIBVkIZa+NJBpX/LvmjSu48fHxG1S1fkyTBh3lb2PGmJ2w==
X-Received: by 2002:a9d:7416:: with SMTP id n22mr2364660otk.309.1631749290785;
        Wed, 15 Sep 2021 16:41:30 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id g2sm133404otp.7.2021.09.15.16.41.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 16:41:29 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso5967849ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:41:29 -0700 (PDT)
X-Received: by 2002:a9d:7483:: with SMTP id t3mr2305334otk.3.1631749289228;
 Wed, 15 Sep 2021 16:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210903182839.1.I20856983f2841b78936134dcf9cdf6ecafe632b9@changeid>
In-Reply-To: <20210903182839.1.I20856983f2841b78936134dcf9cdf6ecafe632b9@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 15 Sep 2021 16:41:18 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPC7M-5zYms=bop6=qnWigKHm_P+8ErzfqwFEc91LRV4Q@mail.gmail.com>
Message-ID: <CA+ASDXPC7M-5zYms=bop6=qnWigKHm_P+8ErzfqwFEc91LRV4Q@mail.gmail.com>
Subject: Re: [PATCH] coresight: cpu-debug: control default behavior via Kconfig
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 6:29 PM Brian Norris <briannorris@chromium.org> wrote:
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -150,6 +150,19 @@ config CORESIGHT_CPU_DEBUG

> +config CORESIGHT_CPU_DEBUG_DEFAULT_ON
> +       bool "Enable CoreSight CPU Debug by default

^^ Eek, I failed to terminate this string, and kbuild is even warning about it:

drivers/hwtracing/coresight/Kconfig:145:warning: multi-line strings
not supported

Sorry about that; I can submit a v2 if you'd like, or feel free to fix
up my mistake when you apply it.

Sorry,
Brian
