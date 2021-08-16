Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE053EE082
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhHPXph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhHPXpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:45:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43256C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:45:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q10so25937769wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4/Ddg64kkfjqf2isPMPVplHIsvSq8ZE7jaLWqZikzI=;
        b=WdwxxNM1Twv5HWBhVDJfyWGZLGtE+vLVxqEkAwFZR/Ao1iO1QLbuBrEqFOEaLnBsn9
         loYcF6sNEaAMYtDan+xdMrPlgAq70ylWhdtkcCyBCdq776uCXhBmCZsRNcLVl1rTUrr9
         WlZ4pq0yP3Ze9Pgr5jUNCWJL21ImV+E9gOP+UQKsi67boX6xm8VtFMKBBr8FmEE1o0KL
         SgahclB3jOvYBQ1j02OSkgLIOhmsrDWqBW4bXxNTofi0WEJo+OzmLuAPEM4LvpiJr5pt
         kzeabJn7lZqor4uHOM4tz9XQ0cle3vwPL67hkwgdigH2q7EnQ/nEIegTOZbOzUZkgJe9
         ZzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4/Ddg64kkfjqf2isPMPVplHIsvSq8ZE7jaLWqZikzI=;
        b=r7FPJntdrF29MB1QCcP4QiR6kCUVqAa85LEn7W/jpicUZU2gR/XtlQk59SnA/vmYyp
         +mA5o4TUtkFlDAs8ROZ/w8F6qzvUsYy7VYwVTdZfn8NHXEQ+EZ71CR3phuL5gYKMj04C
         CpGvXn+pv0+qcGJioeup9rZe9WUlBg85ek7RoxFr0JkY9eq7E9dId0pf2FEqhQ4FSyg8
         qfRYgVJTFTt+SLU+UYXJ+CwTQcvgKorGdYyKJ7rOVxTVINfDucWdwk0VVKiKKG/2q+R5
         HXoMfF0D4EhNpkJl2kx/A09RA5ka5Y2P+SYh6QZyd04bI57EzkQvd6xz3/X0nem+AXMX
         U3/g==
X-Gm-Message-State: AOAM530WJQJKf6ur6EfZqXSQjQgx/BaaGFzRk0Ll3Plq87+uNZO+3H6j
        FW6RT8WzJTcTDIjgm8OFM0KFXg==
X-Google-Smtp-Source: ABdhPJwyC0+NlHuN7UpIoi/LWuaYaE11hWH+Z9kUhQtWBL75GAkI+CKQPDV1IgSsXMfq2RoWMXHeCw==
X-Received: by 2002:a05:6000:18c8:: with SMTP id w8mr549068wrq.90.1629157502843;
        Mon, 16 Aug 2021 16:45:02 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id w11sm291521wrr.48.2021.08.16.16.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 16:45:02 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: r8188eu: changes to rtl8188e_Add_RateATid
Date:   Tue, 17 Aug 2021 00:44:56 +0100
Message-Id: <20210816234459.132239-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does some cleanup on the rtl8188e_Add_RateATid function in
hal/rtl8188e_cmd.c:
Removal of a set but unused variable.
Removal of an unneeded DBG_88E call.
Other cleanup (spacing around operators and un-camel-casing a variable).

Revisions of this patch set:
V1: contained everything in one patch.
V2: takes account of feedback from Greg Kroah-Hartman and Fabio M. De
    Francesco to split patch up, and more accurately reflect patch
    changes in subject lines.

Phillip Potter (3):
  staging: r8188eu: remove set but unused variable from
    rtl8188e_Add_RateATid
  staging: r8188eu: remove unneeded DBG_88E call from
    rtl8188e_Add_RateATid
  staging: r8188eu: perform cleanup in rtl8188e_Add_RateATid

 drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

-- 
2.31.1

