Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672503880DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhERT7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351992AbhERT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:58:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8687CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:57:40 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h7so5732692plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JvjDB9x37KbkhXGo+mBIOIKWP7D/vvjksKE9jNsnqVM=;
        b=XlBzqimzzkY84/NrA1P3tJSm49jxfiKijMeSOBsbwBNlL6+dhVZ9sUpEyWvvnBMr52
         sT0udTR/tCkm+5hqS3C1BG00fWJon8JhQezqR32DuJvJTc1eZdxx94zztu0kzi7ooAdI
         7cq2ep8B5IM6VMgaWLuLIkEklwTqmuexNpLzIsepNCI7vuseTs6whFcCu53wXSHlNiP2
         gMRw4iKefuEP7ZG/RNntgFHUBIIiM5G+jjoQlDgFWQBO/bLTxcFD5EYXb6ifEnxDlXH6
         kFQKgVxLSHtAR1LrrAwWRYEpbjYVKKINihgKCXncmNOLzFL4LHLh2NieKWVMS5S8LQUs
         c9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JvjDB9x37KbkhXGo+mBIOIKWP7D/vvjksKE9jNsnqVM=;
        b=AEYsigHLT1DDC9KLcClchKXtAoISvdrDPfkh5Rq+MUie2xhIanuN74B50rni48uTHm
         YXLU+8k6bhVeUq2W8ZYYDQmZ/EZ+bVcTWVuSFVWjPoUgLxSMr5OFpyZN8IgaxdAmjMQT
         Id7hnosLjeRCy1WPyqyprGIEHkJKZOW3t+E3giv+JIYJ7E9aN4Cqb1eusPiSACRh7eSe
         rQaf/w8o6cU91zQLUrE2ZfNjX2hu/8k4alyBQ+GwNTZW9y1nBxdbCn6rKf4kKAEobinf
         71MUz4NMQT3Semb/Sep6WWKZp3mq+mPr9crGEhMUuLkyqPZ1XghkCb/iDz9SguGI1l9a
         dJTw==
X-Gm-Message-State: AOAM530UO8yzCnnEybVh4mFayc4nC9HKH/lppl/GVvDcJqYVm6ZGWinq
        skqj9qNa42+xXlcHMIGE/x+ZJQ==
X-Google-Smtp-Source: ABdhPJwk6T7X0m8/MN/fEIPyLCYo2XlEldnEZomo4j04VpS+puwXQbF5lr58CXwqsju89hCz1oFTWQ==
X-Received: by 2002:a17:90a:4593:: with SMTP id v19mr6917000pjg.207.1621367859939;
        Tue, 18 May 2021 12:57:39 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id g202sm6072346pfb.54.2021.05.18.12.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 12:57:39 -0700 (PDT)
Date:   Tue, 18 May 2021 19:57:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] KVM: SVM: Drop unneeded CONFIG_X86_LOCAL_APIC
 check for AVIC
Message-ID: <YKQcL4ThiuCqWMIf@google.com>
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518144339.1987982-2-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Vitaly Kuznetsov wrote:
> AVIC dependency on CONFIG_X86_LOCAL_APIC is dead code since
> commit e42eef4ba388 ("KVM: add X86_LOCAL_APIC dependency").
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
