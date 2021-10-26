Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB19843B5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhJZPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:40:05 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:42672 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236963AbhJZPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:40:00 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1CC1218128067;
        Tue, 26 Oct 2021 15:37:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 971472448B9;
        Tue, 26 Oct 2021 15:37:30 +0000 (UTC)
Message-ID: <52c1cd5fa698216734ffda706299d77a102fcb2f.camel@perches.com>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model
 macros
From:   Joe Perches <joe@perches.com>
To:     Trevor Woerner <twoerner@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Yorick de Wid <yorickdewid@users.noreply.github.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Tue, 26 Oct 2021 08:37:29 -0700
In-Reply-To: <20211026144452.GA40651@localhost>
References: <20210423184012.39300-1-twoerner@gmail.com>
         <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
         <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
         <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
         <20211026144452.GA40651@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 971472448B9
X-Spam-Status: No, score=-1.36
X-Stat-Signature: f5wh9ftqskmbjsgudt7zcqyycmeceps3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19BGWKjLVK8sFLYXduqBtSM80M23Qj+zGQ=
X-HE-Tag: 1635262650-355530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-26 at 10:44 -0400, Trevor Woerner wrote:
> On Tue 2021-10-26 @ 02:47:12 PM, Miguel Ojeda wrote:
> > On Mon, Oct 25, 2021 at 11:40 PM Trevor Woerner <twoerner@gmail.com> wrote:
> > > ping?
[]
> > Note that you should put whoever should take it in the To field (I
> > just noticed your original email did not) -- use
> > `scripts/get_maintainer.pl` for getting the relevant people for a
> > patch or path.
> 
> Ah, good point. I have a "cccmd" line in my ~/.gitconfig for adding people to
> the CC when I "git send-email", maybe I should switch that to a "tocmd"?

I use scripts for both.

https://lore.kernel.org/all/1473862411.32273.25.camel@perches.com/


