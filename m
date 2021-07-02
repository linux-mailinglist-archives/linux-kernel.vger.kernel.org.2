Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868CC3BA03A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhGBMRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhGBMRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:17:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98259C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 05:14:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i24so12957165edx.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjWN4MEyKLVeLUkm//Fn9WWchBrYD7ZNuYTgYjzHt4M=;
        b=mAOtEQ5srRuQMlYfASQ8nouMFGWC0J8q1JUTB4O0OsMhP0r4HBvZ+XHaU7G8m9HW2O
         Bhm6zVhxJtO2ZuvabtJsE6AYwlEXqdnYqYWK7yTeZ0eV40YHqFADX1Ef6+ompw3R/cKu
         N3rFcNGhKdVhYyWPokIf7O7VU0T/d9yI1yfu3bDmOErLaM89JOKevZMjnfMdX5c+4up2
         wJzW8OTT+B2B7NBpXunnrCZaCTblvzviQGSgXTgugDqTmFuqGZzm4VsLzBli4KA/dM+r
         QsoAWi9lHHD7UAD4gPqsue2vomRvJOdhFKls710HCxAmCkSc8qaON/gmBR6K6WwAqmz1
         vOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjWN4MEyKLVeLUkm//Fn9WWchBrYD7ZNuYTgYjzHt4M=;
        b=gofXeRjRuv0ozUs85X1sODABB6PPuKkGNJVqARR9XQsI4RWWBG8TxdWjoDVjeWw54D
         g1J8/0XXjhcEVDdbDCt4eam4wjzHIthWNIgOnbsgVdqEm3E6CXnW0H5WOxlax3yErk1v
         +0XcsCL3aOny7GQ1XmpIzc50dICbfyj0wKSum1dO4ysZ1dFM+yCAZuwy6WcE/lJb7OVr
         MPDNLxXLJjCNBI8693X2GSSRN7FrHBRqV6aL5sO8w3ZvS3vjW1f4aOTeseNs77h/U5rx
         Nuq6JTjrF2DVPBccRf8PakHTTIUb/sK4JO2zf7ZLYQrKEbeGCT83nG7ayeKoeGQMhpDK
         f/CQ==
X-Gm-Message-State: AOAM533rE9WdR786uc9K4NY+RGyx4YGwy9XpxrDtFTOOT/SlfJwoUtQ8
        bjiXSqDH26WLl3slxjAqwUOueR5U4k0HDw==
X-Google-Smtp-Source: ABdhPJxDW781iX23hj/fjjv1FeNaG7V3hQinya3O6XWPYG8/NQxYCPhYbMf/PIM7rE6DEFfJPilhEQ==
X-Received: by 2002:aa7:d911:: with SMTP id a17mr275468edr.136.1625228086970;
        Fri, 02 Jul 2021 05:14:46 -0700 (PDT)
Received: from linux.local (host-80-181-152-252.retail.telecomitalia.it. [80.181.152.252])
        by smtp.gmail.com with ESMTPSA id du7sm1269934edb.1.2021.07.02.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:14:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Remove an unused variable and some lines of code
Date:   Fri, 02 Jul 2021 14:14:45 +0200
Message-ID: <2153683.Tj7f0gbxMR@linux.local>
In-Reply-To: <20210702083521.GV2040@kadam>
References: <20210701144707.22820-1-fmdefrancesco@gmail.com> <20210702074840.GT2040@kadam> <20210702083521.GV2040@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 2, 2021 10:35:21 AM CEST Dan Carpenter wrote:
> On Fri, Jul 02, 2021 at 10:48:40AM +0300, Dan Carpenter wrote:
> > On Thu, Jul 01, 2021 at 04:47:07PM +0200, Fabio M. De Francesco wrote:
> > > Remove set but unused iw_operation_mode[]. Remove all the lines of
> > > code from the function rtw_wx_set_rate, except the "return 0;" line
> > > to not break userland code that somewhat uses this IOCTL.
> > > 
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > [...]
> > 

Dear Dan,

> > Just delete this whole file.  It doesn't do anything now.
> 
> Sorry, I meant function, not file.  *chortle*.  :P

No worries, it is clear it was unintended.

Back to the function... As you may suspect :-) I know practically nothing 
neither of Linux device drivers or of whatever else kernel, so I take your 
words for good. ASAP, I'll send a v2 of this patch.

However, I usually like to understand what I make (just for fun and... more).

That rtw_wx_set_rate() is the implementation of the SIOCSIWRATE IOCTL command. 
I hope that I have not misunderstood it, have I? 

However, we know that this function does practically nothing and then simply 
returns 0 to the user. That's exactly the reason why I deleted all its lines 
(except one). 

If I am a user of that command I get a "success" return code (0) and I don't  
notice that it won't be able to set the bit rate. However everything should 
still keep running (I suppose using the default bit rate of the hardware; who 
really knows?). 

Now it's time for two questions: 

1) what happens if that command is used by some users that (hopelessly) expect 
the function to set the bit rate? I mean: if the function is not anymore in 
the list of the IOCTL commands of the rtw_handlers array will still the user 
program compile, link, and don't crash at runtime? 

2) how should I delete the association of SIOCSIWRATE with rtw_wx_set_rate() 
in the rtw_handlers array?
	- delete the entry and shift the array one position up?
	- set the SIOCSIWRATE entry to NULL?

Regards,

Fabio
> 
> regards,
> dan carpenter



