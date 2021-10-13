Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC51742CD50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhJMWJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJMWJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:09:48 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10748C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:07:45 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h10so1351986ilq.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHpSiGDDliTdjJt+IRYI4daer9zeAe2fG4ch4VS4iWU=;
        b=qSl+KNsz9aVlxETG6wP3Ub+rfXROwa0bmYn4vhu/JJcgDX9+rPO5M07RTzAawE5uIk
         vjc+7BGehvm+zSo3DpZC8/Rd8Dr6SjfEMEZjmENflWxNoVk1nkyIH28G9E24TwszGOMU
         qFSRioeqIW3mVOmkQlhrcjONmQI37Tke0lAL8GSzjBxZnNiq6O3HyyJMcQyA/k8tL1lR
         SnGugjzaigJPV5ghlbJ7T2u5eALMPjad0+M0A2W1n079Mi7PYrEAmOMzWzLU0ftdR40Q
         2oKoT38TK41TRlO59GF7ZGZBYYxCN7TLWUd7w7YAs9pAJtGEef5t2+McHEjWzl/0kiIg
         XgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHpSiGDDliTdjJt+IRYI4daer9zeAe2fG4ch4VS4iWU=;
        b=sfyxFz4jlHpNAbpVg6Dmdl/bNhG+Vg53Lp98KpDfYl9XcEqqCffm39lh34FEtQfn6u
         spTxN64hj2hjKNav/ykRXwmSn731sbaGadRH8neLuz1d3Xjqk7LUBPPOMVJqDw2QHfZU
         7VtJh6TWUmZcG+Mldd67qjXe4psO9WO8b1gPkPvKa1pw9xudiwa93o2SDm27shwy7ovF
         d8W39/aOE97ijnfpCorHFeq4aJ1Ro+WSmWtoghScDYOXn2Uw8drOqq+nVZ5QUeC3zvq6
         TaeFzRuWCQ74gPSIohwGPC2nJSFnwj9qjAAaAnpDMu14eIG8CnutTQzf299bCQQYNFBQ
         kKlw==
X-Gm-Message-State: AOAM533zpIwAOqtxmz2P8i3+wOpOWJqr2hq8QdJVz6o4XR+kTRENYZTI
        Gh0IthfOjXsXxPTKRlmZM22+bsUdWWo=
X-Google-Smtp-Source: ABdhPJzkcjAqDnQ4XcxpjNbZ3SqUB0KdjCojZaHT9XOLKsazqyt2ui+wrQze+UXps9/F1iau/z7J/A==
X-Received: by 2002:a05:6e02:148d:: with SMTP id n13mr1278529ilk.278.1634162855394;
        Wed, 13 Oct 2021 15:07:35 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id i15sm324633ilb.30.2021.10.13.15.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:07:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/3] dynamic debug for -next
Date:   Wed, 13 Oct 2021 16:07:23 -0600
Message-Id: <20211013220726.1280565-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Greg, Jason,

This cleans up the previous 1-5, dropping the unwanted 2

Jim Cromie (3):
  dyndbg: fix spurious log-level change
  dyndbg: vpr-info on remove-module complete, not starting
  dyndbg: no vpr-info on empty queries

 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.31.1

