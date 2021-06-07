Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1139E657
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFGSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:20:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBBCC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 11:18:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id og14so22929756ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbUSJqSbut0v53C0fNrpLk5VXvw0k+vSP9xx9sgALVo=;
        b=Up0eT6aD9F4MAu/qG7w2Hl8NvHJ7Sno/dQARnJIfFw8Z2b+q1X8S+MX+sXki+VSvmY
         qMH983ALVxPQtju4Q3i3w5cVU404nErIYO3SK+LGnpZKw02ZmduNNKgQQqLfMSQreu1+
         DUK8ahehOsNO5YUCsIW/MgDWeHcXiio7RGFUmV0/NZaLf+35O3OScscGIDTjkdSRFgjV
         gEkZxRsQUiN/WmKcrO/RQJcNpx6mHeMZqTOqFce7nLgTpCl23uszjTHoeDgWBOYnTn87
         t3Bc4xBRrj2f4T4lpQ1bKIvur3ffGUl9EjUua7Y59VdkoV/NwuGyhbdFlcgzImto99/j
         0Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbUSJqSbut0v53C0fNrpLk5VXvw0k+vSP9xx9sgALVo=;
        b=luSCmzuuvBpndESA53+9nMv8WuTELLnMiN1xslEPZiL3eoNYu2A2yi9aoxh4DjZyOn
         CvugcUDQc3Ynfy1RasdFB2qaup4pOSJ3Nq7kO27lVDuo7VLZvJOOVwZchkYMJ48s3b0+
         gneiTf/qppYOUqvSZlmV/G7lLluVMRdt12b2DloPywnv4OCPrLtI8bFxrXmerxuEtIkP
         GZCrn3uhizjqtV09TbeFuTGp5Naoiwn3rNmy3IyBWJHma1oqjTUoihp0jbsCmx3/9Rb2
         /5zynwQfnvqpNFOjTMjoD07Ke0aqLWOXdXU05RTmfZmDnTo8TMC0Rr4INty7gvoQcteY
         Hrcw==
X-Gm-Message-State: AOAM532lUwbIowSuoMEZWWby1nWHneDjh/4sZ4dB9VkHO+dl1IPGkEL1
        ItIpi03BbFcgeQFicZGUUJVF61ycPIcDySoJ8qEd
X-Google-Smtp-Source: ABdhPJz6c/ZosOHRZERkjdb1ufocxhI1igSKtTjAxQvHM7XCX4fzbRWL/97g88yUm4Y7XAlJmKuAgVUcVme+Ub1rjyg=
X-Received: by 2002:a17:906:2c54:: with SMTP id f20mr19221773ejh.91.1623089893673;
 Mon, 07 Jun 2021 11:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
 <CAHC9VhTvp3Z26JbXJdq8p4T7w3GZk-1CFWY328o75-AqqUbNTg@mail.gmail.com>
 <79d5bffd63b46bb7d54ebcef4765cfca28f76ff0.camel@yandex.ru>
 <CAHC9VhQfzx6xhZz+ghkRB2UKWHmsHKjLzz_7z3L47GHOoHLchw@mail.gmail.com> <20210607175058.GO447005@madcap2.tricolour.ca>
In-Reply-To: <20210607175058.GO447005@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Jun 2021 14:18:02 -0400
Message-ID: <CAHC9VhS341s99jZ=rb90-hHmR2vfavhBANw_wL6oJp-hasST6Q@mail.gmail.com>
Subject: Re: [PATCH] audit: Rename enum audit_state constants to avoid
 AUDIT_DISABLED redefinition
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Sergey Nazarov <s-nazarov@yandex.ru>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 1:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-06-07 13:07, Paul Moore wrote:
> > On Mon, Jun 7, 2021 at 5:58 AM Sergey Nazarov <s-nazarov@yandex.ru> wrote:
> > > Hi, Paul!
> > > I think this could be easer. It's enouth to rename AUDIT_DISABLE only.
> > > enum audit_state deals with per-task syscalls audit context, so we can
> > > use AUDIT_CONTEXT_DISABLED for example. If it's okay, I can send a new
> > > patch version.
> >
> > Hi Sergey,
> >
> > I personally prefer the AUDIT_STATE_* enums and would rather see that.
>
> I find AUDITSC_* or AUDIT*CONTEXT* are more helpful since that makes it
> clear it is about syscall context while STATE doesn't make that clear.

We've seen how this will grow to incorporate more than just a syscall
context, see the io_uring work that is ongoing.

Let me be very clear this time, please use the AUDIT_STATE_* enums.

-- 
paul moore
www.paul-moore.com
