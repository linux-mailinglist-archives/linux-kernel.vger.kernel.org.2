Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6FE3CD36B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhGSK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhGSK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:27:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255D9C061574;
        Mon, 19 Jul 2021 03:17:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so12159741pjo.3;
        Mon, 19 Jul 2021 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1oaFsfB75KGXZ2Jfm6WhblXtwA8C/MYDZ5+7R5cBPf0=;
        b=A9wlRwjI0b8eN2FOcPpMBL/fD/cMWlyUiYCdwaN42z1rr6gqYRrE/0usqGgvGJkQoK
         yEN8aeaUdE0ZUpeFwJ9jfvlj241thx5AapHzbul34XoetkLzcQqWZBi1vBhJ5NtI7jNP
         zLqc0z1xYNWZdyeYpUyPgixLLIay0e/h3mQMl7w42Z30aIxxYTYaUWvTdILERvlnDwbC
         M2+N0gRJTnqzO89+5RrkR26lbUBnsEF5TeD89hbx6DXm/FlCq7oa9bRyeuTsC0VGEl9G
         PK1BAaWfTd7Ua7MwgSuzCc0uecIZRNs0HS85FiEUxUKcqJ600f8GU1JptRcWjsQDyvIA
         G7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1oaFsfB75KGXZ2Jfm6WhblXtwA8C/MYDZ5+7R5cBPf0=;
        b=r+RQfKuBrNNiY4O7mXfVFsw9FHq7mYfh8WQMQH5dJxe17jHYtkVcm3EHanDiljwd72
         GO1ptlx4XXvNvo02kENRiiAHljSNoAWj+KIY9aVBZKv3Yv2N/o3Y4qL3jdKJnOifcEm3
         KjG/yUEnnl6dpQEnRRQMy5Z+jRXpV3weGnMl0asvzceYEoc5OuVRTBzZaZ1XkqFpMOJF
         CMERuYi/gWbaAcQP2MK1Ea76j8Fas5jtBrCSQg01RFArZUa0iVU0PTajkhUMYvKk6VAq
         k3FvcAY7lFWoA3Pi8zrr8nobzBbkNNaxLAuMa8c2PrgXJuX/eu5R3zO+7LHpHLdLvif6
         ltXg==
X-Gm-Message-State: AOAM533ybnP8XygYUn3edXQs2T3BEJSdbqSMVWw1FZV82AaX26Q1gHO+
        6QK8LX/3QICCuFOdQTJK1Yc=
X-Google-Smtp-Source: ABdhPJyKlze6Rj7YCnjhyaZ2tfFiUDKmdyn+Rec3ECNOfKahs6GoqIL24PZJD+J0SGykQP0+eWCMlQ==
X-Received: by 2002:a17:90a:9205:: with SMTP id m5mr30120442pjo.172.1626692886349;
        Mon, 19 Jul 2021 04:08:06 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x23sm21168646pgk.90.2021.07.19.04.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 04:08:05 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [RFC PATCH v2 0/7] docs: pdfdocs: Improve font choice in CJK
 translations
Message-ID: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
Date:   Mon, 19 Jul 2021 20:08:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm calling this patch set "RFC PATCH v2", but the approach has changed
a lot since "RFC PATCH 0/3 docs: pdfdocs: Improve alignment of CJK
ascii-art" [1], hence the different title.

I added Hu Haowen, who is working on zh_TW translations, and Shinwoo Lee,
who has recently shown interest in enhancing ko_KR translations [2] but
has got no public response yet, in the CC list in the faint hope of their
interest in CJK typesetting by Sphinx + XeLaTeX.  If either (or both) of
you has no interest, please let me know.  I won't bother you in this area.

I thought it was impossible to switch CJK font choices in the middle
of a document, but it turns out it is actually possible.

Patch 1/7 is mostly the same as the original "RFC PATCH 1/3".

Patch 2/7 is the most important change in this patch set.
It introduces a pair of LaTeX macros for each CJK language:
    zh_CN:  \kerneldocBeginSC, \kerneldocEndSC
    ko_KR:  \kerneldocBeginKR, \kerneldocEndKR
    ja_JP:  \kerneldocBeginJP, \kerneldocEndJP

, which perform magical font settings for the languages.

Each pair of macros are added in translations' respective index.rst.

As for Hangul inter-phrase spaces, xeCJK provides a knob to preserve
them.  \kerneldocBeginKR has the knob enabled.

Also note that CJKmainfont is changed from "Noto Sans CJK" to "Noto
Serif CJK", as the latter looks more consistent with the roman (serif)
family of Latin text.

The font choice of latin monospace letters is overridden (for
ascii-art alignmet) only when the document is built by
"make SPHINXDIRS=translations pdfdocs".

As for the to-be-merged zh_TW translations, the same approach should
work by choosing "Noto xxxx CJK TC" fonts.

There remain a couple of glitches remaining as of Patch 2/7.
Following patches address them one by one.

Patch 3/7 increases line spacing of CJK contents.
In general, CJK characters in single spacing looks too busy.
One-half spacing generates a reasonable result (to my eyes).

Patch 4/7 is a workaround of "Noto CJK" fonts' lack of italic shapes.

Patch 5/7 fixes excessive kerning by xeCJK around quotation marks
in Korean and Japanese translations. Quotation marks in "Noto Serif
CJK KR" and "Not Serif CJK JP" fonts are half-width rather than
full-width in "Noto Serif CJK SC".

Patches 6/7 and 7/7 corresponds to 2/3 and 3/3 in the original RFC.
They attempt to align ascii-art figures found in the Korean translation
of memory-barriers.txt.

Now, candidates of *true* monospace font for Hangul are:

    D2Coding, Sarasa Mono K, and (ugly looking) Unifont.

I said earlier in response to Mauro's concerns with regard to
"Sarasa Mono" font and sphinx-pre-install [3]:

Akira>>> Existence of "Sarasa Mono SC" can be checked by the command:
     >>>
     >>>     fc-list | grep "Sarasa Mono SC," | grep "style=Regular" | wc -l
     >>>
     >>> If the result is *not* "0", you have the font somewhere in your
     >>> fontconfig path.
     >>>
     >>> I think this is portable across distros.
     >>> Wouldn't this suffice for sphinx-pre-install?
Mauro>> 
     >> No. The sphinx-pre-install tool generate a list of commands
     >> needed to install the pre-reqs on a given distro.
     >> ...
     >> The same command, when executed on a different distro will
     >> print a different set of packages and commands.
Akira>
     > I see...
     >
     > So let's forget Unifont and "Sarasa Mono" for the time being.
     >
     > By adding some custom configuration of fontconfig, "Noto Sans Mono
     > CJK SC" can be made an alias of "Sarasa Mono", "Unifont", or whatever
     > alternative font one wants to try.

This was my misunderstanding.  Yes, alias is possible by fontconfig,
but fontconfig's alias names are not recognized by fontspec/xeCJK + XeLaTeX.
So we need to embed the actual names of candidate fonts in the preamble.

Mauro, isn't the header comment in conf.py added in Patch 6/7 good enough?
I don't think those nice-to-have fonts are pre-reqs that should be
taken care of by the sphinx-pre-install script.

On the other hand, as having heard of nothing from SeongJae, who is
the maintainer of Korean memory-barrier.txt, there might be nobody
who cares the Korean chapter in translations.pdf.
Patches 6/7 and 7/7 need explicit Acks of someone who reads it, I guess.

This series is tested against Sphinx 2.4.4 and brand-new 4.1.1.

Again, any feedback is appreciated!

	Thanks, Akira

[1]: https://lore.kernel.org/lkml/386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com/
[2]: https://lore.kernel.org/linux-doc/CAJMZz3_M34cy4ZbKGLZniGeUPOoJ7DMXdDOQxy-T44_cQ1+Udw@mail.gmail.com/
[3]: https://lore.kernel.org/lkml/0cfd8dfb-b304-4073-973c-930a93d19a17@gmail.com/

--
Akira Yokosawa (7):
  docs: pdfdocs: Refactor config for CJK document
  docs: pdfdocs: Add CJK-language-specific font settings
  docs: pdfdocs: Use one-half spacing in CJK translations
  docs: pdfdocs: Permit AutoFakeSlant for CJK fonts
  docs: pdfdocs: Teach xeCJK the width of quotation marks
  docs: pdfdocs: Add optional choices for Korean monospace font
  docs/ko_KR: Use white spaces behind CJK characters in ascii-art

 Documentation/conf.py                         | 77 +++++++++++++++----
 Documentation/translations/conf.py            | 44 +++++++++++
 Documentation/translations/ja_JP/howto.rst    |  8 ++
 Documentation/translations/ja_JP/index.rst    |  5 ++
 Documentation/translations/ko_KR/howto.rst    |  8 ++
 Documentation/translations/ko_KR/index.rst    |  2 +
 .../translations/ko_KR/memory-barriers.txt    | 14 ++--
 Documentation/translations/zh_CN/index.rst    |  5 ++
 8 files changed, 140 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/translations/conf.py

-- 
2.17.1


