Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADE33A7185
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhFNVsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:48:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:50376 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhFNVsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:48:50 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CC9AA381;
        Mon, 14 Jun 2021 21:46:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CC9AA381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623707203; bh=ldPOqjHzhnsktVtP4/ba9F7uS9uAV5PBCsgLZBgy1lY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qsYnjWzAjGMmuWMTgNqxhDjpvGkjpTX6mwG0zG1KIsj+kozoEbyyUCtWkf70Q4VTH
         d6RjM5gv2XiBhZMsry6HSAnpRChs9rmmMWfmvOqwtrN9JwkgPHtowWmA8L6yvhe8IP
         tylSxyTkiJ2nGyAMcdmCHOi0wW+8BqrkM3w9FU88uRwwayXeRGAgUt78wCZVDP5MWG
         t+DTV7NJBaJZfzOKQv/zJgPMpXKWqi3xjjL+1SAntw+snYNRU5Cw3p8oBn+C1+e1sh
         /xxHZUnXBgmjkAnkr4GwtC8Tkd/KweEa10h48LzNO07uga7fRO/BIPLbeJ3HLzNEf6
         wuXxx90BSn0Fg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        samuel.thibault@ens-lyon.org, jani.nikula@linux.intel.com,
        gene@collinsnet.net, w.d.hubbs@gmail.com, steve.holmes88@gmail.com
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        chris@the-brannons.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] docs: Convert the Speakup guide to rst
In-Reply-To: <20210607132914.20480-1-igormtorrente@gmail.com>
References: <20210607132914.20480-1-igormtorrente@gmail.com>
Date:   Mon, 14 Jun 2021 15:46:43 -0600
Message-ID: <87r1h415mk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Matheus Andrade Torrente <igormtorrente@gmail.com> writes:

> v4: Reverts the licensing change to a dual-licensing
>     'GPL-2.0 OR GFDL-1.2-no-invariants-or-later'.
>
>     And, therefore, this patch should only be accepted when we have
>     all acks from the copyright owners.

What's the status of that?  I'd like to get this work merged for 5.14 if
possible...

Thanks,

jon
