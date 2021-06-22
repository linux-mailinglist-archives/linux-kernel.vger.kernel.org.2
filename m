Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E43B0B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhFVRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:21:43 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:48718 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhFVRVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:21:40 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id CEA9F20002B;
        Tue, 22 Jun 2021 17:19:22 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 7C6B9804CD; Tue, 22 Jun 2021 19:19:19 +0200 (CEST)
Date:   Tue, 22 Jun 2021 19:19:19 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNIbl8Y2Efbp+dA1@owl.dominikbrodowski.net>
References: <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net>
 <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
 <YNBsB6zIo4A4vD4w@kuha.fi.intel.com>
 <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
 <YNGa021IIj+C8H7h@kuha.fi.intel.com>
 <YNHvZGLE9lgS/FRe@kuha.fi.intel.com>
 <YNH1bo6BesNGY3gu@owl.dominikbrodowski.net>
 <CAHp75VffvF0R4qmunbDKpaQpTj900Pv6KK31KNkEfuDuvUSN-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VffvF0R4qmunbDKpaQpTj900Pv6KK31KNkEfuDuvUSN-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Tue, Jun 22, 2021 at 06:28:41PM +0300 schrieb Andy Shevchenko:
> On Tue, Jun 22, 2021 at 5:37 PM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > Am Tue, Jun 22, 2021 at 05:10:44PM +0300 schrieb Heikki Krogerus:
> > > On Tue, Jun 22, 2021 at 11:09:58AM +0300, Heikki Krogerus wrote:
> 
> ...
> 
> > > Before I send the patch to Rafael and Greg, can you confirm that the
> > > appropriate API (device_is_registered()) also works? I'm attaching
> > > patch that should be the final version (if it works).
> >
> > Heikki, that works perfectly. Many thanks, especially for the speedy
> > development of the bugfix!
> 
> May we transform this to the Tested-by tag?

Indeed:

	Reported-and-tested-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
