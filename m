Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34EC41FAFD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 13:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhJBLGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 07:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232621AbhJBLGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 07:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633172677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qto351718/L5ukhIDEPhUdB+4/jOc5k7bmVTjbBmGFU=;
        b=KjolU/u3sKdQGelrWSAOoZE3gu59MY8UOjHHIc0xhzOh4i4LvHzDav+Y3VuWSDlWc636Lr
        c5FAFgPBGFWoKiLrDXqavkCFwGh2tW3WzdHhpitN5n4CWWKc3TlbtL7L8NokA9f1XxukmL
        2gu5cScDnfna3qA35LDEeYD5pjZh02s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ug4L5xqcNcWPN0cmmgsuRA-1; Sat, 02 Oct 2021 07:04:36 -0400
X-MC-Unique: ug4L5xqcNcWPN0cmmgsuRA-1
Received: by mail-ed1-f70.google.com with SMTP id 1-20020a508741000000b003da559ba1eeso12806149edv.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 04:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qto351718/L5ukhIDEPhUdB+4/jOc5k7bmVTjbBmGFU=;
        b=t2E9zVJKlF76MvtnFfpCLusoxUZWsWWxtCVSsKQFw1R+l4caGhqRS9yXiNysVgguNv
         phCGZY7t+btiwJL2YBeI4JAPru4CiUY9pckmT5o47O76kzkhN5ijRLjO/IxivZJSbqFl
         i5a76/dfkTWxwphey9x4izGBaiZkbqpX00cylzPTn2yv7hM1PYvGqRLQaxK/t6T/tKTh
         WnYYWs5s3xAXybEF971IAkNLTI/0MX9BvawtvOUOTB61tZGuBNRDu55+TS91V0ek36gl
         pFh1/JUfJyP/WPUADR2syb1WK0nukkC2AuDBPi/5tLtbv328i9YCvlmevn1XC1GgEFPv
         z/VQ==
X-Gm-Message-State: AOAM5313Za+JAmvWWWSxhDiKNrxcaPdgxnud2qXQ+M8+GlgbhItBdeK9
        7rXoTvnKw40WAs6u4e4zj7+kluJv0avBMpB7vsW9MPHQ69rEjMw3/hkr/cwErFXM7RuPmkh3JLH
        YedId1Z48oiuEidiWcv8MLHyQ
X-Received: by 2002:a17:906:8288:: with SMTP id h8mr3663367ejx.87.1633172675305;
        Sat, 02 Oct 2021 04:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDPoSoXkmNQqJE5Pt6aHzQGKWg+96z9iORt+sMWaffH4hD3Mut3sIH6/2W8YSAjIBpj8fcaA==
X-Received: by 2002:a17:906:8288:: with SMTP id h8mr3663331ejx.87.1633172675106;
        Sat, 02 Oct 2021 04:04:35 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
        by smtp.gmail.com with ESMTPSA id e3sm3959222ejr.118.2021.10.02.04.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 04:04:34 -0700 (PDT)
Date:   Sat, 2 Oct 2021 07:04:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <20211002070218-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> >   Do you have a list of specific drivers and kernel options that you
> > feel you now "trust"?
> 
> For TDX it's currently only virtio net/block/console
> 
> But we expect this list to grow slightly over time, but not at a high rate
> (so hopefully <10)

Well there are already >10 virtio drivers and I think it's reasonable
that all of these will be used with encrypted guests. The list will
grow.

-- 
MST

