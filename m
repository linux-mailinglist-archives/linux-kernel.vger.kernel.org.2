Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2F3E2DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbhHFPgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:36:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhHFPgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:36:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89DF222426;
        Fri,  6 Aug 2021 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628264179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/SzI1b8roifatTGVdNUueHB2p+u563uKTQPFj/ICfU=;
        b=YwLLjMqAGe5/JcIBxU4RtVAHbGmKb205bHTmlg/4lTGMQGA6tSb27yv9ep0NeY3NfIYJVM
        yOQhg3/PRcjZ2oo7BVKlslZtn2MWB47JBtdqAiyM3H8OdtReMQ1lgi8mJrg+XSiTghhQhQ
        PTJPm+3mX43KFh/cYGdyA1HBc0NttHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628264179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/SzI1b8roifatTGVdNUueHB2p+u563uKTQPFj/ICfU=;
        b=te7htrDx210RhQaDluHmmOYI41uNnAU3QUhHwKP5S/VsW9mThyjfJoyIKdaO+VF8om2COp
        ih24c70zxQxXkBCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 25A9713A86;
        Fri,  6 Aug 2021 15:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3etuB/NWDWFUMAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 06 Aug 2021 15:36:19 +0000
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time
 parameter.
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <40982106-0eee-4e62-7ce0-c4787b0afac4@suse.cz>
Date:   Fri, 6 Aug 2021 17:36:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 9:02 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>

> Patch 3 restores the pfn_valid_within() check when buddy allocator can merge
> pages across memory sections. The check was removed when ARM64 gets rid of holes
> in zones, but holes can appear in zones again after this patchset.

To me that's most unwelcome resurrection. I kinda missed it was going away and
now I can't even rejoice? I assume the systems that will be bumping max_order
have a lot of memory. Are they going to have many holes? What if we just
sacrificed the memory that would have a hole and don't add it to buddy at all?
