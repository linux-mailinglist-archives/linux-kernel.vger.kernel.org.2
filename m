Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2083D4733
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 12:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhGXKE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhGXKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 06:04:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDBDC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 03:44:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a20so6282728plm.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZtgMasyH3/dYOIDYLvJAZLai7NTEDCKY0Q4jVq+9j+I=;
        b=Elk0fdfM2HcilsHejfu6Gph/yKIr+tvcO+EJs4MuuOz5AvZntsUtNZOPEE1nx0F4ea
         aHllIHhoe6vWqRMYFJjNXX48Feimdp8NYeOlYRUdQO9n3CVuyc1O4W3JMqkHRD1kOPJ5
         KhXqkg/ATcSpYLT4XCYJmMl2DKU6HS+cMzk8bu6sqKJPXWJy2H9oZhKi/8mdQnenQFcB
         IteMy3aJtLc6a3yHI5SlEe9L6wE0GI3NQRWu8nQ3EU374/8VQonkftGysdEZBdIwW6pE
         uy2hidm+CHjZPAmJUuHabMj136ZIf3EcleaLWEZFbloCUfKUw+rblERr/dwKYPHfXL6O
         TeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZtgMasyH3/dYOIDYLvJAZLai7NTEDCKY0Q4jVq+9j+I=;
        b=fmz1JVlf0Hk4p6IfTrR0fqhsHqW/DQRWEF1Jw9fdsRwpCu2QTAskzN3tNm4Qr2YWBJ
         2JQTDDuLcEObNTjzwkgquuKWnk7v60HjOnttXt99i8n3CHyFpkfjrgLT4CLWro89LEeg
         qoSfnlRncZ7hKrwtyjCDwwstSBTAS+INDR/NmY9v2KrbjEwxiErpmtCjwBwYnABC/3/1
         08YkFxGYQ7QEQuBV5dmR7WNkHiA2rLOhBWNRYUs1ZJpSJ3xfofqFYuEF5pBGi1Va/AGK
         BhguUNefxkgAwXOEmeBLkQpz1+K7AoSwhvgshXhTILDhHou6kIVJkuPheKq0o8Y2FfcF
         I4fA==
X-Gm-Message-State: AOAM531KbYHaAW9mJZEDV2tKb1w4JRtj8rLoTy7yEMoBcYSO1A96iq/n
        UOe802w9jxWP7k4XiCmuEHE=
X-Google-Smtp-Source: ABdhPJw8IRCFGjXrZ8IvIsTAxkGgO4IcBLcVqQXsIN48Kskn9pYa6VnM9ZSJY44EWkljUZz9k4EcEQ==
X-Received: by 2002:a63:5619:: with SMTP id k25mr9175835pgb.92.1627123497745;
        Sat, 24 Jul 2021 03:44:57 -0700 (PDT)
Received: from ojas ([122.161.50.107])
        by smtp.gmail.com with ESMTPSA id e13sm38213709pfd.11.2021.07.24.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 03:44:57 -0700 (PDT)
Date:   Sat, 24 Jul 2021 16:14:47 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, nsaenz@kernel.org,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] vchiq: Patch to separate platform and cdev code
Message-ID: <20210724104447.GA3435@ojas>
References: <cover.1626882325.git.ojaswin98@gmail.com>
 <YPqh0SHa8n3BugnB@kroah.com>
 <20210723125900.GA279903@ojas>
 <702bc38c-8ea2-eb30-84db-a647140585f6@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702bc38c-8ea2-eb30-84db-a647140585f6@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 03:31:58PM +0200, Stefan Wahren wrote:
> Am 23.07.21 um 14:59 schrieb Ojaswin Mujoo:
> > On Fri, Jul 23, 2021 at 01:02:41PM +0200, Greg KH wrote:
> >> On Wed, Jul 21, 2021 at 09:50:48PM +0530, Ojaswin Mujoo wrote:
> >>> Hello,
> >>>
> >>> This patchset adderesses the TODO item number 10 specified at:
> >>>
> >>>     drivers/staging/vc04-services/interface/TODO
> >>>
> >>> For reference, the task is:
> >>>
> >>>     10) Reorganize file structure: Move char driver to it's own file and join
> >>>     both platform files
> >>>
> >>>     The cdev is defined alongside with the platform code in vchiq_arm.c. It
> >>>     would be nice to completely decouple it from the actual core code. For
> >>>     instance to be able to use bcm2835-audio without having /dev/vchiq created.
> >>>     One could argue it's better for security reasons or general cleanliness. It
> >>>     could even be interesting to create two different kernel modules, something
> >>>     the likes of vchiq-core.ko and vchiq-dev.ko. This would also ease the
> >>>     upstreaming process.
> >>>
> >>> A summary of the patches is as follows:
> >>>
> >>> - Patch 1: Move cdev init code into a function
> >>> - Patch 2: Shift some devlarations from vchiq_arm.c to vchiq_arm.h for
> >>>            sharing
> >>> - Patch 3: Move vchiq cdev init code from vchiq_arm.c into vchiq_dev.c
> >>> - Patch 4: Decouple cdev code by defining a Kconfig entry to allow
> >>>            optional compilation of it.
> >>> - Patch 5: Merge code in vchiq_2835_arm.c to vchiq_arm.c
> >>>
> >>> Changes since v3 [2]:
> >>>
> >>> * In Patch 5, replace forward declarations of some of the functions with
> >>>   function definition 
> >> You dropped the reviews of others, so now I need to wait for them again
> >> :(
> >>
> > Hello Greg,
> >
> > Apologies for that, I was under the impression that a new version
> > needed a separate review :(
> No, just the patches which had functional changes.
Ohh, noted.
> > If its okay, I can alternately resubmit this (as v5?) with Stefan's
> > Reviewed-By tags on unchanged commits intact. Let me know if that's okay
> > or if its better to wait out.
> 
> No, please don't resubmit. I will do the review soon.

Thanks for the review and all the help, Stefan. It is much appreciated
:)

Regards,
Ojaswin
