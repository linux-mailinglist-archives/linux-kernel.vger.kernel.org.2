Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC40E367B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhDVHhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhDVHhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:37:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D21B6121E;
        Thu, 22 Apr 2021 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619077034;
        bh=yy+wY+axkHWZSyba1Nnqr7o4QPWBTVEAl6w54RlnMyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSFj8pPARz3daS9UU+HpFk9DytRMSmQfFg5srHqf2szs7VsRpOeHTxsPq4RYReK7O
         etWnfao4zAhdycnAl2GxmsHcafCF7C4l1NYYVmTcwFve3PI6A0V95ebHUS7xcVCbpk
         1CMvrFkVbI1AP4oMYyJmFtdfJ9LtSTt59estsqLkBJ1/AgciM2Y5dEyHXTn6dbGAZ2
         +fIhyfTZ2CZXwwHSww6/FXL/UdP8rQf0EFxf+RZkEgE25tIsX5xmXVbD01IbsPQKZ4
         NQ7Z4mQRXzARcVnmem7bTSfW1WwZHfoK48SvVlNt4b+4475dRu/+wYTnCc2ISV0Sq2
         cNYOPwGssAEWw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZTtn-0007Su-AL; Thu, 22 Apr 2021 09:37:19 +0200
Date:   Thu, 22 Apr 2021 09:37:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: extend compile-test coverage
Message-ID: <YIEnr9g8AmYFuLPh@hovoldconsulting.com>
References: <20210421143115.22797-1-johan@kernel.org>
 <202104220355.v8nwWx2T-lkp@intel.com>
 <CAMuHMdXKWDB89Hm-LQcpfTq=0yjm_xvQsQiD4QuEtW=yVymuRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXKWDB89Hm-LQcpfTq=0yjm_xvQsQiD4QuEtW=yVymuRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:11:50AM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 22, 2021 at 3:20 AM kernel test robot <lkp@intel.com> wrote:

> > >> drivers/tty/serial/serial_txx9.c:987:12: warning: no previous prototype for function 'early_serial_txx9_setup' [-Wmissing-prototypes]
> >    int __init early_serial_txx9_setup(struct uart_port *port)
> >               ^
> >    drivers/tty/serial/serial_txx9.c:987:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    int __init early_serial_txx9_setup(struct uart_port *port)
> >    ^
> >    static
> >    1 warning generated.
> 
> This function is called from arch/mips/txx9/generic/setup.c, and does
> have a forward declaration in arch/mips/include/asm/txx9/generic.h.
> Unfortunately the latter cannot be included from the driver, unless
> the || COMPILE_TEST is dropped again.

Thanks, Geert. I was just about to send a v2 without the txx9 hunk.

Johan
