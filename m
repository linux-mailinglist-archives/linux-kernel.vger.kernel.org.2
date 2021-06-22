Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6823B0909
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhFVPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhFVPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:30:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8AC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:28:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v13so10613696ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6naUjId2MPUXf6cTMuGYByN115rCcg7ccP8QnKum8Ew=;
        b=YJ1AC7cu/X4ujaY3jY2HE/5JpAhSCr604PlMaBMvTrLnLHWntZvwOYb7muTi/R7nO1
         lzvSPPE+i7S61JTIsIvoBeQfKobwOcBXSxbE+UU4+pNhRm+5Rt+hm8wRBUpYuIo1cXVr
         pMSWazoCDtziI3uo9UBF6UMWK4u913IKo0g03t4EGrLVjUdoHIL515gAToTkeL78/BiS
         OeRqUxDG+9szmy4MtIhnQblPDwb0vjh2AnlUm+uLx5B5LHgArIhf7hreNqnfyI4TyFYv
         GXLPT5yYP7PtHpUqHxwNDfH4fvGOADOHxSAS9WtHDjPPlYEX34t7CDfhtU9M++rQU4Lw
         fxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6naUjId2MPUXf6cTMuGYByN115rCcg7ccP8QnKum8Ew=;
        b=NRWXyc5XLStj1gAby3gvP9mmo+8cKdE2C78SHlJelrzKy9g+1qMA8asMmrXg43R8RU
         RIZU2cyDfOvsiUQZy3XriP3BEUU/oLM6VlYi/4/5JafZUDUrEBFgrm3FyN5nsdeY0Qoe
         rdgt1LWH+/Aa21HXDuqR8UniZF8ZUOqfdK16FHJSGFLz33jY4K1y5ILdZ2cgA4GL2rqD
         3qA623wOSjz8ZzY6vo50L+r6bP5H9VOEslCLODYRvVADUvYMvlco8fJBeFK2YsR9SsNR
         QuFoUY1pJ+lTzX4EpHVw5KMJpeT3GH774he/BGOBj6UpFjnL1SdyRya+7Ymc+iQqxuOB
         GlbA==
X-Gm-Message-State: AOAM532vVnoAiziqa2TvGVTsRGVKeySLq4ACSvWF/gZaaSIBaKvcKMra
        7gOudqsJFS50h+PhRUf59so/G/sKi2IIzm/4p672Sko5LgU=
X-Google-Smtp-Source: ABdhPJyJFNdIUsn58ebOAfsjOjBwKn1nptUhBVpUtgSyItwF3NU9bl4BJY2GejU/Ci9VpCqdzSv7uGPuowJtGLnqqrc=
X-Received: by 2002:a17:90a:af90:: with SMTP id w16mr4579661pjq.129.1624375720972;
 Tue, 22 Jun 2021 08:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net> <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net> <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net> <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
 <YNBsB6zIo4A4vD4w@kuha.fi.intel.com> <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
 <YNGa021IIj+C8H7h@kuha.fi.intel.com> <YNHvZGLE9lgS/FRe@kuha.fi.intel.com>
In-Reply-To: <YNHvZGLE9lgS/FRe@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Jun 2021 18:28:04 +0300
Message-ID: <CAHp75VfB2oa-YKTv9D2e6GEOnSGyUGUdqSi=GLuvL0v6BqPBFg@mail.gmail.com>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 5:10 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Tue, Jun 22, 2021 at 11:09:58AM +0300, Heikki Krogerus wrote:

...

> Before I send the patch to Rafael and Greg, can you confirm that the
> appropriate API (device_is_registered()) also works? I'm attaching
> patch that should be the final version (if it works).
>
> I'm sorry to bother you with this.

In the commit message: happenes -> happens.

And you may replace my Cc to the Reviewed-by tag.

Thanks for your help!

-- 
With Best Regards,
Andy Shevchenko
