Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54B3EE668
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 07:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhHQGAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhHQGAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:00:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9AC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:59:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so4590389pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wSxKZQAi3G0dpipOjdzpiHXbsLIYP3+eubhWW8vvEdU=;
        b=UMSwr/jgE8uNQQb6W9xRhU3K8FvkwEX9rU343Jo3Po1OXS66dId1mJKOrJyUfMAsCo
         w/1OISmsv7YfDm/Zt79MNCb39fWTL001RHhHVq+Znh0a7pyHKuItlgm6zUWM23yqSOeW
         HcrqernMj0Vzm3H6Q4IoEZg+V4c4mtdjkWMI6aYWPRP1Jmi6INQRmsnxKMNb7CqVyX/B
         81+LwVxbOUSNGqy+kFAoGdeOzOEsPv+XHO7a0/FrRCiDCDPkQjLZG7mvMR5T7qVrJcOP
         GNxz6n6okqaXsRivjFx1kHxswNGxV4HxAJi6JIf+2AehBZHFkC5luoOJSfDQLB2RJ2qX
         3QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wSxKZQAi3G0dpipOjdzpiHXbsLIYP3+eubhWW8vvEdU=;
        b=UFRZcN5sNQYZSHfPEceiAhnuuHUbSeYSkCZRH4ijpAQFrOG8ipwvplkP7pq1NWX6NF
         0gqBx6e2WlvFWPzEUfB6Sa7yCJcwISJ8lRXrQSUqMvQhsga9/fkJ/BkAg9QICmxl/fwh
         4yZRUARj9jWJpOERiLJBNbNE/aAUvyfl4Vf+1XiuIkjXFYGshpmQ901AdqhGE5k7rUsp
         SANvfjUF40Ihc9at+ojbqAIK3rttAy+z6xHUF1C8/N0Yyw9Eg0AH6klSUYMAU7ajO8er
         ghTrTVrpjv8GbuBhXAttBEDoy5mOrIB33m/ToZEVk6QsBnmsrB2nVT6veOweZfY5flC4
         JX4A==
X-Gm-Message-State: AOAM531e7MRAKIeaOLYUfJBFx2VNKtHrDuW9zuVp0x8OFRM7a/iNY2DC
        S5XYh5VEbMzmQePfnQgrH3c=
X-Google-Smtp-Source: ABdhPJz5wFZEFnG7hZXkQxTM+hWBUgm4kqFMwuenpuZH5dqkbpXWn1XRCUyXuW6rrWb62B3al4JF9A==
X-Received: by 2002:a65:6111:: with SMTP id z17mr1914798pgu.335.1629179976615;
        Mon, 16 Aug 2021 22:59:36 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f0:30b2:5c9e:50:88f3:269a? ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id v25sm1041397pfm.202.2021.08.16.22.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 22:59:36 -0700 (PDT)
Message-ID: <98c4a744901d35dba9225af741da52afad9eb622.camel@gmail.com>
Subject: Re: [PATCH v5 10/11] powerpc/pseries/iommu: Make use of DDW for
 indirect mapping
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 02:59:38 -0300
In-Reply-To: <8dfb28d5-b654-746c-03d8-aeee3d438240@ozlabs.ru>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-11-leobras.c@gmail.com>
         <b98f696a-ed64-4c9e-ccb6-549ae8bc7fd6@linux.ibm.com>
         <8dfb28d5-b654-746c-03d8-aeee3d438240@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey, Fred. Thanks for reviewing!


On Wed, 2021-07-21 at 13:32 +1000, Alexey Kardashevskiy wrote:
> > >     spin_lock(&direct_window_list_lock);
> > 
> > 
> > 
> > 
> > Somewhere around here, we have:
> > 
> > out_remove_win:
> >      remove_ddw(pdn, true, DIRECT64_PROPNAME);
> > 
> > We should replace with:
> >      remove_ddw(pdn, true, win_name);
> 
> 
> True. Good spotting. Or rework remove_dma_window() to take just a
> liobn. 
> Thanks,

Fred,
Good catch! On rebasing the last changes I did miss this one.

Due to reworking v5 06/11, I ended up with a solution that takes a
liobn instead of a win name (as suggested by Alexey), and this one is
no more :)


> 
> > 
> > 
> >    Fred
> > 
> > 
> > 
> > > 
> 

Thanks!

