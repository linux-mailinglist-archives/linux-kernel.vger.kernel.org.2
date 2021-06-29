Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0964A3B772A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhF2R2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhF2R2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:28:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66105C061787
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:25:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so2348369wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4rcOVVwqYzrfvJqP6sXbFWXwM6Z2TrB7WrFrPkDDqGA=;
        b=tQ51S8Kof61wqiRbv0grpyzdbWeuc/S+Bg1uYF5xOACeQ+1fYNzZ3AcY9ElWSopddp
         oI1dTHV2er73ZzwoEF+UKUBes4YCUZGdUxgvdhLZ2BnJfnJ8HDPx3rlwhEOInQKISgJd
         e5M05Zy6M50UhErIWrL6xGay3M03KdJFCZ1FR6eFujN1hX2jHMP4ezmwXZYoMXiJ/BBs
         UAt5jzetr9Onf2CJunq2WLgvXQfnXGBEx81qMoKVqZ2lhYS231nnSm8hihpFFHsjjpm0
         hY5JBN6MPTuHDmchXYBjxFhkBk3s6HrLe6BPW4pvkqKomorvnJibo6Zl+SA+xgIlYQHU
         Wyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rcOVVwqYzrfvJqP6sXbFWXwM6Z2TrB7WrFrPkDDqGA=;
        b=J9WQ2rbLql8cEbkRvWoWDbbUeiEf8Oy8kya9SXvhiURgPr6Sgbd6kdW0fRay11ApkS
         SPN6mL+UovchbYUD6n9+Ww/wkInbVjuJPoLeTs5/xCdIBRYxY69D0KtnHr7xhPy5Eq6d
         8y9GPdDHdAt9eyah7cKafaynGA5MLZOIVakLrNRszGNTTxRmPcG7S7BV/qLzusfA+g3L
         20ZEp5Yr2KtEnlVVG9wEwWY5+mu1+z76skowy66Qi9v9DEfVrcRPY5sj5+ME0Ac6OoKd
         goZIv2kO21SPiQ3wsAnrjjEfjZykyyqm3sTPz6p4/Qn9vcP3OF1RU6jox4daDCMTJHk1
         Z1Mg==
X-Gm-Message-State: AOAM532DdPWJvaXy3O58XngjtbeCvv8K07ogbrMHrixssiqk5Ccptpyi
        5+HLHbpY2JljkoN7Gka0coPbWV2QKqI/fg==
X-Google-Smtp-Source: ABdhPJyKTvbwWVXskDi5IYMNZnQmU0AHkmqxtcbpyGtkRUHmCAcqBqDVrqAyt013P6EeUtxynxeuFQ==
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr33667837wma.96.1624987530016;
        Tue, 29 Jun 2021 10:25:30 -0700 (PDT)
Received: from localhost.localdomain (91-167-148-192.subs.proxad.net. [91.167.148.192])
        by smtp.gmail.com with ESMTPSA id g17sm14359173wrw.31.2021.06.29.10.25.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 10:25:29 -0700 (PDT)
From:   Greg Depoire--Ferrer <greg.depoire@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1 and rootflags
Date:   Tue, 29 Jun 2021 19:20:53 +0200
Message-Id: <20210629172053.1709-1-greg.depoire@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <200308131944.h7DJiMpS001539@turing-police.cc.vt.edu>
References: <200308131944.h7DJiMpS001539@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I configure my kernel to boot without an initrd, with "rw root=PARTUUID=...
rootflags=...". I would like the kernel to mount my root partition with
MS_NOATIME but it is currently not possible without using an initrd that
remounts the root partition with the new flags, as was described in this
thread.

Because the kernel already supports setting filesystem dependent flags, I think
it would make sense for it to also support setting filesystem independent flags.
Also, there is the issue of flags that can't be reset later by initrd (see the
previous messages).

In reply to this message, there is a patch that implements what was suggested,
adding a 'rootopts=' parameter that takes a bitmap value for the mount flags.

It's my first time using a mailing list. I'm not sure if you're supposed to
reply to very old messages like this one or create a new thread instead. Sorry
if I did something wrong.
