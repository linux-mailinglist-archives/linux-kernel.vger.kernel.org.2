Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F741340F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhIUN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhIUN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:29:25 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8434C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:27:56 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso7046201oon.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EgtcCdCSzU7k5FtxRdD3MvPckmd4WnQ4U+ziuWuV4nI=;
        b=DySCcplmfySE1QwOknq+R/xN8XM9Feir8cJMJzRkinrsxNeUJ36MUA10u4/KG9+ILg
         psZGjJXVoC3RG4S42/cWZmUEwKqKu+BqYaj4fWzLO8n+sQ/QGwEAhNAa5vNkfDeS8MTM
         oxbN70FtgjDFT0wbYwBistSH3c5HkcVds74CJDZMOUjTdMdLGh2UQg/o3Ggz/pOKpl14
         jEBxOhMmp0dSN1IVXhXaqyQjYc3vTEfuMEYRBQ4gDW27xAyJTGZ6MYcwuqD5cE4isSHZ
         0L+ieLZIsvZpjSpyI847nGLWLY+3ruWZYng+BtZR4JfzHRr+1yjH4U04C34AsbHbKObk
         CZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EgtcCdCSzU7k5FtxRdD3MvPckmd4WnQ4U+ziuWuV4nI=;
        b=Czngix1Usv85B2x3CN23QRpD5bSD5Nl5jsH1ja8ISshoHckXPVQSMvWYJh09NLxVW4
         FqHQkZGemta72Xng42nQL9BWJTqNratMImSoCwPxI9LtEyFYIdcCIINa3h8EzljMZPdC
         ubCTrskFdpjQQwTw+8jRyGn/RV/YnlTUFXQ8d2HuVJWqqEH8fDLuX/qYI1cE2CiF0aoe
         +xiCAiZoDIOEbtt7/1xPWJbY2VHpBqdC3TvkzcIMadErQe6ctMLUP+lpQ191woANgQsL
         UY5jRcBhmSXJPYO4I0xEwKRYVB6QbiRyIPDDbVUm+vFHTe1rprNbBrI3B2gLiUDAQ2zM
         4+WA==
X-Gm-Message-State: AOAM531h+QiOtsNh+eccBoTjR9kVEvdG8gZpSaE7bMXUT6rjOiRTQpkn
        u32N4q2LdIJD6FydEIZQOEKinw==
X-Google-Smtp-Source: ABdhPJx4lfySURYgTaV8u4sMXn1NFpp6nXLq3QV7t2GFKU4VMyywfUGcG5LlvThswL5AcKFPnfXpqw==
X-Received: by 2002:a4a:942:: with SMTP id 63mr8476148ooa.25.1632230876239;
        Tue, 21 Sep 2021 06:27:56 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d7sm2194162ooa.36.2021.09.21.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:27:55 -0700 (PDT)
Date:   Tue, 21 Sep 2021 06:28:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Gross <agross@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Kathiravan T <kathirav@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the qcom tree
Message-ID: <YUneBtogXtLnxDKw@ripper>
References: <20210921123032.02cd498b@canb.auug.org.au>
 <YUnaJolAAZmhs4kU@ripper>
 <YUnbK840c9L6vpAl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUnbK840c9L6vpAl@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Sep 06:16 PDT 2021, Greg KH wrote:

> On Tue, Sep 21, 2021 at 06:12:06AM -0700, Bjorn Andersson wrote:
> > On Mon 20 Sep 19:30 PDT 2021, Stephen Rothwell wrote:
> > 
> > > Hi all,
> > > 
> > > Today's linux-next merge of the usb tree got a conflict in:
> > > 
> > >   arch/arm64/boot/dts/qcom/ipq6018.dtsi
> > > 
> > > between commit:
> > > 
> > >   261e8a95d9aa ("arm64: dts: qcom: ipq6018: add usb3 DT description")
> > > 
> > > from the qcom tree and commit:
> > > 
> > >   9da2c3f76164 ("arm64: qcom: ipq6018: add usb3 DT description")
> > > 
> > 
> > Greg, this is not a USB patch, can you please drop it from your tree.
> 
> It was sent to me and says "add usb3 DT description", so how am I
> supposed to know to reject it?
> 

It's a dts patch and as we saw in the last cycle bringing in patches
through other trees has a strong tendency to result in merge conflicts
down the road.

It seems like the patch was sent in a series together with driver
changes, so I presume you took the whole series. Unfortunately it's
quite common for these platform enablement efforts to be spread across
multiple subsystems and we keep seeing the series be grouped by function
rather than maintainer...

Not sure if there's anything to do about this.

> I'll go revert it from my tree.  {sigh}
> 

Thanks!

Regards,
Bjorn
