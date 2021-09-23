Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EAF4157C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 07:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhIWFMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 01:12:07 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:58002 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234629AbhIWFMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 01:12:05 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3AB12182CED2A;
        Thu, 23 Sep 2021 05:10:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 8BA3C1A29FC;
        Thu, 23 Sep 2021 05:10:26 +0000 (UTC)
Message-ID: <c993cfe373aad8cd688f172ad4fc032188370e20.camel@perches.com>
Subject: Re: function prototype element ordering
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, apw@canonical.com,
        Christoph Lameter <cl@linux.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, dwaipayanray1@gmail.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux-MM <linux-mm@kvack.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        mm-commits@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Wed, 22 Sep 2021 22:10:24 -0700
In-Reply-To: <CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com>
References: <20210909200948.090d4e213ca34b5ad1325a7e@linux-foundation.org>
         <20210910031046.G76dQvPhV%akpm@linux-foundation.org>
         <CAHk-=wgfbSyW6QYd5rmhSHRoOQ=ZvV+jLn1U8U4nBDgBuaOAjQ@mail.gmail.com>
         <202109211630.2D00627@keescook>
         <af3c775a1515f97c8dbe6a6651bd6e4b6986e8cd.camel@perches.com>
         <202109211757.F38DF644@keescook> <YUraGKetS+Tgc7y9@localhost.localdomain>
         <CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: snz89n14ensws59qo6ginjubhwfa4zsc
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 8BA3C1A29FC
X-Spam-Status: No, score=-0.82
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19xSpeXGi7fPZeju4RiHbCdzQS2uBIxyms=
X-HE-Tag: 1632373826-787062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 14:15 -0700, Linus Torvalds wrote:
> On Wed, Sep 22, 2021 at 12:24 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 
> > Attributes should be on their own line, they can be quite lengthy.
> 
> No, no no. They really shouldn't.
> 
> First off, no normal code should use that "__attribute__(())" syntax
> anyway. It's ugly and big, and many of the attributes are
> compiler-specific anyway.
> 
> So the "quite lengthy" argument is bogus, because the actual names you
> should use are things like "__packed" or "__pure" or "__user" etc.
> 
> But the "on their own line" is complete garbage to begin with. That
> will NEVER be a kernel rule. We should never have a rule that assumes
> things are so long that they need to be on multiple lines.

I think it's not so much that lines are long, it's more that the
information provided by these markings aren't particularly useful to
a caller/user of a function.

Under what circumstance is a marking like __pure/__cold or __section
useful to someone that just wants to call a particular function?

A secondary reason why these should be separate or at least put
at the begining of a function declaration is compatibility with
existing tools like ctags.


