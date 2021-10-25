Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA04398BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhJYOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhJYOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:38:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39687C061746
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:35:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m26so10959738pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=unr/hPV1LRtaLFGvElzu8J0G2Us0ndUhxKDwst/EiBY=;
        b=LAlUCiUiThQLZqtR7k3VnyoObMeALAS0ZF9AaHeUoiJS1guNshz6Ho9BFs5fGeESUF
         q2uQw8bg3OcuTvEaIKGTbCG74e1HYpHPSEZChn9Fui/OXyFCbVB6QffuLlZuyQC4/uQf
         dGmSKBnuqEZd0HOd9FWNHYt0CKXWl00V4xD0baZyEsJC9VPu3MlxhGJT2M9rNeXhmm5W
         UWGLfI/FJZIrNea7hGz9eDiHhGcAJZad6ccR6CGhZCEbW+61HPcmiywR2MfrWgoOFoet
         tTXPL9wIOxueZy8L6p1PVSiKxbew7wnvCvbqwTi/QRy9OUhSavq7f0H9GFeEPT+vkdJT
         8pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=unr/hPV1LRtaLFGvElzu8J0G2Us0ndUhxKDwst/EiBY=;
        b=KLCEl4AH+gfjx2WrG9WHHQt1eMybSheYV2qFBiwC4/xMKzdvoIgZyR0zTD84Gjh0vv
         TZRlqh7lVjpCzN8uxf1Bpi+x7f2LxZ5akYUewXTtAr+rsVdzKoYXGZKmdsCH+lp0xBTn
         4UuzYI1bx4UoIkXEq4ffw1rTGKN/vZ58W7PBo99AFCqvNfw8LhCYk4uAuPLjrXMdvX6u
         /tXfUfZ7T1rUsKKqLavSMhfXNt7V1HhqTxRh3vVx4HYcIXQ+ZtYKMK10h+cStIcHC4cx
         klWlBLBJAOl9qB4yoxXD7HHLDF9pfe+3dbkd83PyXuLdr8F5fbT62ss99afMAQHjAvO8
         7fdg==
X-Gm-Message-State: AOAM533RZVN+0HN4LKQXGy8hq4Pk1x4+fzCfhz+FxLwKNUq95pQEtjre
        7fm/Owh4aKhT3zQZcKcXTA7Szw==
X-Google-Smtp-Source: ABdhPJyb/BEP9mJoL1RpL20RH+Q8i1MKzoGl1tSo55m13uMQcZrHOrIVQIJiC/lW0QvegrL/3HqJkw==
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr13582903pgu.278.1635172555538;
        Mon, 25 Oct 2021 07:35:55 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id cm16sm984666pjb.56.2021.10.25.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:35:54 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:35:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] KVM: x86: APICv cleanups
Message-ID: <YXbAxkf1W37m9eZp@google.com>
References: <20211022004927.1448382-1-seanjc@google.com>
 <23d9b009-2b48-d93c-3c24-711c4757ca1b@redhat.com>
 <9c159d2f23dc3957a2fda0301b25fca67aa21b30.camel@redhat.com>
 <b931906f-b38e-1cb5-c797-65ef82c8b262@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b931906f-b38e-1cb5-c797-65ef82c8b262@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021, Paolo Bonzini wrote:
> So yeah, I think you're right.

Yep.  The alternative would be to explicitly check for a pending APICv update.
I don't have a strong opinion, I dislike both options equally :-)

Want me to type up a v3 comment?
