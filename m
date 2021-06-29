Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9373B6F02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhF2H5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:57:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhF2H5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:57:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 31DF922618;
        Tue, 29 Jun 2021 07:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624953316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8kuYq5+fn9VlY2gb7eT3rq5F1CZFlH38xoKf54rl1A=;
        b=GZx4BoaBQcuqmMYnqu8rkBicS8GbaZnUrpIYTL0L8LQbhB7gNhJ7A4NeDxIOpFhEJQIYSD
        rr0rxZKll/8gmi9K5e7W9zj/YAmoGXTlLnklza2VrgoKPktwktkfFDFNlHRfTrPRK2P6Pu
        TS/iyKPZt8zPOSKec+Ga+kJvgA7Sbl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624953316;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8kuYq5+fn9VlY2gb7eT3rq5F1CZFlH38xoKf54rl1A=;
        b=hzL8E4PyiU0gW87JpJ5ulBr/V0daCHQ5bSNdv8RYhIEAQpOTo6MVsu6T0cQeYtzxTC4+IP
        EpWhPV7+MYCGgOCQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 22AF9A3B8C;
        Tue, 29 Jun 2021 07:55:16 +0000 (UTC)
Date:   Tue, 29 Jun 2021 09:55:16 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Michael Forney <mforney@mforney.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] objtool: Update section header before relocations
In-Reply-To: <20210509000103.11008-2-mforney@mforney.org>
Message-ID: <alpine.LSU.2.21.2106290955030.3234@pobox.suse.cz>
References: <20210509000103.11008-1-mforney@mforney.org> <20210509000103.11008-2-mforney@mforney.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021, Michael Forney wrote:

> The libelf implemention from elftoolchain has a safety check in
> gelf_update_rel[a] to check that the data corresponds to a section
> that has type SHT_REL[A] [0]. If the relocation is updated before
> the section header is updated with the proper type, this check
> fails.
> 
> To fix this, update the section header first, before the relocations.
> Previously, the section size was calculated in elf_rebuild_reloc_section
> by counting the number of entries in the reloc_list. However, we
> now need the size during elf_write so instead keep a running total
> and add to it for every new relocation.
> 
> [0] https://sourceforge.net/p/elftoolchain/mailman/elftoolchain-developers/thread/CAGw6cBtkZro-8wZMD2ULkwJ39J+tHtTtAWXufMjnd3cQ7XG54g@mail.gmail.com/
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
