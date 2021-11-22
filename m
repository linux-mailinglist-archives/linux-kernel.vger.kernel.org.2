Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9874595C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 20:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbhKVTzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 14:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbhKVTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:55:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF81C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 11:52:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so130479pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 11:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R+2NVVaB7HNzmKzz9pvoSqA0OaPLrTBeTq2QxKS1nB4=;
        b=PItd8EYo8Or7WokynjwCq8i4x/kFYinllcqQW39lWPjhQH55Ihfl8074H3A0R5NWdM
         7bwmIv/NVpbT96+rfUIhsSDFQN7pWgdmU/yqB6bJdf9srpYAnFGAbgwyB4Uo2eWh7pRm
         TVx0PLEsVbgfx2vBS0qrsgdS5jeIffJcFJ81iYVAenMiSPmS3GCDmMh6ZzoO4KFD+fPW
         rDqgCbYIk1lE+8oWppClXldsAPfdApQ/aXDXj8RCohAjMA3zkR8ttxqe9zXXeYnLtHSu
         5aBB9sbfBkzu0EQMUkVTgiM8dPa3R3duOims5aLa9QsuCsrUXOUz2gjkGy5bDrNmI8HP
         yLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+2NVVaB7HNzmKzz9pvoSqA0OaPLrTBeTq2QxKS1nB4=;
        b=diqhzzej+NA/KewMqVKROVvXwj6i59UivUbr5C1Iu9gyBoUXLn0WCOpXTEn/TNTEpF
         PrQgFbOOkzcbcohEmIZO+evhTmXbhvvpnbqQhJi9wsPJM1qCpOOdmk8zej/cYf/pta9s
         A12PnFo+/JvmpljGC16ouHlCI4NB27I1onAee0j7oAgnE5EWcE9mkR5CGI3pQ8qi3TQE
         qDho0Urtm5rVBW8sPevGdq2x0sVxh+g7+5+Fm2KXL+R/7f7t0JxeaLa+8eOALLVqPECK
         3TJBJmSblNYMsInxb4D+s6PmluyLV/YLO0ZBaHO78MhU3vk7MTOmXSeJ2hTI48OGmKfW
         NYrA==
X-Gm-Message-State: AOAM531Bq/a4IJ9YD8B6FcjP1iOFXFe23918991iqYtPY9wvM0JDTvzi
        26tEt7ZmZotVFdA9/Fjj58F0Ww==
X-Google-Smtp-Source: ABdhPJwjhM1+Fco2+HarM0SN9NtmRjgRYFfu9c3PjJCXM++heqDPF9Z5D+ei4bDwKF7/qqW/WdoXwg==
X-Received: by 2002:a17:903:32c7:b0:141:eb39:30b7 with SMTP id i7-20020a17090332c700b00141eb3930b7mr75323371plr.41.1637610732883;
        Mon, 22 Nov 2021 11:52:12 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o7sm8484620pjf.33.2021.11.22.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:52:12 -0800 (PST)
Date:   Mon, 22 Nov 2021 19:52:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests: sev_migrate_tests: add tests for
 KVM_CAP_VM_COPY_ENC_CONTEXT_FROM
Message-ID: <YZv06IHPynOqozNA@google.com>
References: <20211117163809.1441845-1-pbonzini@redhat.com>
 <20211117163809.1441845-3-pbonzini@redhat.com>
 <CAMkAt6ovkWTxwhcWMG7UT8X68TogG-0L_6rwTisTfgcWVNapSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkAt6ovkWTxwhcWMG7UT8X68TogG-0L_6rwTisTfgcWVNapSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021, Peter Gonda wrote:
> On Wed, Nov 17, 2021 at 9:38 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > +static void test_sev_mirror(bool es)
> > +{
> > +       struct kvm_vm *src_vm, *dst_vm;
> > +       struct kvm_sev_launch_start start = {
> > +               .policy = es ? SEV_POLICY_ES : 0
> > +       };
> > +       int i;
> > +
> > +       src_vm = sev_vm_create(es);
> > +       dst_vm = aux_vm_create(false);
> > +
> > +       sev_mirror_create(dst_vm->fd, src_vm->fd);
> > +
> > +       /* Check that we can complete creation of the mirror VM.  */
> > +       for (i = 0; i < NR_MIGRATE_TEST_VCPUS; ++i)
> > +               vm_vcpu_add(dst_vm, i);
> 
> Style question. I realized I didn't do this myself but should there
> always be blank line after these conditionals/loops without {}s? Tom
> had me add them to work in ccp driver, unsure if that should be
> maintained everywhere.

Generally speaking, yes.  There will inevitably be exceptions where it's ok to
omit a blank line, e.g. kvm_ioapic_clear_all() is a decent example, as is
kvm_update_dr0123().  But for something like this where the for-loop is a different
"block" than the following code, a blank line is preferred.
