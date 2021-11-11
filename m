Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866C844D41C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhKKJfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhKKJfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:35:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3EF9610F8;
        Thu, 11 Nov 2021 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636623153;
        bh=oEjMLlRChWQ0aWNYFGn9UcrRzHh54IBp+Ng8tjA3kaY=;
        h=Date:From:To:Cc:Subject:From;
        b=k5qOqKyj8sZyXRdC+BYmS2tNdls3+mha/4rFNUCGXNOTKWGAQwZ7IRCiDTvb5Iae6
         //J+ouSiNNzrFbkyAKtBEE1dIrgKrGxCjWI9ZY5bpse/m7YXTJi1LryrH5Cx4Ta8II
         yekf35ilq5QuJ5QHnO1FozWUjtdtbA4f6NL8hiX8=
Date:   Thu, 11 Nov 2021 10:32:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 5.16-rc1
Message-ID: <YYzjLtQQPqaJcShN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b5013d084e03e82ceeab4db8ae8ceeaebe76b0eb:

  Merge tag '5.16-rc-part1-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2021-11-06 16:47:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.16-rc1

for you to fetch changes up to a4119be4370eea352df0dad294488e60e67321cf:

  Merge tag 'coresight-fixes-v5.16' of gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux into char-misc-linus (2021-11-07 11:49:35 +0100)

----------------------------------------------------------------
Char/Misc fix for 5.16-rc1

Here is a single fix for 5.16-rc1 to resolve a build problem that came
in through the coresight tree (and as such came in through the char/misc
tree merge in the 5.16-rc1 merge window).

It resolves a build problem with 'allmodconfig' on arm64 and is acked by
the proper subsystem maintainers.  It has been in linux-next all week
with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      arm64: cpufeature: Export this_cpu_has_cap helper

Greg Kroah-Hartman (1):
      Merge tag 'coresight-fixes-v5.16' of gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux into char-misc-linus

 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)
