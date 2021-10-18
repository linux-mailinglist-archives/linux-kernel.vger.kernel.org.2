Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566154323B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhJRQWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhJRQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:22:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C18C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:20:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i20so1216716edj.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1a1lZasOkjsVLxfEpqTRh9pWlKYrLyxR2OKNtm8b7Fs=;
        b=Us82Pzpe+3m6oR50xgihLqygKNRpNOSPw7IvpLcNGvtbXm0SP40NLABqu+mwj+tvPu
         UABGBqx7KwmerklKb6Lc9HHz3nEJSWli7DTeqSIEYxZfvWuv5WbCQ08qJDVWI9K31kLR
         4Oja2GYz0UXjGaN3WJlXCGvbGXIn0WQQuRmr2L++vWxLwuLEMsJ7fIuit3EzmRUPj++R
         K1nAhMIxDQ3xBP2kYGPj5KkFXPAOe9d8tXcBLEaTxF7gnfKawqEWKTCt2sQBRUDCojV5
         FnlH99DimX7Inp54r+apIIdUwHsU64r2LX6s7JPHUr4C2bCBvoR+6a18Ey1B7GDLvIbs
         R3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1a1lZasOkjsVLxfEpqTRh9pWlKYrLyxR2OKNtm8b7Fs=;
        b=a1Tjc8TG8We5REoxEhYa3KSjxKnwvgfVzatpYXDY6YznZMPaMIewzw6gkGs/iS8jIL
         /EYHBe5oANHn3fiJ3RYeoWau2/CPwmozzLJmpsrXk7Br17M80VZRlv8azd9zy8M+hTiM
         si35VKe/hkkE0bLqFlT4cK4Jl/UAzdRHUXnJkZ9YIQiTT8lnvZbxtDSF41mUi1df5eC4
         dP7UgVaP0PbG0K2Oa7cGi4MjAejQFvNOmQ3GJjIpJunwp23FBuIB9ZUcWD+z9GVK0aE7
         Cdl9vHWKcuZegIpQgIiUTTv0Da+oFGRLwpQuoe868FBxcs8U0evPPY4OPxmxrBzZE37C
         RCpA==
X-Gm-Message-State: AOAM530A1B5xHrsZR/gtOLNzfLO0D8Co3zO2zcyFM6U6C9x4HRIUXfgd
        01hU9+FvTz8KCOEeFUVwSLc=
X-Google-Smtp-Source: ABdhPJw21c2ayrDkQVBjS5Sqyoc1IQMcDs1mlQMHYciYGzmRmoEseEDu0ubOVWjadPFsr77DnIEW+g==
X-Received: by 2002:a17:906:5a8d:: with SMTP id l13mr32442600ejq.95.1634574010476;
        Mon, 18 Oct 2021 09:20:10 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id p7sm10045791edr.6.2021.10.18.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:20:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/3] staging: r8188eu: use completions and clean rtw_cmd_thread()
Date:   Mon, 18 Oct 2021 18:20:03 +0200
Message-Id: <20211018162006.5527-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replaces two semaphores with three completion variables
in rtw_cmd_thread(). Completions variables are better suited for the
purposes that are explained in detail in the commit messages of patches
1/3 and 2/3. Furthermore, patch 3/3 removes a redundant 'if' statement
from that same rtw_cmd_thread().

Tested with ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]

Many thanks to Dan Carpenter <dan.carpenter@oracle.com> who helped with
his review of the RFC Patch.

v2 => v3:
	Patch 1/3:
		No changes;
	Patch 2/3:
		No changes;
	Patch 3/3:
		Furher process the commit message according to a review
		by Greg Kroah-Hartman <gregkh@linuxfoundation.org>>.

v1 => v2:
        Patch 1/3: 
		No changes;
        Patch 2/3: 
		Replace wait_for_completion_killable() with
		wait_for_completion() because killing the kthread is
                not allowed and so there is no need for killable
                wait;
        Patch 3/3: 
		No changes.

Fabio M. De Francesco (3):
  staging: r8188eu: Use completions for signaling start / end kthread
  staging: r8188eu: Use completions for signaling enqueueing
  staging: r8188eu: Remove redundant 'if' statement

 drivers/staging/r8188eu/core/rtw_cmd.c    | 20 +++++++-------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  5 +++--
 drivers/staging/r8188eu/os_dep/os_intfs.c |  8 +++++---
 3 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.33.0

