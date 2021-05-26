Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7003919E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhEZOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234432AbhEZOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622038804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tw3kDFX/e5vI26qc+xYDQKOURNEBK6wDgxbcgNjQMwo=;
        b=IpL0I0DLDAw+nq6A8djgn+5eJ1TGiYkfqBitPWKLT45ecM2b7qJ8m4nkZu6kGDHC7nZS+X
        p2efP45/IGRkwKXL7y9mGZ3sT9NS/N5cGs2sWWgjwQ6WZZbJEl9d+wZmh6b1XVBZVBzBFN
        eFtx1LVXiEvsB/T6ZFpGvzGTj4DiIao=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-x7me7J06OY2Kb2aP4no8gw-1; Wed, 26 May 2021 10:20:01 -0400
X-MC-Unique: x7me7J06OY2Kb2aP4no8gw-1
Received: by mail-il1-f200.google.com with SMTP id p6-20020a92d6860000b02901bb4be9e3c1so885628iln.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tw3kDFX/e5vI26qc+xYDQKOURNEBK6wDgxbcgNjQMwo=;
        b=KblmHuuTz1s3601CD08KVu4pGALXQMRqBZnHperwwAJE5FwqOeyCj868V5v9EyMSc4
         /OIJ4I8WWG0mqCXcB0nMbh4qhswVn/O+OVEaDPMomOQkLgszqPmPzzwnlWYK85CErsYS
         1fQ69d+ORA1wrpDK+zbcS+XnBKQtkZdMDOA8ZjgyNUiOyNTDmuTSvH2321BofiqbvIMY
         YNHlUq3M2aMsMjkZ7BcSm1yeMR8xiuAshBdIkl3GxNu3IxCcfdNSLFq2/RJuB+3ZYby+
         haUCYbXlTNatRHHjATroFxN/H8kAhARE7WtprUlI7ZMnKm0xS+V1noz7Ifyq4GjqF5fg
         EMNw==
X-Gm-Message-State: AOAM5324ZNr/6ewHmYVEVYP+xZ5grO39YTATBCE6VzKOmWzufR9ADU6x
        MFqFZvvkKMVoaJzZiw5GPOaD7xk9ILLazhVfCPodzuDqmyy8+aITLoyWvmbKUTWA9EHGlFdbE25
        8q2jZjm2kNbjonsDSmlFHtwJheEnLuT9tgDRxmbo+
X-Received: by 2002:a6b:8b58:: with SMTP id n85mr25868917iod.196.1622038801214;
        Wed, 26 May 2021 07:20:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6/xvJNSWX0KtrZyJUfd0teZL7cTFZvv9eEhh/QHbQfAh7gs/CemXpahHhE+Ltl8yqoScZYBgb4bH1K8GexEw=
X-Received: by 2002:a6b:8b58:: with SMTP id n85mr25868903iod.196.1622038801001;
 Wed, 26 May 2021 07:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210526134039.3448305-1-colin.king@canonical.com>
In-Reply-To: <20210526134039.3448305-1-colin.king@canonical.com>
From:   Alexander Ahring Oder Aring <aahringo@redhat.com>
Date:   Wed, 26 May 2021 10:19:49 -0400
Message-ID: <CAK-6q+jXZ2MGUw3QPKHwoNDMLdTookO7rq9LpGNx=ZGAn1pqOQ@mail.gmail.com>
Subject: Re: [PATCH][next] fs: dlm: Fix memory leak of object mh
To:     Colin King <colin.king@canonical.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 26, 2021 at 9:40 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is an error return path that is not kfree'ing mh after
> it has been successfully allocates.  Fix this by free'ing it.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: a070a91cf140 ("fs: dlm: add more midcomms hooks")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/dlm/rcom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
> index 085f21966c72..19298edc1573 100644
> --- a/fs/dlm/rcom.c
> +++ b/fs/dlm/rcom.c
> @@ -393,6 +393,7 @@ static void receive_rcom_lookup(struct dlm_ls *ls, struct dlm_rcom *rc_in)
>         if (rc_in->rc_id == 0xFFFFFFFF) {
>                 log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
>                 dlm_dump_rsb_name(ls, rc_in->rc_buf, len);
> +               kfree(mh);
>                 return;

This seems to be a bigger issue, we cannot revert the buffer
allocation with a kfree, we cannot revert it at all. We should avoid
any error handling between create_rcom() and send_rcom(). In general
between get_buffer/commit_buffer.

I don't see a problem with moving the error handling before
create_rcom(). That should fix the issue.

- Alex

