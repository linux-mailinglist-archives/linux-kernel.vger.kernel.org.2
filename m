Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B728A38FBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhEYH1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:27:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhEYH1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:27:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621927575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7T7PKaicDoiKTzfegVuX9iV+jmrHLUsZmHeGnROKAQ=;
        b=FlGmu7tvUW2Y/LaXdhZDqTI0vBL7JbiTuofGU/30AUa1j4hXXie6mQMz9Eh7iYlWkSyvXm
        L+dEmY4TcUDZt8uU/FyLsMEeQumwbRbQJnv+v/yYIVS5cSR2TonzduVvg8/HRt5y/7Rxi3
        r82lGaUCtkAL+dIgqXItMICbdheJrUQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 551E5AEE5;
        Tue, 25 May 2021 07:26:15 +0000 (UTC)
Date:   Tue, 25 May 2021 09:26:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6ZmI5Yag5pyJ?= <chenguanyou9338@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: Re: [PATCH] hungtask: add filter kthread/check comm
Message-ID: <YKymlullP1wuT+UE@dhcp22.suse.cz>
References: <20210521132544.19816-1-chenguanyou@xiaomi.com>
 <20210522145127.5f56751f164df8af2d3f39fa@linux-foundation.org>
 <CAHS3RMWjuB98TzvcYyQ0qtNYOxDeM7W1YmyqDYs=H-cn-VsVdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS3RMWjuB98TzvcYyQ0qtNYOxDeM7W1YmyqDYs=H-cn-VsVdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-05-21 11:27:16, 陈冠有 wrote:
[...]
> These are MTK's LPM designs.

No idea what those are but it seems like an out of tree code.

> If we have linux-api, hungtask can choose to skip kthread, helpful for us
> to debug user space threads in "state=D" when enable hungtask panic.

No, this approach is wrong. You are trying to workaround an incorrect
out of tree code by creating a user visible API. I have already brought
that up in earlier version of this patch.

Nacked-by: Michal Hocko <mhocko@suse.com>

Andrew has already given you a lead on how to fix the said code. Use
TASK_IDLE when waiting for an event. This will both hide that waiting
task from load average accounting and also from the hung task detector.
-- 
Michal Hocko
SUSE Labs
