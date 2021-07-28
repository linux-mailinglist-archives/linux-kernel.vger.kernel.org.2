Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A3F3D882E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhG1Gsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbhG1Gso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:48:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9CC061757;
        Tue, 27 Jul 2021 23:48:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bp1so2028025lfb.3;
        Tue, 27 Jul 2021 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tk2tTN8Rpz9k1o5oub1EXWBJUCnYUwH8P+Hbkc33k0U=;
        b=MyWLagTdhbR8upGWH3EKBCaj1MQ7/iqs60RQnUGjchZoQGy/h9i1Nw7LZWhyortEKQ
         wqyX/B/MsPSaXyR/8lOuXpjkLyte6sRImIGnQ7N08/PPCtHBAxjmT60KqzU+ByaXPARS
         PCR0Cx8zIjCer4iTJ7mlqevgxCW/NmEroiUiKy9jBZ2V/3xnDIS85fCj4BQrfBiZ9FXG
         Sd56hIC+MQyqsRPEh9Hb2gyVMeO3MREcp1535JlE6pw6rb8FYseB66amSbYvAAAnknoJ
         f6o5aBRwSR/Kl8oqNaREnpSQFXcnLXsxtokScK9NsarMnNLRKDzW0CNpkB3GKDhi4MPn
         HqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tk2tTN8Rpz9k1o5oub1EXWBJUCnYUwH8P+Hbkc33k0U=;
        b=NfPTkKY3VwZAgw6pORIWETxusaZXEQm6v9ztqyPlnvAqk7Khq0CV5C0eMjBjzkhYmP
         40Mz8WHHqZlxbZV59ENAKgRrjU3/A07zaoczaeLe/SYKSrKj7sPbmMSdwGK9GLUYzNxU
         nUFAqX1FYJLRqC+dWOskQqBCmYnlaINY7/4Pl2J5hHur/TlArnM9FHMC0suIT0jqe3/Z
         rALC5EXlI2+aJxkZ7N9yScw46OXq0m7jm4MTVHjFSug+SKD+t93AL3rVNi2HhzjfQE5g
         PyCYFOT0cfs5zbu6lRVfoLmg718ctue/quvZG7QPkFjSgHkF4Bt2vI+kCBL7CWqqif3f
         uh7w==
X-Gm-Message-State: AOAM533jCR1iHQ0CUN617U5RWOnlgDk/QlY5ipXPKxK+At1ogPI6KnAE
        0TEWbz2ahaI6tq856FhALGvFWftcCgvMBw==
X-Google-Smtp-Source: ABdhPJzQm88uLHdOXJWjoUCI8bEJhg7XAoaWTkaal91bUICKHHjAmE2TaTk/88ngrEKkxGpDnAFcqA==
X-Received: by 2002:ac2:4888:: with SMTP id x8mr19121891lfc.19.1627454920832;
        Tue, 27 Jul 2021 23:48:40 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id m4sm437739ljq.96.2021.07.27.23.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 23:48:40 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:48:39 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, sandeen@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: idle uses the highest byte for
 duration
Message-ID: <20210728094839.23a185d8@reki>
In-Reply-To: <YQD8MfEZxPHYhnrz@kroah.com>
References: <20210727185800.43796-1-mdevaev@gmail.com>
        <87mtq7t0ex.fsf@kernel.org>
        <YQD8MfEZxPHYhnrz@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Greg KH <gregkh@linuxfoundation.org> wrote:
> Argh, just missed me committing this.  Thanks for the review, sorry it
> missed getting added to the final commit :(

No, it's my fault, I messed up the process and everything went wrong.
I will improve my interaction when working on the next patch.

Sorry again. Although I read the manual on working with kernel mailings,
I forgot about some things. Github PRs and all such things stupefy me :)
