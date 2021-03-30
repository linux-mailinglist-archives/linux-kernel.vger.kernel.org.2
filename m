Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FC34EEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhC3RJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhC3RGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:06:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBFC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:06:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so1613496pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=U4q+4X4ovNbgyNm+vnYZ55+5sJJ03R3eRaFFwvvHanQ=;
        b=1erBt5yBguM3wu5x53SxPYcY+u0nb/gz/8dRWvk3RKVyKuuKPlloDIcIiBqKotYZCY
         sStJJ0lBlWkWwVaDrw7WHNHg9t9R1rrEpYhSrYYLuP1epKnSWoYHANJEVMSTUXAi2wML
         yk1+3mCKwARJa5NcHHC/g+J63eIL3aR818xSS4VpQ4czEfXr8kULsosM4jm4MIIdgnfM
         FNyeqmJbKVErhig2aRM3bWdc8MIZAJ2JYM5W9NqgWVT//REhUi1GXwDwUZ9LqpyDkpZv
         TIA0GrjSvfVfmmUh2Smsa1Ts1w2JiCvr8DMR6GURTunEuQZzak6C0WZOM9ZEBeK0dTkg
         hKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=U4q+4X4ovNbgyNm+vnYZ55+5sJJ03R3eRaFFwvvHanQ=;
        b=PIZL6aZVCFDk1lzGE2LB+nM9ouVfHqL+rOtRcWttwLgh4ZSanQ26Iu14GcP6AZCcgm
         q4XpJfRQnoRkaV/zeRs7i1GukG/GmVb/ngya4rHcpx82cK8/xJKlSKptm3Zv99HHkn0h
         /ZdWCCsmPS+Jk6BIUqDEHLWJOtyqTIJO2DyX4+4Gah4Ss4lGg64lLdmZmS5t+sogeFbj
         P3DIUNfA/D90m6XG2KWvmBxAw3kUyCIrjYKi8n0xw899zKYje4cOC9QWj/44cbFDQ3SE
         0ZUH6sA7ZKDKuoeBogUN/V4kUJoGZSBPRWHEiiSCe+z11vJuVOUQmWADCs2YzFjEwVSZ
         EFdA==
X-Gm-Message-State: AOAM532RYAk0Ju1QYYTzDZuPHJbIBnofOF6/e3eiTCDiAbepGI3lllYW
        zWhx0SfS81BKbo/ZRIaW15ZRKg==
X-Google-Smtp-Source: ABdhPJwiNtg82+2n7Ww23Sbgvk1m2HyIMfb69Sf2f7CaQTCRDT8JKO/LDuIn1LbMKoFYmV/hJdJ0pQ==
X-Received: by 2002:a17:90a:68cf:: with SMTP id q15mr5261816pjj.231.1617123961665;
        Tue, 30 Mar 2021 10:06:01 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:547a:17da:91e6:2591? ([2601:646:c200:1ef2:547a:17da:91e6:2591])
        by smtp.gmail.com with ESMTPSA id a26sm16241008pff.149.2021.03.30.10.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 10:06:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
Date:   Tue, 30 Mar 2021 10:05:59 -0700
Message-Id: <D652C16A-5CAC-48DF-B6B3-797DC61BBA30@amacapital.net>
References: <CAJvTdKmQN7dXk7FifOqZRZRrOqOoB_6+VR9ORx_AfZWpVRePdA@mail.gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <CAJvTdKmQN7dXk7FifOqZRZRrOqOoB_6+VR9ORx_AfZWpVRePdA@mail.gmail.com>
To:     Len Brown <lenb@kernel.org>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 30, 2021, at 10:01 AM, Len Brown <lenb@kernel.org> wrote:
>=20
> =EF=BB=BFAndy,
>=20
> I agree, completely, with your description of the challenge,
> thank you for focusing the discussion on that problem statement.
>=20
> Question:
>=20
> Is it required (by the "ABI") that a user program has everything
> on the stack for user-space XSAVE/XRESTOR to get back
> to the state of the program just before receiving the signal?

The current Linux signal frame format has XSTATE in uncompacted format, so e=
verything has to be there. Maybe we could have an opt in new signal frame fo=
rmat, but the details would need to be worked out.

It is certainly the case that a signal should be able to be delivered, run =E2=
=80=9Casync-signal-safe=E2=80=9D code, and return, without corrupting regist=
er contents.=
