Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039B740CDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhIOUKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhIOUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:10:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E04C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:09:17 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jo30so2716880qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QmINnGAQfwGBHFwHc6SAes9D9CAGNwUU4TpPcc6rrBg=;
        b=VgISpyV1S8lJSw+1NUxW+lmrq3b5kyEVzpD1xU0whvBl6PsXopMfzfkiY64uAFIdmY
         fiH/GfzDNB83Aiz6LMvrRZ6dRaoz2Uz1K/CeyM/eegCj6dI+GyyoPVpxGm6ugn7/8mPz
         JRW/W0XBOTehT2YLKyvWqN6cHEJa9DKmbS1Jt3jj3DhSIpW/mIueTXiw4ED+AvCI6eT9
         s9UlvaHCKnKIjm6NN92NWPd3bFSrXxnOivl0/CRHX64J3KhVgSXclVLh9E+kvkeVdkEK
         8MJd37Hy+lbVshg19ErDN6g1M7Z2QuYJfWHzsH2YRGsLEBiP/5DKc3PWXweDmJBhLi9D
         U6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QmINnGAQfwGBHFwHc6SAes9D9CAGNwUU4TpPcc6rrBg=;
        b=XRnU7JN4HhTVANNkhVwzM79z6nnFpF4anObTbICIAg9NunlWudsttewCIkmK134KjP
         MyhElmC6bas2Gp7sRunlWuBVm2DEPTHvo+TVNjDs7pMvDsXilxhzUvnQFwi367e+J+xN
         Yh9SeOqHwhxqwcS03afu2NMDOZwIvMSmdMnYwNS1fB55sN0v4rV+lJ9IRogTECJW97LB
         lByMKLCQDnErhTKOB7qhlvaBYPVxEsFzGO9R+OeFja6Q0qPgRtITQhIJ7S+Jdtwe9pub
         kio4+UCvzpsA3j6pffnFa/NOipCpb/hn28cp9eYKzu1c7Br7T3JE3OkRG1svxE8iHk3Y
         /bVw==
X-Gm-Message-State: AOAM5330WolBpYqlYV4R3JOGVFQ37WWRJam38ZzFHkOxtmLwKIggHknQ
        ZGKIOOSqNth9tF4spbPpFjw=
X-Google-Smtp-Source: ABdhPJxX2AkAoxlpY53qmSW3QTgL/efQ2x57ZQOGGfj58e9aKmD8KyTSDaqJkLCMGiG0tbb1FwAYXA==
X-Received: by 2002:a05:6214:726:: with SMTP id c6mr621533qvz.9.1631736557208;
        Wed, 15 Sep 2021 13:09:17 -0700 (PDT)
Received: from localhost.localdomain ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id m68sm755665qkb.105.2021.09.15.13.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:09:16 -0700 (PDT)
Date:   Wed, 15 Sep 2021 17:09:02 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, arnd@arndb.de,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: vchiq_arm: replace sleep() with
 usleep_range()
Message-ID: <YUJS3mFpFujQFRqV@localhost.localdomain>
References: <20210914213532.396654-1-gascoar@gmail.com>
 <20210915072904.GF2116@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915072904.GF2116@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 10:29:04AM +0300, Dan Carpenter wrote:
> On Tue, Sep 14, 2021 at 06:35:26PM -0300, Gaston Gonzalez wrote:
> > usleep_range() should be used instead of sleep() when sleepings range
> > from 10 us to 20 ms, [1].
> > 
> > Reported by checkpatch.pl
> > 
> > [1] Documentation/timers/timers-howto.txt
> 
> For this particular warning, you should probably just ignore it, if you
> can't test it...
> 
> You need a Signed-off-by.  Please run checkpatch.pl on your patches.
>

Yes, my bad...

Will drop this one and resend the rest of the series.

Thanks,

Gaston

> regards,
> dan carpenter
> 
