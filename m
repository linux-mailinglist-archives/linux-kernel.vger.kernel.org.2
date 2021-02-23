Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5C322FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhBWRbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhBWRbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:31:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F38C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:30:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kr16so2289924pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31hvjCeQ/TpJV4//HHrQZh8uHoQu/HrXyIpK5ERYqFQ=;
        b=ecAW4migcemxW9RBDocLgIYMXjwcIWDbI/zsZO0JrUzcwkIuuFWG1N03p+cM5qEYGK
         OxZR4U2yshOo0em3gT2jbWzWIQQifd2TdRy7CwMK3TFkKup8Uj1UDUuAsePOokiuP80x
         Jm3QdPUyyWvt5OKkt2a1L6X+Sc37GHiWT9Xpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31hvjCeQ/TpJV4//HHrQZh8uHoQu/HrXyIpK5ERYqFQ=;
        b=bVjL6JOOO3qBeRlOTqbt3Ax04yuzwDZroq/PnEQ4qrf9mUfK1sWNRWIBFvJe1RY7U+
         PU9fJ6v3LqrPHh1hPGcdExMA3NtW25wrAV7Oquxb9r1um4gk+yyQqeed/4nbcMciwGei
         KW0Wc/U07wzcBDjngf6WCqFiDXvylCEIGKFMj/bc4BHIUHS/cenHDEAzAC11OIrDFZkI
         OVkE838YADXkDDYz9zDuAUtYzj//5bgaKmAP2Q5CptpT79TC+bu9mQbAd1q8kDe/q2Qb
         0eEvDwtN6rbnrJ8KMG5dyCVsZC2b7kXslrufnEFl6f3+KZeG98hSQIoAyJWv6agz9NWZ
         7Htg==
X-Gm-Message-State: AOAM530mCz9nA/8RLDedAnq31b38ahJcgTvGHahpqbaHVJnUvnXyhH9v
        XmvsmtDn42ieXYWs6vsc4P4xSg==
X-Google-Smtp-Source: ABdhPJyshqnE9WfVRKuAZUg5Fz5goNkTpKBitCaQ28jtBXQCe9/Ai44Nk7LYupxAPGku6el2cSHT/w==
X-Received: by 2002:a17:90a:420c:: with SMTP id o12mr30562970pjg.193.1614101427545;
        Tue, 23 Feb 2021 09:30:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w3sm4072866pjt.24.2021.02.23.09.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:30:26 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anton Vorontsov <anton@enomsg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        syzbot <syzbot+d0cf0ad6513e9a1da5df@syzkaller.appspotmail.com>
Subject: Re: [PATCH] pstore: fix warning in pstore_kill_sb()
Date:   Tue, 23 Feb 2021 09:30:11 -0800
Message-Id: <161410140523.3588113.12183751046979550289.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210214031307.57903-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <00000000000084130f05bb3aa802@google.com> <20210214031307.57903-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Feb 2021 12:13:07 +0900, Tetsuo Handa wrote:
> syzbot is hitting WARN_ON(pstore_sb != sb) at pstore_kill_sb() [1], for the
> assumption that pstore_sb != NULL is wrong because pstore_fill_super() will
> not assign pstore_sb = sb when new_inode() for d_make_root() returned NULL
> (due to memory allocation fault injection).
> 
> Since mount_single() calls pstore_kill_sb() when pstore_fill_super()
> failed, pstore_kill_sb() needs to be aware of such failure path.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: Fix warning in pstore_kill_sb()
      https://git.kernel.org/kees/c/9c7d83ae6ba6

-- 
Kees Cook

