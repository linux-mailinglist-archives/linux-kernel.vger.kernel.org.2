Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345194551BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241966AbhKRAhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbhKRAhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:37:21 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC18C061570;
        Wed, 17 Nov 2021 16:34:21 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x131so4205183pfc.12;
        Wed, 17 Nov 2021 16:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jZNtYupjDyRzj/OP9VMy9ZZOqtGQ1DuQYj3eJHdRhg=;
        b=S60j/kMrd3JzCK5gaccWBjkfG1JObTx3uBqcEh/Vg8AXySg+8rnQsBYuHZHUbAvlb0
         OhCDCZ/+fOw2jVpjSFFgTi5qAHPiwxwMeBfsN6zdbb9ciPSauGM62yDUZmPdF5G+F5nR
         n2gxbAx+B7wydPG5aZoJevWhD7b35vHdaQhc8fErrbdQiz3UQQleOVHB68tETnJNgZH3
         TBg/gNO2olctGJYxWslozAxssJ+1Qo4ZfpobXwaxbv3+T9/P3CM8Tx7Lp9hooDRoYvqQ
         6xeoyBnSamx6Y3SjU6KKQpk3sbf7fNU6pkMOqDmmnPkrC0OEYiY0u4LOIOls9pInWdua
         cF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jZNtYupjDyRzj/OP9VMy9ZZOqtGQ1DuQYj3eJHdRhg=;
        b=Rwh9Y7RpOR3+y3a0PmARFQa/YHbn5XFQ5e6+LB5YkUTsSTVjqU10JMTBOtdsgLd/CN
         WeWll1N0IbpULX2PzUKYusRh5qzTSaPilmo+fQhfcZkr6VeFoAN9fhUY9HxdFzeTiCPr
         ZLps2Fv1bzkeykJ8U7y2HJZWxdEs0JRztdhFcvyDncieWXAvydMwW5DtwEL3j8V5pTyD
         MPAYjCnwk5knB5UB/1Any+PT9iZoBTZyFXCc+VyfmWxOvTXy0EdTQrrAj6eZJkrbbfM1
         EQOjkHDuXA/jdufaIYI+drVZYj4h3HI7nbZdN32qwfMyXIE46/wCYBlpVaClOAQl2vFR
         vY4g==
X-Gm-Message-State: AOAM533AkxERP/3ZW822884SqxqSZdbyUTqAXetplmh12PL5WPlFiFtM
        AooX20ntlN0V7Pl1EXuhSCg=
X-Google-Smtp-Source: ABdhPJx6X9YDfRHx6Yw5QdMFyy6Of4A5872CH3bPuN+uuxoN/VV1d8hdIGL4OAI3cgpyNIkW7CkTbA==
X-Received: by 2002:aa7:8dc6:0:b0:49f:c66e:2d55 with SMTP id j6-20020aa78dc6000000b0049fc66e2d55mr11121671pfr.81.1637195660976;
        Wed, 17 Nov 2021 16:34:20 -0800 (PST)
Received: from localhost.lan (p4899162-ipngn25301marunouchi.tokyo.ocn.ne.jp. [122.18.9.162])
        by smtp.gmail.com with ESMTPSA id mm22sm711166pjb.28.2021.11.17.16.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 16:34:20 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id 5D156900922;
        Thu, 18 Nov 2021 00:34:18 +0000 (GMT)
Date:   Thu, 18 Nov 2021 00:34:18 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH v2 1/6] riscv: dts: sifive unmatched: Name gpio lines
Message-ID: <20211118003418.2edd1913@gmail.com>
In-Reply-To: <1444ff08-24a6-afbe-1512-9ea24ad5b32d@canonical.com>
References: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
 <1444ff08-24a6-afbe-1512-9ea24ad5b32d@canonical.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 10:28:59 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> On 17/11/2021 00:57, Vincent Pelletier wrote:
> > Follow the pin descriptions given in the version 3 of the board schematics.
> > 
> > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> > 
> > --
> > Changes since v1:
> > - Remove trailing "." on subject line.
> > ---  
> 
> This is not a correct changelog placement - you have to use '---' just
> like git uses it. Just test it yourself and you will see the problem.

Indeed, thanks for catching this.

Is there a recommended way for managing these not-for-commit-message
chunks automatically ?
I obviously compose them by hand so far, and put them in my local git
working copy commit messages, but I would be happier if I did not have
to make (bad) decisions on such mechanical detail.

On a related topic, is there a way to automate "git send-email"
recipient list using get_maintainer.pl (plus some more magic lines,
for example to exclude bouncing addresses) ?

While process/submitting-patches.rst describes what the result should
look like, it feels to me that it (or another related file) could be
more directive on what commands/workflows help to get such result, for
casual contributors like myself. Have I missed such documentation ?

Regards,
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
