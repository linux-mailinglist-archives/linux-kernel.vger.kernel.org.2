Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534EE41E5B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 03:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351062AbhJAB3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 21:29:03 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:54040 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230214AbhJAB3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 21:29:02 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5201D182CED2A;
        Fri,  1 Oct 2021 01:27:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 8BDF120D756;
        Fri,  1 Oct 2021 01:27:17 +0000 (UTC)
Message-ID: <6573ccd25ce80f5e28ed35e4c88c898b0f994fbc.camel@perches.com>
Subject: Re: [PATCH] memblock: Neaten logging
From:   Joe Perches <joe@perches.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Sep 2021 18:27:15 -0700
In-Reply-To: <YVYoVNFBMER4bjrT@kernel.org>
References: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
         <YVYoVNFBMER4bjrT@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.58
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8BDF120D756
X-Stat-Signature: jkb8zfcuprgstbsfrayctatfj3c3q7un
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/pOhNom2PREIjURhP051NROEzMBgf1kA4=
X-HE-Tag: 1633051637-829100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-30 at 14:12 -0700, Mike Rapoport wrote:
> Hi Joe,
> 
> On Wed, Sep 29, 2021 at 09:43:14PM -0700, Joe Perches wrote:
> > Use more typical kernel logging styles.
> > 
> > o Add and use #define pr_fmt KBUILD_MODNAME ": " fmt
> 
> I don't see it as an improvement. On the contrary, the output becomes
> somewhat tautological:

And rather easier to grep as the prefix is constant.

> What is the base commit for this patch?
> It seems it missed a pr_warn in memblock_cap_memory_range()...

linus' master.

