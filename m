Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6B636D022
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhD1BBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhD1BBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:01:38 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 18:00:53 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso55123498otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmMErG0kDZJohZWIq5ty3IFNj9Vax6U4AG0+q1dC7zk=;
        b=UvRyi5l1G9iQ+xwNPCTDSnEtEEsjHPJsatXEkCiCZBXSsidhdou8xFZU+gqzAl65nR
         RJNPYAoM8l2GnxXmDa2M+fonwpiyVwezh/Tvxt+0xFcLXgPCIOVF+tfkxjJHk3Sb5T25
         24cMU70MXp8ITfExG6gXim9AMCnO/Y+8Q2gY6dc0l/oBm5De8Lr/fn0Qm5XtHBI37af7
         E0OJtZ8Kj+6NL3vnO5zK/VLVuL/1MeGHWQe2TcYEsduEeQB2btYiBmwJI0OwRq4zbXzv
         Ief9mpvKJL0x3oLQO1bVCCuoYoDjjOPWnqMYD1wr/QetozqTMMoke5QaeZDy+HaI/FOB
         9sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmMErG0kDZJohZWIq5ty3IFNj9Vax6U4AG0+q1dC7zk=;
        b=RYjM2ftQnfFcoP2gXEjmyrQt7HKg0Ry21Rhz1DhOU0n37uYkDu3gSJuK+t3pVHvjTH
         tAIJrJN88v2M3utZoQn6J1mXbFFtjZXiAoz8etCu0CMs5sz7y8qxN1Pf1kcW3F/GW7wr
         u5A7IXOh8WyJkjsnKtS/w1cKhs2i/behMoxuz4/BJvunFW0mkXNSQfXxpgeZT0kE5prF
         hbKO3eP57RlhpkFBfOdyF+C1EEuTmiBOR/wpwmPD3vtwLcFzjdUG2fHSQI/9d+Lvl6fn
         Qyj1qHhBEELNzxRxlhc8fmjkiYrqaG7SH5Z7SRd1ZhBe18rANhR5tvj5RrFndMy0q9ZS
         P5AA==
X-Gm-Message-State: AOAM531v5PCSJbK4Ek44bdev2S2zGTBuLvOI2tGc4YGN2kSwdOB6fiTq
        yRMKm5W/d1k58Xah/baNR4E=
X-Google-Smtp-Source: ABdhPJxZf3s5TUgCd0zSBUlFxyuYXbbKWKxkuO2UI0Z1RnI8EKXq22BYOGYMIeHxZ5zzolkzVT/tIw==
X-Received: by 2002:a05:6830:214f:: with SMTP id r15mr21357421otd.204.1619571652853;
        Tue, 27 Apr 2021 18:00:52 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id 34sm339004otf.38.2021.04.27.18.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 18:00:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/2] DYNAMIC_DEBUG for 5.13
Date:   Tue, 27 Apr 2021 19:00:29 -0600
Message-Id: <20210428010031.571623-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heres 2 maintenance patches;
- a minor short-circuit optimization
- a cleanup of old cruft

Jim Cromie (2):
  dyndbg: avoid calling dyndbg_emit_prefix when it has no work
  dyndbg: drop uninformative vpr_info

 include/linux/dynamic_debug.h |  9 +++++++++
 lib/dynamic_debug.c           | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.30.2

