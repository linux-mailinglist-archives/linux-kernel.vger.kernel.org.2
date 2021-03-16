Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C111733D130
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhCPJx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236387AbhCPJxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:53:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8596465014;
        Tue, 16 Mar 2021 09:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615888418;
        bh=GSd93vK/PX+RELBJUAGNOA2GGk8bK957V7g6x/JkYN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ktruNk3JQNr8Asa3YoQBhtWV+ggfmv8STLoXyAsB3ptcSlY2O0g+QybedGGMBR8ua
         h7bRfcP5kbvyVbSglRMLpQYiPFNT6G19LYKTZCBlPGsSltA+XvoyQN2nhDgluyB/xV
         zhxqA+2q2jM0H2b10xNTmyA2AkBdLyQtzBcYlTw+U2qdilYnQpkhp+YEeN7WK0bO6u
         0XoDK1zcXwg7iiyIWGFu6QvMTMg7UsQ64q+Rfx0z1krADUDiTuBzWAu2PP06hOn4rM
         sxliERmB9hMslfnt53w+X6CKjPCkLfgibeBPm2dxeeHm7p8Dy9WR0WhHAah+Fdu+eJ
         Lgv2r/kVtyJDQ==
Date:   Tue, 16 Mar 2021 18:53:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools:bootconfig: Fix a typo in scripts/xbc.sh
Message-Id: <20210316185334.69a89cc41d814a01dd2519a2@kernel.org>
In-Reply-To: <20210315122019.1743393-1-standby24x7@gmail.com>
References: <20210315122019.1743393-1-standby24x7@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 21:20:19 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fixes a spelling typo in tools/bootconfig/scripts/xbc.sh
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Oops, good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  tools/bootconfig/scripts/xbc.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/scripts/xbc.sh b/tools/bootconfig/scripts/xbc.sh
> index b8c84e654556..808510f6c168 100644
> --- a/tools/bootconfig/scripts/xbc.sh
> +++ b/tools/bootconfig/scripts/xbc.sh
> @@ -9,7 +9,7 @@ BOOTCONFIG=${BOOTCONFIG:=$XBC_BASEDIR/../bootconfig}
>  if [ ! -x "$BOOTCONFIG" ]; then
>  	BOOTCONFIG=`which bootconfig`
>  	if [ -z "$BOOTCONFIG" ]; then
> -		echo "Erorr: bootconfig command is not found" 1>&2
> +		echo "Error: bootconfig command is not found" 1>&2
>  		exit 1
>  	fi
>  fi
> -- 
> 2.25.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
