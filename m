Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2148B354FFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbhDFJfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235857AbhDFJfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:35:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE2E06135D;
        Tue,  6 Apr 2021 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617701698;
        bh=LuZrpJ9SjACJlYKbWRxk7fOEoUkXTHjdnj2dsQk/qjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpvwQO/gp5gn6MOjpflz83q6+j8bfFs/3J7+8k07xoroXe8x419HvxUvx75NBqoLg
         wEiXZnRMH4Q24YL7nTIjbq+3b5WbZLHF0lcEBjdIKYJC9mpEE9gwV3c3rOQTPmedbq
         gDS8h8IxNk/DW50aGRX2fu6vvjA2LM/AaxNfFIG8=
Date:   Tue, 6 Apr 2021 11:34:55 +0200
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
Message-ID: <YGwrP1p0KtAIOoyZ@kroah.com>
References: <20210406040238.1850-1-photranvan0712@gmail.com>
 <YGvuQlxyorJt+ErG@kroah.com>
 <DM6PR11MB44414602F10C6C991A65D48CE3769@DM6PR11MB4441.namprd11.prod.outlook.com>
 <YGwltSD+iEPmRblS@kroah.com>
 <DM6PR11MB4441660856AC72EA5764BD43E3769@DM6PR11MB4441.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4441660856AC72EA5764BD43E3769@DM6PR11MB4441.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 09:25:18AM +0000, Pho Tran wrote:
> Hi Greg!
> Should I send the Patch with new version (PATCH v8) or keep version of the Patch is v7?

Again, please do not top-post.

v8 is needed.

thanks,

greg k-h
