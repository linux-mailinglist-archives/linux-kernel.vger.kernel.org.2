Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A57368550
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhDVQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:56:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0566DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:55:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso1302533pjn.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n6a5jB5vsbHsHNaYOEmKOrdM81c54DldKWj75CigVaQ=;
        b=CjG6FHmsUDSpGnoGadKDSnlkzv2/jjuV0fuispVRiMf3RBQ8H5atKOj3kVxiyUNJAY
         C3bdxafd0iyjFSFiEZGGEo7fQDYXPDA/mU0z/1F1mM/1/yeJCnpZNb7vz9qHKN327ru4
         jMi/sJYa3DcnmJb6ejURqm9/1MXxl/i/s6wGijsRe0EjdrmCJhHJ98/dIuKDnMBjETZR
         SHuABpIOvHYMd3rQYezi8pOpws3EeDlHv1ADgiNkx5Jv9/R8lsPO06f2Ax4SVCSDgaPT
         DXMlkjNlIhfzi8Tbf768prYzfzYjIr0UmAGOjVSI+WnG7c+D1cnp8dw4a6D/olTbcSZn
         fwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6a5jB5vsbHsHNaYOEmKOrdM81c54DldKWj75CigVaQ=;
        b=XvbFb0qtFH2+GclJecdBRGZCHL71dizsVokIdStxM4LumYIJWKVuCs/YgZJqX0D5KC
         AuKNX4qPHYocEwfJugSXlBQckG38b15Daex4gzo58JrtFNNCGvO7PjXUJFVvl8IlUvS4
         DG74D4RsvqAz7x2Ul85GU2QIoajh3X3Q9OX+GW7EF5w5+nzgAyPb5VNirZmy1cdd80u2
         gEPEDSYBfhmP/rLlQv4s3b+iQ3xDARXu/AZH0PNgc8k6CysnUiyEPA/fiv7eVWnzj60H
         +O2jYtlfukgPvDa+u1KNJ4qpZQRO46tQkmw+EuGNEdf16o5ZmuPDGRZShvUMmmw7dFKq
         SzIw==
X-Gm-Message-State: AOAM530TLRyzLIAATPpkR4Qy9yeFFSmZgJJRKHbjGSPYVErsso6Fvu/9
        h/Io7mJzC/vCFvtJyngbqiHVXg==
X-Google-Smtp-Source: ABdhPJz0rv8gCpduJab4WDKbQoF49ie8V+7gtLo01+J9NCXu4kC15THjV7jhMSoCeM20fugpo0NFdw==
X-Received: by 2002:a17:90a:bb85:: with SMTP id v5mr5059337pjr.106.1619110546372;
        Thu, 22 Apr 2021 09:55:46 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id h11sm2638815pjs.52.2021.04.22.09.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:55:45 -0700 (PDT)
Date:   Thu, 22 Apr 2021 16:55:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2 2/9] KVM: x86: Check CR3 GPA for validity regardless
 of vCPU mode
Message-ID: <YIGqjoHwG+7rHWyp@google.com>
References: <20210422022128.3464144-1-seanjc@google.com>
 <20210422022128.3464144-3-seanjc@google.com>
 <8716951d-cddb-d5f9-e7e2-b651120a51e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8716951d-cddb-d5f9-e7e2-b651120a51e7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021, Paolo Bonzini wrote:
> On 22/04/21 04:21, Sean Christopherson wrote:
> > Check CR3 for an invalid GPA even if the vCPU isn't in long mode.  For
> > bigger emulation flows, notably RSM, the vCPU mode may not be accurate
> > if CR0/CR4 are loaded after CR3.  For MOV CR3 and similar flows, the
> > caller is responsible for truncating the value.
> > 
> > Note, SMRAM.CR3 is read-only, so this is mostly a theoretical bug since
> > KVM will not have stored an illegal CR3 into SMRAM during SMI emulation.
> 
> Well, the guest could have changed it...

That's what I tried to address with "SMRAM.CR3 is read-only".  Both Intel and
AMD state that modifying read-only fields will result in unpredictable behavior,
i.e. KVM going into the weeds would be within spec.  IIRC, there's no real
danger to the host, it'll "just" fail VM-Enter.

SDM:
  Some register images are read-only, and must not be modified (modifying these
  registers will result in unpredictable behavior)

APM:

  Software should not modify offsets specified as read-only or reserved,
  otherwise unpredictable results can occur.
