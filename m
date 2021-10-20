Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4F434DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJTOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhJTOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:32:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40390C0613E7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:29:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa4so2629730pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XgjWa6urh+2o4wqBD5gUfgDpjgp0SCvskomJgQmYY+0=;
        b=ZSDO6CpOBnedFZe6DFUgjtyUK1MuJ5eE1NN4ZS0TVOkGRHpWKc2a4d/GJ5GoCygH4B
         G19Wh+vwFfSvS/Dii+2/P7ebLqIlqTayyCTdyRcVKKqmuTYIM/1lJEcUIfhbrc4JMm6g
         ZBEvoiE2wfWFJx8AM7EIqyLsFpjHUdsuo8VOjM4mUblUjA129GKFOSWt+3yXmjCBCOCv
         ycPzv2wPbaTsvljugga8WJunvimLGcrD2+1SSxHQoaTJbs2FMtND4ZiyvczkY2SlipVT
         Nra68u2y9R+snfbsjk2avm5dW4b6Xy/JS73pj+ibqtdqHmsgJHUrX5IIBMz/NlxiPQAZ
         yYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XgjWa6urh+2o4wqBD5gUfgDpjgp0SCvskomJgQmYY+0=;
        b=aiseDB/4C4neu3rsrM9k41ai3tyA364LGzaQjHK3E+KeU7nKbP7zVJosLyVZJIEpKC
         F9yGVlJXBl22uIW1QHuMlwS7Mz5p6qvJMrf9V5oHD1ZgASMU2w1t+Ve9YZGf5NiQpCOi
         /o5TNDCnbtES9Jp1PMbvkpcZ9J7jCgxN9p4gAAJtN24jAFFaQPG84glN6eRyTDg8/3ut
         dHNn/TB+iwqtRFw84NAkYERFESmMrzBB4zbi9PCXzDVvECiDP9YI482xMY3iTC5RG2JQ
         zKg0r1ep03w9M7fBC+PwoWqf6V6PwMvOpMbbrxpjattcZFk8OQZIlvdJCRYgx4ZQzO8C
         2Swg==
X-Gm-Message-State: AOAM530BwBSOj/ExCJFaK0ZIJOuDKYpxINpdxwi/mtgWLTuMFjw3E0sP
        SRhT/TQ5jdHWezgZUUyRmovn9Q==
X-Google-Smtp-Source: ABdhPJydu28OpbVkEA/WfwFuZQ8SyRqvPuLD1RDzpFZLwQNLnS7QNg/iWP42bkocOYE/dddoEWSm2Q==
X-Received: by 2002:a17:90a:2a0d:: with SMTP id i13mr284267pjd.166.1634740169636;
        Wed, 20 Oct 2021 07:29:29 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i2sm2774356pjt.21.2021.10.20.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:29:29 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:29:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v5 3/6] KVM: SVM: Move kvm_emulate_ap_reset_hold() to AMD
 specific code
Message-ID: <YXAnxXVxFrS41/ui@google.com>
References: <20211020124416.24523-1-joro@8bytes.org>
 <20211020124416.24523-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020124416.24523-4-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The function is only used by the kvm-amd module. Move it to the AMD
> specific part of the code and name it sev_emulate_ap_reset_hold().
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
