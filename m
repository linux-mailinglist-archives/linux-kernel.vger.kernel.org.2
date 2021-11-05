Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D24466D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhKEQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234031AbhKEQSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:18:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7A22604DA;
        Fri,  5 Nov 2021 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636128945;
        bh=eSi2TxojiiMOdXbuKV6Ip/WfgZgHSEspnMEj6sfvcw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEYW6y5871BDRLKZrKbXuAZvyS7XQlm7dSk/rrkZMQb1+ivyocXHXl9F8pbwbTp3v
         6Ks3HJEGEH3EZvpHpHe8fwXFDA+CnoBLvNc/hDQ4zvcdSXmaS6l1GeyEqKi0deaYdJ
         FPiCuH3wi18aQy0pCxBiZQKzmRsYkYea4DKERTpI=
Date:   Fri, 5 Nov 2021 17:15:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     stern@rowland.harvard.edu, mr.yming81@gmail.com,
        chunfeng.yun@mediatek.com, matthias.bgg@gmail.com,
        nishadkamdar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, eddie.hung@mediatek.com
Subject: Re: [PATCH] xhci: Fix USB 3.1 enumeration issues by increasing
 roothub power-on-good delay
Message-ID: <YYVYrksU5/aCB3Fd@kroah.com>
References: <20211105133050.GA1590803@rowland.harvard.edu>
 <20211105160036.549516-1-mathias.nyman@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105160036.549516-1-mathias.nyman@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 06:00:36PM +0200, Mathias Nyman wrote:
> Some USB 3.1 enumeration issues were reported after the hub driver removed
> the minimum 100ms limit for the power-on-good delay.
> 
> Since commit 90d28fb53d4a ("usb: core: reduce power-on-good delay time of
> root hub") the hub driver sets the power-on-delay based on the
> bPwrOn2PwrGood value in the hub descriptor.
> 
> xhci driver has a 20ms bPwrOn2PwrGood value for both roothubs based
> on xhci spec section 5.4.8, but it's clearly not enough for the
> USB 3.1 devices, causing enumeration issues.
> 
> Tests indicate full 100ms delay is needed.
> 
> Reported-by: Walt Jr. Brake <mr.yming81@gmail.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

So this needs:
	Fixes: 90d28fb53d4a ("usb: core: reduce power-on-good delay time of root hub")
right?

thanks,

greg k-h
