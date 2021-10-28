Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7ED43E548
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhJ1Pit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJ1Pis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:38:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BA0C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:36:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f8so4926078edy.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Km7RN9DuYhSgIdZd4vw5rE9R6RjCpFJ/7Jxi8UL+wpU=;
        b=AlM+eueZXz8t3SOmFz7G6PaqrKh/8fZ7t4ebW1BfNzZVsiSmiuBcpXUbFbzFr80EPh
         b3wK5Fp0Dah+Kr1sNSpyk3ND5UYWlrL/QOBud8eo4PQUE0gfQoRFuRqEgC+ZOIoJMKVD
         4srzw4IwWjmkY1d/GYfmTHou9jwST8itfs7PmfHN/JidMIqJqyLQy1VyqeLduhjGFjyn
         6XUaxx0+1udNHyqUeGnqhCwUy1wftttRahRagX9OMuFb4FiDStKPkPdoxEjwwkPgSmBg
         CCcgJHeJRZtecoilsnWiJCaQtgJ/bzROBO8Pv3XJtxy4/e3M5GVe7t7ezA0qUiXdr1Cs
         3CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Km7RN9DuYhSgIdZd4vw5rE9R6RjCpFJ/7Jxi8UL+wpU=;
        b=JYTWpwxQm8haCir+/RWU8t5VpdB2/UPWlx0yX5/N2wSF0//fZMLlU3kMQVspRXqjSE
         uA3oQInoBdX4hO2sOoFjfke8TNc3frODdkzGwBHHhWgI9/Gos9VNFMIZZrRIQohnw826
         XxmA5Pf61L2vYFq4AD7uLqZ4sEw+U8/lSH2oC9wycmlJAkBTrS4jhYCL8qSGd2tnR80x
         6J48YqgE5oH0ts60xvMyBqPL6Czn7CJb8E6CY812kAmViMJwOZCwvQ7u+XZ8VMlYsgIE
         p2tjWJqdMtTk7bh8wFbCFh2ZeyfJfYxTegcsZi0dX6bBjK9wVDXqUClKalkKyHzJD7Tx
         b+rw==
X-Gm-Message-State: AOAM530FrkxPZqyRhcssWDdCC8T/lHZ8ZJ+MifXSmCVZus3/Qjrf5/I7
        k5AGpd+sLBuQq5DKRutVHRg=
X-Google-Smtp-Source: ABdhPJw/Yo90kJQEQRr1eUujrIVd2cC+gKKUV9sZsn77IH1geIQKq/vGEVJuhyTYNpeKCW9Gy0hPKw==
X-Received: by 2002:a17:906:1848:: with SMTP id w8mr6316533eje.485.1635435379975;
        Thu, 28 Oct 2021 08:36:19 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id hv9sm1604735ejc.51.2021.10.28.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 08:36:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 5/7] staging: vt6655: Rewrite conditional in AL7320 initialization
Date:   Thu, 28 Oct 2021 17:36:18 +0200
Message-ID: <9038076.3kJb6oI6SG@localhost.localdomain>
In-Reply-To: <6d2590b127499ba7ae1e7bc36d71064a5262659d.camel@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com> <alpine.DEB.2.22.394.2110281505170.9518@hadrien> <6d2590b127499ba7ae1e7bc36d71064a5262659d.camel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 28, 2021 4:35:30 PM CEST Karolina Drobnik wrote:
> On Thu, 2021-10-28 at 14:36 +0200, Fabio M. De Francesco wrote:
> > As far as I know by reading some Greg K-H's replies to other
> > developers, this 
> > "<test> ? <true> : <false>" style is not well accepted here.
> 
> I thought that the expression is simple enough that it can be written
> this way. Julia nicely summarised why I think it's a good usage of the
> conditional operator. Still, there's no problem in changing it to "if-
> else" statement if that's the preferred option.

If I were you, I'd leave the patch as-is and wait for Greg review.

I was only reporting some words that I recall I read in some emails of Greg. 
But it is highly probable that those contexts were a bit different or that 
the statements were much more complex.

As far as what my personal preference is, I think that you shouldn't care 
because I'm not one of the maintainers. Above all, even if I were one of the 
maintainers I'd never prevent developers to use their own style with this 
kind of statements.

To summarize, you'd better leave the patch as-is.

Thanks,

Fabio

> 
> Thanks,
> Karolina
> > 
> 
> 




