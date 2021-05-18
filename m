Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C738793C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349383AbhERMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:55:07 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37581 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349378AbhERMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:54:39 -0400
Received: by mail-oi1-f174.google.com with SMTP id h9so9673499oih.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QT2Iwiu7Ufcs6EfabXWFcRHNA85+LzV8OWphAen84Q=;
        b=Y2UUZCz4UIis/ImROAypQ5yQc5ToKWRgBJDBTlCULtV0sVQYgvtEXKBNm+v8uSe/XQ
         LcJaP3A9v5foygMyyP5DJUaPw+wNdBR/K6N7Mon+fozlM0l25MX2yWNHqss93tzMQ5iO
         zaCK57alxxc3PyKPTOClUp9J7DqYd3SjTxb9lKojde92YRDAZ56dB6QjBXwqZbybZKPo
         tUY3K1lp7T+DkjP8A9IHL84z3+y7FW49d5dUNzudTsTo5faaQlKSkwvgQ4DxooSvbtH1
         7MM1OYrE1Mr52kSGkITIJa4MbHw1/R7rx+QFHe330TIPMLDsbHs/7rTd+h7Nl9ugUABF
         X2zw==
X-Gm-Message-State: AOAM531wz+AJBTr1VpUY83ykLSij2zbFEPJnsgn9T8WWuGilbx1iPRVJ
        Lpu0UFqAPJhzfCWPaRTsEe7ha5q+5pLyat6KvUSC6IdB
X-Google-Smtp-Source: ABdhPJz4f22obT2zlz+cnGz2Jw9sBkFsoJ7LRicguy/nNs+ZhucmI1IKOhsHn6WkMiCuyfeVEs8nvkMGXrLYXoATxr0=
X-Received: by 2002:aca:4758:: with SMTP id u85mr406947oia.71.1621342400780;
 Tue, 18 May 2021 05:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
 <YKOB6lRqc5DKo2GS@smile.fi.intel.com> <YKOjRyGlx6bHtgZc@kuha.fi.intel.com>
 <YKOlcQqLarSIxE37@kuha.fi.intel.com> <YKOplS4Z4lleYWht@smile.fi.intel.com> <YKO1wiwCzSx62OIK@kroah.com>
In-Reply-To: <YKO1wiwCzSx62OIK@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 May 2021 14:53:09 +0200
Message-ID: <CAJZ5v0hyXOQuLCKB9D_-j64VK-syo5AZmSgEGRHSyuMyvVciOg@mail.gmail.com>
Subject: Re: [PATCH 0/2] driver core: platform: Remove platform_device_add_properties()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 2:40 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 18, 2021 at 02:48:37PM +0300, Andy Shevchenko wrote:
> > On Tue, May 18, 2021 at 02:30:57PM +0300, Heikki Krogerus wrote:
> > > On Tue, May 18, 2021 at 02:21:46PM +0300, Heikki Krogerus wrote:
> > > > On Tue, May 18, 2021 at 11:59:22AM +0300, Andy Shevchenko wrote:
> > > > > On Tue, May 18, 2021 at 11:30:44AM +0300, Heikki Krogerus wrote:
> > > > > > Hi,
> > > > > >
> > > > > > It looks like there is only one place left that still uses the
> > > > > > function. Converting that last user and removing the thing.
> > > > > >
> > > > > > Note, I'm actually resending the patch for board-paz00.c. I'm assuming
> > > > > > the original patch slipped through the cracks because it did not end
> > > > > > up anywhere.
> > > > >
> > > > > Cool!
> > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > >
> > > > > Btw, which base have you used for this series?
> > > >
> > > > intel-next for this one.
> > >
> > > I mean linux-next :-)
> >
> > Let's wait for CIs to respond. I have a feeling that the first patch is good
> > for v5.14, while the second one is probably for the next cycle.
>
> Why?  I can take both now, no problem...

Not really, there are dependencies, one in my tree ATM.

It's better if I take them IMHO.
