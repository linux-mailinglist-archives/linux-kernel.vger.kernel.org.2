Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119DD443152
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhKBPP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbhKBPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:15:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8DC06120A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 08:12:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l13so43636706lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/P+JlVQhPdjKm5XVeacoTH/sKiOZvU19Ao66NpLjpI=;
        b=aD7qi2PqWnlK63AXdBGNS1hr7R1FH79qcGi3MHxWRuL0rLfjXUaQ2cjMSyVz2Nfc3+
         ubgN2WgYfaUo112pMoj/Yhwev7VaVn219E6uZBZZIiZ6fiPLpryHgwhOrbWjM7KGnJ2x
         2mXiIG7EipPN7vw/m9BA3RzmCPi/y3xvJm5/9URsL3dRY2EHtw+WppaQrrHaSYsOR5W4
         46Kr6/q2GuVRu8RUnQ/bz3IIJWPE3ddy1zU3vN0mzORcb/DX9eY7qUlpLAGyPLymI7zU
         M3Bh0YSxiggp+lWL+tdEhmYAMPGtSfMXW8P09HvZvkU7UT9CTzXWzvX26djzsfohVxyl
         3a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/P+JlVQhPdjKm5XVeacoTH/sKiOZvU19Ao66NpLjpI=;
        b=TvRxPOqFYcOU0iIC295kx/VQXlWME8qFQGQAbRU3+IKbtJdYePRgFWx0kIiFsE3Z0a
         OX1UfIqHgx36Abz1/M49z+zuqf2a6ToD3kHyMecvc6HEimXb+tukLO1xHa9ifFHdNRXT
         1bz/PCjFfOlC7uhH/nNS6Z7TAOcN4ZydR3SNvpSL4yMr0vgAbeUfE976Cn6ALyHK/G4a
         uhwmHnoEyueQBU7H5zMoZDmJdPPoPMJxkd+UIYpGbygIKebSWKuZyChNay8AobjOX4FY
         oFUNvGhKkfyMMHeQc4M0QDtltRS3vfSaolpThVHP66SmcFuAuwu5RduQIK7s7KoG939k
         pWTQ==
X-Gm-Message-State: AOAM533Byc1zjTXaOR2pgBVre3NfqP/PeW+BxMeRunk3JQteef4d1e8h
        NKLIDcPxqNfD1WysurUcruXs9SpD/8+Jo3fY9Pvr3A==
X-Google-Smtp-Source: ABdhPJwW3bbYBMow+BLOQ6Z3kkTuneCZ+XClKxxTiKeWebydUO7lU3aFBAnfGW9IxwVbPNEWk0MGovuLAA7JuapWzkg=
X-Received: by 2002:a05:6512:1286:: with SMTP id u6mr30858097lfs.226.1635865966770;
 Tue, 02 Nov 2021 08:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211015233811.3532235-1-tkjos@google.com> <20211102132336.GG2794@kadam>
In-Reply-To: <20211102132336.GG2794@kadam>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 2 Nov 2021 08:12:35 -0700
Message-ID: <CAHRSSEwz-J57rz3n7-fnzK6gyY66WmvuG6BT6XdG6jZB668CWw@mail.gmail.com>
Subject: Re: [PATCH] binder: don't detect sender/target during buffer cleanup
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        jannh@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 6:24 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Oct 15, 2021 at 04:38:11PM -0700, Todd Kjos wrote:
> > When freeing txn buffers, binder_transaction_buffer_release()
> > attempts to detect whether the current context is the target by
> > comparing current->group_leader to proc->tsk. This is an unreliable
> > test. Instead explicitly pass an 'is_failure' boolean.
> >
> > Detecting the sender was being used as a way to tell if the
> > transaction failed to be sent.  When cleaning up after
> > failing to send a transaction, there is no need to close
> > the fds associated with a BINDER_TYPE_FDA object. Now
> > 'is_failure' can be used to accurately detect this case.
> >
>
> It's really hard for me to understand what this bug looks like to the
> user?  Is it a memory leak or do we free the wrong thing?

It is a difficult case to hit (impossible for "well-behaved"
processes), but it could result in file descriptors being closed when
they shouldn't be.

>
> regards,
> dan carpenter
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
