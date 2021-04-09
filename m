Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CE35975F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhDIIO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhDIIO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617956054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0WtewEB21VR9buYKo7EFc1sWeqSCtJz+J9VX2xS7d0=;
        b=cxlMHljZ5ACH7Jw9ioPrnNhRBaxOt45MLnAj5r5MIDUwpYS5rqyEYtZ3m8nGyTl27kjlg0
        mBOlBsI371D+NzBvd7AFFz/lEDqvtGGDLoADB3iDKWqNalU21r0eUeyX27QhbMVxNlu+11
        zA/048/mmVE8arTAWUPiC+y/P5hnp5U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-8fJnD2UaM-Gl5bXQPNmILg-1; Fri, 09 Apr 2021 04:14:12 -0400
X-MC-Unique: 8fJnD2UaM-Gl5bXQPNmILg-1
Received: by mail-ej1-f71.google.com with SMTP id jx20so1882717ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 01:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M0WtewEB21VR9buYKo7EFc1sWeqSCtJz+J9VX2xS7d0=;
        b=o6HwsuFoeDZpd22j45NuG0Opb9tHXNA2NmRYiDfiHrKucdkrvT8scjmt5LW4TxY3Qs
         IZmMD+IMoIOBRQvaLvcBj3J1pstIjd8L9/kvxswRK+boke9yQn4uSP8a7FUCO7NWW6ED
         rv8+Ssh0jV+oM6TcDEvOKh696LTh3n5r85YB/nxQJL/ickfC5zmr6FCmiLUcrq30b6Mk
         O3PkHlscb2PRchC8dxBt6m8uT3nC3VrUpyoYclssYgdFqcsXLcA3Jft/1Gs2K9fr/Kga
         mM+W0fc4q9wjTu+4J5o7o9ocu4wD4Ix8bwpiHOopYw9gsdFfIv08z5tUb5a3LwZAUvRB
         Saqg==
X-Gm-Message-State: AOAM533PW8l7dNBQ7qF0u8ICa78LI2ay7nbsZu+LKdCdjuULbpW97t3A
        6IFHwhgAS24YjslEmeY1RcqQ1hSI8vjSdDdDiLLJ3LzacwTVMc3trJa6iowcMBFZ77Kihycw7jT
        eq2tb/AnVCSnSnCAU1wBeMiyJ
X-Received: by 2002:a17:906:468b:: with SMTP id a11mr14853926ejr.190.1617956051449;
        Fri, 09 Apr 2021 01:14:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZDjr8pGY0n9Fs4qsXTDO5ldcdsheAJLSO7rFz9v3VPmkLdykCNxPW8r3nTwSE1zNy8TkPew==
X-Received: by 2002:a17:906:468b:: with SMTP id a11mr14853907ejr.190.1617956051215;
        Fri, 09 Apr 2021 01:14:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id rh6sm853598ejb.39.2021.04.09.01.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 01:14:10 -0700 (PDT)
To:     jejb@linux.ibm.com, Steve Rutherford <srutherford@google.com>
Cc:     Ashish Kalra <ashish.kalra@amd.com>,
        Nathan Tempelman <natet@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        dovmurik@linux.vnet.ibm.com, lersek@redhat.com, frankeh@us.ibm.com
References: <20210316014027.3116119-1-natet@google.com>
 <20210402115813.GB17630@ashkalra_ubuntu_server>
 <87bdd3a6-f5eb-91e4-9442-97dfef231640@redhat.com>
 <936fa1e7755687981bdbc3bad9ecf2354c748381.camel@linux.ibm.com>
 <CABayD+cBdOMzy7g6X4W-M8ssMpbpDGxFA5o-Nc5CmWi-aeCArQ@mail.gmail.com>
 <fc32a469ae219763f80ef1fc9f151a62cfe76ed6.camel@linux.ibm.com>
 <CABayD+c22hgPtjJBLkhyvyt+WAKXhoQOM6n0toVR1XrFY4WHAw@mail.gmail.com>
 <75863fa3f1c93ffda61f1cddfef0965a0391ef60.camel@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC v2] KVM: x86: Support KVM VMs sharing SEV context
Message-ID: <ed7c38cd-4cfd-9f36-dd81-b8d699fd498d@redhat.com>
Date:   Fri, 9 Apr 2021 10:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <75863fa3f1c93ffda61f1cddfef0965a0391ef60.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/21 03:18, James Bottomley wrote:
> If you want to share ASIDs you have to share the firmware that the
> running VM has been attested to.  Once the VM moves from LAUNCH to
> RUNNING, the PSP won't allow the VMM to inject any more firmware or do
> any more attestations.

I think Steve is suggesting to just change the RIP of the mirror VM, 
which would work for SEV but not SEV-ES (the RAM migration helper won't 
*suffice* for SEV-ES, but perhaps you could use the PSP to migrate the 
VMSA and the migration helper for the rest?).

If you want to use a single firmware binary, SEC does almost no I/O 
accesses (the exception being the library constructor from 
SourceLevelDebugPkg's SecPeiDebugAgentLib), so you probably can:

- detect the migration helper hardware in PlatformPei, either from 
fw_cfg or based on the lack of it

- either divert execution to the migration helper through 
gEfiEndOfPeiSignalPpiGuid, or if it's too late add a new boot mode and 
PPI to DxeLoadCore.

Paolo

> What you mirror after this point can thus only
> contain what has already been measured or what the guest added.  This
> is why we think there has to be a new entry path into the VM for the
> mirror vCPU.

