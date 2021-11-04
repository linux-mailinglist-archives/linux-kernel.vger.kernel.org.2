Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2100A445463
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhKDOAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:00:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F6C06127A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 06:58:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e65so5484176pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6SQdi7s3E5H+vjXCs1YEcND+ZzSy2UU02yujcY6scI=;
        b=f58CavIyrr1D8YaqKFXLcAEyOCA/u9zOjAozKpMPMggBTHgJd9TBxrLqKrJLrAcT0k
         ddBFw9ZKO8mJuQ/sLjbuENiR+uLPKbWwwo4ylv/b4QDTBZ0HL+P3nV9XD21iUmRD0gV2
         c29Kl050tjsTBeYASnCeaoPOj80ZjOL2eI4vPbKJZvNfpPqgGt23IxBACH6Scc650Mps
         bojPWb0ibVrkQa6F0kW1Qsh50WGHtdSZ2+ybc45RFZc+pQ0Fvzg0TEsvWm1Yl4Z0cNej
         yLrKEnrCIGr12Ru+SLf+GYSYAFuy4EOA2IYy70mg32jBhuO2Hw+EWlvn4w8SlTrrLkDt
         01mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6SQdi7s3E5H+vjXCs1YEcND+ZzSy2UU02yujcY6scI=;
        b=w64f4QAZyrfbmLvU7T99TZeQLFQqlGIUChmgRpqf83mjV1iA+LYtt28whcyfPizB+O
         0Zy2mR7aJvL/F5IxKYr4krYotNvASTEgYWz0Q50rAgFlDGaDO3mKdlS6jrtG2Bwnl9n3
         UcbR/LnN7wMd8Z8t5386yoe7tbsBCkSUi8udOy0zhIvyXt7Ds4tx83EWbuTARvzDpGkt
         eZgiNoYyuhzN1pThaaosv1VM5a9xqq7uZ/epO5i+gAr5rd1SZK2KIJGpl0f7Cs5k34II
         UbuyBqmVcPHwIBleiG2c4E5mMtQar0TsdjPJTr7BsIdfibxQejIoWdp3g0witsST3jem
         RO4Q==
X-Gm-Message-State: AOAM533Z7uA4CAiotedqSQgeO+9+svAqGLZ1ACPoH+qfQNUxyTLCqzfz
        u6D/U03jYZizVjATLuIiQn7LlAZ4ESKe1Q==
X-Google-Smtp-Source: ABdhPJyzkYr/yQgMwXyO/ROZ3931wThHZNOvnagfd1BHgc6gzK3Y76yRyb6ViaO5gg3NqkHVJsxFTg==
X-Received: by 2002:aa7:8755:0:b0:494:67a6:1c84 with SMTP id g21-20020aa78755000000b0049467a61c84mr3223903pfo.26.1636034281752;
        Thu, 04 Nov 2021 06:58:01 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v12sm4109756pjs.0.2021.11.04.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:58:01 -0700 (PDT)
Date:   Thu, 4 Nov 2021 13:57:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] KVM: Move INVPCID type check from vmx and svm to
 the common kvm_handle_invpcid()
Message-ID: <YYPm5eann2hCAryi@google.com>
References: <20211103205911.1253463-1-vipinsh@google.com>
 <20211103205911.1253463-3-vipinsh@google.com>
 <YYMZPKPkk5dVJ6nZ@google.com>
 <CAHVum0eFwgM-Pj6xHt0gkFCf1OZGjYD7K0xttswbAaGMo6zpJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0eFwgM-Pj6xHt0gkFCf1OZGjYD7K0xttswbAaGMo6zpJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021, Vipin Sharma wrote:
> On Wed, Nov 3, 2021 at 4:20 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Wed, Nov 03, 2021, Vipin Sharma wrote:
> > > Handle #GP on INVPCID due to an invalid type in the common switch
> > > statement instead of relying on the callers (VMX and SVM) to manually
> > > validate the type.
> > >
> > > Unlike INVVPID and INVEPT, INVPCID is not explicitly documented to check
> > > the type before reading the operand from memory, so deferring the
> > > type validity check until after that point is architecturally allowed.
> > >
> > > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > > ---
> >
> > For future reference, a R-b that comes with qualifiers can be carried so long as
> > the issues raised by the reviewer are addressed.  Obviously it can be somewhat
> > subjective, but common sense usually goes a long ways, and most reviewers won't
> > be too grumpy about mistakes so long as you had good intentions and remedy any
> > mistakes.  And if you're in doubt, you can always add a blurb in the cover letter
> > or ignored part of the patch to explicitly confirm that it was ok to add the tag,
> > e.g. "Sean, I added your Reviewed-by in patch 02 after fixing the changelog, let
> > me know if that's not what you intended".
> >
> > Thanks!
> >
> > Reviewed-by: Sean Christopherson <seanjc@google.com>
> 
> I was not sure if I can add R-b as it was only for the code and not
> changelog. Good to know that I can ask such things in the cover letter
> or the ignored part of the patch.

Ah, that's my bad, that was indeed a very confusing way to phrase my contingent
review.
