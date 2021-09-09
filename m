Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B3740592D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348194AbhIIOiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbhIIOhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:37:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB5C19A47E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 06:49:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id j18so2339806ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=PiIa8TqM5Mmj0hDNLeRMZNh9RbYUYnMgtvBSCi7Gs5w=;
        b=iStALrMsaqDvQhT5JQuG7TQcnsUZ3cIVgPqnWWt44vK8GMMTqPBmEcbK9+tlHvuw4G
         8iNYyvF3woym8GI+iPTb4yhLsIq7N08AWA+5Vl3yz/M+uzaLzRkcpbaV8xzeIIghkwN2
         h84Q4KiNLth8MwmFLIj8DQm5XDDsj5hlE+sXcc0qMrL2hvWSLwt2CE3C3CS8qagpAD43
         1XgNodVrkTUCve0tB4zxddw4+N+phcv6UcQPr3CU0sqpO5O8m80ncRpLCXHovC0O92q2
         psOjFmMzpJ4hJGU5XeHVvd4+99cKbFtQQTAdCWWkS4Wem+fOnJls8nypSci6bF5WdSpi
         t8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=PiIa8TqM5Mmj0hDNLeRMZNh9RbYUYnMgtvBSCi7Gs5w=;
        b=ggS8xV9rKwYAp8Whik/1JFgSrUQ+nHrx14vK7ArjnsYAylkBnwy4dXbBVt13VLeUEJ
         ngTyKZPXcjAzTnzfmkHpC7+N4Q+XWxUm3wCAl99WQ1/XPNeLVVmNpStNhAHNA5eTU8OG
         vSvKSC3oRAyYCM7G+jSTQdIw1/gx/JA3fvSyCkXSdyzajLbVXtRRWx6ItTgEFT69XXV9
         MEVC1e5OUsPGYFLBpcluxLhaGgJQ1b6POtruyJmG1P0hjngwIHoIo3qdCdd9oVOKdveC
         sclV6/Nj5riIfiHD6iq3UVzdz+0iJmtTCtYfEaQXYKG3v5Fsxb3DnFlAtuP6deEUGMHb
         Y7oQ==
X-Gm-Message-State: AOAM530xwxB+xPbtYz/c1BhS3fh2x+k8nre01c2m5ngb3h5pBU8F6BJe
        sfAh1NXzNlqXYzgYxhxoIhpsOXGW0Y2oIy+WTnk=
X-Google-Smtp-Source: ABdhPJzJJhfeBOvZ4rwFn22HFwuhSx+DmBtTXvYsYMtBlGHnzreXDPk0gilXH1WcBTbXR6SQvUQo5tM7gB2CUGdQaHA=
X-Received: by 2002:a05:6638:1401:: with SMTP id k1mr2951230jad.58.1631195344070;
 Thu, 09 Sep 2021 06:49:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:b553:0:0:0:0:0 with HTTP; Thu, 9 Sep 2021 06:49:03 -0700 (PDT)
Reply-To: elizabeth.m2w@gmail.com
In-Reply-To: <CAGCa2iJ+2-x0BvF7=rUtQQbr2w0eaU+TopZCczmKMnMdUg7K0A@mail.gmail.com>
References: <CAGCa2iJ+2-x0BvF7=rUtQQbr2w0eaU+TopZCczmKMnMdUg7K0A@mail.gmail.com>
From:   JENET ADARA <judge.udo.ako@gmail.com>
Date:   Thu, 9 Sep 2021 15:49:03 +0200
Message-ID: <CAGCa2i+v_TZnyFeO9bOokDRx9nbt8rXufj9EGQALXrHUX2kf6Q@mail.gmail.com>
Subject: Fwd:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: JENET ADARA <judge.udo.ako@gmail.com>
Date: Thu, 9 Sep 2021 15:48:31 +0200
Subject:
To: judge.udo.ako@gmail.com

HELLO, DID YOU RECEIVE MY MAIL?
