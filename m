Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612353B9CBD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhGBHMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGBHMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:12:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DE9C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 00:09:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a7bc0890000b02901f347b31d55so5477232wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 00:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c51xWP6HFxyDdwuJ+ddvRUqSKclx8bRLI29HINoCXbk=;
        b=a5ur/ziq97S2/VwBEdouMyPFhp4QefygRKUS+KdZhNND8sGB4tPCO0nRqPcSuNH/94
         E8dTyDF0wsHGyqhouc9RPI+rlZMgqYVEulXchFRUmJWIlYfpT8KVi5w/RpXwGJcO3Nvc
         1naYLp9uJ1ugo93DJJS20DZMJ2CFqnZ0ESTquZqSgJEHfKdM5IvGMU+x7bSn6DlCXheD
         6gLQeN5QJ7rSHwZvUjEcNmyyiJbFhfUK/V/k8oUalkNCa7tYwK5aeJYXnaNX8JeNUZhD
         1ojCTBAz5PicwhYcXK1afhtwAcbFv0GF8bEKY9EcKAHMhFDVcnoYxluZe4vF8y2aRLUu
         IoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c51xWP6HFxyDdwuJ+ddvRUqSKclx8bRLI29HINoCXbk=;
        b=ZhNtOv4vl15xLGPKmKBVNgtkreZ2YNDQvDUtmiarAuwoaO3szagvkfcU5RO/YwzO9r
         pUOO3USDxq9DsO5xtWeGGuNpF7LTUBOD4aJyqV8D5bXpt8oCST97uZ4Yw8UeOBc9hPFq
         LrRyJNOywXZApl9nBJ5pgJUJhMrMkCPC44OjzjDGgnIaruS4ijTF89NygUDSc+Fmn8Su
         b4FYHRZrZ0NGCKz3IqRCrYrUDfKUibgyHcTQVjJCv2M06pxtLKHaKErgwiGlO+GrUsHR
         sDYE1yvk2RaNUZJ/4fA0MC9jkndtASp4S+EFUXoQfGFaHn6nSlEyDL4waSttPkInqjzl
         SI1A==
X-Gm-Message-State: AOAM5335Z0o9W+G0jW8lDqPQzhAPK5kD3ngQJ88UfVNupyerhrLIiIHk
        IWOR4ErrKVaNO3PkZwRs5Gh2/Mor1AbWRw==
X-Google-Smtp-Source: ABdhPJxJhJosJoa0E2M4zoTce1R0UHKzRSap+lYfzMH1gseWrgOYYK34YPODrjGcgiI2Xn/0KeamoQ==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr3864870wmj.8.1625209766767;
        Fri, 02 Jul 2021 00:09:26 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id a16sm2672845wrx.72.2021.07.02.00.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 00:09:26 -0700 (PDT)
From:   Jenny Mgeryan <jennymgeryan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jenny Mgeryan <jennymgeryan@gmail.com>
Subject: How to reply to comments
Date:   Fri,  2 Jul 2021 09:08:57 +0200
Message-Id: <20210702070857.5049-1-jennymgeryan@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone, I have posted an patch and I have received some comments
from reviewers, but I do not know How to reply to them.
thank you!
Jenny

