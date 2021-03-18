Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8748340D18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhCRSca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhCRScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:32:13 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74809C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:32:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f26so8743283ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+QbzbUUNFTn4CN8f2NhR6mdprqbTaQ/xLSbBU+D4Lw=;
        b=ktk1b8F16oRJUsD5REmRZo2GFMspAiBUUPBqNnurHX+RvDnhFQIESmqlMZJnwmR2LO
         /oc5+/OKyWecXCIlDAu+bPOOx0kHrpL5qrLDXcyyOie9YlFAvRpMwfOU0VL8tQ+tH8/C
         tCVREGkKpB8h+Cra89DsgM0BXuh5vJ6JMNy/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+QbzbUUNFTn4CN8f2NhR6mdprqbTaQ/xLSbBU+D4Lw=;
        b=bDZ0gx2lQSZl/6GZrl9xlH/zc9ttk3yqdd/Z6aVLqn3oE1advMg6SVnefJEmnwtdJh
         XwwBVd8NBAlyN7pbbfBwEPU0dVS1KjDOHBwLxQMnbLQEiYUNLxZweanMlABGTIUqc1wJ
         dMoSjo+vZeFSOlCvUFPKYxiavJCCQR3/dZFWZPmJfeZqpUgKLuyNBcMJyIfrArKJf8eB
         c8DqywCYL7Ca7rWHWfQ132Q+nOQuz+rscAdGrU/v5FhSark/HhIfDbVVAr39mi3vTh8N
         KTNoXedIVzFZ/832W8q6uTDuDUUEfcdKe+JcLCprOhMhX0H9uK+aIZsWhnErAvrHTlup
         vX4Q==
X-Gm-Message-State: AOAM533UbRm2bJLZrSwvnKohbyJq54hQj9bve/to/u3WCDvzSavtBft0
        Cgt8gb2Trf2dGmAwH0peoSrnh2ruD73yq7vH43yRbQ==
X-Google-Smtp-Source: ABdhPJzf0IUKEraU90345o5dEc+IbvnKI1MMFHWvW5R2eW7/mkOKVy2chIKRPRYgR/2vfsGWSwT5pa94rgYAgaR2AjM=
X-Received: by 2002:a2e:b5cd:: with SMTP id g13mr6175694ljn.372.1616092331913;
 Thu, 18 Mar 2021 11:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210318051733.2544-1-sargun@sargun.me> <20210318051733.2544-6-sargun@sargun.me>
In-Reply-To: <20210318051733.2544-6-sargun@sargun.me>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Thu, 18 Mar 2021 19:31:36 +0100
Message-ID: <CACaBj2ZEtrcjuv_F2=ff+ewfQaxbySqSq3vfFNnf+87n15sApw@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/seccomp: Add test for atomic addfd+send
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 6:17 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This just adds a test to verify that when using the new introduced flag
> to ADDFD, a valid fd is added and returned as the syscall result.
>
> Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>

I think in the last minutes changes this was removed by mistake:

From: Rodrigo Campos <rodrigo@kinvolk.io>

I'm happy to add more tests if we decide to merge patch 4 :)
