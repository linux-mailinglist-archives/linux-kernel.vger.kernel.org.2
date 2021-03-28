Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A21A34BD59
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC1Qwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 12:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhC1QwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 12:52:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3455D6195E;
        Sun, 28 Mar 2021 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616950327;
        bh=RETHV+Q8yLnc8fBmV5IYVrkLLmknZ21rMiRl9cQqWo4=;
        h=Date:From:To:Cc:Subject:From;
        b=ID5MBLtISAolidAOEEkVB5nWFJiDT23fuXKb+cG2XHq2RpxU2bCDO9olglWEqwsLw
         zxcwqSqTCCQ4QH2Qjx+/uXdIi8EQt9ROQP6NHLQeQmLOJ8rWMu057LuccvsqajWhRI
         Dww4CCsDu0OVtXXinuQwMZA/INMDs7gUVjub5EnNA98rjV5QIPPQIMD+jQ9pppHOTp
         gx3e7PK1hWhorhvDtrdT4z12bmIWsXeT7eUlIandkBSoaJM+7XvUQ6hiZ/uI7VX8QT
         pv6l1Egv9ktJBryDLoxpVjZOnWInsIwviljTnD9A5Mgv8hp17Rp4KuEJ4GK11dfmpq
         adAKxFWlRjDWA==
Date:   Sun, 28 Mar 2021 18:51:51 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.12-rc6
Message-ID: <20210328165118.GA23099@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this fix for auxdisplay.

Thanks!

Cheers,
Miguel

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.12-rc6

for you to fetch changes up to 701454bce906241ba7f50e2773881560d6404d29:

  auxdisplay: Remove in_interrupt() usage. (2021-03-16 16:32:40 +0100)

----------------------------------------------------------------
A fix for auxdisplay:

  - Remove in_interrupt() usage (Sebastian Andrzej Siewior)

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      auxdisplay: Remove in_interrupt() usage.

 drivers/auxdisplay/charlcd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)
