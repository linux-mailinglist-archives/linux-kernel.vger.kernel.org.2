Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EC7401D5C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbhIFPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 11:01:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39104 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbhIFPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 11:01:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAAEB2216F;
        Mon,  6 Sep 2021 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630940418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtLd8PUpY6ySmzB9TkCpxL+dEFac492sN/Mn+31uQ0U=;
        b=BhuvVGKDj60z0dkWsv4qdFmsOnGwz1TLLKU/zpLaeePDixldVArrP4lmpbxkZjxOVMOwWr
        lAFwNVKoD90qrBtgQQkUherK7Spcnr2bYpljOR438F2lXQz6+FazlDE1KbFUvndZwSqQ9/
        MewKYNs8NXt9WX5ekcDgnEB4Z/nHluQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630940418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtLd8PUpY6ySmzB9TkCpxL+dEFac492sN/Mn+31uQ0U=;
        b=GPZjcmZiIdad9Kf9zwg04zZi4k5osODlRR4zLakyoDaCJOk4OKV76hfywsq2P+wN4xl616
        r5j7oMollVgh8QAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B612813C29;
        Mon,  6 Sep 2021 15:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jSa+KwItNmHUZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 06 Sep 2021 15:00:18 +0000
Message-ID: <c2fc9aff-4275-3025-fced-83c0f69e69b1@suse.cz>
Date:   Mon, 6 Sep 2021 17:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH v2] mmap_lock: Change trace and locking order
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210903022041.1843024-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 04:21, Liam Howlett wrote:
> Print to the trace log before releasing the lock to avoid racing with
> other trace log printers of the same lock type.

That description could use more details maybe?

> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
