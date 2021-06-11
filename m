Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EF33A3EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFKJN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhFKJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:13:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A97C0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:11:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so5255570wri.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YElcP8wY/ItH22s2CX3Yk/qIGr089Bxcg+NXSKlpwwM=;
        b=woZ9K25EeoLQgFPoZVy3NGyq6fwzaVKAJZhft3QVaaHAwjel+T2FHYXKeJVF0dq4IV
         KT4si0PHrixQw5HW0jmWLmRYpEtsp3/eZfK1U1nrDfC+VhljAejz/6LwRdKB8Bvb2tMa
         H8J9YWPe2MRbFZbJXcHP9jn7fySM4WPSRK7A5F8GgRiy8AGIsgp23zFDTlJdWTDgJ7cW
         xXmc3PcmEMqJbvIehCJmyyOqmCmZDswRrH03zxLaBPaRmV2V5yqUL83Ikt6z3g2y/aXt
         ybc6xsaj2MgpPjXFU9ob9H9own759QmqW4hygFJqr/9Sgi2hbAlnjJGYMW/I5iO5C/CZ
         ycXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YElcP8wY/ItH22s2CX3Yk/qIGr089Bxcg+NXSKlpwwM=;
        b=hZn90iOl1ZPNqMu1mZnWcqhZuIaYm4WIxNEh+Z/miWwMuKcv3+N4HjfKIn+3aBnW+F
         r7Kf/3OAi8/LQ42WQQAFzyTP3T/5zsX/703tH/tumfDWUbFCoF7y++v4jWhBdtCcFMdR
         5yGYqfQ/WeKOmHiL9MPdAJT3kWSsbt0CgupqEqW+e32EPNC4lzMne89eTpXmdpTLQsDY
         EvfI/JXk/P+7NxPZEBOK4sskJzcq+PFHigOL0L53UHrw+UIMRQFTIVvETcn34++wNmpU
         TOhFays5fEbwySeaWArfjF4G0TQCc2VZ1M4kn/+w8r9JLgmV+W44V49vhxFTjDj/4T/n
         d2CQ==
X-Gm-Message-State: AOAM533cU1CHJ+M5cihIOfHcjNZObW0d4lsJtYSIhynJ6hC2kboGBy6i
        U5zhP24GodgdeuX0wZHQJHSK+oshYjVjSP83+BzmUw==
X-Google-Smtp-Source: ABdhPJygoquYofYpaeSWf98r/mIW7k2U9CQBWHXDLqMaKoPkUUyF4l08eSJo3Yli8sYbBlkW2zzw2hVNtPKpLBXGTGc=
X-Received: by 2002:a05:6000:229:: with SMTP id l9mr2803707wrz.43.1623402704237;
 Fri, 11 Jun 2021 02:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com> <20210610210913.536081-4-tyhicks@linux.microsoft.com>
In-Reply-To: <20210610210913.536081-4-tyhicks@linux.microsoft.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 11 Jun 2021 11:11:33 +0200
Message-ID: <CAHUa44H=vJrkYYTb2T8WPfy6TznQyO8a8wnLCbJUuSE8QO4iuw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] optee: fix tee out of memory failure seen during
 kexec reboot
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:09 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> From: Allen Pais <apais@linux.microsoft.com>
>
> The following out of memory errors are seen on kexec reboot
> from the optee core.
>
> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>
> tee_shm_release() is not invoked on dma shm buffer.
>
> Implement .shutdown() method to handle the release of the buffers
> correctly.
>
> More info:
> https://github.com/OP-TEE/optee_os/issues/3637
>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Do we really need this considering the patch "optee: Refuse to load
the driver under the kdump kernel"?

Jens
