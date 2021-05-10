Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9938A378E14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhEJNER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350777AbhEJNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620651619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ai8jlXjJXaChzB1y0ld74U8FlxDvgMHAMj8lXZNh0X0=;
        b=IypwK3GV1SmVcIyinDmiswC4M/NAj+0UZl5rv+2Ff3BbvPZB3pXso3s3PZ+tI3DOWN/oqR
        AAyHSHc3X2QCq4Dsrl+t62Ie0zZWNAVyfr9lygQ+atQC6kItLk88Px6XfiU4I/Wktqjf5x
        FAHVqhV8UZeH/rc2d66pCvX2dKKqFwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-vESIjZxzMaGD_lkppC2GMA-1; Mon, 10 May 2021 09:00:17 -0400
X-MC-Unique: vESIjZxzMaGD_lkppC2GMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB98A80ED8E;
        Mon, 10 May 2021 13:00:16 +0000 (UTC)
Received: from lithium.homenet.telecomitalia.it (ovpn-115-83.ams2.redhat.com [10.36.115.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83C1C60FC2;
        Mon, 10 May 2021 13:00:14 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, dwalsh@redhat.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com
Subject: [RFC PATCH 0/3] new mode 'shadow' for /proc/PID/setgroups
Date:   Mon, 10 May 2021 15:00:08 +0200
Message-Id: <20210510130011.1441834-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on some old patches I've been playing with some
years ago, but they were never sent to lkml as I was not sure about
their complexity/usefulness ratio.  It was recently reported by
another user that these patches are still useful[1] so I am submitting
the last version and see what other folks think about this feature.

Since the fix for CVE-2014-8989 in order to set a gids mapping for a
user namespace when the user namespace owner doesn't have CAP_SETGID
in its parent, it is necessary to first disable setgroups(2) through
/proc/PID/setgroups.

Setting up a user namespace with multiple IDs mapped into is usually
done through the privileged helpers newuidmap/newgidmap.
Since these helpers run either as setuid or with CAP_SET[U,G]ID file
capabilities, it is not necessary to disable setgroups(2) in the
created user namespace.  The user running in the user namespace can
use setgroups(2) and drop the additional groups that it had initially.

This is still an issue on systems where negative groups ACLs, i.e. the
group permissions are more restrictive than the entry for the other
categories, are used.  With such configuration, allowing setgroups(2)
would cause the same security vulnerability described by
CVE-2014-8989.

This patchset adds a new 'shadow' mode for the /proc/PID/setgroups
file.  It permits to safely enable setgroups also when negative groups
ACLs are used.
When the 'shadow' mode is written to /proc/PID/setgroups, the
current process groups are stored into the user namespace and they
will be silently added on each setgroups(2) call.  A child user
namespace won't be able to drop these groups anymore.

To fully take advantage of this feature, newgidmap will also need to
learn about the 'shadow' mode.  An idea is that when the system or the
user are using negative groups ACLs, then newgidmap needs to check
that /proc/PID/setgroups is set to 'deny' or 'shadow' before allowing a
mapping.  The configuration for negative groups ACLs can either be a
system wide or per user setting.

[1] https://lore.kernel.org/lkml/20210507133703.GB22450@mail.hallyn.com/T/#mc53e0fc80203b8209a8836d5861a267ce22c5c0f

Giuseppe Scrivano (3):
  setgroups: new mode 'shadow' for /proc/PID/setgroups
  getgroups: hide unknown groups
  proc: hide unknown groups in status

 fs/proc/array.c                |  12 +++-
 include/linux/cred.h           |   4 +-
 include/linux/user_namespace.h |  11 +++-
 kernel/groups.c                | 100 +++++++++++++++++++++------------
 kernel/uid16.c                 |  90 ++++++++++++++++++-----------
 kernel/user_namespace.c        |  34 +++++++++--
 6 files changed, 169 insertions(+), 82 deletions(-)

-- 
2.31.1

