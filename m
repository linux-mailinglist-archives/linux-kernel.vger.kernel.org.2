Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3513261F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhBZL0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:26:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:60082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhBZL0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:26:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614338728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oeBa5dwQSjpXQzLYQYGEoVzkSCXLkRRKiXAJEhW1P8I=;
        b=f6niMuV1F3Ivi2wUE/zGN4IrPT40LcYGv2Pirmh7l0KftZvDngRdPPHnFC0O9eBj6Yh1kC
        3j/bAYOx4EWqQl64X2VGCnWs72axWZcqkMS8z1HrcZECO1omRhLaGIgfEDa+BWjD0qAd1n
        UlNcHxjK4wA2GZRAiMx4lbo2p13/e2U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A511B001;
        Fri, 26 Feb 2021 11:25:28 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@kernel.org, mhocko@suse.com,
        Juergen Gross <jgross@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3] kernel/smp.c: add more CSD lock debugging
Date:   Fri, 26 Feb 2021 12:25:18 +0100
Message-Id: <20210226112521.8641-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series was created to help catching a rather long standing
problem with smp_call_function_any() and friends.

Very rarely a remote cpu seems not to execute a queued function and
the cpu queueing that function request will wait forever for the
CSD lock to be released by the remote cpu.

This problem has been observed primarily when running as a guest on
top of KVM or Xen, but there are reports of the same pattern for the
bare metal case, too. It seems to exist since about 2 years now, and
there is not much data available.

What is known up to now is that resending an IPI to the remote cpu is
helping.

The patches are adding more debug data being printed in a hang
situation using a kernel with CONFIG_CSD_LOCK_WAIT_DEBUG configured.
Additionally the debug coding can be controlled via a new parameter
in order to make it easier to use such a kernel in a production
environment without too much negative performance impact. Per default
the debugging additions will be switched off and they can be activated
via the new boot parameter:

csdlock_debug=1 will switch on the basic debugging and IPI resend
csdlock_debug=ext will add additional data printed out in a hang
  situation, but this option will have a larger impact on performance.

I hope that the "ext" setting will help to find the root cause of the
problem.

Juergen Gross (3):
  kernel/smp: add boot parameter for controlling CSD lock debugging
  kernel/smp: prepare more CSD lock debugging
  kernel/smp: add more data to CSD lock debugging

 .../admin-guide/kernel-parameters.txt         |  10 +
 kernel/smp.c                                  | 193 +++++++++++++++++-
 2 files changed, 192 insertions(+), 11 deletions(-)

-- 
2.26.2

