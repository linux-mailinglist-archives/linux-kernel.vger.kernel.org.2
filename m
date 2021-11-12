Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF8C44E38F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhKLJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhKLJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:04:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AAAC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:01:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f4so34887881edx.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcIHLMef49THsgwvLfI1bVNvCabXW3IkXo4MjW8OE+Q=;
        b=aK4bqGzck1WLzHmKqUpQ7xIM3Nq0XsN/FS/20+L21bWIZSz8kEdqOqpjUUMTsUc7WF
         6XrRNkzbSrWzEOiDs3xgb+kJ7SJBXNbWAaq6IPpw5Npwg77dW+3/vb70I2kDBZnyWGRm
         vcxUzgAUKSRQ9EucQPB3/SylJQrW0qW6XfzkfoeYhmtI6y8WH/iwC/da9WRnPLtDsWiM
         99oMWI6Et4UxDcoYSVkOre3KolNUcJRsTTVCgrpUSf4eQBEnhQ0vk5DYQhRbUCcnxIlg
         qGMg78xljNziFdupr60m7NP2pSp1IHfw3xvWsLdfdvd1ZHLxfwddbuaZue3sn7TL/0Wq
         yzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcIHLMef49THsgwvLfI1bVNvCabXW3IkXo4MjW8OE+Q=;
        b=cN5BTt2YJNCG7CKw8j5KCK3W9C1NmPBBOnjnBE2tJ9wpM3cLuBzDzWXbQXNWXvI02n
         oCSC7YZr5Jv5g3TBi8/Sfl2VjPm1kdcN/36Eqf/DyW8uh76EqqFBhMBzpJOR2WGbZhRj
         Jga0xHSJFusYZsUjJCgeu48AH2p0QslMPxKFeU0ieCbAAVGD8HBvkBKsRnKsv6eywPc/
         zop82+424X5nUU5m0zVX9omaVmX8cJclI4520qWTUkP9U3AUFAXZcXIcTu9krGfhXU7F
         /UKGlMCq6cW5FRgtZM0ofTd40TR5ncou+++mqiFucW0BD5ZVdmYEB+7oAhajiAg/Fqx6
         LhEg==
X-Gm-Message-State: AOAM530mLb2wfu7mOQzvazX2qVTRQu3dPm+hcsg1cj6WZ5uGrgjZm7Rn
        q5arwbv/ZiriA6MRKo9aQfo=
X-Google-Smtp-Source: ABdhPJyrxrn0N8bjvkMJDNVDv5vN3bsnLj+3LCU0IyFkwP3nwzFCemZgK+VDj1Tnd8i6YVZH+ZFlSQ==
X-Received: by 2002:a17:906:2757:: with SMTP id a23mr17830390ejd.230.1636707668574;
        Fri, 12 Nov 2021 01:01:08 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id h10sm2688052edf.85.2021.11.12.01.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 01:01:08 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 1/7] staging: r8188eu: remove haldata's EEPROMVID / PID
Date:   Fri, 12 Nov 2021 10:00:59 +0100
Message-ID: <6997531.xZuqOj027S@localhost.localdomain>
In-Reply-To: <20211111212644.9011-1-martin@kaiser.cx>
References: <20211111212644.9011-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 11, 2021 10:26:38 PM CET Martin Kaiser wrote:

> They are used only in a (disabled) debug print.
> 
> In practice, lsusb can be used to read the actual vid and pid.

Hi Martin,

You seem to have overlooked the usual rules for writing conformant commit 
messages :)

Please say "what" you did along with "why" you made the changes.

Here, and in two or three other patches of your series, you forgot to 
describe "what" you did. You actually wrote it in the "Subject" lines but, as 
you know for sure, commit messages must be self-contained entities.

Also, it would be nice to have a cover letter and have all seven patches in 
one thread in response to the above, even if it (AFAIK) is not strictly 
required.

Anyway, many thanks for your work.
Regards,

Fabio

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_halinit.c       | 8 --------
>  drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 --
>  drivers/staging/r8188eu/include/rtl8188e_spec.h | 2 --
>  3 files changed, 12 deletions(-)



