Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3773813CA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 00:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhENWbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 18:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233967AbhENWb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 18:31:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D1A561454;
        Fri, 14 May 2021 22:30:16 +0000 (UTC)
Date:   Fri, 14 May 2021 18:30:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     brookxu <brookxu.cn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace: replace WB_REASON_FOREIGN_FLUSH with a string
Message-ID: <20210514183014.592d4567@gandalf.local.home>
In-Reply-To: <1619914347-21904-1-git-send-email-brookxu.cn@gmail.com>
References: <1619914347-21904-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Would you like to take this?

-- Steve


On Sun,  2 May 2021 08:12:27 +0800
brookxu <brookxu.cn@gmail.com> wrote:

> From: Chunguang Xu <brookxu@tencent.com>
> 
> Now WB_REASON_FOREIGN_FLUSH is displayed as a number, maybe a
> string is better.
> 
> v2: replace some space with tab.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  include/trace/events/writeback.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 1efa463..7c78c04 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -36,7 +36,8 @@
>  	EM( WB_REASON_PERIODIC,			"periodic")		\
>  	EM( WB_REASON_LAPTOP_TIMER,		"laptop_timer")		\
>  	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
> -	EMe(WB_REASON_FORKER_THREAD,		"forker_thread")
> +	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
> +	EMe(WB_REASON_FOREIGN_FLUSH,		"foreign_flush")
>  
>  WB_WORK_REASON
>  

