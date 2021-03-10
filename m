Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C043332B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhCJBTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:19:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45174 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhCJBSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:18:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 71C364D0F5B8B;
        Tue,  9 Mar 2021 17:18:53 -0800 (PST)
Date:   Tue, 09 Mar 2021 17:18:52 -0800 (PST)
Message-Id: <20210309.171852.2017579796449386350.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     glaubitz@physik.fu-berlin.de, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] SPARC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=wgvDZRBoWfynXPDOzTTyD7Ms3UzqVw_K1zzd5S2asn25g@mail.gmail.com>
References: <20210309.162454.822491855062735992.davem@davemloft.net>
        <20210309.171540.1612415953102779664.davem@davemloft.net>
        <CAHk-=wgvDZRBoWfynXPDOzTTyD7Ms3UzqVw_K1zzd5S2asn25g@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 09 Mar 2021 17:18:53 -0800 (PST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Mar 2021 17:17:24 -0800

> On Tue, Mar 9, 2021 at 5:15 PM David Miller <davem@davemloft.net> wrote:
>>
>> Somehow you pull didn't get commits:
> 
> Look closer at the pull date. That was before you had updated your branch.
> 
> I did a second pull just moments ago, I'll push it out (along with the
> networking one), after all my tests have passed.

Thank you.
