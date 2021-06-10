Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93253A27D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFJJLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:11:30 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51076 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhFJJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:11:29 -0400
Received: by mail-wm1-f45.google.com with SMTP id d184so5733829wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sWa4PTmyAX1nPFLXf55YhYnjMvPUrhFAQy3A/xW4Ro=;
        b=tcvwXsQcFO4v2O30nFo/+ootpa3l5mnUGTfVmArzpX2Q6gSj6uNQbr/Hq82FdJDy2n
         QFEysE0lLnnB+vp5iGctu6f+ADXysjN6bJ81UPXfRe67bk2Ufjz69p8B6nobT98v1rxG
         zX5QasRn4NreeJwvCbtod2288rYVJlI8kr9Il0F6SxuMhT0uDVuXZSHLIRfzNy5oNep4
         rGvAV1bcWJhF9yct/An65qa030UVVyd4jhUA5PDbS97uVrpW+Rk5tBDtpmxfl7RIDxgz
         VtA65n7qkCPaDjQvmJd1sRgWOjyRw7TwC7cZdQZ82q+XB8rJ/7T2VzBtxhCsJt0+w09H
         70qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sWa4PTmyAX1nPFLXf55YhYnjMvPUrhFAQy3A/xW4Ro=;
        b=mOmPzYCApvxIv9SGpLjG4S1nSFpLhVW3CIKIo4NcpDmCwApFqXlcSiXRNGfoNhQxJu
         i4UM3Fa26rftD4ZI8Fos+mm3SLrb1PN55AMB/+/CxWNdkUFq96gvtdPaycM55oA8sReL
         Y3ZO6xUt8HMS9u8+B0RDEd2dUTAciO3OhePyomeuwI95elDBbcAI8E9t/9GDqA/drZWC
         +Vx7LlmEw+PQ6COy+BYe4Z30sDybkd6euY5IRWXRGEv8Gksxc+lFapTFc0p5+XlIgKIx
         ZdtGHSpD7aQ/vsR2IoKHu9JMBHYS28ASGn5tCa09lklTKXYNfRnYSh2jdQsK+UTCdaZ8
         EeNg==
X-Gm-Message-State: AOAM533jiGRsMl2zxmkshaTwEUG2Se95rwwnvC2X9DgUSbaj2/6mNARg
        VF2oCuragX9vVWkJbfzBjdSnUIcfVREH0H1B8Vcs3w==
X-Google-Smtp-Source: ABdhPJwpgmIUWV3cUSE4xlzYXM+9q5mCegFROUhTel9Rk/3Y5jckv0H6v3ATlSgrFDSyqPt1S1mgLquVq5FkK5BfLhE=
X-Received: by 2002:a7b:c853:: with SMTP id c19mr14237840wml.30.1623316107589;
 Thu, 10 Jun 2021 02:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
 <20210609102324.2222332-7-jens.wiklander@linaro.org> <20210609145811.GJ4910@sequoia>
In-Reply-To: <20210609145811.GJ4910@sequoia>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 10 Jun 2021 11:08:16 +0200
Message-ID: <CAHUa44Erb6bVFEU=xDoRj4KHn1rMFaEPZfS0H24zR+XgGAoLUQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 4:58 PM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> On 2021-06-09 12:23:23, Jens Wiklander wrote:
> > Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> > the old deprecated tee_shm_alloc() function which required specific
> > TEE_SHM-flags.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> Since this series is essentially a rewrite of the shm allocation logic,
> it is worth pointing out that the rewrite still uses contiguous
> allocations (from alloc_pages()). The tee_bnxt_fw driver is performing
> an order-10 allocation which is the max, by default. I've only tested
> tee_bnxt_fw when it was built-in to the kernel and tee_bnxt_fw_probe()
> was called early in boot but I suspect that it might not succeed when
> built as a module and loaded later after memory is segmented. I think
> this driver would benefit from being able to request a non-contiguous
> allocation.
>
> Is this rewrite a good time to offer drivers a way to perform a
> non-contiguous allocation?

Good idea, I'll look into that. I'll add it as a separate patch if it works OK.

Cheers,
Jens
