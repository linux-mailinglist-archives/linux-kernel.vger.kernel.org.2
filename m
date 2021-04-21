Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D0E3668AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhDUJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:58:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48024 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbhDUJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:38 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lZ9aW-0000oB-Ad
        for linux-kernel@vger.kernel.org; Wed, 21 Apr 2021 09:56:04 +0000
Received: by mail-oi1-f198.google.com with SMTP id n128-20020aca59860000b0290159ccfcbd31so14583509oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w69aDQG9cNpf5b0EV685HKOFNO6b2Zj1c5cSvT1nQX0=;
        b=CGxyEEUdMfZ4ioTrofGjEc3mVu7+E54xEYooCXexJobmG9dDYcsKRb//1U2bPYgJgM
         wPG69+lEz/UZAP+cbt0OmiM7F/d+LmUNqQqAjpyaRWU0RNT+vpr8JqxEh2Vy3sGIdCsP
         It6pgpqQMogL1q8PQpGdxNRHdnrK2e++7QugL5kpikeN22rSHmKChUkqc0dk2oYguCxL
         CEfEPfbVpBCUtKyFSpsLyi6QDevVcjuNfVBYJZGzXzsMmuYgoRBvN9q4sFDLUoYI7hH9
         uK8S1pF0e1FOp1SuhAoT7bSL38ni7AwB4QDfYGoXm4Tc83QJn60rVngEqDRAs6BPsLBk
         XhMg==
X-Gm-Message-State: AOAM5305tsJKGD9JPHBPOFHjqe6bTvYYfnAKiDHZdEjRXbkAbK/3vonl
        B8NeA8YAZZpxqS0ERrJJ5gVhspSBXpdIwrgJR1u8K6OluZi+yADvwkYFWi9sQ/MPBkRgLtLU1dX
        3tCQK8dQVwsIFxxHU7AjTkdoD26J5DKps7yBVnNGNLM/0X5/CJon/P8pRRA==
X-Received: by 2002:a05:6830:2103:: with SMTP id i3mr3530402otc.303.1618998963334;
        Wed, 21 Apr 2021 02:56:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNaCYKVnX/GUE3g+1WAofUpIkd/l+W1oxzZn6TO9PCUbhsgw+MfZPmq/5T+GCYMTo6x6oYIVLtM056xZE+puo=
X-Received: by 2002:a05:6830:2103:: with SMTP id i3mr3530391otc.303.1618998963140;
 Wed, 21 Apr 2021 02:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <CABTNMG0C7_1xYvgethtdPNTBLAfQEy5xu7q-MG=BbpqF2TwY5A@mail.gmail.com>
 <edbdf635a1f23dfa5d09c7ff8377bc11@mail.gmail.com>
In-Reply-To: <edbdf635a1f23dfa5d09c7ff8377bc11@mail.gmail.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 21 Apr 2021 17:55:52 +0800
Message-ID: <CABTNMG3MZ3rDQjG1xanPiuHik=teHStr+ze1Zzz6zuiewq-JgQ@mail.gmail.com>
Subject: Re: Broadcom 9460 raid card takes too long at system resuming
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        linux-scsi@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 9:21 PM Kashyap Desai
<kashyap.desai@broadcom.com> wrote:
>
> Hi Chris -
>
> Most likely behavior you explained is associated with how much time FW takes
> to be activated.
> In case of actual init from fresh boot, FW is already started running once
> system is powered on, and user may not be aware of it.
> By the time OS boot reach driver load from fresh boot, there was enough time
> spend in system bring up.This is not true in case of resume (Hibernation.).
>
> Kashyap
>
Thanks for the prompt response.

Chris

> > -----Original Message-----
> > From: Chris Chiu [mailto:chris.chiu@canonical.com]
> > Sent: Monday, April 19, 2021 3:45 PM
> > To: kashyap.desai@broadcom.com; sumit.saxena@broadcom.com;
> > shivasharan.srikanteshwara@broadcom.com;
> > megaraidlinux.pdl@broadcom.com
> > Cc: linux-scsi@vger.kernel.org; Linux Kernel
> > <linux-kernel@vger.kernel.org>
> > Subject: Broadcom 9460 raid card takes too long at system resuming
> >
> > Hi,
> >     We found that the Broadcom 9460 RAID card will take ~40 seconds in
> > megasas_resume. It is mainly waiting for the FW to come to ready state,
> > please refer to the following kernel log. The FW version is
> > "megasas: 07.714.04.00-rc1". It seems that the
> > megasas_transition_to_ready() loop costs ~40 seconds in megasas_resume.
> > However, the same megasas_transition_to_ready() function only takes a few
> > milliseconds to complete in megasas_init_fw(). The .read_fw_status_reg
> > maps
> > to megasas_read_fw_status_reg_fusion. I tried to add
> > pci_enable_device_mem() and pci_set_master before
> > megasas_transition_to_ready() in megasas_resume() but it makes no
> > difference.
> >
> > I don't really know what makes the difference between driver probe and
> > resume. The lspci information of the raid controller is here
> > https://gist.github.com/mschiu77/e74ec084cc925643add845fa4dc31ab6.
> > Any suggestions about what I can do to find out the cause? Thanks.
> >
> > [   62.357688] megaraid_sas 0000:45:00.0: megasas_resume is called
> > [   62.357719] megaraid_sas 0000:45:00.0: Waiting for FW to come to ready
> > state
> > [  104.382571] megaraid_sas 0000:45:00.0: FW now in Ready state [
> > 104.382576] megaraid_sas 0000:45:00.0: 63 bit DMA mask and 63 bit
> > consistent mask [  104.383350] megaraid_sas 0000:45:00.0:
> > requested/available msix 33/33 [  104.383669] megaraid_sas 0000:45:00.0:
> > Performance mode :Latency
> > [  104.383671] megaraid_sas 0000:45:00.0: FW supports sync cache        :
> > Yes
> > [  104.383677] megaraid_sas 0000:45:00.0: megasas_disable_intr_fusion is
> > called outbound_intr_mask:0x40000009 [  104.550570] megaraid_sas
> > 0000:45:00.0: FW provided
> > supportMaxExtLDs: 1       max_lds: 64
> > [  104.550574] megaraid_sas 0000:45:00.0: controller type       :
> > MR(4096MB)
> > [  104.550575] megaraid_sas 0000:45:00.0: Online Controller Reset(OCR)
> >  : Enabled
> > [  104.550577] megaraid_sas 0000:45:00.0: Secure JBOD support   : Yes
> > [  104.550579] megaraid_sas 0000:45:00.0: NVMe passthru support : Yes [
> > 104.550581] megaraid_sas 0000:45:00.0: FW provided TM
> > TaskAbort/Reset timeout        : 6 secs/60 secs
> > [  104.550583] megaraid_sas 0000:45:00.0: JBOD sequence map support     :
> > Yes
> > [  104.550585] megaraid_sas 0000:45:00.0: PCI Lane Margining support    :
> > No
> > [  104.550999] megaraid_sas 0000:45:00.0: megasas_enable_intr_fusion is
> > called outbound_intr_mask:0x40000000
> >
> > Chris
