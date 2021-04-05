Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7D35412D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbhDEKa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhDEKa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:30:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91C8861002;
        Mon,  5 Apr 2021 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617618651;
        bh=lcxHTMYDUSd1XdjxxNQLYgqHz+59uSOPECsIc3Gofaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/ulKZTSkmEj0IN/bndFKi+B3DqapCk7dGlpgVGV98qRzGlnUZ1bDsd06Fmnuy5I2
         /mhJmMkI81pnR1i7gfMm7Y53INlMUXdSsl6fyNu+fArzLQy6kI1SyrdWlXPYWVX2Hj
         vgggZ4aN9f1SyInj/l5ttee7UYoamAvJO9gsHTo0=
Date:   Mon, 5 Apr 2021 12:30:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCHv2 RESEND] firmware: stratix10-svc: build only on 64-bit
 ARM
Message-ID: <YGrm2GFdX/PMXiwk@kroah.com>
References: <20210404124609.122377-1-dinguyen@kernel.org>
 <YGnIdZ5mbTJnREGB@kroah.com>
 <943c4179-409d-24f5-4324-7f2242920cc5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <943c4179-409d-24f5-4324-7f2242920cc5@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 10:20:26AM -0500, Dinh Nguyen wrote:
> 
> 
> On 4/4/21 9:08 AM, Greg KH wrote:
> > On Sun, Apr 04, 2021 at 07:46:09AM -0500, Dinh Nguyen wrote:
> > > From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > 
> > > The Stratix10 service layer and RCU drivers are useful only on
> > > Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
> > > fails:
> > > 
> > >    drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
> > >    include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
> > >      declared with attribute error: FIELD_GET: type of reg too small for mask
> > >      _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> > >    ...
> > >    drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
> > >      priv->status.version = FIELD_GET(RSU_VERSION_MASK,
> > > 
> > > Fixes: 4483397b0353 ("ARM: socfpga: drop ARCH_SOCFPGA")
> > 
> > Where is this commit id?  I don't see it in Linus's tree, is it
> > somewhere else?
> > 
> 
> It's in the for-next branch in the soc tree. This patch fixes a patch that
> was just recently submitted by Krzysztof.

Then it needs to go through that tree, while you sent it "To:" me, and I
can't do anything with it at the moment :(

thanks,

greg k-h
