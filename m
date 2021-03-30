Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E334E8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhC3NVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhC3NVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:21:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83431C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:21:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x16so16213360wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LkSzsuk6OkyHhMGQ1Io4HJGGD7LNCqzmJHjPWX4H0o8=;
        b=F1neuwXtz2jRrEO3s517BZAonUG9yq+a+buAzWhClqrFM43jqzvc07jkCvWF5txvUi
         sfjwuWoIzE8Eh3kFlUXyoC4iNUL1aycY1lpLUUKk/gmhbRnfpMzA1ckl86/YANQQPxE+
         r+cBg8JayJKdSSSGOOL7O5GAgbJB07wqKLKA0AIV28CWFa/mDLsZghznGf27CxSLaapP
         UgvecC8skd71MO6Q6iQaxkGe3pvMEFaxMQSibQiuX3k2XqvNG1eoqDqkbjI4Cfw6SOQp
         FK4OvJmZlREKEbpUWJm/NFpskLZrRUPGLT+uQSlz2sOpYBDH8nhUVsAVTcAYrtqOuhJa
         E9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LkSzsuk6OkyHhMGQ1Io4HJGGD7LNCqzmJHjPWX4H0o8=;
        b=NiTyEDnLyq0rETBN59OIz6Oy865SsrmoQent/64pDpvlcCgPncq7Vk/tYVjtx62AUn
         1bB7esXcB59gx8UghPbOiK6NoTM1PyoWDIM5ytIWenv7C6XVerbYZandLcRyN2aZ2XuN
         jeWHZAH2F7A6D/+fz9+tlSONRVxMyl4HKxD0iFbndI5bHeZji2H8CGwx7q/LAW3ltRIr
         6s0ylIGqmIjbj8JOpmDZYzZSgtb+Vqf/RevRzLmNPVCFhNt68BgJb3NXkVwmSdg1lk31
         VQx1d4FH3KOg+NdJLtfK0ZUYrvP7K3qKjcCeHLOpm5S4J2xW4ODdu9+boCZ7jQxIYcOH
         vn8w==
X-Gm-Message-State: AOAM530o/ocYYjSWUVNmweQXwDbE6YHdCzKK1IVlQCIMvmOfY6kFotC+
        fpvlrZXz/9K8KjNz5VC+9KhulADqP6+4fw==
X-Google-Smtp-Source: ABdhPJz9oD6yg4b32zNBbtgJAbD0h97AdahA/HWCNM/n6pjsO2hXvdH3WUU3ljzj3XmMUS4sQ/OGZA==
X-Received: by 2002:a5d:6a11:: with SMTP id m17mr35100628wru.361.1617110492938;
        Tue, 30 Mar 2021 06:21:32 -0700 (PDT)
Received: from dell ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id m9sm34291744wro.52.2021.03.30.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:21:32 -0700 (PDT)
Date:   Tue, 30 Mar 2021 14:21:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        drbd-dev@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 00/11] Rid W=1 warnings from Block
Message-ID: <20210330132130.GK2916463@dell>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021, Lee Jones wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (11):
>   block: rsxx: core: Remove superfluous const qualifier
>   block: drbd: drbd_interval: Demote some kernel-doc abuses and fix
>     another header
>   block: mtip32xx: mtip32xx: Mark debugging variable 'start' as
>     __maybe_unused
>   block: drbd: drbd_state: Fix some function documentation issues
>   block: drbd: drbd_receiver: Demote non-conformant kernel-doc headers
>   block: drbd: drbd_main: Remove duplicate field initialisation
>   block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
>   block: drbd: drbd_main: Fix a bunch of function documentation
>     discrepancies
>   block: drbd: drbd_receiver: Demote less than half complete kernel-doc
>     header
>   block: xen-blkfront: Demote kernel-doc abuses
>   block: drbd: drbd_nl: Demote half-complete kernel-doc headers

Would you like me to resubmit these?

>  drivers/block/drbd/drbd_interval.c |  8 +++++---
>  drivers/block/drbd/drbd_main.c     | 30 +++++++++++++++---------------
>  drivers/block/drbd/drbd_nl.c       | 17 ++++++++++-------
>  drivers/block/drbd/drbd_receiver.c | 26 ++++++++++++--------------
>  drivers/block/drbd/drbd_state.c    |  7 ++++---
>  drivers/block/mtip32xx/mtip32xx.c  |  2 +-
>  drivers/block/rsxx/core.c          |  2 +-
>  drivers/block/xen-blkfront.c       |  6 +++---
>  8 files changed, 51 insertions(+), 47 deletions(-)
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: drbd-dev@lists.linbit.com
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Joshua Morris <josh.h.morris@us.ibm.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: linux-block@vger.kernel.org
> Cc: Philip Kelleher <pjk1939@linux.ibm.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: "Roger Pau Monné" <roger.pau@citrix.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
