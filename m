Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3814E400A5C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhIDIQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 04:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhIDIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 04:16:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F97C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 01:15:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t19so2704570ejr.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pvNBw76UJziS8HOMa+qpU0WlkqWkfXVUHv+DLSVIRy8=;
        b=pw8KBGRvX76sf2ctKUm/V/XJYYOoRoWA2pJzblCCkrC1hJto95dHk6HQHNRUwgkufi
         r4hks/7MFfuJEKnpIhVAiVW01RRYBOdE9mM4z8pa4BqfB6mYncyjjxxCzqp8cDlfCnOc
         n6qy9Jcz3w1G0EqYrMwWmnHGJvlEJbycLPj7iHTB6l9Cky5qll/7Sm66TFRG5r3JuPvt
         VXshL0z1OrJZ4BnVbFavG+/eC+JxHjDtq1Jd6xJGDq8GwOrV07xAaj1w+iM6nNoSQQgg
         4TDSwLL8fNvhiKFV/nhT0l7k91lfx+CpJFq/oP7UzQj/4ya1yzi/cCtw4fHqSXhVWiQG
         1lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pvNBw76UJziS8HOMa+qpU0WlkqWkfXVUHv+DLSVIRy8=;
        b=fBaLoKgRgrZ5iGjX2/wgctarcOIW1DvOqyh38TULY0onatOWtBVUouTbQFwdHRbAhY
         5OxowTLlWbo39++l8cjjwfRlSGo9sJ58ZlSBeDzlonqhTWETHIx/67dKZ1Cf9WJgT8sH
         5i/uT/InC5KMpjr4I8R/w7EiFFSuomZmzjmCNn3af4Izn2AlCOxXRV1DG0oftmKusbqx
         byllDbQ5J4t9e6sN6K/AFELwUh9ruWngWWUfeBeEbOPWMH5583ScqfYv/4xKwBKtKvs8
         3Bz4Ep6cvaYBd+SSYQ0ucrZNW5Gb9WERjPYblj0PtPTVhCjBxCbH+LKGUUb2n3Ps/L8W
         M4EQ==
X-Gm-Message-State: AOAM532ToxqcH440IN7wMlCPtZPP7evhiAkB3HZmUZ1Pi8j/a59kg/z6
        EwQv+szFqkeaRufgh2NLjoIPsgMWSiI=
X-Google-Smtp-Source: ABdhPJzmjhylb9Z4Ndgxmv2ubVazxpA50L9O9Aa96BHx1g6FMB6kX2AH/DkSgQ+ZJ/ZlwvSs9mCphQ==
X-Received: by 2002:a17:906:52d9:: with SMTP id w25mr3078305ejn.464.1630743305082;
        Sat, 04 Sep 2021 01:15:05 -0700 (PDT)
Received: from localhost.localdomain (host-79-55-111-111.retail.telecomitalia.it. [79.55.111.111])
        by smtp.gmail.com with ESMTPSA id dj25sm917576edb.51.2021.09.04.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 01:15:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aakash Hemadri <aakashhemadri123@gmail.com>
Subject: Re: [PATCH v5] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Date:   Sat, 04 Sep 2021 10:15:03 +0200
Message-ID: <1916821.ePjk27kztm@localhost.localdomain>
In-Reply-To: <YTCaF5Ure2tjfbZB@kroah.com>
References: <20210828113656.6963-1-fmdefrancesco@gmail.com> <YTCaF5Ure2tjfbZB@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 2, 2021 11:32:07 AM CEST Greg Kroah-Hartman wrote:
> On Sat, Aug 28, 2021 at 01:36:56PM +0200, Fabio M. De Francesco wrote:
> > Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> > unnecessary wrappers, respectively to mutex_lock_interruptible() and
> > to mutex_unlock(). They also have an odd interface that takes an unused
> > argument named pirqL of type unsigned long.
> > The original code enters the critical section if the mutex API is
> > interrupted while waiting to acquire the lock; therefore it could lead
> > to a race condition. Use mutex_lock() because it is uninterruptible and
> > so avoid that above-mentioned potential race condition.
> > 
> > Tested-by: Pavel Skripkin <paskripkin@gmail.com>
> > Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v5: Fix a typo in the subject line. Reported by Aakash Hemadri.
> > 
> > v4: Tested and reviewed by Pavel Skripkin. No changes to the code.
> > 
> > v3: Assume that the original authors don't expect that
> > mutex_lock_interruptible() can be really interrupted and then lead to 
> > a potential race condition. Furthermore, Greg Kroah-Hartman makes me
> > notice that "[] one almost never needs interruptible locks in a driver".
> > Therefore, replace the calls to mutex_lock_interruptible() with calls to
> > mutex_lock() since the latter is uninterruptible and avoid race
> > conditions without the necessity to handle -EINTR errors.
> 
> Based on a recent conversation on the linux-usb mailing list, perhaps I
> was wrong:
> 	https://lore.kernel.org/r/
20210829015825.GA297712@rowland.harvard.edu
> 
> Can you check what happens with your change when you disconnect the
> device and these code paths are being called?  That is when you do want
> the lock interrupted.
> 
> Yes, the logic still seems wrong, but I don't want to see the code now
> just lock up entirely with this change as it is a change in how things
> work from today.
> 
> thanks,
> 
> greg k-h

Hi Greg,

I guess you've already read the responses from Pavel: He tested the code, 
again and again, and it works properly (connect/disconnect, "ip link show",  
and so on). Furthermore, this patch already has his "Tested-by:" and 
"Reviewed-by:" tags.

Pavel and I agree on the fact that this patch can be applied as-is, however 
we obviously know that it's only up to you.

In the meantime he found and fixed a bad design issue that was revealed by 
using my patch.

Please, let me know if there is anything else I can do.

Thanks,

Fabio



