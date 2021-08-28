Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E288C3FA581
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhH1Ld1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhH1Ld0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:33:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A000C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:32:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q3so13887103edt.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mwl0/ofwUR1fW5Jjat5etpDE/bNVRf53IkoL+dJORwA=;
        b=Rw+R9akTqXGUUygEgELjBYlAC/860T6+4EtzYW6AVQHWFgIUERNXqXpAsIbY6oMGYB
         P7qknDvnjyaPokiq5ChcfNwJf+8KlxckeHIG+ekMTvFK0up1Y6opI4YxG+jk63WdB4ld
         FJt+XbCiGO/+vYgxNKRxEGuq255JgqkhiPWSr0WISgxCEClqUDgIuvO3wZaJJeWo1NGF
         rySEDRee0gIZq+U10ypA1dyBKCihuCeSi8NO1oh/XtPqQRXlp36pRM/C0NXApKHqXOKH
         +mzKIU/DJQMKqyiqcmJ1xJKG5gI8fWcksb/9/GHaswDhQEoZJqwmVhT3PS54+wSyaWZG
         lwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mwl0/ofwUR1fW5Jjat5etpDE/bNVRf53IkoL+dJORwA=;
        b=r83+chQrVsUDU3hbEIOTa4njpZxgjscK8EvsjX8Hchbkhqc7YWRFjxUlXZG119N/F3
         Qp8HkaoINhJfDbSa8ueLhfvElFjiFoxbObyzHqznAb2wUd+0lhHzcIl0UvWpQPAT4dyl
         kQCqP1wmDlCLhg3ZYQX+lgx37BeXYG5QeToGrH5uDnuCFQhzhGIORlH/1R0uL2NcIk4d
         0TpU5eAp5wvADZQ65ZRAFDEM1Up86ZLHLWSu6DMJkGG1i/zFrCTpVop3uuXp1vYgr5tH
         YpK9zxKRT+GPfMYXCPvgmHuakqeYWMdiG77i98b8j5+SQ7YGFzD/KqCNfwWBnA9edKmr
         paog==
X-Gm-Message-State: AOAM533pVKZjFyLYIPaNqpITs/XxH9/GwI2bf+gBWp5BZNrSBOFTL3pV
        r1K9IdKsHFgaDdVZXAWw0hMGSIap7ec=
X-Google-Smtp-Source: ABdhPJyYQ0N6TQRJ4JplgfVs3+sbZaNEXcdsfA2TF1udOnQET68RzhP2YCyhtmXmc2M4GrRlla4c2g==
X-Received: by 2002:a05:6402:26d2:: with SMTP id x18mr14315972edd.195.1630150354010;
        Sat, 28 Aug 2021 04:32:34 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id k22sm4121604eje.89.2021.08.28.04.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:32:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHi v4] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Date:   Sat, 28 Aug 2021 13:32:30 +0200
Message-ID: <9823013.QzV6juPZh1@localhost.localdomain>
In-Reply-To: <20210828111622.3jytsm56cblqkvil@xps.yggdrasil>
References: <20210828105109.5776-1-fmdefrancesco@gmail.com> <20210828111622.3jytsm56cblqkvil@xps.yggdrasil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 28, 2021 1:16:22 PM CEST Aakash Hemadri wrote:
> Unrelated to the patch, but if this was a typo then you can easily modify
> the subject prefix for new versions with `-v4` using `git format-patch`
> 
> -Aakash
> 
Thanks for catching that typo. I use Vim and I should have pressed the 'i'
twice to go in insert mode. I prefer to not use git send-mail to add version
numbers. I'll resend it soon.

Regards,

Fabio



