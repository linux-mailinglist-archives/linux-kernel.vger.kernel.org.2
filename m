Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9331F11E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhBRUhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhBRUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:36:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1326EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:35:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so2255799pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=E2rf1f4vUAq7WMW1yPTNF4SYiERg2//VNqcIBdniMlI=;
        b=nGpLGZEyqicqR8ncccD/81uXeQcEMbh/WD2/UunOEWfwOWO58ufo3UxQmeGRJUJAqi
         U839MF06vmqTehU40ZLnW390g1Z3wjSwff9zJHRvK921/r/uzja7+sQVmtdUoIdelVXR
         WxtYAziDhnD4fmHWu7vZyyXkRzxQMPGVRLJxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=E2rf1f4vUAq7WMW1yPTNF4SYiERg2//VNqcIBdniMlI=;
        b=cSJvyIcad8f3tAjrIFn9B9LC/Ji9iPKrZGDRS4FbkZmrJNkZZidcshVP9vViojQdw5
         4UPGFk6D7JPZkIswUNX5qEnvyy5FUBnvqx3O4QiPsCDgwipFZsNneVgxngo2oeKrXWJP
         KB6vZDZMIV/Q6Nn29FZvVkxGIwdvd/0oyQKmHxL8arWTrXTi3Xkr0rydLLw8XfWEaQ/0
         asrHsrQJ0BuwRA8yBHAMKaSH4Nn5lWjK0SjUzBOfCAtv1npAauZfFxeDZVXaAt4kHnJw
         Mpte5it3ZWtGX0xKlWdp3/hKG1YoBIGNfHcox6PGa7meAzfDMqnpSa1rpVIedfJoK9w9
         a9NQ==
X-Gm-Message-State: AOAM5305SS/vhXdpvb1UluH64M05YIOEv+EnesAwbNOzd4RLKZI85mmN
        y4OvRn9SDQvrv2PJ9ojpv1K5wA==
X-Google-Smtp-Source: ABdhPJwvC+oR3dy1wd7pQ5J+t7FL8XiTDO1HrkQpzsFqxRVU9BJUDKn9G2u1wxdUJAPyHcuACoEkWQ==
X-Received: by 2002:a17:903:2305:b029:df:c991:8c49 with SMTP id d5-20020a1709032305b02900dfc9918c49mr6053745plh.8.1613680522684;
        Thu, 18 Feb 2021 12:35:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm6890369pfa.35.2021.02.18.12.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:35:22 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:35:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Bohac <jbohac@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Matteo Croce <mcroce@microsoft.com>
Subject: [GIT PULL] pstore update for v5.12-rc1
Message-ID: <202102181234.5FC6F9CEF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull this tiny pstore update for v5.12-rc1 to fix a CONFIG typo.

Thanks!

-Kees

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.12-rc1

for you to fetch changes up to 19d8e9149c27b689c6224f5c84b96a159342195a:

  pstore: Fix typo in compression option name (2021-02-18 12:27:49 -0800)

----------------------------------------------------------------
pstore update for v5.12-rc1

- Fix a CONFIG typo (Jiri Bohac)

----------------------------------------------------------------
Jiri Bohac (1):
      pstore: Fix typo in compression option name

 fs/pstore/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Kees Cook
