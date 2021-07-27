Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1895F3D7CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhG0SBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhG0SBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627408882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3ve2LBl56pycpmfaPjVOw8bmB5e513L10q/E/QV624=;
        b=MDLz+FGeaEoRAOop+I2WPhQIiBEpOdEUtaF3IUfR7ZxGA6qJnshjDGAD4l0ikzeLlBXSbl
        FfUQecF3ZnoSInmjI/y7U8Zqp1+JkZi+xR30pP5qWnNDe7XnCHKLY0AxuMVsigF3hPi96o
        9psN6hZRE8g3w/F0IchiG2BzMVOLqhk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-DYz3pAuEPi6F5NfwwShdzA-1; Tue, 27 Jul 2021 14:01:20 -0400
X-MC-Unique: DYz3pAuEPi6F5NfwwShdzA-1
Received: by mail-ot1-f70.google.com with SMTP id j16-20020a05683015d0b02904d6c4f8a8a3so5542454otr.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 11:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=l3ve2LBl56pycpmfaPjVOw8bmB5e513L10q/E/QV624=;
        b=afd29VudQlQtIEFws6MD0JbBI37J6QDf9sien0QsMiwlmFCZKAMe051KJz+XixCNaY
         +pafjV5GcLD9ZYh5QK2GFKryY0UDwbIA3uOS0TexM6dC4aNqR4ci/Ui9FLUwt1lgK+FN
         9ttytHizLf2ctWSd23Cj/q0+/nOR9KMzqAbYcGl9iJ6EsteCfawW8ECemeQDxis/AZLc
         xtnWDo6V/CubJUXwJbm7+7Xix4WaI1mXR7AJU98KmtUGMiZIstvg0xpyAyWy0y8T0ONX
         waKkOZHbgc9L8yJYm3JutEsaS/TmZYLQAtt24qYbgJgM93QSMXHTtyE9vEyEFNveLIcw
         aR1A==
X-Gm-Message-State: AOAM530OdbncqxGf+W75qfwYWjlXHSrmszeSqoJ6d16Y//rpI6NhMoH6
        cE1biP910S/IqilQWQflpiW2YxEXt/+OtF4GTr0ifLCYpa80KRlwgX9FhSScAJVWWaWmH0clps6
        5R20amMNfYdbujtlNb3bqPz82
X-Received: by 2002:a05:6830:1290:: with SMTP id z16mr16147238otp.28.1627408879833;
        Tue, 27 Jul 2021 11:01:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxceHuuEWZyk5OIY/tJfuObz6ctGzXsZrPVW7DXIyY1hsrLGqacGF+MYgp+dgviBsUHRwmow==
X-Received: by 2002:a05:6830:1290:: with SMTP id z16mr16147135otp.28.1627408878209;
        Tue, 27 Jul 2021 11:01:18 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id y76sm664344oie.55.2021.07.27.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 11:01:17 -0700 (PDT)
Date:   Tue, 27 Jul 2021 12:01:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, jgg@ziepe.ca,
        eric.auger@redhat.com, kevin.tian@intel.com,
        giovanni.cabiddu@intel.com, mgurtovoy@nvidia.com, jannh@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: Add "#ifdef CONFIG_MMU" for vma operations
Message-ID: <20210727120116.61ba8e25.alex.williamson@redhat.com>
In-Reply-To: <877dhb4svx.fsf@redhat.com>
References: <20210727034000.547-1-caihuoqing@baidu.com>
        <877dhb4svx.fsf@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 18:35:14 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, Jul 27 2021, Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > Add "#ifdef CONFIG_MMU",
> > because vma mmap and vm_operations_struct depend on MMU  
> 
> vfio_pci already depends on MMU -- what problems are you trying to fix?

Exactly my question, we silenced the randconfig builds without
CONFIG_MMU in commit 2a55ca373501 ("vfio/pci: zap_vma_ptes() needs
MMU").  Surely there are prototypes for vma_area_struct regardless of
CONFIG_MMU and vfio-core having an mmap callback has no dependency on
vm_operations_struct.  Thanks,

Alex

