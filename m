Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89C44497F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhKCU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 16:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhKCU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:26:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022BC061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 13:23:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bi35so7504487lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxN7xgD0iXSw13F0ipDNCDWnNNmNAyOzVQih9uftgyE=;
        b=E4J25Q2pudhON45fR3Ntmj+rxfJTuheLQ9A0zpV/g9nLr4j2b5wNMamPgojdn2BlUZ
         vn5Oricpphfe/mHsqdm0R8rD1KtLxcg5ljzSlWEmdAHZjL6S/WIwxBDt+Zh5ohNww0d0
         P/x9uD4qi7IZm97z8FLJdyLye347iZ0mahDxooBOd3kvw8os1OazifhAlDY37HY7WTRz
         dZlUiDeDIpz2Qoi1yamy1CFxN9pPnJaifXY/nTbU+h9f1iFcJpOQRjKuFA5Z/IMc4dvi
         VhPLMV7gmJUTTcR0mG4BeeWIjRj7I7l3b50Ugbi6H6+gFVxIdF3QREgeoIWhsNdzP6HM
         k7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxN7xgD0iXSw13F0ipDNCDWnNNmNAyOzVQih9uftgyE=;
        b=jJsLQOwwEAKkcGKjut2GXZ2dmi/ePouyWzGPtRyQaKmNHOID1peF+xf5apk92f0rjn
         YFNGLU4AJS/9NR2Nn+4lhkhr1x0PubxQl+Uu8ty2vKh7ooYKnwlXMRuQHle3gG1Hd8AP
         0dLSD/7N5Bg3KmNtUXkkImCv/cPDqoVgIndhp2FVhPQD2zycLVXO6PNSPq4CmY9+rwnn
         0fwwblivR8Cro/WGxrm7XmQEZFZQMjuMHBAmyVtrAtAl4PX6BwlHyOEm3m+n183+VUcC
         FZR+DduF/wTtyS5lMTu16vInnWF2fMwGZe27dTxDWsVGiXlWCE6UYb+//zXIIVfgajmV
         n3/A==
X-Gm-Message-State: AOAM530ZYvCw/zE78ciPlORsy4BOw/izvwo4FSzUNYpZ/U/8S1HErHnC
        hRFW5Eov+3ys8+6/rQqEgL4pnI3XJrvWy/ol0Zb+Qg==
X-Google-Smtp-Source: ABdhPJxbCGrrn1mL2csyohdl4SutP0n6yFXUsYy1lJDoQWH0TqVRaru+bSnlVhGUZ647VrzZrYCT1sbGrvvzZuYEUBM=
X-Received: by 2002:a19:c211:: with SMTP id l17mr5051426lfc.627.1635971017862;
 Wed, 03 Nov 2021 13:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211103183232.1213761-1-vipinsh@google.com> <20211103183232.1213761-3-vipinsh@google.com>
 <YYLqRRfaiXrWo7Yz@google.com>
In-Reply-To: <YYLqRRfaiXrWo7Yz@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 3 Nov 2021 13:23:01 -0700
Message-ID: <CAHVum0dzN0cBzkS1ruWNQhJ+wSkfJO3uqFoNjzi67hiMzF2wwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: Move INVPCID type check from vmx and svm to
 the common kvm_handle_invpcid()
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 1:00 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Nov 03, 2021, Vipin Sharma wrote:
> > This check will be done in switch statement of kvm_handle_invpcid(),
>
> Please make the changelog a stand on its own, i.e. don't rely on the shortlog
> for context.
>
> > used by both VMX and SVM. It also removes (type > 3) check.
>
> Use imperative mood, i.e. state what you're doing as a "command", don't refer to
> the patch from a third-person point of view.
>
> The changelog also needs to call out that, unlike INVVPID and INVEPT, INVPCID is
> not explicitly documented as checking the "type" before reading the operand from
> memory.  I.e. there's a subtle, undocumented functional change in this patch.
>
> Something like:
>
>   Handle #GP on INVCPID due to an invalid type in the common switch statement
>   instead of relying on callers to manually verify the type is valid.  Unlike
>   INVVPID and INVPET, INVPCID is not explicitly documented as checking the type
>   before reading the operand from memory, so deferring the type validity check
>   until after that point is architecturally allowed.
>

Thanks. I will update it and send out v3.

> For the code:
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
