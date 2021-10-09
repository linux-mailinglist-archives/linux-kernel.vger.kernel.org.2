Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39CA42783A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhJIJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 05:03:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37852 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhJIJDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:03:08 -0400
Received: from zn.tnic (p200300ec2f1e220071dfbf03a8036444.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:2200:71df:bf03:a803:6444])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D5971EC0478;
        Sat,  9 Oct 2021 11:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633770070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uFgdCYF5FRlmWaSRyHM0mxAEUkaqW/MaZwaHu/Ao7kE=;
        b=nXNFb8n+2ySs3IFKeiNulh6FOQ1ACB9wNdGhbeLeOZgH9QAsxKdICr1vy5DZcfiI/Imbs5
        ab1LafEmC8/rWvBUOTcOeTng12Xf4Y7UaR5yGyMOdjEbFxhZf/2quoTra+fJ2Anp2YyRt+
        F8i9eBoXjzxQza4CSjS6/FvbD4GfTtk=
Date:   Sat, 9 Oct 2021 11:01:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Message-ID: <YWFaUjKEp+5819O/@zn.tnic>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
 <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 01:20:39AM +0000, Quan, Evan wrote:
> Maybe the change below can address your issue.
> https://lists.freedesktop.org/archives/amd-gfx/2021-September/069006.html

Nope, that one doesn't change anything.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
