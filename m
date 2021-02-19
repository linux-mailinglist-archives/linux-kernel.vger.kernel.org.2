Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5D31FC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhBSPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613748833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wiPV+XH0xFOgqDkzIrgb9hABVC++P8dZu7eY2s6gSdA=;
        b=D90OoqpLAt64nmc+dSdHuvWRmOfy2eZkwXled/Qsp6SenmEYJpD/m6jpvl82hGXwq0Q4cE
        mJehGf5P2eQAPGCDAY0dfJHHdnpGnPxO3sx31OOk7fcm+gBEEH/UYyV/VVHwQH036UNa/D
        04e7RVApqQjEydb9D6uKaKf/MpEIrIk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-G4cSN34CNA2xelT4kOLhXQ-1; Fri, 19 Feb 2021 10:33:51 -0500
X-MC-Unique: G4cSN34CNA2xelT4kOLhXQ-1
Received: by mail-ed1-f71.google.com with SMTP id l23so2777403edt.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 07:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wiPV+XH0xFOgqDkzIrgb9hABVC++P8dZu7eY2s6gSdA=;
        b=KfhomKnpz1c04D70Y3XmwtUpm/sMYE1DF/M1F6CuJ9fpQnnUfO9FBRdS5jrxxt8G25
         hM/Q7VHwc9ZBeCDLi2hRn8KiYK0DS/JLCHGKDUua7KQxnsAHfCfz4jbYo38RGrS4Qyx4
         C9L1JAYNpYdWjF+VzIHakQFzIVaF5Of4mdGYWgRULDj0dUoKGcTHsRsg0Ysxf6e0gPqe
         DPsgfyCOoE9u+y8m5/1vRN9qttCZ8HZTVX/6mq7tfcHHcRDgYluFl2nNtd32rjjtB/d8
         7G7oUVdPp5+bk4g7s9Vp7hMzDn//P7CFmkIfVnwVB8N2xGMOGac/j/sIWUvXu1S7mG4I
         1New==
X-Gm-Message-State: AOAM530ZzusiBIOKWvtv+wogIGrGKP4MQMQ/tlAyC+Z39oXqMeZwgKmY
        8hsQK9R5AHu+tZiKc7278Wj2JyFW769/J7RnLrbUy9olT7+hUdV6JIfnl47KkVy8pnO0pHHhD+Q
        kHcVIL0klEC8EfwDoykgHAjLG
X-Received: by 2002:a17:906:2e90:: with SMTP id o16mr8977203eji.467.1613748830738;
        Fri, 19 Feb 2021 07:33:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfbZljLDPsUAwh5LeSvRWiYEyzY3MDR1IKkjscARvyz7vX3Z12ildCjoY1bECMuqPNsruyXA==
X-Received: by 2002:a17:906:2e90:: with SMTP id o16mr8977193eji.467.1613748830551;
        Fri, 19 Feb 2021 07:33:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id rh22sm4718599ejb.105.2021.02.19.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:33:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the origin tree
In-Reply-To: <20210219080235.52c8c7f4@canb.auug.org.au>
References: <20210219080235.52c8c7f4@canb.auug.org.au>
Date:   Fri, 19 Feb 2021 16:33:49 +0100
Message-ID: <87pn0w3wde.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Building Linus' tree, today's linux-next build (htmldocs) produced
> these warnings:
>
> Documentation/virt/kvm/api.rst:4537: WARNING: Unexpected indentation.
> Documentation/virt/kvm/api.rst:4539: WARNING: Block quote ends without a blank line; unexpected unindent.
>
> Introduced by commit
>
>   c21d54f0307f ("KVM: x86: hyper-v: allow KVM_GET_SUPPORTED_HV_CPUID as a system ioctl")
>
> These have been around for some time.

I remember seeing a patch fixing these:
https://lore.kernel.org/kvm/20210104095938.24838-1-lukas.bulwahn@gmail.com/

Paolo, could you please queue it up? Thanks!

-- 
Vitaly

