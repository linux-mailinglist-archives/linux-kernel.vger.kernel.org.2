Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B724358054
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhDHKLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:11:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHKLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:11:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617876660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ungriHiX5fEUPDsMxDg6ldWqj8gfMRUm2LRwontY2qo=;
        b=stwSvQVHWURq+vF8p7oLTd/SCbf3kRN3L6USW3KVD73irNdO8on2X9pIdoK2339hUFUITX
        kk1kL7OlsmKFmMBLhz6hyx16Gy8P+4+z7OMz3mnKDlEgh4kthKW7fsiHHe9kppmJBbV7lR
        lhy+30fF03B/Odu13ZOhxyrqTKb6Lg4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1ABCAAFCC;
        Thu,  8 Apr 2021 10:11:00 +0000 (UTC)
Message-ID: <2c67dd97bbdc81369eb297fdb7ac58616110fb77.camel@suse.com>
Subject: Re: [PATCH 3/4] USB: serial: add support for multi-interface
 functions
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 12:10:48 +0200
In-Reply-To: <YGV6O5jycIj9Nv9Z@hovoldconsulting.com>
References: <20210330143820.9103-1-johan@kernel.org>
         <20210330143820.9103-4-johan@kernel.org>
         <e0b2984e7de0287c5811a10faaac4d5d6d7d91ef.camel@suse.com>
         <YGNCIT1ocatZ3V3/@hovoldconsulting.com>
         <e4d3d21cdfe94068c76ceb4ba38630d76fa9418c.camel@suse.com>
         <3ae68552f3c689c23cbf2573772239c00e2c94be.camel@suse.com>
         <YGV6O5jycIj9Nv9Z@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 01.04.2021, 09:46 +0200 schrieb Johan Hovold:
> On Wed, Mar 31, 2021 at 01:21:15PM +0200, Oliver Neukum wrote:
> > Am Mittwoch, den 31.03.2021, 09:08 +0200 schrieb Oliver Neukum:

> > on the third hand, the more I look at this, would you mind putting
> > sibling_release() with a modified name into usbcore? This functionality
> > is not limited to serial drivers. btusb needs it; cdc-acm needs it;
> > usbaudio neds it. We have code duplication.
> 
> Tell me about it. ;) Unfortunately, drivers all tend to handle this
> slightly different, for example, using a disconnected flag, some claim
> more than one other interface, others look like they may be using their
> interface data as a flag for other purposes, etc.
> 
> At some point we could unify all this but until then I don't think
> putting only half of an interface into core makes much sense.

OK, very well, then let's look at this from a fundamental point
and design a bit. First, can we disregard the case of more than
two interfaces?

	Regards
		Oliver


