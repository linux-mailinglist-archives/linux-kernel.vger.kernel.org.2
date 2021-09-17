Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493BB40F3BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbhIQIJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbhIQIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:05:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885D6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:04:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i3so6612865wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=soSRHLJ4vYwXFOO4+jsV9TMkGekbk7oJH9zPBeefEDE=;
        b=TDgMOqGvelbXNxMU1Lp6U1v4oWz3ZhxO5HlKmjWPw/AVSkYvKkPe90rf4uNM2EsWET
         larCKqhkfGUfbAt2YjubVdUO+8ojvFLr+gMpVi9gpOvYsxyrx/k1PMiA8BvAA3sV5I9J
         37fPQjLe8y6RpoJ1rlxRaxHLmGJlLLGliOzyviVy8aAentA2m9/JJ3TQTPFthWUV83tm
         Kym4wBvfGDqgYm+1e33UmyLTrnZuboN3sjj3KiCZ6J5tJwH0645PZsI+g6aBc0roT2N4
         TAvEJMn/UOTX/cqToPs5dXiOsCKIMzz46sr2zWlzMnjVbUVSu10/j0oDnAhSSx6JvZoP
         RGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=soSRHLJ4vYwXFOO4+jsV9TMkGekbk7oJH9zPBeefEDE=;
        b=AZPH7ON4NxKMMBchOyWkgPuVZuWUOY7Oap/SlT5hOuDMUpfD3IlftIYZPdidiMIdOx
         7dzsv0sC6iy5lJUAtk4TMifovm6Ydg94EMeZKQQJmRdsJKH0uGfh8KPrk+N+WP76qF2O
         KSXS9rEScALXHwDsjeZ1fG9G0AWP++8ycNjhv2zWqzp5iCuneb7jwEYj/eBJW21IfPx7
         4YRAcMXLqsXp4gatqYuHTPrytL9JnBTIKzo9yPLwVPejzac6194HS5P8Ayd0AIKaBdFi
         Z4XtJzwv1aSqqbDFlrt8eMm269f0C8o4zk8ZYm09BsU/SSd80BnDt9hbdckFemf2zRc9
         j5PA==
X-Gm-Message-State: AOAM532jyNap/kfag5k+CDNAmBtzKiwVi++XUABY9vJE1D7JqzbVXiIn
        MiQ4FrE03quD8eIyw9hHQOzKZSx26iI=
X-Google-Smtp-Source: ABdhPJzzEZ50TN0WBIL+U8Qe154RdG+5hg8gwnyYMv7bbwVKAZp2nmz87AIGBOsB6fTMA55zewzm3Q==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr6190500wmg.17.1631865870187;
        Fri, 17 Sep 2021 01:04:30 -0700 (PDT)
Received: from agape.jhs ([5.171.72.212])
        by smtp.gmail.com with ESMTPSA id a6sm9964160wmb.7.2021.09.17.01.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:04:30 -0700 (PDT)
Date:   Fri, 17 Sep 2021 10:04:27 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] extcon: extcon-axp288: use P-Unit semaphore lock for
 register accesses
Message-ID: <20210917080426.GA1410@agape.jhs>
References: <20210916071255.2572-1-fabioaiuto83@gmail.com>
 <a755b46a-5561-0fae-b7b3-d0bc1906f79e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a755b46a-5561-0fae-b7b3-d0bc1906f79e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On Thu, Sep 16, 2021 at 01:12:53PM +0200, Hans de Goede wrote:
> Hi,
<snip>
> > 
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> > Changes in v2:
> > 	- shortened patch title within 75 char
> > 	- added return value check in function
> > 	  iosf_mbi_lock_punit_i2c_access() calls
> 
> 
> Actually your last version was v2, so this one should have
> been v3 (no need to resend it just for that).

oh sorry for mistake

> 
> Other then that remark this looks good, thank you.

thank you for review

> 
> Regards,
> 
> Hans

@Chanwoo, do you need for me to resend a v3 or
you can take the patch as-is?

thank you,

fabio
