Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158A83CA4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhGOSD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbhGOSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:03:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F5FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:01:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x19so1356322ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pxJym6eD7+8vdNj4v5MiZrKve7OxJSUGIHSmhhkgVNY=;
        b=vBM5crOZ8I1Peo5qyHtDpOTiEGxU+hZWJ8//tDnMOhqEOkPQI9K/LWX0pdhWT88j5I
         RlT5FCUwgd7wnyRwsmG8uc0d7bPrUdWuqnFpYzgIDMus2QFdQfUd47mtNr+4osMBornZ
         5OhWDMxnKLhu98YwcZ3U7GA7vckvSfRI3kdXZi+eG0MwXn4yMvJNLEEQDLLA/0luRwy7
         /oTsH3AGItufHwhXmoH/qsjTYcJDXQqR/5QebS9y6gT3BKm22Ltj/0KcrF7JidGBUVsC
         RFou9FFd+TjrfSzSP15GMqHIKWDPGz0w9Rw761gEqrL234GAvCyBAWx0ZgM7UZ59/ji3
         jf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pxJym6eD7+8vdNj4v5MiZrKve7OxJSUGIHSmhhkgVNY=;
        b=UghtAKFvnfX/IFFXlR5Y9KbQh8AxrCxS3xyzlDUapZbT3zkmpx6BW8kyiJKIB+TuUy
         dNrKznEIMdcKwwk9icPxZdkyTordYMXslpCpHMusbjSEoTciclnu2Nz/vsuHbYub0TBl
         NjqWhrhf2ugRaG6S+HFXeGsd5coYlyG+dr0ULCfTbGolk1QI7Ivnx51TuArkTFkb6y31
         tYqrh/ni1q69n2bbTZm6l/YOjhwO3R4IiwYHFgzkHgEsUMzI954xT053ravG08UiDHzC
         lyHAV4ocSEBXJmXIxH5U3TqxXWAj48M5nMB15Xj4pVkRYJSfxdsPv+//zmx7w6Y2EPyI
         QS0g==
X-Gm-Message-State: AOAM531rbhM7wwZ+H1UyOX1SPrOyZciQukQuvg7C7oJh2rRRFhDFl9R8
        HSRmkMFZNgNy3gnSjGA2Z75FNp6MiYXlcA==
X-Google-Smtp-Source: ABdhPJzvljiyI7RxHgFUyZPEyRgch8KGI5MLAxr59j+47wXssmrB/HqtiXyC/3h/AT4Ty/38EJOFlQ==
X-Received: by 2002:a2e:a44c:: with SMTP id v12mr5159326ljn.130.1626372061866;
        Thu, 15 Jul 2021 11:01:01 -0700 (PDT)
Received: from asus ([37.151.208.206])
        by smtp.gmail.com with ESMTPSA id j11sm691657ljc.74.2021.07.15.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:01:00 -0700 (PDT)
Date:   Fri, 16 Jul 2021 00:00:58 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     akpm@linux-foundation.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: KSM: fix data types
Message-ID: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change data types of some variables as there were a few discrepancies
between the types and actual values that were stored.

Zhansaya Bagdauletkyzy (2):
  mm: KSM: fix ksm_run data type
  mm: KSM: fix data type

 mm/ksm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

