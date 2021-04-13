Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EABE35D5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbhDMDZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbhDMDZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:25:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:25:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k21so1473250pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SRXvRUJitDAL3LVBcxgMSN2+Nyo+g/E1R/YUuhMK3zY=;
        b=NT5wxcrMIElDPZAIwOHzPA+cCkYYmfN0PcrXjLMovuafkLeOokhyvZDn2+qKo1JRMw
         yfifmdoDp0w2m5Lq8veWu5rKtEumpKNmqr5PHwjWEM9M+FvcakfBMLmH5HMQ5mVP+Y+m
         Xc6qu+v5+bA4mn4ApziWUp4d9NSZ7y7kojwd/lKea4W7FW4qdJbG6GwkCemLFG241fRU
         2LOd1mtDMhFJdW6M88KvI8PSK+ZpgeDOPmQ60KIxOUuea6gtP7WojxZbAjsV4dUTCPa9
         WGSxnkmoixLKk4UHZqJul0iqUf0VQNm+Cuv3hxFjsj0qN9e8/NrkHF/Ve38cU4JU80PD
         0Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SRXvRUJitDAL3LVBcxgMSN2+Nyo+g/E1R/YUuhMK3zY=;
        b=avL5lyosSZ4141NHKeagomvoDmc0mo8+eRoE5t+smDFktnOxwxI7TdPFvR680zgb/o
         xoSD3CSj39X9/KT112/7y7yoHCTefRtIApVP0o96mUccfU3xAgWFWrXzEMT4rNlUqAj3
         Hh19whHsoZkVn0qsFGoPj7LqVVyT8SKmiFq3hZDzbpVEAB2cg1v60m7yrGkQDKU1634p
         k+J1OytQisawmtgfcQxi2QUN7Q9ggx16ugnT9lDJ4qVrTu6+EQ6I6OyEq0zNjnzbSFHV
         TmjbnDKOxSrT1+uLYY+AtUTzM0uHMhHp5nkkJvQidmMQtEf3XXpIkeV0kdpHKMUEFo7d
         pwDQ==
X-Gm-Message-State: AOAM5303SchIQKUjv20NektOd3tB594kb2/+wEYb0OADMHZrqlavtcma
        hWVzvOP5eLZxQ6yTe5wF7+gFuNAGEK158Q==
X-Google-Smtp-Source: ABdhPJz3w+bs8FKEbZQO5/VCoWcYR59uE27wBIEKt7H5yflDTqlYWDg0XRJIdjOaTQbyPflIpgtrDg==
X-Received: by 2002:a17:902:aa8a:b029:e6:64bd:e29d with SMTP id d10-20020a170902aa8ab02900e664bde29dmr30083774plr.24.1618284309436;
        Mon, 12 Apr 2021 20:25:09 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id s20sm8993891pfh.144.2021.04.12.20.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 20:25:09 -0700 (PDT)
Date:   Tue, 13 Apr 2021 08:55:03 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v5 0/3] staging: rtl8192e: Cleanup patchset for style issues
 in rtl819x_HTProc.c
Message-ID: <cover.1618283232.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v4:-
[PATCH v4 1/3]:- No changes.
[PATCH v4 2/3]:- No changes.
[PATCH V4 3/3]:- Removed casts and parentheses.

Changes from v3:- Changed subject line to match prefix on the patches.
[PATCH v3 1/3]:- No changes.
[PATCH v3 2/3]:- No changes.
[PATCH V3 3/3]:- No changes.

Changes from v2:-
[PATCH v2 1/3]:- Modified subject description. Changes has been made in
v3.
[PATCH v2 2/3]:- No changes.
[PATCH v2 3/3]:- Rectified spelling mistake in subject description.
Changes has been made in v3.

Changes from v1:-
[PATCH 1/3]:- Removed unnecessary parentheses around boolean expression.
Changes has been made in v2.
[PATCH 2/3]:- No changes.
[PATCH 3/3]:- No changes.

Mitali Borkar (3):
  staging: rtl8192e: remove parentheses around boolean expression
  staging: rtl8192e: remove unnecessary ftrace-like logging
  staging: rtl8192e: remove casts and parentheses

 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  18 ++--
 1 file changed, 5 insertions(+), 13 deletions(-)


-- 
2.30.2

