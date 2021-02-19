Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5192431FF36
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBSTHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:07:49 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7578C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 11:07:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so15358144ejf.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 11:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77PV6s4gIH9a1VzZckQTu3z67SAfM9/Sc+3Js4Gjgvo=;
        b=hCTdHliF5L9G8ZuMk18k/qMgmy17gjoxP8UWTiDwyICwg1HB9FW28guF/3Tk3XtuYC
         1ldBQfAkIODBQCCfslAl4sv9BFXHdhTAwkQMHbkvVRf/HrnJBuoztJoCaal05tXrj9Qw
         qPzpDZd114JOtfAalnAx/VTYTkk/4RHmqB5yNWQk379dcsgI2ux3Gd2ArwdKvuCEBfWe
         usqCPbgDNcX0PcOzaeI6dDRPvK/J9nmwvJLhlzovMTLHJu2pzR/KC+Z9K7qlXSwryPLZ
         curCdxPuQa4rvnxnnE2RIVuqtk76O62+YJwF69chHR7hHf9THjscOXSZT7ZY8s5t4tqG
         pb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77PV6s4gIH9a1VzZckQTu3z67SAfM9/Sc+3Js4Gjgvo=;
        b=ZsTo1DCcG1HtXo2usehtdSqOLoQrrTrbVBao9fPadqsWL/FHnR9USSj+FB/tOx/BPe
         MXDJI1Ruxkg5mQC48x7e+EvyOLum2/3B0Tyu1Rmk33HaGxMNEk9YdCXLD10FboqolwHx
         9rC/iGrnlbEcZNcJLtqymy6DFvglKBHw5IK0KQAJFH0WJPg9eFq95rW8UrS+vcFISJqd
         slg1TcguBRg0LaRp4+m6QRvpa8u514FIRRipYAQoNpyvPmiZli3oWidhJsStEMHlWf2W
         JQP+17XfK09Zn17L27VuJwYE7thZC5mrj1dRc6McaN5A2YDvOI0g5MzX9Sgb67DXmcds
         I14Q==
X-Gm-Message-State: AOAM533bh/2q6czR7hLodpGiXqTJ6nETE9fV9RTHplBrZeYHEsWDKci3
        EyDYYBNEoemo8BrUF3Db7DBbJyKR/VHw0BKLr0gn3A==
X-Google-Smtp-Source: ABdhPJzR/lDvqtJqbIDmLhn0O9ySj8OmzkPHoknmUinPK2eIBAAft6YfYF0ouX9fR9U2QYr3Wa7RMjAc3EwHMJYLDaA=
X-Received: by 2002:a17:906:3c58:: with SMTP id i24mr4285681ejg.383.1613761627426;
 Fri, 19 Feb 2021 11:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20210215185908.257724-1-pasha.tatashin@soleen.com>
 <20210215185908.257724-2-pasha.tatashin@soleen.com> <20210219175341.GC6352@willie-the-truck>
In-Reply-To: <20210219175341.GC6352@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 19 Feb 2021 14:06:31 -0500
Message-ID: <CA+CK2bBpXyobT=rjVtY_pFhug4RcveGk_XB4zDBTX=vZBOkaLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kexec: move machine_kexec_post_load() to public interface
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morse <james.morse@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 12:53 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Feb 15, 2021 at 01:59:08PM -0500, Pavel Tatashin wrote:
> > machine_kexec_post_load() is called after kexec load is finished. It must
> > be declared in public header not in kexec_internal.h
>
> Could you provide a log of what goes wrong without this patch, please?
>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Do you have a link to the report, or did it not go to the list?

Hi Will,

https://lore.kernel.org/linux-arm-kernel/202102030727.gqTokACH-lkp@intel.com/

It is also linked in the cover letter.

Thank you,
Pasha
