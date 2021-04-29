Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A59536EF64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbhD2SSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhD2SSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:18:06 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3EBC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:17:19 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 10-20020ac8594a0000b02901b9f6ae286fso19739272qtz.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MpCPitAmm122m51pt+u1hw6SH26S0A84lD3VDR+ZTJQ=;
        b=YPwdYInivlpgPtX9RFoJzjPFD7w4vI51Ydzy31qY8cLpsYPdtkzyLID3WrY6w2ZSjf
         wtpba9FcQp4IJfqHLh3G9QtskdywnrgdhlE+uqw4DWnQUri7qDgpe/CrDRGVtBpsNTNS
         Vhm+8zfE+lwhJHieGHaZZfvnXem6jDM37btbYevWRBiAEKDSQmzb8r++Bc5hNdoDEpqf
         Nxj4eCw23sPHRWjNcFUywTLM2v+ElstFGKxBWJs9dulAJCRswqjq1vydO6629GNb0o/F
         zJ3LSqstamKb5b6S6lXw+vhFJTR+lCqkbhKRDCZhP8TWLAQ2W6Rt2VVMcBopCN/0+lol
         XsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MpCPitAmm122m51pt+u1hw6SH26S0A84lD3VDR+ZTJQ=;
        b=q1Ey840PngV2lMUquLrG2lFbhjuGhPEs3EEti3fFCRDwKrkAY7v3v3GF/jBmOIIVGj
         hxraM+JjG9Zzp6DZOrrhOJBIoGvzGElONK7iQcFEHDC3Q1HyF/tmD06KM+gJUMPOhPeL
         9euqxJnyeOsXPIxQy2v+Q9GYlNZfJJ7M8pEcVrQu9hm4Mx8E4Dy9fBRRvkr3Bip/z1wx
         WQQh1huYk6nfsJR4fh18qGJLRdf+alXahLheH18tOTlftJf1+EcnR+5I7qy7g5IrEF3x
         m4YCZLuiCc/oIoih8DfeCmKke1fuLxBuOEqaZoB4gCWzlxHoE/DYu4TBsxCUo/7fXekW
         ohnA==
X-Gm-Message-State: AOAM533hPNL0tdNA4qnBAairsp37Q463noxCYo1DaGCoUkzKUUxzF+NF
        DFHa+LK+8helgsxK4grxzG7asfkffZ+11rl32rI=
X-Google-Smtp-Source: ABdhPJxPpcshZ7se177uUXlIRLBuOOybyxz8var/6cubB7OZ1tEPUACxt7sVCqaIhIPAZXBeGtSJ5qcyqec0VykPb6I=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:8d4f:4280:c6de:de17])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:486:: with SMTP id
 ay6mr1283593qvb.18.1619720238157; Thu, 29 Apr 2021 11:17:18 -0700 (PDT)
Date:   Thu, 29 Apr 2021 11:17:16 -0700
In-Reply-To: <20210429150940.3256656-1-arnd@kernel.org>
Message-Id: <20210429181716.2409874-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210429150940.3256656-1-arnd@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: Re: [PATCH] smp: fix smp_call_function_single_async prototype
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     arnd@kernel.org
Cc:     arnd@arndb.de, axboe@kernel.dk, bp@suse.de, eric.dumazet@gmail.com,
        jgross@suse.com, jiancai@google.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mpe@ellerman.id.au, peterz@infradead.org,
        tglx@linutronix.de, ying.huang@intel.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(replying manually to
https://lore.kernel.org/lkml/20210429150940.3256656-1-arnd@kernel.org/)

Thanks for the patch; with this applied I observe the following new warnings
though (for x86_64 defconfig; make LLVM=1 LLVM_IAS=1 -j72)

kernel/smp.c:515:19: warning: passing 8-byte aligned argument to 32-byte
aligned parameter 1 of 'csd_lock_record' may result in an unaligned pointer
access [-Walign-mismatch]
                csd_lock_record(csd);
                                ^
kernel/smp.c:516:14: warning: passing 8-byte aligned argument to 32-byte
aligned parameter 1 of 'csd_unlock' may result in an unaligned pointer access
[-Walign-mismatch]
                csd_unlock(csd);
                           ^
kernel/smp.c:525:14: warning: passing 8-byte aligned argument to 32-byte
aligned parameter 1 of 'csd_unlock' may result in an unaligned pointer access
[-Walign-mismatch]
                csd_unlock(csd);
                           ^
