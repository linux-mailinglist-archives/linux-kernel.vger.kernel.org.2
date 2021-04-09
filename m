Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA435910C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 02:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhDIAt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 20:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhDIAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 20:49:56 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D9C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 17:49:42 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id j26so4163634iog.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qC3DsFQp9eza9W51XDdceHkd/83cTsDDXTbOAJ2cHK8=;
        b=gA6fWvlZ9g0kFHdw3sUl6sZ5HCwFuvplDoXb1X9MAxOoy2KevrNJL56W/XyAmFztfJ
         HwFikiUchh0N8FHDQBARJaIgVKH+mr8S/3RhQmNLYcwNtXILFpoJKLhBRZmkkJ2RPvZr
         PMlq78+0qgvQCq0ZrKxdpQlNzRHyVPlJYUUhCMzcQnfOcvwxkPdWl5wRTr3umy9vvNIj
         i6s3lUIB7JXrO50wvIkANmN0XNrgsDv0ejYn10xOZYdTwAPNhZuPovJD0SCg627z1KFF
         +fR5jvEq7yseIt/WYGPSFEgLVOYb04QW0XbmOiMheeRGSbGn7eX9IWtCtnTux1wsr4BT
         fXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qC3DsFQp9eza9W51XDdceHkd/83cTsDDXTbOAJ2cHK8=;
        b=hvQRG88ove6u/Dbk3yjKDIL208NjHDXcNvq4kmi64PJm1tmUdHjjlfdmk0ERG81zod
         RT9LjkfuqpuAEL6lIcGW5TJNCJDpKjquDaQbKWp12sGXtu54dApCXwbrUyXxMyrZx2Dt
         r3MLuwhul6r5EdQgcTPMADLb4OlGCPEVc8AbOPZj7fgV9O5JRXgNYnyJSxbTzGeBoZ2B
         V7xsCkoTKUtWdAO74r/eANoua3z3Os0KG96eM9ItyYmj6Yt7X/NbsiMQcY/NJFZJgtv+
         DAq4YgBwg2Tfw29xGDKLFp2HAiow1zPh5820kPCfEuT3h/opgFdRw08S8OUAHm1hvzXH
         5q1A==
X-Gm-Message-State: AOAM532Kv27Q89N82PFxVPll5eNrcwaO7i6DVPSTRflj6nWj1gxuT5Qz
        zfGHAxEBDDEGMUSIVE2awLU/em2a21KT8rTuircMPVboe04=
X-Google-Smtp-Source: ABdhPJzCalwDwg9TE14hNaIpwcTDIA0jJkJYUNT7QPQhc+EbmWpQVMp/HBrzERN2R3BkhM8vCNRucMh7R+giCeKnIVk=
X-Received: by 2002:a02:ca13:: with SMTP id i19mr11782983jak.47.1617929381986;
 Thu, 08 Apr 2021 17:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210402014438.1721086-1-srutherford@google.com> <18c68409-5fcf-2f2c-61f2-e8e52aab277e@amd.com>
In-Reply-To: <18c68409-5fcf-2f2c-61f2-e8e52aab277e@amd.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Thu, 8 Apr 2021 17:49:05 -0700
Message-ID: <CABayD+fi2Q4nqNGiL8nuO3HfqZbq5PoEgimwWtwjX_o0nANFEQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Add support for KVM_SEV_SEND_CANCEL command
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 3:27 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
>
> On 4/1/21 8:44 PM, Steve Rutherford wrote:
> > After completion of SEND_START, but before SEND_FINISH, the source VMM can
> > issue the SEND_CANCEL command to stop a migration. This is necessary so
> > that a cancelled migration can restart with a new target later.
> >
> > Signed-off-by: Steve Rutherford <srutherford@google.com>
> > ---
> >  .../virt/kvm/amd-memory-encryption.rst        |  9 +++++++
> >  arch/x86/kvm/svm/sev.c                        | 24 +++++++++++++++++++
> >  include/linux/psp-sev.h                       | 10 ++++++++
> >  include/uapi/linux/kvm.h                      |  2 ++
> >  4 files changed, 45 insertions(+)
>
>
> Can we add a new case statement in sev_cmd_buffer_len()
> [drivers/crypto/ccp/sev-dev.c] for this command ? I understand that the
> command just contains the handle. I have found dyndbg very helpful. If
> the command is not added in the sev_cmd_buffer_len() then we don't dump
> the command buffer.
>
> With that fixed.
>
> Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>

Nice catch, will follow-up shortly.


Steve
