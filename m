Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11C3F21F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhHSUxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbhHSUxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:53:20 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED73C061756;
        Thu, 19 Aug 2021 13:52:43 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id m193so14711263ybf.9;
        Thu, 19 Aug 2021 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azek7wC6yuM/sM3dWu6T7jqtDYysj0o8NC23ukK8+Xo=;
        b=BMvVa5Nid54c33zqHeYmI6Jrj9RjtFVyUeC5gXyoBfW4SAIEL3n4RV0n48j0NPVrLl
         9lTQw+U68bTeXb2qtn/x9bz40g28oICv/0kTLk8zRJ2PQ/MaGhvfGgOP0Tf7BTpZLGzV
         9XSsD6ihtax+xY6hSnT7OYtiJx/ijHs3M8WYClgOlC4mfLdsy2fmL7yJZq07F0fVlA/Z
         +GLt4ekvXeM6aHd4B4XCULlMG+Cf4Z7IuDXvwl0hwLjHQdSf3g8c8CW2KV086yoFCds/
         GN11zG7pT9ibby3SbSIUuwT0v1m0nNo9Bb8ueW4MsZIbOrmEfRTGaJfmJrCVyJHtZOXr
         4nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azek7wC6yuM/sM3dWu6T7jqtDYysj0o8NC23ukK8+Xo=;
        b=rYU2eQ8y44/X864nwt3bTdmLkodMEjIedJ7dziFlYWbDaX5Uuyl8hXs21T0jSQkhKw
         a46LpCgX2hfCpsi7JGtgpOIkNSEa/G3GGxM9haTqlb+JwGBTobkIeuqZlcSlxUAx4bnX
         RqirB28LvGjd1RPwahUDlD1XV1eP6OWGVPgmSp0/SfUdLOrrMPzyFIT4oMGtXUrbJgh9
         FBmSgFAg/OCxIWiZ4mgConECQUFZp/r/9pE+Uldw/kjSto6XI8aBxe8xTzOMupv186ys
         58BX2mGvMGzsH/S8poyuKS7nOXcakO3abLBWtCkgP+BApDLvjLIBfclvZ92pxwS+OgJo
         jTJg==
X-Gm-Message-State: AOAM530h9BIwI3/dO9hfhWvB69xLgkEkUuQsZzGFerQcFF2Q82ypHdJq
        L8j1qc5KUkqc3HdG1voptUc2RNPrNSN+RqRUE4o=
X-Google-Smtp-Source: ABdhPJyAXjgRAxLCTvyJfZ51e3JOTUz+HoNsRK0NGqLn3owFT54FaMd6xNAmyQrAMVz8RpRI/8HgHFLRiduOxsLHH6w=
X-Received: by 2002:a25:c083:: with SMTP id c125mr2857848ybf.331.1629406362921;
 Thu, 19 Aug 2021 13:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210730100710.27405-1-colin.king@canonical.com>
In-Reply-To: <20210730100710.27405-1-colin.king@canonical.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 19 Aug 2021 21:52:07 +0100
Message-ID: <CADVatmOudaqZBr+cX_AXwKmDRd2LRTe=C=_bavEki0fdhWkADg@mail.gmail.com>
Subject: Re: [PATCH] parport: remove non-zero check on count
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:07 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The check for count appears to be incorrect since a non-zero count
> check occurs a couple of statements earlier. Currently the check is
> always false and the dev->port->irq != PARPORT_IRQ_NONE part of the
> check is never tested and the if statement is dead-code. Fix this
> by removing the check on count.
>
> Note that this code is pre-git history, so I can't find a sha for
> it.
>
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Greg, can you please take it through your tree..
I think you might not have it in your queue as you were not in the
original recipient list, if so, I can send it after adding my Ack to
it.

-- 
Regards
Sudip
