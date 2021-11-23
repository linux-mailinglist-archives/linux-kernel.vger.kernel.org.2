Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539C545AC19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhKWTUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhKWTUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:20:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F1BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:17:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso176324ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zzQE2/0f+XLR2kGU4qt01xqekYzdAVEvEi8bWEw/fiU=;
        b=U9VLJSGPNG+7rafa41zjmw9wu9ecJ3vdtXeEjSNnIQ+f7rJqnguvCqrk9LzwOMRlev
         w2wxZQmjJ6ioEn1e5XM+amdD2K+Qa/dk4TvGWbLJbC86kw8DADsYoDM+QmAbUdVICFXT
         Lt1E0e8eBzvZLvUoiWT44NlttEks4eC/wpkOui7kKHCKp62zLCX8LZm4M0TxEuHf9FLd
         OBKYq3xhWNu8b2mTKPdbte7ETq/d/rViTBAPaj2RrRsfn6PiMtccVuqSedC8Jwny0bUo
         jDEEe8YrtyR+l4HH6SS5SIHiZzhxpN8GKQnHoVvPZBt2BvMw3L44VJW1/zksBafvr/sA
         DfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zzQE2/0f+XLR2kGU4qt01xqekYzdAVEvEi8bWEw/fiU=;
        b=yJmExGX3+GszYXM3eBxCLJmUnQ0/6/zAoq4Mby+Cw8DHWiI4OsBnFp1Oe+iGQk9VHK
         KOR78Yj30i//ox4VALZuKWMitVer0sbSFZqZsP7aeBJNkoNte+5TWxS8OVUdhPg52RUn
         4r5pdyi97rmBPOtsb+JsR9lWWa6QHhbJfmUc/oP5IAoEiH2L18C/xCMMx0ClyY1YaK+u
         TaQ9GmYLa85BMxHW6U8QWg/NNaVxOYUMI7tfY6GavNwGt8zpa12p9/JrTRpzI2RU73Ug
         cMOniu+AymftLydHAFEFcYCGq/WceSlrioT4ncg83n/JCHIJExwZboa49MrIRmdS74GU
         3e/w==
X-Gm-Message-State: AOAM531T5b1CqwQYEzWYu3czuyascFQHpRfwctg6h85syBGsU33vbS1X
        ULuo+Jm1X7Rmkq3QjJtRrHimzgT99Q==
X-Google-Smtp-Source: ABdhPJy+cyU6Dc+6JXrCnEQqfJlJt3b9RxYJKK6SdKqPNw613+/4UybKEHZ9OyPwV25x0syYrUtZuA7S7A==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:ac67:ee23:d7c5:aa3b])
 (user=tkjos job=sendgmr) by 2002:a25:ada5:: with SMTP id z37mr8996151ybi.93.1637695064659;
 Tue, 23 Nov 2021 11:17:44 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:17:34 -0800
Message-Id: <20211123191737.1296541-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 0/3] binder: Prevent untranslated sender data from being
 copied to target
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binder copies transactions directly from the sender buffer
to the target buffer and then fixes up BINDER_TYPE_PTR and
BINDER_TYPE_FDA objects. This means there is a brief time
when sender pointers and fds are visible to the target
process.

This series reworks the the sender to target copy to
avoid leaking any untranslated sender data from being
visible in the target.

Todd Kjos (3):
  binder: defer copies of pre-patched txn data
  binder: read pre-translated fds from sender buffer
  binder: avoid potential data leakage when copying txn

 drivers/android/binder.c | 442 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 387 insertions(+), 55 deletions(-)
