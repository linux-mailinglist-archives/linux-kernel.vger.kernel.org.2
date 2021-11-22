Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D568458DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbhKVLwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:52:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47920 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbhKVLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:52:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CC7F218E0;
        Mon, 22 Nov 2021 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637581776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObHlJX+R6cBz3I2hvhUPz/10AQi87lwvc2sZDEvI3VE=;
        b=pC9h4uErDeLn+eKrpMVExMKYRS39+xv65yzVI0iF7At5cqM0LBbBjmc3TkJG0MuTFUTrVy
        JBQWvJ9EIO85wp4lDe/f0O+z5hc1wSLKYhhzdKvGu3pO0xNMw3fWYrhLwM6cJmBAZpbVsC
        558EbchJHhDTZXob1EVLvW4bDhYKbfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637581776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObHlJX+R6cBz3I2hvhUPz/10AQi87lwvc2sZDEvI3VE=;
        b=tvZlQKUCgDN60iH/W7LwC9S8/MnG7+/Kkg2Irtpv8pgupjX06mgyYD1iIACxWqO16abNyi
        cwZ3bFJiboMpjICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC0A313B90;
        Mon, 22 Nov 2021 11:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X4IROc+Dm2HzIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 22 Nov 2021 11:49:35 +0000
Message-ID: <56c0671c-6db2-05ac-66a0-6f24101e6c5a@suse.cz>
Date:   Mon, 22 Nov 2021 12:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.org>
Cc:     Rustam Kovhaev <rkovhaev@gmail.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, corbet@lwn.net, djwong@kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
 <20211122013026.909933-1-rkovhaev@gmail.com>
 <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
 <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
 <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
 <alpine.DEB.2.22.394.2111221239050.205511@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] slob: add size header to all allocations
In-Reply-To: <alpine.DEB.2.22.394.2111221239050.205511@gentwo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 12:40, Christoph Lameter wrote:
> On Mon, 22 Nov 2021, Vlastimil Babka wrote:
> 
>> It's no problem to have the real beginning of the object aligned, and the
>> prepended header not. The code already does that before this patch for the
>> kmalloc power-of-two alignments, where e.g. the object can be aligned to 256
>> bytes, but the prepended header to a smaller ARCH_KMALLOC_MINALIGN /
>> ARCH_SLAB_MINALIGN.
> 
> Ok but then the first object in a page may still have those issues.

Hmm, that's right. I guess we should also distinguish ARCH_KMALLOC_MINALIGN
for kmalloc paths, and ARCH_SLAB_MINALIGN for kmem_cache_alloc paths. Seems
the latter is generally smaller, thus some holes left by kmalloc allocations
could be filled later by kmem_cache_alloc allocations.

> 
>> > I dont know but it seems that making slob that sophisticated is counter
>> > productive. Remove SLOB?
>>
>> I wouldn't mind, but somebody might :)
> 
> Well run a space efficiency analysis after this patch. If the memory used
> is larger than SLUB (with the configuration for minimal data footprint)
> then there is no reason for SLOB to continue.

Makes sense.
