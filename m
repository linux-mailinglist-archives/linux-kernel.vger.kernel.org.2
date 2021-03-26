Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6534A05C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhCZDvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCZDu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:50:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEDDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:50:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y5so4010721pfn.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7dlkoV4YkN93dZfloNBqSSl0D7xj9mcV/nV5heuVnU=;
        b=SNPnC0p9uXtxbKzGrahrQ1FsxzBGwjZ1fxBVg2bM0icM5CseQA4oQfHXOfQ0L5jyUy
         GQo88yFCoH9FBDFPM2GhNJoFIv5dvTkb2rTLpn3LmqRQL9oHfHOm5dwWxy/D8DEjlGfp
         rP8AI4wBq8gnbKzLJ2WW0IKJqfsY8lRlUNnrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7dlkoV4YkN93dZfloNBqSSl0D7xj9mcV/nV5heuVnU=;
        b=OVunElrE+DlaukBwrnuCFKKzYdXCh3p7jTzx8BNN57ZATZla2k83z7iJ9aLQgxpIPw
         R4uf++3OCdUuNkyI/QKilTrlPWod7SHd0Z6euFk2DxsoeZJTzHnGED4XKkzDfLmdKKHT
         Y3XrK7LdqwR6zxXPW4kZqvjj+H7z+DbynPOBxX1Fylm20MuvLz2vwrPR0+d1T68ETf16
         2teTD53J0ZIFGEs2PZYZv1kIGoZlcaxE4wtBv5kacIxev8yLZddpHxu3Tpv8EJ5RykvS
         XKGfD0HVpCQTlAjAfZDv3JDmwwcsjiZ4Q+gL4jHmpI3WoTOQV0spOGR6oC0aJ+yNX1H3
         O/Ig==
X-Gm-Message-State: AOAM5337cFzcAK9tzbxwF3ExyW9sEm6a9myPqcDf6b6JYao3An0k+FuX
        8BJaBWAgzeSKgKTPnCh0jdwgyixevB8vcg==
X-Google-Smtp-Source: ABdhPJx1Bdob5s5t68CvMh9vF/Ms3VTvr24uvdgCKlYyqsVixgzhB8rOnFpmjf1QHbwQctM02OMxOA==
X-Received: by 2002:a63:3ecb:: with SMTP id l194mr10378032pga.146.1616730656504;
        Thu, 25 Mar 2021 20:50:56 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:d0b:23e:bf14:3ec9])
        by smtp.gmail.com with ESMTPSA id v11sm7196345pgg.68.2021.03.25.20.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 20:50:55 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Ivo Sieben <meltedpianoman@gmail.com>,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 0/3] Detect suspicious indentation after conditional
Date:   Thu, 25 Mar 2021 20:50:32 -0700
Message-Id: <20210326035035.3057800-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is adding functionality to checkpatch.pl to test for
incorrect code indentation after a conditional statement, like this:

 if (a)
   b;
   c;

(Indentation implies that `c;` was guarded by the conditional, but it
isn't.) The main part is re-sending a patch from Ivo Sieben that was
already proposed in 2014 [1]. I don't know why it was never merged --
it seems that there was no discussion on it. I hope that it was only
overlooked, because it works great, and I think this is a very important
class of common error to catch.

I have tested it extensively on the kernel tree and in the course of
that found a few more edge cases that get fixed by the other two
patches. With all these applied, the vast majority of hits I get from
this check on the kernel tree are actual indentation errors or other
code style violations (e.g. case label and statement on the same line).
The only significant remaining group of false positives I found are
cases of macros being defined within a function, which are overall very
rare. I think the benefit of adding this check would far outweigh the
remaining amount of noise.

[1]: https://lore.kernel.org/patchwork/patch/465116

Ivo Sieben (1):
  Suspicious indentation detection after conditional statement

Julius Werner (2):
  checkpatch: ctx_statement_block: Fix preprocessor guard tracking
  checkpatch: Ignore labels when checking indentation

 scripts/checkpatch.pl | 56 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

-- 
2.29.2

