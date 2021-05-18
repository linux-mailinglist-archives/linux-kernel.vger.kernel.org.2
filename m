Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A867387B70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhEROnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhEROnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:43:00 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CF5C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:41:42 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so8801205otc.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wL+2v0M/vNbXileTKiIKiGd46p3pZGmfkxwPNchYXI=;
        b=HZP+u1nq3armhATM7vYlr3S898E9NMIii8LPHjXGz/dtwZmIfrtiFEhY++b3BnBMDJ
         s2A1AeTwm8LVFtpj8+UaJp3LAdgbYELyc8I/Y6V6rv/u4EQM276LDbA4gXxdIIHYh5m4
         5GxpZLksBDL/c3KNFuGsFwMidRO/DbC3/TVS3e0b/eNoyP4upezS7l5VYOg4X4VZ6aVW
         hNEVeaZhuNP2kScEJChpSDV9+5b+YjnBxcjQLcNVuVpdgPO4En02T0hPxj3teOuA+vqB
         yZYjdT906dhvKZ+G+m1R0fO1nw0GLLfE5AwtzJqJZAO8Qu2t70L2zz+eiXew8KNV7Kqs
         iYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wL+2v0M/vNbXileTKiIKiGd46p3pZGmfkxwPNchYXI=;
        b=UijTq9JC705xVRqEO7a3+7kQmnOeyPaqyTg4vF6VpnL0YOTjPfXzoAFWzKpPhhM5oi
         6Wta95QW+SnR33qf17ubCkdVCqZpGnkjfolx681ocjkJJSAOQxJ0Dp/ULorov5u8qDTN
         wAbhSV2NVVBDY/Zh/7+XO3JN22UhSr7fFTv3pEEngG3NXNYw/06w426glewWeDnoN191
         Ov9HDLUO6omXIwzwm+dDFSrjg/kdQQnoUlgZoM/mQ3BjoEp8CGBC7+n2fn+1kK2yzB+A
         l8pj+BDcHl6oVpUwC6qdiGVGCjmKZWePyWsLOAXtkb41kFtvKzxZWqSbPjy2LS7vwFnf
         9Axg==
X-Gm-Message-State: AOAM531RuJ0ysItqSGycwVF6B/PKIiJhZXGhBN+4YqejwCrPlbNVvbCx
        Ux/g9bpT15GH9L+h8t/t+QJK+v6oNleEYEj8tuprnQ==
X-Google-Smtp-Source: ABdhPJwbXsVUEMSFLRzDCWZ0OB5IgIKwbMCKuf5DQIhUZcrxB2BgDidhPVmoxUCxNOGeS24zAGQDQHAtmUwMID0NXCY=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr4608528otn.233.1621348901293;
 Tue, 18 May 2021 07:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003f654905c168b09d@google.com> <CACT4Y+Zi_femntmu0qtUz1q1gbxs-0VNrLUULzY1bd+hrBngHA@mail.gmail.com>
 <CANpmjNPAKrwrqnsJHMmZTFZwZoTCPEj_DHZ1ecgMci3Pd8JjEg@mail.gmail.com> <8ca64b7f-efd4-0d4a-3235-0b2a4755d8d6@kernel.org>
In-Reply-To: <8ca64b7f-efd4-0d4a-3235-0b2a4755d8d6@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 May 2021 16:41:29 +0200
Message-ID: <CANpmjNOXXt6HAYw9k-hwZvquTQW58hpbN4yzuujbwOuD3Q2p4g@mail.gmail.com>
Subject: Re: [syzbot] KFENCE: use-after-free in kmem_cache_destroy
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        Dmitry Vyukov <dvyukov@google.com>, jaegeuk@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        chenyi77@huawei.com, zhuangyi1@huawei.com,
        wangxiaojun11@huawei.com, stummala@codeaurora.org,
        syzbot <syzbot+9d90dad32dd9727ed084@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 at 16:26, Chao Yu <chao@kernel.org> wrote:
> Hi Macro,
>
> I've figured out a patch for this issue.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=dev&id=cad83c968c2ebe97905f900326988ed37146c347

Ah, nice, thank you!
I wasn't sure if there had already been a fix, so I just wanted to follow up.

#syz fix: f2fs: fix to avoid racing on fsync_entry_slab by multi
filesystem instances

Thanks,
-- Marco
