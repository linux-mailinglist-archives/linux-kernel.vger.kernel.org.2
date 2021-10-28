Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53443E3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhJ1OiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhJ1OiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:38:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE2C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:35:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e4so10575236wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=R5vDRCLKxQuuLX1TwFGPbSTqOd5q7X00mWAhulDDMZw=;
        b=d19eLgmUE6YJ9vGgjKB6ybiHXJAI2uxh7hMaJObS1KroNKXF3fMK8rNzbwdq/ZWar3
         p3iy/H1QNY6HeNNiqWNF/v1sHbAILUjCpoG9gpjKRUVbAEVZp9bnbAfjf0GiejwFF7xJ
         MFkehtgenVbAJAFlff2zdRjC3TY3p2lORZa7Li8owlqIn2SX0FQWT6KHEHh7xaWfMbVU
         V3D+fgbGQJsGI9L3LfBY7SxvxxvImD9km1+Qi6fVjfh49WnxXUCY5j+pk+0ocvwPQZ6C
         1Bb0MyzUwEinFPAGgIEzigUOCkoJRWbVB5eZA10P4z9IIS/QaSPN8Rc523d0MbAzzQHh
         PoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R5vDRCLKxQuuLX1TwFGPbSTqOd5q7X00mWAhulDDMZw=;
        b=z20rnly1RoNfHm2jrONRwPVQ1Pv7czKuPzm+dG1fPihj6jJ9EEV8qRj1X69FBCoBTX
         JcgsdouDvgfppiymHZchxUZArLzNuZwSe3PaqjB6YeLLFSE4sBPXky/z9LZmpofAKptp
         1kYeye1A13z2GxKRx02XuaeRGcwWRHPmmKJlzVpqa+xcDRnSZnB4LGen1BUtZduAbkGJ
         MB/hfXncJuQX9uVtZaZ3svqJLkUYUljHTghs1AxhXiFhKgqxD1QBt5VnGHLp7d/yFvOK
         PZBxVh0fYkx75K/GWRAFPTKvyDQt5+0PsUp5BqCI3xhqy5H0hf/3VeAfht+BHLKxslO7
         3K6Q==
X-Gm-Message-State: AOAM533GAS/oXqe57jbfQB9uRtlEySwxFexhRc5zx9Z+1OojUz9pUt0o
        YN6EHDSpgGNK/9scFXard+g=
X-Google-Smtp-Source: ABdhPJwz/IS5dO4n4UdN4ULl3moVosoEDMKzH5Z5uYS8lRPkc9YdMTNCa/FeKPIDIfjqA92Ta/3fEA==
X-Received: by 2002:a5d:6e91:: with SMTP id k17mr6167781wrz.260.1635431732069;
        Thu, 28 Oct 2021 07:35:32 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id t6sm2025392wmq.31.2021.10.28.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:35:31 -0700 (PDT)
Message-ID: <6d2590b127499ba7ae1e7bc36d71064a5262659d.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 5/7] staging: vt6655: Rewrite
 conditional in AL7320 initialization
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Oct 2021 15:35:30 +0100
In-Reply-To: <alpine.DEB.2.22.394.2110281505170.9518@hadrien>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
         <948406a3e7d23f1cdf866aa4448d9428bdd32512.1635415820.git.karolinadrobnik@gmail.com>
         <1683328.aCfAWUeHFl@localhost.localdomain>
         <alpine.DEB.2.22.394.2110281505170.9518@hadrien>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-28 at 14:36 +0200, Fabio M. De Francesco wrote:
> As far as I know by reading some Greg K-H's replies to other
> developers, this 
> "<test> ? <true> : <false>" style is not well accepted here.

I thought that the expression is simple enough that it can be written
this way. Julia nicely summarised why I think it's a good usage of the
conditional operator. Still, there's no problem in changing it to "if-
else" statement if that's the preferred option.


Thanks,
Karolina
> 

