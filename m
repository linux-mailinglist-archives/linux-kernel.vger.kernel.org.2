Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49038D794
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 23:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhEVVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 17:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbhEVVwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 17:52:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 264A461182;
        Sat, 22 May 2021 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621720288;
        bh=MVoSzpLlxUOzEdfjJRbdh/pcPsg3zH2/R6Cg3GE2BqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CcrQTUD0iNMh9uqRCYKDE3rUcTM6gdwgpdj0aPPsJX5zsB+H9npnftceHCABUfmec
         geoDKMNzS4q3cdVXp/AzyXolxjKj2qszjSrYABv78/ntE/cks2ym33kSHOFxOiT0iJ
         tcyLrtWMudPgkorkc26P1h2ZgbhvOYRU91AszD/0=
Date:   Sat, 22 May 2021 14:51:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        mhocko@suse.com, lukas.bulwahn@gmail.com, vbabka@suse.cz,
        gpiccoli@canonical.com, chenguanyou <chenguanyou@xiaomi.com>
Subject: Re: [PATCH] hungtask: add filter kthread/check comm
Message-Id: <20210522145127.5f56751f164df8af2d3f39fa@linux-foundation.org>
In-Reply-To: <20210521132544.19816-1-chenguanyou@xiaomi.com>
References: <20210521132544.19816-1-chenguanyou@xiaomi.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 21:25:44 +0800 chenguanyou <chenguanyou9338@gmail.com> wrote:

> Some kernel threads are always in D state, when we enable hung_task,
> it will misjudge, we should skip these to narrow the scope.
> 
> exp mtk mobilephone:
> root            435   435      2       0      0 mtk_lpm_monitor_thread 0 D LPM-0
> root            436   436      2       0      0 mtk_lpm_monitor_thread 0 D LPM-1
> root            437   437      2       0      0 mtk_lpm_monitor_thread 0 D LPM-2
> root            438   438      2       0      0 mtk_lpm_monitor_thread 0 D LPM-3
> root            439   439      2       0      0 mtk_lpm_monitor_thread 0 D LPM-4
> root            440   440      2       0      0 mtk_lpm_monitor_thread 0 D LPM-5
> root            441   441      2       0      0 mtk_lpm_monitor_thread 0 D LPM-6
> root            442   442      2       0      0 mtk_lpm_monitor_thread 0 D LPM-7

Maybe convert these threads to use TASK_IDLE?
