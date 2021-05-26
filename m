Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3F391FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhEZSwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233416AbhEZSwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622055043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8U8l4dAq7fCVZLWXnTICF3fjtWAoL6xPRh5BeEIsGo=;
        b=KGGVhNuDpGN9uUoZr5w2014IaxcZBiR9rGv73b43NvTlC6+45mM0LbVXCLhXjN0IqMX15r
        /UttM5frgytZT9QEZSx7A4s5j0Fc9eS1MFsJcNGLTN0zm+XxFR8HpiOS1b1gh5F/g56juY
        /aJqS7kOxJ2Q3sjarh6SVryow46/DJA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-RlPJoEMdOR2e_8PWwz5pKw-1; Wed, 26 May 2021 14:50:41 -0400
X-MC-Unique: RlPJoEMdOR2e_8PWwz5pKw-1
Received: by mail-il1-f199.google.com with SMTP id 15-20020a920d0f0000b02901c54acae19eso1465183iln.23
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 11:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8U8l4dAq7fCVZLWXnTICF3fjtWAoL6xPRh5BeEIsGo=;
        b=mQUgXAMRxWtuRC9w4gy1J9QcEeHzuOAyYG+obPsGq1aAB6MtE1oUjltxsCx2OTZfME
         GgdWL5YeNmhea672FZO7uw+hqWCoSLdIGvW1RXcf2AhOBaZSYFjAZCWJ5pxxhCXHrRS5
         J/aDO8ZIZ56p60xSx841W+G7Q+AtmyNtQDVbbHNsXd/rk5Kfer6+v+h5D/25ycEHqT+e
         70VefWg8kf0LgJvrq1otvLi93PRCUdoE8kX/HmttBFs1o+ky0nkF3/twuDxaegIehhmJ
         LSHzVjtdswuycpnmV3eHSxgJ5EbWAvPibvWS83YphlotiRvSvZXYoYjjhAtnSbtfX/rs
         GTIQ==
X-Gm-Message-State: AOAM53189q35DXaeFgV11CXYIASWXQqSTTWFEH3pv9Cp6hNfWjVkRoYS
        NeBE8+YIJ5YgOgXbBDhF2gOKSEVw+rjyfHIopnbNUFstTu+u/Ybjhlr8UVD2U/dkUcWycFm86om
        fhPw/fbCoCdNygeLpBtY7oOGwwjBUOFoT8JrUZYCg
X-Received: by 2002:a05:6e02:1d0b:: with SMTP id i11mr24946564ila.36.1622055040508;
        Wed, 26 May 2021 11:50:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWdlVDqsrj0ZiVQfex/txYF3LhvArUsKLowNWV1GDQ0d8wQTy5HNq7BAr2OOhHvfOXOCPKSvDLYFtZMpnAVLk=
X-Received: by 2002:a05:6e02:1d0b:: with SMTP id i11mr24946549ila.36.1622055040300;
 Wed, 26 May 2021 11:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210526134039.3448305-1-colin.king@canonical.com>
 <20210526150133.GQ1955@kadam> <c5ea0085-969a-339f-fd92-6724cb1d928e@canonical.com>
 <20210526181726.GJ24442@kadam>
In-Reply-To: <20210526181726.GJ24442@kadam>
From:   Alexander Ahring Oder Aring <aahringo@redhat.com>
Date:   Wed, 26 May 2021 14:50:29 -0400
Message-ID: <CAK-6q+jEfu_bHYgHZJTase3fe9Y_mYmkKzfjEPjZw5g_PRRz8Q@mail.gmail.com>
Subject: Re: [PATCH][next] fs: dlm: Fix memory leak of object mh
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 26, 2021 at 2:24 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, May 26, 2021 at 04:11:06PM +0100, Colin Ian King wrote:
> > On 26/05/2021 16:01, Dan Carpenter wrote:
> > > On Wed, May 26, 2021 at 02:40:39PM +0100, Colin King wrote:
> > >> From: Colin Ian King <colin.king@canonical.com>
> > >>
> > >> There is an error return path that is not kfree'ing mh after
> > >> it has been successfully allocates.  Fix this by free'ing it.
> > >>
> > >> Addresses-Coverity: ("Resource leak")
> > >> Fixes: a070a91cf140 ("fs: dlm: add more midcomms hooks")
> > >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > >> ---
> > >>  fs/dlm/rcom.c | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
> > >> index 085f21966c72..19298edc1573 100644
> > >> --- a/fs/dlm/rcom.c
> > >> +++ b/fs/dlm/rcom.c
> > >> @@ -393,6 +393,7 @@ static void receive_rcom_lookup(struct dlm_ls *ls, struct dlm_rcom *rc_in)
> > >>    if (rc_in->rc_id == 0xFFFFFFFF) {
> > >>            log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
> > >>            dlm_dump_rsb_name(ls, rc_in->rc_buf, len);
> > >> +          kfree(mh);
> > >
> > > Am I looking at the same code as you?  (I often am not able to review
> > > your patches because you're doing development on stuff that hasn't hit
> > > linux-next).  Anyway, to me this doesn't seem like the correct fix at
> > > all.  There are some other things to free and the "mh" pointer is on
> > > a bunch of lists so it leads to use after frees.
>       ^^^^^^^^^^^^^^
> This is sort of impossible, of course, because the struct only has one
> list_head so it can only be in one list and not a "bunch of lists".
>

It is a bunch of lists because mh_handle holds pointers with ref
counters to other structures which are part of lists. :) There is a
list_del() only if hits zero.

> The dlm code seems to be going out of its way to use void pointers and
> that makes it difficult to parse with Smatch.
>

That has been changed on dlm/next. There exists a struct mh_handle *
and a dlm_msg * to get rid of void * handles.

> But in other subsystems, we could make it a rule that list_heads are
> "poison" "init" or "added".  If you freed a memory with an "added"
> list_head then print a warning.  Or if you added a list_head but it was
> already in the added state then print a warning.  Another idea is that
> if you freed a struct mh before the mh->page allocation was freed then
> print a warning about the leak.  This one is probably more prone to
> false positives but there might be workarounds for those.  #IdeasToImplement
>

Currently if a buffer is allocated it is not possible to free it
again. The allocated buffer of the page will be transmitted
(kernel_sendpage()) out in a contiguous way. If somebody wants to
release memory the page buffer needs to be reordered and it can only
be done before commit().

- Alex

