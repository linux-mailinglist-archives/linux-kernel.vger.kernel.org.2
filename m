Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACD03B1840
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFWKyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:54:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:44204 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhFWKyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:54:06 -0400
IronPort-SDR: UzbWQu4PATTUcf+7W78kqMHqHRldG/3/hYMhatAhITLLaaCGtX2apxwbyT1iWREd0eHNm9AOjh
 jaVLk6VHNU4w==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="187619021"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="187619021"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 03:51:40 -0700
IronPort-SDR: Z8B5NnycNx7Kz2dMnw1EwWJbJxXq6r9PzjpJQGG0wTMYD9/EdQByIg98NLe8o6zPWjeXjuAqss
 1EzNTF+Q16/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="556929687"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 23 Jun 2021 03:51:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Jun 2021 13:51:37 +0300
Date:   Wed, 23 Jun 2021 13:51:37 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNMSOfKGSeqqZjP6@kuha.fi.intel.com>
References: <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net>
 <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
 <YNBsB6zIo4A4vD4w@kuha.fi.intel.com>
 <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
 <YNGa021IIj+C8H7h@kuha.fi.intel.com>
 <YNHvZGLE9lgS/FRe@kuha.fi.intel.com>
 <CAHp75VfB2oa-YKTv9D2e6GEOnSGyUGUdqSi=GLuvL0v6BqPBFg@mail.gmail.com>
 <CAHp75VdEskqphUVvMnpkxympYxevpP9TamGjyXNVLYezaavCHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdEskqphUVvMnpkxympYxevpP9TamGjyXNVLYezaavCHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 06:30:19PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 22, 2021 at 6:28 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 22, 2021 at 5:10 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > > On Tue, Jun 22, 2021 at 11:09:58AM +0300, Heikki Krogerus wrote:
> >
> > ...
> >
> > > Before I send the patch to Rafael and Greg, can you confirm that the
> > > appropriate API (device_is_registered()) also works? I'm attaching
> > > patch that should be the final version (if it works).
> > >
> > > I'm sorry to bother you with this.
> >
> > In the commit message: happenes -> happens.
> >
> > And you may replace my Cc to the Reviewed-by tag.
> >
> > Thanks for your help!
> 
> One more detail, shouldn't we drop _nowarn as well?

OK. I'll fix those and send the patch to Greg and Rafael.

thanks,,

-- 
heikki
