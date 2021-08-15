Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5457D3EC659
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhHOAr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:47:57 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:44450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229453AbhHOAry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:47:54 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3CD741A4D7;
        Sun, 15 Aug 2021 00:47:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 3E1512550F6;
        Sun, 15 Aug 2021 00:47:23 +0000 (UTC)
Message-ID: <24b9996f43b0cb012022e8dacc6ab2902f7df981.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix an issue regarding the git commit
 description style test
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 14 Aug 2021 17:47:20 -0700
In-Reply-To: <CAKXUXMy2hutuTP1Z3+wt3AxKuSx1G=vEQb8V4cPeaaba+jBPfA@mail.gmail.com>
References: <20210714082608.28918-1-someguy@effective-light.com>
         <CAKXUXMy2hutuTP1Z3+wt3AxKuSx1G=vEQb8V4cPeaaba+jBPfA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hg5ah11uw11epnat7cb78q49qmxgt3te
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3E1512550F6
X-Spam-Status: No, score=-0.94
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19y4QaeyBAkRLoaDFg5bnTxGJV4gKEfoyo=
X-HE-Tag: 1628988443-155006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-08-14 at 10:43 +0200, Lukas Bulwahn wrote:
> On Wed, Jul 14, 2021 at 10:26 AM Hamza Mahfooz
> <someguy@effective-light.com> wrote:
> > 
> > If we consider the output of the following command:
> > 
> > $ git shortlog | grep '"' | wc -l
> > 14185
> > 
> > It becomes apparent that quite a number of commits have titles that,
> > contain at least one quotation mark and if you attempt to refer to those
> > commits in a new patch, checkpatch throws a false positive. This is
> > because, checkpatch disallows the use of quotation marks in commit titles,
> > only when referring to those commits in commit descriptions.
> > 
> 
> Joe will certainly have the final say on this.

I did suggest a patch.

https://lore.kernel.org/lkml/7f55d9d0369f1ea840fab83eeb77f9f3601fee41.camel@perches.com/


