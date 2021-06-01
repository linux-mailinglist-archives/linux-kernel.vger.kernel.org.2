Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B84397C73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhFAWcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhFAWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:32:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 15:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=JfQxsQSwLRkTvVCqQ194WGxZnDo+4CsYEwA+VphB24o=; b=ozU2SH19tsz7HwfRUL5adVrx4L
        tyDmsWrq76+cKslv/RYS56QyuYDAx6OMts1HbAsxz5LNsaFXz22+poNrBmb6pIT54ewtuhBtR0x37
        GUTvPqC3yU1tddRn9Nh1EcNkCYMDJyY3vwzNdKjEaLWa4vldEB50Bw9w5bqZkxxfVROuqSC5tJ3aT
        at1/5AQ2To12uj8V38OZVZM6P1XERaqzxn1DSDn0m93Cwikji4nfHzJYFbW192hXkMB7Ax1j8mUO0
        BBbNW7rEMhUM0khhl1Y5E+tqoM3AZC4aVL34GU/frcto/mWcP+ChSgtgvkN8NNLJzTDxEOoz9GYAU
        JN051X1w==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loCuf-0012wm-O7; Tue, 01 Jun 2021 22:31:05 +0000
Subject: Re: [PATCH] Documentation/submitting-patches: Document RESEND tag on
 patches
To:     Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20201217183756.GE23634@zn.tnic> <20210413113834.GE16519@zn.tnic>
 <87pmyxsxsy.fsf@meer.lwn.net> <20210415060505.GC6318@zn.tnic>
 <YLT0MjAIO/8u4cjY@zn.tnic> <87zgw98blq.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <452a0c53-8dae-870b-fd7b-807ade28701c@infradead.org>
Date:   Tue, 1 Jun 2021 15:31:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87zgw98blq.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 3:27 PM, Jonathan Corbet wrote:
> Borislav Petkov <bp@alien8.de> writes:
> 
>> Wow, time flies. :-\
>>
>> A month and a half later, Jon, how about it?
> 
> Oops...somehow I missed the fact that there was something there for me
> to look at and respond to, sorry.
> 
> I've just read it through...  if it were me, I would find a way to
> reduce its bulk in the hope that people would actually read it; much of
> what's there is in coding-style.rst (or should be).  But it's not me,
> and if you want to keep it I won't whine (much).  Except about reverse
> fir tree, perhaps, but nobody listens to me on that...:)  I'd say
> package it up as a maintainer-guide entry and go for it.

Yes, as a maintainer-profile/guide/whatever, please,
for X86/tip.

Same for several other feedback comments on patches that
are destined for the tip tree.

thanks.
-- 
~Randy

