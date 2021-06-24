Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359203B38E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhFXVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232582AbhFXVq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624571079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KeRdAwcNNl3UNvL7gS+calQEfq/daIB3UMQMP8GOsv4=;
        b=bbW6ZxMuplvDq3GG/TyPgLH7c5PO9Zs7IK+skv0zqxA9adW8e2WhG93VtRr29JDciYA7Gp
        7WpzN3JKMespXKtGUZsq358cprVyTchBCF6wGhmRhBogubU8NmYK9gv0ko8RNm+opQAMa+
        Dribj8IkVt53ZtWPIDGE46gSm6asaZo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-nr-LvkRGNxS0lWFFZ6i6IQ-1; Thu, 24 Jun 2021 17:44:37 -0400
X-MC-Unique: nr-LvkRGNxS0lWFFZ6i6IQ-1
Received: by mail-ot1-f70.google.com with SMTP id l18-20020a9d70920000b029044977534021so4304356otj.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 14:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeRdAwcNNl3UNvL7gS+calQEfq/daIB3UMQMP8GOsv4=;
        b=VzSbKfYeeDVi+CfF/pSL5gMY2RZu5ZmVI7Rxnc4km318roNl+z2mQ2gTFsDsLEz1Hw
         s8e8r5tV/DqXQH9NCoKPBi1VcHC0rRInxx9coVL1PP02pizS4AkC6vYSstz9/RitqtuR
         aISqjh2PUUeXQE5MVkA1mod/1DPy0tOyK9dF/3D8UKYJT0I4Ca9XCP2ttykvhUIuCyrX
         lTn7zueHiQ3j2XGiRmwNZhqSiz07v5EfzDespZJi8Ha1RE6GiB5vTTF8kH5qTMEPIa3g
         uud1Q+E0LDt5ACtzw5XXlUQppuvOymigWI0m+oc//kVo4fmZiYmg5HZyHQn6oHXUVXWW
         M/4A==
X-Gm-Message-State: AOAM532NlA3+1RqKVJko0a3nwoN3yQD8GJVGLln5nUps/iAvADtwWUQv
        hC/BWirPziM5eM2LFFlsIBI3k5vQpGKFFAvoKW8Rvhw5sFtAm3qQF93p0SLUU9eCn0mmyDdiBtW
        Y2qSzNGsASBSynePDDEqQ7hmG
X-Received: by 2002:a4a:9406:: with SMTP id h6mr6294561ooi.36.1624571077065;
        Thu, 24 Jun 2021 14:44:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzngiFzeX+3Rrv7eQ1vM0Kx3YaNV3sTAHNzRmpbmS5NNJhsYj+dxbfIvYWf90i4dBccSyp6dw==
X-Received: by 2002:a4a:9406:: with SMTP id h6mr6294544ooi.36.1624571076823;
        Thu, 24 Jun 2021 14:44:36 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id x187sm931911oia.17.2021.06.24.14.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:44:36 -0700 (PDT)
Date:   Thu, 24 Jun 2021 15:44:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tian\, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Dey\, Megha" <megha.dey@intel.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "Pan\, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang\, Dave" <dave.jiang@intel.com>,
        "Liu\, Yi L" <yi.l.liu@intel.com>,
        "Lu\, Baolu" <baolu.lu@intel.com>,
        "Williams\, Dan J" <dan.j.williams@intel.com>,
        "Luck\, Tony" <tony.luck@intel.com>,
        "Kumar\, Sanjay K" <sanjay.k.kumar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Virtualizing MSI-X on IMS via VFIO
Message-ID: <20210624154434.11809b8f.alex.williamson@redhat.com>
In-Reply-To: <8735t7wazk.ffs@nanos.tec.linutronix.de>
References: <MWHPR11MB1886E14C57689A253D9B40C08C079@MWHPR11MB1886.namprd11.prod.outlook.com>
        <8735t7wazk.ffs@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 17:14:39 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> After studying the MSI-X specification again, I think there is another
> option to solve this for MSI-X, i.e. the dynamic sizing part:
> 
> MSI requires to disable MSI in order to update the number of enabled
> vectors in the control word.

Exactly what part of the spec requires this?  This is generally the
convention I expect too, and there are complications around contiguous
vectors and data field alignment, but I'm not actually able to find a
requirement in the spec that MSI Enable must be 0 when modifying other
writable fields or that writable fields are latched when MSI Enable is
set.

> MSI-X does not have that requirement as there is no 'number of used
> vectors' control field. MSI-X provides a fixed sized vector table and
> enabling MSI-X "activates" the full table.
> 
> System software has to set proper messages in the table and eventually
> associate the table entries to device (sub)functions if that's not
> hardwired in the device and controlled by queue enablement etc.
> 
> According to the specification there is no requirement for masked table
> entries to contain a valid message:
> 
>  "Mask Bit: ... When this bit is set, the function is prohibited from
>                 sending a message using this MSI-X Table entry."
> 
> which means that the function must reread the table entry when the mask
> bit in the vector control word is cleared.

What is a "valid" message as far as the device is concerned?  "Valid"
is meaningful to system software and hardware, the device doesn't care.

Like MSI above, I think the real question is when is the data latched
by the hardware.  For MSI-X this seems to be addressed in (PCIe 5.0
spec) 6.1.4.2 MSI-X Configuration:

  Software must not modify the Address, Data, or Steering Tag fields of
  an entry while it is unmasked.

Followed by 6.1.4.5 Per-vector Masking and Function Masking:

  For MSI-X, a Function is permitted to cache Address and Data values
  from unmasked MSI-X Table entries. However, anytime software unmasks
  a currently masked MSI-X Table entry either by Clearing its Mask bit
  or by Clearing the Function Mask bit, the Function must update any
  Address or Data values that it cached from that entry. If software
  changes the Address or Data value of an entry while the entry is
  unmasked, the result is undefined.

So caching/latching occurs on unmask for MSI-X, but I can't find
similar statements for MSI.  If you have, please note them.  It's
possible MSI is per interrupt.

Anyway, at least MSI-X if not also MSI could have a !NORESIZE
implementation, which is why this flag exists in vfio.  Thanks,

Alex

