Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22254309D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbhJQOtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbhJQOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:49:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86203C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:47:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g10so60142504edj.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFqNJFVsy2D7h6GKfy8JazvFD2oIbLBEOiY/RubRa68=;
        b=j20NxjysulzWzOseqaVPO2JSbqzWx4oePP+UYSEMUaa2SxXOozUaRBcYAE9onpI52u
         sxMEV+hTUh8BxjZUJvOZHHzAP2HseLy92zraM6IN7IiXI70g7Aqawbv3Wi5ksrigKydR
         mDZGoJ/8rS7oaEBpt2Q9QcBOBv9tlek+inWcg6Iu3b6Uo5QaLtwiR5iDgtkYgL7l41jc
         pS+zMmjTY8LhPs2bscmAMMq5+2aEnbU9QmTh0rytU5+QQNAzmY9N5VEN5h65vbT9fij7
         Hlj6TJxXylA4XcPU2R2UpHOWLqoxt4Dv1iWyTZl3CcQHZAZV9rDqtXWHHpWtgqIRp0aI
         uA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFqNJFVsy2D7h6GKfy8JazvFD2oIbLBEOiY/RubRa68=;
        b=Bmo6Z3l2C9KnqcOSaN7pKX47J5Ri7bxrXLqQ8xq8R7rlyxmXoutxghN+NCaCH0BF7p
         QdlDkb29OIirIqNspxik2MIx6d6Gbn7smPW7PLD22v3dgIeoaUHd0XPFHfZDPzKKBdcS
         yhsOxrEBliaOJfp9N7FdQ9KCebyvbG1CigtneO+nfhSMsNHpWjMID/q2CJnOIqAD7etk
         4ClQndNLTB4CJvbk9BrlADkP+OTQf78Y/k1A/Yf0pUd7kgYEk4aTtYTGfJ6dPIGolWk6
         wDTlEoRMjk7VbOSG9iZXc+ZoBuN4MEPpN7HjGsPcrqb0tfhTxK7R6OYZAlnVM2AT6Sh6
         r2Ew==
X-Gm-Message-State: AOAM533e8WyCiM44qvIUyYXnB7W950pSxOUEL+/+Y2RJixnzidfYrw2+
        d5QPlrZ0UKcdGRWX9nzPUks=
X-Google-Smtp-Source: ABdhPJzDPWYGnvUlTp5HotGSD2kgRMRr0wml8eHhl9LFxn9XXqtF/LVwSj/ORObo2dokPeGzjG90dA==
X-Received: by 2002:a17:906:4a09:: with SMTP id w9mr22411227eju.419.1634482027145;
        Sun, 17 Oct 2021 07:47:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id gt35sm839112ejc.105.2021.10.17.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:47:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 3/3] staging: r8188eu: don't accept SIGTERM for cmd thread
Date:   Sun, 17 Oct 2021 16:47:04 +0200
Message-ID: <1638491.UCx7rxsUkF@localhost.localdomain>
In-Reply-To: <20211016181343.3686-4-martin@kaiser.cx>
References: <20211016181343.3686-1-martin@kaiser.cx> <20211016181343.3686-4-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 16, 2021 8:13:43 PM CEST Martin Kaiser wrote:
> At the moment, our command thread can be killed by user space.
> 
> [root@host ]# kill `pidof RTW_CMD_THREAD`
> 
> The driver will then stop working until the module is unloaded
> and reloaded.
> 
> Don't process SIGTERM in the command thread. Other drivers that have a
> command thread don't process SIGTERM either.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c          | 2 --
>  drivers/staging/r8188eu/include/osdep_service.h | 5 -----
>  2 files changed, 7 deletions(-)

Dear Martin,

After thinking a little more about this topic, now I'm ready for...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Regards,

Fabio


