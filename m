Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417A64304C8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbhJPTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhJPTfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:35:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE22C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 12:33:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i20so51533928edj.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1QhJFF4/w/wmkrgS9B8Sp+Sdrku9F5YiHYF/12cvTY=;
        b=IgDgGVKdhkvN4VTD26TrFOLexbn6XnMoQKVh77MR8TSY/1ybT3cAdzqRTCGdVttjbF
         h8luy+JDU9l+V+OAZ+JxathCO9wdnzUYWrFp4HDbpVRFHbo4jZ/Q46bCQgynWsabX92d
         +pNio31IpkviO/zQSYkPBGwYfPXQ12fkx0Dro5iV+/TatfcdCwR7s6gUQrvLsL+CjHCd
         t/vwIvyx88BeVsdOv8d2f8JBbVwB7OU1vCVAY0dDQr0Spltr9NO1iBPCHh1jykgQ43fa
         q58B04HE1ImhyHt0L9S+P3NXh0dvqPGENEXEx6WAa+mY8KrMXktturzl9epNstiX/9C5
         URWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1QhJFF4/w/wmkrgS9B8Sp+Sdrku9F5YiHYF/12cvTY=;
        b=ePS8LY2HJWqB7dj37BuQopoa3yE0RE2I7jXfSIWBjlJ8qAdpBEV02fNB8/fNjGFJGV
         E3bw2vyYO8aE77cC7Pxyuv7URwjci5lXihPBhK4Q5l9+ASfFDe/J9Wrpz7OTyRFNOcyG
         TX9HtGisMXah2NQIDRpfJfa/0hToPfZOuySHhVMpy/JujN6mwlaKYzTHEAXjcLyJz7p1
         LXyt668iICa6yuyI1+lVgWBkkZXAhm2tcWM8qEgZ9UABK/sFPx7ddS6LxsUCFAtt6ad/
         Y6x+yke5UuDcEqoZJyi2q0N93wNRTJK868EdpcKnc/GuLZTdLF8h9PwRHmzkAIvIGdo6
         +Duw==
X-Gm-Message-State: AOAM5301ZY81HGEVegGZ5N3o+7h7E37yujbdMbYkKBFlipDyKknV/trH
        6JtwVnpor70+HR/Y6u0OMLE=
X-Google-Smtp-Source: ABdhPJwcHrIuckPpvXKirx3kK/CVANsiUIp5el7Uj4OfuLJ1NYJGmHbnWXAUQXGeSC9CxVA6PIJuFg==
X-Received: by 2002:a17:906:52d6:: with SMTP id w22mr16981632ejn.248.1634412778990;
        Sat, 16 Oct 2021 12:32:58 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id g2sm7363674edq.81.2021.10.16.12.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 12:32:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: r8188eu: Use completions for signaling start and end kthread
Date:   Sat, 16 Oct 2021 21:32:57 +0200
Message-ID: <3725568.Q3VL8gKjhB@localhost.localdomain>
In-Reply-To: <20211016192604.GV8429@kadam>
References: <20211016091042.19614-1-fmdefrancesco@gmail.com> <20211016091042.19614-2-fmdefrancesco@gmail.com> <20211016192604.GV8429@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 16, 2021 9:26:04 PM CEST Dan Carpenter wrote:
> Yeah, you're right.  This is fine.  It's a bit confusing how Arnd
> re-used complete to start the function.
> 
> regards,
> dan carpenter
> 

Thanks, Dan.

What still confuses me is why rtw_start_drv_threads() wants to be notified 
that the kthread has started. Can you please answer this question?

Regards,

Fabio



