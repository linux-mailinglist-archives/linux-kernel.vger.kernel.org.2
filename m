Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B33F8B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhHZP5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhHZP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:57:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2998C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:57:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z10so5374559edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXF/RHrw7uR6voIrN0yU+7iqLQE1G5atkH2gmUQ8pZk=;
        b=RQJ9kvRCGzboqUPP5bbDLYsm7wHK3ezjmAWY1wP8SNnfLIS8HarSFZ7DJKNBFxOZyg
         T922M3YNTNVOXO+PbK4iL9ZJdNtmDV5GCGR3QRem4nQSsD520BwsZuLH410XfjbB7EQv
         fxg0GiydJw7Qzi/ur41bgIiyYrORoc/7NuAxot5EHb3QZUR6ae297ssxWmesAEMciV6y
         LFU5wczmGANMvf63O9yQFiIItalWhpi8XqxwqeTTUfmWXyWsCEGp2YBSQfY5bk7oiELJ
         Io/8CFj6cHPCYYeag+XZexMWmHNIhp29ydwdyuPOWHwfB4Z4TqgYQ9iN/r+93RjvaSHF
         OFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXF/RHrw7uR6voIrN0yU+7iqLQE1G5atkH2gmUQ8pZk=;
        b=oeBbGwp3BeWkdkb3zf70zA6yQ8x4g2SnTr+o/QqKMz6/uu5KipIgafFtpalEDt0Z14
         DnmXof5KAN/NiDGH6QL4mP/jo+Noz8uzJ5ooZtAkHt11PsLgCwcWsJ8Juy3gV43htT5B
         lM14DD/FX/ZUdBLKTbsNcC9bwtWRlAqJQ9eZ4691LyRuUxc2xwv2cdi1D7I02GVJJOnD
         F8I42123wSxe5UIevVA8owOgmoV7AwfgQFuTwNqmPS5dFeT4N38+EiPrkYJ8nMfWtkdD
         UGMnIE3CmN4BhoebCY/NCOyqn4C4eePl+XyvfzGa1/5gT0CFKdhMXpRyLj1WSWMW6y0r
         vqAA==
X-Gm-Message-State: AOAM532/DFl8VXNwZy2wVz538GkjV/BJMhzN9+ROqVytpyHK9dDDh8yy
        Bl0swNBdF63Uz1fnZCHcWrBjP42tvnM=
X-Google-Smtp-Source: ABdhPJwTDYtb8XcfblsJ7q7oQNNs+70i6Vv8+cvwvcrMtFQWph5GvGCGlXX7GD4Uq78wknF2uANqUQ==
X-Received: by 2002:a05:6402:354c:: with SMTP id f12mr4872206edd.287.1629993424411;
        Thu, 26 Aug 2021 08:57:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id q5sm2080803edt.50.2021.08.26.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 08:57:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alex Elder <elder@ieee.org>,
        Alex Elder <elder@linaro.org>
Cc:     kernel test robot <lkp@intel.com>
Subject: Re: [greybus-dev] [PATCH v2] staging: greybus: Convert uart.c from IDR to XArray
Date:   Thu, 26 Aug 2021 17:57:02 +0200
Message-ID: <8278430.GnBS7eVdlf@localhost.localdomain>
In-Reply-To: <335f30c7-8ab4-d46a-d415-e994997a3fa5@linaro.org>
References: <20210814181130.21383-1-fmdefrancesco@gmail.com> <1838037.Ul9q4Z07vA@localhost.localdomain> <335f30c7-8ab4-d46a-d415-e994997a3fa5@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 25, 2021 3:45:13 PM CEST Alex Elder wrote:
> On 8/25/21 12:20 AM, Fabio M. De Francesco wrote:
> > On Monday, August 16, 2021 4:46:08 PM CEST Alex Elder wrote:
> >> On 8/14/21 1:11 PM, Fabio M. De Francesco wrote:
> >>> Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> >>> is more memory-efficient, parallelisable, and cache friendly. It takes
> >>> advantage of RCU to perform lookups without locking. Furthermore, IDR is
> >>> deprecated because XArray has a better (cleaner and more consistent) API.
> >>
> >> I haven't verified the use of the new API (yet) but I have a few
> >> comments on your patch, below.
> >>
> >> 					-Alex
> > 
> > Dear Alex,
> > 
> > On August 16th I submitted the v3 of my patch ("staging: greybus: Convert uart.c 
> > from IDR to XArray"), with changes based on the comments you provided.
> 
> Yes, I intend to review version 3.  I'm sorry I didn't respond to
> your earlier message; I am on vacation this week.
> 
> 					-Alex

Oh, there's no hurry, sorry to bother you while on vacation.
Even kernel hackers deserve a vacation at least once a year or two... :-)

Thanks,

Fabio

> > 
> > Could you please take a few minutes to review this too? I would really appreciate it.
> > 
> > The v3 patch is at https://lore.kernel.org/lkml/20210816195000.736-1-fmdefrancesco@gmail.com/
> > 
> > Thanks,
> > 
> > Fabio
> > 
> > P.S.: I'd also like to know if you think it's worth converting IDA to XArray in order 
> > to improve the Greybus driver in staging.
> > 
> >   
> > 
> > 
> > _______________________________________________
> > greybus-dev mailing list
> > greybus-dev@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/greybus-dev
> > 
> 
> 




