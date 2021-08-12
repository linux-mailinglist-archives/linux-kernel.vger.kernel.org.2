Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF53EA4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbhHLMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhHLMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:52:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C668DC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 05:52:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q3so5409764edt.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hW2AHW2LGJWIg3Oz36vt6ea6Y6cYNr8cSKGnKNQkhWE=;
        b=e/T/nmC7+7cvdq1AUguADrAErXb0ShX24hCl6Rw6/nVVl+VEsZkw2cFfWVHWvhaXkf
         GOK2hW+hF689McaSUc1xPbQWNwrSKVPud1zyd1xNOSDvrFYFUEP6HhJMEVCi/03HQ3EA
         WtvK9SC5NU+mu6BkA8LG3WOIzf0ToTVXX8SwsZlZCnCGNMHzfQrQaX8/u9OYVPU4wbfh
         Mcd8kJ6q6vjr9U66i9JQFwihEF+BaClrepaw8VmdhO0f/Yp0xkpetNc0cP3AoIexmjyA
         heIDosxNKfXa5zE1C5/uAMIZjG3O5oka/fhzJdf2HZV4vSJzXe6HLTiy7qxAjbPUw3tD
         RokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hW2AHW2LGJWIg3Oz36vt6ea6Y6cYNr8cSKGnKNQkhWE=;
        b=MTaVk5ESuE/EA1kdE3UIlPpq/yhIwC+njOyP+YAwjRMhhVZe4hfyN/bXjAGNtljm0G
         kilNZ0HzVdL36ChP8Hu24zWBFsbyZg6pQhOcrj59ystmlJ7mFuKZzxB8X9esGnIObAfp
         bIX3pOFfeH9KIMVM6ymrhIL4Zcz8UOe+5A/vmLBx0TvmQvFOs5d7Hbtq96/1O7LzhxHu
         79ik+xwT/BKvJpG0V5r9N8jtKIunmXdgqzbUTrmara1EgSYgnYDkCgT6JOiPlCiI2AWD
         4IkAfbPG+R67qfPmmNygXDgIW97iVOl7ONd/P/ZNdVhkTC6VwaeZolkjjEyxXqM+v3DS
         nzLA==
X-Gm-Message-State: AOAM5309EL/+BHu+e6Rb8+2QoHmQ9OLtxUe1+BWyENfrK1Q4ln2ly4RT
        ljAPrjZdxPMWPOuMNEY1gRs=
X-Google-Smtp-Source: ABdhPJx8r3AQYyHckN9/UA3uF3NV/MJLpkO8leO/8z2J/VxO8fU+Qz57FFO3S2Rv3+u0ll3GAnqBaA==
X-Received: by 2002:aa7:c4d4:: with SMTP id p20mr5307552edr.382.1628772733392;
        Thu, 12 Aug 2021 05:52:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id w5sm791941ejz.25.2021.08.12.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 05:52:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: r8188eu: Remove all 5GHz network types
Date:   Thu, 12 Aug 2021 14:52:11 +0200
Message-ID: <271471387.QXUees3VCy@localhost.localdomain>
In-Reply-To: <13cdcd41-20f6-3b8e-0515-5066b1fdb49c@lwfinger.net>
References: <20210812002519.23678-1-fmdefrancesco@gmail.com> <20210812002519.23678-2-fmdefrancesco@gmail.com> <13cdcd41-20f6-3b8e-0515-5066b1fdb49c@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 12, 2021 4:09:49 AM CEST Larry Finger wrote:
> On 8/11/21 7:25 PM, Fabio M. De Francesco wrote:
> > Remove all 5Ghz network types. r8188eu works on
> > 802.11bgn standards and on 2.4Ghz band.
> > 
> > Signed-off-by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
> > ---
> > 
> >   drivers/staging/r8188eu/core/rtw_ap.c         | 13 ++---------
> >   drivers/staging/r8188eu/core/rtw_ieee80211.c  | 19 +++------------
> >   drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  2 +-
> >   drivers/staging/r8188eu/core/rtw_mlme.c       | 10 --------
> >   drivers/staging/r8188eu/core/rtw_p2p.c        |  2 +-
> >   drivers/staging/r8188eu/core/rtw_wlan_util.c  | 15 ++----------
> >   drivers/staging/r8188eu/hal/odm.c             |  1 -
> >   drivers/staging/r8188eu/include/ieee80211.h   | 23 ++-----------------
> >   drivers/staging/r8188eu/include/wifi.h        |  2 +-
> >   drivers/staging/r8188eu/include/wlan_bssdef.h |  2 +-
> >   10 files changed, 13 insertions(+), 76 deletions(-)
> 
> Fabio,
> 
> This patch is fine, but it does conflict with my series fixing the smatch
> warnings. Whichever set Greg takes first will apply cleanly, but the second 
will
> fail. This problem is due to many people working at the same time.
> 
Hi Larry,

The Wizard of Git :-) (Greg, of course) has been able to work this problem out 
and took both series, as you probably already know.

Just kidding... However, you may be interested to know that, most of the 
times, the above-mentioned conflict can be worked out by using the 3-way merge 
option of git-am (https://en.wikipedia.org/wiki/Merge_(version_control)#Three-way_merge). I suppose that he used that option to resolve the conflict (am I 
missing something?).

> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks for looking at my patches and acking them.

Fabio
> 
> Larry




