Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45AA388697
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhESFf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbhESFea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:34:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED7C061345
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:31:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v14so5912632pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORREq0n4aqhd/nTxoItkg8DEINjbZiFVhT8qbSw5Qbo=;
        b=N4Mk9AgS2BTdoIAnjl5KlK2wtHmjEWnksv9WPpXsDYWA/+Uzoi5AqclODPLV2+c/Mj
         myF7Lw6DHax5aoXqz+RhMnBhkRYP8ZhPWvQSr9Gtn+Nulx9SPebhCH1dKD7XnLxZSfBb
         R9JIz8hiVFRTj9MYvFcNMyW4UVY4fvaOUbaWqs1TGjIjiXprKT8WfMBxDn6QZz+qjBEY
         0QQxTWpvCbkglNLXl/eB23MG1fHtGvuE2k4zMk2d6wGRNxIXS6YGJ2NgzAfbRA2uMasX
         PATBOa6YCLQRr5YM2AREMJTbFqOtPAhYibTEXe4j95bceWE2yPe+yKX1GBH8us8CCY5p
         flzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORREq0n4aqhd/nTxoItkg8DEINjbZiFVhT8qbSw5Qbo=;
        b=LP9JmZn/0rkpqKZbBat0HjLLjorIRbRqt8Qaks365Gi30LwRSpB0i5rSMZSP+ZK2Ku
         YCqpcvtjiRVML7a6nCJeOeT9wHmwEhCnKWFvqHFQuHjXp6NdfZ95Y+EgHkCJdxsfNF3I
         h5/aLHyC+nUszR5L4AHKYp+aLL0ky4WREPWEqv1tNOhnWxe526jgJs8heEdv+0khLkKx
         Da507sewDXqLdIcJ/XiIp9LgqZI0xZtKlaQFSTf2gIEJSavgMpKSKWzlcImjHGfqk5w6
         EosMYwDC2CCMVpreuWU/zMRjsvC1lbZbFEZtmMYpV4GQ/UreqsjYP5fCQFZrzlXZVaub
         U6/Q==
X-Gm-Message-State: AOAM532Hxuzn5oXdA+dpiD1zEqBXOm08Dg+3yHIhxQLHtYpmEbAud/D9
        ohfUKRMoTILMyTIOTNdkPXUGFfxQkAHY9z1Ho72IUA==
X-Google-Smtp-Source: ABdhPJyS/maMeDnKsTfr/21cvzSbf+U4edp1dR+BZgJe5H+LNjhp0wug3B1Xio88zjUK2N9aUx+WBNgbUKfBcY14lwg=
X-Received: by 2002:a65:61a8:: with SMTP id i8mr9086975pgv.271.1621402318747;
 Tue, 18 May 2021 22:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-6-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-6-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:31:43 -0700
Message-ID: <CAAeT=FzKLhUXwt6CLjSKjTzv9p5+HouJr6=vjfP9Da8SdKczWg@mail.gmail.com>
Subject: Re: [PATCH 05/43] KVM: x86: Split out CR0/CR4 MMU role change
 detectors to separate helpers
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:47 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Split out the post-CR0/CR4 MMU role change detectors to separate helpers,
> they will be used during vCPU RESET/INIT to conditionally reset the MMU
> in a future patch.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
