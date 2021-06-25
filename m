Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287A63B4297
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFYLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:35:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A18C061574;
        Fri, 25 Jun 2021 04:32:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a127so7782940pfa.10;
        Fri, 25 Jun 2021 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F1FYj5t4XYoxvLoXBqTjudiXE+LHqymCGK2OtEnIdlM=;
        b=Vug1MX4WgKzGeIKZiGV5dxk5+sQypFDvIqvNce+do+Xf1qJI5YDIW5x+EkBUMKbFZv
         061HMvrNuq2wndVfN9CQuQF33iB4BmdWea+nTuChqpiQgKd7EsXGWHy2nBgydestG4El
         +lXae4pXaHOS5LBVFJcIMtnDiRN5AquOufxLJ4U597XCdmPUvfmxqJIeoTABhhB4aZlM
         lOSgROHM9u/ewbFS3Pz/JGILAWewkl0Gtct8bJs0WBhgsseUQwFQkKEhWaYBGQH2KWAJ
         BTG/+8SvHSZ1Ct82Z0RdQ50KtUuaQNUPcSJwcqYGFaeNUl9irWFRDv4086PzBdiJQkB3
         ULjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1FYj5t4XYoxvLoXBqTjudiXE+LHqymCGK2OtEnIdlM=;
        b=rxe41zgyDujC5eO7PNriJrTdil11Bi+oIl7XOilgd1Lw6hcIiGPU0RTM2GnHBYXYGT
         nYY2ZLHkemy7Q9pvAJeq8/d9zMRFrjp66njXtDpETi+5bFp3neLQExWk0gkQxW7HDaKS
         zcGQbpvcDOcZHpVJvzrTwGi6vbboBHljGm/kf1LMJoGAYZe81PwM3w7PN0YnwvDZ3Ktw
         GqY8+2Ih76tR8qVYn0YKwuJ/tIGZF2beuzpYWN6DGVt/+/8oPL+3cBbjOIfh97bLy5ci
         DhpZPu2+D1z0s6aCfgs8cmCxGNyYgp9hwk/8H5bsYuvXzIomaqMg4bsjDITjFVwq+nyb
         2z4A==
X-Gm-Message-State: AOAM532WeNWSJ/cdjy3M+Q92S9jPTBGVIGufBqBVD7iKdbjrNQZo/JGj
        LC4HtuEpCt0CDWKovrqYb3WBAor74EE=
X-Google-Smtp-Source: ABdhPJyCNRv0sPV9O1TfxSLrNyApdRWlKjaBdFiSvyJknsyaKQa3mPDUVQAcCZlLu7/LKuopSdCBOA==
X-Received: by 2002:a63:3d8a:: with SMTP id k132mr9302612pga.7.1624620771620;
        Fri, 25 Jun 2021 04:32:51 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j20sm4999136pfc.85.2021.06.25.04.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 04:32:51 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK ascii-art
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Wu X.C." <bobwxc@email.cn>, Jonathan Corbet <corbet@lwn.net>,
        SeongJae Park <sj38.park@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
 <20210625065524.GA11219@bobwxc.top> <20210625095059.7f97fd62@coco.lan>
 <ae0a7623-7ec4-937b-4b93-8435f2e94eb9@gmail.com>
 <20210625122423.4435c5e9@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <b6ea891e-b6f3-318a-1b40-268f436c6860@gmail.com>
Date:   Fri, 25 Jun 2021 20:32:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625122423.4435c5e9@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 12:24:23 +0200, Mauro Carvalho Chehab wrote:
> Em Fri, 25 Jun 2021 18:22:26 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Fri, 25 Jun 2021 09:50:59 +0200, Mauro Carvalho Chehab wrote:
[...]
>>
>> One minor problem might be that the Sarasa font needs manual
>> download (and install).
>>
>>         Thanks, Akira
> 
> If this is not yet packaged as part of texlive packages
> on distros, this won't be a minor issue, as we'll need
> to find procedures and test it for all distros supported
> by the script.

Existence of "Sarasa Mono SC" can be checked by the command:

    fc-list | grep "Sarasa Mono SC," | grep "style=Regular" | wc -l

If the result is *not* "0", you have the font somewhere in your
fontconfig path.

I think this is portable across distros.
Wouldn't this suffice for sphinx-pre-install?

        Thanks, Akira
> 
> Thanks,
> Mauro
> 
