Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9F37AA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEKPLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhEKPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:11:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:10:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m124so15930609pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwTrcsYF66Ci4WqwAE8b4kjaAXXOd3wz6jRbttr9oyU=;
        b=L9K3mMvViE1Oc7+lgOxeFPBpl/ORwxmksqUJFWQTLQW4ErZeqwC1WCy68gijKQWiGl
         DeXTkYx1M0XqgjE8g3ug701R/20dso1WytlXhcjFUgQza/OFtGbBt4n9VvqI+VkWxsDO
         Xp4axad5iDPZ2fqqhBtvuKtvQAU+mIVL/8GwhPGXFLWFrXwAfGWH7nDPXK8iFJp4uB8t
         3OGaY5emBnVef+kJ+RYggM7mSBawtSCTHxVEXeCmK5OOTpzjigu0g49FAA4boVAyr9sk
         qFKSVAsp5reOVNi9qP95eZH20ykLYitXGy3ZMAgLK+Z0BvIywpyi/idmIl3/fTVqL0Oz
         gJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwTrcsYF66Ci4WqwAE8b4kjaAXXOd3wz6jRbttr9oyU=;
        b=PIMHw/4i59CQELLmCp3voTfUMWmnrIkZX2SdbcC0yMvj17WAnnDdUj6nbIbnxtQLhM
         pN7fs0DJyurcIlU5VOtT+G1OACh8/MgktIy9zjj6CZ0fwp/LJADPNYrPFwZ29vHxiS/n
         XNdDoh8G0Qk9WATm8Es3aPJScupNJt28YfrEeH2qQRZv1NrrbbeEJp7zsdRYd56qbWxu
         OByIwbM0p03C9F7GmLz+vRSz3owkbiLNTffe8NH4JGMv5b9ZoK684O5+QGcD18p9fY/t
         YMyaTLsg8oyJnXzmyJWknHKLAaZb/mmPdlvcpWG0nhIVRF8Nj2em7PgzU4p0Iz36vKnB
         a2Ug==
X-Gm-Message-State: AOAM532GUb5uE+CugSqYrnuvOGaA2K9Kr493dI8DHgK0ytLJceeMKDU5
        +kq1gMyxk49MpMsAXd3tnQ==
X-Google-Smtp-Source: ABdhPJz7fhGDJwFP00HK7oSVwROpieLkppPXHXun2qSM3/6m8RjXJQ5NRGR+gU8Vyfm7BHcgBzXKwA==
X-Received: by 2002:a63:2115:: with SMTP id h21mr31517103pgh.191.1620745831722;
        Tue, 11 May 2021 08:10:31 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id a18sm14376456pgg.51.2021.05.11.08.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:10:31 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] hwpoison: fix race with compound page allocation
Date:   Wed, 12 May 2021 00:10:14 +0900
Message-Id: <20210511151016.2310627-1-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I updated the patch for the issue reported by Muchun Song in [1].  I
separated into two patches (to reduce the size of core fix for stable):
patch 1/2 focuses on preventing VM_BUG_ON_PAGE() in the reported race.
Patch 2/2 includes some code improvement like calling retry code, revising
the function comment, and some refactoring.

Any comment and testing would be appreciated.

Thanks,
Naoya Horiguchi

[1] https://lore.kernel.org/linux-mm/20210421060259.67554-1-songmuchun@bytedance.com/T/
---
Summary:

Naoya Horiguchi (2):
      mm,hwpoison: fix race with compound page allocation
      mm,hwpoison: make get_hwpoison_page call get_any_page()

 mm/memory-failure.c | 169 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 96 insertions(+), 73 deletions(-)
