Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A132331DEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhBQSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhBQSJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:09:29 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44511C061793
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 10:08:32 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w18so8910663pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 10:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O90jLhGQ0RlHH4NdJj1oYXN3dRv0sZyXJBNmJ5tDDck=;
        b=ccD4MgD+0kioofgsnxt8DyI25aYiEYy+iVxXgzfZgcUmXIE3HaN/0iKS2GoDYhhpnN
         eC+b6ILU16zRbOdh7hTbeVY8Z66gm4NzWtEzPCJvOUJr6GcRMEGgo8rC0kgvekNs7qZK
         JPhNd4FnNGqiQq4c1v1K7k9wn6I1tdAeq2/Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O90jLhGQ0RlHH4NdJj1oYXN3dRv0sZyXJBNmJ5tDDck=;
        b=Cfo9QW8ioulbbOg/KLwTFbuCGYDt8B3cUKXQSxDWSCv2rloPEYpusNzMVrxh/W9nkm
         oLE+tEWZLwPKAAP/3wgno1p3YUZIUb/SCVeDGNl0ItCtBX9G1VwFoQuRkbsObHth9MOk
         UO06CR/TPIf81AB4UuMtFj60jjeLTcujRbCfGbjIzdrcR9+dzWyVC+3R+arwv7m+HOIh
         DgZ3gk9ybFbm9lOJItI7Bxl0vWoSqLYNhccSE+zjK4lNBD8ZWWgJAC4+Z4a8PBizT2lG
         S8R9G6Fyz/BevrJLtaJ3RG9nNGrda5G35JxatBW1Qq+luHc5NOlbDvOFBGPE8es4HsNG
         pstw==
X-Gm-Message-State: AOAM533CqCKNecJc/tQnmCQiSPLXFbJ42yp6bKRNpzbsyJmAk/vceDhi
        GdjQULygLu0Vtdyw3Cz5VeOF2w==
X-Google-Smtp-Source: ABdhPJy63kvoxKLnifjgM/0FsW+dYrbSO2HWL1L3zMrMkEFWbs7/G2ttJ7BVYEWja1RdeFoRmAHlcA==
X-Received: by 2002:a62:3085:0:b029:1ec:a570:682c with SMTP id w127-20020a6230850000b02901eca570682cmr511282pfw.28.1613585310771;
        Wed, 17 Feb 2021 10:08:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mm8sm2989723pjb.11.2021.02.17.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 10:08:29 -0800 (PST)
Date:   Wed, 17 Feb 2021 10:08:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] clang-lto for v5.12-rc1
Message-ID: <202102171006.DD2F341@keescook>
References: <20210216224751.7367-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216224751.7367-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 10:48:10PM +0000, Alexander Lobakin wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Tue, 16 Feb 2021 12:34:37 -0800
> 
> > Hi Linus,
> > 
> > Please pull this Clang Link Time Optimization series for v5.12-rc1. This
> > has been in linux-next for the entire last development cycle, and is
> > built on the work done preparing[0] for LTO by arm64 folks, tracing folks,
> > etc. This series includes the core changes as well as the remaining pieces
> > for arm64 (LTO has been the default build method on Android for about
> > 3 years now, as it is the prerequisite for the Control Flow Integrity
> > protections). While x86 LTO support is done[1], there is still some
> > on-going clean-up work happening for objtool[2] that should hopefully
> > land by the v5.13 merge window.
> 
[...]
> 
> Seems like you forgot the fix from [0], didn't you?
> 
[...]
> 
> [0] https://lore.kernel.org/lkml/20210121184544.659998-1-alobakin@pm.me

Ah yes, sorry for overlooking that. I can send a follow-up PR. AIUI,
it's usually better for Linus's workflow for me to build on sent PRs
instead of resending. (But given the merge window disruption, we'll see
what happens!)

-- 
Kees Cook
