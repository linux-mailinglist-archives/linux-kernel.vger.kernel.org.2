Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F9338BA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhETXUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhETXUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:20:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:18:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w7so8430077lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I39s4AfTS1FlK9WbJvre2lj1XFN86rEIo1G47wYSeiA=;
        b=Guu6ytHTVtAJgVLrZ5CvwpqVw9UFQs4/wq4KDJQLUsbDGQ/bxulZe0qwUiNOh8R8aD
         FjKYgIyc/KbX80400ajv1EKpnY8Gkoppxi640xwyolXE7p/vq6xSVxLZRE5czroJidOV
         6ggM6Tnn7tOkaFPrODwxamFBMPpkTeDqOvM2nDQ5kyXZcdzqTjxvlb/fw9ROaIp6qq11
         OFC1zapPtMbNbEFqDDxcdwvHGi5fFO7x33zWQ4iz9PeCzZV6UbuR1IpGjVPyR4cYrByE
         z3KoJkoVY3F3pE3yt3z895qoxDKDyxr5lPRf4M9tPviuTTSgs8Kgd/1R+yWhkpGYR6sR
         72vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I39s4AfTS1FlK9WbJvre2lj1XFN86rEIo1G47wYSeiA=;
        b=tryZO/jliduF58E2nH28X829whCu4rFytzvkQWSuNwjjKX1yupzfZHxP7UoSFA7TsO
         Dnqs3U9rjIIpT1KtreF/uWxtR+xYkza07w6It6CoY5goGtU9El5V+9nD3+5XjriIrEc1
         kk5Ra9eL2kT44fsIBgVDv7ENxUOIaVgHkn8hazNYO0+aq8hUmhrZ2/uuNiWSGog/JFpf
         wCa0TpBX3b0C1h4vd8Ml4Wpul8CzroKWS+zz5JlbLtUm8BYJe13bYH+wIzcSWTYCQYEU
         mgnCiPuXp3Ps5wXWAOdm5DEudqdQCFfutwbwfbw1pJWRGHYevkoPIhHw139NwYBunfWZ
         iKqA==
X-Gm-Message-State: AOAM532DjRgYPxzCTBYo5/kQiFE77OKJoCMN6BBNMiYf9xV3Jwrulr0S
        NVBjISkmfxXAQsFQEK/ZvrE=
X-Google-Smtp-Source: ABdhPJxXmzFa2Oo2d2ZXCdPzD6pKbHEHghPnl4f+o+IM4nhR/ToSauJGa7PKi14QXFRA0XTF7kRopA==
X-Received: by 2002:a05:651c:200d:: with SMTP id s13mr4595040ljo.254.1621552716457;
        Thu, 20 May 2021 16:18:36 -0700 (PDT)
Received: from 192.168.1.8 ([212.59.242.58])
        by smtp.gmail.com with ESMTPSA id h25sm432761lfe.3.2021.05.20.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:18:36 -0700 (PDT)
From:   Maciej Falkowski <maciej.falkowski9@gmail.com>
To:     natechancellor@gmail.com, ndesaulniers@google.com
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        maciej.falkowski9@gmail.com
Subject: [PATCH 2/2] Makefile: clang-tools: Omit printing stack trace when KeyboardInterrupt is raised
Date:   Fri, 21 May 2021 01:18:21 +0200
Message-Id: <20210520231821.12272-2-maciej.falkowski9@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210520231821.12272-1-maciej.falkowski9@gmail.com>
References: <20210520231821.12272-1-maciej.falkowski9@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user terminates the script (also implicitly through for example
`make clang-analyzer`) by using
Ctrl+C (or sending SIGINT more generally) the KeyboardInterrupt
is raised printing stack trace of the execution as shown below:

$ ./scripts/clang-tools/run-clang-tools.py clang-tidy ./compile_commands.json
^CTraceback (most recent call last):
  File "./scripts/clang-tools/run-clang-tools.py", line 74, in <module>
    main()
  File "./scripts/clang-tools/run-clang-tools.py", line 70, in main
    pool.map(run_analysis, datastore)
  File "/usr/lib64/python3.8/multiprocessing/pool.py", line 364, in map
    return self._map_async(func, iterable, mapstar, chunksize).get()
  File "/usr/lib64/python3.8/multiprocessing/pool.py", line 765, in get
    self.wait(timeout)
  File "/usr/lib64/python3.8/multiprocessing/pool.py", line 762, in wait
    self._event.wait(timeout)
  File "/usr/lib64/python3.8/threading.py", line 558, in wait
Process ForkPoolWorker-6:
Process ForkPoolWorker-1:
Process ForkPoolWorker-5:
Process ForkPoolWorker-7:
Process ForkPoolWorker-2:
Process ForkPoolWorker-3:
Process ForkPoolWorker-4:
Process ForkPoolWorker-8:
    signaled = self._cond.wait(timeout)
  File "/usr/lib64/python3.8/threading.py", line 302, in wait
    waiter.acquire()
KeyboardInterrupt

The patch handles the raise of the KeyboardInterrupt and exits when occurred
with code 130 as documented in: https://tldp.org/LDP/abs/html/exitcodes.html

Signed-off-by: Maciej Falkowski <maciej.falkowski9@gmail.com>
---
 scripts/clang-tools/run-clang-tools.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
index 38fc311d2e03..eb0e0ecfce24 100755
--- a/scripts/clang-tools/run-clang-tools.py
+++ b/scripts/clang-tools/run-clang-tools.py
@@ -77,4 +77,7 @@ def main():
 
 
 if __name__ == "__main__":
-    main()
+    try:
+        main()
+    except KeyboardInterrupt:
+        sys.exit(130)
-- 
2.26.3

