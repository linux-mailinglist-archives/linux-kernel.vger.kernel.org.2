Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3739C307BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhA1RI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhA1RH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:07:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E59CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:06:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p21so8549455lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkrJm7U7mDdQ4OKQvfjV3ukz3WJDfPA15wLuPItmbOE=;
        b=Ym/mHfhFk+OmPYHXLRGVpn540PUV51S08Uw5GDWkwaHamneo2AvmwwHRxCFuEMnahu
         mTllj1MFqapNyaFROIlS1K+xBDTzW74tQ/gCydcXXFZ3XMAtfO30doqm/t2CPRAU58lC
         CrRCRJZtp90i6NbsaVc5C3Cmo92Q4hPjhfro8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkrJm7U7mDdQ4OKQvfjV3ukz3WJDfPA15wLuPItmbOE=;
        b=QLx/CreAvAP9iMUkGCZusbzEhBms3xzHcuJPLWPz/bsqzGrcvKsqX/pbhluSr651FR
         n7vjIn2y8JnvM3o8bIKQC7Wl+K/RAwt9xJJ2dsuOsOftPlBsQB7j12z0Sg2Vr0zjmLEo
         qLbbdeU3aC79G7nDa8ZjCr3ihoYFFt0vynPAP9zQLb7zbujnoem6uVYssOD26rEvRej8
         bkeDffLps72mJnWfLHS3eSs492GJDjmq/yenp6brEmbP47wEyPhGrJhBBL3By++ldPiP
         OBMaavGOTPE44CO0/Bz8SVGWcsUqm860LzXmTRyt9RrOy8jrk/jeGnOAI0R7elJUOONC
         HpsA==
X-Gm-Message-State: AOAM5304/ECL/NnuwUdPN1gyVxPwKaqg+SMhHsjYsiPX91LIBpWejkpf
        mgLSLFvq5pjShmB2bQTbOtBf3qQ2BWButQ==
X-Google-Smtp-Source: ABdhPJwMd7pdxrpa21arEuEOJp5ZAJ4asVhejgmrVXS+ZyRRZvAD0ehtNL6H8s4/gAKpOxatmANcVw==
X-Received: by 2002:ac2:5d69:: with SMTP id h9mr26875lft.576.1611853604373;
        Thu, 28 Jan 2021 09:06:44 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u4sm1757205lfc.277.2021.01.28.09.06.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 09:06:43 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id v24so8550035lfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:06:42 -0800 (PST)
X-Received: by 2002:a19:8458:: with SMTP id g85mr9204lfd.487.1611853602335;
 Thu, 28 Jan 2021 09:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20200616153100.633279950@linuxfoundation.org> <20200616153106.532769297@linuxfoundation.org>
In-Reply-To: <20200616153106.532769297@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 09:06:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCd3aED5YOagwmt3-1+tbc796kgSrqF_PZAZ4_=d1ygg@mail.gmail.com>
Message-ID: <CAHk-=whCd3aED5YOagwmt3-1+tbc796kgSrqF_PZAZ4_=d1ygg@mail.gmail.com>
Subject: Re: [PATCH 5.4 120/134] mm/slub: fix a memory leak in sysfs_slab_add()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: this patch is getting reverted upstream, because it causes a
double free (admittedly under very rare circumstances, but still).

I'll mark the revert for stable, since it seems to have made it into
basically all stable kernels.

The revert commit is 757fed1d0898 Revert "mm/slub: fix a memory leak
in sysfs_slab_add()".

            Linus

On Tue, Jun 16, 2020 at 8:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Wang Hai <wanghai38@huawei.com>
>
> commit dde3c6b72a16c2db826f54b2d49bdea26c3534a2 upstream.
