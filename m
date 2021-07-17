Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04D13CC681
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 23:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhGQVqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhGQVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 17:45:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5928C061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 14:43:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u25so19262912ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mLF1skfBW0gvZzwCxxdZix3vRJTMSgcW19qrBGOZZk4=;
        b=s6YxieFcHITLcNkgs55oloVrenVVGve4xWor4pMaf2xcH98EABDBeLg26f185GC4Ai
         TDphri0bmhs4vHW+MGtkR2NisqRq2eMW1FiUajdocTV3Awc8NVLB298x8INDjwzRkMW5
         PpkaHlPHnPsuxqUPJzHC2L04F1XEGkgd/EtJzGcqBwMC0qghyc+in/xWMD3o0OhUajva
         0yFnhgbYkHPXlAsN1JDTskF4gKjHoskihFYlElvn9ECsKm29hIZCoNXrHtJaEvYjZP/5
         AYmDd3ivFALcl40qH7XxrUy+cfn1jxO90BXOs5+0pteITwBy5yEUWQjk8uqae3UKKqiu
         DAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLF1skfBW0gvZzwCxxdZix3vRJTMSgcW19qrBGOZZk4=;
        b=nvffHnth+qZg8hHK86Q9qRasA4akieEAHGLXBrGQ2RAbmppiOotBQr8iQKtn9lsM9w
         E98XdcLR9htgOEpuSP1qY64ho+hoOuWriZcYG+I2/x0ZUynXNEnuQBQcxw7Yd5N5X8J0
         yJMLKlP8LURTYbim6gbDR7U1lg/JoPUoF1nTLgYFv/j3MBkCzSkMRbeDzMYg3TxwpLnt
         rTFXN1ZtZf2gAoeBhA0+KPRY1cmwXqMt3pnC3HGqyZ3NK9RvRjNE6FhY/0CUahO7YFvf
         3b0R8BFHtcMRYPvwaVuBqxZBs3Ge6JX/JQy9JdzWCge4CSYgOz8Pg2Vi2KSju13aQZvt
         ZVuQ==
X-Gm-Message-State: AOAM533GiyRNOXTjVG3XHGiMs17QJo7UpvJInXifOAaAe8uErxYWNw7o
        VK4wb+4xlT8MUpD93x9q1I6RHA==
X-Google-Smtp-Source: ABdhPJz5aT4S0NpwIXlVRfFVKwWedsyH3dqoJ+sg2ZNoSyV4AActMHx1Uix1R+SNJutxZpO7+Ggt/A==
X-Received: by 2002:a2e:743:: with SMTP id i3mr15614690ljd.266.1626558180199;
        Sat, 17 Jul 2021 14:43:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f9sm1469830ljf.73.2021.07.17.14.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 14:42:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A9F591028D4; Sun, 18 Jul 2021 00:43:02 +0300 (+03)
Date:   Sun, 18 Jul 2021 00:43:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [git pull] drm fixes for 5.14-rc2
Message-ID: <20210717214302.mpfil765uji5dnb7@box.shutemov.name>
References: <CAPM=9tzb9KSspAtVkSH3pYN97hQ815MoOBTSiuHzUJnnb2fhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzb9KSspAtVkSH3pYN97hQ815MoOBTSiuHzUJnnb2fhRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 01:41:18PM +1000, Dave Airlie wrote:
> Hi Linus,
> 
> Regular rc2 fixes though a bit more than usual at rc2 stage, people
> must have been testing early or else some fixes from last week got a
> bit laggy. There is one larger change in the amd fixes to amalgamate
> some power management code on the newer chips with the code from the
> older chips, it should only affects chips where support was introduced
> in rc1 and it should make future fixes easier to maintain probably a
> good idea to merge it now. Otherwise it's mostly fixes across the
> board.
> 
> Dave.
> 
> drm-fixes-2021-07-16:
> drm fixes for 5.14-rc2

Dave, Daniel,

Looks like the fix[1] for nouveau regression[2] is missing. Hm?

[1] https://lore.kernel.org/nouveau/20210609172902.1937-1-christian.koenig@amd.com/
[2] https://lore.kernel.org/lkml/YOC4uekpD7iA3xPi@Red/T/#u

-- 
 Kirill A. Shutemov
