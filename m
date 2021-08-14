Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF103EC013
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 05:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhHNDcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 23:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236695AbhHNDcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 23:32:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9028C60F9E;
        Sat, 14 Aug 2021 03:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628911895;
        bh=L3oY5hXkXWDwvwIuPw6Dn3P4X7n4aLNr6c3fpDyL58Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eiU7Di6xOcxNOgDMylzl4MdWinaMtQefbDuVUKcJcb7V6f6kwWhkki6N81dkyNmia
         NaNLbBiFsLzmIJbjxvGfcB953LCPJOJtH7zK3DszsC27DRBouwzg8YNbgiNsw6lD4e
         tB3GeH58YbilBSCXLrkd3Mgceg3K4/7n8r0I7D7VGTHjpasX50WAHZPeOxSfbNSk2S
         nh645Wv2yZVU3Jj7ZgFHs1bsQKPKwYG6FUOFZZCzSruBXvXM/Qvp2uurDdK18rI5dF
         0+A1/ShZr+Kkrp4Rw4fHDpnp3hxJ++Wh/w/7iQ4MDYTzSgi0NHU44RwBeEJ+lzynEa
         KZ7hoqJOmWFvQ==
Date:   Sat, 14 Aug 2021 12:31:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v4 07/10] tools/bootconfig: Support per-group/all event
 enabling option
Message-Id: <20210814123132.29181525b4debbf3bc5447bb@kernel.org>
In-Reply-To: <162856127850.203126.16694505101982548237.stgit@devnote2>
References: <162856122550.203126.17607127017097781682.stgit@devnote2>
        <162856127850.203126.16694505101982548237.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Aug 2021 11:07:58 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Oops, I missed the changelog for this patch.

-----
Add group or all event enabling syntax support to bconf2ftrace.sh.
User can pass a bootconfig file which includes

ftrace[.instance.INSTANCE].event.enable

    and

ftrace[.instance.INSTANCE].event.GROUP.enable

correctly.
-----

Steve, should I update the patch and resend the series?

Thank you,
    


> ---
>  tools/bootconfig/scripts/bconf2ftrace.sh |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
> index feb30c2c7881..651049c782c0 100755
> --- a/tools/bootconfig/scripts/bconf2ftrace.sh
> +++ b/tools/bootconfig/scripts/bconf2ftrace.sh
> @@ -101,6 +101,12 @@ setup_event() { # prefix group event [instance]
>  	else
>  		eventdir="$TRACEFS/events/$2/$3"
>  	fi
> +	# group enable
> +	if [ "$3" = "enable" ]; then
> +		run_cmd "echo 1 > ${eventdir}"
> +		return
> +	fi
> +
>  	case $2 in
>  	kprobes)
>  		xbc_get_val ${branch}.probes | while read line; do
> @@ -127,6 +133,13 @@ setup_events() { # prefix("ftrace" or "ftrace.instance.INSTANCE") [instance]
>  			setup_event $prefix ${grpev%.*} ${grpev#*.} $2
>  		done
>  	fi
> +	if xbc_has_branch ${1}.event.enable; then
> +		if [ "$2" ]; then
> +			run_cmd "echo 1 > $TRACEFS/instances/$2/events/enable"
> +		else
> +			run_cmd "echo 1 > $TRACEFS/events/enable"
> +		fi
> +	fi
>  }
>  
>  size2kb() { # size[KB|MB]
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
