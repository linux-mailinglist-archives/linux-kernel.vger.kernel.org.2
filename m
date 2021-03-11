Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2553336F81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhCKKDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhCKKDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:03:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10C6E64E57
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615456982;
        bh=IZhUOXZQW97SEt7AhdlCVGpiMiD01alkMKMxSkgoqA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hhek4bkZm18w24Okb8oRsTjg5ku5rDQgBkrVhj2p+trM4twZ9ySmIxuMmhbdD07dM
         KSbVuS7Ng+FRzsd0WwIc/nPAZBcZoysXO3BuhR5D2IfYEa9HR4fn+CYiljdIzBnfdx
         /4PdKrScmDZRhZHrJrsGiMj7WhQE/PHdYz2ii41HlKQJMyneMtKwf1HvL9rKWTetOK
         djQuxxxmJgmT8/ojlZPnhTVBrhuf2YsNbiAMP5ZepBqDLFJWOlXDzFdIOT/dX/QjL4
         qSSdJwUhwNgjRNwcz7OHrn1rRQTJG7+mnaDnfRWyFo7x216lrwoIpcGBa0VxmTpX7a
         8PkPlb829MINQ==
Received: by mail-oi1-f169.google.com with SMTP id x135so18050426oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:03:02 -0800 (PST)
X-Gm-Message-State: AOAM532JyhktilHL0H5RfmCMboUw3TFbCm8EA6+PAsz6UST3Xk9+6NLm
        bOCOM7vdhb53aZguzgBbb0XHyGRADaU4LvgppU4=
X-Google-Smtp-Source: ABdhPJxLTmcDG+0JhaCSbXj4D7tIF854J7GKcMpDtXvjaR2X2Vi+hMCv3Iykk8MoF7qSYLVxBL/Byug4zmEzJ80cyYA=
X-Received: by 2002:aca:1218:: with SMTP id 24mr61853ois.11.1615456981295;
 Thu, 11 Mar 2021 02:03:01 -0800 (PST)
MIME-Version: 1.0
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com> <20210309032356.20800-1-Felix.Kuehling@amd.com>
 <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
 <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com> <YEexf0/V/YF394bf@myrica>
 <CADnq5_OTeK7-nN57+F+WE+Hdg86uiuTN8c_n0bmCtx40N_wraQ@mail.gmail.com> <7831d401-d1ec-13bb-0b3f-b0e0a1a63f7c@amd.com>
In-Reply-To: <7831d401-d1ec-13bb-0b3f-b0e0a1a63f7c@amd.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 11 Mar 2021 11:02:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a05c8nyYXwy0L65vZaAofdjD3DzuKiyNVsUVeWWQaQDEA@mail.gmail.com>
Message-ID: <CAK8P3a05c8nyYXwy0L65vZaAofdjD3DzuKiyNVsUVeWWQaQDEA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 7:34 PM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
> Am 09.03.21 um 18:59 schrieb Alex Deucher:
>
> There has been quite some effort for this already for generic PASID
> interface etc.. But it looks like that effort is stalled by now.
>
> Anyway at least I'm perfectly fine to have the IOMMUv2 || !IOMMUv2
> dependency on the core amdgpu driver for x86.
>
> That should solve the build problem at hand quite nicely.

Right, that sounds better than the IS_REACHABLE() hack, and would fix
the immediate build regression until the driver is changed to use the prope=
r
IOMMU interfaces.

       Arnd
