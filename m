Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1AB440DEC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 12:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhJaLRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 07:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhJaLRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 07:17:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B9C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 04:14:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d27so5953519wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=61FvhhsNkrh8p46sRtRayu7rrrGsE6so+sH35+PNfww=;
        b=b+usS8BJfKn+Absvpirb7SiBSJacPaQEjEbGI5s3LhsWIEIXHdP9Yzx1Nqu3+2nbdl
         3DoCBuPoU7H7PfLw+uHkXbGk8U5PygtRXFIfqGL6v9R+p3kJ+yJoNwqo8fsFE/wYesQ4
         MYd0HadUiQPjx2wF4lyroZYqladcTTbYpq20UZH4FvLpmbZiohAErgWL+4OFXSTF3DoN
         8vS/aNWfXR8pptCM/E3/oewqf/hX2JQd9DfNOVd4TtmpaDHfu1FQj58n2JpHWrNaTERV
         BSQCTCPwXjEmmI+1arOyUzFzfH0ZIY1oGA4GICP5Xqdzk8eZTU+T/3Duti1QHQ8K0Z4K
         PIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=61FvhhsNkrh8p46sRtRayu7rrrGsE6so+sH35+PNfww=;
        b=tfPNkB4hS9HlfiWXzTR4TfPdL3L3T1n5JD/5ZVHraem2I508ZmhFMZtzQACBAjM2PN
         PIHtAeW7zgfpQOJeYOJN4nr8+tNyeqDjzDsnqzoakfKNzCl009YkBxAN2me/X/k8+jwt
         Gs2/WLsW4UQBcmLzmoyDSfLM03aN4uusFAXB89EciwXboHltBmBYTWPFwwlZHZREqr2d
         NlsJX08swRNdDYUGabugD7SQ6tqvRhOPJ6kC9GoYk77/9nnubHHeMM3fIaNa4Uju55Sb
         FT3aDm3snsUacl3yUMadufuV/sKC16IHNjINkLj7Shizov+CUkcD2EyepGXGkVAzyzBp
         8vDw==
X-Gm-Message-State: AOAM530zH6ELm06K4La5mhLkFpnmXJe3Dgb2fVNnxCZhfwn2MgO84x4q
        E24lt1MAI3HyQ2gwrmefn2a5Zcqrrv4r5OwBrTM=
X-Google-Smtp-Source: ABdhPJz2PC2Voc3Hioat8lX7H740j7PGIpN/On2VMFDGbYjD7QNjVdADc24scQv0n9LxvPTmtglbpLo7fsoj//JibDk=
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr28912160wry.321.1635678884816;
 Sun, 31 Oct 2021 04:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211030031832.165457-1-liaochang1@huawei.com>
 <20211030031832.165457-3-liaochang1@huawei.com> <87ee83goju.fsf@disp2133>
In-Reply-To: <87ee83goju.fsf@disp2133>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Sun, 31 Oct 2021 12:14:33 +0100
Message-ID: <CAJ+HfNjaBQrBtOuMvTccbb2K-Ua=T1eZk0+70hp0_aOAc83A-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] RISC-V: use memcpy for kexec_file mode
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Liao Chang <liaochang1@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Kossifidis <mick@ics.forth.gr>, jszhang@kernel.org,
        guoren@linux.alibaba.com, Pekka Enberg <penberg@kernel.org>,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com,
        changbin.du@intel.com, Alex Ghiti <alex@ghiti.fr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2021 at 05:51, Eric W. Biederman <ebiederm@xmission.com> wro=
te:
>
> Liao Chang <liaochang1@huawei.com> writes:
>
> > The pointer to buffer loading kernel binaries is in kernel space for
> > kexec_fil mode, When copy_from_user copies data from pointer to a block
> > of memory, it checkes that the pointer is in the user space range, on
> > RISCV-V that is:
> >
> > static inline bool __access_ok(unsigned long addr, unsigned long size)
> > {
> >       return size <=3D TASK_SIZE && addr <=3D TASK_SIZE - size;
> > }
> >
> > and TASK_SIZE is 0x4000000000 for 64-bits, which now causes
> > copy_from_user to reject the access of the field 'buf' of struct
> > kexec_segment that is in range [CONFIG_PAGE_OFFSET - VMALLOC_SIZE,
> > CONFIG_PAGE_OFFSET), is invalid user space pointer.
> >
> > This patch fixes this issue by skipping access_ok(), use mempcy() inste=
ad.
>
> I am a bit confused.
>
> Why is machine_kexec ever calling copy_from_user?  That seems wrong in
> all cases.
>

It's not machine_kexec -- it's machine_kexec_prepare, which pulls out
the FDT from the image. It looks like MIPS does it similarly.

(Caveat: I might be confused as well! ;-))


Bj=C3=B6rn
