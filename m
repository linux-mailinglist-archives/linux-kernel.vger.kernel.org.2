Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF23262BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBZMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBZMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:32:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53918C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:32:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id d13so5720861edp.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GCu0hDorWnnS7HlnLgsgdPKlD9qx5NPHhv/TQ0Dvwf8=;
        b=LkYTlqy1E04E6yiFg3imxnxZl2eDuE7gimiCB3O0aoMKlQR46zABeAoPNsIJOstndX
         HJ9ZIhfs6fcT5fAmmoNk+6iacNnwXwevZjjZN4wp8jAxX46y4pGa6CxQ7vyzb181d1+x
         fdIm6IJcGkgfNPo9CKkHxvolxBhLrFXqSfT4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GCu0hDorWnnS7HlnLgsgdPKlD9qx5NPHhv/TQ0Dvwf8=;
        b=hJzCzu8vVNHYOxSuDLyBsE9EVcsmIomSgwa4TE7rkZzQhDmcVJUU6DDD1whR5hAKN8
         mLRN8y5uDKWXV0faNfbf3lX1HtGRgDvLtsvclzGDuPvJurvhAzekcxDJ/ej62pkz9SGd
         l/RDGJPCQ7EwasUa/6tOg/JYaVwp6wiXPLvhcnC4CufgqHxU55G1QX9gr4gise/UQVX1
         /FI1+z4ZWv4C8wCEAJIJwhGESq930FRLADxGRWVbg/dJhIuXQD18X7AJRQ9n2lJnzTK0
         yJMTcbJI+dvhrqpUT75WnTMJ/bFWq33MtU4m9cOLIDbHaCEj/QgTbjmEVw4QJIpots+n
         AvqA==
X-Gm-Message-State: AOAM533lgFtnCwZJ/W2EuBBJUyf7HiWydwlGlx3QqLLk4+wHBPz+6eU5
        3uEW+E9Q3JJ76qN7qET37HfgnQ==
X-Google-Smtp-Source: ABdhPJxpow3e0iZ1BhGhGv76Vzsh7zztXx4EoEwDIcnNAmH1VbnmwMBMAQoz8kK3BmfadNmg9mXTxA==
X-Received: by 2002:a05:6402:17b6:: with SMTP id j22mr2920170edy.325.1614342726056;
        Fri, 26 Feb 2021 04:32:06 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id v11sm5005116eds.14.2021.02.26.04.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 04:32:05 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: spdx spring cleaning
Message-ID: <84ce357f-3400-2a4d-02e9-01e659829560@rasmusvillemoes.dk>
Date:   Fri, 26 Feb 2021 13:32:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was doing some 'git grep SPDX-License-Identifier' statistics, but
noticed that I had to do a lot more normalization than expected (clearly
handling different comment markers is needed).

How about running something like the below after -rc1? The end result is

 2558 files changed, 2558 insertions(+), 2558 deletions(-)

mostly from the last fixup, before that it's merely

 90 files changed, 90 insertions(+), 90 deletions(-)

Rasmus

#!/bin/sh

fixup() {
    gp="$1"
    cmd="$2"

    git grep --files-with-matches "SPDX-License-Identifier:$gp" | grep
-v COPYING | \
        xargs -r -P8 sed -E -s -i -e "1,3 { /SPDX-License-Identifier/ {
$cmd } }"
    git diff --stat | tail -n1
}

# tab->space, the first string is "dot asterisk tab"
fixup '.*	' 's/\t/ /g'

# trailing space
fixup '.* $' 's/ *$//'

# collapse multiple spaces
fixup '.*  ' 's/  */ /g'

# or -> OR
fixup '.* or ' 's/ or / OR /g'

# Remove outer parenthesis - when that pair is the only set of
# parenthesis. Only none or */ trailing comment marker is handled.
fixup ' (' 's|Identifier: \(([^()]*)\)( \*/)?$|Identifier: \1\2|'
