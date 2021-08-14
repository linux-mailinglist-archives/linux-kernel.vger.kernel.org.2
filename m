Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349D23EC3F0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbhHNQvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 12:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhHNQvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:51:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 998DE60C3F;
        Sat, 14 Aug 2021 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628959878;
        bh=VGvyUX+8AuHJ3eE8+d6NOBplowHQI6uJJayRDqyGygs=;
        h=Date:From:To:Cc:Subject:From;
        b=U+M6mqLoNEOJwIpPd8W1kfTC4wB1xKt6ZnGtTM7/ozIa6lHh5wINVdBVQCFwtsEg1
         XqubzeXTm1Gbtyl+eaKyC7FYn+B7G0nLaffrNDUkTXneJv45XHM1MvO4KmVDnW4TbX
         m9gTqQpYPHJxHc8LTEgJeQbXH+Zoe3bhW2Vk+PQU=
Date:   Sat, 14 Aug 2021 18:51:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fix for 5.14-rc6
Message-ID: <YRf0g0jpHTNIhObs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.14-rc6

for you to fetch changes up to 664cc971fb259007e49cc8a3ac43b0787d89443f:

  Revert "usb: dwc3: gadget: Use list_replace_init() before traversing lists" (2021-08-10 09:12:32 +0200)

----------------------------------------------------------------
USB fix for 5.14-rc6

Here is a single revert of a commit that caused problems in 5.14-rc5 for
5.14-rc6.  It has been in linux-next almost all week, and has resolved
the issues that were reported on lots of different systems that were not
the platform that the change was originally tested on (gotta love SoC
cores used in multiple devices from multiple vendors...)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "usb: dwc3: gadget: Use list_replace_init() before traversing lists"

 drivers/usb/dwc3/gadget.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)
