Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8643B557
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbhJZPUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbhJZPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:20:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08590C061745;
        Tue, 26 Oct 2021 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=36Le8JT+MjbwIpd4YPOBdixMDoOu86XDiNDfVhsHRrw=; b=z1MLW99S5t8/UX5swpjnywtnO2
        VAidXRPVIWdITEqTWL27k9WqWnTQ+LWAlNymFeH5cb53zLuRrbVyrhjMZFLwxdblQgc9TmlNqg/Hd
        lOYG1ENnPBKzO+6sFdgSgAxBbs7Gy+sSb3BJlZeGLA7tLQ5lUH4JgMlKoV6nPSK5hUN5N6xFPgMYS
        Q1hzgcL8h6+EiOuQS535tW8aEnfK1G3L+sI8XtNgTStDI5ULbZL6W+mgiHqLzTUUg7UvRRe6cq7q9
        iscnx/c7gwCnUvsC1c6CiSUViZRzZIXuAMwoMN4L+XyYobBkF98edx9VYYWLLoWYmA5tZhTYevQuH
        073kB+Kw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfODc-0028EW-8R; Tue, 26 Oct 2021 15:18:28 +0000
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model
 macros
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Trevor Woerner <twoerner@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Yorick de Wid <yorickdewid@users.noreply.github.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20210423184012.39300-1-twoerner@gmail.com>
 <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
 <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
 <20211026144452.GA40651@localhost>
 <CANiq72kf0QZUeO+=U67NLs=WXc=sEtasdv_yaZ5sZedNmzzJBw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org>
Date:   Tue, 26 Oct 2021 08:18:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CANiq72kf0QZUeO+=U67NLs=WXc=sEtasdv_yaZ5sZedNmzzJBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 8:10 AM, Miguel Ojeda wrote:
> On Tue, Oct 26, 2021 at 4:44 PM Trevor Woerner <twoerner@gmail.com> wrote:
>>
>> get_maintainer.pl didn't add Andrew back then on my patch and still doesn't
>> even now. Maybe the MAINTAINERS file needs an update if Andrew is to be
>> included on trivial/documentation patches?
> 
> I mentioned Andrew because he does the hard job of being a backup for
> everything and everyone, but normally you should try to put the actual
> maintainer first in the `To` field and/or trivial@kernel.org.

I think that we decided to stop using trivial@kernel.org for new patches
a few months ago...

-- 
~Randy
