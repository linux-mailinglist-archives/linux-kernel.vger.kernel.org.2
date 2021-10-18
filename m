Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE76E432251
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhJRPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhJRPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:12:35 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615AC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:10:21 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id d20so10400383qvm.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=bjUQsS/JhsFJ7A/LEPaXRPi0vFqsL9QJaIIVS2Ss/90=;
        b=tQE6cJE0pnAsHfyrGzoPORr9usUSs4bYLfxYaZXCWEWCfUev0+FAX9wWRn2z3hxFiJ
         IMRvu72Udfno46/tccNewEb3SPOZKyD93p2DdD2U5M/phSeC8Xs2tc6sXwyE9A6pzLaW
         g093t8LCJRNcUhvVFUM7JjwL0ldbok/F3KIdCnr/JhbDz0dPUtPP/jARynNCS7a4rmBJ
         JbD+xOYf4nJxoyjatr/Z0GN7moliDxxUwHf0s3ZS4SVkUEK7Jp7hNq2wjykQgnNVECxJ
         Hpzj3tVyJc6VXVI7GhZoXi7cTrNNlWVl/i6VI9HKLPOZvis7fJ3li4Ml9FdhBLI9f0g3
         ON2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=bjUQsS/JhsFJ7A/LEPaXRPi0vFqsL9QJaIIVS2Ss/90=;
        b=swmYKP4RPK50CXXUTCFQKOocS6BTONpWb1DcTYHCimSrJ93wN30D7wU7fYdwqQaJ5O
         hfDYMxSwlQNV0jQziL+aJZVruElv3hJ+E3lG/rIhw3rHZxDFxdqCUZ9ZsxDZItM+j+a2
         etLIebLI6bcSLY40s3oL/gq6Hi5J0Ij62rBtPXHS2c1b1DzCTBwHc0qQDf7zOn+RUXxU
         9EC19eGZefTllxB8PBLqXkxQSBCD8Pcyx+NqtKOOSR0a1iOVcUTzZMMb1EMmOTr5gOAT
         GaDWNjSJ/gYH0wr2Dz4xYDZSQI3F+nd8rvGJA91cJCNkIxV5rCaXajjarUvK0zSWWqgW
         RZuA==
X-Gm-Message-State: AOAM533dADl4pV0j5HaDzDqWo5K2owTcI9sPrIuStbQsxhTuEpdqR2Zm
        H7EWXX+Y5bkm0/x6G0WHwi4cNgQGNC9tSQ==
X-Google-Smtp-Source: ABdhPJxCgJ9x/5CETUThrOojYpCRJrGzCCvX3YPSssc5SYgXzwTMWfby3XSl47MeFHr0w5mPqjdE1w==
X-Received: by 2002:a05:6214:c26:: with SMTP id a6mr25938114qvd.40.1634569820662;
        Mon, 18 Oct 2021 08:10:20 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id p22sm6308436qtl.83.2021.10.18.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 08:10:20 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     FMDF <fmdefrancesco@gmail.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: Any tracing mechanism can track the executed instructions of a user process in the kernel?
In-Reply-To: <CAD-N9QW0NEi6Jzh-bu0Bb=RFB6405G28t_jtctk_t8Kw+HUpVQ@mail.gmail.com>
References: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com> <CAPj211vRdmJZBQvM-DE+saiY=LwoQdOu0hV-YFcny6worQ46rg@mail.gmail.com>
 <CAD-N9QW0NEi6Jzh-bu0Bb=RFB6405G28t_jtctk_t8Kw+HUpVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1634569818_99419P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Oct 2021 11:10:19 -0400
Message-ID: <104502.1634569819@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1634569818_99419P
Content-Type: text/plain; charset=us-ascii

On Mon, 18 Oct 2021 16:41:14 +0800, Dongliang Mu said:

> I want to log all the executed instructions of a user process (e.g.,
> poc.c in syzkaller) in the kernel mode and then would like to leverage
> backward analysis to capture the root cause of kernel panic/crash.

> Therefore, I need the instruction-level tracing mechanisms or tools.

Tracing just the instructions won't get you where you want to be if
you're going through this approach.

You *also* need to track all the data - the instruction path inside two
different runs of syzkaller may be essentially identical, but pass 2 different
values as the 3rd parameter of a syscall.

You may also have to deal with insane amounts of data - the actual error could
have been minutes or even hours before, or the interaction between two
different processes.

You probably want to take a *really* close look at how prof and friends avoid
infinite regress when code execution drops inside the prof code, because you're
going to hit the same issues.

Or....

You can work smarter rather than harder, and ask yourself what's the minimum
amount and type of additional information to make a significant improvement in
the debugging of system crashes.

For example, 95% of the time, you can figure out what the bug is by merely
looking at the stack traceback. For most of the rest of the cases, simply
capturing the parameter values from the syscall and the basic info for page
faults and other interrupts is probably sufficient, and you can probably
leverage the audit subsystem for most of that. It can already record syscall
parameters, while logging page faults and other interrupts can probably be done
with prof.

At that point, you don't actually *need* every instruction - only tracing
branch and call instructions is sufficient, because you already know that each
instruction between the target of a branch/call and the next branch/call will
be executed.

Similarly, the lockdep code will catch most locking issues. But it won't flag
issues with data that should be protected with a lock, but are bereft of any
locking. So ask yourself: What ways are there to analyze the code and detect
critical sections prone to race conditions? Is there a sparse-on-steroids
approach that wil do the heavy lifting for those? (Note that this isn't an easy
task for the general case, but identifying two or three specific common
patterns and finding a way to detect them may be worthwhile)

And many of the rest of crashes are timing related, and "let's trace every single
instruction" is almost guaranteed to make things slow enough to change/bypass
the timing issue.

So... What's left that would be the most helpful with the least amount of data?

Go look at some threads on linux-kernel.  Look at the kernel bugs that were the
result of a Homer Simpson "D'oh!" moment.  What can we do to make those
bugs less likely to make it into the code in the first place? For the more subtle
bugs, what data finally made the debugging come together?



--==_Exmh_1634569818_99419P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhbY5aAAoJEI0DS38y7CIc4OkH/ROXT+P1YCrstg2hlsp5PFd8
L23nVJEO3BM+1vp7B/GLKZ/cGuRc8vdNWRWOnvAnCPFzlk/DfSUSkL8f2qaI12qB
uDqzhjGhaAnoSbQuiwWlaqYUMIklF0LFui7r1kMHWG7ZjjoFR07cdRkOykhZrD1D
NfLZ/P6v4ySQeGCUa/QcYKWHMLaHzNFdSytS/4LKtB6UCbnNy/zLc3x/LFw1LtVj
ySBkjIUSFWsV/KVdg7mE8ADm6u8vMFe93W6eQUNUMPHay1Nsj7pne/Db+5wCwDSU
M8krCrGeHesN8EaQJvgKbj5oXXoCbU35ViLQ7+ih1/nQ4iGAkc0YJfG91IDSduM=
=Y//A
-----END PGP SIGNATURE-----

--==_Exmh_1634569818_99419P--
