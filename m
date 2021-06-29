Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE53B7889
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhF2TZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhF2TZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:25:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE40C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Dmb2cO7FzDMV4E3bia4R7SHr/d7o5SoYNbqy/P9f/Go=; b=lYVAD5aSSoQFaqfNtuSDa3heon
        gNI/XvT7CL7vzDBYMFc21hpqwlThwO4HtJzFTOwEXtRewfERlMbDCyJhZlFzf9yt2Rjoh+TOan0Tc
        RH1jBqV5LC3y9+jRL8RV9nLjDu/njcEAP9oXpNQceFY3gmD66OmbR/0VFSWNmTHe4zUy392w2UjPR
        5jFq1eWFHI9x5EbSnRFsP/Ji/k7GNWTO3Qyqdg8au1VowJv+LVUmPcdEn5vXAR2ZOX57CCSQ9X9cd
        lbdWiA4GLKtW4WKJ0YNQVOOt0ABhJP9rpEJZfQrwFU2vYlmyrqDJEi7se7SrKNLmy5eS2WEvttDP1
        4fki1jJA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyJKC-00BvuN-MS; Tue, 29 Jun 2021 19:23:12 +0000
Subject: Re: 2.6.0-test3-mm1 and rootflags
To:     Greg Depoire--Ferrer <greg.depoire@gmail.com>,
        linux-kernel@vger.kernel.org
References: <200308131944.h7DJiMpS001539@turing-police.cc.vt.edu>
 <20210629172053.1709-1-greg.depoire@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bacecf9e-b47e-4a8b-0e36-1004a9711cc3@infradead.org>
Date:   Tue, 29 Jun 2021 12:23:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629172053.1709-1-greg.depoire@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/21 10:20 AM, Greg Depoire--Ferrer wrote:
> Hello.
> 
> I configure my kernel to boot without an initrd, with "rw root=PARTUUID=...
> rootflags=...". I would like the kernel to mount my root partition with
> MS_NOATIME but it is currently not possible without using an initrd that
> remounts the root partition with the new flags, as was described in this
> thread.
> 
> Because the kernel already supports setting filesystem dependent flags, I think
> it would make sense for it to also support setting filesystem independent flags.
> Also, there is the issue of flags that can't be reset later by initrd (see the
> previous messages).
> 
> In reply to this message, there is a patch that implements what was suggested,
> adding a 'rootopts=' parameter that takes a bitmap value for the mount flags.
> 
> It's my first time using a mailing list. I'm not sure if you're supposed to
> reply to very old messages like this one or create a new thread instead. Sorry
> if I did something wrong.

Hi,

It would be better to start a new email thread and include a link to
the previous discussion. E.g.:

Reference: or Link: https://lore.kernel.org/lkml/200308121855.h7CIt6St002437@turing-police.cc.vt.edu/

and also Cc: any interested parties.


thanks.
-- 
~Randy

