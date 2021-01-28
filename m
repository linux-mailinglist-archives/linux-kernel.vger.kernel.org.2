Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974AB3080B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhA1VpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhA1VpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:45:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16EC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:44:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c2so8320486edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UryGwxPgjxzr4/u3z4SvuCaMZjYGfabFAIjtiGO6Pvs=;
        b=TcKvgVRbjJ35lCfTmcTbelSSKo2zddaqaUSfEsRJUi9Yck2ulzBlgWSrmGOfwEQ9V+
         43cud6LkFN8JshOe9YTtHaX/FhOQZnLmPAZNQpp/1v72NoyIcGEdacnLfTY/57ILzpYP
         xudqv7Bdcs/7Ze6FBjwA/aUJBPko4gQBRadyDsxC482E69iivmRThpCWdak5/IHuOSup
         PCTjcPlNOaahVR14BZwr1PSPun7beqEL0xhuaQZ1qtIytPVvuBSt0lhCjMpJeRsBOvq+
         esTBPv512kcs7xTNIinXGYoQppiBY8oxL3DgtdDHMAg3qo4ozoRyKHGcMgKfEppxPx8a
         AFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UryGwxPgjxzr4/u3z4SvuCaMZjYGfabFAIjtiGO6Pvs=;
        b=VzkZsaMKj4aph9PW1Fveg3KL83RwZNojSwCAIw943F6ObLsYPRpAQhPj8O8b6Cm5Y5
         BtoVVli0YD5woKGzg/K0wogHS07PyjF1LGrAG0GfzK4tnwOIwkM0x7Cy0wOGs4VHsvhx
         qQP1Gf31fdBcvFGGzdU/TYJvHrjR8zo/PDvsJxGvqAhTmfQZQFMqdndbOV1HhTPnnZgJ
         0IFBraW8sfvFmBkXLUqExMfZ5czRbUD/ArP1/RjA8dkoRa59UOIUsA4SHBWqEyynceNw
         SG1Z28aV8ggeOHDPpTugp/SbLNFYUitdS8yy0h4G3LtEFtZDdIlVWJK8st4dr8AwrDyB
         hAnQ==
X-Gm-Message-State: AOAM531zsNnAmN+zevNz1C6tNDB/60xG1Jj4MROhT/7Ko6vleK600Tb/
        pce5gZaQ/Xwng/HOZfIGLevaqPLJ8VG2dmXxL/gTkA==
X-Google-Smtp-Source: ABdhPJxuHXbRfZaW91XiFsjmuPjpmnywMK1wWS6MfC5uxToWbv7z+PDnxPDREQ39/MiYKRvYqrZiOH9nraVI3Wc9hxg=
X-Received: by 2002:aa7:cd87:: with SMTP id x7mr1943964edv.210.1611870266976;
 Thu, 28 Jan 2021 13:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20210126204125.313820-1-pasha.tatashin@soleen.com>
 <20210126204125.313820-2-pasha.tatashin@soleen.com> <87lfcczvab.fsf@x220.int.ebiederm.org>
In-Reply-To: <87lfcczvab.fsf@x220.int.ebiederm.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 28 Jan 2021 16:43:51 -0500
Message-ID: <CA+CK2bBMO+USv3SE25GNQDqpY-+4cEXrKbAmaSmsko=_CS6ZPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kexec: dump kmessage before machine_kexec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 3:01 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Pavel Tatashin <pasha.tatashin@soleen.com> writes:
>
> > kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> > machine_restart(), machine_halt(), machine_power_off(), the only one that
> > is missing is  machine_kexec().
> >
> > The dmesg output that it contains can be used to study the shutdown
> > performance of both kernel and systemd during kexec reboot.
> >
> > Here is example of dmesg data collected after kexec:
>
> As long was we keep kmsg_dump out of the crash_kexec path where
> it completely breaks kexec on panic this seems a reasonable thing to do.
> On the ordinary kernel_kexec path everything is expected to be working.

This is an ordinary kexec reboot path, not kdump.

>
> Is kmsg_dump expected to work after all of the device drivers
> are shut down?  Otherwise this placement of kmsg_dump is too late.

Yes it is. It is called after device_shutdown(); in all other places.


Thank you,
Pasha
