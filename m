Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F542C5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhJMQE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJMQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:04:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA0C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:02:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 187so2854328pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=55jBdElmI7vGZUDfiyYYs7/r8iE1Q78jQcOtXK2VrgE=;
        b=CLhkh67xp+nTgG3pyUWx/y3RsOIjiSOR4R19Y4NrjeOKcOHn1PlyHfsBSAmlABQrze
         U3zuAUyUCgd6BmYLB5CfNmibTRBt/AVzgbg/T1L2dMUv1dZratLvw/mHjT+sZhi4kUmu
         Nd0hb/SbN0Y3Ud14Nc6XtFL9FLmrGswLhGxWRGy982a45bCzfW6b7j6XyDBuD8lh7CHK
         lBLpdzwpouH1h+5FIj3zkHOYNxJuinFd2WlWRDbaAdz4yOURRABQz0Az5UE+ePVQ9Kbl
         YnsmEbPQIE9JHRQmb3B1j8hogmZYSc+j3W/kMC/kDCMguuYP/4GWTI3rqKwDG7yQPpRX
         ZLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=55jBdElmI7vGZUDfiyYYs7/r8iE1Q78jQcOtXK2VrgE=;
        b=qzy6cH6uJIGOBR/cbUfBDIjJxzV+te+nxK+teqx092PH3OGB1v652WXHMWWJqYHEiL
         xySvVtd78NlHhbbXDeIQ5r2UY2Z36FVBAw3/xOpAAALZZjYiNDsHLJa0OH40y5FVl57C
         FNCIzPVjqz6EOscAacToaMW+NkC8jWjvHCClqTmykEJQW3uMT+lgFOxqIb4kfWavjid5
         Pyr7TADYtHpm8QWXlPpBiTx2QwsYIgOhfn+QPoyuItbmzzJkd/z/juoOAMgPbHNBPmws
         BppmnOOh02iHjbJ4AB5SXA4fuNheYkcz2PcYYi9eh8A8ChTmizwE7rh/qzDRXRq3+xij
         Gedw==
X-Gm-Message-State: AOAM531nQqPM79bDj64ruqZFBxoSjnKnQLaSNSeSkRoIWcz+igHEwt1B
        GBvCBxFHf1b6EV5Xk+s/wqY=
X-Google-Smtp-Source: ABdhPJzt+IgPPj62sGtY+lv9g+211XJ1u0iikBxm0XqeSJ2iahmRZjBLd+muXKERM6AVZEnOYwa3Qw==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr29005775pgk.448.1634140970820;
        Wed, 13 Oct 2021 09:02:50 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id p16sm12622116pfh.97.2021.10.13.09.02.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 09:02:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH] userfaultfd: support control over mm of remote PIDs
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YWZCClDorCCM7KMG@t490s>
Date:   Wed, 13 Oct 2021 09:02:48 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03C026D4-EBE8-4649-9C42-63F82941B781@gmail.com>
References: <20210926170637.245699-1-namit@vmware.com>
 <YWZCClDorCCM7KMG@t490s>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 12, 2021, at 7:18 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Sun, Sep 26, 2021 at 10:06:37AM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Non-cooperative mode is useful but only for forked processes.
>> Userfaultfd can be useful to monitor, debug and manage memory of =
remote
>> processes.
>>=20
>> To support this mode, add a new flag, UFFD_REMOTE_PID, and an =
optional
>> second argument to the userfaultfd syscall. When the flag is set, the
>> second argument is assumed to be the PID of the process that is to be
>> monitored. Otherwise the flag is ignored.
>>=20
>> The syscall enforces that the caller has CAP_SYS_PTRACE to prevent
>> misuse of this feature.
>>=20
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>=20
> I think this patch from one pov looks just likes the other patch of =
the
> process_madvise on DONTNEED - the new interface definitely opens new =
way to do
> things, however IMHO it would be great to discuss some detailed =
scenario that
> we can do with it better than the existing facilities.
>=20
> The thing is uffd already provides some mechanism for doing things =
like
> customized swapping, so that's not something new IMHO that this patch =
brings
> (neither is what the DONTNEED patch brings), just like when I raised =
in the
> other thread about umap.
>=20
> So IMHO it'll be great if there can be some elaboration on how the =
"remote"
> capability could help us do things better (e.g., use cases that we may =
not
> solve with linking against another uffd-supported library, or we can't =
do with
> register uffd then fork()).
>=20
> (I skipped the security side of things, as I replied in the other =
thread that I
> think I buy in your point on depending on PTRACE capability and also =
the
> examples you gave on ptrace() and process_vm_writev() are persuasive =
to me,
> but no expert on that..)

Fair enough. Let me get back to you once I can provide more data.

For now, I just ask you to have this patch in the back of your mind if =
any
other change to userfaultfd syscall is proposed to prevent a potential
conflict.=
