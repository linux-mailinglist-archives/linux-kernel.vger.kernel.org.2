Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA1321339
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBVJhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:37:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:38568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhBVJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:36:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613986565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GU+/aw0PIkgH54Q2zt6jA65ZSt7fVydd5NaglnVXyOw=;
        b=t0H3TF7+rYpmNyYySQukP1ra4gB6JoPmqMWwnuVvu2yXFxrWVX8PsVumfhg7TlH7LxEPEO
        1Bz6jNdqyF6qPVUngtov1TIwZ157qzS4IjVHACX7p/MXHIy5VKOr5yptz9uWTFoFGE28us
        IFnlNsk4g6gMMPf/OiVjA25GC5bFmVo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB745AD6B;
        Mon, 22 Feb 2021 09:36:04 +0000 (UTC)
Message-ID: <777991bb72f8842e3e730f9b600b2086478f5d36.camel@suse.com>
Subject: Re: usb: cdc-acm: BUG kmalloc-128 Poison overwritten
From:   Oliver Neukum <oneukum@suse.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>, linux-usb@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Bruno Thomsen <bth@kamstrup.com>,
        Lars Alex Pedersen <laa@kamstrup.com>
Date:   Mon, 22 Feb 2021 10:36:01 +0100
In-Reply-To: <CAH+2xPCkKRhXJSqMx7kzsO53JwXbrmYPLLL-_ANO9waNJREDWA@mail.gmail.com>
References: <CAH+2xPCmZNW0ct8XoBmAnd0QK53guv2e4HLn40NvWrEA7pj3qw@mail.gmail.com>
         <CAH+2xPCkKRhXJSqMx7kzsO53JwXbrmYPLLL-_ANO9waNJREDWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 18.02.2021, 16:52 +0100 schrieb Bruno Thomsen:
> Den fre. 12. feb. 2021 kl. 16.33 skrev Bruno Thomsen <bruno.thomsen@gmail.com>:
> > Hi,
> > 
> > I have been experience random kernel oops in the cdc-acm driver on
> > imx7 (arm arch). Normally it happens during the first 1-3min runtime
> > after power-on. Below oops is from 5.8.17 mainline kernel with an
> > extra patch back-ported in an attempt to fix it:
> > 38203b8385 ("usb: cdc-acm: fix cooldown mechanism")
> 
> I can now boot board with 5.11 kernel without any extra patches and
> it produce similar issue. Hopefully that make the oops more useful.
> Issue has been seen on multiple devices, so I don't think it's a bad
> hardware issue.

Hi,

is this a regression from 5.10?

	Regards
		Oliver


