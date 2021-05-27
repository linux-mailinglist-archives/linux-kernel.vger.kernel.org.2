Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378B2393058
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhE0OAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:00:48 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:44802 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhE0OAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:00:47 -0400
Received: by mail-ej1-f41.google.com with SMTP id lz27so191867ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 06:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIsTFYdNP+q67ku3OgodsD7MXc7M+y8wFDcVajRkWBA=;
        b=cLqj68ZNJ8MeXW6H31a0ZO8Ui4kVskskQw8GaMlgB+JjdApkdgFe66mxVCjQcD+DiT
         77FuyQVmbMk0zs3M+NVJorKM6ocr7XY2MC4onLDvPPnwb+OBS4Lmus64XrCsbHm3oLa9
         VBlkKvouJdtt+rl9HF4Wv5zsqDgowpZ9KNzPxJtMu4zw6UM+0UD9n2+BqCAYVsOeq6DX
         BXyVkf30DHhyT/MTtOnbdKBl3YqKIiYHCpPJxoSQxaOHVaG9SjyCH78KheaSuhGfEW6+
         zrZcDtHV9gz6m8WtLbwM+v/9j/+pm+PfmZlledHxnx7PTGcsWYQ2HynJ1pwkEZJykNvn
         6TNg==
X-Gm-Message-State: AOAM531X2FqUUOt8iFSYzhccxSyJsE/Ayd17QokOGKGpaRtL7YAZGvJz
        Cq7+KqctqARxfiN/NxF+On/mDm0nytJzRzv+EX4=
X-Google-Smtp-Source: ABdhPJwcSCel5fBjYawuv/m+D1E5ay+zz+1cr2CIBvWiJ3yxd+CcaAWospn0Iu5LbhOMN/QpK7rPf7X/DnxLY2sJEBM=
X-Received: by 2002:a17:906:1dd1:: with SMTP id v17mr3952580ejh.31.1622123951960;
 Thu, 27 May 2021 06:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-16-chang.seok.bae@intel.com> <CAJvTdKnrFSS0fvhNz5mb9v8epEVtphUesEUV0hhNErMBK5HNHQ@mail.gmail.com>
 <CAJvTdKmzN0VMyH8VU_fdzn2UZqmR=_aNrJW01a65BhyLm6YRPg@mail.gmail.com> <YK9/Gu2Bse0Mc0F3@zn.tnic>
In-Reply-To: <YK9/Gu2Bse0Mc0F3@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 27 May 2021 09:59:00 -0400
Message-ID: <CAJvTdK=Z5LMU9ehFH2NVFCP7LLEvaTtywfuZHdwRb9-7hvE8KA@mail.gmail.com>
Subject: Re: second, sync-alloc syscall
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 7:14 AM Borislav Petkov <bp@alien8.de> wrote:

> So if this second syscall doesn't sound really great, I'd say we stick
> to the #NM-based allocation and keep this one in the bag for now and
> take it out only if it turns out that it makes sense as a use case.

I agree.  Simple to add if later, if something requires it --
though given it's modest incremental value, currently hard to justify.

> As tglx said: it is easy to add stuff later. It is a lot harder - even
> impossible - to remove already present machinery.

Indeed.

thanks!
Len Brown, Intel Open Source Technology Center
