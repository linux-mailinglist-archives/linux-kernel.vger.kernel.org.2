Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9536E97D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 13:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhD2LXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 07:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232317AbhD2LXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 07:23:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E792B6142A;
        Thu, 29 Apr 2021 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619695335;
        bh=jCXcS9pRxcrZC2JZDeCNcSeTZlDS/eX2ZxIUY8hV3yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSer9WpL9VY9Za2h4JeZ7e9sU7Xj9mzPlIFeejL/YmV8dLAvplWdBNVVOnuE/lhDf
         QRrd37uU1lp2RWHEHjgxUuvHHHXYKZLlw9toTbs0Q1xBoEYkVN8ETQtrNmMci6vZa/
         D8LMxKm0E7e+gmmVuQ3oTUsJ5z2A0IudnSxNB09M=
Date:   Thu, 29 Apr 2021 13:22:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: RFC: collection of common distro configs?
Message-ID: <YIqW5a2DTsw7uc9O@kroah.com>
References: <a7fac800-02ae-62d4-00d4-770facff4a7c@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7fac800-02ae-62d4-00d4-770facff4a7c@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:26:54PM +0200, Rasmus Villemoes wrote:
> Hi there,
> 
> Does anybody know of a place where one can find a collection of .configs
> from various distros? I think it might be useful to be able to grep
> around to see what features are actually enabled by which distros.
> 
> Based on the domain name, I hoped linuxconfig.org would be such a place,
> if so I cannot find it.
> 
> If no such collection exists, do others agree it might be useful? If so,
> I'll be happy to throw up a repo somewhere and start collecting them.

It will change on a monthly basis, is this really all that useful?  Who
will keep it up to date?

What are you trying to determine?

thanks,

greg k-h
