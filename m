Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9FE41F659
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355395AbhJAUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:35:59 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:47048 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230064AbhJAUf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:35:58 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C58982CFEA;
        Fri,  1 Oct 2021 20:34:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 12B6820D758;
        Fri,  1 Oct 2021 20:34:11 +0000 (UTC)
Message-ID: <06ede4d0c1bf66614c9e9e013098a876aeec883f.camel@perches.com>
Subject: Re: [PATCH] memblock: Neaten logging
From:   Joe Perches <joe@perches.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 01 Oct 2021 13:34:10 -0700
In-Reply-To: <YVc5RYT+MovmWiiI@kernel.org>
References: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
         <YVYoVNFBMER4bjrT@kernel.org>
         <6573ccd25ce80f5e28ed35e4c88c898b0f994fbc.camel@perches.com>
         <YVc5RYT+MovmWiiI@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 12B6820D758
X-Stat-Signature: unjsd57mp1rm98jc7mmrfhznwpf796ms
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+PpeNY0Rej3iQW6D3iqR/Yz8Bp9gwCecI=
X-HE-Tag: 1633120451-177420
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-01 at 09:37 -0700, Mike Rapoport wrote:
> On Thu, Sep 30, 2021 at 06:27:15PM -0700, Joe Perches wrote:
> > On Thu, 2021-09-30 at 14:12 -0700, Mike Rapoport wrote:
> > > Hi Joe,
> > > 
> > > On Wed, Sep 29, 2021 at 09:43:14PM -0700, Joe Perches wrote:
> > > > Use more typical kernel logging styles.
> > > > 
> > > > o Add and use #define pr_fmt KBUILD_MODNAME ": " fmt
> > > 
> > > I don't see it as an improvement. On the contrary, the output becomes
> > > somewhat tautological:
> > 
> > And rather easier to grep as the prefix is constant.
> 
> memblock_ is perfectly greppable

Of course, but only when it's there, 2 instances out of 9.

$ git grep '\bpr_' mm/memblock.c
mm/memblock.c:                  pr_info(fmt, ##__VA_ARGS__);                    \
mm/memblock.c:          pr_warn("Could not allocate %pap bytes of mirrored memory\n",
mm/memblock.c:          pr_err("memblock: Failed to double %s array from %ld to %ld entries !\n",
mm/memblock.c:          pr_warn("Could not allocate %pap bytes of mirrored memory\n",
mm/memblock.c:          pr_warn("%s: No memory registered yet\n", __func__);
mm/memblock.c:  pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
mm/memblock.c:          pr_info(" %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %#x\n",
mm/memblock.c:  pr_info("MEMBLOCK configuration:\n");
mm/memblock.c:  pr_info(" memory size = %pa reserved size = %pa\n",

cheers, Joe

