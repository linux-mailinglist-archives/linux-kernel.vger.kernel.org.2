Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFDB3F3F75
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhHVNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhHVNYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:24:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 926E960725;
        Sun, 22 Aug 2021 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629638620;
        bh=ycRxLFCmeNIdGPh7gBfzYLg1ElW0LcstWZ9u8bLTpqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yeh1YHjJR+B99G3iR40bCpgW0JhQtDxqvbow0/lux+hCYIWearhAFzYSB3jO9LNez
         42mN+H8zFqxLr6ZGrsIUS0eePpwHm6ggNmJcW3dM+PyZu2549uYIf49PZXZObj1xwr
         pTefrTURqRB7h1A6z3JQ+OiDLhtZP01VeK82kAQc=
Date:   Sun, 22 Aug 2021 15:23:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4.1] include: linux: Reorganize timekeeping and ktime
 headers
Message-ID: <YSJP18Z72t0X+xsp@kroah.com>
References: <b5d4536f-a096-b259-1385-3c1d32754dbf@vt.edu>
 <095645cd-ce53-a803-cb99-522545a409b8@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095645cd-ce53-a803-cb99-522545a409b8@vt.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 09:15:50AM -0400, Carlos Bilbao wrote:
> - v4: 4.0 Fix kernel test robot warnings for ia64 and x86.
>       4.1 Fix kernel test robot warnings for m68k and powerpc.

Please just use whole numbers for patch versions, there's no need for .X
for this type of thing as our tools do not know how to catch that, and
it makes no sense.

Just keep bumping the number please.

greg k-h
