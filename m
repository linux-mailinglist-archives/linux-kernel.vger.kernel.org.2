Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD343163C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJRKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhJRKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:39:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C16C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:36:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so40605544wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CnEGvS5JHOdGgOAvyH9jWqTEdXWkoZtVd5ySMVIlc2M=;
        b=nUS9Jfmev2YDtluONWMHfsBhtGgQYYBu4Q+Kf28SCNr2s4YgglFqRJbpMOyOPYX5NX
         hxK9nJ+XQRFqHBXeMsZLop/QPwqALP23LtbQCiDXWRQ7SvxACThuih4FVcXfPZ3+x+yF
         XBOd9FpimNbU1VCXYo96LQJatqe/VGCp+d0Q6so4WLmKclqpFBso6AK5FpvHGN1neGFF
         UrZCMHy513Ugk620ZjW8lwUg6GF1YiMUkwvGuls2BU7O/mH5Kux/gA4VpWO9oQWq3MD2
         AW4sWYa6lA9qBl5b0u+FO6760LXpWUKJ2/UCVUm+ExmdfbjZkZkisT78hyTtvs2A1UFc
         lvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CnEGvS5JHOdGgOAvyH9jWqTEdXWkoZtVd5ySMVIlc2M=;
        b=F9OrI+hNfn8E6amRAGlYkBz+swQTK2YTUuPHf8DgAnGEKVx4Gm9PHXkma6nyO3eDUL
         dQNLYKB61p72c3ExYAEzgG7C1Z/cYwzwN8jKkg8z35C8yp1U6Mq27A7bfoDrEOxTJyDb
         IzQFUPntS2HiFw6vdorEAnbVioAbHPJx3Vs3acXIn8lHFWIcZ6h3wWza2VA9JMi4Wa1h
         3BKR+btvtvfrzYzrtJiYmrFZQoAgPs3vD2slXRp45RGHhpzASBECJJwABd91xP6ULLuh
         z4D71jS3omn4X57cNfJOzP0kcejWsY64Ev1uqzft6WHrruDuee0vpc2vXO0+blr/vNqj
         eDWQ==
X-Gm-Message-State: AOAM530M1uDWKdQPAl56EzPgAmtvmhmNc2qalGfQxIXdJqrvpKautnC2
        j2B3SzGbIkSRFd3YivUJBXaAEw==
X-Google-Smtp-Source: ABdhPJxwV62HytYs4AsqvTvUlMdNokRzwgb0hYlxd00yfiJ21uyA1k1ex6RbulURH1wBC10+z0Zn1w==
X-Received: by 2002:a05:6000:184b:: with SMTP id c11mr34504451wri.29.1634553411421;
        Mon, 18 Oct 2021 03:36:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:ba81:6f1b:ab2e:f120])
        by smtp.gmail.com with ESMTPSA id c7sm15162725wmq.13.2021.10.18.03.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:36:51 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:36:48 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 03/16] KVM: arm64: Avoid remapping the SVE state in the
 hyp stage-1
Message-ID: <YW1OQNuq5Gdd9jpQ@google.com>
References: <20211013155831.943476-1-qperret@google.com>
 <20211013155831.943476-4-qperret@google.com>
 <87ilxxut74.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilxxut74.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 Oct 2021 at 12:04:15 (+0100), Marc Zyngier wrote:
> I actually ended-up implementing a similar patch as part of my 'first
> run' series[1], though I moved the mapping to the point where we
> finalise the vcpu as that's where the allocation takes place.
> 
> Do you see any potential issue with that approach?

Nope, and in fact I think your patch should allow to simplify a bit
kvm_arm_vcpu_destroy() for me, as checking arch.sve_state != NULL would
now be sufficient to know if the sve state has been shared -- checking
arch.has_run_once is no longer needed.

I'll base v2 on this.

Thanks!
Quentin
