Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3043BF010
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhGGTL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhGGTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:11:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F757C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 12:09:16 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r29so4575193oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/NNS0d1pY0LzGU5RQVZLD5HHDUTLs3pluXhAZ7gXr5o=;
        b=UrDfneJoX9Vvx64apT0HhMb82LTpb21AZu2rRacXtFLUYv/KMXvivaZkJmaFhu7ZLk
         zHps8CdrlfnAqJJXdmU1+bFt7UWm0NiD59rS+lU0PevAv8QUt+N/DbH/lz8TPisy4UOi
         edUHj/AVfm6enNBE3zWjLwX3+GaWchODWOpOs2j72dsiq2r1gWtl19ZJLm7WMmdJsgjg
         +RWv3zE43gMISieNR9iTRLgdePTSWFtfcDlRUjSnEic57gqxrGQZADGTTogMzqTItjTB
         rpKOHDJKxpJnmWd+WbdY1sUIDyJjqYyntnk8swMMT2hcYH+wsh4Z+rQhL88mm8V0aSTK
         7a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/NNS0d1pY0LzGU5RQVZLD5HHDUTLs3pluXhAZ7gXr5o=;
        b=uGyYNGnzm29BJS7kMhwHkUFxRpl+/caZvk9XCZZR46LD5F9WrrimHEbAZx0ECmAIaa
         EoGPoDKenpcC5v7v6DmDLSV+6THMqkFOwYc9nKCHqc7+KO7Azz0fRDCKA5vEBHl/ObXE
         /JtCzEmavKRtxi8/cv2CUQ5Hbu/r7FLiSvcyIdOXIyt6MCJLjchcfXKhvH9j1TPh4484
         V6xrqbGaNyG4SkUYHdpahbdgF2Plj7mdL2GMY2b3Zb7nVzUaYElT7k7/Hwd6J8Xv7SNZ
         gj++O0jFcKVLaNqdu3x4EGogIWCj900SX4QtXQrDRjExbvn/zHZ5wiqqGjlspCapAzcH
         7CTQ==
X-Gm-Message-State: AOAM530rTmbf64NU2uuIu53eiEC/deQLgaN6+UVC7ZYNKIIfQS9ZKgI4
        YeUMFBKhzG6yMepa0/rcEHIQNQ==
X-Google-Smtp-Source: ABdhPJz1pPWVSPHleKf6I6jaYpe5yYsQ2lYhjAJoLeUInbKaOxLtLa/7niOTqwoiqubL68zG6yVhMA==
X-Received: by 2002:aca:4482:: with SMTP id r124mr19725746oia.153.1625684955781;
        Wed, 07 Jul 2021 12:09:15 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 186sm3682933ooe.28.2021.07.07.12.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:09:15 -0700 (PDT)
Date:   Wed, 7 Jul 2021 14:09:13 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Suman Anna <s-anna@ti.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [GIT PULL] remoteproc updates for v5.14
Message-ID: <YOX72TT0fS6NkUKu@yoga>
References: <20210706210228.1229484-1-bjorn.andersson@linaro.org>
 <CAHk-=wiXHZ=v4_HVL5TyP9DaHDd7Xxb8hiXjTQi1eDXOA_XRMw@mail.gmail.com>
 <CAHk-=wiZradn2SLbZcY=sALkhdat-z=Dc07ZuDca+PWjK0mJZg@mail.gmail.com>
 <YOXvLSKuQPl/5Bh/@yoga>
 <CAHk-=wi4b=1gUbNm1WOmD+GcB3-EnR6mwRtU-n4oVpj4kLTrVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4b=1gUbNm1WOmD+GcB3-EnR6mwRtU-n4oVpj4kLTrVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Jul 13:22 CDT 2021, Linus Torvalds wrote:

> On Wed, Jul 7, 2021 at 11:15 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Would you like me to resend this with a correct diffstat?
> 
> No, I merged it - the main reason I check the diffstat and shortlog
> after-the-fact is just to make sure that I get what the pull requester
> _intended_, and that was fairly clear. It's not like the extra commit
> looked out of place in any other way.
> 
> And the only problem with the mismatch is then that I waste time
> trying to figure out _why_ it didn't match. And that's already done,
> so water under the bridge..
> 
> So I just hope it doesn't happen again, because I'm just lazy and
> don't like that "Ok, now I need to figure out what's wrong" part.
> 

I hope so too :)

I've updated my scripts and will keep an eye on this going forward.

Thanks,
Bjorn
