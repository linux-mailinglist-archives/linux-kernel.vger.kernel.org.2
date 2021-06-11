Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16E3A42DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhFKNR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:17:28 -0400
Received: from mail-vk1-f181.google.com ([209.85.221.181]:39932 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhFKNR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:17:26 -0400
Received: by mail-vk1-f181.google.com with SMTP id k189so2502641vkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4p7Da6Bo96meqCCmYg1il+szOZMpXmVP32ev1MWjqw=;
        b=Ot4WYiEYRIGG3AWEh0UfJ0VBCs67SEfKPGht+bHJknT5g7pwYlgHwxQOciIHRzx08m
         hIt7/+kXeW2MYUANeixNF4W5KD5kfebehNQo/rfBst3oCwi3WSyG6RpK1tOaGaf/tEsw
         ZAWXWpBc4AkEFVwaWWEK6gFWoOOSKw571BVes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4p7Da6Bo96meqCCmYg1il+szOZMpXmVP32ev1MWjqw=;
        b=C/lwwvlgbstj8Ti/YEBD0jmLu25ApBn4sQ3OjGz8nK8/nxCZRK3Ycdtg06VPilbZPn
         /uzKROt9TvrpevtHu4VyE56IMVolAiiYYp/RT7koIbdchq/u1EQ8FGdNn/39KPJnaugL
         cOYvv7LgSkqcOEOiH0tSFUkGmzzcnI2pRCvd3AxpY2Xax90N5Fjvw4FVngoWvrEJme89
         wqeNC9wk30K6W/qsIv3GxYJ2O4Addyc3SPC4MqS5D4KUFm0k4TCViEMAEhh9td6svZHu
         bam2X52PHPXThseARHK+SwiQzqCbNWHcxlWVdtnCINHh2BeRcMmqgnYaJVrTZurN84Er
         7HXg==
X-Gm-Message-State: AOAM53263RngDtzSVueWtLqI1NJd27pV5PqTTPHXbqM28F24bOZoSn7r
        HYj3aQjyN3PdoFYifQstSt5b+mynF0NJ7IUMhcQ+3g==
X-Google-Smtp-Source: ABdhPJykpGz+EVt6yKODI9QwMAUVsXqDJL2V4qGkSQk27RFpMDRg7Bxel51dVr3TK8CqlFwAjV275wHFlPReYTBQ0Cg=
X-Received: by 2002:ac5:c9b5:: with SMTP id f21mr8183303vkm.23.1623417268493;
 Fri, 11 Jun 2021 06:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322874509.361452.3143376113190093370.stgit@web.messagingengine.com>
In-Reply-To: <162322874509.361452.3143376113190093370.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 15:14:17 +0200
Message-ID: <CAJfpegtCfgpZ7UpOf+-1qCijWTEvPtCEEPLwd1n4LWeqEraTAg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] kernfs: dont call d_splice_alias() under kernfs
 node lock
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 10:52, Ian Kent <raven@themaw.net> wrote:
>
> The call to d_splice_alias() in kernfs_iop_lookup() doesn't depend on
> any kernfs node so there's no reason to hold the kernfs node lock when
> calling it.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
