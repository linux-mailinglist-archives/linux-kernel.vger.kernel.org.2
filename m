Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1214738AE94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbhETMlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbhETMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF527C0611D0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d11so17349347wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTjS1lV5/2FTT6PaKbPLNrY5CGW03uQdFbkA9bdxFfg=;
        b=kX4RRyxS9naxTiQnFH1J5mN+nwOSBILz6i08OCD+AaK+ucCenu9TlGNO5+S37VKLzu
         0eCm0DSFtWN5eK/n31bNjeefmaSggoWZ3Ej/rUvOsH8wZmsdA8096XBbgRfuqFTURDUw
         yirRTgM9pNQVa1FIkxhT0Ibx/9CGQ6i4FyImB+xD7TB6L8t15sd6tIwpelA3/l97luA2
         FiWwlAup1iWAmN935cuEzdFRrHGW1cCqpjnifIzI0GaLNcg2gZXfDOCEiabv+sRzZMYt
         5uZU27tw7QoGNaHT9cfZR7PmnhnD580XB4UkNFFqVhTXHyo+QNc9uT821dYdGC8DsUsq
         f5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTjS1lV5/2FTT6PaKbPLNrY5CGW03uQdFbkA9bdxFfg=;
        b=TRksLX+KsgYxbIphzHnHpgrj5Qry8qSr9CSJiIUm96FfKFqZuO/QHZJla9pD8dc9KQ
         6GNu5JKh4V0cehLp4TVd8BxlBx8eL6PmnHe4iXsMQM0c5ek7fVKIDT+8qtgif3zo2wZx
         SNKjLGkSIRMKZA27eqN/jTKY1dQ8eIAOwHE12NUd2+Q3kSesKLEbBvpv1HzQ5voTk+SF
         awDHJf/mmnBsSbfcXrexdeW1tGombJvJjhVJyssHCMdDa+j+E3dW4+LEdzKxV+fWCqN3
         K+qRKIi+AAEO/J5FQXYY/9HCsuG5LDdi4FnPviT0aV1G/Uw9Gj6r3JbwiqA/iihV4P6o
         vwcg==
X-Gm-Message-State: AOAM530PAOOdq4l1lLk9dW4XTTHROjDaFnMxa2SiQSHA0U2P2erCTYlV
        Mv1ZVEpuR+rU8MmKF7hzKdDQ8w==
X-Google-Smtp-Source: ABdhPJz0uPVw4uTkRdrIO7TzhB2Lba173UNDrRCxhWTmJsoVc5B9xp6IVviROg24clsZ0WL2ywrxIQ==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr3955329wru.94.1621512045562;
        Thu, 20 May 2021 05:00:45 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-ntfs-dev@lists.sourceforge.net,
        to <linux-ntfs-dev@lists.sourceforge>
Subject: [PATCH 00/15] Rid W=1 warnings from FS {GFS2,NTFS}
Date:   Thu, 20 May 2021 13:00:28 +0100
Message-Id: <20210520120043.3462759-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (15):
  fs: gfs2: bmap: Demote half-complete kernel-doc headers fix others
  fs: gfs2: glock: Fix some deficient kernel-doc headers and demote
    non-conformant ones
  fs: ntfs: namei: Demote non-conformant kernel-doc headers
  fs: ntfs: unistr: Add missing param descriptions for 'name{1,2}_len'
  fs: ntfs: compress: Demote a few non-conformant kernel-doc headers
  fs: ntfs: dir: Supply missing descriptions for 'start' and 'end' and
    demote other headers
  fs: ntfs: runlist: Demote non-conformant kernel-doc headers
  fs: ntfs: inode: Fix incorrect function name and demote file header
  fs: ntfs: attrib: File headers are not good candidates for kernel-doc
  fs: ntfs: aops: Demote kernel-doc abuses
  fs: ntfs: super: Provide missing description and demote non-conformant
    headers
  fs: ntfs: file: Provide missing descriptions for 'start' and 'end'
  fs: ntfs: mft: File headers to not make good candidates for kernel-doc
  fs: ntfs: compress: File headers are not good candidates for
    kernel-doc
  fs: ntfs: runlist: File headers are not good candidates for kernel-doc

 fs/gfs2/bmap.c     |  2 +-
 fs/gfs2/glock.c    |  4 ++--
 fs/ntfs/aops.c     |  8 ++++----
 fs/ntfs/attrib.c   |  2 +-
 fs/ntfs/compress.c | 12 ++++++------
 fs/ntfs/dir.c      |  7 ++++---
 fs/ntfs/file.c     |  2 ++
 fs/ntfs/inode.c    |  4 ++--
 fs/ntfs/mft.c      |  2 +-
 fs/ntfs/namei.c    |  4 ++--
 fs/ntfs/runlist.c  |  6 +++---
 fs/ntfs/super.c    |  5 +++--
 fs/ntfs/unistr.c   |  2 ++
 13 files changed, 33 insertions(+), 27 deletions(-)

Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: cluster-devel@redhat.com
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: to <linux-ntfs-dev@lists.sourceforge>
-- 
2.31.1

