Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA4368667
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhDVSMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:12:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A236DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:11:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p2so17948738pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zOMECuegHtcnsOJsS2wVXJn/DWHnBqjlDGsQSl/szUM=;
        b=ZM5n2Aq3FEeQFiME92sJqLFtyDxwACpCOvO7R+riBUfsI6FF2pOovYWEL8rUf7yu+z
         b5PSN28LpI1YNx4znYaoZoxlw7qST4AAkqHlLQ4elw+XqqMsIsOSUieIImXevuj/iRMf
         J+NMeG4xkE3cZHBEhlxrJ4Zg1IiYyFf88FBIy1OyRs7wi8n1aTh6jkQC8hWpldOsusQd
         mY9Z3G1sSWAizF9/IOVLWqw7z5AW99XOoEl7Y5GcMPrtBsAUncVmMox2Ch0CmKPKNDDB
         dm5DLcYK2bQUTX936PQRzo4uBsYYroypNX1B5oYNRpH23r3cQtN+SGMERQ6HsbwrNq4r
         wcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOMECuegHtcnsOJsS2wVXJn/DWHnBqjlDGsQSl/szUM=;
        b=hacF6D2LV4oZja/972nXXuLBzb+dWhnWS41HQmsA7gZxlpCm6y0SuVTUgAMCY78HO6
         P4PNwKjiCASFF0erU7gK/8I+twue7LIyhgDIQslQ7Rtpiigc0E6GnGULkuim+prowwtb
         OmmReL3MtDos784xGg9WJ2o4C+PJiZ8KVBg2qGBxVPUI17td6qerSSFA8aQCyk66Fit0
         fIbX8dDteb31zOpzMgyD+6HX3EzoaqWQfr7P7+Yi6w53GaS2cRn4sjfOgo1EdVv2fXuf
         NeBV+9MNULa6fkV1DipVWm3cqo3JSdUEAIEeKTFtB/TMX0+9iPZCsWLin/JE/ObXvlMZ
         rorw==
X-Gm-Message-State: AOAM533xPCyeZMP7JQORLD6LKRC4LWWrQM+nxHmVef3RQd60ZTTdBCpk
        /RWcGzrCYCMaQK4b/pHyQoYsGg==
X-Google-Smtp-Source: ABdhPJyUmvXutdMSvrTI4H44P0tv+nMUQbh213KsgOf9jCsnF0xA1ZF6jKYTW8kNrrAT+y3qpR58Bw==
X-Received: by 2002:aa7:800a:0:b029:250:c8c5:64b3 with SMTP id j10-20020aa7800a0000b0290250c8c564b3mr4432744pfi.23.1619115111014;
        Thu, 22 Apr 2021 11:11:51 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id ft3sm5556349pjb.54.2021.04.22.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 11:11:50 -0700 (PDT)
Date:   Thu, 22 Apr 2021 18:11:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Huang <wei.huang2@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v5 03/15] KVM: SVM: Disable SEV/SEV-ES if NPT is disabled
Message-ID: <YIG8Ythi0UIbO+Up@google.com>
References: <20210422021125.3417167-1-seanjc@google.com>
 <20210422021125.3417167-4-seanjc@google.com>
 <5e8a2d7d-67de-eef4-ab19-33294920f50c@redhat.com>
 <YIGhC/1vlIAZfwzm@google.com>
 <882d8bb4-8d40-1b4d-0742-4a4f2c307e5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882d8bb4-8d40-1b4d-0742-4a4f2c307e5b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021, Paolo Bonzini wrote:
> On 22/04/21 18:15, Sean Christopherson wrote:
> > > Support for 5-level page tables on NPT is not hard to fix and could be
> > > tested by patching QEMU.  However, the !NPT case would also have to be fixed
> > > by extending the PDP and PML4 stacking trick to a PML5.
> > Isn't that backwards?  It's the nested NPT case that requires the stacking trick.
> > When !NPT is disabled in L0 KVM, 32-bit guests are run with PAE paging.  Maybe
> > I'm misunderstanding what you're suggesting.
> 
> Yes, you're right.  NPT is easy but we would have to guess what the spec
> would say about MAXPHYADDR, while nNPT would require the stacking of a PML5.
> Either way, blocking KVM is the easiest thing todo.

How about I fold that into the s/lm_root/pml4_root rename[*]?  I.e. make the
blocking of PML5 a functional change, and the rename an opportunistic change?

[*] https://lkml.kernel.org/r/20210318201131.3242619-1-seanjc@google.com
