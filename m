Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4949641FCB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 17:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhJBPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 11:23:51 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:37060 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233425AbhJBPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 11:23:49 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 49791100E7B55;
        Sat,  2 Oct 2021 15:22:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 077632351F3;
        Sat,  2 Oct 2021 15:21:59 +0000 (UTC)
Message-ID: <9f262a81acffffb6e267d5832b29d8596d8046e2.camel@perches.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function
 attributes
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Sat, 02 Oct 2021 08:21:58 -0700
In-Reply-To: <YVf80rXg8Yd19Hmw@kroah.com>
References: <20210930235754.2635912-1-keescook@chromium.org>
         <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
         <YVf80rXg8Yd19Hmw@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 077632351F3
X-Spam-Status: No, score=0.10
X-Stat-Signature: soyiqo7o57w1r49asd8u46n98r7p3mry
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18XHyC4W8Hgtuauvy9FtyuPzQMwcIbmQI8=
X-HE-Tag: 1633188119-488567
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-10-02 at 08:31 +0200, Greg KH wrote:
> I would think that now we have a format that the tools can
> actually follow, while before it was semi-random as to what to pick as
> the "one true way".

There will never be 'one true (and universal) way'.

Most existing code doesn't follow the suggested formatting and you
can't require or expect the existing code to change.

If automated scripts exist to change all the code to that new
'one true way', it wouldn't be applied.
 
> What am I missing here?

Try writing a regex for the proposal and make sure to separate out
all the various __<foo> attributes into their proper locations...

yuck and g'luck.

