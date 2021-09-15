Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A6940D07C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhIOXyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhIOXyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:54:15 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD59CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:52:55 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id k18-20020a4abd92000000b002915ed21fb8so1487399oop.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7C1wZtgkn98K1s9hJS5xXSJjkhUevEkSW9mrpvuaWm4=;
        b=hLBJGo+pwXj3tiajuAfWSCB3+zZHZaNKghjYaH867FtvJPhgJVpcpJ+L5Mlzuz0kkK
         qaVS6cbiu+CMlkQKHGn9mkrjZ85DjytX6FbMwS9DKiJU0CLOt/8+tEMko/UZNQqsFWWM
         pa80EEoihsx4Gjde2/+il8a63TUAD8b4obWcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7C1wZtgkn98K1s9hJS5xXSJjkhUevEkSW9mrpvuaWm4=;
        b=M5YGGHxWSE4vwsj0eW7WzLAP1LxF29o2KIE2eUu6oZvhc98iTqLl6eU5lyShLbGcIu
         dF4y+AFfxgsTAkFoypBkP1X0810/PumxfRxPfEbGJAkAkcFO+pstWyTttg8DptCjn+B+
         QPBcEWl+FNJ6aXxKjagze1bATzYfefOuXHQhz+s2wK4z1MqaMPlYc9KXfDXbfPHRu/az
         ZtvLolFZMYEWsQLXvYYRqisena/K8T2+CGRTCCFLmVsqkK5uy+Oo7OPX7n+EIF9Bj++C
         9tJYIUQtOq/EHsK+8XdDcod3PPyQuGxWK6v2k/cdy9RYNFsAkLiTKbdy4CksTVWE5T01
         jHaA==
X-Gm-Message-State: AOAM533XHjGNApUs0APXDt7TLZwEK0uFjmYNYxcg6/Dh7EbS7v/4fIaj
        VkmW8qQ0VunoTuvvtdzGU4hPAnBKaX/sqA==
X-Google-Smtp-Source: ABdhPJyTm4VTa48YR1fqqrAOavmGduLom2q9/QK5jfj8OoIfWIVar/RDwo0XP2JjLbMUfo2PDEOF2g==
X-Received: by 2002:a4a:3e58:: with SMTP id t85mr2069779oot.81.1631749974573;
        Wed, 15 Sep 2021 16:52:54 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id bh25sm422442oib.40.2021.09.15.16.52.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 16:52:54 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id j66so6543158oih.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:52:53 -0700 (PDT)
X-Received: by 2002:a05:6808:1892:: with SMTP id bi18mr6905790oib.105.1631749973525;
 Wed, 15 Sep 2021 16:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210903182839.1.I20856983f2841b78936134dcf9cdf6ecafe632b9@changeid>
 <CA+ASDXPC7M-5zYms=bop6=qnWigKHm_P+8ErzfqwFEc91LRV4Q@mail.gmail.com>
In-Reply-To: <CA+ASDXPC7M-5zYms=bop6=qnWigKHm_P+8ErzfqwFEc91LRV4Q@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 15 Sep 2021 16:52:42 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPhJGNdS-f+r+haLgAQqmBrF6u9rzcmVZ3pgh9UHxU5zQ@mail.gmail.com>
Message-ID: <CA+ASDXPhJGNdS-f+r+haLgAQqmBrF6u9rzcmVZ3pgh9UHxU5zQ@mail.gmail.com>
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

On Wed, Sep 15, 2021 at 4:41 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Fri, Sep 3, 2021 at 6:29 PM Brian Norris <briannorris@chromium.org> wrote:
> > --- a/drivers/hwtracing/coresight/Kconfig
> > +++ b/drivers/hwtracing/coresight/Kconfig
> > @@ -150,6 +150,19 @@ config CORESIGHT_CPU_DEBUG
>
> > +config CORESIGHT_CPU_DEBUG_DEFAULT_ON
> > +       bool "Enable CoreSight CPU Debug by default
>
> ^^ Eek, I failed to terminate this string, and kbuild is even warning about it:
>
> drivers/hwtracing/coresight/Kconfig:145:warning: multi-line strings
> not supported
>
> Sorry about that; I can submit a v2 if you'd like, or feel free to fix
> up my mistake when you apply it.

And I see you already fixed it -- should've checked before posting:

https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/commit/?id=616ac6902c982f03da9d0b1e4f845df0980d055d
[Fixed missing double quote in Kconfig title]

Thanks,
Brian
