Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39641458C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhKVKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:48:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52488 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhKVKso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:48:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F8FF1FD26;
        Mon, 22 Nov 2021 10:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637577937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzpfsgD821LrTjZLYdBTVR+TwWqFF7kj4zqgUkZFaOY=;
        b=kPa6b1FMXFNVDaJNZJhDSTX0o96rPB7R3uMCbqKdz/S+5lp5Bp0kK5vMSbo7uf7sWLaKf8
        /Vi/60qh14ti9h+uqJy8WQiI0Ty43s5HiW5FwfkPq5DhhOKO7NA5zmRfpRdE3EpbtrN23+
        DcojimCcdGjvoELjzYcx9mup9s9IrLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637577937;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzpfsgD821LrTjZLYdBTVR+TwWqFF7kj4zqgUkZFaOY=;
        b=/lMmYOqMRhn2FLPjathCRD7Xc05m1NS++UnGAmSQToDg/MH5+ltYJWTRue4aaauZ7jY5sd
        wyR0LC7JtAI4Z8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C92DB13C56;
        Mon, 22 Nov 2021 10:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z39SMNB0m2EyfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 22 Nov 2021 10:45:36 +0000
Message-ID: <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
Date:   Mon, 22 Nov 2021 11:45:36 +0100
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
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] slob: add size header to all allocations
In-Reply-To: <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 11:36, Christoph Lameter wrote:
> On Mon, 22 Nov 2021, Vlastimil Babka wrote:
> 
>> But it seems there's no reason we couldn't do better? I.e. use the value of
>> SLOB_HDR_SIZE only to align the beginning of actual object (and name the
>> define different than SLOB_HDR_SIZE). But the size of the header, where we
>> store the object lenght could be just a native word - 4 bytes on 32bit, 8 on
>> 64bit. The address of the header shouldn't have a reason to be also aligned
>> to ARCH_KMALLOC_MINALIGN / ARCH_SLAB_MINALIGN as only SLOB itself processes
>> it and not the slab consumers which rely on those alignments?
> 
> Well the best way would be to put it at the end of the object in order to
> avoid the alignment problem. This is a particular issue with SLOB because
> it allows multiple types of objects in a single page frame.
> 
> If only one type of object would be allowed then the object size etc can
> be stored in the page struct.
> 
> So I guess placement at the beginning cannot be avoided. That in turn runs
> into trouble with the DMA requirements on some platforms where the
> beginning of the object has to be cache line aligned.

It's no problem to have the real beginning of the object aligned, and the
prepended header not. The code already does that before this patch for the
kmalloc power-of-two alignments, where e.g. the object can be aligned to 256
bytes, but the prepended header to a smaller ARCH_KMALLOC_MINALIGN /
ARCH_SLAB_MINALIGN.

> I dont know but it seems that making slob that sophisticated is counter
> productive. Remove SLOB?

I wouldn't mind, but somebody might :)


