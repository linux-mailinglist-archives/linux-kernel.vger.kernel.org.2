Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA282372367
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhECXHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhECXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89AE7611C0;
        Mon,  3 May 2021 23:06:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1ldheT-009Y7i-1S; Mon, 03 May 2021 19:06:57 -0400
Message-ID: <20210503230510.845068955@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 May 2021 19:05:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/7] ktest: Get ready for pulling for 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches have been part of my local ktest tree for some time,
but I realized they never went to the mailing list. Sending them
now and tomorrow I'll send a pull request to Linus.

As it's just the ktest script, no harm will come to the rest of the
kernel for being late.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: c7ceee6958770c447b86a8917a603a20d646b608


John 'Warthog9' Hawley (VMware) (6):
      ktest: Minor cleanup with uninitialized variable $build_options
      ktest: Add example config for using VMware VMs
      ktest: Adding editor hints to improve consistency
      ktest: Fixing indentation to match expected pattern
      ktest: Further consistency cleanups
      ktest: Re-arrange the code blocks for better discoverability

Steven Rostedt (VMware) (1):
      ktest: Add KTEST section to MAINTAINERS file

----
 MAINTAINERS                              |   6 +
 tools/testing/ktest/examples/vmware.conf | 137 ++++++++
 tools/testing/ktest/ktest.pl             | 571 ++++++++++++++++---------------
 3 files changed, 433 insertions(+), 281 deletions(-)
 create mode 100644 tools/testing/ktest/examples/vmware.conf
