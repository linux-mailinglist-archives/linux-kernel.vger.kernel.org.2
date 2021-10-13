Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8475942CCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhJMVSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhJMVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:18:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610BCC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:16:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y11so3912655qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGgmeYJEA+hJC6d1SbOgu4fzoGVI+BZr0QPmIbJi7kQ=;
        b=E1DRIM0q97FmUpIKXSaVqe1NBg/ssaACiSTuQ5kH73Q334ceeF6am/DnoeEV9AYaGT
         fo69QoKvWk7RDEzE0C/nmPQbCrWMFScJMvJPzpBK0QBKU4UIhkXL5+QYolnwlSV5Hz32
         UcZBGdrzwuJ51kCW+/NN422G0mB57hI+UvHg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGgmeYJEA+hJC6d1SbOgu4fzoGVI+BZr0QPmIbJi7kQ=;
        b=BSMsKsDKtfx1MZotSUfz8qcC1zyeTn09XwFs4Jj65wLtTU8GK38qaqG3fhDhk3mp1z
         G9Ptqda8D+IkuJ9B4R0xoq1s+ThvkCH8q31Dt696mzzP/Xvx1ZQjanh2fA/ll1VC5jXa
         JWhgJ+EsFWIaO27G0Hd0zu+bWi2fsJ4oEYMdFHOt3jfvOaPWiSl8CEBFu2YB3DOtJsDs
         ECX52sbGLlRBuyPQ+7BlOEngvlY8ZzFywjVkXLPPY2n5XlvJQkMMUOFXxANvtoXhMG3K
         QORFky0GxwbbHLNTyezJMgvWKfMOqiaXDPfe57QIoV61aebEqCbEH9LLay9IaWOCVmrt
         IovQ==
X-Gm-Message-State: AOAM531lSle7YS8lx1RmrQbTXaFLMlYpGw8jfU6gZMb01gz0mi89OOdB
        an0Jw1e/jmIsJJz6pkypsGDDcn7mEcyUEEVLszSNyA==
X-Google-Smtp-Source: ABdhPJzbLrOl806aiITElI7kNcmtlLZXVpaMcfStIM79CmRGVv9qb+bPogtcTInWREI6yRv9NWwaCilOEow0dXgRpp4=
X-Received: by 2002:a05:622a:1807:: with SMTP id t7mr2029243qtc.140.1634159809094;
 Wed, 13 Oct 2021 14:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210407065555.88110-1-heikki.krogerus@linux.intel.com>
 <20210407065555.88110-3-heikki.krogerus@linux.intel.com> <YWdBZY7vSWO7DN54@google.com>
 <d82e9972-0d30-f9f4-9333-de57146d5543@roeck-us.net>
In-Reply-To: <d82e9972-0d30-f9f4-9333-de57146d5543@roeck-us.net>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 13 Oct 2021 14:16:38 -0700
Message-ID: <CACeCKaf4OOkzchrNMfWF5Y9ayrfKcyJtZ6XPHaBUzc7K6t+e+A@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] usb: Link the ports to the connectors they are
 attached to
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 1:57 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/13/21 1:28 PM, Prashant Malani wrote:
> > Hi,
> >
> > On Wed, Apr 07, 2021 at 09:55:53AM +0300, Heikki Krogerus wrote:
> >> Creating link to the USB Type-C connector for every new port
> >> that is added when possible.
> >>
> >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > Did this patch eventually get merged?
> > I somehow don't see it in the "master" kernel branch [1], although I do
> > see the commit in that repo [2].
> >
>
> It was applied but later reverted with commit 5bdb080f9603 because
> it created a module dependency cycle.
>

Ah I see. Thanks Guenter.
Hi Heikki, I was interested in knowing if relanding this is on your radar.

Best regards,

-Prashant
