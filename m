Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293E5433B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhJSPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhJSPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:52:46 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD66BC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:50:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so2202463otk.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaVKBxfnT0MBUuzApSjuIfM0ffrR/bZgEwtyipODILw=;
        b=YYK1sLjy7nEViVr+sKA1drww83K18jqTXwD04GvfAuTzi/5tbPIJyt6PFtm3g5HN6Z
         CYP2iPFBbJ+mxXehFyvnDzWi7+CpJ2poE+sPJtReG2huVSmfd/+ksfaA1AX0HDwk2Cb9
         lCJ23WPXhVSpTu855/2VGEEnFCve7+0lIeuCUYOsMR08BH3oL9a5sAv23AH96nrBdc2+
         brnQ8PSMbQSFyUO2OllI7EHbIYLOuSJuFhZmeKctj7boYcEmY1OyCkU2BIghsZ/SvMme
         rbaDSQfH9cNKA3L/n93o52bO5OhFCMPs9kMLHJPa47yFbtfIA1ogpVyNCR1q4AnvFrAu
         +B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaVKBxfnT0MBUuzApSjuIfM0ffrR/bZgEwtyipODILw=;
        b=0gKZB4sNPr1l22WBEpOzTOc0TrRsqIj7x7MEi4PDKAJURNiEdqCkoFDLYpnsMVL06f
         PHrhmwCloW2R3ir1zztFbZs2DFdwNA9JkHp/lL6rdPQGQ3mJ80VHttx0aosycB7ueuYk
         bWJ/lBN7iBTeEY70cUzqFp4gnS8r+Yy47BHkSozVK/sRp5OqKfMr6L7ZQ9yBtHUOSXlx
         CQ1Hp6almNJrtKGiqlO9x67bJDPVym5V2NlLhXAnd7ksadgEmIF6JZrlP8rzqtp/Ogpf
         NjqdmRuHFDPt7yMjWEpN9N2SNyD68PwhHCWyfnG3re9vKMbqkYsWhGT3Mt7DbMqjubdb
         Vgxg==
X-Gm-Message-State: AOAM532elugPIsOOKKxeUW7ydosZVaPdI0BgC45ovM2vSKgp/uJa0NCg
        YNKhUcDqjrwPI3Sb7UtdqsfFyg==
X-Google-Smtp-Source: ABdhPJxkrraJps6q/gKEUDRCZU5B28dcm+/an718uXWEQwL7RBHiXNVtxKZIFB6jCjrU1YvC3cm5Tw==
X-Received: by 2002:a05:6830:1dc7:: with SMTP id a7mr6176252otj.342.1634658633015;
        Tue, 19 Oct 2021 08:50:33 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q39sm3798210oiw.47.2021.10.19.08.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:50:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Arnd Bergmann <arnd@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] io_uring: warning about unused-but-set parameter
Date:   Tue, 19 Oct 2021 09:50:30 -0600
Message-Id: <163465862593.624672.9684355063496610398.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019153507.348480-1-arnd@kernel.org>
References: <20211019153507.348480-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 17:34:53 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When enabling -Wunused warnings by building with W=1, I get an
> instance of the -Wunused-but-set-parameter warning in the io_uring code:
> 
> fs/io_uring.c: In function 'io_queue_async_work':
> fs/io_uring.c:1445:61: error: parameter 'locked' set but not used [-Werror=unused-but-set-parameter]
>  1445 | static void io_queue_async_work(struct io_kiocb *req, bool *locked)
>       |                                                       ~~~~~~^~~~~~
> 
> [...]

Applied, thanks!

[1/1] io_uring: warning about unused-but-set parameter
      commit: 00169246e6981752e53266c62d0ab0c827493634

Best regards,
-- 
Jens Axboe


