Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4273771A2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhEHMWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 08:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhEHMWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 08:22:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940BC061574;
        Sat,  8 May 2021 05:21:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bf4so13354838edb.11;
        Sat, 08 May 2021 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uifGGALbd64vKa+6VH1gTKAaHjCszIAApvtYp7NtBKI=;
        b=AYh2Wxg2uElTEfhkThiAV6IK3p5C3DFx6wX+5Yv5xiQwazloMMCHSI5pXFcOKFkJdh
         PzDlbeWnBLwfGQJcsfCFOqvnsOifNeP3gPKEbwTJi2nmtf15NxpjiIu3m5aeGzrVcOMi
         JsBoMO1TSupwEPWIDwv/C8Umuaq2MDFFDReqTTqm7lLf9TVOexT8Pf/XYrvW0t0rWF/+
         YSSlVPxOAqvgUBcxb7SpVoLkxHUYAZvBBQYIWJKxfbcmqu4Okg1qXVVI/Iforg/xtLUh
         DeU7bXxn2HU3vr76Z+GZq2hfz5PaKBVYWzl4AuA7H1W2HdROPcKpo9SXbHV3lD3gJMPq
         TrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=uifGGALbd64vKa+6VH1gTKAaHjCszIAApvtYp7NtBKI=;
        b=LyEKb1meOwBVpis34wNkK50z3KGOQNrbTRTpSA5JOfwRt9YVqPZLNLitQZj1nAs5QK
         VTFSKnAHu7Ts5MOz1NuUVtM2bzHXOWAdBnV5/MFjGp/Utzpo/yPIS7QzV/JEj3B9+Q2E
         +G58d9WOLQov96atLqfmGWTldw7cAt9gZKI0TxryxI6ng6B3TM49eO4RQ9TR2ecRzbyk
         HgufJ/B1UdPsqubV6L689vC9ZfFxvXMW7O5jgJ/7iF3u49HNNs0ZJ+kMuH+aWS3AbIyD
         5iG/m7BmRwNonXpLayI3VgFg7cIRvXGkYLHAKo4O9iyzXCMuSNiReEa3fotL6AjWv/YI
         X1RA==
X-Gm-Message-State: AOAM53186ysBvZBKUqEDJqryJSVD2ewAABYjZzg2S5LewNfu+nGlp0xT
        IxYIYtjy3vHI31kww9gbZfpqPcTBjha2qOAP
X-Google-Smtp-Source: ABdhPJwuVxzwGCg1Z5LEkNxpcw/AcLUHyMFpJaqtKjpfvdG7hm9f+m15qt3b0XG4LAfli62iPZnDeg==
X-Received: by 2002:aa7:c510:: with SMTP id o16mr17552331edq.310.1620476493325;
        Sat, 08 May 2021 05:21:33 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id s2sm6408210edu.89.2021.05.08.05.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 05:21:32 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 8 May 2021 14:21:31 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     coproscefalo@gmail.com, hdegoede@redhat.com, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: platform/x86: toshiba_haps: Missing newline after debug printing of
 received event
Message-ID: <YJaCS9otCKFOHqJc@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

A verly long time ago in Debian it was reported that in the
toshiba_haps driver, there is a missing newline in the printing of the
recieved events. See https://bugs.debian.org/799193

In baae5f91577a ("platform/x86: toshiba_haps: Change logging level
from info to debug") the logging level was changed from info to debug,
and so less to hit. But looking from the code we still have:

    pr_debug("Received event: 0x%x", event);

in the toshiba_haps_notify function.

Regards,
Salvatore
