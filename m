Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C83A4B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 02:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFLAJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 20:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhFLAJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:09:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52132C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 17:07:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v11so3619291ply.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGLFyLESMIgo99vWAnXA3J0lKjK1kQXAD/JyJ1aKsZk=;
        b=QbII9VgB8n74k5K/jFnXpmVK+M1t2h2uYfthcmYVLcLX21+gOXDCMUJ2OEvFRQtZth
         uYhUA0p47+XXAKEXbdlxQeeCpaHRpGsQLd0w/hiz3Me5wpQZD4jiucHL7pUZwj8HbRau
         C2164UGRNBNojotFntcaX1wN4KWUYUNLo5063jEvJy5RFX8h7v6pQPCXLnULVzu2ZTVw
         sqK9AUWZC9WC5ee6tXU84/HUR+5gT1d29ArWcOOss6OZMY2MfFuvU6JyZ5H+aiAK8LZu
         3KF4/t9qw/CgrlcHEqkct40QF2AdfABFL6/vqUCj1/55MuZ/zEEG9RNNAiozR75RgmXL
         CTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGLFyLESMIgo99vWAnXA3J0lKjK1kQXAD/JyJ1aKsZk=;
        b=nhY7b40t4xW8g3VWxS0u5maFit5k9zTw+95YLn8t7OuzKQHjhkh8eoK40/uOPFAeuR
         PUfvkKurb9/Zm1s0eRDW6FBzrQbsq5PFFu6cYUK7ASxlajEAptW3pIPkrL/UxebkLxSI
         KDNCSN1zjh9uIb0lVMUYZ7JfrZl2pmnAzjHnuIt5BzpOl7BpPrkZXaIkLC6cLpRARh9w
         Yyp89tCHGSGOrxW/Zm0413cTmWcp3YD62e+vfriXwdOADcabDEzIVMEjGZzjKlyzujMK
         f2RAqIKNNuj+ZCIaSBVwLD4ecxe7CNs6Znk/IKCTWrb8RpDhuLiLYzsAcaafGMnJhYk8
         5Gdw==
X-Gm-Message-State: AOAM531AVzzLVmOalYFSRMHzEgydH5znkJZnh39jYH4TWiT2NweiaDQr
        cmMorHnkwuFMDqP0I/dEDbGNIkpg1nTfvhp4YJlv8w==
X-Google-Smtp-Source: ABdhPJzWnHWBBuelObRnLJjV0cwtOackeAz3RyD+CKkcuWLFAmuidh4v8+rcKDkgjSaaI097BNGGhzQAwSEoie+Ek/A=
X-Received: by 2002:a17:902:f1cb:b029:10c:5c6d:88b with SMTP id
 e11-20020a170902f1cbb029010c5c6d088bmr6253794plc.52.1623456463807; Fri, 11
 Jun 2021 17:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <162336395765.2462439.11368504490069925374.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162336396844.2462439.1234951573910835450.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210611123953.000054df@Huawei.com>
In-Reply-To: <20210611123953.000054df@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 17:07:32 -0700
Message-ID: <CAPcyv4hU-b1=5eAn=Fs65AwYMQj58txMj_D3Y_Ynq72QO-qJrQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] cxl/pmem: Add initial infrastructure for pmem support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 4:40 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 10 Jun 2021 15:26:08 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Register an 'nvdimm-bridge' device to act as an anchor for a libnvdimm
> > bus hierarchy. Also, flesh out the cxl_bus definition to allow a
> > cxl_nvdimm_bridge_driver to attach to the bridge and trigger the
> > nvdimm-bus registration.
> >
> > The creation of the bridge is gated on the detection of a PMEM capable
> > address space registered to the root. The bridge indirection allows the
> > libnvdimm module to remain unloaded on platforms without PMEM support.
> >
> > Given that the probing of ACPI0017 is asynchronous to CXL endpoint
> > devices, and the expectation that CXL endpoint devices register other
> > PMEM resources on the 'CXL' nvdimm bus, a workqueue is added. The
> > workqueue is needed to run bus_rescan_devices() outside of the
> > device_lock() of the nvdimm-bridge device to rendezvous nvdimm resources
> > as they arrive. For now only the bus is taken online/offline in the
> > workqueue.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I'm not that familiar with nvdimm side of things, so this is mostly
> superficial review of the patch itself.
>
> A few really minor comments inline, but otherwise looks good to me.
>
> Jonathan
>
[..]
> > +static void unregister_nvb(void *_cxl_nvb)
> > +{
> > +     struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
> > +     bool flush = false;
> > +
> > +     /*
> > +      * If the bridge was ever activated then there might be in-flight state
> > +      * work to flush. Once the state has been changed to 'dead' then no new
> > +      * work can be queued by user-triggered bind.
> > +      */
> > +     device_lock(&cxl_nvb->dev);
> > +     if (cxl_nvb->state != CXL_NVB_NEW)
> > +             flush = true;
>
> flush = clx_nvb->state != CXL_NVB_NEW;
>
> perhaps?

Oh, yeah, that's nicer.

[..]
> > +static void cxl_nvb_update_state(struct work_struct *work)
> > +{
> > +     struct cxl_nvdimm_bridge *cxl_nvb =
> > +             container_of(work, typeof(*cxl_nvb), state_work);
> > +     bool release = false;
> > +
> > +     device_lock(&cxl_nvb->dev);
> > +     switch (cxl_nvb->state) {
> > +     case CXL_NVB_ONLINE:
> > +             online_nvdimm_bus(cxl_nvb);
> > +             if (!cxl_nvb->nvdimm_bus) {
>
> I'd slightly prefer a simple return code from online_nvdimm_bus()
> so the reviewer doesn't have to look up above to find out that
> this condition corresponds to failure.

Yeah, not sure why I made that so obscure.
