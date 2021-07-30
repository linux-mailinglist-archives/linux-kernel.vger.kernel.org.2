Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E029D3DB50F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhG3IbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:31:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46654 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhG3IbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:31:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B77B6220E6;
        Fri, 30 Jul 2021 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627633869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWvJNNwKW7SHEOZLIyfMchxd/ms2lbGMUZPA7M96By0=;
        b=I8PAH6vsKlJcwB5P46+BHH6+d1Q3qtJPMB0MOtc1uhE2iiWUYK+Tr6Cz+PmW9HrGBYe57v
        JEn0ai8ApOWjU1Zeh512Ly95ftEKxZ3FgLcWXM4Xlhi0uYNNb8pDwdZqJKxRWKxABOQQlN
        GKFlVdPk0SqnJWtdaVCJbEuVxNWqy6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627633869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWvJNNwKW7SHEOZLIyfMchxd/ms2lbGMUZPA7M96By0=;
        b=fM19tMw1Ucn+Onfrx1cF9iF+fdPoziGV4KRDW52k3kisn1+JxwAC6j2qOOOiKKF1RL1lMK
        4Mn4mKBPXXZPcWDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 932DB1374D;
        Fri, 30 Jul 2021 08:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ivWpIs24A2EQFAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 30 Jul 2021 08:31:09 +0000
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210729014019.GA22801@xsang-OptiPlex-9020>
 <20210729114611.13ff7c1c43c883bd039dab40@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [mm/page_owner] 866b485262: invoked_oom-killer:gfp_mask=0x
Message-ID: <d0c1717f-a3e1-a9d4-44b2-2452134ad5e5@suse.cz>
Date:   Fri, 30 Jul 2021 10:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729114611.13ff7c1c43c883bd039dab40@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 8:46 PM, Andrew Morton wrote:
> On Thu, 29 Jul 2021 09:40:19 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> 
>> 
>> 
>> Greeting,
>> 
>> FYI, we noticed the following commit (built with gcc-9):
>> 
>> commit: 866b485262173a2b873386162b2ddcfbcb542b4a ("mm/page_owner: record the timestamp of all pages during free")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> I don't see how this can happen unless it's a side-effect of making
> struct page_owner 8 bytes larger.

It's possible. Seems to be a 32bit highmem kernel, allocation that fails is
GFP_USER and the page_owner (part of page_ext) has to be in lowmem, even for
highmem pages, and there's not an insignificant amount of it:

[   16.228923][    T0] allocated 178298840 bytes of page_ext

Seems to be one of the cases where contemporary kernel features are not always
suitable for 32bit kernels (especially with large memory). The highmem is 16GB.
If it was smaller, it would be actually better.

> Does setting
> /proc/sys/vm/oom_dump_tasks tell us more?
> 

