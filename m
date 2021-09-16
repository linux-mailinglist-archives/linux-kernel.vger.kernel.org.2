Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61840E96D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345733AbhIPRyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358314AbhIPRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:52:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38D0C0613E6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:33:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c1so3496177pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tiqX7dnBSpraIxKgwlGElCJ7y3YLSYI9MnLnrLWRpJg=;
        b=iNlOkaj31rhWycqF0fbB4UX7Nr3By3h2mdYTW1OCnx4iArZusdd3Dj4q57ZJaDUbY/
         0ZLarEKWdS0JjcAIZBFSM8JH2VAybQolk28ufoXN/e24Azz/3Gz2yw0+MGqry6ZxjVZi
         7xaJDfS9utb4FJgwLJkMqz6baFRdwHbC11oGKBJvH0Z7oe/3NsZAtZLAxpKorbDT+kUL
         y4FELIhKoUd4Sqgie3qzEpfiNY3/KDxAXfphaoVl/YKDGxLHzIIJUtvNvXQWcycGip3E
         +hWkYdXbqZoK1Wp9/+9VvpU9wDKCARsoRqA9h7/48EoLWSU6W61m11ZEviIAiur0nzI3
         ssFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tiqX7dnBSpraIxKgwlGElCJ7y3YLSYI9MnLnrLWRpJg=;
        b=R+OAaVMA7xMDCa50L2shZo2WonzCZpOVUeuMWf6g8HchANqZrH8kGIPqQy/GCu7FZM
         mOU1O/mvfPiwtgwMMbgLZgpt6xXu9J4+Do28EgVcH5TCAzHpgSB33nwZ+MEe13epqDnH
         M8GZh6HVIEO7G8W9zNMFYDT2bEo49J200GBeolyzJC492whixntAs8NuIvNj63V6aSoN
         5R5gyiK3uYwIQnoXEJrAg40WHt0ZrO1WrVy66xGy20zxaBMr/wH1JE9Ii/MBO9cSe+5P
         H2hTphAwS9G4QAhjrz7Z13zL4MJeU9jjr9aCSeOPF9QUl/hRrp/MMgTTyh3MYXqtutq8
         1oVw==
X-Gm-Message-State: AOAM532QPCYYKGOCE8sAVvT9ykhFsGHBPOUTWhNrzYimRYJLpeOAK/ly
        mjzydwh34RNQxKhfqqlHRf3ENjabVoqC9w==
X-Google-Smtp-Source: ABdhPJxtOORah2T5ITGMwmMG9Gl/LK+cVqNihUnXIOc6WfpasBFIXzv9W2gxguosKdSbRk8Rl3kcRg==
X-Received: by 2002:a63:7e11:: with SMTP id z17mr5668827pgc.436.1631810031271;
        Thu, 16 Sep 2021 09:33:51 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z17sm3564469pfh.110.2021.09.16.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:33:50 -0700 (PDT)
Date:   Thu, 16 Sep 2021 16:33:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Edmondson <dme@dme.org>
Cc:     linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Mattson <jmattson@google.com>,
        David Edmondson <david.edmondson@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v5 3/4] KVM: x86: On emulation failure, convey the exit
 reason, etc. to userspace
Message-ID: <YUNx6hC80pBKd6a4@google.com>
References: <20210916083239.2168281-1-david.edmondson@oracle.com>
 <20210916083239.2168281-4-david.edmondson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916083239.2168281-4-david.edmondson@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021, David Edmondson wrote:
> Should instruction emulation fail, include the VM exit reason, etc. in
> the emulation_failure data passed to userspace, in order that the VMM
> can report it as a debugging aid when describing the failure.
> 
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---

Again with  the From: caveat,

Reviewed-by: Sean Christopherson <seanjc@google.com>


Thanks for doing this David!
