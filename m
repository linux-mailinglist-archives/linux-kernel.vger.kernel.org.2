Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51075436DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 00:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhJUWvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 18:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhJUWvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:51:01 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBDC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:48:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h196so3028385iof.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vq4rv0bfOp4Mbz0vcICElRxaucBKkyl5l9ANfNhh4nM=;
        b=iXF8clc3KDTdWuNG9VRHRHjfiXo0uQ+meIC9VdUXKeSh0xoLUE8k5pUqFfoDd9mCZ7
         6wAu+igXTtOzIHFb9lyENr6cryoVMrHNb6x+ebk5GKmxN/WK57wegbe4JMAN8FeiW5nI
         CKXpPFuakUFQtjMvO5Gi4n60XBCaFEWFvyzpRC3wp3IGqYfYORvWPnO3Uo/8iSzirci8
         tgOh1xF6l4gXGgX74wlaIFLsYxnRIIo4Ji4QC8XZefxH/hDFOXNNVejPtLZvQ7k0RAVa
         TClLD60MUwaDKGd9HXEVZLgjqh3fLb3K34464TvY30xg1ojcU28AdWOShrMNGN1HLEzo
         RcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vq4rv0bfOp4Mbz0vcICElRxaucBKkyl5l9ANfNhh4nM=;
        b=rjcI9SKCjeWMZ+wVal4ysuzRJmxDjoJYOn2yO8Y7vcJTv8WbYJItIhsTJh7BpaCMGy
         tUh/EuhH+MU+17ix8rX+FHyaDE/FNptBaIafiQSqE6pLeB0IMbs3rabu2YZxm6PajY1o
         6uiUXZY6v6ZSypHisX8WVu5vUk6OEexkwoGvM4pi/spEuar5W7S1HXMJpCg9RXKwyY5v
         +EgScB/cqZFLV5lvfxXJkUPwUtI0DPRLK+Q0yP3gIBYwzl/nzFzLty+lxNvzG9i0R4LA
         8Bx9QyWX7AgT3fgyh0xl8puuwVxe3UcY1uMfKuQiG3HOnw34VWatMNSWRa6XyOv3olXb
         iJjg==
X-Gm-Message-State: AOAM5304+mNyXck2ioSL2IixjYziwuQNbvenkTzHzdES154mnG2Ep8ZE
        Sa1gEKr1jRIZey6JrTroZdolclRcxTSFrJktz28ueAkw
X-Google-Smtp-Source: ABdhPJx8r7HjGQMYo+y0dlDjHb5Viagc9unNFdG3YpNQJOz8BqBN32PhELMI6RPyMl224IsyCmnW9y4nYNGLghFzQBM=
X-Received: by 2002:a05:6638:45e:: with SMTP id r30mr5856110jap.133.1634856524728;
 Thu, 21 Oct 2021 15:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211014150610.GA22151@kernel.org>
In-Reply-To: <20211014150610.GA22151@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Oct 2021 00:48:33 +0200
Message-ID: <CANiq72=702uKFJiW6KVxMfSxU4TR+DmsjKywMrs=_CV0CTkH3A@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: remove GCC 5.1 mention
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 5:06 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> GCC 5.1 is now the minimum version.

Applying this.

Cheers,
Miguel
