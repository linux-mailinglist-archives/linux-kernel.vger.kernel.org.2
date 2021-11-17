Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A6454C71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhKQRuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239624AbhKQRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:50:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53DFC061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:47:43 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z6so1627660plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwSTsWKREBd0j1OPxgShIGxpysANOcsMn/XRkTtpEHE=;
        b=F/j/ko2lWx+RLWuivdYMCWp8SCc94lKtTOBlvbRq9MU9ZxmZ4fr17+lqzPhFfE2zTs
         9LmZ8JDDiho3dgt1lwT0LRtseEqUCE0nNa2Wh2idE4y74SbgOnfwOqcbkNSdXykARnob
         diD0ZZs04Nydp98DDRfttmnQPlMrtUpcnzLMuD9dFzTQJ3hgbXU+QBXcqy/repz3Ki5a
         6DC8WAepwBICqmFRqGnpnk0D6ryApUtMBDjsZcNVJLPtqgNII95ibYGDH4GFrXg9r/ws
         ZpEJgrrVSLSjlhMuaJwXA5RHv8ekuldQ3gVpipQ2JO39Fu3STOuRS6hSRSXonts9OawM
         sfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwSTsWKREBd0j1OPxgShIGxpysANOcsMn/XRkTtpEHE=;
        b=YpT46V2Fhe5Bo3O6pzW7naqgmJar/uu0aBpGg2T6PsOtZfLzVflWZM/2XTOfAOZjxl
         LXEYFfy0WqSY9Ldxqw5DYyCCkqK5LFRLunkfhkWOp0dhj1XrDpHxIpK3h2yBPc4qz3Kn
         pbic/eKEEyfJNZoHaZgSrbLU4+rgyJSLnx4WTnJnbjfoXapWg1LmZxZb+ec1oCU1d+dJ
         O4HOaXBRTo0pjaFjKTOTBxfWcG+f59D1IMHJ2tKgjdA3Mh5SWTUHR2lUUNyL3Y+2e0At
         FI+brkGiixxaT7FlIdIyavQqbindGI1hHkypLM10CtivZEnL5X6/KAUVd5nNy0lOP9bD
         r4aA==
X-Gm-Message-State: AOAM532Sz7p38RhkTouFYPCu1Z3nZTI56nItQWF82vTiSfO1bMxSjYhw
        CLQ5czbM7hzyS+KkSwBjtgsIGiWMePkA0hx2qz8nxQ==
X-Google-Smtp-Source: ABdhPJzbaDw8BTsyna8LfzocHNBbcTgEWn0dMfdtuOafOJTEG6dZIOm8878lO/uZDHmQDRsRtP1ZTi/L/syebrv9oPs=
X-Received: by 2002:a17:902:db07:b0:141:ea12:218b with SMTP id
 m7-20020a170902db0700b00141ea12218bmr58724450plx.46.1637171263009; Wed, 17
 Nov 2021 09:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20211117163809.1441845-1-pbonzini@redhat.com> <20211117163809.1441845-4-pbonzini@redhat.com>
In-Reply-To: <20211117163809.1441845-4-pbonzini@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 17 Nov 2021 10:47:32 -0700
Message-ID: <CAMkAt6o8HUBogtWmXVqzkeoXn9Tfb19yQnhUHb0Rp7bLjA6vkA@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: SEV: cleanup locking for KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 9:38 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Encapsulate the handling of the migration_in_progress flag for both VMs in
> two functions sev_lock_two_vms and sev_unlock_two_vms.  It does not matter
> if KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM locks the source struct kvm a bit
> earlier, and this change 1) keeps the cleanup chain of labels smaller 2)
> makes it possible for KVM_CAP_VM_COPY_ENC_CONTEXT_FROM to reuse the logic.
>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Peter Gonda <pgonda@google.com>

I like the cleanup thanks Paolo.
