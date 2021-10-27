Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99C43D0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhJ0SjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbhJ0SjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:39:20 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CEEC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:36:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 205so6223639ljf.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA/KGY3jUxUtYWT2WGNI33Dl6A0vyDSF7oCZ6oQZ9Os=;
        b=fMxfuniLnTqucFG0YhxpsugZFF/eJGNK4ZbX4LY9fEmRxdrJbT5w9lcfOs7LN+GXYf
         Hsx6bj8CmeNqESGg6NbYAimJq36WEV/JIaMRB2Ckqs2ytl39CZvDv9m2AJKRIituY0lp
         BDPRE/K5+XlaNuf+SAkqOwHQc8/5O11g4fTLVvllUF81QMfItFbrRb9AQGv5BZUTs73k
         F1hYAQs9FhR88FWOY7IAQo3YmuIHw+w1HJ55DpUdmQrKuF5Z+1iCO8UPDc0KMSl0IJ7l
         PDXENdnLnYQzqGxeLyKbfrQShwbEWbcVnGtviIgv68LasTuItoDmHgwTxwck5gg06Fc5
         crjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA/KGY3jUxUtYWT2WGNI33Dl6A0vyDSF7oCZ6oQZ9Os=;
        b=2LXZH/A+BnRRRv5AqXAo15Q/RMAjqXxTUxckSYTOOtnbStJqcsmCIBkeWs5ahG6yvH
         MQMZyPKs558daOeZp60ICGILWNoe+Z6OFYPfEXMq60Jgn3ezxWfepWxgVR0UlYsjyqza
         jbeAnlpYqUc9jbucBh+2jCh1UWl1opqXx/tfctzaz7KSEVXzxKXXM9ik8I2D164C4Qlw
         KFpV/He3tmzkhxQZRkPLNerfLQhb++qdqv/Kz2N7tfWddB5Ys4sRLwpnvhXbvWdNJCTf
         MwNaMWlTsCgD760qsSgUo47Z1QCEIootVZSowEBhXrkfq5/kygW1WW6rcmyb9O8tzwWp
         rlCw==
X-Gm-Message-State: AOAM533xluASJI9Tk1rqgcsqqKv/6DBACO4uyXj1YJeBU3brpZODlZJQ
        QcsnR8UCBfkf+HFaLVWPzELvdL68uerC5QrQ/sk=
X-Google-Smtp-Source: ABdhPJz6z1AB2KkYkrn9DQFR11S9FAusCTB03d1ao1978U2t3UfKq0TIyj9mlJaVtpofCkNSyVTvTJkmUblgZk6NAL4=
X-Received: by 2002:a2e:960c:: with SMTP id v12mr34402683ljh.344.1635359812899;
 Wed, 27 Oct 2021 11:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211014190503.717830-1-daeho43@gmail.com> <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
 <CACOAw_yupuz+Xx-z9V0UaExuARHd8H9rruWCa2yj5-mgkeuUtQ@mail.gmail.com>
 <3ddb4013-8d63-7c00-6fdd-1f21752bd60c@kernel.org> <CACOAw_wjhr8j=-qEDHP_H+_7cTh_ep7Wix4=JC+5x5zp-zpUFA@mail.gmail.com>
 <c93106ef-b567-b973-7241-ea2fcef84855@kernel.org> <CACOAw_xOOcoTCYnxtSq9Sqn0aUvt=F_6UgUwWeh9RkS5Oj-RDg@mail.gmail.com>
In-Reply-To: <CACOAw_xOOcoTCYnxtSq9Sqn0aUvt=F_6UgUwWeh9RkS5Oj-RDg@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 27 Oct 2021 11:36:41 -0700
Message-ID: <CACOAw_xunxNZz9zNHOJgLzWsGRnKHvpum5+kkizrx8pKCtgqaw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove circular locking between
 sb_internal and fs_reclaim
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:56 AM Daeho Jeong <daeho43@gmail.com> wrote:
>
> > Yes, I doubt the problem may also happen in f2fs_evict_inode() with below
> > callpath:
> >
> > - evict_inode
> >   - dquot_initialize failed
> >   - sb_start_intwrite
> >   - f2fs_truncate
> >    - dquot_initialize lock dqio_sem
> >
> > How about this?
> >
>
> Got it~
> Then we need this in both f2fs_evict_inode() and f2fs_drop_inode().
>

It turns out this deadlock issue was related to the Android kernel only. :(
That was related to one of Android tracepoints, which triggered
internal memory reclaim inside of it.
We made a workaround for that in Android kernel.

Thanks,
