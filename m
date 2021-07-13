Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2563C7880
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhGMVIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 17:08:22 -0400
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:50440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231499AbhGMVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 17:08:21 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 01CA418291090;
        Tue, 13 Jul 2021 21:05:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 0F8BF2EBF91;
        Tue, 13 Jul 2021 21:05:28 +0000 (UTC)
Message-ID: <8c2868969894ae5710147d3660e8442017438932.camel@perches.com>
Subject: Re: [PATCH v1 4/4] serial: 8250_pci: Replace dev_*() by pci_*()
 macros
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Date:   Tue, 13 Jul 2021 14:05:27 -0700
In-Reply-To: <20210713104026.58560-4-andriy.shevchenko@linux.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
         <20210713104026.58560-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F8BF2EBF91
X-Spam-Status: No, score=-1.25
X-Stat-Signature: fmdbu5uiam1jn1ntpfbc1itwfmnuz83w
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19wslUDz56ixfJZwEwSdX46P7sgAziArf0=
X-HE-Tag: 1626210328-779052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-13 at 13:40 +0300, Andy Shevchenko wrote:
> PCI subsystem provides convenient shortcut macros for message printing.
> Use those macros instead of dev_*().
[]
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
[]
> @@ -4147,8 +4139,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
>  		       sizeof(struct pciserial_board));
>  		rc = serial_pci_guess_board(dev, &tmp);
>  		if (rc == 0 && serial_pci_matches(board, &tmp))
> -			moan_device("Redundant entry in serial pci_table.",
> -				    dev);
> +			moan_device("Redundant entry in serial pci_table.", dev);

Unassociated change.

