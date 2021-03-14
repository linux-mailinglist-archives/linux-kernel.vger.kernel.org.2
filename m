Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5371933A87E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCNWS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCNWSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:18:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81494C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:18:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v9so53947113lfa.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bRZlvg5CYiIyLzMVWaD21PsrnUKpNjmztmF2D3AXb9s=;
        b=T57p5g76assY0/wLTfwohhX/YIpkeBG+zU067GIfZmHO34Lv5KxSEl+TGTdsqJz9fG
         2AVDjssGL59STbfp7jLkRRLs+R5RHxLeukLsY7xhyZWzaS5DwnidP6Qb8NJZeJKn7bpI
         V/S47bCRebSgPpVmrgOYexuI8ayzKhVeGVRyAfmt/rOZ0BUykbRc8w9vGJTGUCUD9D2j
         TKBYpzDs9aswpLKAJe7kyll+18/IZGI4nVkxM+r+3BBrEZZTk+0xVLpaD3p+ds+h01q4
         HS/PBp8wcxAG6iFH41v6bxB5hsGV1KfrP0SV80zayywDn4B3xe/VF3dkXnpxQ1m9l9Ns
         xOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bRZlvg5CYiIyLzMVWaD21PsrnUKpNjmztmF2D3AXb9s=;
        b=T0Rq1v43PQmHe+RmIRZPFYJVDlf3Jy0bjQDarJVbZfLgWIg3TBgiLj02xeYBGZpzmX
         i6we9L0DuXfBVcs+ILc9Q0uzXP6mZ6FgXnDGMdHasJ2p3ehQzcMIyYo9Regq/qeTXSIr
         7UplO6YWZbyvHKAqAXOzdjHbnAMAaeH1O31YiBhu+Tk2P5x66EwCnk2skPFvj7x9GaCJ
         jUjO6aa7QyXYTLxKhmjvMG6utC17YPLrB7u024IYjfE+7er8se3M7StP0EtLB83HOBAE
         I5WuVl5eCAGeSWFH88LW9/qIN/8XOVrDQdaOPqMdesTvkNAYtGxDD6tKgcOTTjlFAQlu
         qwIg==
X-Gm-Message-State: AOAM531p4oFRy58iIG2iESafrAbZFHCSM7mEg+BdlRx0yI6BnyzoBXkB
        xiAnD5NxhZx55KVhdpFuStU=
X-Google-Smtp-Source: ABdhPJwrYRFA8yv0MViVAYfhde3SweDTEMzlXVFvy1TcsHx3xKN4QxNysalSBzkS9LRQ/inoC20Kkg==
X-Received: by 2002:a19:ac43:: with SMTP id r3mr6317023lfc.470.1615760309885;
        Sun, 14 Mar 2021 15:18:29 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id e9sm2749314ljj.52.2021.03.14.15.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:18:28 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 076E15601D9; Mon, 15 Mar 2021 01:18:27 +0300 (MSK)
Date:   Mon, 15 Mar 2021 01:18:27 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <YE6LswIxL1N+8AS4@grain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE53QiJuxsCUeoiu@localhost.localdomain>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 11:51:14PM +0300, Alexey Dobriyan wrote:
> 	prctl(PR_SET_MM, PR_SET_MM_AUXV, addr, 1);
> 
> will copy 1 byte from userspace to (quite big) on-stack array
> and then stash everything to mm->saved_auxv.
> AT_NULL terminator will be inserted at the very end.
> 
> /proc/*/auxv handler will find that AT_NULL terminator
> and copy original stack contents to userspace.
> 
> This devious scheme requires CAP_SYS_RESOURCE.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---

Thanks for catching up, Alexey!
