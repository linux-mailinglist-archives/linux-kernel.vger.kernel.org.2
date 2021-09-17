Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FBD40F903
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbhIQNUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbhIQNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:20:42 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78775C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:19:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w19so13906464oik.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=irpWsGGMsGJ4DtpFXdv5OWCvYLCIS8iAXj1jsW9bhIw=;
        b=HOEWU8hoOtlFTQ/p0WLcdyNuhPKn/eTLAE1+a06NQBp7Q8yCpS2JwNHYsHy3pyVk7F
         4bNjsVx7/qfiszEFidmUBtJOXxfukA3yi9juAyBiNnWDFtdw7MW/yWHHaH4W1yJeM3Ys
         BvLjprqxKIoUOeOOkVeFcingSXccWb9Z/nKHS7NoOQb/M8Vru8kSXjREhMLk/e4jtvn/
         W1CSMVv7Rf2YnQ5b6vSSfXtLz5QcXuNjzSiqHIrhAyueRfz9W7cn80oEGjejw9YgxmZ9
         8JsRjS0HZFx4pzw8OMGRuOBsXmRpxwfiZBZvhJ+lHdiGG3b4ewgFxlxhrok9vFOEkKip
         yrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=irpWsGGMsGJ4DtpFXdv5OWCvYLCIS8iAXj1jsW9bhIw=;
        b=TafqCh4Fx6H5HwccOhGbm0sMTyAcC9QCM+cnStjp1jUxk6fqRxzm0q5TtslukO27js
         doVkmZshJlqGxATGOaK91SYVKgy9clYYblosRfkDbYVEwG9HO4T5bbhuLXO2tm1zIDAt
         kE01AN3pNN+EB2R6qet5HDMvNJrVIl7lVMIxNNLmCspYb4DNDiF4XJDaaO6yiMAM4O5z
         u32arAEvDChB4vc4EUO8zHolx5dDTy5pkYtMEKEuNbybFemjDMjXsBtMnGmFg0YTTran
         OqWVMiwYWtyM0TbFrK8NaYOys0Lw+3xrssSIxFbFD2mv2ohS53nzx/hQbGkriBjSZabx
         aUuA==
X-Gm-Message-State: AOAM531g+rECy1xRLeV5m86Q1PWLBHeoM30Hf5inDhOomVj1ZynbnpUU
        zf1vlDNG/cezc2sFXdf/XaEYhBqRNg==
X-Google-Smtp-Source: ABdhPJwkobeH+ck5CNHupTxaPfqYHxRqiljqdH3EHSMFHWtP2kQvV2Ig0caKyxyBDALGjuiume/6sw==
X-Received: by 2002:aca:da05:: with SMTP id r5mr12947235oig.30.1631884759752;
        Fri, 17 Sep 2021 06:19:19 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id y26sm1463153oih.2.2021.09.17.06.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 06:19:18 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2dd4:10f2:4a03:3baa])
        by serve.minyard.net (Postfix) with ESMTPSA id D217D18000C;
        Fri, 17 Sep 2021 13:19:17 +0000 (UTC)
Date:   Fri, 17 Sep 2021 08:19:16 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Anton Lundin <glance@acc.umu.se>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Openipmi-developer] Issue with panic handling and ipmi
Message-ID: <20210917131916.GB545073@minyard.net>
Reply-To: minyard@acm.org
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
 <20210917125525.GF108031@montezuma.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917125525.GF108031@montezuma.acc.umu.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 02:55:25PM +0200, Anton Lundin wrote:
> On 17 September, 2021 - Corey Minyard wrote:
> 
> > On Fri, Sep 17, 2021 at 12:14:19PM +0200, Anton Lundin wrote:
> > > On 16 September, 2021 - Corey Minyard wrote:
> > > 
> > > > On Thu, Sep 16, 2021 at 04:53:00PM +0200, Anton Lundin wrote:
> > > > > Hi.
> > > > > 
> > > > > I've just done a upgrade of the kernel we're using in a product from
> > > > > 4.19 to 5.10 and I noted a issue.
> > > > > 
> > > > > It started that with that we didn't get panic and oops dumps in our erst
> > > > > backed pstore, and when debugging that I noted that the reboot on panic
> > > > > timer didn't work either.
> > > > > 
> > > > > I've bisected it down to 2033f6858970 ("ipmi: Free receive messages when
> > > > > in an oops").
> > > > 
> > > > Hmm.  Unfortunately removing that will break other things.  Can you try
> > > > the following patch?  It's a good idea, in general, to do as little as
> > > > possible in the panic path, this should cover a multitude of issues.
> > > > 
> > > > Thanks for the report.
> > > > 
> > > 
> > > I'm sorry to report that the patch didn't solve the issue, and the
> > > machine locked up in the panic path as before.
> > 
> > I missed something.  Can you try the following?  If this doesn't work,
> > I'm going to have to figure out how to reproduce this.
> > 
> 
> Sorry, still no joy.
> 
> My guess is that there is something locking up due to these Supermicro
> machines have their ERST memory backed by the BMC, and the same BMC is
> is the other end of all the ipmi communications.
> 
> I've reproduced this on Server/X11SCZ-F and Server/H11SSL-i but I'm
> guessing it can be reproduced on most, if not all, of their hardware
> with the same setup.
> 
> We're using the ERST backend for pstore, because we're still
> bios-booting them and don't have efi services available to use as pstore
> backend.
> 
> 
> I've tested to just yank out the ipmi modules from the kernel and that
> fixes the panic timer and we get crash dumps to pstore.

Dang.  I'm going to have to look deeper at what that could change to
cause an issue like this.  Are you using the IPMI watchdog?  Do you have
CONFIG_IPMI_PANIC_EVENT=y set in the config?

Thanks,

-corey

> 
> //Anton
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
