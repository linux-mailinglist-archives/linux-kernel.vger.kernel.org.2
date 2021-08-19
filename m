Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38AF3F1F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhHSR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhHSR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:26:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABF5C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:25:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w24so4257281wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IyytWCulA1iPzZ1hS/joKgz0vVkpY6YXu12pfBDZAWU=;
        b=lc9N5bGTNxic8gAviHPJu2O0dJ2glIHBfpM/PkBBFbZgR3IVDoVpBOianNarpnuJzx
         AiiDjU6ZPQTmJsYLO2JthmunWUOCmx7ZCcPMLB4s/yGcBJBm1FRUP69FA18CNFG/dJli
         vwbgTU850MuFPL3F7m2S7z6U00HOzoCecK0aNk5hw9/y68ZCqQkkx5TavMuod+n3zJ79
         IfAswbZJQJZ+j/EYNaK33I0e+kLxDM/GgLfb/riF/y5LXRpg0WLRwO6ulWmxMAAIwRb0
         HXqvys3AQOykdjJ8yUjwHdsLBvcwAvLYOvVPtKOYJXnCcv1KDnpeqi3dNA/x+hSfBq0y
         8VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IyytWCulA1iPzZ1hS/joKgz0vVkpY6YXu12pfBDZAWU=;
        b=VEDrBp8sHeRp4jeHBASEy8x4q6IxxoEBbX5Ap5R2LDLoeuN6W0SIT8YiDwPWtLFHFT
         Hp97ybwNSXlvJdt5228PXjWew8PcoWzIDAN2Bg+40Oqh14u6QdCboO3BraU8doWlCcT0
         B7Omtg4XepH+wWvIHa3K7/kErd/L/iwsP8CyeFFIyUJz3LozPbB64eJs33c0G/ebqwCu
         dPeRAWjUb7+aTsmM0J8CJold/Nto4sPga73b7hPaeRrASEyIaPadnkLwewJV3380wy5g
         El5q7/oqWbGWPFKAVZoNHN7YGKxs7eeSAWToNo5OLKYEsmlwqIjAOXNp+M1DT29mBdfP
         vP1g==
X-Gm-Message-State: AOAM532LZ0lBU79XuRTxNphy1OYSAWBRBfb3M7J2+8LdRa4QZZ1eBJOx
        hBFdHFFXV8dIMSf6rFIQTAC/FCNNAOs=
X-Google-Smtp-Source: ABdhPJxZpe0J9hIThLbLjIkrF0sieeH74U+a7/NRDgoojZsyBl+e1Vn7XndOC4hrnCsXY871xTvtGQ==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr15117731wmn.114.1629393957337;
        Thu, 19 Aug 2021 10:25:57 -0700 (PDT)
Received: from agape.jhs ([5.171.80.14])
        by smtp.gmail.com with ESMTPSA id o14sm3512815wrw.17.2021.08.19.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:25:57 -0700 (PDT)
Date:   Thu, 19 Aug 2021 19:25:54 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
Message-ID: <20210819172553.GA1416@agape.jhs>
References: <20210819100230.GA28768@agape.jhs>
 <YR4uffjFuqvrz1Tp@zn.tnic>
 <20210819121653.GB28768@agape.jhs>
 <YR5dtDvvcgekoIJu@suse.de>
 <20210819134328.GD28768@agape.jhs>
 <YR5haH+K4fjm/cnK@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR5haH+K4fjm/cnK@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joerg,

On Thu, Aug 19, 2021 at 03:49:28PM +0200, Joerg Roedel wrote:
> On Thu, Aug 19, 2021 at 03:43:28PM +0200, Fabio Aiuto wrote:
> > shall I restore back CONFIG_AMD_MEM_ENCRYPT?
> 
> Yes, please restore it.
> 
> Thanks,
> 
> 	Joerg

Your patch works. I've tested the boot 10 times and
worked fine. Tell me if you want me to test some other
ways.

thank you,

fabio
