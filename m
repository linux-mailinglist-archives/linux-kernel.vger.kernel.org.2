Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE16E40B43D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhINQMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:12:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59952 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbhINQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:12:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FE131FE25;
        Tue, 14 Sep 2021 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631635862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5C+B3s0+s0kVAvW4V7aTwm7p5FXKMe3BMinycoHWq7Y=;
        b=i9eV3r3FIPHOQNdNf/CW/GDUW3bqiD53fKWAxaE1SHU1S1Ytd9RLvPedrIcJ969SUdcbtD
        CW8Q5vT7ymAtE2Y29q0+iUpOybsyT1/iHw6UZUB4Mgr5qm90jimmyysImuJYMf7fkKcZ20
        ZNknuPXUONAjWPy/Ld51RCXv/zzMxfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631635862;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5C+B3s0+s0kVAvW4V7aTwm7p5FXKMe3BMinycoHWq7Y=;
        b=YvaZOTmzjHv0DAJbtjujmYd45L4C+vqyCtA0YUc0bkoG7zJL3xumM+62H8Jg6OQBCCGxPi
        vPsybwUSVysp8uCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBC6813ABE;
        Tue, 14 Sep 2021 16:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x8fROJXJQGGYLwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Sep 2021 16:11:01 +0000
Message-ID: <e5c7ce5b-93f0-b305-de32-c99d0390eb28@suse.cz>
Date:   Tue, 14 Sep 2021 18:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [for-linus][PATCH 1/2] bootconfig: Fix to check the xbc_node is
 used before free it
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20210914144809.297030763@goodmis.org>
 <20210914145033.337080566@goodmis.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210914145033.337080566@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 16:48, Steven Rostedt wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Fix to check the xbc_node is used before calling memblock_free()
> because passing NULL to phys_addr() will cause a panic.
> This will happen if user doesn't pass any bootconfig to the
> kernel, because kernel will call xbc_destroy_all() after
> booting.
> 
> Link: https://lkml.kernel.org/r/163149460533.291098.7342418455457691240.stgit@devnote2
> 
> Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Should have replied here.

Tested-by: Vlastimil Babka <vbabka@suse.cz>

details:
https://lore.kernel.org/all/61ab2d0c-3313-aaab-514c-e15b7aa054a0@suse.cz/

> ---
>  lib/bootconfig.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index f8419cff1147..4f8849706ef6 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -792,7 +792,8 @@ void __init xbc_destroy_all(void)
>  	xbc_data = NULL;
>  	xbc_data_size = 0;
>  	xbc_node_num = 0;
> -	memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
> +	if (xbc_nodes)
> +		memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
>  	xbc_nodes = NULL;
>  	brace_index = 0;
>  }
> 

