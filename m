Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1037F988
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhEMOTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhEMOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:19:08 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA0BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:17:58 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so2555991otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfnosBslQXQ6G/XHnjEn8kNJdLQMZYIRcVlnHPvH2C8=;
        b=mq4tFwhiYBB2EaSet++vzh5Sr0pU/IBg1ujAlt3d1n8aY0afTSIoGsqVLWsqJAEkyj
         EE2OqfqAJkDAG+W9DlxKQqM559NMkfDH7Lv0PRszYSA7bHr5mDt56BmrlF1fvJNazVZ7
         Ojie/HAjVIAsyV6ibcX25qDqVN6FOCG82G+cyUbg6ZafyoCUontwMeZpXn5+NE2z3QGq
         j25EmTnu7lqWQPmcsxGDGFZL56mhOy/fW736B2xxNVga1uQvZf74YK1jziIQyq9Elxjb
         M6fH10MTu38vp3Pbrk+h9Z6evwEA2vmUyw9fi3p9JA7WgNQb7jipIdrjz/PozkHLD8EU
         pQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfnosBslQXQ6G/XHnjEn8kNJdLQMZYIRcVlnHPvH2C8=;
        b=q52SB/tZYpFX4sJKGXh4GhPpoOWpGi24MDkWiYH5Aa+8ikAs+jzfRAzwJqGSpRFhx4
         eHIM5mIHbhmTjlujkPNShfX/LKTXs93g4bXSRMvdWxncAb6WeLfWtlGpaWgLyAvYXJIz
         GhNXDT/Zn4hsNRtxa9q+HJrq0vkhhzWvCOUzNw53aHqLi/vV8TjK24lN+HzATPwq+l0A
         JvLpkJlS05Pg9M+uxG6SlUfwqtUKq6KRCYTgxtu3cMIVaa4nOpQYMwTsi7sEgITIlm8k
         bBU897LM+AJiwqPRPIh1WW9gyOGjU7lVJJPshRim7Z3uyBSY4dqdBEuOkcdwE8QtM04Z
         xnWg==
X-Gm-Message-State: AOAM5302TS2a2nGlO1/7yJJZkrT9qr973evXAhCwrGgmIu4HI4ijk5Qs
        /IuPgt+WFCjGo4R+xbL4MF5YOV8LqXpjOM8Hlyg=
X-Google-Smtp-Source: ABdhPJxTuKONdTHhjCot+kHIbRUAsCd1jXu+Acx3Qqmz3ej6XXD1jWsLndeTtun90RmyYhqJQhoePg3XzWEPbbCSZPo=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr33353968oti.23.1620915478199;
 Thu, 13 May 2021 07:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210512013058.6827-1-mukul.joshi@amd.com> <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic> <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
In-Reply-To: <YJz3CMBFFIDBzVwX@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 May 2021 10:17:47 -0400
Message-ID: <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Joshi, Mukul" <Mukul.Joshi@amd.com>, x86-ml <x86@kernel.org>,
        "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 9:26 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 13, 2021 at 03:20:36AM +0000, Joshi, Mukul wrote:
> > Exporting smca_get_bank_type() works fine when CONFIG_X86_MCE_AMD is defined.
> > I would need to put #ifdef CONFIG_X86_MCE_AMD in my code to compile the amdgpu
> > driver when CONFIG_X86_MCE_AMD is not defined.
> > I can avoid all that by using is_smca_umc_v2().
> > I think it would be cleaner with using is_smca_umc_v2().
>
> See how smca_get_long_name() is exported and export that function the
> same way.
>
> To save you some energy: is_smca_umc_v2() is not going to happen.
>
> > You can think of GPU device as a EDAC device here. It is mainly
> > interested in handling uncorrectable errors.
>
> An EDAC "device", as you call it, is not interested in handling UEs. If
> anything, it counts them.
>
> > It is a deferred interrupt that generates an MCE.
>
> Is that the same deferred interrupt which calls amd_deferred_error_interrupt() ?
>
> > When an uncorrectable error is detected on the GPU UMC, all we are
> > doing is determining the physical address where the error occurred and
> > then "retiring" the page that address belongs to.
>
> What page is that? Normal DRAM page or a page in some special GPU memory?
>

GPU memory.

> > By retiring, we mean we reserve the page so that it is not available
> > for allocations to any applications.
>
> We do that for normal DRAM memory pages by poisoning them. I hope you
> don't mean that.
>
> Looking at
>
> amdgpu_ras_add_bad_pages
> |-> amdgpu_vram_mgr_reserve_range
>
> that's some VRAM thing so I'm guessing special memory on the GPU.
>

Yes.

> If so, what happens with all those "retired" pages when you reboot?
> They're getting used again and potentially trigger the same UEs and the
> same retiring happens?

The bad pages are stored in an EEPROM on the board and the next time
the driver loads it reads the EEPROM so that it can reserve the bad
pages at init time so they don't get used again.

Alex


>
> > We are providing information to the user by storing all the
> > information about the retired pages in EEPROM. This can be accessed
> > through sysfs.
>
> Ok, I'm a user and I can access that information through sysfs. What can
> I do with it?
>
> > Hope it clears what "bad page retirement" is achieving.
>
> It is getting there.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
