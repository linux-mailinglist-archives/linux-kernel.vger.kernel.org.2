Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE2235C299
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbhDLJqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238966AbhDLJb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:31:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E11896121D;
        Mon, 12 Apr 2021 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618219866;
        bh=AitILzDXOaPxQJDyb5VWuU+H9qTa5Vx2vTYtd7yvvbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0wESZK06EOMBoGHqMcawB5gEZBUbdp/KQ0p40iIbYOMmgTp5GEWWdLFEcog5OTQM
         k1quQMahCaEACeCd/qN9Jk6XhbgpV2DMFAvZIfGcrc/1DHAG4u1a7zEo77oIceu4Gw
         pn/A/W7z7ZiqSBT1xwYuU9m53thBxU5l+TBZIDis=
Date:   Mon, 12 Apr 2021 11:31:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: Remove variable
 set but not used
Message-ID: <YHQTVwx+S82CAJyb@kroah.com>
References: <20210411174143.31618-1-fmdefrancesco@gmail.com>
 <alpine.DEB.2.22.394.2104111943230.11703@hadrien>
 <2836382.q67jgZTtOx@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2836382.q67jgZTtOx@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 08:12:05PM +0200, Fabio M. De Francesco wrote:
> On Sunday, April 11, 2021 7:43:57 PM CEST Julia Lawall wrote:
> > On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > > Remove variable "int ret" which is instantiated but not used.
> > 
> > instantiated -> declared?  I thought instantiated could mean initialized,
> > but that doesn't seem to be the case.
> > 
> > julia
> Please, help me to remind...
> 
> If a local variable is declared but not set to any value, does it take 
> space on the stack?

Maybe, maybe not, doesn't matter either way.

> If I understand your message, it does not. Therefore it is only declared 
> but no memory is allocated for it (i.e., it is not instantiated). Right?
> 
> If you confirm I've understood this topic, I can send a v2 patch.

That's not the issue here at all...

confused,

greg k-h
