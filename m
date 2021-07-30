Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEDA3DB733
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhG3Kh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbhG3Kh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:37:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6813C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:37:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hs10so7318821ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMfu1srrrCowux2puKJtVzqFqMeZgfFMHDutBgFq480=;
        b=b6KKUDLAr4Py7iKkMYzaXIUyLwZ+ZLkZQkrFVSQTVprgZHQIB3fyACoqwKIPg7krzt
         nehYEz6WwAyxRyOkJsE0bwecsbWe0x57YAmuKpyN/JI2DBFGXSwfbukx/tlWrabsoHk7
         ZE1/9A2kinsibOa7xlT9wx2TlN0cOs1p/hav7mfGxc3R5ehxVNJIIDW28tvQgkjs2DM7
         Dv3KxBkpOXLLHze+OJmz3BZMe9eMRyq/TYCFR5NAUnxGqWtM3u7eXm69eDTAKV0EaT0W
         Gr5YiZ/G7KYHtPBB4OFIfNVvI+0vhnT7+1R/u0iO47x53TzHdGfw3D9y0Od2xqBEMSM1
         fuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DMfu1srrrCowux2puKJtVzqFqMeZgfFMHDutBgFq480=;
        b=Exeswls0F+nfWsGQMn3xWVUCtBEjIw1Qc/t8gRMtiqfu0O4QLjsziA3HQNNC/cTQcD
         eRjB4I3VfVyRSrQKLNkgW/V1co+FO+dS/z9dmbxrkBchlT4OoeiCcmpGfzxa8B84KPrS
         3B2zT5ZPqqlkwVw/OEM6piCzNr1WBbUBjt7D1LTS0W95X5mV18SyCaX4tLJ6St1E1bOj
         zS31N03FMYoOfEga5HsIM5lEqMH10DfyGt8J3CItumcGabq25c6jgikuJGl+onYgczj3
         KwfImfIys91PZInXnBrhW6U/QHM+1NUsqk32YxWGXZ+ZWQgJhFaYKM1kRIUGF7FwYrOx
         p4gA==
X-Gm-Message-State: AOAM533EvtJxLQlbpAncB+GlE3ua4sfT+Mnu9sTTMjIwyrP0mjWzHPez
        rHwCGgIZQ1wOLLCHSf38wE4=
X-Google-Smtp-Source: ABdhPJxXHnxYDFphlFhEYaM7ywgHmUqUTabi55Dg4QFe3B2RD2eNRdIj9tmTDL1xtoPAZAN/UMdALQ==
X-Received: by 2002:a17:906:31cb:: with SMTP id f11mr1924227ejf.379.1627641440426;
        Fri, 30 Jul 2021 03:37:20 -0700 (PDT)
Received: from localhost.localdomain (host-79-26-32-124.retail.telecomitalia.it. [79.26.32.124])
        by smtp.gmail.com with ESMTPSA id v17sm493436edc.47.2021.07.30.03.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 03:37:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: Use in-kernel API and remove no more needed symbols
Date:   Fri, 30 Jul 2021 12:37:14 +0200
Message-Id: <20210730103716.27210-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use crc32_le() in-kernel API in place of the custom getcrc32(). Then
remove no more necessary functions and variables that were needed by
getcrc32().

Fabio M. De Francesco (2):
  staging: r8188eu: Replace a custom function with crc32_le()
  staging: r8188eu: Remove no more used functions and variables

 drivers/staging/r8188eu/core/rtw_security.c | 111 ++++++--------------
 1 file changed, 35 insertions(+), 76 deletions(-)

-- 
2.32.0

