Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B3E387BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbhEROsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhEROsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:48:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6899C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:47:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y14so8457920wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dB+ePFTvUsUaS+lArpYnJP5LI9VI+hSBypIe+Bx+BVk=;
        b=X1DM7UnsDMsUdjsqO7UHHqWdYQPerdamEtCvZyxQxdp7yTglA0kVecDXT/jbTcgQwe
         krroyzjuA5FuSKs1epriqJ49tmgp1dJABl1j96KtGeUOWeiB30AjX3lYJGiF8TtBF/Z6
         kEaKdXb1SPfsWY9nKoLNW/u3HXjCsQvasxA2L6khtv1SqYBykwcZr3yYD7QiyfO6Qbo9
         JirRgFWllForsxQFKAhrMrkboFZvBpxM/1GEsMv4xl0px/FuI4B0L/mq26nWhJutaZ74
         1xhI9mJ8//dpZVCJSUDWO6ygHzR8h4YCsWSbeLCN8w2b+NNWUBXVwMSHLm7nTft9U+fU
         oA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dB+ePFTvUsUaS+lArpYnJP5LI9VI+hSBypIe+Bx+BVk=;
        b=hqQRHBcPK1Ldv2gSmm9M/0azCFeq2srR89hWf8KojLxYffNJRzv86y12a1hhwWmui/
         /T0G/UuSEWwvPDeIscu28Etdqy6g76TGhy+dhZlxWr0K3EYi0kxscEjBvknp+2RzkVIK
         2aA2rDjHC+SSE/Ghf1zqE8EKiUubKA4fpwLPbm2BNpyLyJ9+wWrQuvZXQqhiiFleR/EI
         TXF0n2yF4g2Dy2LnHvISooTVM92d9Tr+UFxn9hNGsIraU7Oj8JvtMv4gDOLfRp+NNNbs
         f2d75s8LMRH7/QkFMM5uYAiKwWH8SrXtSvZVTxTK1TxwCymmcP7YANY5asp1IOvE8V/h
         sbiw==
X-Gm-Message-State: AOAM532+jhrbXYX/qsyi2NSsEx+I/iqQvG75WwigYvIS84xJ+8wWCXfZ
        43yiAwEeMPG3W8JOsxuRcPVxQA==
X-Google-Smtp-Source: ABdhPJxH+tWw0XX3qtZokWWh3OOlpCscv0PWh+9j1Afl8eVfSzPZdbs69GNg2ugb0h52GYgReQGFkA==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr7823812wrp.28.1621349251362;
        Tue, 18 May 2021 07:47:31 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:d372:a165:d598:6e85])
        by smtp.gmail.com with ESMTPSA id z3sm2134574wrq.42.2021.05.18.07.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:47:30 -0700 (PDT)
Date:   Tue, 18 May 2021 16:47:25 +0200
From:   Marco Elver <elver@google.com>
To:     syzbot <syzbot+9d90dad32dd9727ed084@syzkaller.appspotmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] KFENCE: use-after-free in kmem_cache_destroy
Message-ID: <YKPTfbqFcWijSB46@elver.google.com>
References: <0000000000003f654905c168b09d@google.com>
 <CACT4Y+Zi_femntmu0qtUz1q1gbxs-0VNrLUULzY1bd+hrBngHA@mail.gmail.com>
 <CANpmjNPAKrwrqnsJHMmZTFZwZoTCPEj_DHZ1ecgMci3Pd8JjEg@mail.gmail.com>
 <8ca64b7f-efd4-0d4a-3235-0b2a4755d8d6@kernel.org>
 <CANpmjNOXXt6HAYw9k-hwZvquTQW58hpbN4yzuujbwOuD3Q2p4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOXXt6HAYw9k-hwZvquTQW58hpbN4yzuujbwOuD3Q2p4g@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[-Cc most to avoid spam]

> > https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=dev&id=cad83c968c2ebe97905f900326988ed37146c347
> 
> Ah, nice, thank you!
> I wasn't sure if there had already been a fix, so I just wanted to follow up.

Let's try again without the line break that GMail introduces...

#syz fix: f2fs: fix to avoid racing on fsync_entry_slab by multi filesystem instances
