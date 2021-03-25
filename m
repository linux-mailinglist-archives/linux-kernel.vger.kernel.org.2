Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE383491BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCYMQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhCYMQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:16:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BBFC06174A;
        Thu, 25 Mar 2021 05:16:19 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lPOuM-0005y8-Kz; Thu, 25 Mar 2021 13:16:15 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1616181657.git.linux@leemhuis.info>
Subject: Re: [PATCH v3 0/5] docs: reporting-issues: streamline process and
 solve a FIXME
Message-ID: <c8770353-3d0d-17af-115a-efa4a31fd97b@leemhuis.info>
Date:   Thu, 25 Mar 2021 13:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1616181657.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616674579;95de1c9e;
X-HE-SMSGID: 1lPOuM-0005y8-Kz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan!

On 19.03.21 20:27, Thorsten Leemhuis wrote:
> This series bundle a few patches that piled up for
> Documentation/admin-guide/reporting-issues.rst. The main changes are these:

Sorry to bring the following up, as I saw you mentioning in another mail
on linux-doc you have a lot on your plate already. I really would prefer
to not add something to it, but something came up.

My vague hope had been to get this patchset merged for 5.13-rc1 and
after its release post the text to Greg, Sasha, ksummit-list and LKML
for a round of really public review. That would make sure at least all
the important maintainers are aware of the text and have a chance to
intervene before it gets fully official. Depending on the outcome I had
hoped to remove the the two last remaining "FIXME" boxes and the "WIP"
box at the top of reporting-issues.rst for 5.14-rc1 and also remove
reporting-bugs.rst.




But a few days ago Konstantin put a visible admonition on the front of

bugzilla.kernel.org that links to the rendered version of
reporting-issues.rst – for context see

https://lore.kernel.org/lkml/CAMwyc-Sqbkg=VxCWcfRazkGG7vkwEQ43m9Dov_Nawia5MN_oUQ@mail.gmail.com/

And then Tytso brought up that it might be a good time to bless the
text: https://lore.kernel.org/lkml/YFovanxCgq1lF4Ah@mit.edu/



That's why I'd like to speed things up a little. But for that it would
be good to have something from you: a kind of "I like the direction
where this patch set is heading and I'm optimistic that we get it merged
for 5.13-rc1" message from you. With something like that I could move
ahead as outlined above already. Do you maybe have a minute for that?

Ciao, Thorsten


>  * patch 2/5: tones down 'test vanilla mainline' a little and mention that
> vendor kernel might be find in some cases if they are close to vanilla. Gets rid
> of a "FIXME" box.
> 
>  * patch 5/5: creates a streamlined process for users wanting to report
> regressions within a stable and longterm kernel series. The existing process is
> too demanding, complicated and takes too much time for this case. I didn't CC
> the stable maintainers here, they need to review the whole document anyway once
> the last few details have been sorted out.
> 
> Patch 1/5 are just small fixes I wanted to keep separated. Patch 3/4 and 4/5 are
> mainly there to make the diff in the last patch of this series easier to read in
> the review phase. They can easily be squashed into the patches that follow them.
> 
> v3:
> * add patch to fix a typo and an existing style-issue that came up during review
> that until now handled separately
> * add related patch that tones down 'test vanilla mainline' a bit
> * add another patch to make the diff easier to read
> 
> v2: https://lore.kernel.org/linux-doc/cover.1615116592.git.linux@leemhuis.info/
> * initial version, starting straight with v2 to avoid confusion, as one of the
> patches was submitted earlier already
> 
> Thorsten Leemhuis (5):
>   docs: reporting-issues.rst: fix small typos and style issues
>   docs: reporting-issues.rst: tone down 'test vanilla mainline' a little
>   docs: reporting-issues.rst: reorder some steps
>   docs: reporting-issues.rst: duplicate sections for reviewing purposes
>   docs: reporting-issues.rst: improved process esp. for stable
>     regressions
> 
>  .../admin-guide/reporting-issues.rst          | 832 ++++++++++--------
>  1 file changed, 471 insertions(+), 361 deletions(-)
> 
> 
> base-commit: a8f2a68e42d19e6fc1e0eb6eaef548ef07b19d75
> 
