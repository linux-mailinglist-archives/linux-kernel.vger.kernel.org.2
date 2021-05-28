Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2994393A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhE1AaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbhE1AaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:30:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46577C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:28:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so1528345pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I7wy99R89NcBY4kuPu7JFHQrrTyxSqc5+QStHaB/eUU=;
        b=tda8JphBgw5jUTht2VrzpvbblgBlHPLgA3xnHbpUUtFQj5cYEJIfAGND1LawcJHqXZ
         t6iw1s8vareTh+zcsT+FIAfvWEtwKf40lKNniQtL0gEUX+2XMoB7qmwn12KCELABYEc8
         sv6hxDh5H4ZgULvz7fKdhrwUKjG+nusz2yCFMhu7pIe0FFXu1BC00LnKjVLrT8yzDiV9
         nsy67CFHpjlh3hwatKuZCpEQb10MWcdTR2GbsFdPlaYQS2XjDiAAfdMyJGIuTd/PRI2x
         UyHHyU100te1VyBhEcvO4oupoPIch1h6AO6nwVDn7hh4U6ANCLJVG1ZJlo2ZU7zapRlK
         1BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I7wy99R89NcBY4kuPu7JFHQrrTyxSqc5+QStHaB/eUU=;
        b=Ad7vOrnfR5JkZkk/DPz8CDTxb7QwvPmWzIsDW/vBQ/KV9nltvIfUTGOSZfUrrun9g6
         yK3Iz/kiTBXx3mQOeR+I1QDzkR14yiuvEmY1A4xgq9G0cyzRfZ6EX+5J16zN4uIB+gJS
         JniVeft0DEGortPD3Vdg7GaqT5GBVev3CgJ/Hml4Y9Z0SxhCq63BEPejRntBwY3UB1IE
         hBCEnocCh0//9vJzqYZfKXqikUZPzXjiqcB3peGrwQdRkYd3wkJBNJcZa2yl2MPHCv4Y
         mvODE7Rvyql0V2tGVrVLz+xZCRsIuMC0npPbuE95/yp0mS9lfh5/ZVnBW8Oc7pLr4d0z
         Tpjg==
X-Gm-Message-State: AOAM530N9hypudtCUCB7FeDD/Q4ocx2MelIKj2wOwLxiycx1rK0E+oJ/
        z7IfL40n7e9hCo9D6w0BJTpiwg==
X-Google-Smtp-Source: ABdhPJzw4drT7C9GHtNuv8i4niDLo5ACJsDJ9OeneWGvOpOu4EAkz/8JH6tc9Od1aqrcDMQbqLZO8Q==
X-Received: by 2002:a17:90a:a013:: with SMTP id q19mr1331687pjp.29.1622161720673;
        Thu, 27 May 2021 17:28:40 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id pg5sm2585505pjb.28.2021.05.27.17.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 17:28:40 -0700 (PDT)
Date:   Fri, 28 May 2021 00:28:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 2/2] KVM: X86: Kill off ctxt->ud
Message-ID: <YLA5NFSGemfAOrMa@google.com>
References: <1622160097-37633-1-git-send-email-wanpengli@tencent.com>
 <1622160097-37633-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622160097-37633-2-git-send-email-wanpengli@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> ctxt->ud is consumed only by x86_decode_insn(), we can kill it off by 
> passing emulation_type to x86_decode_insn() and dropping ctxt->ud 
> altogether. Tracking that info in ctxt for literally one call is silly.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
