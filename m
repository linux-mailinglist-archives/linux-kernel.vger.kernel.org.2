Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DCD33359B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhCJF6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCJF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:57:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9217BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 21:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=aCwj/zK90mEIHSHziIKlokYai4koVhnz2V1DkGYxj8U=; b=kImbn+ZpOeK8SB/fA6HdqXUdn+
        oAHpgw6j5CgaT/iI9bMQA4YK/wPB+9toNKY/mmVm2Z7hmgal4VOuxYheL9q302K17lX/ScwUkUh94
        BpJx96QkpvrrCAuXU8208qdTRAPKVs8lxuOgLZoIn2QywQl3ydGDvCy+9glqcQSnzztCagU2gwQRI
        M2XUModlHUwYpAx7dG88yCLlRxP/potPTo88ltAYMchPGrjkDc1WKN6nHt0mDEBW/fa3TAv45VB+d
        KDBLcXF6pgozBgZ+NxGd/UFpm8GyiRT+zOBcmhG1L4ISuVKKT8byFWjSa2UtThD4voPbAU2acdt3r
        HJbeSiKQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJrqx-000lO1-MS; Wed, 10 Mar 2021 05:57:52 +0000
Subject: Re: linux-next: Tree for Mar 10 (lib/test_printf.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Petr Mladek <pmladek@suse.com>
References: <20210310150217.046fef19@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <62857b03-c12c-6841-72ae-d94f00a3a868@infradead.org>
Date:   Tue, 9 Mar 2021 21:57:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210310150217.046fef19@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 8:02 PM, Stephen Rothwell wrote:
> Hi all,
> 

on i386 (at least):

../lib/test_printf.c: In function 'page_flags_test':
../lib/test_printf.c:595:17: error: 'sec' undeclared (first use in this function); did you mean 'sem'?
  page_flags |= (sec & SECTIONS_MASK) << SECTIONS_PGSHIFT;
                 ^~~


Should that be 'section'?


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
