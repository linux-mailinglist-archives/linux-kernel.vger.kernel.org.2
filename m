Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B758745F0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354485AbhKZP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378065AbhKZP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:27:48 -0500
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 07:21:29 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5CC061792
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:21:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AF54622AE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C60BC93056;
        Fri, 26 Nov 2021 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637939754;
        bh=Wicu8F7sjJX7obp59U8Ejw+C7HFE8KoX78DAmgaKJEI=;
        h=Date:From:To:Cc:Subject:From;
        b=XLAcFgmjV+rvGZUWzGjDcMD96774LVw/DCZnCCDrYXJ8x/8IdjoqTwtWFwK8RRSaz
         mKNbJIc0xVTldlnFksttaLQ+DD4Y2/ZIq73jOvrt6924iNZVKn5ppCKuaLk7kNpCHc
         /hI18GJelCwJBkt70hAnyf6tmmp4hDzo1zn8br8I=
Date:   Fri, 26 Nov 2021 16:15:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 5.16-rc3
Message-ID: <YaD6J4/erxgzssrB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc3

for you to fetch changes up to c21a80ca0684ec2910344d72556c816cb8940c01:

  binder: fix test regression due to sender_euid change (2021-11-17 16:08:52 +0100)

----------------------------------------------------------------
Char/Misc driver fix for 5.16-rc3

Here is a single binder driver fix for 5.16-rc3.

It resolves a problem reported in the set of binder fixes that went into
5.16-rc1.  It has been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Todd Kjos (1):
      binder: fix test regression due to sender_euid change

 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
