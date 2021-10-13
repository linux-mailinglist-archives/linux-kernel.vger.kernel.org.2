Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB542BB77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhJMJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhJMJ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:28:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE743C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:26:16 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ce200e42a3e901495df36.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e200:e42a:3e90:1495:df36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D79CD1EC04D1;
        Wed, 13 Oct 2021 11:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634117174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mzSW+lZEocE/K7VEFrysmA7kJQvRTS0m7rv02eijMs4=;
        b=qt6lM7be63EpV5GkEoIkqUVieASALd/z7ZFtEQfgnNn7cBQU2pmkf+0/sAGqmb5IRJtX8q
        gcE0qUSPEXFZMbj1TtKfwdD/0mdNIb0rwGrGuPDqcnxWLRFlnDGXmKNnipiuRG6dy9TkOd
        xDEA9WeehT2mRoFk6unESyzbMHFc0To=
Date:   Wed, 13 Oct 2021 11:26:13 +0200
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
Message-ID: <YWamNaMAxaw+/9Az@zn.tnic>
References: <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
 <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
 <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWRvl6ymevr7+kiB@zn.tnic>
 <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:19:45AM +0000, Quan, Evan wrote:
> So, I need your help to confirm the last two patches(I sent you) do not affect the fix for the bug above.
> Please follow the steps below to verify it:
> 1. Launch a video playing
> 2. open another terminal and issue "sudo pm-suspend" command to force suspending
> 3. verify the system can suspend and resume back correctly without errors or hangs

Just to confirm: you want me to do that with the last two patches
applied?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
