Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629FA35337F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhDCK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 06:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236484AbhDCKvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 06:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCFA461006;
        Sat,  3 Apr 2021 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617447092;
        bh=11fo+56dWWE978yMT6knzohG9xQgkQgPOTSHpycPBKg=;
        h=Date:From:To:Cc:Subject:From;
        b=iODyNnDoc2XLXNx0IK2AAKuUjgENp0UBjT8GWq45PbsiCOCG3zxZ1gYeYYIOS7g0S
         VJa8P+i0OEXD73AODyePGGP/eUdFMX87d3hIh74iBwO6Uf+71nczu308F2/DUqSDI9
         GAOZeeiSOcugHR5CtxhoJohl+aWi6w1kJ6vKN2Bg=
Date:   Sat, 3 Apr 2021 12:51:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fix for 5.12-rc6
Message-ID: <YGhIsWHsP474a+dE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.12-rc6

for you to fetch changes up to e78836ae76d20f38eed8c8c67f21db97529949da:

  staging: rtl8192e: Change state information from u16 to u8 (2021-03-23 13:32:40 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.12-rc6

Here are 2 rtl8192e staging driver fixes for reported problems.  Both of
these have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Atul Gopinathan (2):
      staging: rtl8192e: Fix incorrect source in memcpy()
      staging: rtl8192e: Change state information from u16 to u8

 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
