Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2011A342F70
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 21:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCTUE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 16:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhCTUEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616270691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnGnuCZZHz4XpqGqAahLmMqXi+ESBvx9VOBJS6yQPvo=;
        b=EZOzHxGH8HZVAlFBR1R8RwegZXIlxrcBfFMIHGYvS9lNmwkMXc1D1jBrRR4kRTis6jk+Zg
        /ugwsnV/M29hRh2ia99BFvGFK0vrNEcDer0gCQWcxPHXu0V5yFnhFolEZJtzJa/SA0zKfX
        wPEOIj0bnySVGydiwyQmWvu3KhXBwH4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-dFZ2k8-1MRuiUzzAptNBrg-1; Sat, 20 Mar 2021 16:04:49 -0400
X-MC-Unique: dFZ2k8-1MRuiUzzAptNBrg-1
Received: by mail-wr1-f69.google.com with SMTP id p12so21116362wrn.18
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pnGnuCZZHz4XpqGqAahLmMqXi+ESBvx9VOBJS6yQPvo=;
        b=boAMxLFnvQeZtzenp60nvdgBWlP5DZRZu/25X9nQ27bEv0algsROMJJAp05Ra2W18d
         Un2tk6TREWFDLWKRSbWjjYnq6e0ey7SLnWvQqa+0oAXVclRSpsGJ9sbgNLc0vWGpKmG0
         7DfDqw70gMDy/6Q3/uyxroaqaPbbD/8PhZGQg0k49/g6gpX3hoH+AnKJhM6V6RkyhT41
         9nMSOu8xdnwdNTgZg/Dd9e8C+2w1STxCsGOYafpf5XIpAEcS2m32xPlw2jspZB/aEtsI
         gmrsDi8ywDvXMZ9ZmMHMlpPkeV6JTRhBe0w/dpNW87GCALtUWyY881B5CKBGMwwxfnuT
         hdWQ==
X-Gm-Message-State: AOAM533oQiTVg6ddTcOn9MDuR8Bbh/KbDiUttF3W2yKgv8BWR3oPGycH
        2RBRCnweO7ve5sb3Mn4xLjP3jCKZzu7C5zULOrBEvWhN5CjVLejj+xSMtL6gi61lNcQGBQV2t8C
        jB9JL/RG9qeg1OmSu0Gygb6D9
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr10599185wrz.74.1616270688148;
        Sat, 20 Mar 2021 13:04:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7L9ySoCVBIPu7d6xQw3Xs2Tj/PnDDoZVrDpnDuMVdcWWj5/Ke+oKKH8pTiLrVtFu6ZdfbPg==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr10599168wrz.74.1616270687954;
        Sat, 20 Mar 2021 13:04:47 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
        by smtp.gmail.com with ESMTPSA id l15sm12002303wme.43.2021.03.20.13.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 13:04:47 -0700 (PDT)
Date:   Sat, 20 Mar 2021 16:04:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
Message-ID: <20210320160430-mutt-send-email-mst@kernel.org>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
 <00c5dce8-fc2d-6e68-e3bc-a958ca5d2342@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c5dce8-fc2d-6e68-e3bc-a958ca5d2342@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:52:14AM -0500, Connor Kuehl wrote:
> On 3/18/21 10:17 AM, Miklos Szeredi wrote:
> > I removed the conditional compilation and renamed the limit.  Also made
> > virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.
> 
> Thanks, Miklos. I think it looks better with those changes.
> 
> > The virtio_ring patch in this series should probably go through the respective
> > subsystem tree.
> 
> Makes sense. I've CC'd everyone that ./scripts/get_maintainers.pl suggested
> for that patch on this entire series as well. Should I resend patch #1
> through just that subsystem to avoid confusion or wait to see if it gets
> picked out of this series?

Yes pls post separately. Thanks!

> Thanks again,
> 
> Connor

