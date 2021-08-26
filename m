Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BCC3F90A6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbhHZWVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 18:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243750AbhHZWVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630016459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zroasAaaMl84Lp8cGgnsSX6CLhufn7UDcF8dOmcgMyE=;
        b=RQJ+j/tRnD5Iy48aUB3IKJ9IOmTnsZXAVbmWg22j+stZxVkzS6XunHe+3nH5KLH3KPuWxD
        Jbpnyrh1giboRTALF1Rh8TnkXCixuggyQ9okom3AO6yQizTCYvoOKBUrsQAygN9H1KABIE
        uMBvarPh6PiWIVpTikySA3xvlL9/Ve0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-YkF4HzlAP8Ck5fb50EgIlg-1; Thu, 26 Aug 2021 18:20:58 -0400
X-MC-Unique: YkF4HzlAP8Ck5fb50EgIlg-1
Received: by mail-oi1-f197.google.com with SMTP id x13-20020a54400d0000b029026825ff437cso2305107oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 15:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zroasAaaMl84Lp8cGgnsSX6CLhufn7UDcF8dOmcgMyE=;
        b=An9UcJoPmRvtVrp9Fi2iccALwyOgkjzX00vdR+4ZRceEUipWzqnySOgdcpfgiwDtqq
         Zh2GN++sfy1wMYbr5Kn54ONEw4JoE+AP34pNQIcXGq1eY4EubHS3Xc5vRifKRJSVRWnM
         16KEB8lmbsz564n/oMJpnOJWI8Ifm2sjD0lc15RntbcxB4YJ1chp0B78vTWNlJBvQnt6
         9vOHNTQbo93dNO+KZadMct8CzPGuEumPLNQtBUh2JtiNsd03vZVQ24PMxH+kdb2oot01
         8wAck6ar893KgAxHssG7Eo4h5wd60J3x6ILoS/+L3mizd3WePu9sucEJZwz/qtDLOLu8
         KbQQ==
X-Gm-Message-State: AOAM531Y4llLOoFLNsZ1oRpwEhnlnChIe7wFY8nGH7bM4Wx4SBcs15e1
        IyxkNQSITP1wImD/1md5xoovkJ9wPwGX3UhYRTzCa9GmOaEZHmRa6PQNl38AaqsIwSRzaXgZ8/h
        GYpdfppcxRA3xXnR7U0fJD4Mj
X-Received: by 2002:a05:6830:441f:: with SMTP id q31mr5265953otv.204.1630016457918;
        Thu, 26 Aug 2021 15:20:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8TozJtnLI8oHWvST2FybzAHXy1mHRyzcLBuZjcgJQTjoQcaruPsL3DLvGDsW5daknmMQbwg==
X-Received: by 2002:a05:6830:441f:: with SMTP id q31mr5265931otv.204.1630016457733;
        Thu, 26 Aug 2021 15:20:57 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u15sm862114oor.34.2021.08.26.15.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:20:57 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:20:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        kwankhede@nvidia.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2 0/2] s390/vfio-ap: do not open code locks for
Message-ID: <20210826162056.304eb7ca.alex.williamson@redhat.com>
In-Reply-To: <20210823212047.1476436-1-akrowiak@linux.ibm.com>
References: <20210823212047.1476436-1-akrowiak@linux.ibm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 17:20:45 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The subject line does not necessarily encompass both patches of this
> two-patch series, but I left it as versions 1 and 2 used this subject
> line and I didn't want to confuse those who reviewed those patches.
> 
> Change log v1->v2:
> -----------------
> * Both of these patches were rebased on Alex's linux-vfio-next tree taken
>   from https://github.com/awilliam/linux-vfio.git.
>   
> * Replaced kvm_s390_module_hook structure with a function pointer to the
>   interception handler for the PQAP(AQIC) instruction.
> 
> Tony Krowiak (2):
>   s390/vfio-ap: r/w lock for PQAP interception handler function pointer
>   s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM
>     notification
> 
>  arch/s390/include/asm/kvm_host.h      |   8 +-
>  arch/s390/kvm/kvm-s390.c              |  32 ++++++-
>  arch/s390/kvm/priv.c                  |  15 +--
>  drivers/s390/crypto/vfio_ap_ops.c     | 127 +++++++++-----------------
>  drivers/s390/crypto/vfio_ap_private.h |   4 +-
>  5 files changed, 84 insertions(+), 102 deletions(-)

Applied to vfio next branch for v5.15.  Thanks,

Alex

