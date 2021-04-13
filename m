Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB935DBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbhDMJ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:57:00 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:2554 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231320AbhDMJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:56:41 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AFqbHTaq7g8Ab45sZyXkxT8saV5t/L9V00zAX?=
 =?us-ascii?q?/kB9WHVpW+afkN2jm+le8BfyhioYVn1Io6H4BICrR3TA+ZlppbQAJLvKZniFhE?=
 =?us-ascii?q?KEJJxvhLGC/xTOACv7n9Q26Y5Bd7F5E8D5ClJ35PyKmDWQM9Fl+9Wf9bDtuOG2?=
 =?us-ascii?q?9RhQZCVLT40l0AtjEAacFSRNNWp7LL40DoCV6MYChxfIQxQqR/+2DHUEQOTPzu?=
 =?us-ascii?q?ej/K7OWhIICwUq7wODl1qThILSKBSA2wdbbjUn+9wf2FLYmA/07LjLiZ+G4yLc?=
 =?us-ascii?q?zGPa4tB3n9bs27J4daqxo/USQw+Ati+YIKBaf7WDuXQNu+Go81Y2gLD30nMdFv?=
 =?us-ascii?q?U2z3vQe22vyCGdvDXI4XIW8H/l0l+EkRLY0KnEeA4=3D?=
X-IronPort-AV: E=Sophos;i="5.82,219,1613430000"; 
   d="scan'208";a="502961834"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 11:56:21 +0200
Date:   Tue, 13 Apr 2021 11:56:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: cocci script hints request
In-Reply-To: <20210413090400.GA5477@agape.jhs>
Message-ID: <alpine.DEB.2.22.394.2104131154100.2872@hadrien>
References: <20210413090400.GA5477@agape.jhs>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Apr 2021, Fabio Aiuto wrote:

> Hi,
>
> I would like to improve the following coccinelle script:
>
> @@
> expression a, fmt;
> expression list var_args;
> @@
>
> -       DBG_871X_LEVEL(a, fmt, var_args);
> +       printk(fmt, var_args);
>
> I would  replace the DBG_871X_LEVEL macro with printk, but
> I can't find a way to add KERN_* constant prefix to the fmt
> argument in the + code line. If i try this
>
> @@
> expression a, fmt;
> expression list var_args;
> @@
>
> -       DBG_871X_LEVEL(a, fmt, var_args);
> +       printk(KERN_DEBUG fmt, var_args);
>
> plus: parse error:
>   File "../test.cocci", line 94, column 20, charpos = 1171
>   around = 'fmt',
>   whole content = +	printk(KERN_DEBUG fmt, var_args);
>
> how could I do this?

Although I certainly agree with Greg, I'll answer the question from a
technical point of view.

I'm not sure that that kind of compound string is supported for a
metavariable.  It is possible to get around this problem using a python
script.  If you ever need to do this for a better reason, you can take a
look at demos/pythontococci.cocci in the Coccinelle source code
distribution.

julia
