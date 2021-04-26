Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3836B7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhDZRPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhDZRPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:15:35 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D62C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:14:53 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id gv2so18294030qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GCAPi9gnTpy/8eag0I4x1AXUBjLbBBwgQYNygxMuoO4=;
        b=JrAD5UkOrA3X0n82t+2R9ytotkGPQEtjGt3hV4uQSMyAXuoD296DrG4fHyjwR8j2lm
         1l3YG588tbIBunoEB/hq4jTAj+9HJl9o61zX+wFXmYqjc7vk+zAVc+8Av20N7KnS7xTx
         yvURegVw4tRVL3AA3lJxVpWS0/XUW0txzsM8KSjQ45hJsE+XZr1DSGxbeoA0UYhbYL+F
         L3yJbJXw0Q6bPB1A1cgLzt5yCsOMVT7hg4XJssfEM967j3tRMGgxWpMOgbP4YNx2g633
         3+tUIie57siT5qci4nrzunJvO+qQ+FDBwKCWfZu/tTBS9C2KJiszgsi8LFRNglx0h0yY
         qUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GCAPi9gnTpy/8eag0I4x1AXUBjLbBBwgQYNygxMuoO4=;
        b=QBl3MzFbdXvAbCs+cO47tz63XDRiBncuwFNbbh1SMpwnhSfYwI4tF1IDbMsfo+vgkr
         BbdwZzqOyjmOtuEm/YBMGIFnY53qVKgNlQn846ECEUst4DpUVQSz1QpdZeR1SM7HpLuD
         8Rd8+p6DbqWTFr2HKd3Io5Lpc0tZnX599LN0FnUgr5UZq3L99JFVE6Tdu8q5w3Zy1/vz
         s7JkmOHyK75PKkMMHDBRgsEc8vjtKjPHEJ654NUZGglJWSJUS2T8OvXpG0Zbu5WR3Cgz
         JGfcSn7PtnWI0cl1jb4lgJWAhFhWOxmoIId3R57rHMTxL+xaAHGOLw6DjNWlnUs544So
         oWSw==
X-Gm-Message-State: AOAM532uyLd5I2vveOH//YN5DfjViNdMCNtRFPiIJ8UHA22rHv2hIyIH
        OgoZ0+isfSlqjPQFz5s8pWE=
X-Google-Smtp-Source: ABdhPJyJTphILptsxX6CDcZ/C+LxSFiNDQ5oxTcc2pBYOVcGU91lMTL++lUrxjY2LN0cpxLsWii/Vg==
X-Received: by 2002:a05:6214:268f:: with SMTP id gm15mr18723648qvb.62.1619457292919;
        Mon, 26 Apr 2021 10:14:52 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id i127sm580873qke.71.2021.04.26.10.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 10:14:52 -0700 (PDT)
Date:   Mon, 26 Apr 2021 10:14:51 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     yury.norov@gmail.com
Subject: wrong patch order
Message-ID: <20210426171451.GA133505@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

In the next-20210426 I see the commit 7c3c0a5796a8 "h8300:
rearrange headers inclusion order in asm/bitops" is applied after
a54cbe7fa597 "lib: add fast path for find_next_*_bit()".

This may cause cause build failure for h8300 while bisecting.

Can you please change order of the patches so that 7c3c0a5796a8 would
follow 68b80f24c2f6 "arch: rearrange headers inclusion order in
asm/bitops for m68k and sh"? It's also possible to merge 7c3c0a5796a8
and 68b80f24c2f6 because they address the same issue.

Thanks,
Yury
