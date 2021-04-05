Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4840235422B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhDEMqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 08:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhDEMqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 08:46:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D6CC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 05:46:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g24so8351150qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rr+qLI5dbOnzWTxPW+TcyOj2It+BpPtlzlZZi5K4QYg=;
        b=OnQPSw9d7gRUp+cgQMef3+wT//a+NVtQMRp1ehvr+NZMvfCCapHSNeFwXTW4nTJFbo
         4moyC5lEcUDrZVVhq4BUv8usbYvjiquW2O0T3A/twwT4+pmuHhxwM9x6AcPpcZGUHAce
         BqVhKz9DbYrmbezF6Cgn97soqZd2Cy+LejNdza3pwFTOiUWHfwTy7ATQBTuuvt3PWkFZ
         doyWFJMUdIfxnDn+6l3rSWX/fYXsx8Tcq+XA7xLJDsKccPjFMcfO0A6PW0slMV0nS0cX
         LfXvyFGD4t6vU7jtYNlf/adYVmqb5fYaA5C6BQR3KGetJel1Mm6nkSbtMbiYun6ZwK4+
         bMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rr+qLI5dbOnzWTxPW+TcyOj2It+BpPtlzlZZi5K4QYg=;
        b=GwmZtc2yhHJWgAtRd6VT9oMkIegJ/B45RNEDAvw/JTF3fA3FgpSqxnwdfZDtqKyhPG
         i3LNehQLACyO99/H7FqidF9MR/xGqaUicjIegiup01Wp78hyY8hWzRzc1deYYy1JD1WY
         eXFIgtYOqYDD7AmaKzVbYNhLiz5Fgoax6b9nUfS7IliramYJ/nZ/YkKYHwuQAqP5dDvB
         ia50hPhIAzLXcNq3USsqY1LEa0swnkoI3ftQ9IzTtImE/uRt53jJWnbsszeyiUWIz14T
         JOSrLubn4ClnH/xSjHqlfvGSbx994z2hye+AgDQX5s2+Dc//EIF7p3n3ZmGguUFjnGtL
         K9tw==
X-Gm-Message-State: AOAM530DEHtA1wrhyMSp28IKvBindVDU16q4Rn0171BYxNnn10chss75
        3+kVYPQP2EGjidTe3QNyGJI=
X-Google-Smtp-Source: ABdhPJz46PlWHN+ve9Yq+gPLhBoY940+Ff82NTNiRbIx/dGYiugqdS7LOTBhZ/ih3k8Bry6CD1XTVg==
X-Received: by 2002:ac8:738c:: with SMTP id t12mr5792949qtp.332.1617626802296;
        Mon, 05 Apr 2021 05:46:42 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:214:8167:5000:d94c:b1e1:5a07:101c])
        by smtp.gmail.com with ESMTPSA id x14sm10446472qkn.98.2021.04.05.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 05:46:42 -0700 (PDT)
Date:   Mon, 5 Apr 2021 09:47:27 -0300
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zbr@ioremap.net, corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] w1: ds2438: fixed a coding style issue to
 preferred octal style
Message-ID: <20210405124727.7kutpafoq7rh56oy@LuizSampaio-PC.localdomain>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210405105009.420924-7-sampaio.ime@gmail.com>
 <YGrsIg9efV/8asDE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGrsIg9efV/8asDE@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 12:53:22PM +0200, Greg KH wrote:
> On Mon, Apr 05, 2021 at 07:50:06AM -0300, Luiz Sampaio wrote:
> > Changed the permissions to preferred octal style.
> > 
> > Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
> > ---
> >  drivers/w1/slaves/w1_ds2438.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
> > index 56e53a748059..ccb06b8c2d78 100644
> > --- a/drivers/w1/slaves/w1_ds2438.c
> > +++ b/drivers/w1/slaves/w1_ds2438.c
> > @@ -388,7 +388,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
> >  	return ret;
> >  }
> >  
> > -static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
> > +static BIN_ATTR(iad, 0664, iad_read, iad_write, 0);
> 
> Why not BIN_ATTR_RW() instead?
> 
> thanks,
> 
> greg k-h

I agree! Thanks for the review. I will change for the next version.
