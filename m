Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4C3EB6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhHMOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240709AbhHMOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:36:07 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6ACC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:35:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id t13so23207ioj.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YGSv2P9uhaegaKoy56zSI9xp6PeYgFftxKXTpSKVkc=;
        b=m8PQ25rzPzj4Lo4MJw12G/2L9EgadLss8Kg8cfs+Qgf6cDb64+904kl9nflNIWVPMc
         0w9rzXYH2gKNJOa3zNi/thrZtfXy3NdWTBx7sHx257Bq5a9axUho8b3bYmSw1dloyUS8
         f1dihUSLwoNjhmpRO4llmiVRmfG3yKRIMHECs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YGSv2P9uhaegaKoy56zSI9xp6PeYgFftxKXTpSKVkc=;
        b=NM3CMgUE43+10+KiRIsCx/fiiPgnSYIrEFuzLMQy0ChX6+/Xs0M2lEjAI758LXQSm2
         ySmDnsoUK1qo84u2+vL8ReK7Zawf5p4TawRZBqOhbUfAySgVdkOTazWaRxplUSuf2m5u
         yj9mdH9ESejJ2O3v6oINRxf1PlCTmwqypaIFRZrpKR5rqN+dTiknyorU8Ta+gWn3PJb3
         CrnQksBdEK2h93KzjEQtt4VSFD1/XdfzoZgOzpjToFrRyaccnKGpPASSCOaW9iDYvI4p
         rsK+hfD68thyGRsWFd1aCpnUKgp1wiNxX6lK8xqfda0xvsKg9C3YyTORWI660SCcRTJ3
         cjRg==
X-Gm-Message-State: AOAM531Q+85V4qI5PjHTp+vCgAazhi3fg9wdVEovQH5OTLvVTRA6fZc9
        MSLUgsb6r3Nu64nyeeQU38S6lNJoIy1I4Q==
X-Google-Smtp-Source: ABdhPJxpyq9OTFnapU2Z1wK/G+Uq+xnFw4764mG2GnFq4k8IQpI/JOh6Yh9wwI0wGxTkQejfVzjkxw==
X-Received: by 2002:a02:9484:: with SMTP id x4mr1606635jah.68.1628865339349;
        Fri, 13 Aug 2021 07:35:39 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id g19sm983561iow.15.2021.08.13.07.35.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:35:38 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id d22so13536082ioy.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 07:35:38 -0700 (PDT)
X-Received: by 2002:a02:cf18:: with SMTP id q24mr2630664jar.5.1628865337879;
 Fri, 13 Aug 2021 07:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210813121719.70beddf2@canb.auug.org.au>
In-Reply-To: <20210813121719.70beddf2@canb.auug.org.au>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 13 Aug 2021 07:35:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XjSvV8vrs+62ZFTtdWJo44F_Q8WRX75_FydQ70DDS_2g@mail.gmail.com>
Message-ID: <CAD=FV=XjSvV8vrs+62ZFTtdWJo44F_Q8WRX75_FydQ70DDS_2g@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 12, 2021 at 7:17 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the sound-asoc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> sound/soc/codecs/rt5682-i2c.c: In function 'rt5682_i2c_remove':
> sound/soc/codecs/rt5682-i2c.c:297:22: warning: unused variable 'rt5682' [-Wunused-variable]
>   297 |  struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
>       |                      ^~~~~~
>
> Introduced by commit
>
>   772d44526e20 ("ASoC: rt5682: Properly turn off regulators if wrong device ID")

Thanks for the report. Fixed by:

https://lore.kernel.org/r/20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid
