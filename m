Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B8C30A2C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhBAHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBAHj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:39:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B18864E22;
        Mon,  1 Feb 2021 07:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612165127;
        bh=rXTgEhvSR6W4sYPBq+m/nEqhZ92jWIC4mr9KkRrG9Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxTPxEwuiUIxxHtKQcwAEP+jEiTeI8pMcNwRrnxYMxB9EoJ7ldnUsMmow3IA0Zmon
         uuRUEL+RjSfKjmvNXtlZX9gZfugu8jP5y32Ry6ZuAtDe08aDbwV3ijvQ7lJQzynFxB
         zoLvdF52yaLYmguUHKf08WFhGPrZs5mv+SO+gT5s=
Date:   Mon, 1 Feb 2021 08:38:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mans Rullgard <mans@mansr.com>, Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: add option to disable registration of
 legacy ISA ports
Message-ID: <YBewA7FDXSjR6kIq@kroah.com>
References: <20210128172244.22859-1-mans@mansr.com>
 <CAHp75VenDC0R3uX4_=Yzii-q5Z-YWcfT2_OO0yJkYehYAHDCew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VenDC0R3uX4_=Yzii-q5Z-YWcfT2_OO0yJkYehYAHDCew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:25:33PM +0200, Andy Shevchenko wrote:
> On Thursday, January 28, 2021, Mans Rullgard <mans@mansr.com> wrote:
> 
> > On systems that do not have the traditional PC ISA serial ports, the
> > 8250 driver still creates non-functional device nodes.  This change
> > makes only ports that actually exist (PCI, DT, ...) get device nodes.
> >
> >
> 
> This is kinda ABI breakage. At least this will break x86 platforms with
> HSUARTs (all modern ones) that are used in embedded systems.
> 
> I think you would rather need an option to disable this and select it by
> the platforms where it is known not to break anything.

This option is behind CONFIG_EXPERT, if you set it, you know what you
are doing, so that's fine.

thanks,

greg k-h
