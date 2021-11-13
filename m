Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E287544F365
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhKMNkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhKMNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:40:35 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB4C061766;
        Sat, 13 Nov 2021 05:37:43 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso9977162pjb.2;
        Sat, 13 Nov 2021 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IRy9ruURmvdITp6JartVAHmE1TEeRSrqEIJePZ/fx3U=;
        b=gGH7noEByFITMs9LrNhUqLg0wTMaE/7EqHLaRncleJ88yipV6iBgRlk1WTRfHyXX/M
         9xet7DiORH3qCJ53gAQ9q3Vf7e7urwn7oV9X/jJCQtJ9+8eMRkz4dWrcQ2YTJzu4sb+I
         8l+s+NOjjchACvKW+UEhtRMKIRDa4I7WNJeXFO5ZgRlQw2oQAj2uizErJNWnYmkGnDvI
         iyevRJYYbHaPcfcjogQqkEY48BhlT9h3g6ql22sWRIgR6vbqyEiCUPOHgLRYGAvgGTLK
         wInK2DDKAhbbUkwHUOL1ZTIE6zMsCosLADpRaZXsMC7+bUyEaRkZkuIy20/vJaYtDaD/
         QjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IRy9ruURmvdITp6JartVAHmE1TEeRSrqEIJePZ/fx3U=;
        b=tViucfsYSS1RsCh6C6ebifG3NWDNToXqL5pzCvQMsTlnQ9PBwdLhN56A8BPxUJgQrr
         AsIJGG8YLFSiiqXwe4j3uZ+hRj6Jim7VPEBZMIWEuPR4rPxESJQTQCVTW+sI91K77uvE
         j5IUpPaZO/2ieAkW7n1eXtYRcIcd5AbG3fyyUfyDCUkZSXnPkxaT6tS0hJU2DgGLnMo+
         quphBv7V5iXXlJD0Yreb4aIKARCy3rv5jZGSqN7YNOgON+10yuUPbmwNiW8epQ3YWOCo
         IqElH60eRGKaiGvb/uP6lHzNTqVb9Kuw9dd4nohDKqvUioar7oYWAs1Vil9ZgRTnDCJ2
         aZfA==
X-Gm-Message-State: AOAM533g/izOciorq0E1kX2EIogCv+MldKiCzxZkiY0hbj/4MDMAeMul
        MkXS0hYt0BcgGFilKRW5Yx/t5+rasyk=
X-Google-Smtp-Source: ABdhPJygtaq31MdPjIneNzyYTHKf47oJqoRVGcLYfTh1Eyv8tjnoRl8tkLNDb15W0izhhiksA32KWA==
X-Received: by 2002:a17:902:e0d4:b0:142:8897:94e2 with SMTP id e20-20020a170902e0d400b00142889794e2mr17361330pla.58.1636810663285;
        Sat, 13 Nov 2021 05:37:43 -0800 (PST)
Received: from pc ([223.197.3.99])
        by smtp.gmail.com with ESMTPSA id h186sm7999905pfg.64.2021.11.13.05.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Nov 2021 05:37:42 -0800 (PST)
Date:   Sat, 13 Nov 2021 21:37:34 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     corbet@lwn.net, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ftrace: fix the wrong path of tracefs
Message-ID: <20211113133722.GA11656@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete "tracing" due to it has been included in /proc/mounts.
Delete "echo nop > $tracefs/tracing/current_tracer", maybe
this command is redundant.

Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 Documentation/trace/ftrace.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 4e5b26f03d5b..b3166c4a7867 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2442,11 +2442,10 @@ Or this simple script!
   #!/bin/bash
 
   tracefs=`sed -ne 's/^tracefs \(.*\) tracefs.*/\1/p' /proc/mounts`
-  echo nop > $tracefs/tracing/current_tracer
-  echo 0 > $tracefs/tracing/tracing_on
-  echo $$ > $tracefs/tracing/set_ftrace_pid
-  echo function > $tracefs/tracing/current_tracer
-  echo 1 > $tracefs/tracing/tracing_on
+  echo 0 > $tracefs/tracing_on
+  echo $$ > $tracefs/set_ftrace_pid
+  echo function > $tracefs/current_tracer
+  echo 1 > $tracefs/tracing_on
   exec "$@"
 
 
-- 
2.17.1

