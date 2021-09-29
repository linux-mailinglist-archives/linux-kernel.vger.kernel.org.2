Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063A241BF18
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 08:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbhI2G0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 02:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243959AbhI2G0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 02:26:21 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6BC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 23:24:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id E067570C2; Wed, 29 Sep 2021 08:24:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1632896674;
        bh=87UG4M6PKxJVgFZNnssRSPeCI+Kk7GJBUEncdt5VozQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFFj8bZTJpdNPr+KV1fmxaFn7eD3ClGTU0VybVvo2qrbe2A9FxhpHNEzp0cohyjlE
         +1vVCDdumjr41UCEn4+BZfdf8joicdulOB6bc667joF8DQ+Hm4mKRyODDLP544rOCw
         HwR7EAbM7oxTL58OTjrT6f7olijxYysNynDGrbuZYGKWlfzqGCGzX7kQ2vqes3iBFA
         I7R2b1LToYCwzLBsBzqhss8tj0V7jK8pH2AEAw0jS8T2dqnyovFOiVgVhL1CFm3iHl
         WDYXs9tk67m6QlmrZRKm3q4Xhf1SRyswHyiNafwng2HOJ2el037+7Iarjbl95hs5qf
         VFM60ZcbLs1AneLaJ/PYK7EIrkuOjH5T4xByhe0XgjosRtxgGk6ito4217mKOk9yG6
         lHiWqenssePpIKGtrXapzt2gK7sQY6cOn/XMR2rIJS77WhQU52c5mkGtIN42skFGLm
         p51AGFTRGc7DnTRO6005OT398COP2LSZsTtobEfZkwA1Q27uWMuqF1WIr8mvotQEkF
         VNwUr5BuDxRvdO9e2Sysif8/8CxWON/cFbtNmuouPcNAIICjvEqBEU3EwuU9f5zCmb
         /TqXtK2Ks/ZFtcqk9aEhAEICbVr4iqglUx8HM9GdrCu+i9BuKE/uXzJ0wbnYVaCES9
         s+L0oxM4572o3G5TD7qjFi0Y=
Date:   Wed, 29 Sep 2021 08:24:34 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ocfs2: mount fails with buffer overflow in strlen
Message-ID: <20210929062434.GN28341@valentin-vidic.from.hr>
References: <20210927154459.15976-1-vvidic@valentin-vidic.from.hr>
 <00850aed-2027-a0ab-e801-c6498a5a49f8@linux.alibaba.com>
 <20210928131450.GM28341@valentin-vidic.from.hr>
 <212f878e-1bbe-347c-ba43-e4ffb9b4afbe@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <212f878e-1bbe-347c-ba43-e4ffb9b4afbe@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:38:59AM +0800, Joseph Qi wrote:
> Okay, you are right, strlen(src) is indeed wrong here.
> 
> But please note that in strlcpy():
> size_t ret = strlen(src);
> if (size) {
> 	size_t len = (ret >= size) ? size - 1 : ret;
> 	memcpy(dest, src, len);
> 	dest[len] = '\0';
> }
> 
> Take ci_stack "o2cb" for example, strlen("o2cb") may return wrong if the
> coming byte is not null, say it is 10.
> The input size is 5, so len will finally be 4.
> So dest is still correct ending with null byte. No overflow happens.
> So the problem here is the wrong return value, but it is discarded in
> ocfs2_initialize_super().

strlcpy starts with a call to strlen(src) and this is where the read overflow
happens. If the kernel is compiled with CONFIG_FORTIFY_SOURCE this gets
executed instead (include/linux/fortify-string.h):

__FORTIFY_INLINE __kernel_size_t strlen(const char *p)
{
        __kernel_size_t ret;
        size_t p_size = __builtin_object_size(p, 1);

        /* Work around gcc excess stack consumption issue */
        if (p_size == (size_t)-1 ||
                (__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
                return __underlying_strlen(p);
        ret = strnlen(p, p_size);
        if (p_size <= ret)
                fortify_panic(__func__);
        return ret;
}

So while strlcpy did work before this fortify check, it is probably not the
best option anymore due to the missing null terminator in the source.

-- 
Valentin
