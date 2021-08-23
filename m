Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE43F4329
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 03:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhHWBpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 21:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhHWBpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 21:45:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2DBC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:44:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso17376261ota.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 18:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjgeU9TRFij/6WfRHFGF+/ushS1etizwrqPfiLC/p5g=;
        b=CIVs7z3kmbGezQ+HLK8wPgicFeCXunZu3npE/L3PZ1sdUrQFaT+zNf2xeRhLHEYSwu
         IgUKTW0s/3uOCa6BhHgsUhKvCli+SqEzIYI4/QMRnc9+4e9LwMgXbyCWNJAa+KwGyezJ
         AAKWiVG9x5N2hrVUQbK0EYxLcbl1LDWPEu1kty+AwxeKYZ4zCNMeYw28X7CoLLGGKIkN
         NLJLbIceEX/4fB0xEFlnqPAfjcKn5v3olQSAlJk5uOLjrUsRF0ZWvt5fGF4LTsukHUWf
         /HKAGIC7b6+lJNbfrVSjd6wjeDVL5QWVPJsNZdUQ1UuDrr/qlLdhA3WzaRz1pWus6Res
         ucRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LjgeU9TRFij/6WfRHFGF+/ushS1etizwrqPfiLC/p5g=;
        b=G5MQD9Q/R/cdzmMgh8b1nxSfTWcT+r3HOYsfh+36zihB/AebEwnKgZLJ4UtWLUMf86
         RT4tON0/jaaJD1hn9wyMRN+Fffye45HcTvE1D8ljUtFfF6agyKQO0UmLRDrlVsTQz+uZ
         Aix0y1Vz6ZGPjSYfXOkYFgpk47c2qgUcr/QCNWAQPOI/f/8yUag9jgicqMozzp4KS5fJ
         3ZCM8XolbX5rCLs+OpBFoasH/VHQuZQJDfrYJ6E9NFNgjA8SPQAOAmKd3QLMK9IHgYUU
         qh0DBz0xePLY+Yoey5JyhsfAsVSaBZBR04MCWJArd2KYolYYQxgaXjqTq3P5e72XFMpn
         YLSQ==
X-Gm-Message-State: AOAM533v2cdx6umZuitmGT+FRYh762QNrJuKQTUC6NgMIcLU3YNHzIEa
        VfLrKOqhTBThZOlJRhzqTrDDX9k53qs=
X-Google-Smtp-Source: ABdhPJxNCxgsEspo+z5suEd0Ysi3GK4lMNqFY9TG61WlMY29hI/fh1VR6x1WQ9+59XeAZC2klkjXrw==
X-Received: by 2002:a05:6830:241d:: with SMTP id j29mr25577744ots.47.1629683097283;
        Sun, 22 Aug 2021 18:44:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9sm1163426oie.20.2021.08.22.18.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 18:44:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 22 Aug 2021 18:44:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.14-rc7
Message-ID: <20210823014455.GA1133377@roeck-us.net>
References: <CAHk-=wgZ_W7ZF84Mtq6KRjF4FEoYh14dnw+Oc0avZz_6WrCkfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZ_W7ZF84Mtq6KRjF4FEoYh14dnw+Oc0avZz_6WrCkfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 02:35:38PM -0700, Linus Torvalds wrote:
> So things continue to look normal, and unless there is any last-minute
> panic this upcoming week, this is likely the last rc before a final
> 5.14. Much of the discussion I saw last week was about things slated
> for the next merge window, and nothing in here looks particularly
> strange or scary.
> 
> Most of the changes here are drivers (GPU and networking stand out),
> and the rest is pretty random stuff: arch, tracing, core networking, a
> couple of VM fixes..
> 
> So please give this all some final testing to make sure we're all
> ready for the release,
> 

Nothing left to report from my side.

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 479 pass: 479 fail: 0

Guenter
