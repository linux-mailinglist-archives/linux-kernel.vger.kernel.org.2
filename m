Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11233C1DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhGIDsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhGIDsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:48:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE7C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:45:22 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a6so8031127qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=drcX60ClzQbMoVXgzd4rWY+QRIFMx2n+Mr8C5WvMyGg=;
        b=VBybsezIjP0xlnWZs+L9ppdaYJUuua5rYXdYVT6X6+XDf2/MQNUMOL89AdpeonL0Wo
         5w9mJ90a2H4f9lqsQ8iXWG5tLLzdOYs4ai49H12Ge4VAfFyqwaXpp5/WL1rFC+jzJETr
         bb2RtTRUtECbIaWuSF+P9TDOFfMqGqCyh7GVEx16bj1LLz9mMJ0KYjeQqn0z/+kMh1td
         eQYD2Y/0kl47XHREm+wAP775dMpFDrrVbCqDNrPVXYY/LqGYCKnhCl1jXVCaW8lQu4JM
         rHFAgtjok67CV7Sfe6tAiogcrEdD41qMLRITYxzr5J8k/QvLxhVoXHKLitvWyXM5s0Kg
         6nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=drcX60ClzQbMoVXgzd4rWY+QRIFMx2n+Mr8C5WvMyGg=;
        b=CvPY++k974AqMgY25PdoYsfViPhITtbaMLZ7CU7+VOw2SCJxsHvmgr3A57jPZl42W7
         7Uim/LqOXaM9vOe+ixn8SvX9hnGsXCDZyD0FmPB4spcWmsy0cmUcpr3ckw9omJM0UNWi
         vT7cZpGkSHpGTJkMfwx3DBZtoI9uDzwmi9k9I7D+oUDzXTjolCvgYovRQhioibxrbHHB
         LLdTG4/MxFMgFNaKP/k1H5mnBaxZA7kgNCcW3FkNthR4cToYhRAAMJUfaHmtalGKf7eT
         MpRCQ+XMFStiYqheqrn+t/RUXUxKcNeV+eP8CgckANmwbJ5oZYOea6UwO/Ef0iFrhWHD
         R+uA==
X-Gm-Message-State: AOAM530Mc+iCO+kjoWWhzLVBxwyFw+m1CCVSGENO22hLJcERucZK4j5B
        K8QnGJCjBoba9o+j0LpoOLAZBShOeJ4=
X-Google-Smtp-Source: ABdhPJz6r3AA4LPsLyPg6A/j24bNS3e4pnADPPXHkto6rhFzrEL7fMEXM0plnLRAsqUlvDzUfs+u2A==
X-Received: by 2002:a05:620a:22d6:: with SMTP id o22mr18083687qki.444.1625802321879;
        Thu, 08 Jul 2021 20:45:21 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id o66sm2009265qkd.60.2021.07.08.20.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 20:45:21 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 0/2] bitmap: introduce for_each_set_bitrange()
Date:   Thu,  8 Jul 2021 20:45:17 -0700
Message-Id: <20210709034519.2859777-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce for_each_set_bitrange() and improve bitmap_list_string().

On top of:
https://lore.kernel.org/lkml/YNp3extAkTY8Aocd@yury-ThinkPad/T/ and
https://lore.kernel.org/lkml/YNirnaYw1GSxg1jK@yury-ThinkPad/T/

The full series is here:
https://github.com/norov/linux/commits/bm-f3

Yury Norov (2):
  lib: bitmap: add performance test for bitmap_print_to_pagebuf
  bitmap: introduce for_each_set_bitrange{_from}

 include/linux/find.h |  7 +++++++
 lib/test_bitmap.c    | 37 +++++++++++++++++++++++++++++++++++++
 lib/vsprintf.c       | 40 ++++++++++++++++------------------------
 3 files changed, 60 insertions(+), 24 deletions(-)

-- 
2.30.2

