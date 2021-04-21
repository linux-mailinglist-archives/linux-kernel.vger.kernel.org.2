Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E60366F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbhDUPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243965AbhDUPXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:23:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10DB2600D1;
        Wed, 21 Apr 2021 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619018553;
        bh=uCRYmylzXXwa0XgJ+Nt67oOm790cS23CJ6ivt68PYCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKiXkibF/agDmdT747lettzZS6BzcIS9zeBkCcI7acJPPdkTnfvXXDTuqwCJTetO0
         YwhkHieLcgJ8T75/6pa2ZcC/NL34QgNmUNf2auwdtjA6cUJdlTg2nsAdl1afv8mnEw
         /ciHEsx3N2B0bmY+jruPcscaKZo+J8oywdXQ45Po=
Date:   Wed, 21 Apr 2021 17:22:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lorenzo Colitti <lorenzo@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after
 __hrtimer_get_next_event()
Message-ID: <YIBDNoX7Fzb8B6RH@kroah.com>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com>
 <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
 <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
 <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
 <87eef5qbrx.ffs@nanos.tec.linutronix.de>
 <CAKD1Yr2qeXseNLcQ9r4niob02jGOXdVeta6OwWF3Ta1dyp1V2Q@mail.gmail.com>
 <CAKD1Yr1TOd1XKFdWK2Wr_Pw2rKciSapCM8ATEirxpCApZZzZmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKD1Yr1TOd1XKFdWK2Wr_Pw2rKciSapCM8ATEirxpCApZZzZmQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:40:54PM +0900, Lorenzo Colitti wrote:
> On Wed, Apr 21, 2021 at 11:08 PM Lorenzo Colitti <lorenzo@google.com> wrote:
> > load the timer will almost never fire since there will always be
> > another packet coming. So the speed of adding/updating the timer is
> > much more important than the accuracy. We will try to move it to
> > timer_list.
> 
> ... but actually, that's not acceptable, because AFAICS timer_list
> counts in jiffies so its resolution might be as low as 10ms. It's not
> acceptable to delay network traffic by up to 10ms under load. Not sure
> if there is another timer API that can be used here.

What do other network drivers do?  This has to be a common problem, why
is this USB driver somehow unique here?

thanks,

greg k-h
