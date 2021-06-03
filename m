Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD8399E19
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFCJwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFCJw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:52:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2CEC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 02:50:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d6-20020a2568060000b0290535b52251cfso6991724ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WodA4cwW8evDahl78i//uxClrYSQx00er8Xt0Jxhbsg=;
        b=Ygw51n8wfm9lFZI3xex/mXBhfGsFka65cBbbx7b7+2vgBJoUY9GqxJIMPumNpKmwar
         JPSYeqjLVCudYagM9pzYAr/DIyUDfSi0I/FRTAnE0+v1qsbkc3WeqThX/OuEDlTvrXNb
         zbfdmipGFsubXExWhZ8kpX+CBcwTA1unFVoB+rN2HJ9TD+VDqMyqmhK7gZr0jsklQzJF
         TFE3HA320u2bqyxCCPVbmB0CpCpk6uEz/3zXyUzA7pEFaIhKNloAN/cIHy8c23Z9qAn4
         bRViw2ck+o0aJXumDz0Z9p1VJzESEfLTSR7GquUMH756oFy7zugzbQ2J68fv6sx8eaNc
         y+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WodA4cwW8evDahl78i//uxClrYSQx00er8Xt0Jxhbsg=;
        b=EGy7hP3eD+w6UvQUHUC2GNzWWPKP2L5udThZTEetB4dTmmZ/yK05R4U4C9lRLlGEN8
         xXbj2NwPxhEI30tzHX0u6WbYkVX34AxQAlVl5efZ53cR0PBkkQ6Psw6W5g3JQgNputHF
         MXBX2L3qq4j8FyBQlKGJzBFZfa5k5DRpAK+HVOOxhwwbDxELeS46yBetoOt5epydpcd5
         8y14h70rNrTvCinL+CH/pM5Lk55K6jOX24ik5WKZNVmXMMjDF2RfWZXjQSZd2KaXFNIW
         qWLC4vCdhup/hfmX6FsjWgQjUAvKUZWMpnQqh1kzrO0ZpZ6bUse8BAIPwTRUjt6+BbiK
         JVLA==
X-Gm-Message-State: AOAM531nh2qVv6+3tSoe6UPV2SyXijOVFcy5uDs7aFG48pnEQJG0oLo9
        k41hDsoeXNht5WQniMtaUOwvtVg7xsU=
X-Google-Smtp-Source: ABdhPJynmwoj0mblrAdNot1lXDwB1wQmT9NFiOhQkn9P5Mn/HixT+3+tCZIHQCVLgAxmlYiVHkU6IcBz00I=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a5b:489:: with SMTP id n9mr52932311ybp.45.1622713842127;
 Thu, 03 Jun 2021 02:50:42 -0700 (PDT)
Date:   Thu,  3 Jun 2021 09:50:36 +0000
Message-Id: <20210603095038.314949-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 0/2] Fix up casefolding sysfs entries for F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These correct displaying support for casefolding only when that capability
is present, and advertise if encryption and casefolding are supported
together. Casefolding requires CONFIG_UNICODE, and casefolding with
encryption wasn't supported until commit 7ad08a58bf67
("f2fs: Handle casefolding with Encryption")

Changes for v2: Added comments to double #endif's, added Fixes and Cc tags

Daniel Rosenberg (2):
  f2fs: Show casefolding support only when supported
  f2fs: Advertise encrypted casefolding in sysfs

 fs/f2fs/sysfs.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

