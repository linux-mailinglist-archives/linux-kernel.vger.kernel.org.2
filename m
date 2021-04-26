Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB00436B67D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhDZQIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbhDZQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:08:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:07:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso5589495pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7IJTiftTRCYNE58mebJi7CsbHWjfR72oScneYqnG9Ls=;
        b=y2Rj/5nqSUo2to/jdMcX6XxBwVgXYK7OCaT12dmQBMaF3bBzWGi1kwuWy5WuiuZHOZ
         0M9DqCQdZ0DcdbzXGEvngqt1kvD7O/IknEdXCmQ8NWoQP/N0o0mjXalnK+wMUtSznSY7
         eLRLh2iFSDY2c4RNEs4OuWznd9kUpgp/oeSuw+nkvgDNwUKW0cVbU9ENFC9ddmfd4Dox
         2PZR68S38YCWrfHvTwd+SoCWcwmYd/IHFFwxwWDpV5W2WpTYwRx2kgx6sH43BbHYcJuO
         VF3gok5H6lysZEmwpUQLJpoF07fjCoV+u1wNqtG0ysLgmVVisumXM7CawxwHpHrmvSgE
         Hzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7IJTiftTRCYNE58mebJi7CsbHWjfR72oScneYqnG9Ls=;
        b=LC7Xwo/l82g+rMlQ6MGapoRTrrJKcuC2WWmikbSgHaMSlvoL4SYF2y2V0+37y4TgTt
         yT07CYe/7Pqjtb0F931DRcOTb0DEueEWXoBrEPbF3fc7KpfmQIdEzOGqV97lCD0agZYU
         QVImdqg7nUt4TE34bbYWIQ2rlA+dMrHY67kmL394E0cHeoVrbz2BredDf80mCoqu8kK8
         rxyb1Hmcpp7beh1f1B2pv20yfGbapuP6dpuKuc3/qaqo2ofLshdGO6vSOulcC5hQuJMr
         roxuQlEf1g2PF7VuWhVV5CsFV4pozq6lvyQepCiOXwbT3cKVuKpP+9cOoAH0JAe1fC2p
         4ATA==
X-Gm-Message-State: AOAM5316AbIbwWEdPgrG/bxfMcFsdWAdfQqWkevEIKMe5n6u7O66UQ6y
        y1FmcjTd+6MT3+g2nncTF+7PBA==
X-Google-Smtp-Source: ABdhPJzPgNSDIhHXVpuq3+W2wjW+mucevBUukLaeO4ubj039pw5w6VEb4fHr5LvILZAPzPXGCGgZug==
X-Received: by 2002:a17:902:e8d5:b029:e6:cabb:d07 with SMTP id v21-20020a170902e8d5b02900e6cabb0d07mr19031619plg.3.1619453247608;
        Mon, 26 Apr 2021 09:07:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a16sm11587350pgl.12.2021.04.26.09.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:07:26 -0700 (PDT)
Date:   Mon, 26 Apr 2021 09:07:26 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Apr 2021 09:07:24 PDT (-0700)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
In-Reply-To: <20210425130113.7bfe5cad@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-215fe0c9-b695-4d8f-97b2-667560e63267@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Apr 2021 20:01:13 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Commits
>
>   97db849866cf ("riscv: vdso: fix and clean-up Makefile")
>   ab541f55291b ("riscv: Set ARCH_HAS_STRICT_MODULE_RWX if MMU")
>   c79a9a16f7e7 ("riscv: module: Create module allocations without exec permissions")
>   b170834bcc98 ("riscv: Mark some global variables __ro_after_init")
>
> are missing a Signed-off-by from their committer.

Thanks, these should be fixed.  I also found that I'd accidentally push 
up my test merge from last week, which I've cleaned up as well.
