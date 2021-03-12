Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E5C3391C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhCLPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhCLPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:44:10 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490AFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:44:10 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n9so15159516pgi.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+vKX0oejrAAjAn6+pNcjfY0BoTxk90dWvOiiFx6GgM=;
        b=uk3UMsWUnARyCjk/rZjQNy4KOAdhCfP9AAkqlCQac4QuUFovoZJ50xMOx/uFlQW7gW
         f3MOT2e6wjuzmnoEZdnBHL3I5WQJV4A+eW5uwTzJ++vYIITQpMpRwJXl0LeDYUtwlz91
         O0LCMitIfJIcG1vpDjL/CkHtCC/G04ZsKSYCQZH4rt8SjPPa71L+ett9DeXLD7bffHmX
         TRNKFHcRUSftMwkalYqLqwXTcyd3GRf8dIVhY8N/NKeCnrnlVQDsYQuWqb8EO6uvXNuz
         6K22iQADcVO9VrGrV+gTTVldj34jHpjJ13GLWpJLo3FlA4gCdhjAeIjpp4EAQfNs0EuX
         roUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+vKX0oejrAAjAn6+pNcjfY0BoTxk90dWvOiiFx6GgM=;
        b=Z9hIwIVRWI0JNTXuqOhBUzEkze28WFmARNOjHdX0v1Shh4NKAKBHB2vGp1ox7A58tq
         kn2ffd17FNmpoVloerkL6u4PeUqnw/zl+e+6+X1jDNx0UgcOYcacF7pV06w8GUMiWH0Q
         O8nyQKsffuwN5+DT5Bg9+Y+ed+k82WpDosqFDs6D4TP9Yj8N4fN5BmAEwi4IOlz7Z3Zg
         BV9kglUY38bXg2ttaVD1oRxvMg4yBmMPNLqMd641mxtvVeq8ksQyi8MTna7ITCyIqYHK
         Li+j+8e6hzl+1yHpl4G3usyqWPvD+KsZjJWdIpL3lSuq5iOK5cYVhKXEa2hVQZLb33im
         wGDg==
X-Gm-Message-State: AOAM5338wgZlU2ZTF3oY6umrsq6RtMoVgtABSibPoF64eDxWf5xVPtB9
        AlmKETUgOdKoiawUEi0Yx4U=
X-Google-Smtp-Source: ABdhPJzeoZ/erFaGMu2OCf881BsEso5df4Pi9Key45/kBq8Iwtf1xkg7+6sIU1Gx3FE708swm/pccg==
X-Received: by 2002:a63:445e:: with SMTP id t30mr10169360pgk.147.1615563849895;
        Fri, 12 Mar 2021 07:44:09 -0800 (PST)
Received: from ThinkCentre-M83.wg.ducheng.me ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id s22sm2652057pjs.42.2021.03.12.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:44:09 -0800 (PST)
From:   Du Cheng <ducheng2@gmail.com>
To:     yildirim.fatih@gmail.com
Cc:     gregkh@linuxfoundation.org, h.shahbazi.git@gmail.com,
        linux-kernel@vger.kernel.org, Du Cheng <ducheng2@gmail.com>
Subject: [PATCH] drivers: tty: vt: vt.c: fix NULL dereference crash
Date:   Fri, 12 Mar 2021 23:43:58 +0800
Message-Id: <20210312154358.6941-1-ducheng2@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <14878df31817f11528c9326f2855819bcf782721.camel@gmail.com>
References: <14878df31817f11528c9326f2855819bcf782721.camel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fatih,
I just found out that the section [Patch testing requests] on
https://syzkaller.appspot.com/bug?id=defb47bf56e1c14d5687280c7bb91ce7b608b94b,
indicates that you did not attach the patch when sending email to syzbot. syzbot
was simply testing the vallina upstream with repro.c, so it failed as expected.

Anyway, I resent the test email *with the patch* from Hassan to syzbot, and
let's see the result.

Regards,
Du Cheng

