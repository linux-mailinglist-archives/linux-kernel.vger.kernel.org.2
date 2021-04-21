Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1A366FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbhDUQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbhDUQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:20:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663E3C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:19:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j7so20934598pgi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mbowa4eGXVqgNRFl8Ptq/4t6AHbidKrVDS7uCXbthl0=;
        b=jrcHDTFu9cpMi0xHYHXjqVifJleR2lPm5sllZXnWakKs6LOxMF36iBVwx8NJifaig0
         1iQGU6B6C2AtTU85aOq6UML+RmQ6zerTwARKx8rHUjWkfM1v9zoKhTvvgOOMhCGalLUx
         q+nWK84K3zKyXoGcZWcMXOPcY/g6kNj5l+HYJJLL1qsMJBt5PiLPVJXfAGYkowOHYiRd
         y/IowPQH6Zczzrci5sCDhsXJuhZ0yv0mZW7/LlkMUJbZYzARlBeR/MdmlPofuMS0jN4D
         6SU8VppMFKhLbqXf9fhekF/9K/9rhAftQFQFvdk7uGPKO8nyuOacM8EJgwEcjfP2giDl
         ohsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mbowa4eGXVqgNRFl8Ptq/4t6AHbidKrVDS7uCXbthl0=;
        b=oLzuvWEmhrNid1Cqg8dOsVFkYRxmsq2dVsNuF0cgXJatO5hoZs/JyLI1HX4zzEXYpf
         Ydlexn9O8jNYWgetF43szcJ9zGM7voiy3wX4Gz543kYjZkEC23FkXe3PrXwuaTrziXc5
         wfvtHMbsCSh66wy5NAd5CCWzm83cn+nTpin27uoGhDshJt0vwRj0nX1qGiD5EIR0fads
         TIKVAlqeYOrhK2S+SpTy3HssJtliJY0I/eP5FUNu9I5Gv6QliEOhmlruSgiT+8QEITJ5
         7CtZunVuWEiBxG7iRow7BMMkzi+j5XOsLBnwkQK56dMU09xcvYtcuNZn+Hedaczzr8v/
         Qqiw==
X-Gm-Message-State: AOAM530tUqzys+PCed7pC18pZ7tE2PcKxKwhll0B/IIJh4XUrqE3Twln
        yGzznHMvQjkiIlaL7/zDC9Q9yg==
X-Google-Smtp-Source: ABdhPJyFws8ZWFDMZIipUdDjla37bGQRxTnJtkCwK4lkHEftHRqpoty09GrTTnBh2rsn7NW7nQp5PQ==
X-Received: by 2002:aa7:9e4f:0:b029:25e:cf65:c554 with SMTP id z15-20020aa79e4f0000b029025ecf65c554mr16686787pfq.66.1619021980804;
        Wed, 21 Apr 2021 09:19:40 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id a7sm2845087pjm.0.2021.04.21.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:19:40 -0700 (PDT)
Date:   Wed, 21 Apr 2021 16:19:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pl@sslab.ics.keio.ac.jp,
        kono@sslab.ics.keio.ac.jp
Subject: Re: [RFC PATCH 0/2] Mitigating Excessive Pause-Loop Exiting in
 VM-Agnostic KVM
Message-ID: <YIBQmMih1sNb5/rg@google.com>
References: <20210421150831.60133-1-kentaishiguro@sslab.ics.keio.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421150831.60133-1-kentaishiguro@sslab.ics.keio.ac.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021, Kenta Ishiguro wrote:
> To solve problems (2) and (3), patch 2 monitors IPI communication between
> vCPUs and leverages the relationship between vCPUs to select boost
> candidates.  The "[PATCH] KVM: Boost vCPU candidiate in user mode which is
> delivering interrupt" patch
> (https://lore.kernel.org/kvm/CANRm+Cy-78UnrkX8nh5WdHut2WW5NU=UL84FRJnUNjsAPK+Uww@mail.gmail.com/T/)
> seems to be effective for (2) while it only uses the IPI receiver
> information.

On the IPI side of thing, I like the idea of explicitly tracking the IPIs,
especially if we can simplify the implementation, e.g. by losing the receiver
info and making ipi_received a bool.  Maybe temporarily table Wanpeng's patch
while this approach is analyzed?
