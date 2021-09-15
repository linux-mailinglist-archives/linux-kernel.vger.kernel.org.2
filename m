Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ABD40CBB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 19:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhIOR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhIOR3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:29:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F3CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:28:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i189-20020a256dc6000000b005a04d42ebf2so4510726ybc.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0Mpsn02xM/YuBlrSis/n9F6ZUK1gBjVr+OiMo9wjlAQ=;
        b=s1ECptAGCvVmiXovrEGOINpvCNckSyvqdrKMssMC7fAErHZzCKDl9hghsgTCP0fMow
         CTTKH08ZBexj+4DCShLWqhONIVOmKJG1e/ihn3iviwq0I5OtbGcz0WeBTfdkkd3/bhIw
         C72vZVRfGV1Ao9zOuf4kzG+JbPiGCSxMOuh4q3WOtfFeA4EOHbO8coOQCXB5h8ovQZr3
         GRO16Urj+GsWLye9IVlHHhh/3LGdAi5a+gLEIa0JwATlXizpovQwXXWxtFZcXj7XG7M8
         U26ZpTmn747qRnItz6/aeeM8XGlK93fa8MXAXQx/YXh5oEoDoejec+cW3692J4hRISNb
         +6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0Mpsn02xM/YuBlrSis/n9F6ZUK1gBjVr+OiMo9wjlAQ=;
        b=mTEVCJq/5zP+3pvlaStMPH0bH12+CdiUgS+cIJ3xt7rin4BfQOj7lmCr/aXzUjiNi2
         ImN+0mZcoFEhZv5bC1PjT9jMHHgMT1d1/Y+3EALiov54VoSahqNOm848CQ2X1KU1Vw/P
         PEgQbuuf79aD7N3PC10jblIA+06WMyUryAXYZd0dN3DZRsN4I9Xy0NNp5kQh33MbaLgV
         /MreU7Aswjt0rhX1WnTKSfhoJ6sBnZQcf6hGV/dQo/8FFpDzHMLxYrcFuJId86DnOvUb
         ePjCb01wvQyeIFKwv4R2mHgWyX5I8nPCL3UUD1uPSBDJybgIwjvDoy4bRFSwhQmaJj+G
         3JjA==
X-Gm-Message-State: AOAM533T2jOPEcwTTlzDTgZXfpfJno7UR5qUK91B09+1tayteUF/kj3N
        wJ+NJspva93XsUwNQtITBm2xHNCdxUyJq7E=
X-Google-Smtp-Source: ABdhPJzBIITdRs4TqmV7SkXXusLrh5mu9MCLSmIM8gh6wRkct6tfaFhDBKJEVxzTae/D6SYt/VboanRcQ4S1q/4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a25:d615:: with SMTP id
 n21mr1355282ybg.500.1631726892730; Wed, 15 Sep 2021 10:28:12 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:28:04 -0700
Message-Id: <20210915172808.620546-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 0/3] fw_devlink logging improvements
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are pretty trivial logging changes that I would like to go into 5.15
please.

Thanks,
Saravana

Saravana Kannan (3):
  driver core: Set deferred probe reason when deferred by driver core
  driver core: Create __fwnode_link_del() helper function
  driver core: Add debug logs when fwnode links are added/deleted

 drivers/base/core.c | 54 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

