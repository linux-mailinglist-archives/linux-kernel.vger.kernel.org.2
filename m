Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE14543DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhKQJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhKQJlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:41:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F96C061570;
        Wed, 17 Nov 2021 01:38:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so4790775pja.1;
        Wed, 17 Nov 2021 01:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Aki1NLeVtsw26dC02yR/rmj2WdHrHGV0mkw6Kw4rHCw=;
        b=jZ5dkPMf9wul3etBBgJWkwsyn7EE3gI+sqkW28tqz68xjxuD27gIO1xXt/szcXsrDZ
         5jN1zYJ9RnRLgDEzwyRoatlR/N+OwJuRjYPaHqLJpw/zbXqB+txldPOfJA8b/YjBUZCt
         4nEYacysDDtBJhp4GrD86U2byGGheF9PkTZtgsL+nTM2yEsPsJvGxOE9fIlm8RhhFXU8
         kP+iwB6Mp/RmjTDPKXXC2upfjPKR72Rc/O/g8JKeOvDBOsq1cN0moJxaKSm8WSAjjBIX
         PventnqvI1R5PBVuFQtNtUDyF3FDAP9Nvx3K1YxepWnxTqr9KPDhAnSMwHilr/gwI23N
         rXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Aki1NLeVtsw26dC02yR/rmj2WdHrHGV0mkw6Kw4rHCw=;
        b=B75ZJvdBhJ4B3yo+9WGKWeukHBM/wvKW6FXC9aycwqUQ5+xSHUeP24NrOb1RjLy3qY
         TJ7vdplM/gAkIb27fs0GXjDU8ZtGYnxixDoBYhG1ceUFHMvT9HylYzHK+Eqyzt04Sm/e
         xrRjyFAGpsjvKUaNwVuT0JQSHj1BBAtWwZDKl7a7J/C9ni61I7bLWY6CqfROgA7PO0Nx
         G4GvRn/AN0M2UMFySuWWKQpwFMcC1DlXPMPTDkMZcRiL1qaK3iSlVQPGfjx+hjGzXpck
         J4h2pPP6BEPVmGG1opzx4Fi3fwJrOPRofl/RP6N2Ss71r8vhcP6pc4yBvYdap8gpeCHk
         Ts4w==
X-Gm-Message-State: AOAM533Uv9ra2Tyo+g85zJUrSD3U3wqUlRksLraBT8+z6zPR6FBRjcW5
        i+V0hx13e7yBCjATrmQShhM=
X-Google-Smtp-Source: ABdhPJy1tYpf+Ff1f/HN12UhwDRBest1lP6OWxOPXMQlYVK1+8lb3BdUwEVMqc1YzlmYhEiilmUrOg==
X-Received: by 2002:a17:90b:4c0b:: with SMTP id na11mr8226675pjb.53.1637141898264;
        Wed, 17 Nov 2021 01:38:18 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id rj8sm5338117pjb.0.2021.11.17.01.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 01:38:17 -0800 (PST)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: admin-guide/blockdev: Use subgraphs in
 node-states-8.dot
Message-ID: <3cbff170-582b-b6cf-0988-e0d0c9b47505@gmail.com>
Date:   Wed, 17 Nov 2021 18:38:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While node-states-8.dot has two digraphs, dot(1) command can not
properly handle multiple graphs in a DOT file.

Use subgraphs and merge them into a single graph.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
---
Hi Jon,

I happened to spot a broken DOT script at the bottom of

    https://www.kernel.org/doc/html/latest/admin-guide/blockdev/drbd/figures.html

and managed to fix it.

DRBD DRIVER maintainers,
If I'm missing something here, please let me know.

        Thanks, Akira
--
 .../blockdev/drbd/node-states-8.dot           | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot b/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
index bfa54e1f8016..993f0c152ead 100644
--- a/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
+++ b/Documentation/admin-guide/blockdev/drbd/node-states-8.dot
@@ -1,13 +1,16 @@
-digraph node_states {
-	Secondary -> Primary           [ label = "ioctl_set_state()" ]
-	Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
-}
+digraph G {
+	compound=true;
+	subgraph node_states {
+		Secondary -> Primary           [ label = "ioctl_set_state()" ]
+		Primary   -> Secondary 	       [ label = "ioctl_set_state()" ]
+	}
 
-digraph peer_states {
-	Secondary -> Primary           [ label = "recv state packet" ]
-	Primary   -> Secondary 	       [ label = "recv state packet" ]
-	Primary   -> Unknown 	       [ label = "connection lost" ]
-	Secondary  -> Unknown  	       [ label = "connection lost" ]
-	Unknown   -> Primary           [ label = "connected" ]
-	Unknown   -> Secondary         [ label = "connected" ]
+	subgraph peer_states {
+		Secondary -> Primary           [ label = "recv state packet" ]
+		Primary   -> Secondary 	       [ label = "recv state packet" ]
+		Primary   -> Unknown 	       [ label = "connection lost" ]
+		Secondary  -> Unknown  	       [ label = "connection lost" ]
+		Unknown   -> Primary           [ label = "connected" ]
+		Unknown   -> Secondary         [ label = "connected" ]
+	}
 }

base-commit: 53b606fa29e321352a105978726b975b42b292a4
-- 
2.17.1

