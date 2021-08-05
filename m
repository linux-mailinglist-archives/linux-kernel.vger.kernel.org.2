Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB23E0FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhHEHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236977AbhHEHzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:55:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CC7960E53;
        Thu,  5 Aug 2021 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628150135;
        bh=QiUEnspHIRAkgxLeABfnYxzZnyZRQryISrYTf838FMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rFlJUwWJjk7fcKpYFUKLhCEA/XiYbg0JljwDzq67OGE9H3W2IkoQtLCt4zRTXhybt
         wEcbwPx1g+Ph0NZI5vYVPSmtA6v2cDUkVpgxi2potOwMQJ/oVA6BzZWEs6uaqY0BFy
         P31xflsMYQ0/65lBdZzR9KkwzFn0c1uAoUiH8Jck=
Date:   Thu, 5 Aug 2021 09:55:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQuZdVuaGG/Cr62y@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQuYCePPZEmVbkfc@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 09:49:29AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 04, 2021 at 12:50:24PM -0700, Andi Kleen wrote:
> > > And what's wrong with the current method of removing drivers from
> > > devices that you do not want them to be bound to?  We offer that support
> > > for all busses now that want to do it, what driver types are you needing
> > > to "control" here that does not take advantage of the existing
> > > infrastructure that we currently have for this type of thing?
> > 
> > I'm not sure what mechanism you're referring to here, but in general don't
> > want the drivers to initialize at all because they might get exploited in
> > any code that they execute.
> 
> That is exactly the mechanism we have today in the kernel for all busses
> if they wish to take advantage of it.  We have had this for all USB
> drivers for well over a decade now, this is not a new feature.  Please
> use that instead.

Hm, wait, maybe that didn't get merged yet, let me dig...

