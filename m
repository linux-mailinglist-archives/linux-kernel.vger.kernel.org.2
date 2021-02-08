Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB2C31316A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhBHLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhBHL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:29:50 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0787C061756
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 03:29:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so8612478pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 03:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kweKRPI1pGm9W64fX6UfwaUQ0m1Se5IM1naGco2xf+4=;
        b=d5KXgII/EiEoYNURcLqauiLr64YPI+Hle/fzKNzUTaWtuPcVwNG3CBjkT+K0uDAXMm
         DW60Pfrf1rx8KcSt/DZ4oIoDiRjb4goqns6FdXVc1dxkoBPjTHSS0qhLePT8iP/lNM0+
         110JOZKdp53dg/5+25DDAuZRiV0DULlMl6tdGfy4PFaIsMr6Ur6ToA0ofMjVrke+HlC7
         pzpg6zSGyWDMDp01tq93PTUsNvTCWQ0OsJ/2SiSViteZ3fSyE1F2wj+KCn3S0vCTgVvp
         bls8LnMy3EyJc+J0pYBDJ8qqjPB0zA6qu86VFNea+LH9kczMIetc+1LNrU02jjFaBpsy
         XAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kweKRPI1pGm9W64fX6UfwaUQ0m1Se5IM1naGco2xf+4=;
        b=okPw4gkY8PE3i98gSVe6Uu8HgI2BTPpSN3Wf+OYzEyl3Ofo5bHI09bcOQhMJwlWj8I
         psC/CVeZ3ZnZKO2vxZsenJ8JNG0Wr0k62bE7xo2fOOqp94I7lLlxjIcIVHdmN9Dr4w1H
         0g1koULwGwSLVgAyCGmXkYc6qIxWtlwLnWjHYJQ04iU5EC2cG2RnDfX5oUAU/46czd1N
         TnrY7n/+tC4UjzuhQhHigPM6MnhaCfolwe7+ZZT++pD5M0sXfpHLKqlZjcHJu0omC7ck
         cKG7Ym8Cb2hqa/fqkv8mUj6WPDnvb/qWTHRhbzY10Zc5cRLalT7U/11kPMPGAvMyPmrK
         SkpQ==
X-Gm-Message-State: AOAM531V6YAHgWEwSyVbBwvKmQepxsSPssRjbxhjjXr33FID7lwzHLeI
        eFMvrS4YOwsEvcr7WV9BCMo=
X-Google-Smtp-Source: ABdhPJxlCQx4Wo1XsAPH4bAApa/+8xlIrbWBhst9PjT1JI11YYaxxUrvAjEQwsR9fzgkdvubHUHv7g==
X-Received: by 2002:a17:90a:b703:: with SMTP id l3mr15919485pjr.60.1612783744545;
        Mon, 08 Feb 2021 03:29:04 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id 9sm8548695pfw.48.2021.02.08.03.29.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:29:04 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     ndesaulniers@google.com, natechancellor@gmail.com
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH v1] clang_tools:gen_compile_commands: Change the default source directory
Date:   Mon,  8 Feb 2021 19:28:57 +0800
Message-Id: <1612783737-3512-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default source directory is set equal to build directory which
specified by "-d".But it is designed to be set to the current working
directoy by default, as the help messge says.It makes a differece when
source directory and build directory are in separted directorys.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 1996370..add9e47 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -64,7 +64,7 @@ def parse_arguments():
             os.path.abspath(args.directory),
             args.output,
             args.ar,
-            args.paths if len(args.paths) > 0 else [args.directory])
+            args.paths if len(args.paths) > 0 else [os.getcwd()])
 
 
 def cmdfiles_in_dir(directory):
-- 
1.8.3.1

