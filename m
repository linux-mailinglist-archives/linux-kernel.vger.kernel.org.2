Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B55369509
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhDWOs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:48:28 -0400
Received: from mail.javad.com ([54.86.164.124]:45868 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDWOs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:48:26 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 10:48:26 EDT
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 905303E95C;
        Fri, 23 Apr 2021 14:40:20 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1lZwyh-0004QE-7K; Fri, 23 Apr 2021 17:40:19 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Walter Harms <wharms@bfs.de>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Dan Carpenter' <dan.carpenter@oracle.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        "John Wang" <wangzhiqiang.bj@bytedance.com>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Patrick Venture <venture@google.com>,
        "Benjamin Fair" <benjaminfair@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Lippert <rlippert@google.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: AW: [PATCH] soc: aspeed: fix a ternary sign expansion bug
References: <YIE90PSXsMTa2Y8n@mwanda>
        <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
        <877dktuvmz.fsf@osv.gnss.ru>
        <265e2d3accc74c89b5bab22eadb43808@AcuMS.aculab.com>
        <ebe4a1a6dd0748e28e6ca19aec20223e@bfs.de>
Date:   Fri, 23 Apr 2021 17:40:19 +0300
In-Reply-To: <ebe4a1a6dd0748e28e6ca19aec20223e@bfs.de> (Walter Harms's message
        of "Fri, 23 Apr 2021 11:03:30 +0000")
Message-ID: <878s59rrn0.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Walter Harms <wharms@bfs.de> writes:

> as indepentent observer,
> i would go for Dans solution:
>
> ret = kfifo_to_user();
> /* if an error occurs just return */
> if (ret)
>    return ret;
>
> /* otherwise return the copied number of bytes */
>
> return copied;
>
> there is no need for any deeper language knowledge,

Yep, but this is not idiomatic C, so one looking at this code would
tend to convert it back to ternary, and the actual problem here is that
the type of 'copied' does not match the return type of the function.

-- Sergey Organov
