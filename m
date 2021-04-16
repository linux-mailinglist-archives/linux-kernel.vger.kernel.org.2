Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C92362ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhDPWJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDPWJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:09:16 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B077C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:08:51 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d23so18408488qko.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAVpyw3HpD2ywqcxbGBN3eCbLgjjSxQTSq6wSel4TrA=;
        b=mgiKr04WpGHHyDIWIGaT65rHJ9jD/JD/Uj/YlXXR8MG6IiATka2xsfIt9xHBTV3vih
         H5OXJBDQR0rosJ8fxSnbgnHWn1KmDRKcOgiFb3Q7QF/e1ZO21n0Xm/MW0mrmHfr21VG0
         5INdlCVkP4UShi8ay7i4T9LWESpN5T5cGpBAgNEuTxY+Vqb19g8KFDavGOgGp6S6XcbE
         Q0AXEhJEyrNfrIyOl7kVh+uOgctitCNdnii/viwOOWe2+2mYqDexF3XLo3/0KnNak75A
         g3QQUi8Gx4CL1qDpHqIEStBRhHp1sRU0Nb9b60mMVMsUqEUZQBuPOG74d3USuK9LJcRs
         N09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAVpyw3HpD2ywqcxbGBN3eCbLgjjSxQTSq6wSel4TrA=;
        b=kiuxNtVTbdvRof82GGDu7/JMKpSoA3qMdzaYIy/9Zaw7FiK0DiPQ//LuBwSshX1vZg
         pYJC0O9zW2TZ0oXnXbkWxhxEGDwiXN81jlNis9nrjiRIw3h2N+mWF/K1KJZn9wG7wWlU
         unzwJXnQBbOZEnQe8Z9ik7T2Mu4LZ38nx+p0/o7ZUdT0mytZDYcWcJoeX4kjW6/xM7Eg
         xWNGEKA0DIjJpH4w6MT+3u66pF8cajYHKBewyH8aAYLLUgKe85oi6CszhWgL1ccmR8fc
         1hwrif4prpN+Oq0LNDKip7+HO/Yr1EJOSLrMFYynvFy+TMhlAF5BXDjQxZZXkZHpXmH+
         1+uw==
X-Gm-Message-State: AOAM533WNvbTTmptY87XC8Jn3/mXuNf0TBXCntsjXYLG9BU82jVNJP4y
        fGUaupEtW9u2x3ZGICT4l9MpKiIBNiynr6Kvr0Dj8A==
X-Google-Smtp-Source: ABdhPJwgecDMzKX0rqVmFwlWXvMyRxsyDDfr45Z81oJcuJNaPT9jTWQ10/rnHymH7M+5L6PQ1WCkqUIZJmrAR+B/N+I=
X-Received: by 2002:a05:620a:3d9:: with SMTP id r25mr1417902qkm.421.1618610930841;
 Fri, 16 Apr 2021 15:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
 <YHnLCoeBDn3BcRx1@smile.fi.intel.com> <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
 <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
In-Reply-To: <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Apr 2021 15:08:40 -0700
Message-ID: <CAPcyv4g=XyFfDZYL-brAO7LTVEc90=x7aQWar_WZtfnPx09UVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 1:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Apr 16, 2021 at 01:08:06PM -0700, Dan Williams wrote:
> > [ add Erik ]
> >
> > On Fri, Apr 16, 2021 at 10:36 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> > > > Strictly speaking the comparison between guid_t and raw buffer
> > > > is not correct. Return to plain memcmp() since the data structures
> > > > haven't changed to use uuid_t / guid_t the current state of affairs
> > > > is inconsistent. Either it should be changed altogether or left
> > > > as is.
> > >
> > > Dan, please review this one as well. I think here you may agree with me.
> >
> > You know, this is all a problem because ACPICA is using a raw buffer.
>
> And this is fine. It might be any other representation as well.
>
> > Erik, would it be possible to use the guid_t type in ACPICA? That
> > would allow NFIT to drop some ugly casts.
>
> guid_t is internal kernel type. If we ever decide to deviate from the current
> representation it wouldn't be possible in case a 3rd party is using it 1:1
> (via typedef or so).

I'm thinking something like ACPICA defining that space as a union with
the correct typing just for Linux.
