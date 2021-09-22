Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9C414C52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhIVOrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhIVOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:47:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912EBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:46:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id r7so1669005pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rCwvv55ksRRBZPVu5dfkaaUj0wQlCK647s+02LK9KDc=;
        b=Ptd33SYY0b9VtKRZaOwNHMFlPoO75TZNibpm48/DsYN0B3BAnVd3tD/BhI9WX1Mg/S
         ILLECWbJQ8SLGhT+FLov0jY/4rHIcu/wKb2D0gu2lBFx8ShWch0ssEqEFMgKJfZ182o+
         M5gYXk+36mZqx3QcLTrI2z2UKDy9vhIQ9ZUiMUOLb2P7lMXrJwlYctMV6pbiNVfDcXoz
         LqjKLhLLeJ2Vf8qG3oNZ375re+6Uvk646I/p/z2d8Fs/aHfFyw84tyqMbpag8zyOiM9M
         03Q+Le2wzYiMOfHKm18zbvjBurHUGWxcjKDpoUZXMflylNDJNgnECJL6M5FRscb9EEnW
         9Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rCwvv55ksRRBZPVu5dfkaaUj0wQlCK647s+02LK9KDc=;
        b=E92R7TcPhZJMic3f5+5G4M194JcNdP6IOCZd7ezoHcybifBFzRe4GKy1IjnVFz+S3+
         leLfsFImqh5hKMPZtTP69/jownqcOh3y8hw4OD5WT7EKznSQX1XBmpA48pPcdV3gbuL+
         6wTjd+u5OPwjmn7zZGucyeNvOVHTIRpbL+TJR6wxidXVFd078yegxmRxCmU2k5dUBE9E
         MtlOXzkNDW6D1GKgONs0vHNfvGAWsjvVjSaeOZmYS+pdWrOwNPs+YilW16gkpyaI19P2
         hCzOzU3Y3vwfQ241/vZE6L5bX5IamZAG1NYpDiCihx6PGuD50LHZBhwjYyeHjgINMycm
         FMtg==
X-Gm-Message-State: AOAM531Vp00huchU1Qxrypk9qrV7liSHyWEcabgq12K/Xd+kH4HeQKBy
        ochjmnGtHxHHY7Y0SBPI5Zde3A==
X-Google-Smtp-Source: ABdhPJwU+dyHlhyA/XTKqvfNb2Q4uQkhOvVMY/EtyP7rxZt/Vk5ie7j2lZv72Al+NamQUIEcfeOL/Q==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr11783832pje.176.1632321966848;
        Wed, 22 Sep 2021 07:46:06 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e24sm2801631pfn.8.2021.09.22.07.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:46:06 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:46:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/7] KVM: few more SMM fixes
Message-ID: <YUtBqsiur6uFWh3o@google.com>
References: <20210913140954.165665-1-mlevitsk@redhat.com>
 <22916f0c-2e3a-1fd6-905e-5d647c15c45b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22916f0c-2e3a-1fd6-905e-5d647c15c45b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021, Paolo Bonzini wrote:
> On 13/09/21 16:09, Maxim Levitsky wrote:
> >    KVM: x86: nVMX: re-evaluate emulation_required on nested VM exit

...
 
> Queued, thanks.  However, I'm keeping patch 1 for 5.16 only.

I'm pretty sure the above patch is wrong, emulation_required can simply be
cleared on emulated VM-Exit.
