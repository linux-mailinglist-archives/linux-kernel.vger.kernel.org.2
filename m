Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7BF3FB247
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhH3IP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhH3IP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:15:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E64C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:14:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so10936604wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C9dk2+VCltyEEkDv8wQBAPoWCNIY69Z823DPo+nBLdc=;
        b=afedxgOLpJNwFJh2CpeczYHooEtygK+OZpghWQFMhQGKW9f3oosVxuKQLfw5yjFfAu
         P+i3LEQUik40cXAYmtKtVyR06ugLIxkhi1/lvSkLJZIEi/DuRMdvhkAuRUrrx8BCPLo2
         86RryPT6y780RZHFx2BvFpnkYDCW3RBF12ca/1v8ChI4veUxBn4wOfksU4CgxN//9XY5
         1GyUjzKHWgVCNggPOgI98e6ygM2dnmVld6lIcYI+Vao2z7AM/PeWJP4XGyY1u5oHQwoD
         /3JdZ+OsGq9IjAbO1eqzO48/BUYV03HZncUUQwrGeI+68W3s3/eCkT2SZ8M2P3IuicI2
         dPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C9dk2+VCltyEEkDv8wQBAPoWCNIY69Z823DPo+nBLdc=;
        b=FOzgvBqgmqHsfgnAe1PD6Q2ebNv7X7UFa4ICROSnCy05yQoqjIBpyYi6NgiDOLfE/N
         rezW7Mu34ho0vOIW0GwdqSdvgza4FOqwWNmNqlEfHJQgIPZT3UvSh5Ch6c3qHmhSjxG/
         v47PqCy9s0TFGKMSV184RJ3LWfODxITh2UP1gd3UMocXGXw2h6bJEFyvGaWT+5SKNlvL
         PrK9C3b41peGuM6Kn5rs103NCKb+RuPhtLpY5jw6rFUpveqffsN/benHGM0ByVfNsv2B
         orZpViESQZziwR4657A+vJcRfIH0AtaM63rNKwO5SaWoqrLrf45sl/BW7xygpOhA/9vT
         q1bA==
X-Gm-Message-State: AOAM532YB3X3YKmNuAt1TzBnGvOCn4Vov6YU50KNN3v7l2kqKvM5Hxyj
        XJwBGdLf6AZXXZ8rdbJFetE=
X-Google-Smtp-Source: ABdhPJy2gFfXJviteh0Qp5UT5bwpI3yQrfsp5IyTjhc7I+bLutyE7Y7JsTiGBbvVRhPAv/AmiaWQtg==
X-Received: by 2002:a05:600c:4999:: with SMTP id h25mr31317552wmp.175.1630311271439;
        Mon, 30 Aug 2021 01:14:31 -0700 (PDT)
Received: from agape.jhs ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id l124sm14381278wml.8.2021.08.30.01.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 01:14:31 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:14:29 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: rtl8723bs: remove lockdep warning
Message-ID: <20210830081428.GB1416@agape.jhs>
References: <cover.1630307025.git.fabioaiuto83@gmail.com>
 <85ef4038-24e7-fdd4-fe42-35416f705b99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ef4038-24e7-fdd4-fe42-35416f705b99@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On Mon, Aug 30, 2021 at 09:44:01AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/30/21 9:09 AM, Fabio Aiuto wrote:
> > This patchseries removes a lockdep warning that turned out to
> > be a false positive.
> > 
> > All "lockable" queues in the driver are initialized by
> > a single function. This confuses lockdep which puts all
> > locks in the same unexistent class.
> > 
> > Fixed it by doing the initalization of queues in place.
> > 
> > Done a small code cleaning and removed the no more
> > used function.
> > 
> > Tested-on: Lenovo ideapad Miix 300-10IBY
> 
> Thank you so much for fixing this.
> 
> The entire series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> For the series.

Thank you,

fabio

> 
> Regards,
> 
> Hans
> 
