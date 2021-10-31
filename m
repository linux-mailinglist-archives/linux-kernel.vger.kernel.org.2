Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20C0441043
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 19:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhJaSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhJaSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 14:53:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0A7C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:51:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x66so14294358pfx.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LbOPgXUy+8K10GTePYW5RJJdGzLLV+FgjjdIr6/5xjQ=;
        b=ekQrVjnFOzW517qgV1OkKXojdFZEzOGkYUB4Gs2vCL2VPStZMDZ3iOhPdg5tgkKz/F
         Ohd93hnfsTh+jFngrZweEJUlmXjRQhndlOomveutXGdi19b/+qIxAV/Y9eITzTNk91VJ
         eymE64euA7nPR6p7QNo635RhtcpZ8Nu8glhZXM10mr3MzPbqrFVBx4pUrP53tiE13T2x
         c2yzXFjRjAX8IbnalZLXQVagbVBJfjAWAxBvqzYdgE15SfbDBbOsH6RucqhqiCO9ulPG
         +ATVLqGS3oJUyKFsTLgsl9HsVvyVjoN0yld/UccSqWrC0ZABcj5w0WG6zUIpUOEH76sN
         Lh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LbOPgXUy+8K10GTePYW5RJJdGzLLV+FgjjdIr6/5xjQ=;
        b=AjeLdT5A0Fmc3LOjn6xuktTS+FCXS+ckgDhjE7zNEaenYGYNeXdry7c8UpqRydiuKr
         Q7/t40JdKpcGYhyy1TcnVVyacmm4CTtzPewdP/hCmasJgZdwTySej7pIdNwuatOiCrbT
         n/hWJIgImYEqvOJV66osO6KbuQSpAhWOSisAxk0c/T4NYH6AQ2l0P4IULFwRAWh9h4WV
         Qd4/3WgVzJt52BkUSYvJPVFTePz7QLa4Q/SGOIPsnKcAN4U0Ta4ieSAfLAm48awBXxHA
         EgjohJAOzsdSduHXQ3jZKp9sLm0VPdMZekcrw0gCS+eJQBgFB7CuZKKnC/NVQoJg9+sQ
         mPwQ==
X-Gm-Message-State: AOAM532EqB1TICrf8SIJfYP7AJ6SM5ET3yqXef6To0d2MXlsgnYh0B8R
        ukawqEu0AcpXoGiwVm1EP/U=
X-Google-Smtp-Source: ABdhPJxXrh5TZbwvJi0fdtXIUGAAX/T1jZeDtJHfJePYkeHV8g65ocAnk/IaznouNQbm+LfKqnt48Q==
X-Received: by 2002:a63:88c8:: with SMTP id l191mr6919960pgd.369.1635706270243;
        Sun, 31 Oct 2021 11:51:10 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.88.136])
        by smtp.gmail.com with ESMTPSA id f10sm13037640pfe.82.2021.10.31.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 11:51:09 -0700 (PDT)
Date:   Mon, 1 Nov 2021 00:21:03 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: hal: break after the return not useful
Message-ID: <YX7ll4SbJ8oM7uef@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the break after the return statement. As function is return
break will never execute.

issue detected by checkpatch.pl

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 0fd11aca7ac7..c88e10417100 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -83,7 +83,6 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 			case PWR_CMD_END:
 				/*  When this command is parsed, end the process */
 				return true;
-				break;
 			default:
 				break;
 			}
--
2.33.0

