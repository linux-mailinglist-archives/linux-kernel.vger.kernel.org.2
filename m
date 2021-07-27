Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA753D7E40
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhG0TEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhG0TEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:04:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7E8C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:04:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g13so23440345lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57qgj1c6LCtY+XqJGr03UfT/+n6dkMmVsE0B06Lumzw=;
        b=uuT/okmd4zjIpxDDKkIo5gwpx+QtKyHJ0E93R3t5hro9Z87Vm4vz5rNCAD//WAeMPV
         zOEicokwcFP1XJzeU0QnQB5S8BBb04pEiud4bpWXTt/nvK2A5j6ZBhMZf5kZyxa0QJ8J
         Qe11/8Lt+wGkL20lOcaHSWvcsQ/6ShSlkSMdczrYuYnNAvPVjjz8GxsBShYUets5Oq48
         G4vSYSb3yEiZa0PfCxyfc0UbKGC5tjeLzrk26FtR6WkNg630ZMyrgnA6vO2Aha+ECMa/
         InceSka+YBQDZP8g3EyZtT3KB8/D/V20jMaSy60mHEm/RxAYKDfIOA6a6NUEh9uNuzUS
         YjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57qgj1c6LCtY+XqJGr03UfT/+n6dkMmVsE0B06Lumzw=;
        b=jArJmyj4BImxp1wDflnGbbsYyiQaKwNLrvFie97cNwIIZiD6H3kHaFwS+tUUPlHin2
         h5/89cmwNfMJ8N158cu2dgcVbf7K5FWa30IQi77ur1/yXi8vncM0AEpXOvp9h4x6cskE
         Ts2sYaJOLU0Mn6BTPcEcKpO1JVKUF9NlMoZiEuZXUz0mD5fHaQjRp0DICxiQhSBJUCLC
         fn1Wnuvgk/mwFLhNA2d1tCIrz7Qh0zDIxecsQPHKWcabh3nHf6qrduyv2PnTLgSNvM95
         kRZbJB58hO0VW3iXavf4dTUSjyvHqfXSPf2THh5u8+9ETvQU2Eqh6mgDzEtoH7ZUnU1s
         /T1A==
X-Gm-Message-State: AOAM533S4nH2lM2tomBg2a23bqjITeZuDPLnYHXg+ZJVsZeSPG9dNJP0
        qpPJ6Fz2dVt64N10uuk0ccxgcBvu41pZbdJ5tq+g0A==
X-Google-Smtp-Source: ABdhPJxLr8+coUojLcpoNK8iBCbQyiX5qGUJUc6ABlCOlILu34Y6PX4HXl0Qji3LqTu4Wjm0wAA98vz5rrkNeYeNO+w=
X-Received: by 2002:ac2:59db:: with SMTP id x27mr17500966lfn.547.1627412669994;
 Tue, 27 Jul 2021 12:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com> <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
 <0fcf5740-2e0f-4da7-be58-77822df54f81@kernel.org>
In-Reply-To: <0fcf5740-2e0f-4da7-be58-77822df54f81@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Jul 2021 12:04:18 -0700
Message-ID: <CAKwvOdmMpLcYEKSyTavUmK-CxuR6H55ogwLQzRA1q12RuUYNNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 7/27/2021 10:39 AM, 'Nick Desaulniers' via Clang Built Linux wrote:
> > Isn't -Wunused-but-set-variable enabled only for W=1 builds?
>
> Maybe Bill's tree does not have commit 885480b08469 ("Makefile: Move
> -Wno-unused-but-set-variable out of GCC only block"), which disables the
> warning for clang just like GCC for regular builds?

Looks like 885480b08469, which landed in v5.13-rc1, so that's a
possibility.  Should that be sent to stable@ so that we don't observe
these warnings for non-W=1 builds of stable branches with newer
versions of clang?
-- 
Thanks,
~Nick Desaulniers
