Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622E43B665B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhF1QGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhF1QGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:06:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A750AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=d0oLH0yMmNocoX6aVWixqwCRit5ll2P90SYDRMW8gZA=; b=qaNuiySb9526gAc1xGBm1CJzzk
        R3Mwk+kGTZ34YiZSeHkbavkdbDaWIR0eAZIa1A0Aa2NkW2HIj9/2+5bwJxrp6x2tLvS41YkmhbYc+
        kEK9RblyHBBxWInzAU/qUKJ5zKw/68uFPw4HHi3OqsBvo1v24eWo8+dDw4DRn66WGNUWgc2DTaWmq
        Bx3wTWtL4CSVJswbbKjTEw+pBfg9E5I9lSE+9uKPXFIb2twaIFdhw0KTgzr8zuPJ+Ng/p4Sli8CEy
        z6vtoa1kbPjgEcrZCQ9Ws17wP/0/z2MZplf7TiTMEDjYbM6qC7hRVTR6SkemC4GaD69IFmgt5vX5u
        lhef6ddw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxtjK-008XUh-Eq; Mon, 28 Jun 2021 16:03:26 +0000
Subject: Re: [PATCH] ASoC: atmel: ATMEL drivers depend on HAS_DMA
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Bo Shen <voice.shen@atmel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20210530204851.3372-1-rdunlap@infradead.org>
 <9ba0da3b-dbdb-c91d-2def-f3dcd30cbde3@infradead.org>
 <20210628130214.GB4492@sirena.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6734cd67-ae14-74f4-a78e-b6a810c1cdec@infradead.org>
Date:   Mon, 28 Jun 2021 09:03:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628130214.GB4492@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 6:02 AM, Mark Brown wrote:
> On Sun, Jun 27, 2021 at 03:28:59PM -0700, Randy Dunlap wrote:
>> [adding LKML]
>>
>> ping?
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so 
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.

a. The entire email/patch was there. Should I put the ping _after_ the patch?
Would that help?

b. What do you consider a reasonable time?  The patch was sent 28 days
prior to this gentle ping.

> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
> 

Yes, I shall resend the patch. Thanks.

-- 
~Randy

