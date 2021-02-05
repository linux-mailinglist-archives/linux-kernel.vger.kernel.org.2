Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40F31173B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhBEXkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhBEOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:20:10 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D5EC061D7C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:57:01 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id k204so6330818oih.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KW2YxiWoUuY8qaPcgZBtVIfE9G2SZ880I/V6+RY2NjM=;
        b=N12CL2qYs6a2FVeLxgBeR7Lp6MiE/N/1gLXkEYnhRuu3M9cI27p9vE7lykcsRajlC6
         6f4FgBPO/JkI9yH9elY1krGGqcHBGI/Fbkgmhx9LPNDseJHpRGdbwobkatdN1lCFDEmh
         GTwKZvr3KVeb8r6H0/ex4pFx9ly444yQ+hQXfJeQdG8Rim+UI4YKIEiCjWyqmpCpsRyE
         146uy6CySZ7TbOzgd/YiVDEFgYMV9FExjiAM0xokhhVn0LlGYvsAWegwEKf/M11M90O7
         QjtKPsrdqZMgQTOqWdJKfCZJq4krA6mBMoQEYnRmsw6H7ngZEt/tcqcukTaBpjriEwRq
         xDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KW2YxiWoUuY8qaPcgZBtVIfE9G2SZ880I/V6+RY2NjM=;
        b=a7HW5Z2v6xX3UUSfN4S0mZ57PptEL0kc4HslnF+BDpU86sYl0rg0A6ntMzYIrX2t02
         3cKhO1YuHFFq6N7mHF6IIsJoiDK/2II8H45qUSczjdFl8lXG/1Glczxv0rTcKDqkf9Mr
         uJQWZyq1+aJo1XzH92D+3TCDftD+VrDSBYGJ5cTIiB852FI3qa2mFggfLlkWrO3ExyZ6
         C6w5EAOrMS89EJwPPsF3cGHubQAuHcHGvQ22SEJgpbZytaKSfnrtzIUGDS9gnflYQtYe
         kXG3MzYso08i31YTyjStLxYukXaZa4gjuberyENYpUfnknq6gMiHfxWWnKUr1Nk4eO2T
         zEsA==
X-Gm-Message-State: AOAM532yiaBaS4yGLzfrBL7McjiUWB83wmr4aqBrBsnRA18GusRirhQI
        jN6W++1zUJrShszwGGO5deP8Gg+JB44=
X-Google-Smtp-Source: ABdhPJwxnLX0P2jLQp2TSikWJzseQNTQ/Sl3m2VTSjQp4jJO0x9Nl9kpAg+2awirDD+ZiHXJCIQ08Q==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr4290989pjb.29.1612536200978;
        Fri, 05 Feb 2021 06:43:20 -0800 (PST)
Received: from localhost (g186.222-224-165.ppp.wakwak.ne.jp. [222.224.165.186])
        by smtp.gmail.com with ESMTPSA id g22sm9582305pfu.200.2021.02.05.06.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:43:20 -0800 (PST)
Date:   Fri, 5 Feb 2021 23:43:17 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Cc:     geert@linux-m68k.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] openrisc: use device tree to determine present cpus
Message-ID: <20210205144317.GK2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
 <20210131212752.GG2002709@lianli.shorne-pla.net>
 <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 12:49:31PM +0100, Jan Henrik Weinstock wrote:
> Use the device tree to determine the present cpus instead of assuming all
> CONFIG_NRCPUS are actually present in the system.
> 
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>

Hi Jan,

I cannot apply this patch, it seems you somehow sent it signed as a multipart
message via Thunderbird.

This causes errors when trying to apply, even after I tried to manually fix the
patch mail:

    Applying: openrisc: use device tree to determine present cpus
    error: sha1 information is lacking or useless (arch/openrisc/kernel/smp.c).
    error: could not build fake ancestor
    Patch failed at 0001 openrisc: use device tree to determine present cpus

Can you send this using 'git send-email?'

If not I can get it applied with some work, otherwise you can point me to a git
repo which I can pull it from.

-Stafford
