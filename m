Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4982745AAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbhKWSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:03:10 -0500
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:36764 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233945AbhKWSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:03:09 -0500
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EDEAD18473E35;
        Tue, 23 Nov 2021 18:00:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 68803200051E;
        Tue, 23 Nov 2021 17:59:58 +0000 (UTC)
Message-ID: <7b6e9af20d5e18315986c8e004a13c3840afb9ad.camel@perches.com>
Subject: Re: arch/mips/mm/tlbex.c:2243:3: warning: unannotated fall-through
 between switch labels
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 23 Nov 2021 09:59:58 -0800
In-Reply-To: <20211123175610.GA8713@embeddedor>
References: <202111230719.OZDUHU4z-lkp@intel.com>
         <20211123005528.GA550759@embeddedor>
         <ea07a2f1e20503965c7c2eba7c0a7a4538457265.camel@perches.com>
         <20211123165057.GA7382@embeddedor>
         <b73d287a696c10279cd0c931840ce95b03876d58.camel@perches.com>
         <20211123175610.GA8713@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.87
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 68803200051E
X-Stat-Signature: 5abhep5mpfpktxggxmmiw73fyko5caxd
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/3DYbCkrweiDXwhQT+VPuLXXf9uS+UqMU=
X-HE-Tag: 1637690398-387024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 11:56 -0600, Gustavo A. R. Silva wrote:
> On Tue, Nov 23, 2021 at 09:25:17AM -0800, Joe Perches wrote:
> > On Tue, 2021-11-23 at 10:50 -0600, Gustavo A. R. Silva wrote:
> > > On Tue, Nov 23, 2021 at 12:52:30AM -0800, Joe Perches wrote:
> > > > 
> > > > Perhaps this would be better:
> > > 
> > > Feel free to send a proper patch.
> > 
> > I commented on your proposed patch.
> 
> And I reply giving you an option if you want to proceed.
> 
> > And I'd prefer you actually look at and improve the code instead
> > of merely silencing warnings.
> 
> If this is a matter of preference then I should express my preferences, too.
> So, I prefer to give you the opportunity of improving the code and not being
> pedantic at the same time. :)

It appears to be difficult to give you suggestions on how to improve
what you do.

cheers, Joe

