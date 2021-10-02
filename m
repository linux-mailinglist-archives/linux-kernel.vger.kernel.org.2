Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3C41FCBA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 17:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhJBPXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 11:23:55 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:37466 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233508AbhJBPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 11:23:54 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AE189182CED28;
        Sat,  2 Oct 2021 15:22:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 3E13B20A294;
        Sat,  2 Oct 2021 15:22:05 +0000 (UTC)
Message-ID: <0cbd2549be1245b445796f6c57a27b910fa4dc9d.camel@perches.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function
 attributes
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Date:   Sat, 02 Oct 2021 08:22:04 -0700
In-Reply-To: <CANiq72=T9b_RgZGHuKDjj=E46c0nB2CHH3+Wsdws2Wt9YWcHVw@mail.gmail.com>
References: <20210930235754.2635912-1-keescook@chromium.org>
         <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
         <YVf80rXg8Yd19Hmw@kroah.com>
         <CANiq72=T9b_RgZGHuKDjj=E46c0nB2CHH3+Wsdws2Wt9YWcHVw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.60
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3E13B20A294
X-Stat-Signature: yanmkicwt4zwyzm7d6m19nhnm1p8j4c5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/U9EYoX2BCER/gqYqYndT+x8+0TM0IkdI=
X-HE-Tag: 1633188125-535750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-10-02 at 12:42 +0200, Miguel Ojeda wrote:
> In the future, clang-format could have a configuration option to pass
> a sort order, in which case, having the sort order already defined in
> the kernel would definitely be helpful.

It's not so much a sort order so much as it's a positional one.


