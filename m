Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625F235337D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 12:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhDCKvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 06:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236479AbhDCKvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 06:51:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D7FA6121E;
        Sat,  3 Apr 2021 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617447065;
        bh=lE6423WWcgGb+6oVObRyK0L/d7wX1r9/rJMQY8eXRTg=;
        h=Date:From:To:Cc:Subject:From;
        b=GDVCwiHIDhwmxWDEYtDURYVvLKYqEKC7rDeBjACZmWGQ5EmFH0mk4aDfG0YjxNKkT
         UIwtNBSq8sX0+tkeZSFfRu6GxpLWGapurZLqC+zVtjVKGQcrwWAFIbYcgI60Dh9nWr
         3dj+VVPb1p906vb8FN+bNUFpyCPZ/uUUHnnFRux0=
Date:   Sat, 3 Apr 2021 12:51:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] Serial driver fix for 5.12-rc6
Message-ID: <YGhIlsp8p19O+yy3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc6

for you to fetch changes up to 29d96eb261345c8d888e248ae79484e681be2faa:

  soc: qcom-geni-se: Cleanup the code to remove proxy votes (2021-03-26 15:16:05 +0100)

----------------------------------------------------------------
Serial driver fix for 5.12-rc6

Here is a single serial driver fix for 5.12-rc6.  Is is a revert of a
change that showed up in 5.9 that has been reported to cause problems.

It has been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Roja Rani Yarubandi (1):
      soc: qcom-geni-se: Cleanup the code to remove proxy votes

 drivers/soc/qcom/qcom-geni-se.c       | 74 -----------------------------------
 drivers/tty/serial/qcom_geni_serial.c |  7 ----
 include/linux/qcom-geni-se.h          |  2 -
 3 files changed, 83 deletions(-)
