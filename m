Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033223F74D7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbhHYMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhHYMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:12:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE6C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:11:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z10so1760816edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78fuDtGdiJkSRp2noeoObedntOADJ5PLukyaDoEGYms=;
        b=fVAd9ZUYnHE7ghmyI04wX0XnRWSbVy1rZl96lrl6AqhKJDQNea3gdxCyGnetcCdHvB
         /xqZ2PSK4gRInyWAvDC82DqneRN6IxDiTQY0i1nrx3SFOqjBnXD2sG8zaw+B1JG2B/yf
         NdHzUbDk04whbfj2r6FG4+yBCa/3InQ47JMRx9BqWK7DSQqc1s/CZJ6rP7xwF3mo775C
         UxPdkNroJr48FE7Z3SZ2hVzY383Z68pvDnlZ5KUGWe6r18ZDH295xFL2Bz9UNaOhdoO5
         ECHQbRRIxFDOfypkgnTKLRNY2h/rjfWNedA2dN55rao2gWiJsEuVxgJa1NC1zzaFKRoz
         FGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78fuDtGdiJkSRp2noeoObedntOADJ5PLukyaDoEGYms=;
        b=ew4Xfmsz7t7ci4gGe0DNg+KA/8KWInDRluT9Mrt+eBrxPDIOWvA6Is0I7lwe8p5HcG
         CFeYmfX7vtr0D0KwVZEyngr7OSPL++g6tC81GYOIupt5l6YuRb6qnSHB+B5AcuznzZwx
         LTXso+OlbU98zjcqygi/cRVA5X0DZ0Xir/+OF6fCNjWz2+g+YORrjoLi5jea/Jnfwa98
         RjzYwhJOCLPYmBHvG3klySws3KJW04m01afiSYHtZ3kGww3x7mOT/wDfck4NDx7E97qv
         p11ELgeGvqN1uK4/6uA9LrZnVnv9KORCkY+h57iRflLEzUyGg3k3n4jakbsdelrd0hPT
         H1+A==
X-Gm-Message-State: AOAM530O2rtTKDLpKEMLVgy5+UwAjdttUzCo4BkHEneTSjRnNWYZ3aPk
        5LaAZsI7UhVMG2JPPX0r2QU=
X-Google-Smtp-Source: ABdhPJwtj0rB0CpGYG5QvGGgd3o7WMrJPtpJ04lLDb4itQRxG/vMdxZjJ+XvTVtu6Q9JYcHVizvEsg==
X-Received: by 2002:a05:6402:4303:: with SMTP id m3mr48991271edc.379.1629893491486;
        Wed, 25 Aug 2021 05:11:31 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id d23sm13607473edt.39.2021.08.25.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 05:11:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
Date:   Wed, 25 Aug 2021 14:11:29 +0200
Message-ID: <46570925.meDeiM9PHE@localhost.localdomain>
In-Reply-To: <20210825113122.GT7722@kadam>
References: <cover.1629789580.git.paskripkin@gmail.com> <3494498.825kMHXWDN@localhost.localdomain> <20210825113122.GT7722@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 25, 2021 1:31:22 PM CEST Dan Carpenter wrote:
> On Wed, Aug 25, 2021 at 01:06:40PM +0200, Fabio M. De Francesco wrote:
> > On Wednesday, August 25, 2021 12:38:02 PM CEST Dan Carpenter wrote:
> > > On Wed, Aug 25, 2021 at 01:13:54PM +0300, Pavel Skripkin wrote:
> > > > Both series are pending right now and made on top of staging-next branch.
> > > > Who needs to rebase? I think, applying these series as-is can broke the
> > > > driver, since error handling will be broken
> > > 
> > > That's a bug then.  The patch should be rejected.  You're not allowed to
> > > break the code.
> > 
> > Sorry Dan, I disagree. It's not a bug. No one intend to break the code. 
> > How could anyone know that someone else is working simultaneously on 
> > some code that is not compatible with the work of the other developer?
> 
> Okay, I haven't been following the discussion closely.  If these patches
> introduce a known bug, then I am going to be cross.
> 
> I'm really stressed out right now.  If you at all suspect that your
> patches are going to introduce bugs then just go back and say "Sorry,
> don't take this one, the way it conflicts with Pavel's ends up
> introducing a bug.  I'll resend after Pavel's patches are applied."
> 
> regards,
> dan carpenter
> 
Dear Dan,

Yours is a nice solution to this problem. 

I had thought that I should have waited for Greg to ask to take into account Pavel's 
series, change some lines of his code (because they are the only users of the new 
version of the helper function, that is my work - as suggested by Greg himself), 
rebase and resend, I really think that your idea is better.

I'll do as you suggest ASAP, within the end of the day (now I have to go).

Thanks very much.

Fabio


