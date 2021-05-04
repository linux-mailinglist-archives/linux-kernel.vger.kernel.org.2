Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2A372FB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhEDS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhEDS2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:28:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA81961157;
        Tue,  4 May 2021 18:27:16 +0000 (UTC)
Date:   Tue, 4 May 2021 14:27:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: [GIT PULL] ktest: Updates for 5.13
Message-ID: <20210504142715.518514f3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Updates for ktest:

 - Added a KTEST section in the MAINTAINERS file

 - Included John Hawley as a co-maintainer

 - Add an example config that would work with VMware workstation guests

 - Cleanups to the code


Please pull the latest ktest-v5.13 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.13

Tag SHA1: 90760c1fa622b44051dc2de39f7cfecc03dd2806
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
---------------------------

