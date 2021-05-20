Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC8138BA59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhETXT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhETXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:19:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC82C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:18:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v8so21949998lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/aZkvClPqTkoxRn3OG0yQtPKnHJCNnuxaerq1yum2k=;
        b=i8rZOgkQrZCPMbsFHBYdAG4mh77RUUBri8iiWFb4glpbSLKrTjBpBNUR5HLX8hMhkM
         zVRynWksccDahcpq6JPUCmDOOnn9CRPCj7dtp6PSnA/Kv01I97e6ThkBqeVwigPRjFZH
         uxci66g1LGoKBUoSvMdZoOcL15r7Wf0SlGHy72Glg2A6O05kqoy6ng7kfqBQB17frgzk
         v+V1ptXmVPIVWwM79M3D4C+TEAtauzwzEDUhcXKY55u8lqBQKPw0TmnoUpS9yDvkG3tZ
         SD8zrisw7vd2gCiSjkXbjTabV94O9QUNXnSqDkfcCu4DXlz3xAx0cPLZo0hWBQa1BCvo
         2GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V/aZkvClPqTkoxRn3OG0yQtPKnHJCNnuxaerq1yum2k=;
        b=LWdTfffYMJm4Hr+pKWNCZ+9uec+eIKdXcmMiwxPqeHna6kmRPGRCPK8R+KqS+PiGYW
         K27qiyordpkAbSlfScWwXGSOrt50ek86paplwJeQenQKw9DpCOzdKhxc4P+4+zagfNkk
         EMXwl3tX5SS8oPbxkUGno1wNuMzs+Qe9hMN299Drgh2ZxephUZC6zJx7xU1SY/8E9Pxg
         1bM0RCAD+AK7vItytsm1q+Xe58y0L9fZYwZPeXsKKFwIarnF9VnUne5D6k0OA4E5r63o
         jeF3dnfdg1Er35eaVOu3tMWt9xPKfTCAUuuGqbwaNq21GtSCoyl8fwqpxdTt55YO/jpI
         SU6Q==
X-Gm-Message-State: AOAM531eH+fCSd6u8WxCTQz4A1SHZhNygfehL29PZIBA1UMmb0UcT8mk
        Tu40NWNwK+Y72YrZdPiNpXQ=
X-Google-Smtp-Source: ABdhPJwEWg02ikvH2tTZMpJIkAUxAMTsntOKxMB6eLdZJ5Ps2LdV0aOXvB712vhHlDBpdyYe/iyd2w==
X-Received: by 2002:a19:6a0f:: with SMTP id u15mr4990334lfu.614.1621552713684;
        Thu, 20 May 2021 16:18:33 -0700 (PDT)
Received: from 192.168.1.8 ([212.59.242.58])
        by smtp.gmail.com with ESMTPSA id h25sm432761lfe.3.2021.05.20.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:18:32 -0700 (PDT)
From:   Maciej Falkowski <maciej.falkowski9@gmail.com>
To:     natechancellor@gmail.com, ndesaulniers@google.com
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        maciej.falkowski9@gmail.com
Subject: [PATCH 1/2] Makefile: clang-tools: Print information when clang-tidy tool is missing
Date:   Fri, 21 May 2021 01:18:20 +0200
Message-Id: <20210520231821.12272-1-maciej.falkowski9@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When `clang-tidy` tool is missing in the system, the FileNotFoundError
exception is raised in the program reporting a stack trace to the user:

$ ./scripts/clang-tools/run-clang-tools.py clang-tidy ./compile_commands.json
multiprocessing.pool.RemoteTraceback:
"""
Traceback (most recent call last):
  File "/usr/lib64/python3.8/multiprocessing/pool.py", line 125, in worker
    result = (True, func(*args, **kwds))
  File "/usr/lib64/python3.8/multiprocessing/pool.py", line 48, in mapstar
    return list(map(*args))
  File "./scripts/clang-tools/run-clang-tools.py", line 54, in run_analysis
    p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
  File "/usr/lib64/python3.8/subprocess.py", line 489, in run
    with Popen(*popenargs, **kwargs) as process:
  File "/usr/lib64/python3.8/subprocess.py", line 854, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/lib64/python3.8/subprocess.py", line 1702, in _execute_child
    raise child_exception_type(errno_num, err_msg, err_filename)
FileNotFoundError: [Errno 2] No such file or directory: 'clang-tidy'
"""

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "./scripts/clang-tools/run-clang-tools.py", line 74, in <module>
    main()
  File "./scripts/clang-tools/run-clang-tools.py", line 70, in main
    pool.map(run_analysis, datastore)
  File "/usr/lib64/python3.8/multiprocessing/pool.py", line 364, in map
    return self._map_async(func, iterable, mapstar, chunksize).get()
  File "/usr/lib64/python3.8/multiprocessing/pool.py", line 771, in get
    raise self._value
FileNotFoundError: [Errno 2] No such file or directory: 'clang-tidy'

The patch adds more user-friendly information on the missing tool by
catching FileNotFoundError for `clang-tidy` file and raising exception
again for possible other files:

$ ./scripts/clang-tools/run-clang-tools.py clang-tidy ./compile_commands.json
Command `clang-tidy` is missing in the system.

Signed-off-by: Maciej Falkowski <maciej.falkowski9@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1342
---
 scripts/clang-tools/run-clang-tools.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index fa7655c7cec0..38fc311d2e03 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -67,7 +67,13 @@ def main():
     # Read JSON data into the datastore variable
     with open(args.path, "r") as f:
         datastore = json.load(f)
-        pool.map(run_analysis, datastore)
+        try:
+            pool.map(run_analysis, datastore)
+        except FileNotFoundError as not_found:
+            if not_found.filename == 'clang-tidy':
+                print('Command `clang-tidy` is missing in the system.')
+            else:
+                raise not_found
 
 
 if __name__ == "__main__":
-- 
2.26.3

