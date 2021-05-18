Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97638712D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhERFWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 01:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhERFWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 01:22:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6AC061573;
        Mon, 17 May 2021 22:21:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so12518722ejc.10;
        Mon, 17 May 2021 22:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pFiqMZJlaX/Bz8XfAz/1acvvJaIlIKoYenynJIsVpYg=;
        b=pWFD6aKjXGka+IDfLinyMbuOCrPazm71mcAX5Z13URw9fijjqI9HIshAGQ7HDFkHuh
         8J6K0eWO7aCg/sBQiNDAuJ3MLOb0mGVScyOBvcuW17F3hnJOPTTkQbjLgmRnRxlbWw4Z
         r3tWfGlAdQqJSAxgACFuLRwrAl3ZhrAOTFAoSd3x/7YFcZA8A5yUh/0mwTKmAbBbiSgy
         Gd94DIK2cW8o6Uh4YpD3oeDnlkV17rAPyBlMMiOJ+bfzttjtj+ZSdJC+mEgX4wxvAFy1
         +I/8MLb7aZrEovPmaUtc+XcY+MdWCy/FYg0fnZDpxg6FXel+UkmB3KREQebGUMrMsHAN
         wBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pFiqMZJlaX/Bz8XfAz/1acvvJaIlIKoYenynJIsVpYg=;
        b=P2hqwhggzAq8HahRFSssb/9EXm2NUpaExhW7cthNdXap7DWHR2QaLvD+AyKFFDfMcT
         IVgALEKBzaPxS+eVHSkIc84efPXkpgNZkLLLD2SNbz2iD1L8rRnUkRZCVexHcHtwbvvY
         /MN8yI8WdOQ4vaGGkVny45eJY5D2nUYzZz7EqnfvOEq2nqng80oSP4PjQXgbcF8hjurg
         Azvv1JC2cYEVK79ahoUQundH7KF1ZA2Q8Y4l2+MAsKHbM6KB8riTLOa+kM+ZDzKb8dHT
         9Owrz8yxUQYrAovrt/98uQjUMdYCAbeybnTPiO5+hEBSqJF9WXZACl8Q46arUHKbcHOq
         fZ4w==
X-Gm-Message-State: AOAM530g9vkXeDYKruSgdUIh2bKW+SucxFNIETP7ScZxHepiFdqw2WMk
        6CUXNqRlrXWzMO8JafRfDO0=
X-Google-Smtp-Source: ABdhPJy4K1K21/QwX54PrULsub866WZnIzTF94ShTuczWsNwbnxKx+MSERRD4XwAQG2zHinmS3Yt7Q==
X-Received: by 2002:a17:906:cc9:: with SMTP id l9mr4155748ejh.454.1621315291050;
        Mon, 17 May 2021 22:21:31 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2db8:6100:84b8:37fd:659f:be17])
        by smtp.gmail.com with ESMTPSA id n17sm12117083eds.72.2021.05.17.22.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 22:21:30 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 0/1] Mining maintainers for kernel headers
Date:   Tue, 18 May 2021 07:21:16 +0200
Message-Id: <20210518052117.14819-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, Jiri,

Some basic data mining on the kernel development process [1, 2, 3] showed that
various files in ./include currently do not have a maintainer formally assigned
with a section in the MAINTAINERS file.

This is a first semi-automatic attempt of mining a mapping of header files to
MAINTAINERS section.

Currently, the automated code analysis basically does the following steps:

  1. Heuristically map header files to the related source files.

    The heuristics basically uses ctags to obtain the prototypes within a
    header file and then elixir to identify in which these prototypes are
    defined. The header file is then mapped to the source file with the highest
    number of definitions for prototypes referred to. More fine-tuning may
    still be required here.

  2. Deterministically map these source files to its MAINTAINERS section.

    Simply, using get_maintainer.pl, we obtain all relevant MAINTAINERS sections
    for each source file linked to a header file above.

  3. Combine those two mappings to identify which header files should be best
     added to which section in the existing MAINTAINERS file.

    As of now, we simply take the one most relevant source file identified and
    map it to a maintainer section. However, as the mapping from step 1 does not
    map every header file to a source file, the overall suggestions for
    additions is still pretty incomplete.

  4. Manually review the suggestions and manually create the patch for some
     example sections.

    At this early stage, we look at some selective sections, review the
    suggestions made by this tool for a section, filter out suggestions that
    seem rather wrong and then manually create the patch to add files and
    patterns from ./include/linux to the appropriate section.

Hence, the provided additions in this patch should be correct, but are not
necessarily complete wrt. all header files in ./include/linux/ that actually
belong to the TTY LAYER.

As all of this work is still pretty early and experimental, please provide
feedback on its correctness or simply pick such change for your tree if it is
all okay to take for now (although not yet complete).

Also, criticism on the approach and the way providing such patches for
MAINTAINERS is welcome, e.g.:

Your suggestions need to have this specific quality before reaching out to me
or other kernel maintainers with patches of such kind.

Or: Please do not take up the maintainers' review time for such clean-up and
just keep MAINTAINERS in the state as it is. (I would hope that this MAINTAINERS
clean-up is worth my time to attempt it, and given some good heuristics and own
manual review, worth the time to pick up by the individual maintainers.)

Or: Please first work on this other clean-up topic in MAINTAINERS and then
afterwards clean up this aspect here.


[1] https://lore.kernel.org/lkml/alpine.DEB.2.21.2003090702440.3325@felia/#r
[2] https://lwn.net/Articles/842415/
[3] https://lists.elisa.tech/g/devel/message/1269


Thanks and best regards,

Lukas


Lukas Bulwahn (1):
  MAINTAINERS: TTY LAYER: add some ./include/linux/ header files

 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1

