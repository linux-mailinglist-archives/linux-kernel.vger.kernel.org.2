Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942A23BE5D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhGGJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhGGJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:51:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3AC061574;
        Wed,  7 Jul 2021 02:48:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cs1-20020a17090af501b0290170856e1a8aso3367147pjb.3;
        Wed, 07 Jul 2021 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cc+gCUPAZx+LyHdRSTQp6eiJxr/vq/O0gj+XZ0T3Lwo=;
        b=Sl82vp63dbbtc98hScOpOoPm+YleBTjm06dkdaLTpKDFd+yw71TST/kzJQNi+ikJ6C
         1aUNEMFLFuissBMN+DaZgVgGtoWIPz5MDHjHJWHtZW8i/AbjJER7giD8l26f7T+lzU6w
         zNj7yOd240mm+V5eDR4jjkOXKP5zHtnkrQU/aQGRKkQKk0UzlTepemzQhCHvcAF3NgQD
         /7hr1/cYSHlFBL2Z+wwwgAT8MZGkaU3ggkklqBlY1LQMIm6pU5ixya00yJfO0JH6i/Rt
         MXnnBlOQdYypQOnEKv7YLg6hTlQjZ6z+EEbX6Q4divuftRHLo+VceRJSVTImfbmd9CLE
         0VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cc+gCUPAZx+LyHdRSTQp6eiJxr/vq/O0gj+XZ0T3Lwo=;
        b=NX28ezHDHCIR7e4rPCH3QLXATf1PUgQFB8d5dt2q1Hcf+vIlIL8yAxki+lpj2TAp3f
         9238PGBgTOTDd9LOtmKz8LaXCJCvmi4/F5TyhwJZ2YKEZCq99BOnHwupSJYHJc92qRhU
         BWNXQNwq0XwvkIqpjz2+f/u68bOpZdv/aTKEZHW72qhtkk1b20GfYqa5gK7DO4DMjzNB
         urnMeynmcY0PtQAGjT74vsYddzq47f63eDCqB1Nmo7i6qYxOkOVeLWvB9Mx4CQZWurSV
         +5GAD7elXBhdwhcqmSuXORWc5UeRT4Kcg2JyincwPHrgGlKUJ3kdr1+MCrQSzeyj4fEC
         PnVg==
X-Gm-Message-State: AOAM530GdGHIVAf2G2ZJflDrDkTRO51m66mNp3HYyYW3c/wJ/4nfD+vp
        HSK/Wy7ca0fkmr5KtrgA9VWB1dlW16I=
X-Google-Smtp-Source: ABdhPJzIoyhc89idZJ/ODVCBO4/2M4NxPV1QNsGzEk0mGUmTMF/tMC5Hgeis9EwRNafLTvDxZxCjzA==
X-Received: by 2002:a17:90b:238f:: with SMTP id mr15mr2549077pjb.57.1625651310372;
        Wed, 07 Jul 2021 02:48:30 -0700 (PDT)
Received: from carrot.localdomain (i60-35-90-140.s42.a014.ap.plala.or.jp. [60.35.90.140])
        by smtp.gmail.com with ESMTPSA id gd19sm80137pjb.38.2021.07.07.02.48.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 02:48:29 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] nilfs2: fix incorrect usage of kobject
Date:   Wed,  7 Jul 2021 18:48:20 +0900
Message-Id: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please send the following patchset to upstream.

Nanyong Sun (6):
  nilfs2: fix memory leak in nilfs_sysfs_create_device_group
  nilfs2: fix NULL pointer in nilfs_##name##_attr_release
  nilfs2: fix memory leak in nilfs_sysfs_create_##name##_group
  nilfs2: fix memory leak in nilfs_sysfs_delete_##name##_group
  nilfs2: fix memory leak in nilfs_sysfs_create_snapshot_group
  nilfs2: fix memory leak in nilfs_sysfs_delete_snapshot_group

This patchset from Nanyong Sun fixes memory leak issues and a NULL
pointer dereference issue caused by incorrect usage of kboject in
nilfs2 sysfs implementation.

Thanks,
Ryusuke Konishi
--
 fs/nilfs2/sysfs.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
1.8.3.1

