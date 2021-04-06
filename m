Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D720B354F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbhDFJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240720AbhDFJLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:11:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 211B6613C2;
        Tue,  6 Apr 2021 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617700282;
        bh=7bwSyCq3xl3rvTLlAlTsTLbegvrd4q2jdmctViiGkxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGjX9UmtWnR5X2jA6bAERPpUywrKMTC18dx1213xx1NuaxAsfhuIxz7lIrsToL2bM
         402d//e4qvH6jYtdlRvIvO0A0TikvvhARcdeV9u4W/ehH7WUDqPNc5A59g1jh8fc3K
         xCpGonV7AUKNFaCCcjuRKmKJPOCP2YgtxErfPtFs=
Date:   Tue, 6 Apr 2021 11:11:17 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     'Pho Tran' <photranvan0712@gmail.com>,
        "'johan@kernel.org'" <johan@kernel.org>,
        "'linux-usb@vger.kernel.org'" <linux-usb@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>,
        'Kernel test robot' <lkp@intel.com>
Subject: Re: [PATCH v7] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YGwltSD+iEPmRblS@kroah.com>
References: <20210406040238.1850-1-photranvan0712@gmail.com>
 <YGvuQlxyorJt+ErG@kroah.com>
 <DM6PR11MB44414602F10C6C991A65D48CE3769@DM6PR11MB4441.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB44414602F10C6C991A65D48CE3769@DM6PR11MB4441.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Tue, Apr 06, 2021 at 08:17:42AM +0000, Pho Tran wrote:
> Hi Greg!
> I am grateful for your promptly reply!
>  Yesterday, I got the response from the kernel test robot with this message: 
> " If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>". 
> It's a reason why I added "Reported-by: kernel test robot <lkp@intel.com>" 
> to my new Patch.
> Could you tell me what I need to do in the next step to submit this patch to the kernel mainline?
> Once again, Thank you a lot!

If you fixed this as an add-on patch, yes it would belong in the
reported-by:  But as you are just fixing this up to a patch that has not
been accepted yet, all you need to do is write it in the "what changed
from the previous version" section of the changelog, below the --- line.

thanks,

greg k-h
