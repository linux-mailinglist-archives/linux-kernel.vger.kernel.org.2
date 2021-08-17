Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDED3EF10D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhHQRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:47:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:46930 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhHQRr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:47:29 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17HHiMVp024495;
        Tue, 17 Aug 2021 12:44:22 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17HHiKkS024494;
        Tue, 17 Aug 2021 12:44:20 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 17 Aug 2021 12:44:20 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jason Wang <wangborong@cdjrlc.com>, benh@kernel.crashing.org,
        yukuai3@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh: no need to initilise statics to 0
Message-ID: <20210817174420.GG1583@gate.crashing.org>
References: <20210817115104.30057-1-wangborong@cdjrlc.com> <2105ef52-b736-cc18-def9-02ac174d1922@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2105ef52-b736-cc18-def9-02ac174d1922@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 01:59:33PM +0200, Christophe Leroy wrote:
> 
> 
> Le 17/08/2021 à 13:51, Jason Wang a écrit :
> >Global static variables dont need to be initialised to 0. Because
> >the compiler will initilise them.
> 
> It is not the compiler, it is the Kernel. It is done here:
> 
> https://elixir.bootlin.com/linux/v5.14-rc6/source/arch/powerpc/kernel/early_32.c

This implements part of the C language: everything with static storage
duration (which includes all global objects, not just those marked
"static") is initialized.

> Among those 44 changes, only 2 are related to the commit's description.

Yeah.  Don't do that please :-/


Segher
