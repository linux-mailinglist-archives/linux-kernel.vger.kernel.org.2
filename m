Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CE230DD0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhBCOk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:40:59 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:44867 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhBCOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:39:54 -0500
Received: by mail-oo1-f49.google.com with SMTP id n19so6041804ooj.11;
        Wed, 03 Feb 2021 06:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvCgyaA7ebswaUoEV6zT2acMnS693vX8wjJzePgLqXE=;
        b=j1xDUI+AwEZLCFiKtpwML9/tia5puhA39MI0rHhqDWsF4CL+eHykN6igvPfZdQvcDR
         NzK9o5LBsGlW7U72KRJ2+Hqc/bBZQTIMy/8WxVumqrb8oOvDJTqDkfme4D3xh1xljagv
         OqKGLi33gF5OqAUUFYgw6BtKb/YKk0+jejsNTFEjCU2+OVwBI6NZyDlioPpC4IUTfv1h
         IpiTk0B0PLFORK1T1DLhmYRUo4eArgWJ/gq5uFpPQ8Y1C46/bLOybc/KLjd/+Sh7Smfb
         T6DJSfW5/WGCQTas2eFQw/iTOlGsWa0M0m6uPQJru6BcqYvKLSqV7r++gsbzJR1MgC2/
         Rscw==
X-Gm-Message-State: AOAM530T8OCU9WpJXuB+/NJOmJWcy4AFI6QMYkGlhmlpF3+4VVBbqRG8
        8Q60tkk5z2pwO2KDwltClmyC8SVkJKXRnuXZ8ojXhSdO
X-Google-Smtp-Source: ABdhPJxLgXz4703BGQ6k6OnV77vwQFCxJbVpp0dwaZsdt7mZrfvUnJ7uTwqhs/HydMW2k5mA83+gWlMoFdyTdggDlHg=
X-Received: by 2002:a4a:cb87:: with SMTP id y7mr2282467ooq.1.1612363153621;
 Wed, 03 Feb 2021 06:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
 <20210202125032.64982-2-heikki.krogerus@linux.intel.com> <CAJZ5v0gMEBV=Gm-R=5zkN-J_p7cMTBwoOJrv=ec1j6SfSYRg_w@mail.gmail.com>
 <20210202150102.GA1687065@kuha.fi.intel.com> <CAJZ5v0hVZBhqzLPGPHDZYPcYyJPfwgYwjzKGYaUMZOBw7Eh7CQ@mail.gmail.com>
 <20210203094535.GC1687065@kuha.fi.intel.com> <CAJZ5v0j6oY=hXOJtoJ=_vdWqwLDDAO8SJoG1N3nehaAcAz8G8w@mail.gmail.com>
 <20210203142655.GG1687065@kuha.fi.intel.com>
In-Reply-To: <20210203142655.GG1687065@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Feb 2021 15:39:02 +0100
Message-ID: <CAJZ5v0hwjxtADph8=R+F0bgzm1q1EMrrzZMhQQUoHG9O-wdTag@mail.gmail.com>
Subject: Re: [PATCH 1/6] software node: Provide replacement for device_add_properties()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 3:27 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Feb 03, 2021 at 02:50:24PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 3, 2021 at 10:45 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Tue, Feb 02, 2021 at 05:08:40PM +0100, Rafael J. Wysocki wrote:
> > > > It looks like there is a use case that cannot be addressed by using
> > > > device_add_properties() and that's why you need this new function.
> > > >
> > > > Can you describe that use case, please, and explain what the problem
> > > > with using device_add_properties() in it is?
> > >
> > > The problem with device_add_properties() is that it gives false
> > > impression that the device properties are somehow directly attached to
> > > the devices, which is not true. Now, that should not be a major issue,
> > > but it seems that it is. I think Lee Jones basically used that as an
> > > argument to refuse changes (and pretty minor changes) that would have
> > > allowed us to use software nodes with the MFD drivers.
> > >
> > > Nevertheless, I was not planning to provide a replacement for it
> > > originally. We do in any case have the real issue caused by that
> > > device_remove_properties() call in device_del() which has to be fixed.
> >
> > What's that issue, specifically?
>
> The problem is that we can't now reuse or share if necessary, or just
> in general be in charge of the lifetime of the software nodes because
> that call is in device_del(). Now the lifetime of the software nodes
> is always tied to the devices they are attached, no questions asked.

I see and so instead you want the reference counting to trigger the
cleanup when the count gets to 0.

Sounds reasonable to me and please put this information into the patch
changelog.
