Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDF37F9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhEMOcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEMOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:31:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781AAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:30:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e440021f4b7a45291c72c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4400:21f4:b7a4:5291:c72c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4340E1EC032C;
        Thu, 13 May 2021 16:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620916242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q/FWCwRMgsRKVUM9zO85vUS6qMZ5capc4M5/7Qx9MH4=;
        b=h1Qbg54LGvKZ62jWfecfrcp4a3gGhPK6L4FS5qF50E3tXNDsNktWaZyOs8Qau1U+w1gqd3
        +ig/uJT6i7HPfQpaEg0+ibjNAuCdy0nI9A9k1zlFCXUPZekk5HQQlax28ig1a7Y7N4HQg0
        gTtCxo2S0OigQUnlkZFnAB0KxlATcR8=
Date:   Thu, 13 May 2021 16:30:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Joshi, Mukul" <Mukul.Joshi@amd.com>, x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJ04D8a6LaVRMuGH@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:17:47AM -0400, Alex Deucher wrote:
> The bad pages are stored in an EEPROM on the board and the next time
> the driver loads it reads the EEPROM so that it can reserve the bad
> pages at init time so they don't get used again.

And that works automagically on the next boot? Because that sounds like
the right thing to do.

So practically, what happens to a GPU in such a case where the VRAM
starts going bad? It might get exhausted eventually and the driver will
say something along the lines of:

  "VRAM bad pages: 80%, consider replacing the GPU. It is operating
  currently with degrated performance."

or so?

Yap, from a RAS perspective, that makes good sense as you're prolonging
the life of the component while still remains operational as good as it
can and the only user interaction you need is she/he replacing it.

Sounds good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
