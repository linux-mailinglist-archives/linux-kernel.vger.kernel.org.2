Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2B739439D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhE1Ny5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhE1Nyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:54:55 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00A7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:53:19 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso3540251ote.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ratv6BUca1F7+J2AtSIDBJ81TFRTS5Nnw/PddyoDNuU=;
        b=JxVq6wCc8vfTqSyQD0W4f87uD71N4V6fNQnzCSHfrgpBN3RMYr7bTdrrJDJ/vULyEK
         icVIfCKUCxBPohN2EhSK7lIZlK1bAg1Y9cH+q9AFEgPAyuB73Pe7TUjR/wn1Flwd+PaR
         J5Mibv3QRVbeQRYyxYlksey8k9ZprJr4BoRzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ratv6BUca1F7+J2AtSIDBJ81TFRTS5Nnw/PddyoDNuU=;
        b=uIMGuQ3JtJadz+GLNjdLY7Ni+s5n12i0+VGfyGs/sSrXeGHxw5ygUnN7NasCcbQRTT
         fTQZ0enNuadskhrdyM5AzCxtTG/fk1CRr2p0hGe5+xMY/w1PSccymbRK13a9TFxRuV9v
         31GLelisgf0TdJUjV9D2TNFqhdUxY1GX8kh8QucwD+9jwsIFBkTGc3WIispyzAJ2D35P
         /nfwg37aMeSWLiu+M51gM3ES/RSpsmQrU+/oU2t1oYf6+0aDWgqJmcq864aWt4OxqChd
         17X2Y0AuhMEk/52z0Y4Hwf+aCsSTp6sd6CQ8xmxYox1Vg4eVIzPSsNRRg5Y272GqyCWy
         s7VA==
X-Gm-Message-State: AOAM530lmizircX6frDrLFCPBDMNckt2WSLSGRhXCTuVnMN8KZ8RoeNp
        CzD2AaOi+ESYjBlObp+RzsMwDQ==
X-Google-Smtp-Source: ABdhPJzoSjo/06O9XqdUS+WhJSyHxsfhmpdiOliLDv9/z3eE3e2m0M4PWrxiEUG2UFFV/uvmARgxzQ==
X-Received: by 2002:a9d:3675:: with SMTP id w108mr7021666otb.58.1622209999050;
        Fri, 28 May 2021 06:53:19 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id d19sm1111983oop.26.2021.05.28.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:53:18 -0700 (PDT)
Date:   Fri, 28 May 2021 08:53:16 -0500
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.12 0/7] 5.12.8-rc1 review
Message-ID: <YLD1zKeoht2EsKZb@fedora64.linuxtx.org>
References: <20210527151139.241267495@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527151139.241267495@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 05:13:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.12.8 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 May 2021 15:11:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.12.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

