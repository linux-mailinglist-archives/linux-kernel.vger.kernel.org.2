Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8797934A3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCZJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhCZJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:11:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D762BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l4so7278667ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5DZ45h/RpaWq13JyZLjT9LQ1ZqjNiweLlYOo/ZaYXM=;
        b=ErqIzfGi0c1e3jcAj0Yxf3Dsxy8pLrWN05Twko2gum5hm17MBkf2T37Lx1rTCwuSOr
         OUmHko0rOR8XE4vzoO5boLLDMprD7P/8JiEdDO8VvwFVXZQS75udcJNM5ndhvNgRe6C1
         UjR8bEHXFXbLP8YOODfr5PtsqLcYVHl+/7mYRWS++Okpgzar9rQmcu8IyAyn8RXIPQnf
         a2mBpf+u5XjSzXWVc6cWsTBldNsp0k4YUmbDqaMLwwkWvhex6ojRkOIErD3UvJIW/dbV
         V4dvvw946RAeIJuqwrH7Ry5gcWNZ2fcU5XP1A+vjBPc7p9OnT2J6hS7mVd9zmAGVp8SV
         sQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5DZ45h/RpaWq13JyZLjT9LQ1ZqjNiweLlYOo/ZaYXM=;
        b=q0bBXWrSEhx2i+qN48hjVTb8gdmEtm96CwCxeTF98Apdy3ZWxvFV1J2wPEkCo0MYX2
         I8NpX6g4QV80xdYLWmJ7+/1OFkLlLtB+PGVlfe9s6dp1mi5iaCfEQpTVrO0KCdR6jARE
         wHxmanMaBDiaUQbMba51IvhPX7jxSFtiwiw3ovumF6pEYrWaHZrxsAsdBj/L6GGVdqWG
         bbdibBtLyBWaUKnPyzMiigYS5Y3ufhLOUPLztP8pQmLj6hrVxU9ncc5OSessttYjUIcL
         B2oj9NmBJhTQ7kDhKVAE0cb96Us6im8nrK1psrIrRzAAdTfplNfmeW7LQyLoAHS0oRmT
         doAw==
X-Gm-Message-State: AOAM530fBzIX/B8N23juawv3XzlzRqjzl+U0ZPDgrfF7t4mrYEVXXbJD
        cKYmxRzd54uxKf5DvEij0SupZg==
X-Google-Smtp-Source: ABdhPJwNkJzoSyBqRRjCKPX1E4A0iDVoJ3n3WyHamx41u8DVwNPy/Qr4ZE9aLevdZdE2AUs6ce0vYA==
X-Received: by 2002:a17:907:76a3:: with SMTP id jw3mr14379620ejc.353.1616749914533;
        Fri, 26 Mar 2021 02:11:54 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:11:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
Subject: [PATCH 00/18] Rid W=1 warnings from GFS2
Date:   Fri, 26 Mar 2021 09:11:33 +0000
Message-Id: <20210326091151.311647-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (18):
  fs: gfs2: dir: Finish off mostly complete headers demote others
  fs: gfs2: xattr: Help out some kernel-doc header demote non-conformant
    ones
  fs: gfs2: bmap: Demote half-complete kernel-doc headers fix others
  fs: gfs2: glops: Fix a couple of kernel-doc misdemeanours demote
    others
  fs: gfs2: log: Fix a couple of param descriptions and demote
    non-conformant headers
  fs: gfs2: lops: Help out worthy kernel-doc headers and demote others
  fs: gfs2: glock: Fix some deficient kernel-doc headers and demote
    non-conformant ones
  fs: gfs2: aops: Fix a little potential doc-rot
  fs: gfs2: meta_io: Add missing description for 'rahead' param
  fs: gfs2: inode: Fix worthy function headers demote others
  fs: gfs2: file: Strip out superflouous param description and demote
    kernel-doc abuse
  fs: gfs2: ops_fstype: Fix a little doc-rot
  fs: gfs2: quota: Fix incorrect param name in 'gfs2_quotad'
  fs: gfs2: rgrp: Fix a few kernel-doc misdemeanours
  fs: gfs2: recovery: Provide missing param descriptions and remove one
    other
  fs: gfs2: super: Fix kernel-doc issues where feasible demote one other
  fs: gfs2: util: Fix one conformant kernel-doc header and demote a
    bunch of abuses
  fs: gfs2: lock_dlm: Demote incomplete kernel-doc header

 fs/gfs2/aops.c       |  5 +----
 fs/gfs2/bmap.c       |  4 ++--
 fs/gfs2/dir.c        | 35 +++++++++++++----------------------
 fs/gfs2/file.c       |  3 +--
 fs/gfs2/glock.c      |  9 ++++-----
 fs/gfs2/glops.c      | 18 ++++++------------
 fs/gfs2/inode.c      | 22 ++++++++++++----------
 fs/gfs2/lock_dlm.c   |  3 +--
 fs/gfs2/log.c        | 11 ++++-------
 fs/gfs2/lops.c       | 13 +++++++------
 fs/gfs2/meta_io.c    |  1 +
 fs/gfs2/ops_fstype.c |  7 ++-----
 fs/gfs2/quota.c      |  2 +-
 fs/gfs2/recovery.c   |  3 ++-
 fs/gfs2/rgrp.c       |  4 +++-
 fs/gfs2/super.c      | 13 ++++++-------
 fs/gfs2/util.c       | 19 ++++++++++---------
 fs/gfs2/xattr.c      | 25 +++++++------------------
 18 files changed, 83 insertions(+), 114 deletions(-)

Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: cluster-devel@redhat.com
-- 
2.27.0

