Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B737FA20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhEMO6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:58:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54934 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEMO6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:58:53 -0400
Received: from zn.tnic (p200300ec2f0e440021f4b7a45291c72c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4400:21f4:b7a4:5291:c72c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CBD11EC023E;
        Thu, 13 May 2021 16:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620917861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AbgyPKG5ZtG/4WqxP4kIpo39kNw3OZzOO2nwU/C30hg=;
        b=oRJpIZArC9T1M+9MNwcVtDwjwfbntLsBzjjToIMCKWfzI3s0eG1Hr+RerU06xPGRegGdNV
        4kXRfxt+dIQV3oe9KG2yNlBVoNz4nQFBNgRjaiKItSEZNZpwuZcOKQHamI3kAxT17XuauI
        AOQFZrfNvojet7MBk7JzSn81CuVsorc=
Date:   Thu, 13 May 2021 16:57:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Joshi, Mukul" <Mukul.Joshi@amd.com>, x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJ0+YbwSpxTrghpo@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic>
 <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 10:32:45AM -0400, Alex Deucher wrote:
> Right.  The sys admin can query the bad page count and decide when to
> retire the card.

Yap, although the driver should actively "tell" the sysadmin when some
critical counts of retired VRAM pages are reached because I doubt all
admins would go look at those counts on their own.

Btw, you say "admin" - am I to understand that those are some high end
GPU cards with ECC memory? If consumer grade stuff has this too, then
the driver should very much warn on such levels on its own because
normal users won't know what and where to look.

Other than that, the big picture sounds good to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
