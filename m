Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14236C95F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhD0QZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhD0QTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:19:24 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E05C061761
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:18:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id q4so16177418qtn.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gDBOYGAKVRv8KzMlYVFHBR8Aw08s7JEGf5T5p5wx/2c=;
        b=atGxqJEdRtFL/SAI1ZFCnzw7UlHdSa5UsShjOIWgx44ubv0y7Usfg9gJxvB8f0a88U
         xwO1u/9WJnaN4n0aPwpMVlsWr5QPb4u8dUTKu+NW3BDfQEU081ZNxtK0tWLdJ7x7vM41
         CN87CeSM+rsbAov3OPBQziDgqDESV+UUbAGMuHLfO/637jJviwi1r43a5U+iUX5TIceD
         NzQ5BPT/qyO9Ro+HhpWDFcHgnhT/sbC+fLvZH8ykyqSA32NYl+6PUuBec59rnt+DOkvw
         7FYDmbfS0yYvqZXXtS/b0O2ntrW01q5rE4HohoUociPw5412F5Z4/sKyHgxrf9g0y8BS
         vJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gDBOYGAKVRv8KzMlYVFHBR8Aw08s7JEGf5T5p5wx/2c=;
        b=ucDK9I61TDZoN69FwOaL7VKKvM+RZHFVgJwabRrnQLsviXPbCmSvjT4yWG9XSPDUpw
         YF1EyP+56PzYx57QZfXPL62XWV4BMzya5lQMHXczUYJ1+bK4+uba1CcqioINS8oQbzyg
         lqQwh3XsWa2pM+dFAqgbZlnfxZCGKwvtOMzacDxpTbET7tPb4JC9c4NbvQC4Tlz5QHen
         vfyuR2Pp3cKu7cOUkoZNl+fvYwToEYFRXzGMj4J8M3mrLk19i2TTe/GZAQylOFEAx3fr
         RQHZTPCEPpHNhtR4D/b/bMQlTQHNOaVyIRfYyyBrB/bxvw2AHQSWuxZEADzN+E0aSGrA
         ZOCg==
X-Gm-Message-State: AOAM5322JyAakvx3uP2CanzWi0KFoDY8QkTCVrnrUvB6IoM+eAZVUGFq
        Djm3hXogko0zENSDC0/aLr/ztG5Z1hSXxTp6eeRrXkcwHtVVww==
X-Google-Smtp-Source: ABdhPJw2VmKFmBVcevnWb5iFeJs6l9y7Nugi1SFY33SG7r//xw4EiNAG2STuL4miGfQsOvODB36HJ6e11EkemFVq+KM=
X-Received: by 2002:ac8:4e53:: with SMTP id e19mr22308814qtw.248.1619540295360;
 Tue, 27 Apr 2021 09:18:15 -0700 (PDT)
MIME-Version: 1.0
From:   Josef <josef.grieb@gmail.com>
Date:   Tue, 27 Apr 2021 18:18:04 +0200
Message-ID: <CAAss7+pgO1W6CBGRidmmXBZ1shYWNHJ8K=fmY8iXCdxXap9U9w@mail.gmail.com>
Subject: gdb python script lx command error
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the lx commands(like lx-symbols) were failing in gdb with the following error:
loading vmlinux
Python Exception <class 'gdb.MemoryError'> Cannot access memory at
address 0xffffffff828da7a0:
Error occurred in Python: Cannot access memory at address 0xffffffff828da7a0

the python script is loaded in gdb
(/home/jo/linux-5.12/vmlinux-gdb.py) the CONFIG_RANDOMIZE_BASE is
disabled and CONFIG_FRAME_POINTER is enabled

kernel config:
https://gist.githubusercontent.com/1Jo1/0d455013f31bb42ec68715ac7ff10db7/raw/7501b404abdfb6949d13df97216f4cace3192f2e/qemu-kernel-gdb-debugging

I followed these instructions
https://www.kernel.org/doc/html/latest/dev-tools/gdb-kernel-debugging.html

I have the same issue with older kernels, probably I missed something?

-- 
Josef
