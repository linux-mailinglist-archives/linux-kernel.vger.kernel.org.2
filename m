Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5513525EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 06:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhDBEEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhDBEEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 00:04:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBFBC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 21:04:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g7so1519199ybm.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 21:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XZrYx5QlhPN0C6ANYVOpCkedku0P+Q04Hro7oLo1wBA=;
        b=SGjX4RsxIMdN3SWvrEY5AY19Edq7bUdXFGVZcr0+b02fxAzCsq4XHs3wjR6vO38VLA
         gfm9zpD5PVYiMyRQhAWQxEx9/WT64gTJFGnBQh6cq6VIqzN6KptdASK4VzTFvnHhz48L
         0q/pouo6H5fnVLon0zh1XvKNPg0H9H/yoWD2EgwZdpM82tlFfZSG5YaBJG9wqjsrLDCf
         Ep7Dx1wMMpUk1rA70XxTyD9taIXPpHZWQQ2V1ZYOn6ILi9TaWgLv5a6Fknn7wZHAlL/T
         afMjy+aEKfs+SUOi1xA7wbNyXLMIdOt+Yc7ffH0OLE9DmV9HhwYz1FLXj4sd7sqh0To5
         2tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XZrYx5QlhPN0C6ANYVOpCkedku0P+Q04Hro7oLo1wBA=;
        b=SqBICxZSIQ9O1j+sPXuG4Ufg2CJEki/tIQxyVShW/tDzPTO/gpB7Ik5Z3KlaecxIRu
         pFqWp4tBnldY/niB4Exml2ETQ4EylKvBsF/qRqeZwljQt+NWhdkwX4dobdM0ZA3b01ui
         q3NvHrZFWdDVUfpPN3BlOCtIxgY4q7tsTQ0VKFNEX+kTFg0IKxusXER4rtDXJr9oZqSy
         6kJZXhlEixf53e4hjD+4xRDGxVyuGhB4vISuADKgio8goKOSOuGpr3H0XSUbKk90K9R5
         m7dm6tkcEvFJrS23etpKwjSlUOSEYtcz6hfcJI8JNlYZ+l76ZArv6LVL0upTYWIdt99e
         kd3g==
X-Gm-Message-State: AOAM531ukYdm8KNzjnrhOecY3nzuVpUFON2EA/LC5gL1VKKMWVyMz4JX
        D8ZbFDSuOduPuJ7PNuE9hx9STJ8RWOtZpfE=
X-Google-Smtp-Source: ABdhPJxBQg1yvcD3glkhed2bKNtGOeiSZ/leYz2Zo/Oz0C/f7+VvEtoXgmstCPOAhQh78FpfLNTOnCw9eVDEzBs=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:4867:55c5:8fbb:da39])
 (user=saravanak job=sendgmr) by 2002:a25:ef42:: with SMTP id
 w2mr15971414ybm.34.1617336244851; Thu, 01 Apr 2021 21:04:04 -0700 (PDT)
Date:   Thu,  1 Apr 2021 21:03:39 -0700
Message-Id: <20210402040342.2944858-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v1 0/2] Fix deferred_probe_timeout and fw_devlink=on
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes existing bugs in deferred_probe_timeout and fixes some
interaction with fw_devlink=on.

Saravana Kannan (2):
  driver core: Fix locking bug in deferred_probe_timeout_work_func()
  driver core: Improve fw_devlink & deferred_probe_timeout interaction

 drivers/base/base.h |  1 +
 drivers/base/core.c | 64 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/base/dd.c   | 13 ++++++---
 3 files changed, 68 insertions(+), 10 deletions(-)

-- 
2.31.0.208.g409f899ff0-goog

