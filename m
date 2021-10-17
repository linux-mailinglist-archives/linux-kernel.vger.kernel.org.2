Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6BB43070B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhJQH3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhJQH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 03:29:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22806C061765;
        Sun, 17 Oct 2021 00:27:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i12so34769472wrb.7;
        Sun, 17 Oct 2021 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oiduE/LQqYR1IcZvqAgWtFEtOd2hhEmfHVFgC1RKeq8=;
        b=jZFbep4PmzAXtDnUaiajm2zaeo5slYPLoslC8MMTd+fyyvh9PyErWW/WIm7OHZ2gfr
         Wi0N7tTHCuYnmMEQ3jffQDpGRf5G8pvrVBiPLok3MdmNBEH5DSJbtj+XOC+xrehLKgye
         Z+Wm8w1P22m4j9XfCpNjwp3wWI8pgp03KqNtJOFWH4v5qsg55Za8ucHn+5yTk6WfPdf8
         bDl0jiSKcf2KVPaUJPfDJDBdqDTPCtnI/llhPoUYBAzv6dTZ/ZjeEuqyfvfVV/TnOAZZ
         +sNIQSAZA6nMxkZP8XEMLHNMMlnFqyiEbDiEhrmpIUAiUPIH4GA806NtTXIN6iIB+q7I
         JKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oiduE/LQqYR1IcZvqAgWtFEtOd2hhEmfHVFgC1RKeq8=;
        b=f302/nLekXWLzcUQlJQ6yJeUkzuRmJtFJxm04Ah2UyVtk0KlsxE7YzihZv7eHkf3xZ
         gV6tlw0iGn620IU3Lef5h7N17cUeragoyuJ+MSr0M/vrMv7w2Y+vXZjBw2V0YL2Zifn/
         xmGpn7NaBXfr/VkGjoXlvGkZvaXpKu81l0cY8017lmpEU90CtdpEyuyB0mZX4liRG3o+
         x1AsncyPYV8NrdKF8TalGia1ZZ3b+bdAsOmc3sbLtGhcsy0STNsnfaa2OhDXJoR2xKP3
         4ZrgyHUzvS5mLRqpTQXrSeM5yNpThVQQUSA5Bej3qSVgnF7or4Al/lMIH6nnONMUdsg9
         NMGA==
X-Gm-Message-State: AOAM531K3P66EpusGT2DU2rQ4ckRt2kzTB/Qp+B/IHHHGElESMRSnZhN
        W3qcGwdzqkhIUMLDqI0vpeBETsMF5bQ=
X-Google-Smtp-Source: ABdhPJxJFzhDKRf060qZ+mIy5M7I19yiNI+YdQpJWiHPQdXMBCxawCH80oKTBqvhU8qJesvpcy1S5w==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr27511386wrg.327.1634455647199;
        Sun, 17 Oct 2021 00:27:27 -0700 (PDT)
Received: from tom-desktop (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id m4sm10803127wrz.45.2021.10.17.00.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 00:27:26 -0700 (PDT)
Date:   Sun, 17 Oct 2021 09:27:24 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com
Subject: Re: [PATCH] docs: update file link location
Message-ID: <20211017072724.GA3786@tom-desktop>
References: <20211003220706.7784-1-tomm.merciai@gmail.com>
 <87ee8quipd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee8quipd.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 01:49:34PM -0600, Jonathan Corbet wrote:
> Tommaso Merciai <tomm.merciai@gmail.com> writes:
> 
> [CC += Arjan just in case]
> 
> > Fix web error: this site can't be reached
> >
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> >  Documentation/process/submitting-drivers.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/process/submitting-drivers.rst b/Documentation/process/submitting-drivers.rst
> > index 3861887e0ca5..8413b693d10d 100644
> > --- a/Documentation/process/submitting-drivers.rst
> > +++ b/Documentation/process/submitting-drivers.rst
> > @@ -185,7 +185,7 @@ Linux USB project:
> >  	http://www.linux-usb.org/
> >  
> >  How to NOT write kernel driver by Arjan van de Ven:
> > -	http://www.fenrus.org/how-to-not-write-a-device-driver-paper.pdf
> > +	https://landley.net/kdocs/ols/2002/ols2002-pages-545-555.pdf
> 
> This is an OK change, I guess...a working link is better than a broken
> one.  That said, I do have to wonder whether this link needs to be
> preserved at all.  That paper was good advice 19 years ago, but I'm not
> sure it has much to tell people in 2021; the days of having to tell
> developers to think about SMP systems are past.

  Got it :)

  Thanks,
  tommaso
> 
> I'll apply this for now, though.
> 
> Thanks,
> 
> jon
