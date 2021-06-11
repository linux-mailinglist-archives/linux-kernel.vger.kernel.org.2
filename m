Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC16A3A424F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhFKMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:49:05 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:44892 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFKMtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:49:03 -0400
Received: by mail-ua1-f50.google.com with SMTP id 68so2516108uao.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 05:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjHrb1dtK2G/VbmUcqAkZXLppuMhMD3yMja93ulZGQA=;
        b=TDYoRaMYnwSoHRfHhL8DdQgmyyazxTWd+5D9U6VCh6/4Cqe+HB+jQIwNMTGVAepTi/
         EG8SMJmsDCwnfL7FNv9ubkMR7fxAyaiyOaUuzrCpG6AQ0ECcse3JAlaW1CpYbpIgrCqL
         kXP81kGnaSZ+bsP/LfqD63ZHfNlQLgSxrUIg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjHrb1dtK2G/VbmUcqAkZXLppuMhMD3yMja93ulZGQA=;
        b=H0OcdMam1XuQJH7/pJ+LxQ3JWktL5iQOFJDhWYXh4bJDt8A5Ny81BE3QT2D7MOoQkI
         YDlheCRzARILOfLZ+2Zi7MJCRdEyweDCh6pxDMLsA6sFxCkAAgLeft2Wtwpb27pJjx9W
         McUf3JhItyJc+Mkjn0RAN5cy3gu96VFDVJTkn/DOU545b0c0QNrVhCrJxyToy10xMZ1t
         adJ4ddut4XyNbNbakShNBpzxufIP65H+LKeACfMbKRri6XsRS/CHQLMQEIiGoDkAEj7w
         EzcSC4381h/lBSqE69bfZ2rsVc184TWLOv+zIz9swz053mAxrQtwqmlzk68euR+r2gwd
         owug==
X-Gm-Message-State: AOAM530sEE/WNaqBOEotpGF7af5TYYDkZNHfKwNhMsdKiAkYhwMMO13f
        BDDrmdIPSumitXE8/muL1/3gwBSquA1dRVXlf2lWfQ==
X-Google-Smtp-Source: ABdhPJxsTaNkmd6IAo6MBi8zrtu0rXXBlRV5F5kC0pToscPzFB5ElGS3yZW1yf0MnsJxWIjkZkCPso9bS6w7O+CpmE8=
X-Received: by 2002:ab0:3418:: with SMTP id z24mr2723800uap.11.1623415565376;
 Fri, 11 Jun 2021 05:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322857790.361452.16044356399148573870.stgit@web.messagingengine.com>
In-Reply-To: <162322857790.361452.16044356399148573870.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Jun 2021 14:45:54 +0200
Message-ID: <CAJfpegvsi7CjdGORphOZTHg_fEdwidszhyKT94CRQJ3bYLogBQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] kernfs: move revalidate to be near lookup
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

On Wed, 9 Jun 2021 at 10:49, Ian Kent <raven@themaw.net> wrote:
>
> While the dentry operation kernfs_dop_revalidate() is grouped with
> dentry type functions it also has a strong affinity to the inode
> operation ->lookup().
>
> It makes sense to locate this function near to kernfs_iop_lookup()
> because we will be adding VFS negative dentry caching to reduce path
> lookup overhead for non-existent paths.
>
> There's no functional change from this patch.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
