Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18671341617
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhCSGmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233953AbhCSGmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:42:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 161C761494;
        Fri, 19 Mar 2021 06:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616136133;
        bh=ImAkHCzc5WG0y4vB0/Y3CwDPIGZqeshxLO/Zc3IXzbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PxSfUAjkeal3bOELDTpmmQW/oqR3J3HzNEKu0vjX1shqnHkyEv2BT8O7hP0iOWxUy
         SatHJf28MHUmWLigGhpqRt4Gd9CEvE0eQSohx01D83PbqGMdeQ1sbVopCj6R7Ahwzj
         O3Dz269nJxGFYaDJMT8hzo1RXajXEyUez/bV/UYw=
Date:   Fri, 19 Mar 2021 07:42:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul McQuade <paulmcquad@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtl8188eu: Removed Unnecessary ftrace-like logging
Message-ID: <YFRHwr2lWw/dehOz@kroah.com>
References: <20210318200527.454486-1-paulmcquad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318200527.454486-1-paulmcquad@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 08:05:27PM +0000, Paul McQuade wrote:
> prefer using ftrace

You need to say more here than just this please.

Also please fix up your subject line to have "staging:" in it, otherwise
it gets easily lost.

thanks,

greg k-h
