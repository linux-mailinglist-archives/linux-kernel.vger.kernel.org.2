Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB13E582E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbhHJKVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239800AbhHJKVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:21:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C1D661051;
        Tue, 10 Aug 2021 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628590869;
        bh=/neDvGFqen0Ho9gJnce0tGXE6fYsBJbEyvmkPBb11rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LH1HTTRrWKFtEiDynQfyzk0k9Kkadnst9PXEEUDBpDdwp5uG2AWlnEu3XhrnHIsoH
         1hDg9yf0mx2+6TCr5eVrKEww38/TvqsadXZ+Z97RPWIP0YHK1TVkmwPXEJPZbM7hps
         HygMUeCHfjmvjw+/eKFiv1uZIjyyeCO8g9q0JDO4=
Date:   Tue, 10 Aug 2021 12:21:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Replace BITn with BIT(n)
Message-ID: <YRJTEp7jpZ+Tg7OB@kroah.com>
References: <20210809182006.29452-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210809182006.29452-1-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 01:20:06PM -0500, Larry Finger wrote:
> The driver uses BITn instead of BIT(n). All such usage is converted.
> 
> Note that this patch does not address any warnings that checkpatch
> will note. These include missing space around operators and lines
> that are too long. These problems will be addressed in a separate
> patch.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---

Breaks the build:

n file included from drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:4:
drivers/staging/r8188eu/hal/../include/Hal8188EPwrSeq.h:45:105: error: ‘BIT1’ undeclared here (not in a function); did you mean ‘BIT’?
   45 |         {0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT1, BIT1},/* wait till 0x04[17] = 1    power ready*/  \
      |                                                                                                         ^~~~
drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:12:9: note: in expansion of macro ‘RTL8188E_TRANS_CARDEMU_TO_ACT’
   12 |         RTL8188E_TRANS_CARDEMU_TO_ACT
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:4:
drivers/staging/r8188eu/hal/../include/Hal8188EPwrSeq.h:46:103: error: ‘BIT0’ undeclared here (not in a function); did you mean ‘BIT’?
   46 |         {0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0|BIT1, 0}, /* 0x02[1:0] = 0   reset BB*/                      \
      |                                                                                                       ^~~~
drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:12:9: note: in expansion of macro ‘RTL8188E_TRANS_CARDEMU_TO_ACT’
   12 |         RTL8188E_TRANS_CARDEMU_TO_ACT
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/r8188eu/hal/../include/Hal8188EPwrSeq.h:47:103: error: ‘BIT7’ undeclared here (not in a function); did you mean ‘BIT’?
   47 |         {0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, BIT7}, /*0x24[23] = 2b'01 schmit trigger */ \
      |                                                                                                       ^~~~
drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:12:9: note: in expansion of macro ‘RTL8188E_TRANS_CARDEMU_TO_ACT’
   12 |         RTL8188E_TRANS_CARDEMU_TO_ACT
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/r8188eu/hal/../include/Hal8188EPwrSeq.h:49:103: error: ‘BIT4’ undeclared here (not in a function); did you mean ‘BIT’?
   49 |         {0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4|BIT3, 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/ \
      |                                                                                                       ^~~~
drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:12:9: note: in expansion of macro ‘RTL8188E_TRANS_CARDEMU_TO_ACT’
   12 |         RTL8188E_TRANS_CARDEMU_TO_ACT
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/r8188eu/hal/../include/Hal8188EPwrSeq.h:49:108: error: ‘BIT3’ undeclared here (not in a function); did you mean ‘BIT’?
   49 |         {0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4|BIT3, 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/ \
      |                                                                                                            ^~~~
drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:12:9: note: in expansion of macro ‘RTL8188E_TRANS_CARDEMU_TO_ACT’
   12 |         RTL8188E_TRANS_CARDEMU_TO_ACT
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/r8188eu/hal/../include/Hal8188EPwrSeq.h:123:103: error: ‘BIT5’ undeclared here (not in a function); did you mean ‘BIT’?
  123 |         {0x0553, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT5, BIT5},/*Respond TxOK to scheduler*/ \
      |                                                                                                       ^~~~
drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:60:9: note: in expansion of macro ‘RTL8188E_TRANS_ACT_TO_LPS’
   60 |         RTL8188E_TRANS_ACT_TO_LPS
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/r8188eu/hal/../include/Hal8188EPwrSeq.h:134:103: error: ‘BIT6’ undeclared here (not in a function); did you mean ‘BIT’?
  134 |         {0x0029, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT6|BIT7, 0}, /*.        0x29[7:6] = 2b'00        enable BB clock*/\
      |                                                                                                       ^~~~
drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c:67:9: note: in expansion of macro ‘RTL8188E_TRANS_LPS_TO_ACT’
   67 |         RTL8188E_TRANS_LPS_TO_ACT
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~


:(


