Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE58B40A735
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbhINHRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235026AbhINHRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:17:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED5F161151;
        Tue, 14 Sep 2021 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631603751;
        bh=nFQvaYJAuEHYUk8dVRaRPaKxqzp+RqQSt8+lFkFM3PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSy70ut9M5z/HtmHmv6toBLC5ewltUq64ZWTu0hf3SRVRqN85Nls1R/Sc4ZkRojIV
         GB+hR1Lqz5JVZtmC3pD6VJjicngVcxby5kz4kC9xHGBpoEm73vqVuM32P/B0YGqTFf
         rP87SdFINikebWcHdOvjgGC0bFkQHhoNbIehiFQU=
Date:   Tue, 14 Sep 2021 09:15:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] staging: r8188eu: power management cleanup
Message-ID: <YUBMGWjFe/vt4uo5@kroah.com>
References: <20210911141521.24901-1-martin@kaiser.cx>
 <YT96cYdbN/n5OY+S@kroah.com>
 <20210913193733.nh5fijjo5jlsmqpk@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913193733.nh5fijjo5jlsmqpk@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 09:37:33PM +0200, Martin Kaiser wrote:
> Thus wrote Greg Kroah-Hartman (gregkh@linuxfoundation.org):
> 
> > On Sat, Sep 11, 2021 at 04:15:09PM +0200, Martin Kaiser wrote:
> > > Remove some unused parts of the power management code.
> 
> > > Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.
> 
> > > Martin Kaiser (12):
> > >   staging: r8188eu: btcoex_rfon is always false
> > >   staging: r8188eu: setting HW_VAR_SET_RPWM does nothing
> > >   staging: r8188eu: remove write-only variable cpwm
> > >   staging: r8188eu: remove write-only variable tog
> > >   staging: r8188eu: remove rtw_set_rpwm
> > >   staging: r8188eu: remove unused power state defines
> > >   staging: r8188eu: _free_pwrlock is empty
> > >   staging: r8188eu: remove unused pwrctrl definitions
> > >   staging: r8188eu: remove unused enum and array
> > >   staging: r8188eu: rtw_set_ips_deny is not used
> > >   staging: r8188eu: remove unused variable cpwm_tog
> > >   staging: r8188eu: remove unused variable b_hw_radio_off
> 
> > I applied a subset of these.  Please rebase and resend the reset.
> 
> I sent a v2 of this patchset with the outstanding patches as a followup
> to this set. I hope that this is generally the right thing to do after
> the maintainer applies some patches of a set.

That works, thanks!

greg k-h
