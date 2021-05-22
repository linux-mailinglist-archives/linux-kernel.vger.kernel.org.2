Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3147138D4CD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhEVJhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhEVJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:37:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CF6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 02:36:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11so12231819pjm.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jw5wI2CtBuQpPL0rk8AvkdZs5+SsBTEiYW7PK+KIv7M=;
        b=JJAVaVV8sFuPv+bfBqkpTzrdKfnmhlX4xlqfSprwIPTdCF9PSs12raKxz6tx/o0OeH
         TFwqWcz4DFGMX/hm2elK6WrnGGAtlVDlr+3vyZsVzi/fc0oCDvA8AklA1mv47peVSLBj
         aUJ4L01UOkh7oZWEg8+GkIriKy/i+X1h66WmxH7upPAUUAGx5SPsVnTaa0i5bIkoAh+T
         hn2BYec75/brlLZZKnspO4V71b9sAcRvVATtrFLtnIgL4PgkUYkUBgxnOVZ0HULG0X79
         bzY91oB3fq+Im7LCoK9t8P449h7pitZ01WI4ydxllHLtJbgyJGWCWGoFzxkXLU/raKOs
         xC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jw5wI2CtBuQpPL0rk8AvkdZs5+SsBTEiYW7PK+KIv7M=;
        b=Nu574lgoIJoWqbm9W1j8edEyiSULDZoSpcAc65HbP3Oz9AWmE7JWqOueXuzBwGsX40
         dssgeR6LzyOlKjnq7cEzBwdpkEynDUILAnD+PKiO2auRNtap302VzL677jL27uMyXBxj
         tKUA3tF6OfcPOkLJcMOYk9I7I+y13wDgJ+TUBYo5Ad0acBc4mBJnzdgZIoxCwLs4fMZg
         zs6vGK7/8fIzeFC8frJqjSev8Gdhy2OdKwU/isBLT5hmXOCcSckzVXrYlr63UlZHiGg4
         WWzEJFWbufH8aJW2hjUzRMC/bQIxxqUZHvbMWErmBBbPy6n+nlLO2kXr8sTTKD1j8HKt
         6ERA==
X-Gm-Message-State: AOAM533qmaFk/01DkAb8ecfLoi9/3SkOybVhTRlSAX6Il6NhhSGB4l8j
        bDUtsamD0uAX3vLsRk1Uknv6DV+A4AA2nA==
X-Google-Smtp-Source: ABdhPJzakmGjbjjwFSgaxMnbZdRP5Rp19c4vvN3SrrbpPi+bM/ZvXWDlKWl2ttlGTrDPIxpvztz8lQ==
X-Received: by 2002:a17:90a:7306:: with SMTP id m6mr15379236pjk.217.1621676183955;
        Sat, 22 May 2021 02:36:23 -0700 (PDT)
Received: from fedora ([2405:201:6000:a04d:2131:362f:d566:c9d5])
        by smtp.gmail.com with ESMTPSA id g13sm6541406pfi.18.2021.05.22.02.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 02:36:23 -0700 (PDT)
Date:   Sat, 22 May 2021 15:06:18 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Resend] [PATCH 1/2] [RFC] staging: rtl8723bs: refactor to
 reduce indents
Message-ID: <YKjQkrb8Haky5UXk@fedora>
References: <20210522092024.65018-1-chouhan.shreyansh630@gmail.com>
 <20210522092024.65018-2-chouhan.shreyansh630@gmail.com>
 <YKjOWtwarhM99dXc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKjOWtwarhM99dXc@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 11:26:50AM +0200, Greg KH wrote:
> On Sat, May 22, 2021 at 02:50:23PM +0530, Shreyansh Chouhan wrote:
> > Reduce the number of indents in rtw_wlan_util.c file by refactoring the
> > code.
> > 
> > Moved the part of code that rearranged ac paramaters in the function
> > WMMOnAssocResp to a separate function named sort_wmm_ac_params. It takes
> > both the array of ac params and their indexes as arguments and sorts them.
> > Has return type void.
> > 
> > Moved the part of code that checked for the realtek vendor in the
> > function check_assoc_AP to a separate function named
> > get_realtek_assoc_AP_vender. It takes a pointer to struct
> > ndis_80211_var_ie as an argument and returns a u32 realtek vendor.
> > 
> > Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> > ---
> >  .../staging/rtl8723bs/core/rtw_wlan_util.c    | 108 +++++++++---------
> >  1 file changed, 56 insertions(+), 52 deletions(-)
> 
> Why is [RFC] in the subject line?  Do you not want these merged?
> 

No, since I wanted to ask about the names of these functions I sent
these patches as RFC. If these names are fine, I'll send another patch
series with a couple of patches besides these that fix other much simpler
coding style issues in the same file.

> confused,
> 

I hope this clears the confusion caused.

> greg k-h

thanks,
--Shreyansh
