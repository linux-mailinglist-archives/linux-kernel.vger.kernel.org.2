Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306DD3FCCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhHaSQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhHaSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:16:12 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C11C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j12so198594ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HeW13tvhrL9w5gUzeL7/FrKd5rvLwTrOT4w/pqdAqYI=;
        b=gXGwAW3ph6ywIS8Sz5jE+FROTf5zxy9FLtAF8gdEQCU88x0F4zTKe6GmlfHoU+uqYL
         7bg9ATTsnSiC+2DcSi8q6dBnNfY0sJbTvPXohDhE7IcGz/nNL+zK2ELfa1UUaXksTMwu
         AXI9v49SXZPQlSwh3gY2g65C+VIPKJTWREAdZqBQ3mLW+F8IPttFsw/i72huSIuE9kD2
         b6wpnHPHRV8NCLdOjADGs59MaNeq3nB4law5rpgXyAyxK8R9sj7i4SLWOmIQ/n71gzZc
         4HrLEGrl2PGAf8O8xu5bTHzmuru3w8pmkcF7AEXKip4rhaKGFOcMncYI7XF/py6uHVxM
         lYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HeW13tvhrL9w5gUzeL7/FrKd5rvLwTrOT4w/pqdAqYI=;
        b=SacEvfzfkG1/qJ2JTieKn8IK+Lha9HqY4JtjpjsARnS7iM7gMgHBuNOz/NV5q1jb5f
         6CkRTAqSn8m/ob2yHd+4PKgQFlvwedEalRt+dl2CwTmlpONifn9kInKgQ3CkH3M7oD6Q
         KtZCATSM0B0JoI0fh+i+BEuJaHcSSOg3a1vd/9ttkF7JEnM6NRpEzL2KuUCC9n1Fe7mB
         T2DHjimmDPTgg48FwaXlCz9ik3dWJFkh//VGdHcQHIUz7RUoGyE+cOksiq6FMOVF34I6
         bssdNLcvTEBeCzFEuQE/F23ZIpEQ7dAo6ozde9Id3f2LpMRWIcM01DjZ7VpE6YY9dKoV
         JZsQ==
X-Gm-Message-State: AOAM5304ZWd4waam9tS65cUeE8qjNT5N4zVVM/KV0B0NM8mHlzfAsbzs
        KbKwl6QURZOI8M6JyhIQ61mp4E9mpQff6g==
X-Google-Smtp-Source: ABdhPJxewjW9UZrju5EUVd3IeOVLtk2BregE54DcFplZw6qtPBzo0F7AYM26Qs/ppjaObvXxOZmm7A==
X-Received: by 2002:a2e:9798:: with SMTP id y24mr25635516lji.165.1630433714811;
        Tue, 31 Aug 2021 11:15:14 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id z11sm2270757ljn.114.2021.08.31.11.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:15:14 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] fs/ntfs3: Fix various styling issues
Date:   Tue, 31 Aug 2021 21:15:00 +0300
Message-Id: <20210831181505.1074767-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many new checkpatch warnings have been introduce to ntfs3. These could
have been prevent if checkpatch is used. One thing that worrys me is
that Konstantin puts new code without code reviewing process to ntfs3.
Patch commit message says one thing, but one huge patch address that and
lot of just refactoring code.  Also with review process we can prevent
these kind of silly checkpatch mistakes.

Kmalloc_array was my fault for some reason checkpatch did not show
those. I have no idea how, but I just fix it now and be very ashamed.
You should also Konstantin use checkpatch always before push so you can
spot these things before hand. I will try to get CI going for patches.

Kari Argillander (5):
  fs/ntfs3: Use kmalloc_array over kmalloc with multiply
  fs/ntfs3: Use consistent spacing around '+'
  fs/ntfs3: Place Comparisons constant right side of the test
  fs/ntfs3: Remove braces from single statment block
  fs/ntfs3: Remove tabs before spaces from comment

 fs/ntfs3/bitmap.c  | 2 +-
 fs/ntfs3/frecord.c | 8 ++++----
 fs/ntfs3/index.c   | 4 ++--
 fs/ntfs3/lznt.c    | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)


base-commit: d3624466b56dd5b1886c1dff500525b544c19c83
-- 
2.25.1

