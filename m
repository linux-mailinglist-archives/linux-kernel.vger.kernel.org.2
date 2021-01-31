Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC130998F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhAaBGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhAaBGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:06:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CBC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:05:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e9so8838762pjj.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version:content-id;
        bh=r8k9jK620IYLNsggdgUbg3BsPfEDM6m/yiiU1YLrWAw=;
        b=AbDWEoxLtWC5rFFEoGevGOfkYyOi6vlTsPxqsOxnSxXr56Q7HL5QB1wiG5dcMXr6NT
         jlK8BEg3U6mUS4WaQ626sPx4i4w7uCvkE/VGFSgWXCTZ1hlXgOfndeUc3Cev6dZrPTAF
         2ykugCAEpBSPo50S1Gh7THLM3hMkWdQhaJK9sX4HbKrMRQOEYxcD3sBOfAQ8Jfm1TRXw
         WUTWbC7uJ+ECqhblysqZcD+2L7qSJSBRAZISn1RI7ND8zQJ2+uB+HlVuXEwkKZyObnT5
         a8wYdLUZUOn4+vgxla6BkV+I1X+405HBfufkBCe2cMinsAuYMfY5RBIDP9+ON4LPGOYm
         KOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version:content-id;
        bh=r8k9jK620IYLNsggdgUbg3BsPfEDM6m/yiiU1YLrWAw=;
        b=Im7vseNrJDEByRtbhAqBPaUMJKJS/DP3vLpOYPwPWpcbhRP84OzmN0ELCZtj0oVMfH
         xmdGL047ZuzKrmoyyMjsKtdMmN0cYrdndoxu0TmSSfO+9KQCJ9sIxzVc+KYsdPPAORpO
         6IYXK2tDb9WcC2WqabreLb9A9ZaLzdrymw1Uk/28VzfcLdThD2OLwTYCSnHdV+g/PbCe
         x536M+NFzu40T8utLQSx5WKPWWUZBUkJmf1CZvxtm16C7CnLk3Ktg1lHQ6RBBLm5yn8H
         x1COXYCvX+7gsLjFLLHdPCP1K5Z3Ay1vSdQDp7HRjS4trK766tepH6Nt+DwpLbBqnORB
         drDw==
X-Gm-Message-State: AOAM530Jvre0MSeuCGa4OL5HRUEUQcQyzrKz6aAVrHIjJTLMM6b2sYeQ
        G2XLo69MXuYEdAkXe6pDLi2OZA==
X-Google-Smtp-Source: ABdhPJzyml+kLniFVZmom/yqKS7q4D3rThIp4ffJprGSR2hJefLMlZRkDWBuQ0KTXt6duzjZsobn9w==
X-Received: by 2002:a17:90b:68c:: with SMTP id m12mr10855571pjz.212.1612055152161;
        Sat, 30 Jan 2021 17:05:52 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j14sm10965795pjl.35.2021.01.30.17.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:05:51 -0800 (PST)
Date:   Sat, 30 Jan 2021 17:05:50 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ttm: Use __GFP_NOWARN for huge pages in
 ttm_pool_alloc_page
In-Reply-To: <20210128095346.2421-1-michel@daenzer.net>
Message-ID: <3939e41f-50ea-98c9-6e14-763970e4cbf0@google.com>
References: <20210128095346.2421-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1482994552-668564148-1612055102=:606041"
Content-ID: <af4a7b4a-ceb4-84b2-d3d4-9c6b9db7f13@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-668564148-1612055102=:606041
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <44f0f8f-e050-7c3e-558-921c81485830@google.com>

On Thu, 28 Jan 2021, Michel Dänzer wrote:

> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> Without __GFP_NOWARN, attempts at allocating huge pages can trigger
> dmesg splats like below (which are essentially noise, since TTM falls
> back to normal pages if it can't get a huge one).
> 
> [ 9556.710241] clinfo: page allocation failure: order:9, mode:0x194dc2(GFP_HIGHUSER|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_ZERO|__GFP_NOMEMALLOC), nodemask=(null),cpuset=user.slice,mems_allowed=0
> [ 9556.710259] CPU: 1 PID: 470821 Comm: clinfo Tainted: G            E     5.10.10+ #4
> [ 9556.710264] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.OR 11/29/2019
> [ 9556.710268] Call Trace:
> [ 9556.710281]  dump_stack+0x6b/0x83
> [ 9556.710288]  warn_alloc.cold+0x7b/0xdf
> [ 9556.710297]  ? __alloc_pages_direct_compact+0x137/0x150
> [ 9556.710303]  __alloc_pages_slowpath.constprop.0+0xc1b/0xc50
> [ 9556.710312]  __alloc_pages_nodemask+0x2ec/0x320
> [ 9556.710325]  ttm_pool_alloc+0x2e4/0x5e0 [ttm]
> [ 9556.710332]  ? kvmalloc_node+0x46/0x80
> [ 9556.710341]  ttm_tt_populate+0x37/0xe0 [ttm]
> [ 9556.710350]  ttm_bo_handle_move_mem+0x142/0x180 [ttm]
> [ 9556.710359]  ttm_bo_validate+0x11d/0x190 [ttm]
> [ 9556.710391]  ? drm_vma_offset_add+0x2f/0x60 [drm]
> [ 9556.710399]  ttm_bo_init_reserved+0x2a7/0x320 [ttm]
> [ 9556.710529]  amdgpu_bo_do_create+0x1b8/0x500 [amdgpu]
> [ 9556.710657]  ? amdgpu_bo_subtract_pin_size+0x60/0x60 [amdgpu]
> [ 9556.710663]  ? get_page_from_freelist+0x11f9/0x1450
> [ 9556.710789]  amdgpu_bo_create+0x40/0x270 [amdgpu]
> [ 9556.710797]  ? _raw_spin_unlock+0x16/0x30
> [ 9556.710927]  amdgpu_gem_create_ioctl+0x123/0x310 [amdgpu]
> [ 9556.711062]  ? amdgpu_gem_force_release+0x150/0x150 [amdgpu]
> [ 9556.711098]  drm_ioctl_kernel+0xaa/0xf0 [drm]
> [ 9556.711133]  drm_ioctl+0x20f/0x3a0 [drm]
> [ 9556.711267]  ? amdgpu_gem_force_release+0x150/0x150 [amdgpu]
> [ 9556.711276]  ? preempt_count_sub+0x9b/0xd0
> [ 9556.711404]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> [ 9556.711411]  __x64_sys_ioctl+0x83/0xb0
> [ 9556.711417]  do_syscall_64+0x33/0x80
> [ 9556.711421]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: bf9eee249ac2 ("drm/ttm: stop using GFP_TRANSHUGE_LIGHT")
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>

Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> reported the same issue.
--1482994552-668564148-1612055102=:606041--
