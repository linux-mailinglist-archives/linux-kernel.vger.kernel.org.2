Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E733E1ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbhHERsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236276AbhHERsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:48:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1F9E610A2;
        Thu,  5 Aug 2021 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628185702;
        bh=yZOHom4qqFMbgz1bHakl8OM4IIcGcy0PtjbuHhRIXPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oef1xggieo9aPY3hzR/8vPm6bWLHnadq2Lo30KgnPFxmxVuJNA+J3Oeaw4i8/74lV
         z8bdOYmXCxhM7VsKrandNewcr/85eLCDlWn5VudAYgesv0CIq4YXeJi+GqYieGtRHs
         U/dm5YUwNh9EJHk89Q/woxl7M9/OYYrB8bnpQK4M=
Date:   Thu, 5 Aug 2021 19:48:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQwkY7fmEs+3qIEA@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com>
 <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <CAPcyv4iCBknhGyw-YjO7_Tua9Vkw_UCSHVj3prL3mVfz4nj-_g@mail.gmail.com>
 <1e9efeb3-4aef-68e2-6af3-cf6bb5decb38@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e9efeb3-4aef-68e2-6af3-cf6bb5decb38@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:25:32AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 8/5/21 9:37 AM, Dan Williams wrote:
> > I overlooked the "authorized" attribute in usb and thunderbolt. The
> > collision problem makes sense. Are you open to a core "authorized"
> > attribute that buses like usb and thunderbolt would override in favor
> > of their local implementation? I.e. similar to suppress_bind_attrs:
> 
> Even if such overriding is allowed in default boot, it should not be
> allowed in protected guest + driver_filter model.

The kernel has no idea of "protected guest" at the moment so I do not
know what you mean here...
