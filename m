Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2225350FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhDAHLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhDAHKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:10:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB99C60FEF;
        Thu,  1 Apr 2021 07:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617261051;
        bh=hBCvfn9cBUbVyzPwPTGBx2KYC5IfCBRbGy9L4ghZ9OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQTjaYBJax7KP/2dDcsHaNkxu/lMlHSajkGO2BqfGEpxDExN2mQCzP/g7SAV//Bfb
         e4itHXKo7lRZe924aKQUJ46iUROgZ3TU78uIexKShsceXrwegin5p6HhASrQMQGl0C
         IDl+DQjTCCfzgG95CzTHt8M2QzHP48I+KRA5HFUQ=
Date:   Thu, 1 Apr 2021 09:10:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     George Zhang <georgezhang@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: vmw_vmci: initialize payload passed to
 vmci_send_datagram()
Message-ID: <YGVx+A7VyV7LVLPW@kroah.com>
References: <20210401055747.3820-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGVlnbTIVsps8FeJ@kroah.com>
 <29011e79-edb4-35ce-10ab-6d0fd5fd2ec5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29011e79-edb4-35ce-10ab-6d0fd5fd2ec5@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:53:02PM +0900, Tetsuo Handa wrote:
> On 2021/04/01 15:18, Greg Kroah-Hartman wrote:
> > On Thu, Apr 01, 2021 at 02:57:47PM +0900, Tetsuo Handa wrote:
> >> KMSAN complains that the vmci_use_ppn64() == false path in
> >> vmci_dbell_register_notification_bitmap() left upper 32bits of
> >> bitmap_set_msg.bitmap_ppn64 member uninitialized.
> >>
> >> KMSAN also complains that vmci_check_host_caps() left the payload part
> >> of check_msg uninitialized.
> >>
> > 
> > What commit does this "fix"?  Can you resend with a proper "Fixes:" tag
> > so we know where it needs to be backported to?
> 
> It seems that this problem exists since the introduction.
> 
>   commit 83e2ec765be03e8a8a07619e65df70b48a1db023
>   Author: George Zhang <georgezhang@vmware.com>
>   Date:   Tue Jan 8 15:53:51 2013 -0800
>   
>       VMCI: doorbell implementation.
>   
>   commit 1f166439917b69d3046e2e49fe923579d9181212
>   Author: George Zhang <georgezhang@vmware.com>
>   Date:   Tue Jan 8 15:55:32 2013 -0800
>   
>       VMCI: guest side driver implementation.
> 
> But this patch should be safe to backport to as old as possible, for
> this patch is merely explicitly initializing variables.

Great, can you please resend with the Fixes: tag and a cc: stable in the
signed-off-by area as well when you resend these as a 2 patch series?

thanks,

greg k-h
