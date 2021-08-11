Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3873E94E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhHKPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhHKPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:45:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD151C0613D3;
        Wed, 11 Aug 2021 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=K/t1vEsTRTZYWCGSLB9i47YNeSP4/7hglGWP97VFACk=; b=R7QWmrh48n6hRXby4kf5wIqapF
        IFC5jUJ0JDosXicHI1hnFvd5T6gCeL7akKdaMrWLfj+etxHjZ42gbzJI5UbLf0xiM00snbFJ2Os76
        K45bQBcL1CDk+6fvhvNSzyaHDMX37G3ux2IBN74SIc39QLXLApIvfjiLUNIoENrlrcaC1NY+bWv69
        epV2vqAI8NLJzFzKcLB2Fsyd0JtJpnJCzZYOuh53eWEdrXQONAj88hlduQjUjj6v4kvrBUE+nalvZ
        sFfE8PmtghxA3ISDeKRRZtENU7YpwIy2Mwocw3Wn/y57J+XFyE8uj1NZv34F/N3ElzGEV3jN5l69t
        MbGVDc/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDqPr-007bpE-16; Wed, 11 Aug 2021 15:45:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 0/3] fstests: add patient module remover
Date:   Wed, 11 Aug 2021 08:45:09 -0700
Message-Id: <20210811154512.1813622-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of my series of enhancements to fstests to deal with
false positives with meta block drivers we use for tests such as
scsi_debug which are caused by races by not being able to remove
a driver.

Changes in v2:

  - Now that I have confirmed the issue with the refcnt being bumped
    after it becomes 0 is also present on linux-next, and *is* a generic
    "this is life with modules" matter, I went ahead and implemented
    a patient module remover support into kmod and posted patches.
    What this means for this series of patches is that we get a real
    patient module remover support in modprobe, and so modprobe -p
    will soon be an option, if merged. This series then now checks for
    that and if its present uses it, otherwise it open codes a similar
    solution.

  - The patient module remover now also re-tries to remove the module,
    as *any* race can easily bump a module refcnt up. We just then need
    an upper limit threshold on timeout or to decide if we run forever.

  - adds udevadm settle after pvremove

  - I confirm now I don't get any stupid module false positives on older
    or newer kernels, and life can move on.

Luis Chamberlain (3):
  fstests: use udevadm settle after pvremove
  common/module: add patient module rmmod support
  common/scsi_debug: use the patient module remover

 common/config     |  31 ++++++++++++++
 common/module     | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 common/scsi_debug |   6 ++-
 tests/generic/081 |   5 ++-
 tests/generic/108 |   1 +
 tests/generic/459 |   1 +
 6 files changed, 148 insertions(+), 3 deletions(-)

-- 
2.30.2

