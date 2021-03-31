Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE9350797
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhCaTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:47:54 -0400
Received: from ms.lwn.net ([45.79.88.28]:48172 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236187AbhCaTrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:47:18 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9AAF699C;
        Wed, 31 Mar 2021 19:47:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9AAF699C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617220037; bh=QZDExYXGb3d5wWmxKQZYirEY2hdW/aKcYXit+Lg/SJ0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZcedmdEcVgXCPfz27VFMWLKvwUQGWE7wdNB/uKaz3qFOyb5pdAFe64AvnC1IW8so3
         51quilfUeff7WHuEudpbfa8khKfiAZaMImTbjsNr4bSJj88UNUKGQIGNIDXfawGqOE
         n3VPeEXgVD/mC/Ej/6Uata5xXpZmXPkOPxvrxo4UlH6jeBIo4tKoV9ncqhVQOkKG+D
         f+NfLIrx53lzo9fLs2egZCjkuAlupN4eo1lYToarItzp0KIRDEwleXVEVPr4hE5Lwp
         1Yl6UwH++IOpjYrZR4Sme66iGRySc8y3jVEEVlenE/S9fJt9HIh9TB09OtWqfUOcqm
         +BS8GTuWZ9Anw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH v1 1/4] docs: make reporting-issues.rst official and
 delete reporting-bugs.rst
In-Reply-To: <YGM68Q0+aeNgjsdy@kroah.com>
References: <cover.1617113469.git.linux@leemhuis.info>
 <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
 <YGM68Q0+aeNgjsdy@kroah.com>
Date:   Wed, 31 Mar 2021 13:47:17 -0600
Message-ID: <87h7krksvu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Mar 30, 2021 at 04:13:04PM +0200, Thorsten Leemhuis wrote:
>> Removing Documentation/admin-guide/reporting-bugs.rst will break links
>> in some of the translations. I was unsure if simply changing them to
>> Documentation/admin-guide/reporting-issue.rst was wise, so I didn't
>> touch anything for now and CCed the maintainers for the Chinese and
>> Italian translation. I couldn't find one for the Japanse translation.
>
> Traditionally translations catch up much later on, you shouldn't have to
> worry about them the authors will clean them up and submit patches for
> them when they get the chance.

Agreed.  None of the broken references actually generate warnings
(though perhaps some should) so we can let the translators catch up on
their own time.

I've applied the set and stuck in this tweak:

> FWIW, this needs a
> 
>  s!stable/>_`!stable/>`_!
> 
> Sorry, this slipped through. :-/ Ciao, Thorsten

while I was at it.

Thanks,

jon
