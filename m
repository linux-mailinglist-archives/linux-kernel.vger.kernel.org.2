Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529B33534EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhDCR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbhDCR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 13:29:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE21C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 10:29:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i18so3830368wrm.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/pPAPgGU/W0eWYpvJgPXIzYE99umLz25OGAt5xbxQs=;
        b=JKAfyacofh+Xq2PWnCyWh3n6Y17IR6zk01mfjIMKD+KF2E6SEEZQMEo5j7jgdcAhCk
         PVKkSQB17FJXRn+XPUR3CCBZre+UQV57MqLXs+rkgSrqvzy0h7h9xKKU3uuI1xVeQQRD
         4MyBVgQdSUrDJKePvoNx6/MyeUJpigWzmFBiU0SqDydED1Yp7AEIuqW/KpA9sPuF+iw5
         eBh61eClcOLZmGVrGeUq4GQLXZO/aLhL5y7vpOA9d+SZMKLMP5+GpX4I+3zeOzzmRPFJ
         jncd0drftERauuGyOKamg2Ah31A7PBaLW3VSvtt4xkLUICX3C9D+pznFbxXuLYBzBYPc
         1d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/pPAPgGU/W0eWYpvJgPXIzYE99umLz25OGAt5xbxQs=;
        b=io3hVwb6eef7S/Mjl6WxEGrXaIE+M2zTPTgOfbn13464Lqxbjd9k7e7qIQNngbQ/ql
         RPR5lKjlEliWEs7nZMNKjmV+lIze+ZLm3jWEM9HkgGZBJYegEP4fqvshGqf6ON7qusZk
         UE27QlJ7DqIEyy2b67vMhHZM5ACZ6DHXbSeHxUfGNhLhfZQuX5OIM+6vTt6aDhO+mW5L
         qxiuQg5W4ocrFmbyfUFgNfDIMN7v+y15isCqbGOI2GcgN87GpybCWEIJ91NN7ALt+N0X
         gx8kUJCC5vmq1wmOddafwSwg0C1iWOVPaqG753SuoTCe1uFJp5TkdeC+D7t8zZ25IVpF
         lBcw==
X-Gm-Message-State: AOAM53103gsFs37qEst6qRwO4eRgLuSqOevUTEGFeyC1sB+Ei1rymyik
        lq95faUjw3J1q9mj1qzsl0R3GywY6P3+lw==
X-Google-Smtp-Source: ABdhPJyRH/CHvAviZMtvw61sFhJd5FLUaPL92VP/IlkksWvp8fHGVgigRE7F9tOZMTJXyIOM6Kt/bg==
X-Received: by 2002:a5d:4884:: with SMTP id g4mr20849042wrq.191.1617470942295;
        Sat, 03 Apr 2021 10:29:02 -0700 (PDT)
Received: from agape.jhs ([5.171.80.207])
        by smtp.gmail.com with ESMTPSA id a131sm17258422wmc.48.2021.04.03.10.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 10:29:02 -0700 (PDT)
Date:   Sat, 3 Apr 2021 19:28:59 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/30] staging: rtl8723bs: remove RT_TRACE logs in
 core/*
Message-ID: <20210403172858.GA2397@agape.jhs>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
 <1cd79d781cdcccf621ce8e104a9cdf1e90e7f803.camel@perches.com>
 <20210403152143.GA1403@agape.jhs>
 <7120836b08b680d54c15fd89b8630ccc67a53116.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7120836b08b680d54c15fd89b8630ccc67a53116.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 09:17:37AM -0700, Joe Perches wrote:
> On Sat, 2021-04-03 at 17:21 +0200, Fabio Aiuto wrote:
> > On Sat, Apr 03, 2021 at 08:02:25AM -0700, Joe Perches wrote:
> > > On Sat, 2021-04-03 at 11:13 +0200, Fabio Aiuto wrote:
> > > > This patchset removes all RT_TRACE usages in core/ files.
> > > 
> > > and hal and include and os_dep
> > 
> > Hi, 
> > 
> > I was just about to send the second patchset relative to hal/ files.
> > The whole has been split up in directories in order to reduce the
> > number of patch per patchset
> 
> > It's a good idea, but the patches relative to RT_TRACE removal
> > could be huge
> 
> That's really not a significant issue.
> Simplicity in review is also important.
> Mechanization of patch creation can reduce review efforts.

Maybe I wrongly associated simplicity with patch dimensions, but maybe
for patches this simple have expert reviewers some tool for
automatic review?

Is automatic review possible?

> 
> Few people are actively working on this particular codebase.
> As far as I can tell no logical defect is being corrected here.
> None of this is likely to be backported.
> 
> Applying each individual patch has a 'cost' in maintainer time
> and review effort.

got it

> 
> Fewer patches create lower overall costs.
> 
> Good luck...
> 

I like your idea, and sure I will work in that direction,
for this particular case I wait maintainer's opinion. If
patchsets will be rejected again I will apply the scheme you
proposed, if it will be accepted I will apply the scheme for next
patchsets.

Thank you,

fabio 
