Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1617A426D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbhJHPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbhJHPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:14:42 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7FAC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:12:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id l7-20020a0568302b0700b0054e40740571so6355378otv.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Tc85uSn71zoLgJN5kOaU4Z2ZyYOC67yARPr0fIsiAs=;
        b=Ukui3bvTslBaxIiHycBn+I3BCVItPJm6+KGZ2x/1rbM8E3Sr3DNUE78+jIDvdoCYml
         FgXMbXMd6pjls91EyRtpYwVEJu6WhGVxGy0QPQga1uIwRbJ/YKviHyT6nlri9fsKc2CD
         laPU4eG0bAgQAvYvdv+MFdWvubwBmlmMYXeMzgVDd+wcEZbV6iwGzDirSJTCnBC2f7vy
         GlMULMkiW67T1+9EJ7LP7HbU2qco+EpWoUzMRZJvbVEi/cxm3gidxA6okHfZN48TqeYG
         yEcU1Bd7R7QKf4T0yUVb1H9IsvfLQ7gO79nFlRUgPJnqKXLfRePJb1VYYBvOucrAFEFx
         hS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Tc85uSn71zoLgJN5kOaU4Z2ZyYOC67yARPr0fIsiAs=;
        b=ibzu4+ymKr+lvFI/B0gsnVo+iEMJtmISrqK/an1adtMMds6tYU7atbV2jZ+RN2aMz7
         70oYEbekV1SW7omaUAhaf5C3Vtn6Um3dM9s3+W0JHbxn+8dQ1b/ktXcFHlvsxjMbTNYg
         VTDD+oMV0XdZfuAwcsGHQBD7ELO5SlMR3GvsexyhAF+Elk29bkSOS+k9tlgKsmPIJKLY
         NXo7C6StEumYEMEPUEYTn0PPZ/dcQO4QB7Dpj8NHuyxq9QnO590YRq7HpDrW90x3vPwo
         kWsNsLfEd89Sb+ndThOkrQDweutsVH8h23x8g44n8HVVSssip5p1iKBT222781Jyk7dR
         oGZQ==
X-Gm-Message-State: AOAM533owLQIDIEyK4xBNsNOYa4itTXIkV4jJgxXYxKrIOtEF1jO5jEh
        08jfLZJnTklJVK8UG2zklfLaB+5BF1hzaC0IFKc=
X-Google-Smtp-Source: ABdhPJxUL8KFWOA6AWwUvhY/+LgnqjH8Du3ga2Dn6uJV/M8QEcz3mzomlpDBc7gbhvJV8CdnTACwbJAs+0BfgsT4L10=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr9047755otd.200.1633705966214;
 Fri, 08 Oct 2021 08:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <YV81vidWQLWvATMM@zn.tnic> <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
In-Reply-To: <YWBeD7fd2sYSSTyc@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Oct 2021 11:12:35 -0400
Message-ID: <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Quan, Evan" <Evan.Quan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 11:04 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Oct 08, 2021 at 10:45:47AM -0400, Alex Deucher wrote:
> > I don't have a CZ system handy at the moment.
>
> I could test patches on mine here, if that would help...

Can you try swapping the order of
amdgpu_device_ip_set_powergating_state() and
amdgpu_device_ip_set_clockgating_state() in the patch?

Alex


>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
