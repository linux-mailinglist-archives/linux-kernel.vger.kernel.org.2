Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25B735EDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbhDNGzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbhDNGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:55:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:54:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 10so4214657pfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zjGZSJ4KhJd9LlJKKk+vKP/bKS46sOTGkiQwBP1VtGE=;
        b=KKB9FpUH30uY+/y98TUqidow/1dG2KfxxDL6U/EbsjDCFPOKEPiLKc8p3AHsvTiJmS
         B18PembLrTJMfnAWetvVk06sKbqiuDkHTGi9m0VURe7TJC54rQnqGsGs5G3QXFzZZAgq
         b0nUDBaADaeVpbz4r3XoUrUzXQsmByXV+NWPq2tHd0Ogzc/kF3SCvSCavR6Jl9tUvBKp
         Wk3a77bhepf4kGsOHJ52FVyvMH9Bfwcz+VPMXCwTWc7EiqzvxHnJhreDpyeE+dryoenl
         KLtArye4LjPhgn6JruVO8xtZ/y3XHlQiZwaoxmq1/WnHjdjNu1beqmKEsXm4tgvcULv5
         8uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zjGZSJ4KhJd9LlJKKk+vKP/bKS46sOTGkiQwBP1VtGE=;
        b=giWba+efWSIjB+KI8bvZJmklcH0a8QXxFVAhWpdAVXPkifV7U68+v16u8CUqOIJpIE
         3+7EYN5sI+fNlIVO1JpwS/su1sYBvCBtqtyjBgG0w6nzcJ0gWZQyHd06bEtYvzw9UKKQ
         BUnJtc3JLfM5dacW6wQeyl4GG1+wnpAGxCmkdRaovdt72opEt7agRJeiu55DgD5+BeNB
         RYWmr8/fI8C3ZDg3ywBMg8YY89v/QrA6N9EHAtLBuj592y8ntuGgUix59aqJnxBpYAx0
         qJDdF6lhZiFqcY8ZNMKoY4sf10Q47rA2ricuiy/cOX6qtzO8j7ram1qxKbtprrYNp0Td
         juSA==
X-Gm-Message-State: AOAM530ZmT/jV4WljAvIPlO9O7XmjuGDK1z2Q8mLUXvwManct0hUQmVt
        v3cC7CvHRqt3sbSR7xiPggI=
X-Google-Smtp-Source: ABdhPJxfXzwlTrnnbyk70dIWdFe19sh4MMUMyct7kPX0nzf63n6o/spUl894vJXbSP8WORN+uAtZlA==
X-Received: by 2002:aa7:8c1a:0:b029:249:e2b1:4b2d with SMTP id c26-20020aa78c1a0000b0290249e2b14b2dmr18151700pfd.6.1618383292734;
        Tue, 13 Apr 2021 23:54:52 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id i22sm16164505pgj.90.2021.04.13.23.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:54:52 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:24:44 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Subject: [PATCH v2 0/5] staging: rtl8192e: CLeanup patchset for
 style issues in rtl819x_Y.c files
Message-ID: <cover.1618380932.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:- Dropped 6/6 from and made this as a patchset of 5 as
alignment of code is done in following patches.
[PATCH 1/5]:- No changes.
[PATCH 2/5]:- No changes.
[PATCH 3/5]:- No changes.
[PATCH 4/5]:- Rectified spelling mistake and replaced memcmp with
ether_oui_equal.
[PATCH 5/5]:- No changes.

Mitali Borkar (5):
  staging: rtl8192e: add spaces around binary operators
  staging: rtl8192e: remove unnecessary blank line before brace
  staging: rtl8192e: remove unnecessary blank line after close brace
  staging: rtl8192e: rectified spelling mistake and replace memcmp with
    ether_oui_equal
  staging: rtl8192e: removed multiple blank lines

 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 67 ++++++++---------
 drivers/staging/rtl8192e/rtl819x_TSProc.c     | 10 +++--
 include/linux/etherdevice.h                   |  5 +
 3 files changed, 37 insertions(+), 45 deletions(-)

-- 
2.30.2

