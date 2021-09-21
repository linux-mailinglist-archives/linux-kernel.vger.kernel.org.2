Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34857413A20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhIUSiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhIUSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:38:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9303AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:36:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg28so171554edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3cOxiaXTx9Z24g7+I+WmBeZRqCcpFDof8uhshlDK3+s=;
        b=pyVkZOT8drL8yKpXiTdD7UMqtjaRWMOiR7Xrq0cbvrceD2G03xHJ8P2Kx1uxsWD4QO
         krWpJOZDgIrCYVb9qCK/BsHaIGgnN0nc7a5CNYpGlA2aKRz9X7KhdHzCiatlGPcWG3Jz
         lnx7lUwANO5E+8dpmMUAfsEQbJXSjIWg+SeWhXpdZFxUemoUcxcCtWMlbNDzfb414qK6
         W16LGj9LXC3lBD6a6UnrffijMsNd3WZsDXdyzOSrh9Ws2vYML5halzGfqWfiOwmRAfoG
         L2qNvBjJ5HEwXB0vgTFZsri//xmp0Zh03ovSjb8geD2pgdny2cLSYAjw1JL7Bu0JSX+2
         GJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cOxiaXTx9Z24g7+I+WmBeZRqCcpFDof8uhshlDK3+s=;
        b=CGMlL4+M8cNeqks+JMmAPMmMPcMs3sWHMrYe5So1pXc3hKJ2ML2pC3cNpNAR7QHHMG
         WVvPRUasiT52GpuF21zonnDFyO9NCJRs+k/X3ARZhSsA8tgz/W2/oscJQ/jFuCKKWjcT
         FbMDBgryI+70YBTEKXItXRzUt4BKRU1dncMQoFR3ryir3d1tHhzutzNoNllvxDZUZIxz
         rhSj36ItnytXM2C1RQQbNkn5XXy661ZMLtT0k3SFHHpJ2fKth57z8KfbB3/A1vvc2HKE
         NOWUdFX2TJhfWmpZ9NA87QVLsakktFOzjjRiyod9YITk2+aq6YN3BqTU3/5URKHVpW6i
         vvKw==
X-Gm-Message-State: AOAM531ttW6IChw94wd7A7ydRaiGTyAlKAl6A97EAgCxwWPnulWIb+NN
        qra6nVMnJVDpqONSmze4l0U=
X-Google-Smtp-Source: ABdhPJwJ8fdjdbDMPXfJJ96A7n4DqcIP+j08vvmoMHD//l9E+AVT3cWqjb2uPA6U7qd/6DDrp3jsnQ==
X-Received: by 2002:a17:907:98e6:: with SMTP id ke6mr9914004ejc.63.1632249406256;
        Tue, 21 Sep 2021 11:36:46 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id d16sm7827280ejk.39.2021.09.21.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:36:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: r8188eu: Remove mp, a.k.a. manufacturing process, code
Date:   Tue, 21 Sep 2021 20:36:44 +0200
Message-ID: <10957254.UNI85QxBjH@localhost.localdomain>
In-Reply-To: <20210920185437.15652-1-Larry.Finger@lwfinger.net>
References: <20210920185437.15652-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 20, 2021 8:54:37 PM CEST Larry Finger wrote:
> The standard driver contains code used by the factory to evaluate chips
> that have just been manufactured. Such code is indicated by "mp" in
> the variable names, the routine names, and in file names. All of these
> can be deleted.
> 
> In addition to removing nearly 7,000 lines of code, the size of the driver
> is reduced by 63 KB:
>           text    data     bss     dec     hex
> Before  573959   48582   14660  637201   9b911
> After   513530   45894   14660  574084   8c284
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Dear Larry,

It's a great job, a heavyweight, impressive!

Congratulations,

Fabio


