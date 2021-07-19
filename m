Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994903CD5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbhGSM6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbhGSM6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:58:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:01:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso1137wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YWipcSLEOaheP07xex9veQfZl0Z1vV0LQN+2n8cjKsA=;
        b=CNm1BBIQqcgx6zX/dXg0WWmp1MmRgupG3sxzggKPJQJmBNC9naFQbjh7hAKRFoMuT4
         N6kmjOrM7TwVZCUS3ViuT7cilOVw5TUGEk1JvtpcX+dZ0jnr6+P3n3UElg/7Yk+n3cqR
         5dcFbsGLReIGqlwZiYSSUIstzppYHr8STNug0C2hdG9JWZvk3H7aHe69G35165bLgXfF
         Wz/7jDi77m+ARzTOT/sUN9Tp7PXBNcS7I0LYMPtOUhStGhqNAuqTdAxMBDMsPJS+AU5y
         Wf7LifU3sZdwHZPUOhG5v5/ykSoXjkBecRidb642zpacSEv20rn8IkVcf3hUDWKXGZES
         5owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWipcSLEOaheP07xex9veQfZl0Z1vV0LQN+2n8cjKsA=;
        b=j12McohOkEcvjoLBt04dMJWMNpAkgsJzLwSilVVYHMI/KYy1CBs66owXwDSUQMZCRc
         MH76nYe+64ec3qpTk0vLcInvn70yDJ1Ehe6TpkIn6gHa1FzCeUIbqHoBZN/IEEP/NINS
         /tiVZ+yMrV8hezwtXGgftMqmiBW7EXePYi3P3VRd74YxN5/NnPZ/gYTIli23zRzk8MkH
         k0m/WoK+hlxw+Zquo7W6yjRIgEzmD2XiAZQDUAR7IApjmneaP1XCLFhcQuJMcugcHVY9
         knnUTHrfZFMFAiomDSL0Sepb2sVU0F+j9gDR6AUlgA28Ah8fbZ817QmLDu/AW8CWvOU7
         M3NA==
X-Gm-Message-State: AOAM533Mb9HVdK6SYFnGd0K66zI3AlfMGJ/xh/2CY3o+uA4vPAWoJXWS
        3d08s3b7VcmA6MZ4q6+4XEY3ug==
X-Google-Smtp-Source: ABdhPJyYT/YffwHR1fUpFsi8GYZ3DLBHWESA81MHvoJEipodSYGoTNpTuaPUSnMI7u6L0EQikRpzog==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr11503607wmj.83.1626701949064;
        Mon, 19 Jul 2021 06:39:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id p9sm8224430wrj.54.2021.07.19.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:39:08 -0700 (PDT)
Date:   Mon, 19 Jul 2021 14:39:05 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH 05/14] KVM: arm64: Don't overwrite ignored bits with
 owner id
Message-ID: <YPWAeTJMWJ+A7W2c@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-6-qperret@google.com>
 <87im16jwe6.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im16jwe6.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 Jul 2021 at 13:55:29 (+0100), Marc Zyngier wrote:
> On Mon, 19 Jul 2021 11:47:26 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > The nVHE protected mode uses invalid mappings in the host stage-2
> > page-table to track the owner of each page in the system. In order to
> > allow the usage of ignored bits (a.k.a. software bits) in these
> > mappings, move the owner encoding away from the top bits.
> 
> But that's exactly what the current situation is allowing: the use of
> the SW bits. I am guessing that what you really mean is that you want
> to *preserve* the SW bits from an existing mapping and use other bits
> when the mapping is invalid?

Yes, this is really just forward looking, but I think it might be useful
to allow annotating invalid mappings with both an owner id _and_
additional flags for e.g. shared pages and such. And using bits [58-55]
to store those flags just like we do for valid mappings should make
things easier, but no big deal.

I see how this is going to conflict with kvm_pgtable_stage2_annotate()
from your series though, so maybe I should just drop this patch and
leave the encoding 'issue' to the caller -- the rest of the series
doesn't depend on this anyway, this was just small cleanup.

Thanks,
Quentin
