Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970B73C887D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhGNQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhGNQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:18:14 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693CCC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:15:22 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so3074033ott.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcJqFhnBs3c+2NPpPUvwxuNTpO21d8YHEIVzJJluXGY=;
        b=YP+2hyEJXigWYVj+xlaBdB8e4G12hxNTLrNTHcYTZdZrF+D1pNTQaBJwPQ6mqZuGfs
         zUI1aZJuX17W/usN9r4dvlPsw+PUurvljbKBGA1ZafhYTd7jlHpD8jiiw9ZfjFLSiboI
         GBtyE8ux36bNIB9Eae2kD35gPKM7kyfgByzJ2NSGXOyIJ1tgdK99vaGHr/Dzz34ThLju
         cv+vw6QKCQbcp7qqV7uV+75Fom+To2QDW9Ns0sz/JV99tczNjI+wnLZe9YTLc9kCPtcx
         eJo2kbDRlyMMlyk4ed91ed/ImPVYEvbQmfsfvJhtP9JJ718MPqh9O7N0KY3diSYfjXes
         eq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcJqFhnBs3c+2NPpPUvwxuNTpO21d8YHEIVzJJluXGY=;
        b=P2TUtW1YMWF/5bxcFpd/SOBsmdb2axs5AZRvKi7Exy0grun6FgCFsaWJEOZmKdUFns
         dQamdvxjDuiwsTikJVKGs5Aeb7bnO1JLWEEMpP0dI+njN2gTDuRKqS18X0Z58LWMHWi/
         trzptojevHbiOLu8atmmZDDBa3cWmXKHviqYVKZDixF6yUz+YmklYUF2nths7HLD3Smg
         qFFdrDjHv8Jhxe7YsFVVcfOqPCuLhhjVFYZmlGkA99qUyQMik3/lxp3tquvx9JLt3Ax3
         NDHSz9yXc5FnaC0/GQpq9Y5GFemePFS0HiJQ0xDqTroMd3LqjDcviRY7LcYwd2h4KDJj
         5OtA==
X-Gm-Message-State: AOAM531g+rs84K7IgIoubzH85KAZNyirctI3y422LocsXGHMfMHQe0u7
        PXIJpc+bB42cKYTF1qMrMwiZBQYYwp5AEQuvW5k6Aw==
X-Google-Smtp-Source: ABdhPJxEFIMS7J1VqoMpDvD+RYJFHirbgxfFTbTCcHZoXrz+J2T1sP9siadEw3dTCtiCVduj1kZAJsN/vuqiAfRvo7c=
X-Received: by 2002:a9d:550e:: with SMTP id l14mr9050040oth.241.1626279321498;
 Wed, 14 Jul 2021 09:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <1625825111-6604-1-git-send-email-weijiang.yang@intel.com>
 <1625825111-6604-7-git-send-email-weijiang.yang@intel.com>
 <CALMp9eQEs9pUyy1PpwLPG0_PtF07tR2Opw+1b=w4-knOwYPvvg@mail.gmail.com>
 <CALMp9eQ+9czB0ayBFR3-nW-ynKuH0v9uHAGeV4wgkXYJMSs1=w@mail.gmail.com>
 <20210712095305.GE12162@intel.com> <d73eb316-4e09-a924-5f60-e3778db91df4@gmail.com>
 <CALMp9eQmK+asv7fXeUpF2UiRKL7VmZx44HMGj67aSqm0k9nKVg@mail.gmail.com>
 <CALMp9eSWDmWerj5CaxRyMiNqnBf1akHHaWV2Cfq_66Xjg-0MEw@mail.gmail.com>
 <12a3e8e4-3183-9917-c9d5-59ab257b8fd3@gmail.com> <CALMp9eROgWVBe1NuqD46xbgXHedgAFW1EMFX5zW-_Ee5enHmnw@mail.gmail.com>
 <cb4c1daa-f7a3-4f9c-fcdd-6a91e0dbcab4@gmail.com>
In-Reply-To: <cb4c1daa-f7a3-4f9c-fcdd-6a91e0dbcab4@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 14 Jul 2021 09:15:10 -0700
Message-ID: <CALMp9eQF2ZAs0qNfmjpXAUNwiR8ESfUiA8AjA3uPbDMeX_Aotw@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] KVM: x86/vmx: Save/Restore host MSR_ARCH_LBR_CTL state
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        seanjc@google.com, vkuznets@redhat.com, wei.w.wang@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 6:33 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> On 14/7/2021 1:00 am, Jim Mattson wrote:

> > We have no such concept in our user space. Features that are not
> > migratable should clearly be identified as such by an appropriate KVM
> > API. At present, I don't believe there is such an API.
>
> I couldn't agree with you more on this point.

Maybe KVM_GET_SUPPORTED_CPUID could be made more useful if it took an
argument, such as 'MAX', 'MIGRATABLE', etc.

> We do have a code gap to make Arch LBR migratable for any KVM user.

Right. My point is that the feature as architected appears to be
migratable. Therefore, it would be reasonable for userspace to assume
that any KVM implementation that claims to support the feature (via
KVM_GET_SUPPORTED_CPUID) should support it in a fully migratable way
(i.e. if the hardware supports the guest LBR depth, then it should be
able to run the VM, without loss of functionality).
