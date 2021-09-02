Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0997E3FEA54
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbhIBIBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 04:01:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34678 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243607AbhIBIBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:01:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3953224A5;
        Thu,  2 Sep 2021 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630569604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wG5ludP/4gEC4SIqeHD4LJedSIA+YmEOtAhafiN+9Bc=;
        b=ljz7RDfQQWWZGl2/9ptgiitKdg3yYD5U31/Vmt3t2TM19StScduna3l6L+5HLZDLcy1gwt
        2hyIlqAR3MsZXf5JYdZ9Z5tlmipu1kVbr7ed6aYymiRDkJr3WZCAEnIZgg1ko92vdMui+x
        a1+TBNnSCYge+Q0kZLuAJbrk75sIMfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630569604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wG5ludP/4gEC4SIqeHD4LJedSIA+YmEOtAhafiN+9Bc=;
        b=wall8DtTRhiFL3sM/yMG4YyVJjGyqY362o5tkQlIroCT3FR0bLID1USPceriXe54lIryct
        go7i+GvcntJLvHAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 96F6213A75;
        Thu,  2 Sep 2021 08:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2ZstJISEMGFDQgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 02 Sep 2021 08:00:04 +0000
Message-ID: <e6f6fb85-1d83-425b-9e36-b5784cc9e69a@suse.cz>
Date:   Thu, 2 Sep 2021 10:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [RFC PATCH 2/2] lib, stackdepot: Add helper to print stack
 entries.
Content-Language: en-US
To:     imran.f.khan@oracle.com, geert@linux-m68k.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>
References: <20210901051914.971603-1-imran.f.khan@oracle.com>
 <20210901051914.971603-3-imran.f.khan@oracle.com>
 <f425e27a-8f4a-7687-589e-b726085c5c7a@suse.cz>
 <9527f084-4d60-2a85-f4e3-8e16cf7aad08@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <9527f084-4d60-2a85-f4e3-8e16cf7aad08@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 02:11, imran.f.khan@oracle.com wrote:
> Hi Vlastimil,
> 
> On 1/9/21 7:07 pm, Vlastimil Babka wrote:
>> On 9/1/21 07:19, Imran Khan wrote:
>>> To print a stack entries, users of stackdepot, first
>>> use stack_depot_fetch to get a list of stack entries
>>> and then use stack_trace_print to print this list.
>>> Provide a helper in stackdepot to print stack entries
>>> based on stackdepot handle.
>>>
>>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> You should convert existing users together with the patch that introduces
>> the helper. I think print_stack() in mm/kasan/report.c, and
>> __dump_page_owner() could use this.
>>
> 
> Okay. I have done this in v2 of the patch set. BTW I also see some users
> (one place in page owner, rest all in some gpu drivers) of stack_depot_fetch
> + stack_trace_snprintf. Could you please let me know if it would be okay to
> add a helper corresponding to stack_trace_snprintf as well.

Yeah looks like that would make sense too, i915 even has this as
__print_depot_stack(). Thanks.
