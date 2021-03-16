Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8233DCE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhCPSvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbhCPSuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:50:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC466C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:50:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d15so11031486wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZYCIwusXOn9GIbUjPY+Z1gvgGv1eCVcPoYFgPm/ZsBw=;
        b=PghuLEmcLXD6wtSYmtr9Asf1mywcnZil/eiZ7U/X1wOSv14YPWgKWrVsWXrVB1hskv
         VYlpRFINPGuL3IZI9bFlqul5iNue6ol4NzZ03u2n2hr1YUVBfUATmDri09NHWfp29/5d
         hBHdrPxmO2YclrwWMKLBJwWOgdbC/EKrSoMUElY4v9QciAgKuO+hcDFu6UqR9oH6RxWC
         vg6fauwyLboYvVFuQPAXjN9HO3RE3x3dXKHOwjwFIlkET2f6e2nzLe6uZ/9T+mxD8iKB
         DC2Rn9ig96MiFGTYWfIrMnLYYIeUL78vQQRmS892ohBei+G9kE7lwkOq/EqAt47sTiL4
         od8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZYCIwusXOn9GIbUjPY+Z1gvgGv1eCVcPoYFgPm/ZsBw=;
        b=uf9J6olrZIkqOuOAMHajLDK2uJtorkhw9HuQP8G6thBt+3PMJatdQ66+Cbyy94Lbeo
         WvNB7adGtwdxueyTr+16DDdFtPNCF6nk+0iAFT1VWXtzXLH/P+2NDFsTNNW4/OtK6Ba/
         h3+omzTscTLlTnls2GT15ZEMcEuThd6bqR2ryL+YAx2EeV5Maddt+WUXopMm/YAy5qzl
         +kOJi0jcUJXldhJ+KwAVoiZLMxyM193suFGMiu714neVUEc9AjRteATDFCbrN/IS2LVL
         sscPrNdpn8k6SSWwgCpgCnClKyA0y8SKxrmP/erCEWaOhcbeYnuEwv1ARJtRiQmSQ38O
         hmuw==
X-Gm-Message-State: AOAM530CwvLSJDFG9W1Vu4cPlN6rAppSnMg0TxvowVwQ/dfsOagDMj6q
        Mei4G7F1oAWHKEGmpptf0A==
X-Google-Smtp-Source: ABdhPJz23hAs8nh3LiixdzIhqWtJL+8yYO+WofDjUQWG5ej1fW8c/lVVl0QS3v0ek7DXHPMRocGRpA==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr405735wrw.421.1615920637509;
        Tue, 16 Mar 2021 11:50:37 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.49])
        by smtp.gmail.com with ESMTPSA id y18sm23289935wrw.39.2021.03.16.11.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:50:37 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:50:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: auxv stuff (Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack
 leak)
Message-ID: <YFD9+0BEvMtwMqVi@localhost.localdomain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
 <YE734MgE40jTv9zJ@localhost.localdomain>
 <YE8B52ET790Y/6WO@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YE8B52ET790Y/6WO@grain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:42:47AM +0300, Cyrill Gorcunov wrote:
> On Mon, Mar 15, 2021 at 09:00:00AM +0300, Alexey Dobriyan wrote:
> > On Sun, Mar 14, 2021 at 02:40:05PM -0700, Linus Torvalds wrote:
> > > [mm->saved_auxv]
> > > 
> > > That's a separate issue, and I can't find it in myself to care (and
> > > nobody has ever complained), but I thought I'd mention it.
> > 
> > There is another (non-security) one. Compat 32-bit process will report
> > 2 longs too many:
> 
> Good catch! Alexey, should I address it? Or you have fixed it already?

I didn't and I don't know how frankly.
Something I've noticed during more important auxv rewrite.
