Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598853F3AEE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhHUOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhHUOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 10:19:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F56C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 07:18:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so2902717pjw.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jehk/SAV88QAcVymj6qobcNZQrFrGYFZzagP5r8Z4ns=;
        b=XaAaRGcVxjGBSRqOemxoFACYeDiCmZN3SZvnOemXvEmg9sQ5VQWlhMF27tCLPIJTZZ
         +OAFXQfeNPQ7Ysb5FBSHxyDssrxhUkaWMN+w/Sx7j/g27foaednkAWtSVAuob28/FN+u
         HZBGrOe/ibyB011Mgbf3kdwMPSV8aD0GgTUJKPEo1vGFRr4tES3L7aCpDaF/G69HoCHn
         T4hB4iWFii2/WFX+qZD5TLM4f8oVopRRvJHbAA+/e0LpE/4Fk4UnUcfqjL8Yc2Qp2Jim
         tLBEzUiia6SoMexqThhOKHlWMJfULJGSCFHKL4+0lOJW3YBgxBUpLCYzw5BDy+F5wF4/
         MFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jehk/SAV88QAcVymj6qobcNZQrFrGYFZzagP5r8Z4ns=;
        b=neW1abO8d9Pf5Sv3evwI56TJNuXmxqj184D6CTaacBrytgoR4CAzeqtax2rRs5LKrP
         01mvgxQWuLJ3xjRUnxdagjwgrrjFbDdkXm8IjnpQ+l7ArLCqzvSjqGF0aKn0fG6Tnz3u
         FkJ9roSmOX7qFK7Y5oUx5fZLVGehMWzcQP/6nd2of7sb9uTzDimrOIz2EohX4wZvxjER
         2l5cnZxbR/CdSaQNYfrdDtXfJphzVruO1gi8jG02HEK/jJev/vijwk5lCKJL3gif5wKT
         81+S0G7rCITHpWr7NBJFJafbNsTG/TdFSG8zf4rWyZZXkhxTXSdXJ4YUxPy63EpZLB8e
         Ez1A==
X-Gm-Message-State: AOAM533CQeI2cNc/D9kvFKzEjNecYUW1I/RUPX8SguR76qnjkipNoM5R
        3tXux18Xm1F28c3UDqj5J1ZvV4/3DMaR+iKV
X-Google-Smtp-Source: ABdhPJwe+puIbYiIzF4CRnOsxRLWtBJjm/5UJ3Kul6PNDqEOpZRNwxK/Qudhi6k3EHXJS1uEdxlhQA==
X-Received: by 2002:a17:902:ab53:b029:12c:57a6:13ae with SMTP id ij19-20020a170902ab53b029012c57a613aemr20741714plb.53.1629555528697;
        Sat, 21 Aug 2021 07:18:48 -0700 (PDT)
Received: from localhost ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id j11sm10816718pfa.10.2021.08.21.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 07:18:48 -0700 (PDT)
Date:   Sat, 21 Aug 2021 19:48:46 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] staging: r8188eu: restricted __be16 degrades to
 int
Message-ID: <20210821141846.k4n4eorn4ifk5lfj@xps.yggdrasil>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <bd63137c645ecc20dc446a6cfa7f7d3461a642d7.1629360917.git.aakashhemadri123@gmail.com>
 <YR6S7MfxpXpQFl9d@kroah.com>
 <1777630.LqDDHREl4S@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1777630.LqDDHREl4S@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/20 05:10PM, Fabio M. De Francesco wrote:
> Building on the objections you had from Greg I suggest that, before attempting 
> anew to address problems like these, you get a better understanding of the topics of 
> native and network endianness and of the API that (conditionally) swap bytes 
> in a variable between little endian and big endian representation.
> 
> To start with, please note that the following code leads to tests for "v.vub[0] == 0xDD" 
> which is true on little endian architectures while "v.vub[0] == 0xAA" is true on big 
> endian ones...
> 
> union {
>         u32 vud;
>         u8 vub[4];
> } v;
> 
> v.vud = 0xAABBCCDD;
> 
> Also note that API like cpu_to_be32(), htonl(), be32_to_cpu(), ntohl, and the likes are 
> used to (conditionally) swap bytes (i.e., change the arrangement of the bytes in a 
> multi-bytes variable).
> 
> Casts have very different purposes and usage patterns and, above all, they cannot 
> magically change the endianness of a variable.
> 
> Regards,
> 
> Fabio
> 

Thanks for the explanation Fabio!
Will rework and send it through!

Thanks,
Aakash Hemadri
