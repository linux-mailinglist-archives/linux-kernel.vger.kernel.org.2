Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8B42954C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhJKRKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhJKRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:10:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84753C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 10:08:39 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08bb0030636ca0dab1dbfc.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:3063:6ca0:dab1:dbfc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DDF61EC03CA;
        Mon, 11 Oct 2021 19:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633972118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FMJ87cZlHbBg1zdTYi7tsPE0KeMnTTBDJeA7UWr8R9w=;
        b=a7srOT5I3V1nAfaWgJyb2fEz6l0t//DB7j2ThZIftq268LEFtwQwzA638iMS+tkeShTuRl
        EyHPYSJl9d9iy6Iy75WXVLaQeDlmg2yXMe0/0UfIHpbwaChuWZsuR0hm8NNGfnIyQT1NM2
        dQC5fBiuxdX35kQMaQPIMHytezbx+yo=
Date:   Mon, 11 Oct 2021 19:08:39 +0200
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
Message-ID: <YWRvl6ymevr7+kiB@zn.tnic>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
 <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
 <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 08:03:51AM +0000, Quan, Evan wrote:
> OK... Then forget about previous patches. Let's try to narrow down the
> issue first. Please try the attached patch1 first. If it works,

It does.

> please undo the changes of patch1 and try patch2 to narrow down further.

It does too.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
