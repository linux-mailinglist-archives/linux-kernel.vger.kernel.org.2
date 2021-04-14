Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCAB35F936
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352814AbhDNQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352817AbhDNQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:47:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BDBC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:46:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h19-20020a9d64130000b02902875a567768so8931882otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QyqH9wgwqkw+Tim/5reZH7esCeUL17nNuqOsrcEi/8=;
        b=lGOxeERQw55ADBZgd0OCtT8SNdwtjcdWCKEUxYbZaKzkP4Mr+URPnctooW80uujOnV
         Wqs0E9H/Ez6M87Y2+B0oHoElSHuu6R3yaGtrNBqmcQjuS3S0z404d8hMNDWyWGMb+YaF
         Jtx64JCJ/ns+b3d70x+UVo72Y8+qxvM0ZH/hzgzt81xAl/OzYJX5IfMDxBXDzjeH+zBc
         YQEfkj1fRvTKzJ4SGb2Hys+df3j2N/sJ+/OUaPhkxFbUp1AA1rQI/HyhNBF/Qx0sD8Wf
         gdJ8sGdUD6tXOst71T0YyaTCPrapDVyQY/V9mIk+KoYDldSW3YZSWyrUCREKbJGvGNuh
         NojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QyqH9wgwqkw+Tim/5reZH7esCeUL17nNuqOsrcEi/8=;
        b=lrvWkasuExdMWhW+yifTxX1Kul4i4Ym2sMBe6mbSMSKwJyH5xn31neTf31DXSUmRYJ
         LkEBprqS+vTaPVszTXbS/oQtPVkdPmpU7wnZBK0mHG1TUN22QbWEEniYPnERKdfi6PJ5
         86k+gUwG10uo+P+GEkbqyvvvNlj8aP5/IXHep3mhHDJbfUSLiLBsN8/i4oiaiJi+lImD
         KIyNDDULYoThKtU1pQKC07cwvlOO6LeKjwpop+tewaT0uWTAT+x0KQoNDev7/EFWinrl
         MgGnQsRiOxG9bFZ884X95i96rqwPa/0m3uszjLFUK5ks1X22q6vScOXEzmFaQz8yyj01
         XXWg==
X-Gm-Message-State: AOAM530mcA4JW+gNLMZtim4ZlDhlsFsLBhRGt2VAt01YYO+PAdGU3ght
        FeS1Ro9kMvEr13oNM3sMDs8igOeDN4++ZyBrlQ9WQA==
X-Google-Smtp-Source: ABdhPJzgSqw2ZayjEkdo6yb/pd5CbG5hLuc1phWHzN7ngsXecfxWfjztrdh/yvJ/pC1ZZuWOVGM4BXIbqzzVEGvZmrU=
X-Received: by 2002:a9d:e87:: with SMTP id 7mr26932570otj.324.1618418816911;
 Wed, 14 Apr 2021 09:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
 <CAHUa44Gga=k3indU8FC3X5xE=6RnKEDNeZBDWeJzm47-Spm0QA@mail.gmail.com> <1318f015-40cb-2bdd-17fb-2a3843ed45bc@amd.com>
In-Reply-To: <1318f015-40cb-2bdd-17fb-2a3843ed45bc@amd.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 14 Apr 2021 18:46:46 +0200
Message-ID: <CAHUa44EtLazK8YezYCV7_oGxfarsXv5CfSivqiBecb7=LrYYqQ@mail.gmail.com>
Subject: Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes 0
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiro,

On Mon, Apr 12, 2021 at 12:20 PM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
>
>
> On 12/04/21 1:06 pm, Jens Wiklander wrote:
> > On Mon, Apr 5, 2021 at 11:43 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
> >>
> >> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
> >>
> >> If it is a single instance TA, the TA should not get unloaded from AMD
> >> Secure Processor, while it is still in use in another TEE context.
> >>
> >> Therefore reference count TA and unload it when the count becomes zero.
> >>
> >> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> >> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> >> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> >> ---
> >> v2:
> >>  * Unload TA if get_ta_refcount() fails
> >>
> >>  drivers/tee/amdtee/amdtee_private.h | 13 ++++
> >>  drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
> >>  drivers/tee/amdtee/core.c           | 15 +++--
> >>  3 files changed, 106 insertions(+), 16 deletions(-)
> >
> > Looks good to me. Please address Dan's comment.
> >
>
> Hi Jens,
>
> I have replied to Dan's comment.
>
> If you are okay with the current patch, request you to pull this.

By addressing the comment I meant fixing it not just replying that
you're going to ignore it. :-)
I can't see any reason why the preferred style shouldn't be used.

Cheers,
Jens
