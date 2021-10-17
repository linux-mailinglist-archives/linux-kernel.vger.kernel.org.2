Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B2430CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 00:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbhJQWhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 18:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233585AbhJQWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 18:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634510104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2amCF2t2yxpSnm4H6NQfAANQp7T0Ry525nyuBhj1de4=;
        b=Zy+I2+dWF2EqKlqxQLcPBxP1gb4kiWxmD1NRCBS5uvPghcZe9dWIkoXHpnJ5JmyMFXe/hw
        CZ5ZhDy8E3gLLuLjdh46xddeHKb7BjRuh1HFoGs0wgs1SwfBuHBG5f5iRmieA0MjP1vQ2k
        eAQEbGo82XTKKOWhRNfbq4WYcqvjzPA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-EgQNRQ6LMGiKFyBMoynD_A-1; Sun, 17 Oct 2021 18:35:02 -0400
X-MC-Unique: EgQNRQ6LMGiKFyBMoynD_A-1
Received: by mail-wm1-f72.google.com with SMTP id p12-20020a05600c204c00b0030da46b76daso2633700wmg.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 15:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2amCF2t2yxpSnm4H6NQfAANQp7T0Ry525nyuBhj1de4=;
        b=CrOIOxbmlxUgJsy6Tkpso2YQgDe/2Nm3J32V0J18CKOqB9QUgWLoGy5VaUbzddc8ET
         cTGwJYnsTvsuFuv0RiSRMxgjar/aWaDx3JiQPS4zyY6mLtRN3GokaixX87mxAiR8n9C2
         GHhbT0RqJUkPTb60eyZrMqwTolR5omuEg1whYASVJFKuvJOecklSFRMJ0JyAywX0SanQ
         JgxFC0W5BVeCByL9jMVq7j93TDeg4QZpbEBecDDREtzWkCNDsIm9iPCtyGJU+toplz7r
         jIV4+dQFaqEqH9F39oe4lQCFh2OHEThFxwQVf/K/MJRzcs5uzlwIAEuRdxnql/KWdlBx
         AWhw==
X-Gm-Message-State: AOAM530/hxdmycMO4SZW/MU08twb37EQWWoVNaJOFoBu1UPR3ekELfd3
        gvw2Mja1GguLaee7oIWYqgLsg+bCB14j1I0eStNiB3ReYx+PdLKwQ6m+S18D21hXEdCYdPitH5B
        8bMd7/o4Cf24wfvNmP++7FzAS
X-Received: by 2002:adf:bd91:: with SMTP id l17mr31240808wrh.261.1634510101134;
        Sun, 17 Oct 2021 15:35:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgj20T9S3Mhwu8ZNtDbLyBNpvrhbSd2ZDUigIL0zI5BROsECa6WuvGKc+POusCIh1A5SJpsg==
X-Received: by 2002:adf:bd91:: with SMTP id l17mr31240797wrh.261.1634510100960;
        Sun, 17 Oct 2021 15:35:00 -0700 (PDT)
Received: from redhat.com ([2.55.147.75])
        by smtp.gmail.com with ESMTPSA id n7sm5189381wrp.17.2021.10.17.15.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 15:34:59 -0700 (PDT)
Date:   Sun, 17 Oct 2021 18:34:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
Message-ID: <20211017182145-mutt-send-email-mst@kernel.org>
References: <20211011075945-mutt-send-email-mst@kernel.org>
 <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
 <20211011142330-mutt-send-email-mst@kernel.org>
 <4fe8d60a-2522-f111-995c-dcbefd0d5e31@linux.intel.com>
 <20211012165705-mutt-send-email-mst@kernel.org>
 <c09c961d-f433-4a68-0b38-208ffe8b36c7@linux.intel.com>
 <20211012171846-mutt-send-email-mst@kernel.org>
 <c2ce5ad8-4df7-3a37-b235-8762a76b1fd3@linux.intel.com>
 <20211015024923-mutt-send-email-mst@kernel.org>
 <d5e755fd-41a7-7c3f-f540-094c1c583365@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5e755fd-41a7-7c3f-f540-094c1c583365@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 06:34:17AM -0700, Andi Kleen wrote:
> cutting down the insane cc list.
> 
> On 10/14/2021 11:57 PM, Michael S. Tsirkin wrote:
> > On Thu, Oct 14, 2021 at 10:50:59PM -0700, Andi Kleen wrote:
> > > > I thought you basically create an OperationRegion of SystemMemory type,
> > > > and off you go. Maybe the OSPM in Linux is clever and protects
> > > > some memory, I wouldn't know.
> > > 
> > > I investigated this now, and it looks like acpi is using ioremap_cache(). We
> > > can hook into that and force non sharing. It's probably safe to assume that
> > > this is not used on real IO devices.
> > > 
> > > I think there are still some other BIOS mappings that use just plain
> > > ioremap() though.
> > > 
> > > 
> > > -Andi
> > Hmm don't you mean the reverse? If you make ioremap shared then OS is
> > protected from malicious ACPI?
> 
> 
> Nope
> 
> >   If you don't make it shared then
> > malicious ACPI can poke at arbitrary OS memory.
> 
> 
> When it's private it's protected and when it's shared it can be attacked
> 
> 
> > 
> > For BIOS I suspect there's no way around it, it needs to be
> > audited since it's executable.
> 
> 
> The guest BIOS is attested and trusted. The original ACPI tables by the BIOS
> are attested and trusted too.
> 
> Just if we map the ACPI tables temporarily shared then an evil hypervisor
> could modify them during that time window.
> 
> -Andi

I thought some more about it.

Fundamentally, ACPI has these types of OperationRegions:
SystemIO | SystemMemory | PCI_Config | EmbeddedControl | SMBus | SystemCMOS | 
PciBarTarget | IPMI | GeneralPurposeIO | GenericSerialBus |
PCC

Now, SystemMemory can be used to talk to either BIOS (should be
encrypted) or hypervisor (should not be encrypted).

I think it's not a great idea to commit to either, or teach users
to hack around it with command line flags.  Instead
there should be a new SystemMemoryUnencrypted API for interface with
the hypervisor. Can you guys propose this at the ACPI spec?
If not but at least we are in agreement I guess I can try to do it,
have a bit of experience with the ACPI spec.

And I assume PciBarTarget should be unencrypted so it can work.

-- 
MST

