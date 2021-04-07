Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEF13578A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDGXqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDGXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 19:46:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B648C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 16:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=pVaGWW2BhrXbQF8x/5PEjIGC6Z4HeDSsSzJUgk7h8bQ=; b=BN/3C4BLLyd0jvWDsQENxwlejl
        Hpu5fLWgYAj4nZZ8pVIsXmEK8th5wN9fgf8CHQr++md+wHlEuGfZ7m7GvyYOWnlbryzscNof1M6hN
        mKvFswC6/pDw21FhgfH7C1PXwOe+arPFr92fWQC9dQiz0ArjVwKnVYDa6N2JS+98mH8KBvxcqwuyv
        FyHKfUL9k67JaSKJrnwcgUcK9KWAFS/88MMTuqYfH4py3TyoYtb4UfkC5SmNG1AGKHw2ge2UuvRMH
        i7upUZya6CEo9bm4Y8EnJp8m7GXUNOXp7RH1GtrkzUSBIkTUaHVPXF24sMUpsQaPznjEyDHSVzYZ+
        7e9uqbyg==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUHrs-006JlB-Ik; Wed, 07 Apr 2021 23:45:52 +0000
Subject: Re: undefined reference to `cmpxchg8b_emu'
To:     kernel test robot <lkp@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maciej Patelczyk <maciej.patelczyk@intel.com>
References: <202104080722.L7ErkTLc-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43259c3d-fbc3-2820-02c1-171d2ae32321@infradead.org>
Date:   Wed, 7 Apr 2021 16:45:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202104080722.L7ErkTLc-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 4:34 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   454859c552da78b0f587205d308401922b56863e
> commit: 1c530d431c698f156538b8954b07df95337beb34 dma-buf: Use atomic_fetch_add() for the context id
> date:   11 months ago
> config: um-randconfig-r034-20210407 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1c530d431c698f156538b8954b07df95337beb34
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 1c530d431c698f156538b8954b07df95337beb34
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 

Hi robot,

Can you test a patch?
https://lore.kernel.org/lkml/20210404182044.9918-1-rdunlap@infradead.org/


thanks.

-- 
~Randy

