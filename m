Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82D3D8AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhG1Jjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235679AbhG1Jjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627465177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZYlpvd0wrMNvulsNAlFJD373h3DlBpV9FmzAud/uLI=;
        b=fp4iQm5OVMwzimSby6fBdTsntfeoUE4pZKsnA71OJWHjDZBqJeqnl0ymGb5Z7qWkLZUnmn
        mTUOz0Mnsluv9iEGxvH+XxicjpsJDJsgHwcnIizDPoD7LqcOs8VFM17QIgU54IuEuM6i4c
        pSr4HxmWG/Ct/jbngGvfgQ3+lYIpOE4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-QLnScPHqOVOWroGzJLdPHQ-1; Wed, 28 Jul 2021 05:39:36 -0400
X-MC-Unique: QLnScPHqOVOWroGzJLdPHQ-1
Received: by mail-il1-f198.google.com with SMTP id d9-20020a056e021c49b02902095727d18dso1191125ilg.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ZYlpvd0wrMNvulsNAlFJD373h3DlBpV9FmzAud/uLI=;
        b=cXf4jG0VzsVi3EoEoGqXcV5TiuhmWuF7Xd8vEdP/zsPAaB0s+uadLeTK/DnJjw107U
         +PnNGixGNGpHc58AOsZoomuFvco5Ov0cS8IiHvWmXR4JYpvn6qIwpNctyCB+OYT27Ufc
         H5iA/T6kNM3SUmBVDKLSPUSm+rDq3qRRuZGIuefNVUbi3RhRKzCkF++XPZB//8+6xRBa
         v/Icfn9R3m6bo0f+DYh1Ncy8xOtW1wovSNTmFg5X+HCPESdxNkNo2A4qGl2fvtz2EA4T
         twgsyJ2MF7j/RX8LG97n4oS7gby5f5p0pgvMV7K3Dbuw+pup7nGx2UeejlG21rHLLJJc
         MF2w==
X-Gm-Message-State: AOAM531RGGn/CVgv17mQoQnDLOcSFCA4Kfhi3DQsnzPGBaDxFZsogKCs
        2PuhQ2wDsh4i3LFtiYwGdLMSbvs6HYZLpkFg1I50eXpd4ZyUvxmUEk5szXhQ/ZTLvJ2TfsEbfoy
        9puRoQqME/r27+TNUkz2/ONMsVXBAcuMtRe2RH+Cp
X-Received: by 2002:a92:cec5:: with SMTP id z5mr18759439ilq.226.1627465175920;
        Wed, 28 Jul 2021 02:39:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGQjikI+CcP92C8oA9YNs6Xpubb3f815soKcRbvzy7YTVQlpcJkpzxb3OZh2Rq+Q7nKigYlaFrt4yknkYOVMo=
X-Received: by 2002:a92:cec5:: with SMTP id z5mr18759427ilq.226.1627465175742;
 Wed, 28 Jul 2021 02:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210727111446.119561-1-mlombard@redhat.com> <YQDznBi5NuTIKd+x@kernel.org>
In-Reply-To: <YQDznBi5NuTIKd+x@kernel.org>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Wed, 28 Jul 2021 11:39:25 +0200
Message-ID: <CAFL455=X7aCK=vSBuQZV39gR03mrnc1j+-YHWkWbVor4g89DkQ@mail.gmail.com>
Subject: Re: [PATCH V2] iscsi_ibft: fix crash due to KASLR physical memory remapping
To:     Mike Rapoport <rppt@kernel.org>
Cc:     bp@alien8.de, tglx@linutronix.de, x86@kernel.org,
        pjones@redhat.com, konrad@kernel.org,
        George Kennedy <george.kennedy@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

st 28. 7. 2021 v 8:05 odes=C3=ADlatel Mike Rapoport <rppt@kernel.org> napsa=
l:
>
> Hi,
>
> On Tue, Jul 27, 2021 at 01:14:46PM +0200, Maurizio Lombardi wrote:
> > Starting with commit a799c2bd29d19c565f37fa038b31a0a1d44d0e4d
> > memory reservations have been moved earlier during the boot process,
> > before the execution of the Kernel Address Space Layout Randomization c=
ode.
> >
> > setup_arch() calls the iscsi_ibft's find_ibft_region() function
> > to find and reserve the memory dedicated to the iBFT; this function
> > also saves a (virt) pointer to the iBFT table for later use.
>
>               ^ virtual
>
> > The problem is that if KALSR is active, the physical memory gets
> > remapped somewhere else in the virtual address space and the pointer is
> > no longer valid, this will cause a kernel panic when the iscsi driver t=
ries
> > to dereference it.
>
> Please drop "this patch" and use imperative language, e.g. "Fix this bug
> by..."
>
> > This patch fixes the bug by saving the address of the physical location
> > of the ibft; later the driver will use isa_bus_to_virt() to get
> > the correct virtual address.
> >
> > It will also simplify the code by renaming find_ibft_region()
> > to reserve_ibft_region() and removing all the wrappers.
> >
> > [   37.764225] iBFT detected.
>
> It is better to put the crash report close to the problem description as =
it
> actually shows how the issue is manifested.

Thanks for the review, I will submit a V3 soon

Maurizio

