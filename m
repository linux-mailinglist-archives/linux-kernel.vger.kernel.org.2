Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4932F444EC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhKDGYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhKDGYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:24:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DBB8611C9;
        Thu,  4 Nov 2021 06:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636006902;
        bh=ljBsjz769VaC8m46dh4BZTBTEtz9FbGD82T8llITUBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGSbvuoY2r6O26Ti7ZN30Eh46Veu4QakqFeD/trTenjvGZYwKsBnQrRNYs/BrMA2f
         wUtlqouVUp2zwfhwDt1WP9LhSyueF4kfeFHsKwUF2v1BX1qAY5S7sWC4d4dLc57nuK
         +eCGykLPo1FjuFJ/WtlloQwTKMs4aC1+fXRoFLSY=
Date:   Thu, 4 Nov 2021 07:21:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5] include: linux: Reorganize timekeeping and ktime
 headers
Message-ID: <YYN78YlFrV0vFPq9@kroah.com>
References: <b5d4536f-a096-b259-1385-3c1d32754dbf@vt.edu>
 <095645cd-ce53-a803-cb99-522545a409b8@vt.edu>
 <YSJP18Z72t0X+xsp@kroah.com>
 <1c156aca-d0ad-e7e8-2238-5c3d904d171c@vt.edu>
 <327f5c2f-b996-8aa1-cbbf-3354e01ee1f3@vt.edu>
 <fb66b935-b498-723a-1f05-f02648f8f580@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb66b935-b498-723a-1f05-f02648f8f580@vt.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 03:33:52PM -0400, Carlos Bilbao wrote:
> Hello everyone,
> 
> Some time ago I sent a small patch to avoid implicit function declaration. 
> In particular, timekeeping.h was using ktime_to_ns(), a static function defined 
> in a header it does no include, ktime.h. Some maintainers saw this as an 
> opportunity to reorganize ktime, and so I did and tested for all architectures.
> Now, this patch has fallen into the "limbo of patches", so the original problem
> remains unsolved. Please, either take a look at this or check the original
> patch for the header dependencies.

Please just resend after 5.16-rc1 is out, there's nothing we can do with
this at this point in time.

thanks,

greg k-h
