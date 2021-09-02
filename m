Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B08A3FEA46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbhIBH4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:56:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32868 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbhIBH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:56:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99A7622479;
        Thu,  2 Sep 2021 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630569317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtCcql6hcNDFk2Mt6ipSvxcUCyGqqnhRS9SxqnHrxyA=;
        b=mASWHtqQ1ZhYEx1m4yJsu/bOeO+CudGsilMmicm63aJIJYyDKlHBKe61ci2ocTN8GEuJqM
        +mVTo5BBX26qWJdVKhCeYQlzyu9sgUbClJ1qJ5ZQ1enfbV0oLztUDHwkaL28BFtLpXcHoR
        aWSRCr8/k0Nz3ErgwElCuVaEPKBHn1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630569317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtCcql6hcNDFk2Mt6ipSvxcUCyGqqnhRS9SxqnHrxyA=;
        b=Wz/Qsv3OZo4v1KExKb8JcH+TKrDsL2x8WNo4NoCH9Jbe3ByTW6p/pa1FyaUmttQQtUx4AC
        LT1MmGMVaitMYrBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 771301389C;
        Thu,  2 Sep 2021 07:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +olaHGWDMGHUQAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 02 Sep 2021 07:55:17 +0000
Message-ID: <85f4f073-0b5a-9052-0ba9-74d450608656@suse.cz>
Date:   Thu, 2 Sep 2021 09:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [RFC PATCH v2 2/2] lib, stackdepot: Add helper to print stack
 entries.
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, geert@linux-m68k.org,
        akpm@linux-foundation.org, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210902000154.1096484-1-imran.f.khan@oracle.com>
 <20210902000154.1096484-3-imran.f.khan@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210902000154.1096484-3-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 02:01, Imran Khan wrote:
> To print a stack entries, users of stackdepot, first
> use stack_depot_fetch to get a list of stack entries
> and then use stack_trace_print to print this list.
> Provide a helper in stackdepot to print stack entries
> based on stackdepot handle.
> Also change above mentioned users to use this helper.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
