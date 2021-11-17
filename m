Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B8E45504D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhKQWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbhKQWWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:22:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BBC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:19:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so3442856plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x1h1INIZ8WhcZzeT8STD1Y1WIDkkI1uuBmn+FT5vweA=;
        b=DNO2U45wStZmzQe32h+CttOAfg7YZWOdr3rPs0wh6JsubtPIU5YjHIdy6E4Y6/8WHJ
         /ck/npL+vh7ffuSh+m0sMnqFEBUnbpm2/CGrQpioMNjR8V/FCXqwsVAw/V7YeL4MTM4R
         fHgMtgZcfN/pED4PUkk0/der1N/Vr3V9qG/2pkWoZGNJyxHQLgyrLVvhpfUQuTyej1SL
         edTfe4jCupUa7eIfsqr3eCVighjdvpcTGkFpi9ArVMiFLziffJpBl+viETzrPH0eFIUZ
         emROgWddSWIS4cq+LZA3KByQt9zq84x/wFf2CHL+rPC50YxR4R5kmT2zqMD5+gddxlOm
         4UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x1h1INIZ8WhcZzeT8STD1Y1WIDkkI1uuBmn+FT5vweA=;
        b=MXYLzaUL8YHFSohuXKi8SmluxXvio8h6ciiztDyblZgRd9O8F+mZW06zt/fB/7+58s
         TH4qD4W3knKOkZrmi18zriKClk/45hK7/ZX5c5Ro9hZXYhs602DRQoTL9aLYHt/jd+ZM
         6n9QImktbAl9Qn5tVubCCE3m4Eat6TjR7/2qAwqz83QtJsGFpdYv4H9DiRlbezM2B1N/
         4DmJetOPkSnK9ipddyBjLTwGb9gLAbgyX3hhczZJJFnKs/RnT68rvhnHL/5cYvtrJu0j
         aBxsn6DUIaYqQoY3EY/JTUcK+/nenRo/HI//6zOQE0AABefZYIlo6qBWAHZhm6mmfqNc
         c4vw==
X-Gm-Message-State: AOAM530iPPAbZlXmUjDo0WBRPs03RSaqpt/h6QIYbuRfEfodXORYm8rr
        5fkV8UMAdp/+gcukwtch0gVm9g==
X-Google-Smtp-Source: ABdhPJzmlUGGGEebLbyfGzUzf+W2G5tyBnW5OOwGj41CIzVK7TscIl7PaRnN5iqWSKaVpHc1irUtnA==
X-Received: by 2002:a17:90b:4f86:: with SMTP id qe6mr3951430pjb.198.1637187578764;
        Wed, 17 Nov 2021 14:19:38 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t7sm6332693pjs.45.2021.11.17.14.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 14:19:38 -0800 (PST)
Date:   Wed, 17 Nov 2021 22:19:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     zhaoxiao <zhaoxiao@uniontech.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Fix the warning by the min()
Message-ID: <YZV/9lsblb4HB+T+@google.com>
References: <20211116121014.1675-1-zhaoxiao@uniontech.com>
 <8881d7b4-0c31-cafd-1158-0d42c1c7f43a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8881d7b4-0c31-cafd-1158-0d42c1c7f43a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021, Paolo Bonzini wrote:
> However, the second reason is that "r < 0" is a very common way to express
> "if there was an error".  In this case that would be
> 
> 	r = __kvm_io_bus_write(vcpu, bus, &range, val);
> 	if (r < 0)		// "if __kvm_io_bus_write failed"
> 		return r;
> 
> 	return 0;
> 
> That "r < 0" is what will catch the attention of the person that is reading
> the code, no matter if it is an "if" or (as in the existing code), a
> "return".  Using "min" removes the idiom that tells the person "this is
> checking for errors".

+1, there is zero chance that I would realize "min(r, 0)" is "handling" errors.
