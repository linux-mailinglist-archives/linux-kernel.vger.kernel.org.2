Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC6443A01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKBXu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhKBXuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:50:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5E6C061714;
        Tue,  2 Nov 2021 16:48:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x5so743728pgk.11;
        Tue, 02 Nov 2021 16:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HJipf6E0wMX/VQfuLK3bpQT/GXpVFz/q7mqyd24tIJU=;
        b=mXdGRMzFWXiUhrL/kj1Ya9nizk2wrETtb1vN5Vn2QRFE/TkU1BchtE4AV7skQmUuKs
         f+cYUKyKOnFXo1WkFXSAY+Bflu0PlVwjSsFH0ZK1TgtHwmE3CpS25akvzzGFsms7C33N
         hwOTJZCGU3mcnFVCDO5tcgCANzYuTSO9dZ3UD3HJ+iaWrzmF1T1rqdgrbinQnhZcxqvn
         SI+nNE6uBOCOE5ZpXNc8C1geda4VsDrHhJwYQi2Jzx98Fh87wHDpxiUL9pzvvqmVRZvz
         tY1dZPromay/xJyVpNe7mho5gZLNxZeIXYwS65IJnkLMjJWPI+LbKMdBAtxxJ1vi44L6
         nJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HJipf6E0wMX/VQfuLK3bpQT/GXpVFz/q7mqyd24tIJU=;
        b=Rr8qTahOKtqFSOL2jf4QZTs25bvtJlEBJfNZmCgE4WpywBwIf5pMkRB8tLK3ASznlp
         Uricb+b5fo6F+yeWRZQV4G2Za+1aPYX1vZZ1pZvC7df0aDuw7oLJgDcGaA8k8alIM4+0
         1PRQ1cuhnM52Dzh41pPEuB/+t1eyRpJLwORiYRJSR5HSGwvEBf/xPmelxlrlwh9YTt6u
         5rx7ZOsB7fA21mi2c7ebyIiuhYiTxDByKgXpRSigDTmPSlWj6RX2Gfd6g5I1ZUKQEBjs
         3LBN9n/rnBvqAZndnuhKde03AxbUoHGh1ayCnbLsHFBNzF9ELMonixv3exZt7KdpE7wY
         w6uA==
X-Gm-Message-State: AOAM532yOgzxDOzqg9zPnzLBa7kWZfAXw6YS6WYnVJbS6eXoK8H2OBoc
        vzUpq+fKo6RjhVsIbCyrj82Qrn2MnBM=
X-Google-Smtp-Source: ABdhPJzcAdCP3uzeV/VwQWuKmqEc1ayrTAdyy1tesu/pevwcKOyeUzwi1rqXtfJrT6XVtYwRYCBGaw==
X-Received: by 2002:a63:af44:: with SMTP id s4mr30525569pgo.219.1635896898855;
        Tue, 02 Nov 2021 16:48:18 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 13sm169402pjb.37.2021.11.02.16.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 16:48:18 -0700 (PDT)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -rcu] docs: RCU: Avoid 'Symbol' font-family in SVG figures
Message-ID: <c363a4b2-143c-c334-4c5b-2f16acbf3989@gmail.com>
Date:   Wed, 3 Nov 2021 08:48:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH -rcu] docs: RCU: Avoid 'Symbol' font-family in SVG figures

On Ubuntu Focal, strings in some of SVG files under
Documentation/RCU/Design can not be rendered properly when
converted to PDF.

Ubuntu releases since Focal and Debian bullseye have trouble
with "Symbol" font-family in SVG files.

As those strings are mostly API names such as "READ_ONCE()",
"WRITE_ONCE(), "rcu_read_lock()", and so on, using a generic
monospace font-family should be a good alternative.

Substitute the font-family name by a simple sed pattern:

    's/Symbol/monospace/g'

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi Paul,

As was discussed off-list messages, here is a workaround
to avoid illegible strings in RCU.pdf when built on
Ubuntu Focal.

It turns out Debian bullseye also shows the same symptom.
Recent Ubuntu releases of Hirsute and Impish do too.

My suggestion was to substitute "Mono" for "Symbol", but
"monospace" is used as a generic font-family in recent
versions of Inkscape.

This is relative to -rcu's dev branch.

        Thanks, Akira
--
 .../Expedited-Grace-Periods/Funnel0.svg       |  4 +-
 .../Expedited-Grace-Periods/Funnel1.svg       |  4 +-
 .../Expedited-Grace-Periods/Funnel2.svg       |  4 +-
 .../Expedited-Grace-Periods/Funnel3.svg       |  4 +-
 .../Expedited-Grace-Periods/Funnel4.svg       |  4 +-
 .../Expedited-Grace-Periods/Funnel5.svg       |  4 +-
 .../Expedited-Grace-Periods/Funnel6.svg       |  4 +-
 .../Expedited-Grace-Periods/Funnel7.svg       |  4 +-
 .../Expedited-Grace-Periods/Funnel8.svg       |  4 +-
 .../Requirements/GPpartitionReaders1.svg      | 36 +++++------
 .../Requirements/ReadersPartitionGP1.svg      | 62 +++++++++----------
 11 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel0.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel0.svg
index 98af66557908..16b1ff0ad38c 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel0.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel0.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel1.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel1.svg
index e0184a37aec7..684a4b969725 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel1.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel1.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel2.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel2.svg
index 1bc3fed54d58..8fb2454d9544 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel2.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel2.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel3.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel3.svg
index 6d8a1bffb3e4..5d4f22d5662c 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel3.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel3.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel4.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel4.svg
index 44018fd6342b..b89b02869914 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel4.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel4.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel5.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel5.svg
index e5eef50454fb..90f1c77bea2f 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel5.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel5.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel6.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel6.svg
index fbd2c1892886..3e5651da031a 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel6.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel6.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel7.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel7.svg
index 502e159ed278..9483f08d345e 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel7.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel7.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel8.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel8.svg
index 677401551c7d..1101ec30e604 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel8.svg
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel8.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -125,7 +125,7 @@
            y="492.36218" /></flowRegion><flowPara
          id="flowPara2991" /></flowRoot>    <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="362.371"
        y="262.51819"
        id="text4441"
diff --git a/Documentation/RCU/Design/Requirements/GPpartitionReaders1.svg b/Documentation/RCU/Design/Requirements/GPpartitionReaders1.svg
index 4b4014fda770..87851a8fac1e 100644
--- a/Documentation/RCU/Design/Requirements/GPpartitionReaders1.svg
+++ b/Documentation/RCU/Design/Requirements/GPpartitionReaders1.svg
@@ -88,7 +88,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -103,7 +103,7 @@
          id="text2993"
          y="-261.66608"
          x="412.12299"
-         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
          xml:space="preserve"
          transform="matrix(0,1,-1,0,0,0)"><tspan
            y="-261.66608"
@@ -135,7 +135,7 @@
     </g>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="112.04738"
        y="268.18076"
        id="text4429"
@@ -146,7 +146,7 @@
          y="268.18076">WRITE_ONCE(a, 1);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="112.04738"
        y="439.13766"
        id="text4441"
@@ -157,7 +157,7 @@
          y="439.13766">WRITE_ONCE(b, 1);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="255.60869"
        y="309.29346"
        id="text4445"
@@ -168,7 +168,7 @@
          y="309.29346">r1 = READ_ONCE(a);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="255.14423"
        y="520.61786"
        id="text4449"
@@ -179,7 +179,7 @@
          y="520.61786">WRITE_ONCE(c, 1);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.10254"
        y="384.71124"
        id="text4453"
@@ -190,7 +190,7 @@
          y="384.71124">r2 = READ_ONCE(b);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.10254"
        y="582.13617"
        id="text4457"
@@ -201,7 +201,7 @@
          y="582.13617">r3 = READ_ONCE(c);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="112.08231"
        y="213.91006"
        id="text4461"
@@ -212,7 +212,7 @@
          y="213.91006">thread0()</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="252.34512"
        y="213.91006"
        id="text4461-6"
@@ -223,7 +223,7 @@
          y="213.91006">thread1()</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.42557"
        y="213.91006"
        id="text4461-2"
@@ -251,7 +251,7 @@
        inkscape:connector-curvature="0" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="111.75929"
        y="251.53981"
        id="text4429-8"
@@ -262,7 +262,7 @@
          y="251.53981">rcu_read_lock();</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.10254"
        y="367.91556"
        id="text4429-8-9"
@@ -273,7 +273,7 @@
          y="367.91556">rcu_read_lock();</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.10254"
        y="597.40289"
        id="text4429-8-9-3"
@@ -284,7 +284,7 @@
          y="597.40289">rcu_read_unlock();</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="111.75929"
        y="453.15311"
        id="text4429-8-9-3-1"
@@ -300,7 +300,7 @@
        inkscape:connector-curvature="0" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="394.94427"
        y="345.66351"
        id="text4648"
@@ -324,7 +324,7 @@
        sodipodi:open="true" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="112.11968"
        y="475.77856"
        id="text4648-4"
@@ -361,7 +361,7 @@
        sodipodi:open="true" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="254.85066"
        y="348.96619"
        id="text4648-4-3"
diff --git a/Documentation/RCU/Design/Requirements/ReadersPartitionGP1.svg b/Documentation/RCU/Design/Requirements/ReadersPartitionGP1.svg
index 48cd1623d4d4..e2a8af592bab 100644
--- a/Documentation/RCU/Design/Requirements/ReadersPartitionGP1.svg
+++ b/Documentation/RCU/Design/Requirements/ReadersPartitionGP1.svg
@@ -116,7 +116,7 @@
     <flowRoot
        xml:space="preserve"
        id="flowRoot2985"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
          id="flowRegion2987"><rect
            id="rect2989"
            width="82.85714"
@@ -131,7 +131,7 @@
          id="text2993"
          y="-261.66608"
          x="436.12299"
-         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
          xml:space="preserve"
          transform="matrix(0,1,-1,0,0,0)"><tspan
            y="-261.66608"
@@ -163,7 +163,7 @@
     </g>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="112.04738"
        y="268.18076"
        id="text4429"
@@ -174,7 +174,7 @@
          y="268.18076">WRITE_ONCE(a, 1);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="112.04738"
        y="487.13766"
        id="text4441"
@@ -185,7 +185,7 @@
          y="487.13766">WRITE_ONCE(b, 1);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="255.60869"
        y="297.29346"
        id="text4445"
@@ -196,7 +196,7 @@
          y="297.29346">r1 = READ_ONCE(a);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="255.14423"
        y="554.61786"
        id="text4449"
@@ -207,7 +207,7 @@
          y="554.61786">WRITE_ONCE(c, 1);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.10254"
        y="370.71124"
        id="text4453"
@@ -218,7 +218,7 @@
          y="370.71124">WRITE_ONCE(d, 1);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.10254"
        y="572.13617"
        id="text4457"
@@ -229,7 +229,7 @@
          y="572.13617">r2 = READ_ONCE(c);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="112.08231"
        y="213.91006"
        id="text4461"
@@ -240,7 +240,7 @@
          y="213.91006">thread0()</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="252.34512"
        y="213.91006"
        id="text4461-6"
@@ -251,7 +251,7 @@
          y="213.91006">thread1()</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.42557"
        y="213.91006"
        id="text4461-2"
@@ -281,7 +281,7 @@
        sodipodi:nodetypes="cc" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="111.75929"
        y="251.53981"
        id="text4429-8"
@@ -292,7 +292,7 @@
          y="251.53981">rcu_read_lock();</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.10254"
        y="353.91556"
        id="text4429-8-9"
@@ -303,7 +303,7 @@
          y="353.91556">rcu_read_lock();</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="396.10254"
        y="587.40289"
        id="text4429-8-9-3"
@@ -314,7 +314,7 @@
          y="587.40289">rcu_read_unlock();</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="111.75929"
        y="501.15311"
        id="text4429-8-9-3-1"
@@ -331,7 +331,7 @@
        sodipodi:nodetypes="cc" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="394.94427"
        y="331.66351"
        id="text4648"
@@ -355,7 +355,7 @@
        sodipodi:open="true" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="112.11968"
        y="523.77856"
        id="text4648-4"
@@ -392,7 +392,7 @@
        sodipodi:open="true" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="254.85066"
        y="336.96619"
        id="text4648-4-3"
@@ -421,7 +421,7 @@
          id="text2993-7"
          y="-261.66608"
          x="440.12299"
-         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
          xml:space="preserve"
          transform="matrix(0,1,-1,0,0,0)"><tspan
            y="-261.66608"
@@ -453,7 +453,7 @@
     </g>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="541.70508"
        y="387.6217"
        id="text4445-0"
@@ -464,7 +464,7 @@
          y="387.6217">r3 = READ_ONCE(d);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="541.2406"
        y="646.94611"
        id="text4449-6"
@@ -488,7 +488,7 @@
        sodipodi:open="true" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="540.94702"
        y="427.29443"
        id="text4648-4-3-1"
@@ -499,7 +499,7 @@
          y="427.29443">QS</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="686.27747"
        y="461.83929"
        id="text4453-7"
@@ -510,7 +510,7 @@
          y="461.83929">r4 = READ_ONCE(b);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="686.27747"
        y="669.26422"
        id="text4457-9"
@@ -521,7 +521,7 @@
          y="669.26422">r5 = READ_ONCE(e);</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="686.27747"
        y="445.04358"
        id="text4429-8-9-33"
@@ -532,7 +532,7 @@
          y="445.04358">rcu_read_lock();</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="686.27747"
        y="684.53094"
        id="text4429-8-9-3-8"
@@ -543,7 +543,7 @@
          y="684.53094">rcu_read_unlock();</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="685.11914"
        y="422.79153"
        id="text4648-9"
@@ -567,7 +567,7 @@
        sodipodi:open="true" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="397.85934"
        y="609.59003"
        id="text4648-5"
@@ -591,7 +591,7 @@
        sodipodi:open="true" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="256.75986"
        y="586.99133"
        id="text4648-5-2"
@@ -615,7 +615,7 @@
        sodipodi:open="true" />
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="546.22791"
        y="213.91006"
        id="text4461-2-5"
@@ -626,7 +626,7 @@
          y="213.91006">thread3()</tspan></text>
     <text
        xml:space="preserve"
-       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
+       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
        x="684.00067"
        y="213.91006"
        id="text4461-2-1"

base-commit: 2fef638a161f05fe94df7c8f7b52721131a83cde
-- 
2.17.1

