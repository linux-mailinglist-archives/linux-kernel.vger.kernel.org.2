Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1192A3575AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355999AbhDGUPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345885AbhDGUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:15:09 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0FFC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:14:59 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c131so15448364qkg.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ceq8XvNE/VKGx/FMUKPisDgv/8Sf3c1dCyF6b7cDUlE=;
        b=diZvRjNagL/cTfPIrlKCvoxMiNgCBAJmq2gY5rPRKs0WoLmwgnYDSqKbPYI0CgaufI
         bCjCzhaVjKEztDsnN9SOTZmTxJaOPpvyUK7Jg60OkmSEfPs0lbNTxkXGyAY2dPAugbUt
         zo+fTFxwH033qLbaEyv/h6F9nIDbEZJHFOEkNbsZO/8a/Q7boXLRWDq01wlNSz+moOX6
         xwkY1MGoQInP5Zcj45IkWeocMAMYmRNjtHBJ1mJTk8xOWI+qKoiPHOvFBAWuXytZpgou
         Z6AM5/sizAmUDRUX1lXlXnoSli7y57aGBfI2s+yx2Zok1HbdaDqNOp8csZlyLvNP1FS3
         MGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ceq8XvNE/VKGx/FMUKPisDgv/8Sf3c1dCyF6b7cDUlE=;
        b=LRkdPmtDKUjccwaIzS5BzoDKVBKsxuXyYUWfi0t81g9Au3CEULajf6Fkbk/MJyDIiw
         2zrJicVxnR7vNF4hEQl+Tqvx7AXbrCSfA4pDF3vNI8rEUScSjiiXL+lsYn8L8ChGNyA1
         zxPawmFvneYAangCxEB+wrff5sGBDwP5rC/io8xKfinhurLArEZNrEY9Pnq/CvYp7tj+
         gvExOzvJYNxjFrcldZvhhcVobO/WOevwG2IuffkG+w0WkuqsEWDilEOgtxjpEKJQBp65
         VLSZX9WCiGIPSV9GK9dKZoLkiaD9VPP0d3ZB4lPgCowwhrwAuI4drPEq6p9gbUnxjstd
         P1qQ==
X-Gm-Message-State: AOAM53140C1lGN6Hx2VQsZMyHQx6DFlFhTQeqCudaLYOVUEfK9SUQjJI
        6NUvRfI7pwFytiP8+X6dlc+Sx/iYLPLfYfelkAc=
X-Google-Smtp-Source: ABdhPJw8se9qCloL1BmpH+0RaPpAlNuQscHk86VmksDcfryOQi6f6AQNz0osRK/CGqVIG4NtWiauZZb9vBfm+cbR2UA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:258e:3713:7415:ce58])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:ee81:: with SMTP id
 u1mr5216935qvr.14.1617826499155; Wed, 07 Apr 2021 13:14:59 -0700 (PDT)
Date:   Wed,  7 Apr 2021 13:14:55 -0700
In-Reply-To: <ead0e9c32a2f70e0bde6f63b3b9470e0ef13d2ee.1616107969.git.andreyknvl@google.com>
Message-Id: <20210407201455.49907-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <ead0e9c32a2f70e0bde6f63b3b9470e0ef13d2ee.1616107969.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: Re: [PATCH] mailmap: update Andrey Konovalov's email address
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     andreyknvl@google.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Marco Elver <melver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(replying to https://lore.kernel.org/lkml/ead0e9c32a2f70e0bde6f63b3b9470e0ef13d2ee.1616107969.git.andreyknvl@google.com/)

Just got the bounceback, RIP. :(

Marco is updating your epitaph.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
