Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79E53067A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhA0XQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbhA0XLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:11:52 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:11:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c2so4453912edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P4E9XkSKWUJdsiYmpjHKs1qxutdDmK6RKi7DGMsqnfo=;
        b=Q2jkOledYj90UawG6DC1dSHDZAGnp9L6DRQjK1D66cAkvwO6hk8Xsthr7hqEG7jueZ
         yLBGLtdTjXbY4Zjya6m4NQBwZtczDulMvssVO+laJZt1eWI07XllWSnP1EdmbRKwwvh6
         gDymjd48Dx3Egm/G2yK/IswQSAYCyEHvEkLdZuZrbR5Kr0prZweJoS2W2u6tKhLjfA0d
         LzYTShcFm6mXtyyKuOiiCWOIqv7+lsW9/KjBYgUtoF32rut5vFG00NyZIGrdS0AwtcpR
         5N2pBfKtF6WYksAgOtvJa7U8Nn7dzehnAxp8Zcnx5p2LfR5oHqRjx7NLpk429kaj/mdW
         PksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P4E9XkSKWUJdsiYmpjHKs1qxutdDmK6RKi7DGMsqnfo=;
        b=FgdeTjvaNiS6D9wCyuFNiapfP5zX+3PCS2oruATynJ1HojnJdsjmyecDlCYuXDeVc2
         vJO9+mxzrTI/Tgaa3vML/eJgZG3NrFTa9MRPJMcItelFpWl99aAYgI2WkoSelOkIldzW
         wXp4aBC2hxmcoJsVSAc9VhS4mhnlTcBUcKbBycUqCGrkLYS8a5VBQDalYCRYRigDte7K
         lGTBuopMGleCjD6O8k03hyyIniMzLCzHY/Lv4bGfAjRDzYgKcWXt0gekQH26wOm2wFPS
         wj42MqOx6gIvp0uPgU6Ouo1RUtQUugYke7xPKDR718mlkR6V5oRT+/p/JQdkzByH5nUm
         0j8w==
X-Gm-Message-State: AOAM531mhi00/ahGXbu/tA3e0SYKh7U3R0DrYTRURTqRqwfeAv58Q+Am
        ElK6PL0kZWmMsKjm6HoWy7MnaUEp3YgIAvMxwNpgTg==
X-Google-Smtp-Source: ABdhPJwZ05CRYzyDCIn0+aFVtJGEaG/UnKXK3voTOj0Ndco5CXyd3muvzdlRYeyyYdJ8Cn8ILMSQUOEfipZHhI1dia4=
X-Received: by 2002:a05:6402:1341:: with SMTP id y1mr11078032edw.273.1611789070344;
 Wed, 27 Jan 2021 15:11:10 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 27 Jan 2021 15:10:59 -0800
Message-ID: <CAP045Arw973KWCiHqXmRJ3QxH8o84on-t8Nm6NyEYXDpicF7JA@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore the previous single step reporting behavior
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        yshuiv7@gmail.com, "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This regression[0] has totally broken rr on 5.11. Could we get someone
to look at and merge Yuxuan's patch here?

- Kyle

[0] https://github.com/rr-debugger/rr/issues/2793
