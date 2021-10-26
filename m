Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6BC43B589
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhJZPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:30:13 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:51994 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232476AbhJZPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:30:11 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1519C184A82B1;
        Tue, 26 Oct 2021 15:27:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 46E3620D751;
        Tue, 26 Oct 2021 15:27:44 +0000 (UTC)
Message-ID: <58650d3729a5b3a8bc86037757bccda5cc254e3f.camel@perches.com>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model
 macros
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Trevor Woerner <twoerner@gmail.com>
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
Date:   Tue, 26 Oct 2021 08:27:43 -0700
In-Reply-To: <fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org>
References: <20210423184012.39300-1-twoerner@gmail.com>
         <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
         <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
         <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
         <20211026144452.GA40651@localhost>
         <CANiq72kf0QZUeO+=U67NLs=WXc=sEtasdv_yaZ5sZedNmzzJBw@mail.gmail.com>
         <fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 46E3620D751
X-Spam-Status: No, score=-1.24
X-Stat-Signature: nu3xzep8u4f9aors41inrambaais4ff4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/SVfpBUaA3R2tKARvohc5r/nEZqK9kxPg=
X-HE-Tag: 1635262064-19342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-26 at 08:18 -0700, Randy Dunlap wrote:
> On 10/26/21 8:10 AM, Miguel Ojeda wrote:
> > On Tue, Oct 26, 2021 at 4:44 PM Trevor Woerner <twoerner@gmail.com> wrote:
> > > 
> > > get_maintainer.pl didn't add Andrew back then on my patch and still doesn't
> > > even now. Maybe the MAINTAINERS file needs an update if Andrew is to be
> > > included on trivial/documentation patches?
> > 
> > I mentioned Andrew because he does the hard job of being a backup for
> > everything and everyone, but normally you should try to put the actual
> > maintainer first in the `To` field and/or trivial@kernel.org.
> 
> I think that we decided to stop using trivial@kernel.org for new patches
> a few months ago...

Dunno who the "we" is but then maybe this is appropriate:
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 869e6cc6366bc..8c933736bb412 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19282,12 +19282,6 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TRIVIAL PATCHES
-M:	Jiri Kosina <trivial@kernel.org>
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
-K:	^Subject:.*(?i)trivial
-
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>

