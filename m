Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E133F6DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhHYDzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbhHYDzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:55:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE0C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:54:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so20137674pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CVEoBZ/UnTo6nLZUccYHUvCMvIcxl/WBSnIq60Ivb00=;
        b=heeEu0ku4/ofb/JqTrjFVArqpzXSELI9PpG8iyH2oUVcapzxZ4F6eUSll21FaFoEHG
         rEOcs1p1bjAZ6S0EXDsLYSwpCHJKPlc9FWoJjw6SwmZs/gZDa2QZFfDm6hoPj4zMG2KQ
         63KYFn007p3fCw3teQ2BiiRzNgdDBrbMOK4YQklMkupPtNZ7Gew5Okrt0YKmu7yc0EN+
         P31EcfDqEGGIWNLVq90dVWeRu59B+W0L962bFxO8PV0pRntWkNobSK0Gc2R9c/loIIk8
         bRWQLUrdSeSWepgA1KbFuOHRm3qcScANquXK6KhPjSLwF0rL9T70YGWQUDaaDJtoO64Z
         m45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CVEoBZ/UnTo6nLZUccYHUvCMvIcxl/WBSnIq60Ivb00=;
        b=CwmPxzt/p4jUt4Szm4guWJma9YYYyfJv+BekdL0JTfF5xRAbfoVr8HrMzU4WbmLy3y
         MnQ1ZUbl+tONBPRpcqgFcxa4hYLQv4N/86SLHTzyc3227V6vpeBMjrPtjDi4jfh+D4ty
         dtgzR3ajwFjFwhEEASBeKOms5/z+UURApzLXwfNOe/9N/IoylYzMTgEbSwaWUEXq0dsc
         jWpEurK2b/qKMoH7820V/Wa3yhMmm4oW9nrZZVHv3vYWPOJMk0yCFCeMNrXGP8O7HVqI
         VHsU69FycLxKFl9OYNAajhw+7jTdArNEj4LLGDHtQvYjtoSq8Z0Mz8YGfrUGSl7T7aj7
         zRkQ==
X-Gm-Message-State: AOAM530cUkxaZKN9/PfJ0MH7Gmv3laISoKZZIS0eQIFNYE9wc/WjVhLV
        Ytl8KJt+0Kq8xBJdDLJ9Xig=
X-Google-Smtp-Source: ABdhPJyfIo5M/sa9StAar1/4CefQWSbehUpQcoL0gNc4p1Jr9nqXEIqqpaaMlJjYqnxXC/a2ilaFig==
X-Received: by 2002:a63:535f:: with SMTP id t31mr4818786pgl.270.1629863656844;
        Tue, 24 Aug 2021 20:54:16 -0700 (PDT)
Received: from user ([122.175.21.197])
        by smtp.gmail.com with ESMTPSA id h9sm4138369pjg.9.2021.08.24.20.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:54:16 -0700 (PDT)
Date:   Wed, 25 Aug 2021 09:24:10 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
Message-ID: <YSW+4iq1hhFPQI3R@user>
References: <YSFgrLUfXzgcT6k4@user>
 <1821445.fzUCeO1EU3@localhost.localdomain>
 <CAA=Fs0mu4m04_Be4-f=W+=_hhGn5oJ2q=KOmZdRrMyGhMgqc-Q@mail.gmail.com>
 <18734228.Nv2I6EOGHm@localhost.localdomain>
 <CAA=Fs0kZvkSmf9vH_Z1rUbDMYYd5SWbQQXhGpMxDbfvWQs338A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=Fs0kZvkSmf9vH_Z1rUbDMYYd5SWbQQXhGpMxDbfvWQs338A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2021 00:58, Phillip Potter wrote:
> On Sun, 22 Aug 2021 at 17:24, Fabio M. De Francesco
> <fmdefrancesco@gmail.com> wrote:
> >
> >
> > Dear Philip,
> >
> > I didn't mean to be harsh with you, I apologize if this is the message
> > I conveyed. Really!
>
> Dear Fabio,
>
> No apology necessary :-)
>
> >
> >
> > Now it is clearer to me what acking means. I've given only a handful of
> > acks because I thought I should also check if they applied and if they
> > build. It takes time. Now I understand it is not required. Thanks.
> >
>
> Yeah I try to ack as many as I can now, but couldn't possibly do as
> many as I do if I had to build test them all, especially with my own
> code to write and a family/full time non-kernel dev role. It is
> certainly desirable for the majority, but if the code looks
> good/correct and is a simple patch then in my mind an Acked-by is fine
> to give in any case. That said, I will no doubt make mistakes on that.
>
> >
> > Please, don't ever think I'm not more than sure that you give a lot
> > of your _unpaid_ time to the kernel and I thank you very much
> > I know what it means, because I too have other commitments :-)
>
> Thank you, and I appreciate your involvement so keep up the good work :-)
>
> Regards,
> Phil


Thanks Michael, Phil, Fabio for review.
