Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67845AA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbhKWR23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:28:29 -0500
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:59004 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234416AbhKWR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:28:28 -0500
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0F0D618225E09;
        Tue, 23 Nov 2021 17:25:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 6D904E000354;
        Tue, 23 Nov 2021 17:25:17 +0000 (UTC)
Message-ID: <b73d287a696c10279cd0c931840ce95b03876d58.camel@perches.com>
Subject: Re: arch/mips/mm/tlbex.c:2243:3: warning: unannotated fall-through
 between switch labels
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 23 Nov 2021 09:25:17 -0800
In-Reply-To: <20211123165057.GA7382@embeddedor>
References: <202111230719.OZDUHU4z-lkp@intel.com>
         <20211123005528.GA550759@embeddedor>
         <ea07a2f1e20503965c7c2eba7c0a7a4538457265.camel@perches.com>
         <20211123165057.GA7382@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: b7d1gcsizzptxunoomxpxxup7dmzqm44
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6D904E000354
X-Spam-Status: No, score=-2.18
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+jMFOfgZkymPvJY5ZOxOiWXjv9rAWCmrQ=
X-HE-Tag: 1637688317-268891
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 10:50 -0600, Gustavo A. R. Silva wrote:
> On Tue, Nov 23, 2021 at 12:52:30AM -0800, Joe Perches wrote:
> > 
> > Perhaps this would be better:
> 
> Feel free to send a proper patch.

I commented on your proposed patch.

And I'd prefer you actually look at and improve the code instead
of merely silencing warnings.

