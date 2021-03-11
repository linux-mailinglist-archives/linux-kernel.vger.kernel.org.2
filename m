Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71D336DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhCKIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:23:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:26150 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhCKIXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:23:09 -0500
IronPort-SDR: uydRjFS/62Lt2iVT4A2aDsgwMS5v3hYk5Bh+CCLPNi6cEjHf+TznRLQoVmAFThrHszvUZxJzKg
 +qWXr3fr/4ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="252649507"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="252649507"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 00:23:09 -0800
IronPort-SDR: mxAc5cHEm7yMS29HbwH/QaczNjfOAkw8Zyk4zbqALoFOqYgvM5tBjZA6T5CdRINUFPTekoMWNE
 JVUZT45S8IaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="509953979"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Mar 2021 00:23:07 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 11 Mar 2021 10:23:06 +0200
Date:   Thu, 11 Mar 2021 10:23:06 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] software node: Two fixes
Message-ID: <YEnTavP7B6MQHWam@kuha.fi.intel.com>
References: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
 <YEdTGsr6CjUirOsn@smile.fi.intel.com>
 <CAJZ5v0ivHnHNTFPXKSgiKYY0fKiqSWuBaLh6noqE3xQEFC2-pA@mail.gmail.com>
 <YEh3FGTExpE3IGhb@kuha.fi.intel.com>
 <CAJZ5v0j1GDoqYKHfts-pQtkNQYpYsvCxeradmDQMLYMVY024mw@mail.gmail.com>
 <CAJZ5v0hoM8zXjwxzzNbUKjVqmXfXZnrgryRdy8LE0E230iZWnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hoM8zXjwxzzNbUKjVqmXfXZnrgryRdy8LE0E230iZWnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 03:30:09PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 10, 2021 at 3:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Mar 10, 2021 at 8:36 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Tue, Mar 09, 2021 at 02:51:22PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Mar 9, 2021 at 11:51 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, Mar 01, 2021 at 05:30:10PM +0300, Heikki Krogerus wrote:
> > > > > > Hi,
> > > > > >
> > > > > > The second one only affects 5.12-rc1.
> > > > >
> > > > > Rafael, Greg, can this be applied for v5.12-rcX?
> > > >
> > > > Do you have a pointer to this?
> > >
> > > Pointer?
> >
> > Never mind, I'll pick them up from the archive.
> 
> Both [1-2/2] applied as 5.12-rc material now, thanks!
> 
> However, I would appreciate CCing swnode-related material to linux-acpi.

Sure think. Maybe it would be better to add an entry for the thing to
the MAINTAINERS file. That way we can make linux-acpi the ml for it. I
have half automated the preparation of patches and I rely on the
get_maintainer.pl script, so it would make at least my life a bit
easier :-).

I'll send you the patch. I'll make myself and Andy the reviewers.

thanks,

-- 
heikki
