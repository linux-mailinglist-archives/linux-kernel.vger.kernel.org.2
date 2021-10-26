Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2561043B39E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhJZOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:10:40 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47667 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhJZOKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:10:39 -0400
Received: by mail-io1-f72.google.com with SMTP id m8-20020a0566022e8800b005de532f3f54so11410939iow.14
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zAgp8okh6vxIBbMFv4/T2c2F1sXUHx2RabZm01wS4gg=;
        b=w2CfvwiKad9USHSIXwKlh9lxfJ4NmU9YYySJ97EkE6AnHuYLm2/CZ34AZOUTYO6cik
         RCXxJAIueqg8Guu6Ch1n2KiWDbJ3h3li4o3GPqDsjJbud61FEDbjnmlvARH/KVLNaF4o
         XkMSbQCVA1Cuk1UvY4oxK3CpXrdH8myKYjBILd5tLLQHq1w/ZxM5pnQYaJSfBvlOptKt
         HslUy6Gx86MtP8A3PlHwlDMuGuRFXgcxAT7+27zJojZaTgdf+f4dFNI8gU+TVACx5Ozh
         U+qcIgufy9sRhpWkoB8viJNyKkO+gRTx6WquJOtwQ9nk3aCj3MxJ7sECj8X9oQ0IlaWs
         4uhg==
X-Gm-Message-State: AOAM532ikTDQak8b7NLRc9NdQ9sRDEFVXpQUbGyI22KRbBwTk0oGZFJe
        MBM76cimQ28KVGlGMnDPK2fNawvpf7f18iLJ1Sgu23QZ4iB2
X-Google-Smtp-Source: ABdhPJyFhSmTBo5hdBUNPekThTlZiowgDtNE3OQC4K19Ek7DFLCGcEheGhAbWEUtS3K9GR44C6SgG323gRLDIHmrkGqMvf+CaWnh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:: with SMTP id g3mr4063920ile.103.1635257295389;
 Tue, 26 Oct 2021 07:08:15 -0700 (PDT)
Date:   Tue, 26 Oct 2021 07:08:15 -0700
In-Reply-To: <0000000000009e7f6405c60dbe3b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003548bc05cf4202f3@google.com>
Subject: Re: [syzbot] upstream test error: BUG: sleeping function called from
 invalid context in stack_depot_save
From:   syzbot <syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dan.carpenter@oracle.com,
        desmondcheongzx@gmail.com, dvyukov@google.com, hdanton@sina.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
187ad460b841 ("mm/page_alloc: avoid page allocator recursion with pagesets.lock held")
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
