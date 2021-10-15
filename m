Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E90A42EA7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhJOHqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:46:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:13075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236189AbhJOHqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:46:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="215033263"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="215033263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 00:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="627236218"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 15 Oct 2021 00:44:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Oct 2021 10:44:07 +0300
Date:   Fri, 15 Oct 2021 10:44:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] usb: Link the ports to the connectors they are
 attached to
Message-ID: <YWkxR03lLRPlXTqy@kuha.fi.intel.com>
References: <20210407065555.88110-1-heikki.krogerus@linux.intel.com>
 <20210407065555.88110-3-heikki.krogerus@linux.intel.com>
 <YWdBZY7vSWO7DN54@google.com>
 <d82e9972-0d30-f9f4-9333-de57146d5543@roeck-us.net>
 <CACeCKaf4OOkzchrNMfWF5Y9ayrfKcyJtZ6XPHaBUzc7K6t+e+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaf4OOkzchrNMfWF5Y9ayrfKcyJtZ6XPHaBUzc7K6t+e+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:16:38PM -0700, Prashant Malani wrote:
> On Wed, Oct 13, 2021 at 1:57 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 10/13/21 1:28 PM, Prashant Malani wrote:
> > > Hi,
> > >
> > > On Wed, Apr 07, 2021 at 09:55:53AM +0300, Heikki Krogerus wrote:
> > >> Creating link to the USB Type-C connector for every new port
> > >> that is added when possible.
> > >>
> > >> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > >
> > > Did this patch eventually get merged?
> > > I somehow don't see it in the "master" kernel branch [1], although I do
> > > see the commit in that repo [2].
> > >
> >
> > It was applied but later reverted with commit 5bdb080f9603 because
> > it created a module dependency cycle.
> >
> 
> Ah I see. Thanks Guenter.
> Hi Heikki, I was interested in knowing if relanding this is on your radar.

Ah, I'm sorry guys, I forgot about this patch. I'll put it back to my
task list. If you are interested in fixing this, and have time to do
that, go right ahead. Let me know.


thanks,

-- 
heikki
