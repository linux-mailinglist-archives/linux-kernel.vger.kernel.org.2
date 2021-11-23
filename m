Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C874B45AB35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbhKWSYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:24:51 -0500
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:53354 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232326AbhKWSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:24:49 -0500
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DDE48180ABA19;
        Tue, 23 Nov 2021 18:21:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 4B9A6E00036E;
        Tue, 23 Nov 2021 18:21:38 +0000 (UTC)
Message-ID: <81039009afd63eaac721201a961a4a39c3dd3990.camel@perches.com>
Subject: Re: arch/mips/mm/tlbex.c:2243:3: warning: unannotated fall-through
 between switch labels
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 23 Nov 2021 10:21:38 -0800
In-Reply-To: <20211123181648.GA9405@embeddedor>
References: <202111230719.OZDUHU4z-lkp@intel.com>
         <20211123005528.GA550759@embeddedor>
         <ea07a2f1e20503965c7c2eba7c0a7a4538457265.camel@perches.com>
         <20211123165057.GA7382@embeddedor>
         <b73d287a696c10279cd0c931840ce95b03876d58.camel@perches.com>
         <20211123175610.GA8713@embeddedor>
         <7b6e9af20d5e18315986c8e004a13c3840afb9ad.camel@perches.com>
         <20211123181648.GA9405@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.90
X-Stat-Signature: h9n6b1947nir68rjqsf8auxbc86k4dwz
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4B9A6E00036E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19nBxGqF9wcEIJgQVzU1LGHjFE+SrgIrb4=
X-HE-Tag: 1637691698-442365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 12:16 -0600, Gustavo A. R. Silva wrote:
> On Tue, Nov 23, 2021 at 09:59:58AM -0800, Joe Perches wrote:
> > On Tue, 2021-11-23 at 11:56 -0600, Gustavo A. R. Silva wrote:
> > > On Tue, Nov 23, 2021 at 09:25:17AM -0800, Joe Perches wrote:
> > > > On Tue, 2021-11-23 at 10:50 -0600, Gustavo A. R. Silva wrote:
> > > > > On Tue, Nov 23, 2021 at 12:52:30AM -0800, Joe Perches wrote:
> > > > > > 
> > > > > > Perhaps this would be better:
> > > > > 
> > > > > Feel free to send a proper patch.
> > > > 
> > > > I commented on your proposed patch.
> > > 
> > > And I reply giving you an option if you want to proceed.
> > > 
> > > > And I'd prefer you actually look at and improve the code instead
> > > > of merely silencing warnings.
> > > 
> > > If this is a matter of preference then I should express my preferences, too.
> > > So, I prefer to give you the opportunity of improving the code and not being
> > > pedantic at the same time. :)
> > 
> > It appears to be difficult to give you suggestions on how to improve
> > what you do.
> 
> No; that's appreciated.
> What I suggest you to improve is how you communicate it,

:)  Thanks.  I'll try.

> and to take into account a "Feel free to send a proper patch."

I'm not much for sending actual patches as when I do I get accusations
of being an excessively trivial patch submitter.

And I prefer to communicate in code where feasible rather than
expand all the code into words.  But if you prefer:

The indentation used for the fallthrough addition in your patch is
incorrect.

In addition, the brace location in this code is poor.
There is an unnecessary open and close brace around the default case.

Please remove the unnecessary braces and move the default case to the
more typical end-of-block location of the switch statement.

I believe the diff I posted was more efficient than the text above.

cheers, Joe


