Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588B741CBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346273AbhI2SjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhI2SjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:39:21 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C774C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id r9so3937303ile.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CvXxbX6zKX31mbM3WA/BnjCaTCXkekxw5zZrIgK+gIw=;
        b=KYlnMtEo8j/BpJHhb74r8trJdPCwZF0RrQrznfXXklMD0yMEvAwkEvQhwZE0La5NqZ
         agUXyAovT0AQghFOgZojaAnuho5FHznaOpkQi2XSWL2hCZranY83BTRcef61iFnqUri/
         lYiQk03rvNw28CWu8c/2DjHi8eVDZuE6phyHiXqYKqRRAfywbkpcOI/bEzHSj1VbpD6B
         A6D6WIddCInNurIwsmLnsLtpOYwfagO+94XE0VbV0/S9V1QLHs67Y4bhZ38Cfx1ckJGL
         6BkPjrHth7aeATUBER4y25Y9q7hxv1ZK2QLDvK+qNUJDqpy/CW33V1t65m0twKzv5dU8
         oLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CvXxbX6zKX31mbM3WA/BnjCaTCXkekxw5zZrIgK+gIw=;
        b=KJNk/17aNBJ80DF4SQzlnpshyGw3F25yymgNqsoLxwkwV4Lt35dEFjNH1i3A8ARkb8
         U01jjb87LHthZqjpMD30xofzy1eK8q2GpXtyB6mL5yjXA3yovWO4CWKhbmjNO9Ap3mPH
         hCnXkvFgdyx7wzparqozQ+tgzePDdy8s+p6fQ93g8+cq7JOju+5KstTHn8DWESCZTKr1
         l2FFjWUciiN0hnxKP9mwwTsd2EernOSgwmLewV7HhiJ8IguGTZRjA31otBqxTRcqu6eb
         9qBgT8ch8+8BtBpU+ULXcxkutL4WzZT5Mbe3lzBez9AdVPFe8XgFCWUlOIaIElP3zk64
         uIBQ==
X-Gm-Message-State: AOAM531D3XteRxvuueBEuocExIZB3bKTsXxSf1HCaNQWLaTqxoiO3WEQ
        ssNp00f/rZjIB+Q2y3EDpbSVy1elJiA=
X-Google-Smtp-Source: ABdhPJypoFYWYIfzTRdwE5/mc5soDY4fG3EPqwDwL6HXlU3HKmhc3dJBBXmFngzti1fAA+nXXlaiyg==
X-Received: by 2002:a05:6e02:1b0c:: with SMTP id i12mr883025ilv.27.1632940659446;
        Wed, 29 Sep 2021 11:37:39 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y2sm317041ioj.12.2021.09.29.11.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:37:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/6] dyndbg updates for 5.15-rcX
Date:   Wed, 29 Sep 2021 12:37:29 -0600
Message-Id: <20210929183735.6630-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, Greg,

Heres a set of "maintenance" patches distilled out of other work.  Its
almost all tweaks to verbose output, except for 1st, which changes a
strcmp to == because its true, and useful going forward.

Jim Cromie (6):
  dyndbg: recode for stronger precondition
  dyndbg: show module in vpr-info in dd-exec-queries
  dyndbg: rationalize verbosity
  dyndbg: use alt-quotes in vpr-infos, not those user might use
  dyndbg: vpr-info on remove-module complete, not starting
  dyndbg: no vpr-info on empty queries

 .../admin-guide/dynamic-debug-howto.rst       |  2 +-
 lib/dynamic_debug.c                           | 47 ++++++++++---------
 2 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.31.1

