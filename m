Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD567444B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 00:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhKCXXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhKCXXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 19:23:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31939C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 16:20:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u33so3958486pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Y2S6Byxm0KbZa6sY2deNa9Jl5FKstAIjXV9nN4iMDk=;
        b=K91RCxho56MVM9xkrEB3UKg+BWwwhcaLoHcPld8X+H1nqOstvWhabsJWdT86MzZbv7
         oYqZLQrjvkH849hAVJZ2gX3z3qYj2UdkVjRVOf1PONjBt7BAw7bdI0IrQpUMqG5E28bI
         2RjSQz8jt3phmu+OmeOnD8nIfgVc49b+0LoH9Vt+G7hZcEtEy7RR4CdCEeJtS6Nocs9H
         MpO5GOPe8STy5QY0RmZA0cv4M9SiZF6+TN2V4hmGqbop68oXQXRFwvXRPh49V8XG8wJS
         v9pqQ0qAZzxQfuN0eUwHeY91rh3DFXDFHHpyOgj10UE+5p3SwIqfQ5tns06PgJzkoTk/
         cm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Y2S6Byxm0KbZa6sY2deNa9Jl5FKstAIjXV9nN4iMDk=;
        b=p5H3Z98tzYND+fpe+ObUjljWSn1J9gi+y8NhD28z/y8QacEGDcj80h8JdsqRFHx4lA
         VEkfyhK6bRsS9YV2/Klduw2Q74yttu8ta2cTmnGHqBgVTs8QqI1auMmMWs4j3KZDQuAA
         Z8DgEw5xkH4hxC+7jh90Am+JbYxdBuCjmiwpt1/2F8oyipJcEwDtfbhQQmEPKIzHDcI6
         2tmK49LeBIVYQNTtVfOLNYH5V7GNAYYZFfDKNfg9i8cNGat9soPzgtPWt4QEf6dfM+vY
         AkeVfyGGOKEdEx/xhjeT03dq3dUUdGtkffLz/8iAD4EIS5eZqujVO1c+WR94vHkldgrv
         omtg==
X-Gm-Message-State: AOAM530be08A72Q7WSX3lZXEAeeqFX0inMF6AwUNo7kgDA3RRoVCkT1f
        w04P1Yamo+RQkNwllddJh0jY8Q==
X-Google-Smtp-Source: ABdhPJy4brD18aSZ3rwkyQEyhmNvGSzOxarylF5FcaeQ9OUCRHAS0uELEun5xfh8MoMWYe+r+G6K0A==
X-Received: by 2002:a65:5082:: with SMTP id r2mr35784039pgp.353.1635981632525;
        Wed, 03 Nov 2021 16:20:32 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n20sm2682378pgc.10.2021.11.03.16.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 16:20:32 -0700 (PDT)
Date:   Wed, 3 Nov 2021 23:20:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] KVM: Move INVPCID type check from vmx and svm to
 the common kvm_handle_invpcid()
Message-ID: <YYMZPKPkk5dVJ6nZ@google.com>
References: <20211103205911.1253463-1-vipinsh@google.com>
 <20211103205911.1253463-3-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103205911.1253463-3-vipinsh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021, Vipin Sharma wrote:
> Handle #GP on INVPCID due to an invalid type in the common switch
> statement instead of relying on the callers (VMX and SVM) to manually
> validate the type.
> 
> Unlike INVVPID and INVEPT, INVPCID is not explicitly documented to check
> the type before reading the operand from memory, so deferring the
> type validity check until after that point is architecturally allowed.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---

For future reference, a R-b that comes with qualifiers can be carried so long as
the issues raised by the reviewer are addressed.  Obviously it can be somewhat
subjective, but common sense usually goes a long ways, and most reviewers won't
be too grumpy about mistakes so long as you had good intentions and remedy any
mistakes.  And if you're in doubt, you can always add a blurb in the cover letter
or ignored part of the patch to explicitly confirm that it was ok to add the tag,
e.g. "Sean, I added your Reviewed-by in patch 02 after fixing the changelog, let
me know if that's not what you intended".

Thanks!

Reviewed-by: Sean Christopherson <seanjc@google.com>
