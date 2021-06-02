Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD903993C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFBTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:47:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50200 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBTrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:47:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5FAF51FD3C;
        Wed,  2 Jun 2021 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622663158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/oc7YZVc05AvuONiWEUclRuOrK26WvFpQMDXLOqQ9c=;
        b=UVlFEgG3USHB6GmF2UBb4j2hKuSpBF1PUQK2tZZvFfFKLvQwzIHFvKOr52vbvFRZJcbqHy
        /KQU5u0CoKFdVaXQTEkEVTr3HwaKCa3NiIUFmHKYR9XT+7uxKzTthxvH4TLUrYI/alTFMF
        r/VTLvI8Evom92o9sMeNIvilmjd/bk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622663158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/oc7YZVc05AvuONiWEUclRuOrK26WvFpQMDXLOqQ9c=;
        b=c7ryAEr6OsnLL2688tPFa+O88w77ef77Ecd6ZYceexmGhQpm9tnDi1snWK5pTruXCA8tcS
        A+rmZ9QdxEpbYzCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 531DD118DD;
        Wed,  2 Jun 2021 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622663158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/oc7YZVc05AvuONiWEUclRuOrK26WvFpQMDXLOqQ9c=;
        b=UVlFEgG3USHB6GmF2UBb4j2hKuSpBF1PUQK2tZZvFfFKLvQwzIHFvKOr52vbvFRZJcbqHy
        /KQU5u0CoKFdVaXQTEkEVTr3HwaKCa3NiIUFmHKYR9XT+7uxKzTthxvH4TLUrYI/alTFMF
        r/VTLvI8Evom92o9sMeNIvilmjd/bk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622663158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/oc7YZVc05AvuONiWEUclRuOrK26WvFpQMDXLOqQ9c=;
        b=c7ryAEr6OsnLL2688tPFa+O88w77ef77Ecd6ZYceexmGhQpm9tnDi1snWK5pTruXCA8tcS
        A+rmZ9QdxEpbYzCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id BIbxE/bft2BXDAAALh3uQQ
        (envelope-from <osalvador@suse.de>); Wed, 02 Jun 2021 19:45:58 +0000
MIME-Version: 1.0
Date:   Wed, 02 Jun 2021 21:45:58 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
In-Reply-To: <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
User-Agent: Roundcube Webmail
Message-ID: <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-02 20:37, David Hildenbrand wrote:
> Long story short, using get_online_mems() looks wrong.
> 
> Maybe the current lightweight reader/writer protection does serve a 
> purpose?

It was too nice and easy to be true I guess.
Yeah, I missed the point that blocking might be an issue here, and 
hotplug operations can take really long, so not an option.
I must have switched my brain off back there, because now it is just too 
obvious.

Then I guwmess that seqlock must stay and the only thing than can go is 
the pgdat resize lock from the hotplug code.

Meh.

-- 
Oscar Salvador
SUSE L3
