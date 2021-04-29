Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0C36E7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbhD2JaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:30:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230392AbhD2JaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:30:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619688572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GURfDSTelGx7xUlgLiEjO8EKMyn3vHPONCEGq/bqGyo=;
        b=iSeBHVapQW+dkmCSYYPSjTQ+YV2t1ymKcCP+xacQPXGFRePFoDgme/OTaY2fPASBxxdM+u
        VBar4aVndRgLEEK/2nmuOT39PhNAq62wxd0+eAz+pFRvuiGBnMRYvB58Cpv8XbpA6g6EfD
        zAKNByCTYg0kHAk7Bmmua4GHr73eKw4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8931B018;
        Thu, 29 Apr 2021 09:29:32 +0000 (UTC)
Date:   Thu, 29 Apr 2021 11:29:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Wang Qing <wangqing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2,RESEND 1/4] kernel: watchdog: Modify the explanation
 related to watchdog thread
Message-ID: <YIp8e6ftzUdgX4Yv@alley>
References: <1619687073-24686-2-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619687073-24686-2-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-04-29 17:04:25, Wang Qing wrote:
> The watchdog thread has been replaced by cpu_stop_work, modify the 
> explanation related.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

You should have added my Reviewed-by when resending the patchset.
Anyway, for all four patches:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Andrew, would you take it via -mm tree?

Best Regards,
Petr
