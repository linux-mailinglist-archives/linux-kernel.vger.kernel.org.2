Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4540D3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhIPH3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhIPH3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:29:21 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A544C061574;
        Thu, 16 Sep 2021 00:28:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g11so4747132qtk.5;
        Thu, 16 Sep 2021 00:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVbyhvmeHGYeGOFh7qjQY4cFr9i92ZBaof0BazQUorI=;
        b=hOKvbfNdu+GhgoP1GNbaEScCzXmyTWBWgdYBhb5l8fstFGaqVohSBlYUQJmQlFdd10
         7/AT/hWvHODQNjcP1ij+cWi0UtdJYXMB+uxKm3dwk9CLaIygKK9PlF3KWSiXERJWi5ku
         qf3g6KdrqLRx7T0+CVDKk6QZ9b8jvw5+88YNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVbyhvmeHGYeGOFh7qjQY4cFr9i92ZBaof0BazQUorI=;
        b=DjTrifoZBiTdCS4SuZ1mC3mFzXHh2SneO704z1OUD43TL9B1TM46jX8zX4O5VeI/OB
         fhUadqPv27RVcK1rMJyp5YpxygyiNfWs+xK6T2IrywISWO8VOJghjXYVeVpzbLNFAOBQ
         r6S26UC4WhH9cQ2gnftmtrQFTUUDToBm35m+hwOpPquq+PPpvjvrPtiZnb3nfEAo10Y5
         OVK6GmpDWSD3vD1YcTglcN51pKkAhnXRabrvivftQhq8HMOEOqZt1xaGkGtnH8xGvuJc
         sCFq9zDBYZE2RDyc66xVX/uL9Suj8vrvgcV8dUYeOLynP1By64ZQI1xqDITYe/IlF4s0
         Fnrw==
X-Gm-Message-State: AOAM530pRucRnpdQGWGf0jVm4Z/aVBARIvpXtOcTvNVq0jY6m6ZtQ6Uj
        vUjfzrYAUYucx18/qyme15Ufu3zWWgsakPfgC9E=
X-Google-Smtp-Source: ABdhPJxcKmaCp7WgCIndqSTIhP31PNoyITQMAxTDCqB49y2c4oqobHacueUm6hYd6oIICTiHiNkLmYbi1LF+89qnlV4=
X-Received: by 2002:a05:622a:15d2:: with SMTP id d18mr3628592qty.145.1631777280136;
 Thu, 16 Sep 2021 00:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210914213543.73351-1-eajames@linux.ibm.com> <20210914213543.73351-4-eajames@linux.ibm.com>
 <20210915161333.GA3712393@roeck-us.net> <ac8d30e988ab6cc16d4c7446d259b87deb734910.camel@linux.ibm.com>
In-Reply-To: <ac8d30e988ab6cc16d4c7446d259b87deb734910.camel@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 16 Sep 2021 07:27:48 +0000
Message-ID: <CACPK8Xfqf7siS9jtQbrd5mDNmCURS2==B3wGXpHibB8546o60g@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-fsi@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sept 2021 at 21:11, Eddie James <eajames@linux.ibm.com> wrote:
>
> On Wed, 2021-09-15 at 09:13 -0700, Guenter Roeck wrote:
> > On Tue, Sep 14, 2021 at 04:35:43PM -0500, Eddie James wrote:
> > > Save any FFDC provided by the OCC driver, and provide it to
> > > userspace
> > > through a binary sysfs entry. Do some basic state management to
> > > ensure that userspace can always collect the data if there was an
> > > error. Notify polling userspace when there is an error too.
> > >
> > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >
> > This is now the 2nd series that we have pending, and the first series
> > (from July) still didn't make it into the upstream kernel because the
> > fsi code
> > seems to go nowhere. Any chance to address that ?
>
> Yes... Joel, can we merge that? I don't have any comments to address.

Thanks for the reminder. We have a queue of FSI patches to send out. I
hope to get that done this coming merge window.

Cheers,

Joel
