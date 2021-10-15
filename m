Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887B642E57D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhJOAx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhJOAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:53:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF0BC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:51:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t16so31152724eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcRK/FMVq0d7lZR4RgJDlpzm/0Nvfg5lOqEnDV14pGI=;
        b=HML4pD7AnS2Vr6k1owyyANHoletVzaGLhW97xCsJ5G3v9Wcm1tNIRMIsPjILEAjWlI
         +mZTYKkzN9IK/swYK3PiuYyQUigHN1ZNAAtr6FdDp49PIRmqN2euUNXvHrE4i1BJjLGx
         GqmGMCXg/KaXwLRn7WyQGBYbo2ngUpngQtP+Oaj1uAKz5PuqGJ8wBILJ0wzSHAMNH3cq
         +cKmvTz1eHfameLcaMU3ke95r/iPrbUWXIM8jy1KN6ixYtwcp9HjIqGyk/2Gi7nBo/13
         9oycwknqH06imOZDYRGABe8BDK79p81Kv7ZFw6IlfPleRh6V8qJ0WfLiqNq+BffhG4dh
         zrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcRK/FMVq0d7lZR4RgJDlpzm/0Nvfg5lOqEnDV14pGI=;
        b=O/nuN9EmvQHQNWr2WbB25F5OL98MbF9ny0v0pcD6xaEiJYcf4Qr6zr+oEPWxTPGTlU
         kiAe/bvsMvx4noeZfdwTJl/43D0zGIinBYAAlPQaHXK3A5zi9GkJO1/ZSZGwerOFR8s9
         9BasZUIZqQS5Ms174Ypb9D8MG+F4bG8QwrEhKNssahoviXYVVHo1HZdCS71FarSsKLil
         hZNfCkUV90CNTt5PDTfTl7K3YODoiM1Klpo1OO02mHCzKSJyeg2gOljcOa2hp32Xo827
         57HCvrf+obXULm31khB3fTiQ7+yMtiYdQblj7CDClqccMHOcJrti3G9/ASsdFqo86L7l
         /ugw==
X-Gm-Message-State: AOAM530MN2u7Zm1IxTZbhne0gIkEjL8lwVfGEDn1F4aqzJdHkzJ1H0sJ
        idRUsqPE0a88UWPCXANf1Dt4RuFOq1BD0W/PC2SFKJM58Q==
X-Google-Smtp-Source: ABdhPJyN18BWWGLLUDpiphSW+3Z/VIWJ/mmcSvKDvqZF8BKKyiTackXdTeu9WpZbjK7c0Y4Ro+yX/INJU8pwDjqLXuE=
X-Received: by 2002:a17:906:3d22:: with SMTP id l2mr3016297ejf.187.1634259109991;
 Thu, 14 Oct 2021 17:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211015095327.42344a21@canb.auug.org.au> <CAHRSSEwR9c1jV_Hy6DbH9aZ5Q02AeR_dkay9W9od0RpiYKdgLg@mail.gmail.com>
In-Reply-To: <CAHRSSEwR9c1jV_Hy6DbH9aZ5Q02AeR_dkay9W9od0RpiYKdgLg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Oct 2021 20:51:38 -0400
Message-ID: <CAHC9VhSsFzMxBdJHYOgq4X-PwQWLX2+UP5_T_U38mYd1_BeSHw@mail.gmail.com>
Subject: Re: linux-next: Fixes tags needs some work in the selinux tree
To:     Todd Kjos <tkjos@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 8:21 PM Todd Kjos <tkjos@google.com> wrote:
> On Thu, Oct 14, 2021 at 3:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > In commit
> >
> >   fef994d85ac9 ("binder: use cred instead of task for getsecid")
> >
> > Fixes tag
> >
> >   Fixes: ec74136ded79 ("binder: create node flag to request sender's
> >
> > has these problem(s):
> >
> >   - Subject has leading but no trailing parentheses
> >   - Subject has leading but no trailing quotes
> >
> > In commit
> >
> >   d1c927fb8b52 ("binder: use cred instead of task for selinux checks")
> >
> > Fixes tag
> >
> >   Fixes: 79af73079d75 ("Add security hooks to binder and implement the
> >
> > has these problem(s):
> >
> >   - Subject has leading but no trailing parentheses
> >   - Subject has leading but no trailing quotes
> >
> > Please do not split Fixes tags over more than one line.

Thanks Stephen, my apologies for not catching this during the merge.

> Stephen / Paul - do you want me to upload a new series for this or is
> this something you would normally do since it is a simple change?

I fixed it up and did a force push to selinux/next, it should be taken
care of now.

-- 
paul moore
www.paul-moore.com
