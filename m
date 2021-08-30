Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824413FB9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhH3QGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:06:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbhH3QGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:06:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 515932216A;
        Mon, 30 Aug 2021 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630339559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tu3Srlltk1gV5LbtaloNcu/X6jYrN+dgxGU84IwMz4c=;
        b=GcSn84ueH7DhSedmu/bpQNLBeXS8cpP708lcjMgHPysKF3NXqElrwIwTNYq0khdQ/zppdf
        oaQeaSLpTD6xYa7zMRF6WiNS8vWFL6Ra0+2rwotd50HnOEQA+44xWVX1ZXIXMeIXnZLbbf
        eraaWUMTMaxyi4n53gDdsyc2n5pFqdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630339559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tu3Srlltk1gV5LbtaloNcu/X6jYrN+dgxGU84IwMz4c=;
        b=R+HiVBAoG6mHGxpUhn0rvdNpoCiJfaDoNhy8sJC4EaHIDbo9Y+zgbYRhi4f3uF1HYiXFnF
        NomOcawYrO+wbwCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 336B0139BB;
        Mon, 30 Aug 2021 16:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cFJYC+cBLWFGHwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Mon, 30 Aug 2021 16:05:59 +0000
Message-ID: <14465cfe-281a-0f67-dc17-ead34ec48365@suse.cz>
Date:   Mon, 30 Aug 2021 18:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Mikko Rantalainen <mikko.rantalainen@peda.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
 <0d11f620-0562-e150-259d-85de8d10cd7a@infradead.org>
 <YSzuLbHr7fHshafX@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Why is Shmem included in Cached in /proc/meminfo?
In-Reply-To: <YSzuLbHr7fHshafX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 16:41, Matthew Wilcox wrote:
> On Mon, Aug 30, 2021 at 07:34:38AM -0700, Randy Dunlap wrote:
>> [add linux-mm mailing list]
>> 
>> On 8/30/21 12:44 AM, Mikko Rantalainen wrote:
>> > It's not immediately obvious from fs/proc/meminfo.c function
>> > meminfo_proc_show() but the output of Cached: field seems to always
>> > include all of Shmem: field, too.
>> > 
>> > Is this intentional? Usually cache is something that can be discarded if
>> > needed but shared memory (e.g. used to contain files in tmpfs) cannot be
>> > discarded without a data-loss. As such, I'd argue that it shouldn't be
>> > included in the Cached: output.
> 
> That's a reasonable position to take.
> 
> Another point of view is that everything in tmpfs is part of the page
> cache and can be written out to swap, so keeping it as part of Cached
> is not misleading.

Yeah, but with that view, anonymous memory can be also written out to swap. But
it's non-intuitive that something called "Cached" will contain something that
(if not dirty) can't be just dropped. I've had to point this Shmem oddity out a
number of times to someone, so I would say that it would be much better if it
was not part of Cached.

However, if we change it now, we might create even larger confusion. People
looking at the output for the first time (and IIRC also the 'free' command uses
it) on a new kernel wouldn't be misled anymore. But people working with both old
and new kernels will now have to take in account that it changed at some
point... not good.

> I can see it both ways, and personally, I'd lean towards clarifying
> the documentation about how shmem is accounted rather than changing
> how the memory usage is reported.
> 

