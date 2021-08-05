Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AAD3E0F99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhHEHur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhHEHup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:50:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AA0B60E52;
        Thu,  5 Aug 2021 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628149832;
        bh=IfDGT3CJpSAkyCOes60sLQqs86j1EQBH2nZKN5/U2cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QV49Q7qgT4me+2nhzciEzpt4zkloppO+EN9Nw/872uE9xdiUf39JQ+hGHb2w2iEzN
         9JGGvj60ozU19m9dPoO37zgfwa/RoPdKS2x7MaWBqbFIMxwNqgpvRzOUFUjWGx4QXM
         laUxoMNPMrabPiIFfyNsjpJSmp5wG36S21AabyTM=
Date:   Thu, 5 Aug 2021 09:50:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQuYRZ9+lfwprA14@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <56f15095-f1aa-88bc-9335-e0147bdcc573@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56f15095-f1aa-88bc-9335-e0147bdcc573@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 01:09:07PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 8/4/21 12:50 PM, Andi Kleen wrote:
> > 
> > > And what's wrong with the current method of removing drivers from
> > > devices that you do not want them to be bound to?  We offer that support
> > > for all busses now that want to do it, what driver types are you needing
> > > to "control" here that does not take advantage of the existing
> > > infrastructure that we currently have for this type of thing?
> > 
> > I'm not sure what mechanism you're referring to here, but in general
> > don't want the drivers to initialize at all because they might get
> > exploited in any code that they execute.The intention is to disable all
> > drivers except for a small allow list, because it's not practical to
> > harden all 25M lines of Linux code.
> 
> Yes, we are not trying to remove the drivers via sysfs. If driver
> filter is enabled, "allowed" sysfs file is used to view the driver
> filter status (allowed/denied). And a write to that file changes
> the allowed/denied status of the driver. It has nothing to do
> with bind/unbind operations.

Again, we have this already today, with full sysfs control in userspace.
Why add yet-another-way to do this?  What is lacking in the existing
functionality that needs to be expanded on?

greg k-h
