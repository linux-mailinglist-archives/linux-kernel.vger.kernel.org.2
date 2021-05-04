Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF237321D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhEDV6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhEDV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:58:11 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:57:16 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso9622670otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6nDWrO9L8CxbAXjtDgqv4B1xC4L9HAr7ltSEuwJLk8=;
        b=lp8Ds+q4uHoTq/2xNdc6nB8zMv9+EVRduoGZhmPcTiX40X3BRyVq20/wmbznOaJKXk
         48InIae6D+ySRAWfUzgcwxVE0xLGPx4ZpJGtdte6bTc/hYHkp3FD8UDSB6B4obl0gPal
         6Anx4jvxkyiRcU36eEj3cO21HPg5+rRJm7jyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6nDWrO9L8CxbAXjtDgqv4B1xC4L9HAr7ltSEuwJLk8=;
        b=Wbr4d8iqRJ0cs/haI17JQBHOAZvsXbwZ8FivLgyyL6D7SQXYtwwSHcqZHnereH64JE
         dplWCH/7PfHU16edhhrWEiccyLvnwpLJ3RMo0eIppWoSAg/tmoUrHbtOR0IHqcW54u0/
         t/GUI7rsuijuD0XdvQk+l4f57lPc+d/DfmcVUkXp7heYtT1UNnQUH3MzvKOBqp3caHwI
         D6PWmWskMRE4VLOmjJdD8nrfQ83loRc/JKYAJ83fuW7lAu7wB0n9bSJDvzPFQOw3xe2W
         Fsv7et/5aMCLw7zF9Ydlb7Hi/NHBHYX1HSHwpy6MDJQub5tHY4hq4JxUQTVyCFSbSwhg
         PscQ==
X-Gm-Message-State: AOAM533RR8cvGAYrKKp0184SWUCevBhJ4GXzzbXrFJPVHsdlHKaCtc/D
        WXlaYz7suSU4ToRsy9TRcp0HiQFxe2GDI3z6
X-Google-Smtp-Source: ABdhPJwyicK3eVoQiZRg0a9m4hs1uZUy2mUr3MsLIC/Hxp0mEkkUUju/SIO16mAJi0ntdw1srhlKIQ==
X-Received: by 2002:a9d:4c1a:: with SMTP id l26mr21736371otf.181.1620165435366;
        Tue, 04 May 2021 14:57:15 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id i17sm905277oie.36.2021.05.04.14.57.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 14:57:15 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso9659031otp.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:57:15 -0700 (PDT)
X-Received: by 2002:a05:6830:a:: with SMTP id c10mr21052802otp.21.1620165431621;
 Tue, 04 May 2021 14:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 4 May 2021 14:56:35 -0700
X-Gmail-Original-Message-ID: <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
Message-ID: <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Enable hibernation when Lockdown is enabled
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jarkko@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know if this series is abandoned, or is Matthew planning
to do another spin? Email to matthewgarrett@google.com bounces.

-Evan
