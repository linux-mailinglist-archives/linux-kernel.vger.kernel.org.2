Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9860F39F3AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhFHKj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:39:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42716 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhFHKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:39:26 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1A72219AA;
        Tue,  8 Jun 2021 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623148650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDmE6QuhdTyP2nHpIsv6JodtlTnXMn4pqbcTnULJo+U=;
        b=mN9m+U7XOsvR6ZQPol37rfpX9oFXJXqlJsVlWdcH7OtoHSsHu8HGiwuXhRvRvw6UKxC4GX
        CxmiNN+TNGVm+KbYNvuQM51rn/RL+SJumMfp7Qp4qq8DI00ljGEJRlkbQROiwVEk3wzFRd
        fWhRwimnHAZgO6W/9AMhkjynQWkGusA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623148650;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDmE6QuhdTyP2nHpIsv6JodtlTnXMn4pqbcTnULJo+U=;
        b=eFmkzv6qRK5id41CrO5FZjshj+sxdGiIZ61Qtsh6S8nLUdZdK9//zNq1Nm6fyhrScEw7sY
        exS9hD9Y8LNXeoAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7B7E0118DD;
        Tue,  8 Jun 2021 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623148650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDmE6QuhdTyP2nHpIsv6JodtlTnXMn4pqbcTnULJo+U=;
        b=mN9m+U7XOsvR6ZQPol37rfpX9oFXJXqlJsVlWdcH7OtoHSsHu8HGiwuXhRvRvw6UKxC4GX
        CxmiNN+TNGVm+KbYNvuQM51rn/RL+SJumMfp7Qp4qq8DI00ljGEJRlkbQROiwVEk3wzFRd
        fWhRwimnHAZgO6W/9AMhkjynQWkGusA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623148650;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDmE6QuhdTyP2nHpIsv6JodtlTnXMn4pqbcTnULJo+U=;
        b=eFmkzv6qRK5id41CrO5FZjshj+sxdGiIZ61Qtsh6S8nLUdZdK9//zNq1Nm6fyhrScEw7sY
        exS9hD9Y8LNXeoAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id uDqaHWpIv2COBgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Tue, 08 Jun 2021 10:37:30 +0000
Subject: Re: [RFC 02/26] mm, slub: allocate private object map for
 validate_slab_cache()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-3-vbabka@suse.cz>
 <20210525101742.GK30378@techsingularity.net>
 <aad15d62-23c0-9eeb-d61f-a214eb57fb19@suse.cz>
 <20210525113317.GM30378@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2af1b781-cb88-9e37-9b94-921b7ab82949@suse.cz>
Date:   Tue, 8 Jun 2021 12:37:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525113317.GM30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 1:33 PM, Mel Gorman wrote:
> On Tue, May 25, 2021 at 12:36:52PM +0200, Vlastimil Babka wrote:
>> > Most callers of validate_slab_cache don't care about the return value
>> > except when the validate sysfs file is written. Should a simply
>> > informational message be displayed for -ENOMEM in case a writer to
>> > validate fails and it's not obvious it was because of an allocation
>> > failure?
>> 
>> he other callers are all in the effectively dead resiliency_test() code, which
>> has meanwhile been replaced in mmotm by kunit tests meanwhile. But it's true
>> those don't check the results either for now.
>> 
> 
> Ok.
> 
>> > It's a fairly minor concern so whether you add a message or not
>> 
>> I think I'll rather fix up the tests. Or do you mean that -ENOMEM for a sysfs
>> write is also not enough and there should be a dmesg explanation for that case?
>> 
> 
> I mean the -ENOMEM for a sysfs write. While it's very unlikely, it might
> would explain an unexpected write failure.

On second thought, a failed GFP_KERNEL allocation will already generate a
prominent warning, so an extra message looks arbitrary.


