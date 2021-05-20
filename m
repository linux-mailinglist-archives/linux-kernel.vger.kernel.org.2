Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1120F38B3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhETPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhETPvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:51:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7559BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:50:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y15so1279404pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pWfEJ33HmYjyJ1Y5NXIDf1GmNE5PqL3F2Pv45dftgSU=;
        b=EdlG5Qf7QEWX704/Y6+GYnd32o0nYlnE3E/NiWhrP8dFMil+TqElUzyv7omguVtwPy
         YhWJOheS/s5hIMi/LxAUa8cGzj4mUq90S+cNqYNcW7QdS33FRMMkowf3JvT71JcwYg5R
         GNFacIMxL63N9DCAoJ25Z3e8VbnLFY7/i4wg2phjrlPgwSW4uncK7u3Jm6MujnNnmY2H
         R2+VJj4UxbLn4T1pA6tYFLp9IeHHWzteD+jKFwQOABdmoMrkqJxR305obI6O+YERz3X1
         Ldo0fMLzyns1tgycBjHWwK18AuyVvUEk9670Ddhgzb/9QmW4cv9SW7iHg+c7JUZGLJSl
         4t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pWfEJ33HmYjyJ1Y5NXIDf1GmNE5PqL3F2Pv45dftgSU=;
        b=aV2zNTdQKBuQ19STw4BQLWvsAUuEEegQwltxOlX6lMDoj0FRc6598QiknCMPkl6b24
         z9HAAOx7r5Wx98fu23KFstRZI0JrUOkPrnQgyxPzPNqMuhNchFreo1HS5hNSmzZvMYUV
         rOfj+JvjmmeiS7TQEk8QAlu3GziTr/ROxlwqq3WT5RRM/lNy0TP/s3Y1cMiY0JE21P+b
         wZWNHB1q6bM7GsyGWEhxcmFm3R5pR3wanA3lUWqO8fgTkDRvNc1J+QHmRAOKlOtC6Itd
         urX6oE8hXVyk5ZdnLikf4Fjn4y19iO/khEljlzgsm75sopSp41UO612DxXkxKQqEjni/
         whzQ==
X-Gm-Message-State: AOAM531hkf+Pgycd4pY6MfCDUG93j3gkTvdnaJKjSFi/bpCzb7v9aTaW
        b0vxiwBifwjrUSH9r3oPfmaX1g==
X-Google-Smtp-Source: ABdhPJxpB51ovb+xOMBMfQ27ebYcjzzqo75xRL/4ldCDgC3y2w/k3e8jb2E74WRsVJp1Z/4CAYodIw==
X-Received: by 2002:a63:f5c:: with SMTP id 28mr5378882pgp.84.1621525811763;
        Thu, 20 May 2021 08:50:11 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id f83sm2300640pfa.163.2021.05.20.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:50:11 -0700 (PDT)
Date:   Thu, 20 May 2021 15:50:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joe Richey <joerichey94@gmail.com>, trivial@kernel.org,
        Joe Richey <joerichey@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [PATCH 0/6] Don't use BIT() macro in UAPI headers
Message-ID: <YKaFLxhuI2i0IX/a@google.com>
References: <20210520104343.317119-1-joerichey94@gmail.com>
 <YKZC9o8019kH76xS@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKZC9o8019kH76xS@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021, Borislav Petkov wrote:
> On Thu, May 20, 2021 at 03:43:37AM -0700, Joe Richey wrote:
> > This patch series changes all UAPI uses of BIT() to just be open-coded.
> > However, there really should be a check for this in checkpatch.pl
> 
> Wanna add that check too?
> 
> > Currently, the script actually _encourages_ users to use the BIT macro
> > even if adding things to UAPI.
> 
> How so?
> 
> This is with your first patch:
> 
> $ ./scripts/checkpatch.pl /tmp/bit.01
> total: 0 errors, 0 warnings, 7 lines checked
> 
> /tmp/bit.01 has no obvious style problems and is ready for submission.
> 
> Also, in your commit messages you refer to patches with patchwork links
> - please use the respective upstream commit IDs instead. Grep for
> "Fixes:" here:

Gah, beat me to the punch.  Stupid weird mutt sorting.
