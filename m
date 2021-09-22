Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAAF414435
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhIVIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:53:13 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:44110 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233741AbhIVIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:53:11 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 46C8818224D8D;
        Wed, 22 Sep 2021 08:51:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id A34D41E04D3;
        Wed, 22 Sep 2021 08:51:35 +0000 (UTC)
Message-ID: <e231bce4942848400f4286a2d4178eeab6555989.camel@perches.com>
Subject: Re: function prototype element ordering
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        linux-doc@vger.kernel.org
Date:   Wed, 22 Sep 2021 01:51:34 -0700
In-Reply-To: <YUraGKetS+Tgc7y9@localhost.localdomain>
References: <20210909200948.090d4e213ca34b5ad1325a7e@linux-foundation.org>
         <20210910031046.G76dQvPhV%akpm@linux-foundation.org>
         <CAHk-=wgfbSyW6QYd5rmhSHRoOQ=ZvV+jLn1U8U4nBDgBuaOAjQ@mail.gmail.com>
         <202109211630.2D00627@keescook>
         <af3c775a1515f97c8dbe6a6651bd6e4b6986e8cd.camel@perches.com>
         <202109211757.F38DF644@keescook> <YUraGKetS+Tgc7y9@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.58
X-Stat-Signature: stsnoorhuzzsu81jzy15qc4susetbm8e
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A34D41E04D3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/0VQy3rI6crSuBv+vrDUQ0lyPWzhzLHhQ=
X-HE-Tag: 1632300695-215196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-22 at 10:24 +0300, Alexey Dobriyan wrote:

> Attributes should be on their own line, they can be quite lengthy.
> 
> 	__attribute__((...))
> 	[static] [inline] T f(A1 arg1, ...)
> 	{
> 		...
> 	}
> 
> There will be even more attributes in the future, both added by
> compilers and developers (const, pure, WUR), so let's make "prototype lane"
> for them.
> 
> Same for structures:
> 
> 	__attribute__((packed))
> 	struct S {
> 	};

Do you know if placing attributes like __packed/__aligned() before
definitions would work for all cases for structs/substructs/unions?


