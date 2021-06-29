Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADA63B6F01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhF2H52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:57:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36808 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhF2H50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:57:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DF61420396;
        Tue, 29 Jun 2021 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624953298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SJPDCA11H7G7+5Wf+uDO/CkwNoQC8kvZQumalgcCuuI=;
        b=S5u8RPu/BhuGbujfFQG4I6/I7GvIofZldNIM9F/mt2p7BVyn+ExCAqZbYGMB8xXeaXpmHg
        Omf4OLVBHDn0riRNahhXXA4czltqCfPHvOVgZFRQUfemOGvOcCkD5g8iP+ksHxry15nyP8
        bHjOuIrKEz/YFPuFzvmAwNsl0k9t990=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624953298;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SJPDCA11H7G7+5Wf+uDO/CkwNoQC8kvZQumalgcCuuI=;
        b=SnG7hmEsFLF6u4R14OONvyq26zK0TjLLN27QeWRNx6DsHbgkAzUgnHdWN/gNmA5utTl3MR
        PKOEgZqk/K/fbGDg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF252A3B8A;
        Tue, 29 Jun 2021 07:54:58 +0000 (UTC)
Date:   Tue, 29 Jun 2021 09:54:58 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Michael Forney <mforney@mforney.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] objtool: Check for gelf_update_rel[a] failures
In-Reply-To: <20210509000103.11008-1-mforney@mforney.org>
Message-ID: <alpine.LSU.2.21.2106290954420.3234@pobox.suse.cz>
References: <20210509000103.11008-1-mforney@mforney.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021, Michael Forney wrote:

> Otherwise, if these fail we end up with garbage data in the
> .rela.orc_unwind_ip section, leading to errors like
> 
>   ld: fs/squashfs/namei.o: bad reloc symbol index (0x7f16 >= 0x12) for offset 0x7f16d5c82cc8 in section `.orc_unwind_ip'
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
