Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863AA30E3D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhBCUH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhBCUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:07:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 12:07:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id q12so941617lfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 12:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kpfh9SxqhbXVAvduWXLkt3nG5WWOIvz3WkEIu4NNz7c=;
        b=O9vxx80gl/k9keknQ6fiZPXocJOOncAcdeIZ6akawRcVRBFNzF5hhkdAGj3EKxTDVO
         0tXEKP9WD5HDHhwvfLBaLBjdXeGl1DsU5Pi/lyCQ2ckXXfJb/LYkljHjpjOKECkyDWdg
         3Go0y3vjTAMTEfVdFupLN71dukSnZnXC92wMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kpfh9SxqhbXVAvduWXLkt3nG5WWOIvz3WkEIu4NNz7c=;
        b=Dox7jrZgO8ngypqdmGAFWHgmb/sXVg/4y9sBP7IvcDDb5P2bSyKmC3cvsRRzOgv9r/
         Ij2jjiy5Ga5ID5yLs/yJA2och0cy2g48/KaR5LYUe3MjgITGbVo6RnH5xBbzA5GmTkn8
         iuS3tYvtzgSZZejV/YJ11R32cSaJEFF6h0DEeYBum2W0mN1CmSzSR9HGgCQ9ftL63qoC
         yDsHrcDsXglJhDpJdYtmfeRC3Ui2X0edqzT01GJAmgyYraXawR/Ug1gGw7yvtPrhLryC
         jC4wfhQlbDYaCNJorsD2VKQbH70jgCZKzZnTMPlp9558ceV1D8EAgT/KaKO3r1im/weo
         o9AQ==
X-Gm-Message-State: AOAM531BccZbZl5YE7vNZDGG54gZEUJz2WADuBoKi9iRl9CWaoiV14pC
        DUHypI7PZucNvO0WHZ1BsUyExuP2NoxhLg==
X-Google-Smtp-Source: ABdhPJzI+PXyFCOBxouc9CvmFGQ1yoUmEhSMsraZkvGXADhOy9HNfjqa5OEdsVb3EIDkkacjBB+kXQ==
X-Received: by 2002:a19:c519:: with SMTP id w25mr2661147lfe.16.1612382829694;
        Wed, 03 Feb 2021 12:07:09 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a10sm338781lfs.18.2021.02.03.12.07.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 12:07:08 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id a8so984367lfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 12:07:08 -0800 (PST)
X-Received: by 2002:ac2:4436:: with SMTP id w22mr2548053lfl.41.1612382828438;
 Wed, 03 Feb 2021 12:07:08 -0800 (PST)
MIME-Version: 1.0
References: <8a358ee4-56bc-8e64-3176-88fd0d66176f@linuxfoundation.org>
In-Reply-To: <8a358ee4-56bc-8e64-3176-88fd0d66176f@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Feb 2021 12:06:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg983RfAiSSo4zLMADEfzLEuoBi+rye30Zrq7Bor8zg_Q@mail.gmail.com>
Message-ID: <CAHk-=wg983RfAiSSo4zLMADEfzLEuoBi+rye30Zrq7Bor8zg_Q@mail.gmail.com>
Subject: Re: Linux 5.11-rc6 compile error
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 11:58 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> ld: arch/x86/built-in.a: member arch/x86/kernel/pci-swiotlb.o in archive
> is not an object
> make: *** [Makefile:1170: vmlinux] Error 1

That honestly sounds like something went wrong earlier - things like
doing a system upgrade in the middle of the build, or perhaps running
out of disk space or similar.

I've not seen any other reports of the same, and google doesn't find
anything like that either.

Does it keep happening if you do a "git clean -dqfx" to make sure you
have no old corrupt object files sound and re-do the whole build?

            Linus
