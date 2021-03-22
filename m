Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819E43443E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhCVMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:55:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231979AbhCVMof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:44:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616417071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g7NjXJ5P50fjj+9kPayWsEIvX1rQdbi78jgM0gsDnQA=;
        b=kJ7bsVwLKhYrBKxaTcbYFYPQmjPyNMCytUvEraNMyWaSvj6iN6sqbUXySdFNBTyzavXrIw
        IQjXAdcV5ni0QN3Oo9OT95l445orlp9d96g1Wv1qXWRrpwBCyv18i+gcc8yfzGLH1d/QXl
        O2CXS3+a827ccB4hiJ7IWF/17R92fHs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B51BEACFC;
        Mon, 22 Mar 2021 12:44:31 +0000 (UTC)
Date:   Mon, 22 Mar 2021 13:44:31 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.com>
X-X-Sender: mbenes@pobox.suse.cz
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] objtool: Fix static_call list generation
In-Reply-To: <20210318171919.764599543@infradead.org>
Message-ID: <alpine.LSU.2.21.2103221343080.12460@pobox.suse.cz>
References: <20210318171103.577093939@infradead.org> <20210318171919.764599543@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1045,6 +1045,12 @@ static int add_call_destinations(struct
>  		} else
>  			insn->call_dest = reloc->sym;
>  
> +		if (insn->call_dest && insn->call_dest->static_call_tramp) {
> +			list_add_tail(&insn->static_call_node,
> +				      &file->static_call_list);
> +		}
> +
> +

A nit, but too many new lines here.

Miroslav
