Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105E5420A33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhJDLlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:41:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhJDLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:41:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 888F4222EF;
        Mon,  4 Oct 2021 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633347586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nT/jLfbNhArcPOADaW8wlcm8on7ZVbyGnGG2HoqjWGs=;
        b=NxCm1A1BFyPVegRtNI1alewKpJJ93UlMPsXG2s1Y55+FsrrUc0z3At7XULFaLblu2QDBe4
        Lc3+z0Nyuk2kXWdUTtlo3yHHlV+2gPlNcyV7e4kE3DNhjY+j2Nz6eNlg7EqOJzAEFmBlS0
        hY4V/gg43d3R/9bQc1oad3MIcViQsjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633347586;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nT/jLfbNhArcPOADaW8wlcm8on7ZVbyGnGG2HoqjWGs=;
        b=ku7g04Hn//qUxif9ptrSCqNlDhQnftU/FVmX/OEzkXi51CghUtYI3oZPysk7CGpLKAREUE
        B3vRE0HcbofNcuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B07E51348D;
        Mon,  4 Oct 2021 11:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id crpgKujnWmFaBwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Oct 2021 11:39:20 +0000
Message-ID: <075fde61-8c28-25ec-0ec1-28b1bdea7c95@suse.cz>
Date:   Mon, 4 Oct 2021 13:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
 <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <377a622-9a5e-37dc-8f8d-42ae124042b6@google.com>
 <20211004060109.GA2949@linux.asia-northeast3-a.c.our-ratio-313919.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211004060109.GA2949@linux.asia-northeast3-a.c.our-ratio-313919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 08:01, Hyeonggon Yoo wrote:
> On Sun, Oct 03, 2021 at 06:25:29PM -0700, David Rientjes wrote:
>> I would disagree that SLAB isn't currently maintained, I think it's 
>> actively maintained.
> 
> I thought it was not actively maintained because most of patches were
> fixups and cleanups for years and as Vlastimil said, new features are

Fixups and cleanups still count as "actively maintained". The opposite
case would be "nobody uses it because it was broken for years since
commit X and we only noticed now".

> only added to SLUB. development was focused on SLUB.
> 
>> I think the general guidance is that changes for both allocators can still
>> be merged upstream if they show a significant win (improved performnace, 
>> maintaining performance while reducing memory footprint, code hygiene, 
>> etc) and there's no specific policy that we cannot make changes to 
>> mm/slab.c.
> 
> Good.
> 
> I see things to improve in SLAB and want to improve it.
> I will appreciate if you review them.

It would be great if your motivation started with "I prefer SLAB over
SLUB because X and Y but I need to improve Z", not just a theoretical
concern.

> Thanks,
> Hyeonggon
> 

