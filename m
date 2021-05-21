Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4D738C245
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhEUIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhEUIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:51:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:50:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so6964314pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z+pNd8iiKn7fyjmLzbAXru7lbppAXi9Y4DYZJ4cZYbI=;
        b=QqKzCjwO7SBetuZ/52HQXYCXl65z6cjRzwx7dfDOuQKlPUjYl75GW/n7eXjrhzP4XK
         7HH37dPidegrGSpLfV8dZoAvBRZXdohd5pPX4CZXCFKHQUi/yo8l7p6IxXGg3WLk5qAr
         B0fB7eMQeoyV9T53XeSHQvypm6ONWvFmpEyqeK2BLWv3PurEzVSwX6CV8lApOpIJVDl9
         YJvsqidILxlvBBQv6oky3Kdazrd0+CvqOH5IH/hjfv7PQr/dNkEzw5/LSkKesMXx/VHc
         HNbpIGdoECoO9SjjmLg369x1uYxG7+XUe1ZLu/WIeIydJVtmYup5WV3/Uu0Nqk1wKQ+9
         KmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+pNd8iiKn7fyjmLzbAXru7lbppAXi9Y4DYZJ4cZYbI=;
        b=It6N2nB6yl/essVUjB1iSBwgccQsD1qQk2fqpTX4D0ldQ2/a96r65WecClG3sffv2a
         eY/X2j8ZlQRfdpedQ6ZsA8SD6paQTXs89B5jgFyV98PM/LB8iEQqSyxT3FKUP9+IKYv8
         GCgsVq0KKoDqoxbdvQW2OD4Kic/9xv0B0z4gUzZtx7csJ8U6PFGteW3Y2SSMap0LMeOI
         utpa0fNYZqw9f+vahHBmnH2YIw1/R8DOx5iSBEHhs32TFMF+8XoL289btXTxOG4xUS7Q
         NXVDDbefOFu1Z3AglWuOjwkZ82mCg4L+U8ZdLDNAC2JCvBgoJ48IJrfdYyieMlwKr52C
         xabQ==
X-Gm-Message-State: AOAM531oiWjTVi3/qpFNdMklvZ32TYtfuAHMYzgHJnb5MK8sejBTOfTK
        xL2l11sNEuJzBkc3AZ31Ja8qSQ==
X-Google-Smtp-Source: ABdhPJxTH/EUjEEsKboooGZ1Xc0iz18xdDFrb5WRT5TAC3wWaXiQuV2kz2z5+VbiHKmItXbvREJh3w==
X-Received: by 2002:a17:903:30c4:b029:ef:82f1:cb28 with SMTP id s4-20020a17090330c4b02900ef82f1cb28mr10984611plc.19.1621587008404;
        Fri, 21 May 2021 01:50:08 -0700 (PDT)
Received: from google.com ([2401:fa00:fc:202:f654:3898:11e:aa15])
        by smtp.gmail.com with ESMTPSA id f13sm3796911pfa.207.2021.05.21.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 01:50:07 -0700 (PDT)
Date:   Fri, 21 May 2021 16:50:00 +0800
From:   Martin Liu <liumartin@google.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, minchan@google.com, www@google.com,
        davidchao@google.com, jenhaochen@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kthread: Fix kthread_mod_delayed_work vs
 kthread_cancel_delayed_work_sync race
Message-ID: <YKd0OBB7dPoAYX7J@google.com>
References: <20210513065458.941403-1-liumartin@google.com>
 <20210520144845.52755f3af700a902e07e2ee7@linux-foundation.org>
 <YKddXqLh6+Pj7wFW@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKddXqLh6+Pj7wFW@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 09:12:30AM +0200, Petr Mladek wrote:
> On Thu 2021-05-20 14:48:45, Andrew Morton wrote:
> > On Thu, 13 May 2021 14:54:57 +0800 Martin Liu <liumartin@google.com> wrote:
> > 
> > > We encountered a system hang issue while doing the tests. The callstack
> > > is as following
> > >
> > > ...
> > >
> > > Fixes: 37be45d49dec2 ("kthread: allow to cancel kthread work")
> > 
> > Thanks.  I added a cc:stable to this and shall hold it in -mm for a
> > couple of weeks to get exposure and testing before sending it to Linus
> > for 5.13.
> 
> Sounds good to me. Thanks for taking care of it.
> 
> Best Regards,
> Petr

Hi Petr, Andrew

Thanks for your help! :)
