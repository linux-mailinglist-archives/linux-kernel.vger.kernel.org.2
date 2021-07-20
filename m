Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B163CF69D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhGTI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhGTIVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:21:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4890EC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 02:00:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t3so27511091edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RnsSk0IgGqobCFjh6CXIgOm+uV9hEt1QtilnTcttZyE=;
        b=an9esNH1MdcspqVlJT2+7qtVubv9TwaxW5wbCpdg28PCMLm8odmj/YPDk22ynQgcIK
         zCsjj7iLHt4FOSiVvux7xroXdvCETk2lKDvQ25cSx/AE//3D1ewYmi9ZjLX/PluWyzM+
         fKaTvYk33nKY9VMosPwoHUGmH30PLJWSJxouh3I//Q9gSLCe4i8opSufnZJT3UW5tDw7
         NY/CYJhQ8YUfnltpOCgRKH0i3tCjVsFInvgu0GdfGbEM9XaeBRNZrJ5n//18CdabzcSN
         pukTiCBHwppEqLBYpCsniyn7WNoBvWrJ6gzuaq5h6JXRXIo68X2ls0j9ZbnZxJqaazzy
         jH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RnsSk0IgGqobCFjh6CXIgOm+uV9hEt1QtilnTcttZyE=;
        b=hOnO0DkDjtgRsCFlyeDL4Phwe2r73BqRvNWHHwu4AKLh5SJFwQGOKZCv8Qev+tVzJx
         mPks7UhidZ7VSo3yXrgvfx2yv2LvxoMvhkJECZdvhAdoSRzmspWzi84TUKuqHQIBLZO4
         p5+00WR0fHRwHR9krhsU2XZJ8Z//uCEuhz3CdnP5KP/3d9zkx65Yt7bR2AKeOWD4dsKC
         8oIY22ZOo58ewGQtngIFfqU8C02OQVHab05yLNwPr+8jM8kyS9pf6gDqFcLla29wCITY
         bT3yqmpeyvBlPHXsoXzCjq4j5FFv9L/X0rp+dpwcqjh6I8b9+ako96FXIAy3Z/1YowKf
         KE1Q==
X-Gm-Message-State: AOAM531gue2EFYoqx7mCuzIZpPBpxp8vK8hn4S1GK/p2914BAFSxoder
        gbrCJTpiaIZMfTR+5+eIJTk=
X-Google-Smtp-Source: ABdhPJzrYR3/S9DPB/a902Ci6IaMGVy82Zg4kfZ+HF8RAaQnDa7mfhGmUwRv2rCU6jScDnoj6lzROg==
X-Received: by 2002:aa7:c4d1:: with SMTP id p17mr38992996edr.2.1626771643950;
        Tue, 20 Jul 2021 02:00:43 -0700 (PDT)
Received: from agape.jhs ([5.171.80.77])
        by smtp.gmail.com with ESMTPSA id f18sm6963472ejx.23.2021.07.20.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 02:00:43 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:00:36 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
Message-ID: <20210720090035.GB1406@agape.jhs>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Jul 19, 2021 at 06:46:16PM -0500, Larry Finger wrote:
> On 7/19/21 5:46 PM, Phillip Potter wrote:
> > Move all C source files from the core subdirectory to the root
> > folder of the driver, and adjust Makefile accordingly. The ultmate
> > goal is to remove hal layer and fold its functionalty into the main
> > sources. At this point, the distinction between hal and core will be
> > meaningless, so this is the first step towards simplifying the file
> > layout.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/rtl8188eu/Makefile            | 34 +++++++++----------
> >   drivers/staging/rtl8188eu/{core => }/rtw_ap.c |  0
> >   .../staging/rtl8188eu/{core => }/rtw_cmd.c    |  0
> >   .../staging/rtl8188eu/{core => }/rtw_efuse.c  |  0
> >   .../rtl8188eu/{core => }/rtw_ieee80211.c      |  0
> >   .../rtl8188eu/{core => }/rtw_ioctl_set.c      |  0
> >   .../staging/rtl8188eu/{core => }/rtw_iol.c    |  0
 > 
> 
> I think this is just source churning. The current setup with include. core.
> hal and os_dep subdirectories are not opressive.
> 
> Larry
> 
> 

maybe the information we will need one day is:

will the core/-os_dep/-hal/-include/-directory-structure be
welcomed in mainline wireless subsystem, when an rtl* driver
will be perfectly tuned?

At the moment I can't see such a directory organization
in any of the realtek wireless driver.

Sure there's time for that ;),

Thank you,

fabio


